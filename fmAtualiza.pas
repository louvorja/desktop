unit fmAtualiza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdHTTP, StdCtrls, OleCtrls,
  ShellAPI, bsSkinCtrls,
  BusinessSkinForm, strutils, bsPngImageList,
  IdComponent, Data.DB, FireDAC.Comp.Client,
  Vcl.ComCtrls, IdBaseComponent, uArquivosWeb;

type
  TfAtualiza = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel1: TGridPanel;
    img1: TbsPngImageView;
    sTitulo: TbsSkinLabel;
    pbProgresso: TProgressBar;
    sProgresso: TbsSkinLabel;
    pbProgressoT: TProgressBar;
    sProgressoT: TbsSkinLabel;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinButton2: TbsSkinButton;
    tmrFecha: TTimer;
    sStatus: TbsSkinLabel;
    procedure FormActivate(Sender: TObject);
    procedure http_baixa();
    function bancoTemUrlDownload(const arquivo: string): Boolean;
    function urlParaCaminhoLocal(const caminhoLocal, base, urlBanco,
      idioma: string): string;
    function baixaArquivo(const url, destinoTemp: string): Boolean;
    procedure httpWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure httpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    temUrlDownload: Boolean;
  public
    { Public declarations }
    arquivos: TStringList;
    arquivos_falha: TStringList;
    cancela: Boolean;
    erro: Boolean;
  end;

var
  fAtualiza: TfAtualiza;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;

{$R *.dfm}

function TfAtualiza.urlParaCaminhoLocal(const caminhoLocal, base, urlBanco,
  idioma: string): string;
var
  local, remoto: string;
