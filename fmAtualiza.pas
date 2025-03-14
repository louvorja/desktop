unit fmAtualiza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IdHTTP, IdSSLOpenSSL, StdCtrls, ValEdit, OleCtrls,
  IdCoderMIME, ShellAPI, Grids, bsSkinCtrls, IdIPWatch,
  BusinessSkinForm, strutils, bsPngImageList, IdIOHandler,
  IdIOHandlerStack, IdSSL, IdCoder,
  IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, Vcl.ComCtrls, IdBaseComponent, IdExplicitTLSClientServerBase;

type
  TfAtualiza = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    IdFTP1: TIdFTP;
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
    ftp: TValueListEditor;
    sStatus: TbsSkinLabel;
    procedure FormActivate(Sender: TObject);
    procedure ftp_conecta();
    procedure ftp_baixa();
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    arquivo_temp: string;
    arq: Integer;
  public
    { Public declarations }
    arquivos: TStringList;
    arquivos_falha: TStringList;
    ftp_url: string;
    ftp_dir: string;
    ftp_porta: integer;
    ftp_usuario: string;
    ftp_senha: string;
    cancela: Boolean;
    erro: Boolean;
  end;

var
  fAtualiza: TfAtualiza;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;

{$R *.dfm}

procedure TfAtualiza.ftp_baixa;
var
  arquivo_ftp: string;
  i: Integer;
  size: integer;
