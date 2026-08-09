unit uInstanciaUnica;

{
  Controle de instancia unica do Louvor JA.

  O programa usa um unico arquivo SQLite (config\database.db), um unico arquivo
  de configuracao em %APPDATA%\LouvorJA e uma porta fixa no servidor de
  transmissao. Duas copias abertas ao mesmo tempo disputam esses recursos e o
  sintoma mais comum e o erro "database is locked".

  Aqui um mutex nomeado marca que o programa ja esta rodando. A segunda copia
  avisa o usuario, pede para a janela ja aberta vir para frente e encerra.

  O nome do mutex inclui a pasta de configuracao, entao o parametro de linha de
  comando dir_config continua permitindo rodar instancias realmente separadas,
  cada uma com seu proprio banco.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Forms;

var
  //Mensagem registrada no Windows: pede para a instancia ja aberta vir para frente
  WM_LOUVORJA_RESTAURA: UINT = 0;

  //Avisa a janela principal que chegou um arquivo de outra instancia. E postada
  //para si mesma: abrir o arquivo dentro do WM_COPYDATA travaria quem enviou.
  WM_LOUVORJA_ABRE_ARQUIVO: UINT = 0;

//Retorna False quando ja existe outra instancia; nesse caso o programa nao deve iniciar
function IniciaInstanciaUnica: Boolean;

//Reserva o lugar da instancia. False quando outra copia ja esta rodando
function ReservaInstancia: Boolean;

//Avisa o usuario e pede para a instancia ja aberta vir para frente
procedure AvisaJaAberto;

//Libera o mutex. Precisa ser chamada antes de relancar o executavel (reinicio do programa)
procedure LiberaInstanciaUnica;

//Identifica a instancia pela pasta de configuracao, para nao ativar uma copia de outra pasta
function IdInstanciaUnica: Cardinal;

//Traz a janela para frente, preservando o estado maximizado
procedure TrazJanelaParaFrente(Form: TForm);

//Entrega um arquivo para a instancia ja aberta. False quando nao ha para quem
//entregar (a janela principal ainda nao existe, por exemplo)
function EnviaArquivoParaInstancia(const arq: string): Boolean;

implementation

{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}

const
  ASFW_ANY = DWORD(-1);

  //Nao esta declarado na Winapi.Windows desta versao do Delphi
  PROCESS_QUERY_LIMITED_INFORMATION = $1000;

function AllowSetForegroundWindow(dwProcessId: DWORD): BOOL; stdcall;
  external 'user32.dll' name 'AllowSetForegroundWindow';

function QueryFullProcessImageName(hProcess: THandle; dwFlags: DWORD;
  lpExeName: PChar; var lpdwSize: DWORD): BOOL; stdcall;
  external 'kernel32.dll' name 'QueryFullProcessImageNameW';

var
  FMutex: THandle = 0;
  FId: Cardinal = 0;
  FLang: TStringList = nil;

//Repete a regra de fmIniciando: parametros vem de paramstr(2) separados por ";"
function PastaConfig: string;
var
  params: TStringList;
  sub: string;
begin
  sub := '';

  params := TStringList.Create;
  try
    params.Text := StringReplace(ParamStr(2), ';', sLineBreak, [rfIgnoreCase, rfReplaceAll]);
    sub := Trim(params.Values['dir_config']);
  finally
    params.Free;
  end;

  if sub = '' then
    sub := 'config';

  Result := ExtractFilePath(ParamStr(0)) + sub + '\';
end;

//FNV-1a: reduz o caminho da pasta a um identificador curto para caber no nome do mutex
function Hash32(const txt: string): Cardinal;
var
  i: Integer;
begin
  Result := 2166136261;
  for i := 1 to Length(txt) do
  begin
    Result := Result xor Cardinal(Ord(txt[i]));
    Result := Result * 16777619;
  end;
end;

function IdInstanciaUnica: Cardinal;
begin
  if FId = 0 then
    FId := Hash32(LowerCase(PastaConfig));
  Result := FId;
end;

procedure CarregaLang;
var
  arq: string;
begin
  if Assigned(FLang) then
    Exit;

  FLang := TStringList.Create;

  arq := ExtractFilePath(ParamStr(0)) + '.translate';
  if FileExists(arq) then
  try
    FLang.LoadFromFile(arq);
  except
    FLang.Clear;
  end;
end;

//Mesma tabela de traducao usada por fIniciando.Translate
function Texto(const txt: string): string;
var
  tra: string;
begin
  Result := txt;

  CarregaLang;
  if Trim(FLang.Values['_']) = '' then
    Exit;

  tra := FLang.Values[txt];
  if Trim(tra) <> '' then
    Result := tra;
end;

function TituloPrograma: string;
begin
  CarregaLang;
  if Trim(FLang.Values['_']) = 'ES' then
    Result := 'Loor JA'
  else
    Result := 'Louvor JA';
end;

procedure TrazJanelaParaFrente(Form: TForm);
begin
  if not Assigned(Form) then
    Exit;

  //Ainda na tela de abertura: nao force a janela principal a aparecer antes da hora
  if not Form.Visible then
    Exit;

  if IsIconic(Form.Handle) then
    ShowWindow(Form.Handle, SW_RESTORE);

  SetForegroundWindow(Form.Handle);
end;

function ReservaInstancia: Boolean;
begin
  Result := True;

  FMutex := CreateMutex(nil, True, PChar('Local\LouvorJA_' + IntToHex(IdInstanciaUnica, 8)));

  //Se nao foi possivel criar o mutex, abre normalmente em vez de travar o programa
  if FMutex = 0 then
    Exit;

  if GetLastError <> ERROR_ALREADY_EXISTS then
    Exit;

  Result := False;

  CloseHandle(FMutex);
  FMutex := 0;
end;

//Pede para a instancia ja aberta aparecer na frente
procedure ChamaInstanciaAberta;
begin
  //Autoriza a outra instancia a roubar o foco antes de pedir que ela apareca
  AllowSetForegroundWindow(ASFW_ANY);
  PostMessage(HWND_BROADCAST, WM_LOUVORJA_RESTAURA, WPARAM(IdInstanciaUnica), 0);
end;

procedure AvisaJaAberto;
begin
  MessageBox(0, PChar(Texto('O Louvor JA já está aberto!')), PChar(TituloPrograma),
    MB_OK or MB_ICONINFORMATION or MB_SETFOREGROUND or MB_TOPMOST);

  ChamaInstanciaAberta;
end;

var
  FArquivo: string;
  FEntregue: Boolean;

//Caminho do executavel dono da janela. Serve para so falar com outra copia do
//proprio LouvorJA, sem depender do nome da classe da janela.
function ExeDaJanela(Wnd: HWND): string;
var
  pid: DWORD;
  proc: THandle;
  buf: array[0..MAX_PATH] of Char;
  tam: DWORD;
begin
  Result := '';

  pid := 0;
  GetWindowThreadProcessId(Wnd, @pid);
  if (pid = 0) or (pid = GetCurrentProcessId) then
    Exit;

  proc := OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, pid);
  if proc = 0 then
    Exit;
  try
    tam := Length(buf);
    if QueryFullProcessImageName(proc, 0, buf, tam) then
      SetString(Result, buf, tam);
  finally
    CloseHandle(proc);
  end;
