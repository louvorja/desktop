unit fmTransmitir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinBoxCtrls,
  Vcl.StdCtrls, Vcl.Mask, bsSkinCtrls, Vcl.ExtCtrls, idcontext, IdSocketHandle,
  IdCustomHTTPServer, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdHTTPServer, bsribbon, bsSkinExCtrls, Vcl.Clipbrd, bsdbctrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfTransmitir = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel77: TGridPanel;
    Panel58: TPanel;
    bsSkinStdLabel142: TbsSkinStdLabel;
    Panel59: TPanel;
    bsSkinStdLabel143: TbsSkinStdLabel;
    seSrvPorta: TbsSkinNumericEdit;
    seSrvUrl: TbsSkinEdit;
    IdHTTPServer1: TIdHTTPServer;
    bsSkinPanel53: TbsSkinPanel;
    ckSrvConectar: TbsSkinCheckBox;
    bsRibbonDivider53: TbsRibbonDivider;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinLabel1: TbsSkinLabel;
    lblStatus: TbsSkinLabel;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinLabel2: TbsSkinLabel;
    lblLinkMus1: TbsSkinLinkLabel;
    btCopLinkMus1: TbsSkinSpeedButton;
    Memo1: TMemo;
    bsSkinPanel3: TbsSkinPanel;
    lblLinkMus2: TbsSkinLinkLabel;
    btCopLinkMus2: TbsSkinSpeedButton;
    bsSkinLabel3: TbsSkinLabel;
    bsSkinPanel4: TbsSkinPanel;
    bsSkinLabel4: TbsSkinLabel;
    bsSkinPanel5: TbsSkinPanel;
    bsSkinLabel5: TbsSkinLabel;
    bsSkinPanel6: TbsSkinPanel;
    lblLinkBib1: TbsSkinLinkLabel;
    btCopLinkBib1: TbsSkinSpeedButton;
    bsSkinLabel6: TbsSkinLabel;
    bsSkinPanel7: TbsSkinPanel;
    bsSkinButton2: TbsSkinButton;
    bsSkinPanel8: TbsSkinPanel;
    btServidor: TbsSkinSpeedButton;
    btIPRede: TbsSkinSpeedButton;
    ckSrvAltIPPorta: TbsSkinCheckBox;
    bsSkinPanel9: TbsSkinPanel;
    bsSkinLabel7: TbsSkinLabel;
    btCopLink: TbsSkinSpeedButton;
    lblLink: TbsSkinLinkLabel;
    Panel1: TPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    seSrvToken: TbsSkinEdit;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    qrBUSCA: TFDQuery;
    procedure seSrvUrlExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure btServidorClick(Sender: TObject);
    procedure ckSrvConectarClick(Sender: TObject);
    procedure btCopLinkMus1Click(Sender: TObject);
    procedure btCopLinkMus2Click(Sender: TObject);
    procedure btCopLinkBib1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure btIPRedeClick(Sender: TObject);
    procedure ckSrvAltIPPortaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btCopLinkClick(Sender: TObject);
    function geraToken():string;
    procedure seSrvTokenExit(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    tentativaConexao: Integer;
  public
    { Public declarations }
  end;

var
  fTransmitir: TfTransmitir;

implementation

{$R *.dfm}

uses
  fmMusica, fmMenu;

// ── Enumeração de interfaces de rede (iphlpapi) ─────────────────────────────

// Prefixo "_" evita colisão de nomes com Winapi.IpTypes/IpHlpApi (não usadas aqui).
// Os códigos de retorno usam ERROR_SUCCESS/ERROR_BUFFER_OVERFLOW de Winapi.Windows.
const
  _MAX_ADAPTER_NAME_LEN = 260;
  _MAX_ADAPTER_DESC_LEN = 132;
  _MAX_ADAPTER_ADDR_LEN = 8;

type
  TInterfaceInfo = record
    Nome: string;
    IP:   string;
  end;

  PIPAddrString = ^TIPAddrString;
  TIPAddrString = record
    Next:      PIPAddrString;
    IPAddress: array[0..15] of AnsiChar;
    IPMask:    array[0..15] of AnsiChar;
    Context:   DWORD;
  end;

  PIPAdapterInfo = ^TIPAdapterInfo;
  TIPAdapterInfo = record
    Next:             PIPAdapterInfo;
    ComboIndex:       DWORD;
    AdapterName:      array[0.._MAX_ADAPTER_NAME_LEN-1] of AnsiChar;
    Description:      array[0.._MAX_ADAPTER_DESC_LEN-1] of AnsiChar;
    AddressLength:    UINT;
    Address:          array[0.._MAX_ADAPTER_ADDR_LEN-1] of Byte;
    Index:            DWORD;
    AType:            UINT;
    DhcpEnabled:      UINT;
    CurrentIpAddress: PIPAddrString;
    IpAddressList:    TIPAddrString;
    GatewayList:      TIPAddrString;
    DhcpServer:       TIPAddrString;
    HaveWins:         BOOL;
    PrimaryWins:      TIPAddrString;
    SecondaryWins:    TIPAddrString;
    LeaseObtained:    DWORD;
    LeaseExpires:     DWORD;
  end;

function GetAdaptersInfo(pAdapterInfo: PIPAdapterInfo; pOutBufLen: PDWORD): DWORD;
  stdcall; external 'iphlpapi.dll';

// Redeclarada com retorno DWORD: a TrackPopupMenu padrão do Delphi retorna BOOL,
// que não carrega o ID do item selecionado quando se usa TPM_RETURNCMD.
function TrackPopupMenuResult(hMenu: HMENU; uFlags: UINT; x, y, nReserved: Integer;
  hWnd: HWND; prcRect: PRect): DWORD; stdcall; external 'user32.dll' name 'TrackPopupMenu';

// Retorna as interfaces IPv4 ativas (nome + IP). Array vazio em qualquer falha de
// API ou ausência de adaptadores — o chamador trata isso caindo no GetIP.
function EnumerarInterfaces: TArray<TInterfaceInfo>;
var
  BufLen: DWORD;
  Buf: TBytes;
  Adapter: PIPAdapterInfo;
  AddrStr: PIPAddrString;
  IP, Nome: string;
  Count: Integer;
begin
  Result := [];
  BufLen := 0;
  if GetAdaptersInfo(nil, @BufLen) <> ERROR_BUFFER_OVERFLOW then
    Exit;

  SetLength(Buf, BufLen);
  if GetAdaptersInfo(PIPAdapterInfo(Buf), @BufLen) <> ERROR_SUCCESS then
    Exit;

  Count := 0;
  Adapter := PIPAdapterInfo(Buf);
  while Adapter <> nil do
  begin
    Nome := string(PAnsiChar(@Adapter^.Description[0]));
    AddrStr := @Adapter^.IpAddressList;
    while AddrStr <> nil do
    begin
      IP := string(PAnsiChar(@AddrStr^.IPAddress[0]));
      if (IP <> '') and (IP <> '0.0.0.0') and
         (Copy(IP, 1, 4) <> '127.') and
         (Copy(IP, 1, 8) <> '169.254.') then
      begin
        SetLength(Result, Count + 1);
        Result[Count].Nome := Nome;
        Result[Count].IP   := IP;
        Inc(Count);
      end;
      AddrStr := AddrStr^.Next;
    end;
    Adapter := Adapter^.Next;
  end;
end;

// ────────────────────────────────────────────────────────────────────────────

procedure TfTransmitir.bsSkinButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfTransmitir.btIPRedeClick(Sender: TObject);
var
  Interfaces: TArray<TInterfaceInfo>;
  I: Integer;
  Ponto: TPoint;
  HPopup: HMENU;
  Cmd: DWORD;
begin
  Interfaces := EnumerarInterfaces;
  if Length(Interfaces) = 0 then
  begin
    seSrvUrl.Text := fmIndex.GetIP;
    Exit;
  end;

  HPopup := CreatePopupMenu;
  try
    for I := 0 to High(Interfaces) do
      AppendMenu(HPopup, MF_STRING, UINT(I + 1),
        PChar(Interfaces[I].Nome + '  –  ' + Interfaces[I].IP));

    Ponto := btIPRede.ClientToScreen(Point(0, btIPRede.Height));
    // TPM_RETURNCMD devolve o ID do item direto no retorno; TPM_NONOTIFY suprime
    // o WM_COMMAND — essencial aqui, pois TbsBusinessSkinForm o intercepta e a
    // seleção nunca chegaria a um handler de menu VCL convencional.
    Cmd := TrackPopupMenuResult(HPopup,
      TPM_RETURNCMD or TPM_NONOTIFY or TPM_LEFTALIGN or TPM_LEFTBUTTON,
      Ponto.X, Ponto.Y, 0, Handle, nil);
  finally
    DestroyMenu(HPopup);
  end;

  if (Cmd >= 1) and (Cmd <= DWORD(Length(Interfaces))) then
    seSrvUrl.Text := Interfaces[Cmd - 1].IP;
end;

procedure TfTransmitir.bsSkinSpeedButton1Click(Sender: TObject);
begin
  seSrvToken.Text := geraToken();
  fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);