begin
  arq := -1;
  for i := 0 to arquivos.Count-1 do
  begin
    if tmrFecha.Enabled = true then Continue;

    arq := i;
    if not IdFTP1.Connected then
    begin
      sTitulo.Caption := 'Conexão perdida... Reconectando...';
      ftp_conecta();
    end;

    arquivo_temp := 'arquivo_'+formatdatetime('yyyymmdd_hhnnsszzz', Now())+'.~tmp';
    arquivo_ftp := StringReplace(arquivos[i], '\', '/', [rfIgnoreCase, rfReplaceAll]);

    sTitulo.Caption := 'Baixando arquivo '''+ExtractFileName(fmIndex.dir_temp+arquivos[i])+'''';
    sProgressoT.Caption := 'Arquivo '+IntToStr(i+1)+' / '+inttostr(arquivos.Count);

    pbProgressoT.Max := arquivos.Count+1;
    pbProgressoT.Position := i+1;
//    pbProgresso.Position := 0;
//    pbProgresso.Max := 0;

    DM.qrARQUIVOS_SISTEMA.Locate('URL',arquivos[i],[]);
    size := DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger;
    //ShowMessage(arquivos[i]+' / '+inttostr(size)+' / '+DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').asstring);
    if (size <= 0) then
      size := IdFTP1.Size(ftp_dir+arquivo_ftp);

    if (size <= 0) then
    begin
      pbProgresso.Max := 0;
      pbProgresso.Style := pbstMarquee;
    end
    else
    begin
      pbProgresso.Max := size;
      pbProgresso.Style := pbstNormal;
    end;

    try
   // ShowMessage(AnsiToUtf8(ftp_dir+arquivo_ftp));
      IdFTP1.Get(trim(ftp_dir+arquivo_ftp), Trim(fmIndex.dir_temp+arquivo_temp), true, false);
    except
      on E: Exception do
      begin
//        ShowMessage('Erro: ' + E.Message );
        try
          sTitulo.Caption := 'Falha no download... Tentando novamente...';
          Sleep(2000);
          ftp_conecta();
          sTitulo.Caption := 'Baixando arquivo '''+ExtractFileName(fmIndex.dir_temp+arquivos[i])+'''';
          IdFTP1.Get(Trim(ftp_dir+arquivo_ftp), trim(fmIndex.dir_temp+arquivo_temp), true, false);
        except
        //ShowMessage('Erro: ' + E.Message+' = '+ftp_dir+arquivo_ftp);
          arquivos_falha.Add(arquivos[i]);
          sStatus.Caption := 'Falha no download: '+inttostr(arquivos_falha.Count);
        end;
      end;
    end;




  end;

  sTitulo.Caption := 'Finalizando...';
  pbProgressoT.Max := 1;
  pbProgressoT.Position := 1;
  tmrFecha.Enabled := True;
end;

procedure TfAtualiza.ftp_conecta;
var
  msg: String;
begin
  IdFTP1.Disconnect();
  Sleep(2000);

  IdFTP1.Host := ftp_url;
  IdFTP1.Port := ftp_porta;
  IdFTP1.Username := ftp_usuario;
  IdFTP1.Password := ftp_senha;
  IdFTP1.Passive := true; { usa modo ativo }
//  IdFTP1.RecvBufferSize := 8192;

  try
    IdFTP1.Connect;
  except
    on E: Exception do
    begin
      msg := '';

      if (Pos('too many connections', LowerCase(E.Message)) > 0) or
         (Pos('servidor sobrecarregado', LowerCase(E.Message)) > 0) then
      begin
        msg := 'O servidor estás sobrecarregado. Muitos usuários estão atualizando os arquivos neste momento. Tente novamente em alguns minutos!'+#13#10;
      end;

      if (Application.MessageBox(PChar('Não foi possível conectar ao servidor!'
          +#13#10
          +msg
          +#13#10
          +'Causa do erro: '+E.Message
          +#13#10
          +'Tentar novamente?'
      ),fmIndex.TITULO,mb_yesno+MB_ICONERROR) = 6)
        then ftp_conecta()
        else tmrFecha.Enabled := true;
    end;
  end;
end;

procedure TfAtualiza.IdFTP1Disconnected(Sender: TObject);
begin
  if (tmrFecha.Enabled) then Exit;
//  ShowMessage('Desconectado');
end;

procedure TfAtualiza.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if (tmrFecha.Enabled) then Exit;
  pbProgresso.Position := AWorkCount;
//  if (pbProgresso.MaxValue <= 0) then
//    pbProgresso.MaxValue := pbProgresso.Value;

  sProgresso.Caption := inttostr(AWorkCount div 1024)+ ' KB / ' +inttostr(pbProgresso.Max div 1024)+ ' KB';
end;

procedure TfAtualiza.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if (tmrFecha.Enabled) then Exit;
  pbProgresso.Position := 0;
  if (pbProgresso.Max <= 0) then
    pbProgresso.Max := AWorkCountMax;
end;

procedure TfAtualiza.IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  dir: string;
begin
  if (tmrFecha.Enabled) then Exit;

  pbProgresso.Position := pbProgresso.Max;

  dir := ExtractFilePath(ExtractFilePath(application.ExeName)+arquivos[arq]);
  if not DirectoryExists(dir)
    then ForceDirectories(dir);

  CopyFile(PChar(fmIndex.dir_temp+arquivo_temp), PChar(ExtractFilePath(application.ExeName)+arquivos[arq]), false);
  DeleteFile(fmIndex.dir_temp+arquivo_temp);
end;

procedure TfAtualiza.tmrFechaTimer(Sender: TObject);
begin
  //tmrFecha.Enabled := False;
  try
    if IdFTP1.Connected then
    begin
      try
        IdFTP1.Disconnect;
        IdFTP1.Abort;
      except
        //
      end;
     // IdFTP1.Free;
    end;
  except
    //
  end;
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
  lParams: string;
  ret_ftp: string;
  LinkPag,txt: string;
  ip: TIdIPWatch;
  url: string;
  dados_ftp: Boolean;
  tentat: Integer;
begin
  cancela := False;
  erro := False;
//  if DM.tmrSair.Enabled = true then Exit;

  tmrFecha.Enabled := False;
  arquivos_falha := TStringList.Create;
  sStatus.Caption := '';

  sTitulo.Caption := 'Buscando informações...';
  pbProgresso.Style := pbstMarquee;


  DM.IdHTTP1.Request.CustomHeaders.Values['Api-Token'] := '02@v2nFB2Dc';
  try
    LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
  except
    Sleep(2000);
    LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
  end;
  //txt := fmIndex.ExtraiTexto(LinkPag, '<params>', '</params>');
  txt := LinkPag;
  txt := IfThen(trim(txt) = '', '=', txt);
  fmIndex.Param.Strings.Text := txt;
  fmIndex.Param.Strings.SaveToFile(fmIndex.dir_dados + 'configweb.ja');


  if (fmIndex.param.Strings.Values['conn_ftp'] = '') then
  begin
    Application.MessageBox(PChar('Não foi possível buscar informações de conexão!'),fmIndex.TITULO,mb_ok+MB_ICONERROR);
    tmrFecha.Enabled := True;
    erro := True;
    Exit;
  end;

  ret_ftp := '';
  dados_ftp := False;
  tentat := 0;
  if (trim(fmIndex.loadCol.Strings.Values['FTP']) = '') then
  begin
    while (tmrFecha.Enabled = False) and (Trim(ret_ftp) = '')  do
    begin
      application.processmessages;
      tentat := tentat+1;
      ip := TIdIPWatch.Create(nil);
  //    lParams := TStringList.Create;
      lParams := '';
      lParams := lParams+'&lang='+fIniciando.LANG;
      lParams := lParams+'&version=' + fmIndex.lblVersao.Caption;
      lParams := lParams+'&bin_version=' + fmIndex.VersaoExe;
      lParams := lParams+'&datetime=' + formatdatetime('yyyy-mm-dd hh:nn:ss', Now());
      lParams := lParams+'&ip=' + ip.LocalIP;
      lParams := lParams+'&directory=' + Application.ExeName;
  //    lParams := lParams+'&parametros=' + GetCommandLine;
      fmIndex.paramtemp.Lines.Clear;
      fmIndex.paramtemp.Text := fmIndex.GetComputerNameFunc;
      lParams := lParams+'&pc_name=' + trim(fmIndex.paramtemp.Lines[0]);

      if Pos('?', fmIndex.param.Strings.Values['conn_ftp']) > 0 then
        url := fmIndex.param.Strings.Values['conn_ftp']+'&data='+DM.IdEncoderMIME.EncodeString(lParams)
      else
        url := fmIndex.param.Strings.Values['conn_ftp']+'?data='+DM.IdEncoderMIME.EncodeString(lParams);

      while (tmrFecha.Enabled = False) and (dados_ftp = False)  do
      begin
        dados_ftp := True;
        application.processmessages;
        try
          ret_ftp := DM.idHttp1.Get(url);
        except
          on E: Exception do
          begin
            dados_ftp := False;
            if (Application.MessageBox(PChar('Não foi possível obter dados FTP! O servidor pode estar indisponível, ou o programa não possui permissões de acesso à internet.'+#13#10+'Causa do erro: '+E.Message+#13#10+'Tentar novamente?'),fmIndex.TITULO,mb_yesno+MB_ICONERROR) <> 6) then
            begin
              fmIndex.erro_log.Lines.Add(E.Message);
              fmIndex.erro_log.Lines.Add(url);
              tmrFecha.Enabled := True;
              Sleep(1);
              erro := True;
              Break;
              Exit;
            end
            else
            begin
              sTitulo.Caption := 'Reconectando...';
              Sleep(2);
            end;
          end;
        end;
      end;

      if (tmrFecha.Enabled = true) then
      begin
        Sleep(1);
        Break;
        Continue;
        Exit;
      end;

      if (dados_ftp = true) then
      begin
        if (Trim(ret_ftp) = '') then
        begin
          if (tentat <= 5) then
          begin
            sTitulo.Caption := 'Não foi possível obter dados da conexão! Tentando novamente...';
            dados_ftp := False;
            Sleep(2);
          end
          else
          begin
            if (Application.MessageBox(PChar('Não foi possível obter dados da conexão!'+#13#10+'Tentar novamente?'),fmIndex.TITULO,mb_yesno+MB_ICONERROR) <> 6) then
            begin
              fmIndex.erro_log.Lines.Add(ret_ftp);
              fmIndex.erro_log.Lines.Add(url);
              tmrFecha.Enabled := True;
              erro := True;
              Break;
              Exit;
            end
            else
            begin
              sTitulo.Caption := 'Reconectando...';
              tentat := 0;
              dados_ftp := False;
              Sleep(2);
            end;
          end;
        end
        else
        begin
          ftp.Strings.Text := DM.IdDecoderMIME.DecodeString(ret_ftp);
          fmIndex.loadCol.Strings.Values['FTP'] := ftp.Strings.Text;
        end;
      end;
    end;
  end
  else
  begin
    ftp.Strings.Text := fmIndex.loadCol.Strings.Values['FTP'];
    dados_ftp := True;
    ret_ftp := DM.IdEncoderMIME.EncodeString(ftp.Strings.Text);
  end;

  if (tmrFecha.Enabled = true) or (dados_ftp = false) or (Trim(ret_ftp) = '') then
  begin
    sTitulo.Caption := 'Finalizando...';
    tmrFecha.Enabled := true;
    Exit;
  end;


  if (ftp.Values['ftp_msg'] <> '') then
  begin
    Application.MessageBox(PChar(ftp.Values['ftp_msg']),fmIndex.TITULO,mb_ok+MB_ICONERROR);
    fmIndex.loadCol.Strings.Values['FTP'] := '';
    tmrFecha.Enabled := True;
    Exit;
  end;

  arquivo_temp := '';

  ftp_url := ftp.Values['host'];
  ftp_dir := ftp.Values['root'];
  ftp_porta := StrToInt('0'+ftp.Values['port']);
  ftp_usuario := ftp.Values['username'];
  ftp_senha := ftp.Values['password'];

  sTitulo.Caption := 'Conectando ao servidor...';
  ftp_conecta();

  if tmrFecha.Enabled = True then
  begin
    sTitulo.Caption := 'Finalizando...';
    Exit;
  end;

  sTitulo.Caption := 'Obtendo informações dos arquivos...';
  DM.qrARQUIVOS_SISTEMA.Close;
  DM.qrARQUIVOS_SISTEMA.Open;

  ftp_baixa();
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