end;

//Entrega o arquivo por WM_COPYDATA a uma janela de outra copia do programa.
//O identificador da instancia vai junto: uma copia rodando com outra pasta de
//configuracao ignora a mensagem.
function EnumeraJanelas(Wnd: HWND; Param: LPARAM): BOOL; stdcall;
var
  dados: TCopyDataStruct;
begin
  Result := True;

  if not SameText(ExeDaJanela(Wnd), ParamStr(0)) then
    Exit;

  dados.dwData := IdInstanciaUnica;
  dados.cbData := (Length(FArquivo) + 1) * SizeOf(Char);
  dados.lpData := PChar(FArquivo);

  if (SendMessage(Wnd, WM_COPYDATA, 0, LPARAM(@dados)) = 1) then
  begin
    FEntregue := True;
    Result := False; //achou quem recebesse: para a busca
  end;
end;

function EnviaArquivoParaInstancia(const arq: string): Boolean;
begin
  FArquivo := arq;
  FEntregue := False;

  AllowSetForegroundWindow(ASFW_ANY);
  EnumWindows(@EnumeraJanelas, 0);

  Result := FEntregue;
end;

function IniciaInstanciaUnica: Boolean;
var
  arq: string;
begin
  Result := ReservaInstancia;
  if Result then
    Exit;

  //Arquivo aberto pelo Windows com o programa ja rodando: entrega para a
  //instancia existente em vez de avisar que ja esta aberto
  arq := ParamStr(1);
  if FileExists(arq) and EnviaArquivoParaInstancia(arq) then
  begin
    ChamaInstanciaAberta;
    Exit;
  end;

  AvisaJaAberto;
end;

procedure LiberaInstanciaUnica;
begin
  if FMutex = 0 then
    Exit;

  ReleaseMutex(FMutex);
  CloseHandle(FMutex);
  FMutex := 0;
end;

initialization
  WM_LOUVORJA_RESTAURA     := RegisterWindowMessage('LouvorJA.RestauraInstancia');
  WM_LOUVORJA_ABRE_ARQUIVO := RegisterWindowMessage('LouvorJA.AbreArquivo');

finalization
  LiberaInstanciaUnica;
  FreeAndNil(FLang);

end.
