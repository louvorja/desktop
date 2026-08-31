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
  //A tela serve a dois usos: a sincronizacao de arquivos (modo padrao) e o
  //download avulso de uma lista de URLs (itens agendados). Ver http_baixa.
  TModoAtualiza = (maAtualizacao, maDownload);

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
    procedure http_baixa();
    procedure httpDownloadWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure httpDownloadWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
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
    //OnActivate dispara de novo quando a janela reganha o foco
    download_executando: Boolean;
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

    //Modo download avulso: preencher urls e destinos (mesma ordem) antes do
    //ShowModal. Ao voltar, baixados diz quantos vieram e arquivos_falha lista
    //as URLs que nao deram certo.
    modo: TModoAtualiza;
    urls: TStringList;
    destinos: TStringList;
    titulo_download: string;
    baixados: Integer;
  end;

var
  fAtualiza: TfAtualiza;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;

{$R *.dfm}

//Baixa a lista de "urls" para os caminhos de "destinos" (mesma ordem), usando
//a mesma tela da sincronizacao de arquivos: pbProgressoT mostra o arquivo atual
//dentro do total e pbProgresso o progresso do arquivo.
//Cada arquivo e baixado para ".~tmp" e so recebe o nome final quando termina,
//entao um download interrompido nunca deixa arquivo pela metade no lugar certo.
procedure TfAtualiza.http_baixa;
var
  i: Integer;
  destino, temporario: string;
  saida: TFileStream;
  workAnterior: TWorkEvent;
  workBeginAnterior: TWorkBeginEvent;
begin
  baixados := 0;

  if (urls = nil) or (destinos = nil) or (urls.Count = 0) or
     (urls.Count <> destinos.Count) then
  begin
    erro := True;
    tmrFecha.Enabled := True;
    Exit;
  end;

  if (trim(titulo_download) <> '') then
    sTitulo.Caption := titulo_download;

  pbProgresso.Style := pbstNormal;
  pbProgresso.Position := 0;
  pbProgresso.Max := 0;
  pbProgressoT.Position := 0;
  pbProgressoT.Max := urls.Count;

  //O IdHTTP1 e compartilhado com a API do programa: os handlers de progresso
  //dele apontam para outro lugar e sao devolvidos no final.
  if download_executando then
    Exit;
  download_executando := True;

  workAnterior := DM.IdHTTP1.OnWork;
  workBeginAnterior := DM.IdHTTP1.OnWorkBegin;
  DM.IdHTTP1.OnWork := httpDownloadWork;
  DM.IdHTTP1.OnWorkBegin := httpDownloadWorkBegin;
  try
    for i := 0 to urls.Count - 1 do
    begin
      if cancela or tmrFecha.Enabled then
        Break;

      destino := trim(destinos[i]);
      if (destino = '') then
        Continue;

      sProgressoT.Caption := 'Arquivo ' + IntToStr(i + 1) + ' / ' + IntToStr(urls.Count);
      pbProgressoT.Position := i + 1;
      pbProgresso.Position := 0;
      pbProgresso.Max := 0;
      pbProgresso.Style := pbstMarquee;
      sProgresso.Caption := '';
      sStatus.Caption := ExtractFileName(destino);
      Application.ProcessMessages;

      //Ja baixado antes: aproveita
      if FileExists(destino) then
      begin
        Inc(baixados);
        Continue;
      end;

      if not DirectoryExists(ExtractFilePath(destino)) then
        ForceDirectories(ExtractFilePath(destino));

      temporario := destino + '.~tmp';
      if FileExists(temporario) then
        DeleteFile(temporario);

      try
        saida := TFileStream.Create(temporario, fmCreate);
        try
          //Sem os cabecalhos de outras chamadas: o token da API do usuario nao
          //pode ir junto para um servidor de fora
          DM.IdHTTP1.Request.CustomHeaders.Clear;
          DM.IdHTTP1.Get(urls[i], saida);
        finally
          saida.Free;
        end;

        if cancela or tmrFecha.Enabled then
        begin
          if FileExists(temporario) then
            DeleteFile(temporario);
          Break;
        end;

        if RenameFile(temporario, destino) then
          Inc(baixados)
        else
        begin
          arquivos_falha.Add(urls[i]);
          if FileExists(temporario) then
            DeleteFile(temporario);
        end;
      except
        on E: Exception do
        begin
          fmIndex.gravaLog('Falha ao baixar ' + urls[i] + ': ' + E.Message);
          if not (cancela or tmrFecha.Enabled) then
            arquivos_falha.Add(urls[i]);
          if FileExists(temporario) then
            DeleteFile(temporario);
        end;
      end;
    end;
  finally
    DM.IdHTTP1.OnWork := workAnterior;
    DM.IdHTTP1.OnWorkBegin := workBeginAnterior;
    download_executando := False;
  end;

  pbProgresso.Style := pbstNormal;
  pbProgresso.Position := pbProgresso.Max;
  pbProgressoT.Position := pbProgressoT.Max;
  tmrFecha.Enabled := True;
