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

implementation

{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}

const
  ASFW_ANY = DWORD(-1);

function AllowSetForegroundWindow(dwProcessId: DWORD): BOOL; stdcall;
  external 'user32.dll' name 'AllowSetForegroundWindow';

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

procedure AvisaJaAberto;
begin
  MessageBox(0, PChar(Texto('O Louvor JA já está aberto!')), PChar(TituloPrograma),
    MB_OK or MB_ICONINFORMATION or MB_SETFOREGROUND or MB_TOPMOST);

  //Autoriza a outra instancia a roubar o foco antes de pedir que ela apareca
  AllowSetForegroundWindow(ASFW_ANY);
  PostMessage(HWND_BROADCAST, WM_LOUVORJA_RESTAURA, WPARAM(IdInstanciaUnica), 0);
end;

function IniciaInstanciaUnica: Boolean;
begin
  Result := ReservaInstancia;
  if not Result then
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
  WM_LOUVORJA_RESTAURA := RegisterWindowMessage('LouvorJA.RestauraInstancia');

finalization
  LiberaInstanciaUnica;
  FreeAndNil(FLang);

end.