end;

procedure TfTransmitir.btCopLinkBib1Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkBib1.Caption;
end;

procedure TfTransmitir.btCopLinkClick(Sender: TObject);
begin
  Clipboard.AsText := lblLink.Caption;
end;

procedure TfTransmitir.btCopLinkMus1Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkMus1.Caption;
end;

procedure TfTransmitir.btCopLinkMus2Click(Sender: TObject);
begin
  Clipboard.AsText := lblLinkMus2.Caption;
end;

procedure TfTransmitir.btServidorClick(Sender: TObject);
var
  Binding : TIdSocketHandle;
  url: string;
begin
  tentativaConexao := tentativaConexao+1;

  seSrvUrl.Enabled := True;
  seSrvPorta.Enabled := True;
  seSrvToken.Enabled := True;
  btIPRede.Enabled := True;
  fmIndex.spServer.Caption := '';
  btServidor.Enabled := False;
  IdHTTPServer1.Active := False;
  IdHTTPServer1.Bindings.Clear;
  lblStatus.Caption := 'Desconectado';

  lblLink.Caption := '';
  lblLink.URL := lblLink.Caption;
  lblLinkMus1.Caption := '';
  lblLinkMus1.URL := lblLinkMus1.Caption;
  lblLinkMus2.Caption := '';
  lblLinkMus2.URL := lblLinkMus2.Caption;
  lblLinkBib1.Caption := '';
  lblLinkBib1.URL := lblLinkBib1.Caption;

  if (btServidor.ImageIndex = 9) then
  begin
    btServidor.ImageIndex := 8;
    btServidor.Caption := 'Iniciar Servidor';
    btServidor.Enabled := True;
    tentativaConexao := 0;
  end
  else
  begin
    if (trim(seSrvUrl.Text) = '')
      then seSrvUrl.Text := fmIndex.GetIP;
    if (trim(seSrvPorta.Text) = '')
      then seSrvPorta.Text := '7070';
    if (StrToInt(seSrvPorta.Text) <= 0)
      then seSrvPorta.Text := '7070';
    if (trim(seSrvToken.Text) = '')
      then seSrvToken.Text := geraToken();


    IdHTTPServer1.DefaultPort := StrToInt(seSrvPorta.Text);
    Binding := IdHTTPServer1.Bindings.Add;
    Binding.Port := IdHTTPServer1.DefaultPort;
    Binding.IP := seSrvUrl.Text;
    // Also bind to localhost for local API access (e.g., from web browsers)
    if seSrvUrl.Text <> '127.0.0.1' then
    begin
      Binding := IdHTTPServer1.Bindings.Add;
      Binding.Port := IdHTTPServer1.DefaultPort;
      Binding.IP := '127.0.0.1';
    end;
    try
      IdHTTPServer1.Active := True;
      btServidor.Enabled := True;
      btServidor.ImageIndex := 9;
      btServidor.Caption := 'Desconectar Servidor';
      seSrvUrl.Enabled := False;
      seSrvPorta.Enabled := False;
      seSrvToken.Enabled := False;
      btIPRede.Enabled := False;
      fmIndex.gravaParam('Servidor', 'URL', seSrvUrl.Text);
      fmIndex.gravaParam('Servidor', 'Porta', seSrvPorta.Text);
      fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);

      url := 'http://'+seSrvUrl.Text+':'+seSrvPorta.Text;
      fmIndex.spServer.Caption := url;
      lblStatus.Caption := 'Conectado';

      lblLink.Caption := url;
      lblLink.URL := lblLink.Caption;
      lblLinkMus1.Caption := url+'/musica?transmissao';
      lblLinkMus1.URL := lblLinkMus1.Caption;
      lblLinkMus2.Caption := url+'/musica?retorno';
      lblLinkMus2.URL := lblLinkMus2.Caption;
      lblLinkBib1.Caption := url+'/biblia?transmissao';
      lblLinkBib1.URL := lblLinkBib1.Caption;

      memo1.lines.savetofile(fmIndex.dir_config+'server/file/file.ja');
    except
      IdHTTPServer1.Active := False;
      IdHTTPServer1.Bindings.Clear;
      btServidor.Enabled := True;

      if tentativaConexao < 3 then
      begin
        if (seSrvUrl.Text <> fmIndex.GetIP) then
        begin
          seSrvUrl.Text := fmIndex.GetIP;
          btServidorClick(Sender);
        end
        else
        begin
          seSrvPorta.Text := IntToStr(1 + Random(10000));
          btServidorClick(Sender);
        end;
      end
      else
      begin
        tentativaConexao := 0;
        Application.MessageBox(PChar('Erro ao iniciar servidor!'),fmIndex.TITULO,mb_ok+mb_iconerror);
      end;
    end;
  end;