end;

procedure TfAtualiza.httpDownloadWork(ASender: TObject; AWorkMode: TWorkMode;
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

procedure TfAtualiza.httpDownloadWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if (tmrFecha.Enabled) then Exit;

  pbProgresso.Position := 0;
  pbProgresso.Max := AWorkCountMax;
  //Servidor que nao informa o tamanho: barra em movimento em vez de parada
  if (pbProgresso.Max > 0) then
    pbProgresso.Style := pbstNormal
  else
    pbProgresso.Style := pbstMarquee;
end;

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

    if(arquivos[i] = 'config\database.db') then
      arquivos[i] := 'config\'+lowercase(fIniciando.LANG)+'_database.db';

    arquivo_temp := 'arquivo_'+formatdatetime('yyyymmdd_hhnnsszzz', Now())+'.~tmp';
    arquivo_ftp := StringReplace(arquivos[i], '\', '/', [rfIgnoreCase, rfReplaceAll]);

    fmIndex.gravaLog('Baixando: '+ftp_dir+arquivo_ftp);

    sTitulo.Caption := 'Baixando arquivo '''+ExtractFileName(fmIndex.dir_temp+arquivos[i])+'''';
    sProgressoT.Caption := 'Arquivo '+IntToStr(i+1)+' / '+inttostr(arquivos.Count);

    pbProgressoT.Max := arquivos.Count+1;
    pbProgressoT.Position := i+1;
//    pbProgresso.Position := 0;
//    pbProgresso.Max := 0;

    size := 0;

    try
      DM.qrARQUIVOS_SISTEMA.Locate('URL',arquivos[i],[]);
      size := DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger;
    except
    end;


    //ShowMessage(arquivos[i]+' / '+inttostr(size));
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
        msg := 'O servidor está sobrecarregado. Muitos usuários estão atualizando os arquivos neste momento. Tente novamente em alguns minutos!'+#13#10;
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

  if(arquivos[arq] = 'config\'+lowercase(fIniciando.LANG)+'_database.db') then
    arquivos[arq] := 'config\database.db';

  CopyFile(PChar(fmIndex.dir_temp+arquivo_temp), PChar(ExtractFilePath(application.ExeName)+arquivos[arq]), false);
  DeleteFile(fmIndex.dir_temp+arquivo_temp);
end;

procedure TfAtualiza.tmrFechaTimer(Sender: TObject);
begin
  //No modo download quem esta ocupado e o IdHTTP do DM, nao o FTP
  if (modo = maDownload) then
  begin
    try
      DM.IdHTTP1.Disconnect;
    except
      //conexao ja pode ter caido
    end;
    fAtualiza.Close;
    Exit;
  end;

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

  //Modo download avulso: nao passa por nada do fluxo de atualizacao abaixo
  if (modo = maDownload) then
  begin
    http_baixa;
    Exit;
  end;

  fmIndex.gravaLog('Conectando FTP');

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
        url := fmIndex.param.Strings.Values['conn_ftp']+'&data='+DM.IdEncoderMIME.EncodeString(lParams)+'&lang='+fIniciando.LANG
      else
        url := fmIndex.param.Strings.Values['conn_ftp']+'?data='+DM.IdEncoderMIME.EncodeString(lParams)+'&lang='+fIniciando.LANG;

      fmIndex.gravaLog('URL para autorização de conexão: '+url);

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

  fmIndex.gravaLog('ftp_url: '+ftp_url);
  fmIndex.gravaLog('ftp_dir: '+ftp_dir);
//  fmIndex.gravaLog('ftp_porta: '+inttostr(ftp_porta));
//  fmIndex.gravaLog('ftp_usuario: '+ftp_usuario);
//  fmIndex.gravaLog('ftp_senha: *****************');

  sTitulo.Caption := 'Conectando ao servidor...';
  ftp_conecta();

  if tmrFecha.Enabled = True then
  begin
    sTitulo.Caption := 'Finalizando...';
    Exit;
  end;

  sTitulo.Caption := 'Obtendo informações dos arquivos...';
  try
    DM.qrARQUIVOS_SISTEMA.Close;
    DM.qrARQUIVOS_SISTEMA.Open;
  except
  end;
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