begin
  Result := '';

  local := trim(caminhoLocal);
  if (local = '') then
    Exit;

  if SameText(local, 'config\database.db') or
     SameText(local, 'config\' + idioma + '_database.db') then
  begin
    Result := trim(urlBanco);
    Exit;
  end;

  if (not temUrlDownload) or (not DM.qrARQUIVOS_SISTEMA.Active) then
    Exit;

  if not DM.qrARQUIVOS_SISTEMA.Locate('URL', local, [loCaseInsensitive]) then
    Exit;

  remoto := trim(DM.qrARQUIVOS_SISTEMA.FieldByName('URL_DOWNLOAD').AsString);
  if (remoto = '') then
    Exit;

  Result := urlDoArquivo(base, remoto);
end;

function TfAtualiza.bancoTemUrlDownload(const arquivo: string): Boolean;
var
  conexao: TFDConnection;
  consulta: TFDQuery;
begin
  Result := False;
  if not FileExists(arquivo) then
    Exit;

  conexao := TFDConnection.Create(nil);
  try
    conexao.DriverName := 'SQLite';
    conexao.Params.Values['Database'] := arquivo;
    conexao.Params.Values['OpenMode'] := 'ReadOnly';
    conexao.LoginPrompt := False;

    try
      conexao.Connected := True;

      consulta := TFDQuery.Create(nil);
      try
        consulta.Connection := conexao;
        consulta.SQL.Text := 'SELECT URL_DOWNLOAD FROM ARQUIVOS_SISTEMA LIMIT 1';
        consulta.Open;
        Result := True;
        consulta.Close;
      finally
        consulta.Free;
      end;

      conexao.Connected := False;
    except
      on E: Exception do
        fmIndex.gravaLog('Banco baixado sem a coluna URL_DOWNLOAD: ' + E.Message);
    end;
  finally
    conexao.Free;
  end;
end;

procedure TfAtualiza.http_baixa;
var
  i: Integer;
  base, urlBanco, lang, url, destino, temp, dir: string;
begin
  lang := LowerCase(fIniciando.LANG);
  base := trim(fmIndex.param.Strings.Values['https_files']);
  urlBanco := trim(fmIndex.param.Strings.Values['https_db_' + lang]);

  if (base = '') then
  begin
    Application.MessageBox(PChar('Não foi possível obter o endereço dos arquivos!'),
      fmIndex.TITULO, mb_ok + MB_ICONERROR);
    erro := True;
    tmrFecha.Enabled := True;
    Exit;
  end;

  for i := 0 to arquivos.Count - 1 do
  begin
    if cancela or tmrFecha.Enabled then
      Break;

    url := urlParaCaminhoLocal(arquivos[i], base, urlBanco, lang);
    if (url = '') then
    begin
      fmIndex.gravaLog('Sem endereço de download para: ' + arquivos[i]);
      arquivos_falha.Add(arquivos[i]);
      sStatus.Caption := 'Falha no download: ' + IntToStr(arquivos_falha.Count);
      Continue;
    end;

    fmIndex.gravaLog('Baixando: ' + url);

    sTitulo.Caption := 'Baixando arquivo ''' + ExtractFileName(arquivos[i]) + '''';
    sProgressoT.Caption := 'Arquivo ' + IntToStr(i + 1) + ' / ' + IntToStr(arquivos.Count);
    pbProgressoT.Max := arquivos.Count;
    pbProgressoT.Position := i + 1;
    pbProgresso.Position := 0;
    pbProgresso.Max := 0;
    pbProgresso.Style := pbstMarquee;
    sProgresso.Caption := '';
    Application.ProcessMessages;

    temp := fmIndex.dir_temp + 'arquivo_' +
      formatdatetime('yyyymmdd_hhnnsszzz', Now()) + '.~tmp';

    if baixaArquivo(url, temp) then
    begin
      if SameText(ExtractFileName(arquivos[i]), 'database.db') and
         (not bancoTemUrlDownload(temp)) then
      begin
        DeleteFile(temp);
        fmIndex.gravaLog('O banco baixado nao traz a coluna URL_DOWNLOAD');
        arquivos_falha.Add(arquivos[i]);
        sStatus.Caption := 'Falha no download: ' + IntToStr(arquivos_falha.Count);
        Continue;
      end;

      destino := ExtractFilePath(Application.ExeName) + arquivos[i];
      dir := ExtractFilePath(destino);
      if not DirectoryExists(dir) then
        ForceDirectories(dir);

      CopyFile(PChar(temp), PChar(destino), False);
      DeleteFile(temp);
    end
    else
    begin
      if FileExists(temp) then
        DeleteFile(temp);
      if not (cancela or tmrFecha.Enabled) then
      begin
        arquivos_falha.Add(arquivos[i]);
        sStatus.Caption := 'Falha no download: ' + IntToStr(arquivos_falha.Count);
      end;
    end;
  end;

  sTitulo.Caption := 'Finalizando...';
  pbProgressoT.Max := 1;
  pbProgressoT.Position := 1;
  tmrFecha.Enabled := True;
end;

function TfAtualiza.baixaArquivo(const url, destinoTemp: string): Boolean;
var
  tentativa: Integer;
  saida: TFileStream;
  workAnterior: TWorkEvent;
  workBeginAnterior: TWorkBeginEvent;
begin
  Result := False;

  workAnterior := DM.IdHTTP1.OnWork;
  workBeginAnterior := DM.IdHTTP1.OnWorkBegin;
  DM.IdHTTP1.OnWork := httpWork;
  DM.IdHTTP1.OnWorkBegin := httpWorkBegin;
  try
    for tentativa := 1 to 2 do
    begin
      if cancela or tmrFecha.Enabled then
        Exit;

      if (tentativa = 2) then
      begin
        sTitulo.Caption := 'Falha no download... Tentando novamente...';
        Application.ProcessMessages;
        Sleep(2000);
      end;

      try
        if FileExists(destinoTemp) then
          DeleteFile(destinoTemp);

        saida := TFileStream.Create(destinoTemp, fmCreate);
        try
          DM.IdHTTP1.Get(url, saida);
          Result := saida.Size > 0;
        finally
          saida.Free;
        end;

        if Result then
          Exit;
      except
        on E: Exception do
          fmIndex.gravaLog('Falha ao baixar ' + url + ': ' + E.Message);
      end;
    end;
  finally
    DM.IdHTTP1.OnWork := workAnterior;
    DM.IdHTTP1.OnWorkBegin := workBeginAnterior;
  end;
end;

procedure TfAtualiza.httpWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if (tmrFecha.Enabled) then Exit;

  pbProgresso.Position := 0;
  pbProgresso.Max := AWorkCountMax;
  if (pbProgresso.Max > 0) then
    pbProgresso.Style := pbstNormal
  else
    pbProgresso.Style := pbstMarquee;
end;

procedure TfAtualiza.httpWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if (tmrFecha.Enabled) then Exit;

  if (pbProgresso.Max > 0) then
  begin
    pbProgresso.Position := AWorkCount;
    sProgresso.Caption := IntToStr(AWorkCount div 1024) + ' KB / ' +
      IntToStr(pbProgresso.Max div 1024) + ' KB';
  end
  else
    sProgresso.Caption := IntToStr(AWorkCount div 1024) + ' KB';
end;

procedure TfAtualiza.tmrFechaTimer(Sender: TObject);
begin
  fAtualiza.close;
end;

procedure TfAtualiza.bsSkinButton2Click(Sender: TObject);
begin
  cancela := True;
  try
    tmrFecha.Enabled := true;
  except
    //
  end;
  pbProgresso.Position := 0;
  pbProgressoT.Position := 0;
end;

procedure TfAtualiza.FormActivate(Sender: TObject);
var
  LinkPag, txt: string;
begin
  cancela := False;
  erro := False;
//  if DM.tmrSair.Enabled = true then Exit;

  tmrFecha.Enabled := False;
  arquivos_falha := TStringList.Create;
  sStatus.Caption := '';

  fmIndex.gravaLog('Buscando parametros');

  sTitulo.Caption := 'Buscando informações...';
  pbProgresso.Style := pbstMarquee;

  fmIndex.gravaLog('URL: '+fmIndex.url_params);

  DM.IdHTTP1.Request.CustomHeaders.Values['Api-Token'] := fmIndex.api_token;
  try
    LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
  except
    Sleep(2000);
    try
      LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
    except
      Application.MessageBox(PChar('Não foi possível se conectar!'),fmIndex.TITULO,mb_ok+MB_ICONERROR);
      tmrFecha.Enabled := True;
      erro := True;
      Exit;
    end;
  end;
  //txt := fmIndex.ExtraiTexto(LinkPag, '<params>', '</params>');
  txt := LinkPag;
  txt := IfThen(trim(txt) = '', '=', txt);
  fmIndex.Param.Strings.Text := txt;
  fmIndex.Param.Strings.SaveToFile(fmIndex.dir_dados + 'configweb.ja');


  sTitulo.Caption := 'Obtendo informações dos arquivos...';
  try
    DM.qrARQUIVOS_SISTEMA.Close;
    DM.qrARQUIVOS_SISTEMA.Open;
  except
  end;

  temUrlDownload := DM.qrARQUIVOS_SISTEMA.Active and
    (DM.qrARQUIVOS_SISTEMA.FindField('URL_DOWNLOAD') <> nil);

  http_baixa();
end;

procedure TfAtualiza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tmrFecha.Enabled := False;
end;

procedure TfAtualiza.FormCreate(Sender: TObject);
var
  Result : Integer;
  SearchRec: TSearchRec;
begin
  if (DirectoryExists(fmIndex.dir_temp)) then
  begin
    result := FindFirst(fmIndex.dir_temp+'*.*', faAnyFile, SearchRec);
    While Result = 0 do
    begin
      DeleteFile(fmIndex.dir_temp + SearchRec.Name);
      Result := FindNext(SearchRec);
    end;
  end
  else CreateDir(fmIndex.dir_temp);
end;

end.