end;

procedure TfTransmitir.ckSrvAltIPPortaClick(Sender: TObject);
begin
  if ckSrvAltIPPorta.Checked then
    fmIndex.gravaParam('Servidor', 'AltPortaIP', '1')
  else
    fmIndex.gravaParam('Servidor', 'AltPortaIP', '0');
end;

procedure TfTransmitir.ckSrvConectarClick(Sender: TObject);
begin
  if ckSrvConectar.Checked then
    fmIndex.gravaParam('Servidor', 'Conectar', '1')
  else
    fmIndex.gravaParam('Servidor', 'Conectar', '0');
end;

procedure TfTransmitir.FormActivate(Sender: TObject);
begin
  tentativaConexao := 0;
end;

procedure TfTransmitir.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

function TfTransmitir.geraToken: string;
const
  CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
var
  i: Integer;
begin
  Randomize;
  Result := '';
  for i := 1 to 5 do
    Result := Result + CHARS[Random(Length(CHARS)) + 1];
end;

procedure TfTransmitir.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  url:string;
  arq:string;
  txt: TStringList;
  songId: Integer;
  tagValue: Integer;
  txtModo: string;
  tocarAudio: Boolean;
  messageDraw: string;
  messageStopwatch: string;
  messageSlide: string;
  attemptCount: Integer;
  success: Boolean;
  isLocalRequest: Boolean;
  keyCode: Integer;
  I: Integer;
  searchTerm: String;
  jsonResult: String;
  primeiro: Boolean;
begin
  // Allow cross-origin requests from web applications
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, OPTIONS';

  arq := ARequestInfo.Document;
  arq := Trim(arq);
  if (arq <> '/') and arq.EndsWith('/') then
    Delete(arq, Length(arq), 1);

  // Requests via localhost (127.0.0.1) are trusted — only processes on the
  // same machine can reach this binding. Token is only required for network access.
  // AContext.Binding.IP returns the server-side socket address (getsockname),
  // which cannot be spoofed by a remote client.
  isLocalRequest := (AContext.Binding.IP = '127.0.0.1');

  if Pos('/api', arq) = 1 then
  begin
    AResponseInfo.ContentType := 'application/json';
    AResponseInfo.CharSet := 'utf-8';

    // Validação de token (somente se não for localhost)
    if (not isLocalRequest) and
      (ARequestInfo.Params.Values['token'] <>
        fmIndex.lerParam('Servidor', 'Token','')) then
    begin
      AResponseInfo.ResponseNo := 401;
      AResponseInfo.ContentText :=
        '{"status":"error","message":"Invalid token","code":"INVALID_TOKEN"}';
      Exit;
    end;

    // API: Health check endpoint (used by web apps to detect if LouvorJA is running)
    if arq = '/api/ping' then
    begin
      AResponseInfo.ContentText := '{"status":"ok","app":"LouvorJA"}';
      Exit;
    end;

    // API: Simulate keyboard key press
    // Usage: /api/keyboard?key=13
    if arq = '/api/keyboard' then
    begin
      keyCode := StrToIntDef(ARequestInfo.Params.Values['key'], -1);

      if keyCode = -1 then
      begin
        AResponseInfo.ResponseNo := 400;
        AResponseInfo.ContentText :=
          '{"status":"error","message":"Missing or invalid key","code":"INVALID_KEY"}';
        Exit;
      end;

      // Executa no thread da UI
      TThread.Queue(nil,
        procedure
        begin
          // traz a aplicação para frente
          if (fMusica <> nil) and (fMusica.Visible) and (fMusica.HandleAllocated) then
          begin
            SetForegroundWindow(fMusica.Handle);
          end
          else if (fmIndex <> nil) and (fmIndex.HandleAllocated) then
          begin
            SetForegroundWindow(fmIndex.Handle);
          end;

          // envia a tecla
          keybd_event(keyCode, 0, 0, 0);
          keybd_event(keyCode, 0, KEYEVENTF_KEYUP, 0);
        end
      );

      AResponseInfo.ContentText :=
        '{"status":"ok","action":"keyboard","key":' + IntToStr(keyCode) + '}';

      Exit;
    end;

    // API: Change to next slide or previous slide and get status slides
    if arq = '/api/song-slides' then
    begin
      if (ARequestInfo.Params.Values['action'] = 'next') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          fMusica.acaoSlide('prox');
          AResponseInfo.ContentText := '{"status":"ok","message":"Advanced to the next slide","code":"ADVANCED_SLIDE"}';
          Exit;
        end
        else
        begin
          AResponseInfo.ContentText := '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequestInfo.Params.Values['action'] = 'previous') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          fMusica.acaoSlide('ant');
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"Reverted to the previous slide"}';
          Exit;
        end
        else
        begin
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequestInfo.Params.Values['action'] = 'playing-check') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"Song playing","code":"SONG_PLAYING"}';
          Exit;
        end
        else
        begin
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequestInfo.Params.Values['action'] = 'get-slide') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          messageSlide := '';

          if (ARequestInfo.Params.Values['slide'] = 'current') then
          begin
            messageSlide := fMusica.lblLetra.Caption;
          end
          else if (ARequestInfo.Params.Values['slide'] = 'next') then
          begin
            if (fMusica.lbLetras.Items.Count > fMusica.nslide) then
              messageSlide := fMusica.lbLetras.Items[fMusica.nslide]
            else
              messageSlide := '< FIM >';
          end;

          messageSlide := StringReplace(messageSlide, '"', '\"', [rfReplaceAll]);

          messageSlide := StringReplace(messageSlide, #13#10, '\n', [rfReplaceAll]);
          messageSlide := StringReplace(messageSlide, #13, '\n', [rfReplaceAll]);
          messageSlide := StringReplace(messageSlide, #10, '\n', [rfReplaceAll]);

          AResponseInfo.ContentText := '{"status":"ok","message":"' + messageSlide + '","code":"SONG_PLAYING"}';
          Exit;
        end
        else
        begin
          AResponseInfo.ContentText := '{"status":"ok","message":"","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else if (ARequestInfo.Params.Values['action'] = 'close') then
      begin
        if (fMusica <> nil) and (fMusica.Visible) then
        begin
          fMusica.Close;
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"Song closed","code":"SONG_CLOSED"}';
          Exit;
        end
        else
        begin
          AResponseInfo.ContentText :=
            '{"status":"ok","message":"No song playing","code":"NO_SONG_PLAYING"}';
          Exit;
        end;
      end
      else
      begin
        AResponseInfo.ResponseNo := 400;
        AResponseInfo.ContentText :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/song-slides?action=next","code":"MISSING_ACTION"}';
      end;
      Exit;
    end;

    // API: Gets the time of the computer where Louvor JA is
    if arq = '/api/clock' then
    begin
      AResponseInfo.ContentText :=
        '{"status":"ok","hour":"' + formatdatetime('hh:mm:ss', now()) + '"}';
      Exit;
    end;

    // API: Control Drawing number
    if arq = '/api/drawing-number' then
    begin
      if (ARequestInfo.Params.Values['action'] = 'get-last') then
      begin
        attemptCount := 0;
        success := False;

        while (attemptCount < 3) do
        begin
          if (fmIndex.btSortear.Enabled) then
          begin
            messageDraw := fmIndex.lmdSorteio.Caption;
            AResponseInfo.ContentText := '{"status":"ok","action":"get-last","message":"' + messageDraw + '"}';
            success := True;
            Break;
          end
          else
          begin
            Inc(attemptCount);
            Sleep(1000);
          end;
        end;

        if not success then
        begin
          AResponseInfo.ResponseNo := 400;
          AResponseInfo.ContentText := '{"status":"error","message":"Failed after 3 attempts, button not enabled","code":"BUTTON_NOT_ENABLED"}';
        end;
        Exit;
      end
      else if (ARequestInfo.Params.Values['action'] = 'draw') then
      begin

        if fmIndex.lbSorteio.Items.Count = 0 then
        begin
          AResponseInfo.ResponseNo := 400;
          AResponseInfo.ContentText :=
            '{"status":"error","message":"Nenhum participante adicionado ao sorteio","code":"EMPTY_PARTICIPANTS"}';
          Exit;
        end;

        fmIndex.btSortearClick(fmIndex.btSortear);

        AResponseInfo.ContentText :=
          '{"status":"ok","message":"Sorteando número"}';

        Exit;
      end
      else if (ARequestInfo.Params.Values['action'] = 'get-participants') then
      begin

        messageDraw := '';

        for I := 0 to fmIndex.lbSorteio.Items.Count - 1 do
        begin
          if messageDraw <> '' then
            messageDraw := messageDraw + ', ';

          messageDraw := messageDraw + fmIndex.lbSorteio.Items[I].Caption;
        end;

        AResponseInfo.ContentText := '{"status":"ok","action":"participants","message":"' + StringReplace(messageDraw, '"', '\"', [rfReplaceAll]) +'"}';

        Exit;
      end
      else
      begin
        AResponseInfo.ResponseNo := 400;
        AResponseInfo.ContentText :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/drawing-number?action=draw","code":"MISSING_ACTION"}';
      end;
      Exit;
    end;

    // API: Control stopwatch
    if arq = '/api/stopwatch' then
    begin
      if (ARequestInfo.Params.Values['action'] = 'get-time') then
      begin
        messageStopwatch := fmIndex.lmdCrono.Caption;
        AResponseInfo.ContentText := '{"status":"ok","action":"get-time","message":"' + messageStopwatch + '"}';
        // success := True;
        Exit;
      end
      else if (ARequestInfo.Params.Values['action'] = 'start') then
      begin
        fmIndex.btIniciarCronoClick(fmIndex.btIniciarCrono);
        AResponseInfo.ContentText := '{"status":"ok","action":"start","message":"Iniciando cronÃ´metro"}';
        Exit;
      end
      else if (ARequestInfo.Params.Values['action'] = 'stop') then
      begin
        fmIndex.btZerarCronoClick(fmIndex.btZerarCrono);
        AResponseInfo.ContentText := '{"status":"ok","action":"stop","message":"Parando e zerando cronÃ´metro"}';
        Exit;
      end
      else if (ARequestInfo.Params.Values['action'] = 'note') then
      begin
        fmIndex.btAnotTempoClick(fmIndex.btAnotTempo);
        AResponseInfo.ContentText := '{"status":"ok","action":"note","message":"Anotando tempo"}';
        Exit;
      end
      else
      begin
        AResponseInfo.ResponseNo := 400;
        AResponseInfo.ContentText :=
          '{"status":"error","message":"Missing or invalid action. Usage example: /api/stopwatch?action=start","code":"MISSING_ACTION"}';
      end;
    end;

    // API: Search songs by title or author
    // Usage: GET /api/search-songs?q=termo
    if arq = '/api/search-songs' then
    begin
        searchTerm := Trim(ARequestInfo.Params.Values['q']);

        if searchTerm = '' then
        begin
            AResponseInfo.ResponseNo := 400;
            AResponseInfo.ContentText :=
                '{"status":"error","message":"Missing search term","code":"MISSING_SEARCH_TERM"}';
            Exit;
        end;

        qrBUSCA.Close;
        qrBUSCA.ParamByName('VALOR').AsString := fmIndex.termo_busca(searchTerm);
        qrBUSCA.Open;

        jsonResult := '{"status":"ok","musicas":[';
        primeiro := True;

        while not qrBUSCA.Eof do
        begin
            if not primeiro then
                jsonResult := jsonResult + ',';
            primeiro := False;

            jsonResult := jsonResult + '{';
            jsonResult := jsonResult + '"id":' + qrBUSCA.FieldByName('ID').AsString + ',';
            jsonResult := jsonResult + '"nome":"' + StringReplace(qrBUSCA.FieldByName('NOME').AsString, '"', '\"', [rfReplaceAll]) + '",';
            jsonResult := jsonResult + '"album":"' + StringReplace(qrBUSCA.FieldByName('NOME_ALBUM_COM').AsString, '"', '\"', [rfReplaceAll]) + '"';
            jsonResult := jsonResult + '}';

            qrBUSCA.Next;
        end;

        jsonResult := jsonResult + ']}';
        AResponseInfo.ContentText := jsonResult;

        Exit;
    end;

    // API: Open a song slide by its database ID
    // Usage: GET /api/open-song?id=123
    if arq = '/api/open-song' then
    begin
      if TryStrToInt(ARequestInfo.Params.Values['id'], songId) then
      begin
        if not TryStrToInt(ARequestInfo.Params.Values['tag'], tagValue) then
          tagValue := 1;

        if tagValue = 2 then
          txtModo := 'PB'
        else
          txtModo := '';

        tocarAudio := tagValue < 3;

        TThread.Queue(nil,
          procedure
          begin
            if Assigned(fmIndex) then
              fmIndex.abreLetraMusica('BD', txtModo, songId, tocarAudio);
          end
        );
        AResponseInfo.ContentText :=
          '{"status":"ok","action":"open-song","id":' + IntToStr(songId) + '}';
      end
      else
      begin
        AResponseInfo.ResponseNo := 400;
        AResponseInfo.ContentText :=
          '{"status":"error","message":"Missing or invalid song ID. Usage example: /api/open-song?id=123","code":"MISSING_ID"}';
      end;
      Exit;
    end;
  end;

  // Static file serving (existing behavior)
  if (arq = '') or (arq = '/') then
    arq := '/index.html';

  if (arq = '/musica') or (arq = '/biblia') then
    arq := '/mirror.html';

  url := fmIndex.dir_config+'server'+arq;
  if not FileExists(url) then
  begin
    arq := '/404.html';
    url := fmIndex.dir_config+'server'+arq;
  end;
  txt := TStringList.Create;
  try
    txt.LoadFromFile(url);
    AResponseInfo.ContentText := txt.Text;
  finally
    txt.Free;
  end;
end;

procedure TfTransmitir.seSrvTokenExit(Sender: TObject);
begin
  fmIndex.gravaParam('Servidor', 'Token', seSrvToken.Text);
end;

procedure TfTransmitir.seSrvUrlExit(Sender: TObject);
begin
  seSrvUrl.Text := StringReplace(seSrvUrl.Text,'http://','',[rfIgnoreCase, rfReplaceAll]);
  seSrvUrl.Text := StringReplace(seSrvUrl.Text,'https://','',[rfIgnoreCase, rfReplaceAll]);
  //192.168.56.1
end;

end.


