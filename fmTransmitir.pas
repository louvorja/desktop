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

    // ====================================================================
    // API v2 - declarações
    //
    // Tudo que pertence à v2 fica agrupado aqui e, na implementação, num
    // bloco único no fim da unit. A v1 não é tocada: continua atendendo
    // quem já está integrado a ela.
    // ====================================================================

    // Roteamento. Devolve True quando a requisição era da v2 e já foi
    // respondida - nesse caso o handler principal não segue adiante.
    function trataApiV2(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo): Boolean;
    procedure v2Despacha(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const rota, acao: string);

    // Verbos que o Indy não entrega ao OnCommandGet, como o OPTIONS
    procedure IdHTTPServer1CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

    // Impede que o Indy recuse sozinho o esquema Bearer
    procedure IdHTTPServer1ParseAuthentication(AContext: TIdContext;
      const AAuthType, AAuthData: String; var VUsername, VPassword: String;
      var VHandled: Boolean);

    // Executa na thread da interface e espera pelo fim, com prazo. Todo
    // acesso a componente visual ou ao banco passa por aqui.
    function executaNaInterface(const rotina: TProc; timeoutMs: Integer): Boolean;

    // Autenticação: página servida pelo próprio programa dispensa token
    function v2PaginaInterna(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo): Boolean;
    function v2TokenValido(ARequestInfo: TIdHTTPRequestInfo): Boolean;

    // Montagem das respostas no formato da convenção
    function escapaJson(const txt: string): string;
    procedure respondeV2Ok(AResponseInfo: TIdHTTPResponseInfo;
      const acao, codigo, mensagem, dados: string);
    procedure respondeV2Erro(AResponseInfo: TIdHTTPResponseInfo;
      codigoHttp: Integer; const acao, codigo, mensagem: string);

    // Auxiliares das rotas
    function v2Param(ARequestInfo: TIdHTTPRequestInfo; const nome: string): string;
    function v2Acao(ARequestInfo: TIdHTTPRequestInfo): string;
    function v2ExigeMetodo(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao, metodo: string): Boolean;
    procedure respondeV2Ocupado(AResponseInfo: TIdHTTPResponseInfo;
      const acao: string);
    procedure respondeV2AcaoInvalida(AResponseInfo: TIdHTTPResponseInfo;
      const acao, aceitas: string);

    // Rotas de leitura
    procedure v2Clock(AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2SongSlides(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2Stopwatch(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2StopwatchComando(AResponseInfo: TIdHTTPResponseInfo;
      const acao, acaoPedida: string);
    procedure v2StopwatchModo(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2DrawingNumber(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2SearchSongs(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);

    // Rotas de comando
    procedure v2Draw(AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2Keyboard(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
    procedure v2OpenSong(ARequestInfo: TIdHTTPRequestInfo;
      AResponseInfo: TIdHTTPResponseInfo; const acao: string);
  public
    { Public declarations }
  end;

var
  fTransmitir: TfTransmitir;

implementation

{$R *.dfm}

uses
  fmMusica, fmMenu, dmComponentes, System.SyncObjs, System.StrUtils,
  IdURI, IdGlobal;

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


    //Eventos que a v2 precisa. Ficam aqui porque é onde o servidor é
    //configurado; a v1 não é afetada por nenhum dos dois.
    IdHTTPServer1.OnCommandOther := IdHTTPServer1CommandOther;
    IdHTTPServer1.OnParseAuthentication := IdHTTPServer1ParseAuthentication;

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
  // A v2 é atendida por um bloco próprio, no fim desta unit. Quando ela
  // responde, nada daqui para baixo é executado.
  if trataApiV2(AContext, ARequestInfo, AResponseInfo) then
    Exit;

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
        // O Indy decodifica a query string com o charset do Content-Type, e
        // num GET não existe Content-Type: o charset fica vazio e ele usa o
        // padrão de 8 bits. Como o navegador percent-encoda em UTF-8, buscar
        // "coração" não encontrava nada, enquanto "coracao" encontrava. v2Param
        // faz a decodificação correta.
        searchTerm := Trim(v2Param(ARequestInfo, 'q'));

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

// ##########################################################################
// #                                 API v2                                 #
// ##########################################################################
//
// Daqui até o fim da unit é tudo da v2. Nada acima é usado por ela, e ela não
// altera nada da v1 - as duas rodam lado a lado.
//
// ------------------------------- CONVENÇÃO --------------------------------
//
// ROTA       /api/v2/<recurso>, em kebab-case. Barra final não muda a rota.
//            O recurso é substantivo; o verbo vai no parâmetro "action".
//
// MÉTODO     GET lê, POST altera. Método errado devolve 405. Comando não
//            alterna: repetir "start" mantém iniciado, não pausa.
//
// TOKEN      Exigido, menos em página servida pelo próprio programa - que é
//            conexão de 127.0.0.1 com Origin ausente ou igual à do servidor.
//            Aceito em "Authorization: Bearer <token>" ou em ?token=.
//
// PARÂMETRO  Nome em minúsculas. "action" é comparado sem diferenciar
//            maiúsculas e com Trim. Ausente -> 400 MISSING_*; inválido ->
//            400 INVALID_*. Parâmetro desconhecido é ignorado. Os valores
//            são lidos por v2Param, que decodifica em UTF-8.
//
// RESPOSTA   Sempre JSON em UTF-8, inclusive nos erros.
//
//     { "status":"ok",    "action":"...", "code":"...", "message":"...",
//       <campos de dados> }
//
//     { "status":"error", "action":"...", "code":"...", "message":"..." }
//
//     status   só "ok" ou "error".
//     code     sempre presente, em SCREAMING_SNAKE. É o contrato estável: o
//              cliente decide por ele, nunca pelo texto. Em "ok" descreve o
//              estado; em "error", o motivo.
//     message  só texto para humano. Nunca carrega dado.
//     dados    em campo próprio e nomeado ("musicas", "time", "slide"), no
//              topo do objeto. Nunca dentro de "message".
//
// HTTP       200 ok               400 erro do cliente
//            401 token            404 rota inexistente
//            405 método errado    409 o estado do programa impede
//            500 falha interna    503 interface não respondeu no prazo
//
// THREAD     O handler roda numa thread por conexão. Todo acesso a componente
//            visual ou ao banco passa por executaNaInterface, nunca direto.
//            503 significa "não deu para confirmar no prazo", e não "nada
//            aconteceu": a rotina enfileirada ainda pode rodar depois.
//
// ##########################################################################

const
  ROTA_V2 = '/api/v2';

  //Prazo para a thread da interface atender. Se estourar, a resposta é
  //503 em vez de deixar a conexão presa: a interface pode estar com um
  //diálogo modal aberto, esperando o operador.
  TIMEOUT_INTERFACE = 5000;

  //Comando ganha prazo maior: abrir uma música carrega letra e áudio, e
  //demora bem mais que ler uma legenda de tela
  TIMEOUT_COMANDO = 15000;

type
  //Ponte entre a thread do Indy e a thread da interface.
  //
  //Vive por contagem de referência de propósito: se a espera desistir pelo
  //prazo, a rotina enfileirada ainda vai rodar em algum momento e sinalizar
  //o evento. Se o objeto fosse liberado pela thread que desistiu, essa
  //sinalização cairia em memória já liberada.
  IExecucaoInterface = interface
    ['{7F2A1C64-3E5B-4B9A-9C21-6D0E5A8B4411}']
    procedure Executa(const rotina: TProc);
    function Espera(timeoutMs: Integer): Boolean;
    function Erro: string;
  end;

  TExecucaoInterface = class(TInterfacedObject, IExecucaoInterface)
  private
    FEvento: TEvent;
    FErro: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Executa(const rotina: TProc);
    function Espera(timeoutMs: Integer): Boolean;
    function Erro: string;
  end;

constructor TExecucaoInterface.Create;
begin
  inherited Create;
  //Manual reset: quem espera só precisa saber que terminou
  FEvento := TEvent.Create(nil, True, False, '');
end;

destructor TExecucaoInterface.Destroy;
begin
  FEvento.Free;
  inherited;
end;

procedure TExecucaoInterface.Executa(const rotina: TProc);
begin
  try
    rotina();
  except
    on E: Exception do
      //A exceção não pode escapar aqui: ela estouraria na thread da
      //interface e viraria um diálogo de erro na cara do operador por
      //causa de uma requisição HTTP. É levada de volta a quem pediu.
      FErro := E.ClassName + ': ' + E.Message;
  end;
  FEvento.SetEvent;
end;

function TExecucaoInterface.Espera(timeoutMs: Integer): Boolean;
begin
  Result := (FEvento.WaitFor(timeoutMs) = wrSignaled);
end;

function TExecucaoInterface.Erro: string;
begin
  Result := FErro;
end;

{
  Executa a rotina na thread da interface e espera pelo fim.

  O handler do Indy roda numa thread por conexão. Ler ou escrever componente
  visual dali é acesso concorrente à VCL - a causa de travamentos e violações
  de memória difíceis de reproduzir. Na v2, todo acesso a componente visual e
  ao banco passa por aqui.

  Devolve False quando o prazo estourou, e nesse caso a rotina ainda pode vir
  a rodar depois. Ou seja: em comando, prazo estourado não significa que nada
  aconteceu, significa que não deu para confirmar a tempo.
}
function TfTransmitir.executaNaInterface(const rotina: TProc;
  timeoutMs: Integer): Boolean;
var
  execucao: IExecucaoInterface;
begin
  //Se já estamos na thread da interface, enfileirar e esperar por nós
  //mesmos travaria para sempre
  if (TThread.CurrentThread.ThreadID = MainThreadID) then
  begin
    rotina();
    Exit(True);
  end;

  execucao := TExecucaoInterface.Create;

  TThread.Queue(nil,
    procedure
    begin
      execucao.Executa(rotina);
    end);

  Result := execucao.Espera(timeoutMs);

  //Falha dentro da interface volta como exceção aqui, para o endpoint
  //responder erro em vez de fingir que deu certo
  if Result and (execucao.Erro <> '') then
    raise Exception.Create(execucao.Erro);
end;

{
  Escapa tudo que o JSON exige.

  Na v1 só as aspas eram tratadas, e só em alguns pontos. Uma barra invertida
  ou um caractere de controle vindo do banco ou da letra da música produzia
  JSON inválido, e o cliente recebia erro de interpretação em vez dos dados.
}
function TfTransmitir.escapaJson(const txt: string): string;
var
  i: Integer;
  c: Char;
begin
  Result := '';
  for i := 1 to Length(txt) do
  begin
    c := txt[i];
    case c of
      '"':  Result := Result + '\"';
      '\':  Result := Result + '\\';
      #8:   Result := Result + '\b';
      #9:   Result := Result + '\t';
      #10:  Result := Result + '\n';
      #12:  Result := Result + '\f';
      #13:  Result := Result + '\r';
    else
      if (c < #32) then
        Result := Result + '\u' + LowerCase(IntToHex(Ord(c), 4))
      else
        Result := Result + c;
    end;
  end;
end;

{
  Resposta de sucesso.

  "code" está sempre presente e é o contrato estável: é por ele que o cliente
  decide, nunca pelo texto de "message", que é só para humano e pode ser
  traduzido ou reescrito. "dados" entra como trecho de JSON já pronto, com os
  campos nomeados do endpoint.
}
procedure TfTransmitir.respondeV2Ok(AResponseInfo: TIdHTTPResponseInfo;
  const acao, codigo, mensagem, dados: string);
var
  json: string;
begin
  json := '{"status":"ok"' +
          ',"action":"' + escapaJson(acao) + '"' +
          ',"code":"' + escapaJson(codigo) + '"';

  if (mensagem <> '') then
    json := json + ',"message":"' + escapaJson(mensagem) + '"';

  if (dados <> '') then
    json := json + ',' + dados;

  AResponseInfo.ResponseNo := 200;
  AResponseInfo.ContentText := json + '}';
end;

{
  Resposta de erro.

  O código HTTP acompanha o significado: 400 erro do cliente, 401 token,
  404 rota inexistente, 409 o estado do programa impede, 500 falha interna,
  503 interface ocupada.
}
procedure TfTransmitir.respondeV2Erro(AResponseInfo: TIdHTTPResponseInfo;
  codigoHttp: Integer; const acao, codigo, mensagem: string);
begin
  AResponseInfo.ResponseNo := codigoHttp;
  AResponseInfo.ContentText :=
    '{"status":"error"' +
    ',"action":"' + escapaJson(acao) + '"' +
    ',"code":"' + escapaJson(codigo) + '"' +
    ',"message":"' + escapaJson(mensagem) + '"}';
end;

{
  Identifica requisição vinda de uma página servida pelo próprio programa,
  que é o caso que dispensa token.

  São duas condições, e cada uma cobre um caso:

  - Conexão da própria máquina: o cabeçalho Origin só é confiável quando quem
    monta a requisição é um navegador. Um script escreve nele o que quiser,
    então pela rede o Origin não vale como prova e o token continua exigido.

  - Origin ausente ou igual à origem do servidor: numa requisição de mesma
    origem o navegador omite o Origin ou manda a origem do próprio servidor.
    Uma página de terceiro aberta no navegador do operador sempre manda a
    origem dela, e a página não consegue mentir nisso. É o que separa
    "página do programa" de "qualquer página aberta na máquina".
}
function TfTransmitir.v2PaginaInterna(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo): Boolean;
var
  origem: string;
begin
  //Binding.IP é o endereço do lado do servidor, que o cliente não escolhe
  if (AContext.Binding.IP <> '127.0.0.1') then
    Exit(False);

  origem := Trim(ARequestInfo.RawHeaders.Values['Origin']);
  if (origem = '') then
    Exit(True);

  Result := SameText(origem, 'http://' + ARequestInfo.Host);
end;

{
  Confere o token, aceito no cabeçalho Authorization ou na URL.

  O cabeçalho é a forma preferida: na URL o token vai parar no histórico do
  navegador, em log de servidor e no cabeçalho Referer enviado a terceiros.

  lerParam pode ser chamado desta thread: ele cria um TIniFile local e lê pela
  API do Windows, que é segura entre threads.
}
function TfTransmitir.v2TokenValido(ARequestInfo: TIdHTTPRequestInfo): Boolean;
var
  informado, esperado, autorizacao: string;
begin
  autorizacao := Trim(ARequestInfo.RawHeaders.Values['Authorization']);

  if StartsText('Bearer ', autorizacao) then
    informado := Trim(Copy(autorizacao, Length('Bearer ') + 1, MaxInt))
  else
    informado := Trim(v2Param(ARequestInfo, 'token'));

  esperado := Trim(fmIndex.lerParam('Servidor', 'Token', ''));

  //Sem token configurado não há como autenticar: o acesso pela rede fica
  //fechado, em vez de liberado para qualquer um
  Result := (esperado <> '') and (informado = esperado);
end;

{
  Lê um parâmetro da URL decodificando em UTF-8.

  Não dá para usar ARequestInfo.Params aqui. O Indy decodifica a query string
  com o charset do Content-Type (DecodeAndSetParams, em IdCustomHTTPServer),
  e numa requisição GET não existe Content-Type - o charset fica vazio e ele
  cai no padrão de 8 bits.

  Como todo navegador percent-encoda em UTF-8, o resultado é que qualquer
  termo acentuado chegava corrompido: buscar "coração" não encontrava nada,
  enquanto "coracao" encontrava 21 músicas. Vale para a v1 também.
}
function TfTransmitir.v2Param(ARequestInfo: TIdHTTPRequestInfo;
  const nome: string): string;
var
  bruto, item, chave: string;
  i, ini, p: Integer;
begin
  bruto := ARequestInfo.QueryParams;

  ini := 1;
  i := 1;
  while (i <= Length(bruto) + 1) do
  begin
    if (i > Length(bruto)) or (bruto[i] = '&') then
    begin
      item := Copy(bruto, ini, i - ini);
      p := Pos('=', item);

      if (p > 0) then
      begin
        chave := Trim(Copy(item, 1, p - 1));
        if SameText(chave, nome) then
        begin
          item := Copy(item, p + 1, MaxInt);
          //Formulário codifica espaço como '+' (RFC 1866)
          item := StringReplace(item, '+', ' ', [rfReplaceAll]);
          Exit(TIdURI.URLDecode(item, IndyTextEncoding_UTF8));
        end;
      end;

      ini := i + 1;
    end;
    Inc(i);
  end;

  //Não veio na URL: pode ter vindo no corpo de um POST, que o Indy já
  //decodifica com o charset declarado no Content-Type
  Result := ARequestInfo.Params.Values[nome];
end;

//Ação pedida, normalizada. Na v1 a comparação era exata: 'Start' ou
//'start ' não eram reconhecidos.
function TfTransmitir.v2Acao(ARequestInfo: TIdHTTPRequestInfo): string;
begin
  Result := LowerCase(Trim(v2Param(ARequestInfo, 'action')));
end;

{
  Leitura é GET, comando é POST.

  Não é firula de estilo: um GET é tratado por navegadores, prefetchers e
  prévias de link como requisição sem efeito, e pode ser repetido sozinho.
  Na v1 tudo era GET, inclusive sortear, apagar e trocar de slide.
}
function TfTransmitir.v2ExigeMetodo(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao, metodo: string): Boolean;
begin
  Result := SameText(Trim(ARequestInfo.Command), metodo);
  if not Result then
    respondeV2Erro(AResponseInfo, 405, acao, 'METHOD_NOT_ALLOWED',
      IfThen(SameText(metodo, 'GET'),
        'Esta ação é de leitura e aceita apenas GET',
        'Esta ação altera o programa e exige POST'));
end;

//A interface não respondeu no prazo. Pode estar com um diálogo modal aberto
//esperando o operador - por exemplo o aviso de "não há itens para sortear".
procedure TfTransmitir.respondeV2Ocupado(AResponseInfo: TIdHTTPResponseInfo;
  const acao: string);
begin
  respondeV2Erro(AResponseInfo, 503, acao, 'UI_BUSY',
    'O programa não respondeu no prazo. Pode haver uma janela aberta ' +
    'aguardando o operador.');
end;

procedure TfTransmitir.respondeV2AcaoInvalida(AResponseInfo: TIdHTTPResponseInfo;
  const acao, aceitas: string);
begin
  respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_ACTION',
    'Parâmetro action ausente ou não reconhecido. Aceitos: ' + aceitas);
end;

{
  Hora do computador onde o LouvorJA está rodando.

  Não passa pela thread da interface: não toca em componente visual.
}
procedure TfTransmitir.v2Clock(AResponseInfo: TIdHTTPResponseInfo;
  const acao: string);
var
  agora: TDateTime;
begin
  agora := Now;
  respondeV2Ok(AResponseInfo, acao, 'CLOCK', '',
    '"date":"' + FormatDateTime('yyyy-mm-dd', agora) + '"' +
    ',"time":"' + FormatDateTime('hh:nn:ss', agora) + '"' +
    ',"datetime":"' + FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', agora) + '"');
end;

{
  Estado da música em exibição e texto dos slides.

  Tudo que é lido aqui é componente visual, então a leitura inteira acontece
  dentro da thread da interface e só depois o JSON é montado.
}
procedure TfTransmitir.v2SongSlides(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  acaoPedida, qualSlide: string;
  tocando: Boolean;
  slideAtual, slideProximo: string;
  totalSlides: Integer;
begin
  acaoPedida := v2Acao(ARequestInfo);

  //Comandos: alteram a exibição, então exigem POST
  if (acaoPedida = 'next') or (acaoPedida = 'previous') or (acaoPedida = 'close') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
      Exit;

    tocando := False;

    if not executaNaInterface(
      procedure
      begin
        tocando := (fMusica <> nil) and (fMusica.Visible);
        if not tocando then
          Exit;

        if (acaoPedida = 'next') then
          fMusica.acaoSlide('prox')
        else if (acaoPedida = 'previous') then
          fMusica.acaoSlide('ant')
        else
          fMusica.Close;
      end, TIMEOUT_COMANDO) then
    begin
      respondeV2Ocupado(AResponseInfo, acao);
      Exit;
    end;

    //Pedir para avançar sem música aberta é conflito de estado, não erro de
    //requisição. A v1 devolvia 200 aqui, o que fazia o comando parecer ter
    //funcionado.
    if not tocando then
    begin
      respondeV2Erro(AResponseInfo, 409, acao, 'NO_SONG_PLAYING',
        'Nenhuma música em exibição');
      Exit;
    end;

    if (acaoPedida = 'next') then
      respondeV2Ok(AResponseInfo, acao, 'SLIDE_ADVANCED', 'Avançou um slide', '')
    else if (acaoPedida = 'previous') then
      respondeV2Ok(AResponseInfo, acao, 'SLIDE_REVERTED', 'Voltou um slide', '')
    else
      respondeV2Ok(AResponseInfo, acao, 'SONG_CLOSED', 'Música fechada', '');
    Exit;
  end;

  if (acaoPedida <> 'status') and (acaoPedida <> 'slide') then
  begin
    respondeV2AcaoInvalida(AResponseInfo, acao,
      'status, slide (GET); next, previous, close (POST)');
    Exit;
  end;

  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
    Exit;

  qualSlide := LowerCase(Trim(v2Param(ARequestInfo, 'slide')));
  if (qualSlide = '') then
    qualSlide := 'current';

  //Parâmetro inválido é erro do cliente e é recusado antes de olhar o estado
  //do programa: senão, com nenhuma música aberta, um valor errado passaria
  //despercebido e só apareceria quando houvesse música em exibição
  if (acaoPedida = 'slide') and (qualSlide <> 'current') and (qualSlide <> 'next') then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_SLIDE',
      'Parâmetro slide deve ser current ou next');
    Exit;
  end;

  tocando := False;
  slideAtual := '';
  slideProximo := '';
  totalSlides := 0;

  if not executaNaInterface(
    procedure
    begin
      tocando := (fMusica <> nil) and (fMusica.Visible);
      if not tocando then
        Exit;

      slideAtual := fMusica.lblLetra.Caption;
      totalSlides := fMusica.lbLetras.Items.Count;

      //nslide aponta para o próximo da lista
      if (fMusica.lbLetras.Items.Count > fMusica.nslide) then
        slideProximo := fMusica.lbLetras.Items[fMusica.nslide]
      else
        slideProximo := '';
    end, TIMEOUT_INTERFACE) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  if not tocando then
  begin
    respondeV2Ok(AResponseInfo, acao, 'NO_SONG_PLAYING',
      'Nenhuma música em exibição', '"playing":false');
    Exit;
  end;

  if (acaoPedida = 'status') then
  begin
    respondeV2Ok(AResponseInfo, acao, 'SONG_PLAYING', '',
      '"playing":true' +
      ',"slide_count":' + IntToStr(totalSlides) +
      ',"has_next":' + IfThen(slideProximo <> '', 'true', 'false'));
    Exit;
  end;

  //action=slide: o texto pedido vai em campo próprio. Na v1 ele vinha em
  //"message", misturado com as frases destinadas a humano.
  if (qualSlide = 'next') then
    respondeV2Ok(AResponseInfo, acao, 'SONG_PLAYING', '',
      '"playing":true,"slide":"' + escapaJson(slideProximo) + '"' +
      ',"which":"next","is_last":' + IfThen(slideProximo = '', 'true', 'false'))
  else
    respondeV2Ok(AResponseInfo, acao, 'SONG_PLAYING', '',
      '"playing":true,"slide":"' + escapaJson(slideAtual) + '","which":"current"');
end;

{
  Estado do cronômetro.

  O estado vem de DM.tmrCrono.Enabled, que é quem de fato determina se o
  cronômetro anda. A legenda do botão reflete o mesmo estado, mas é texto de
  apresentação: derivar decisão dela amarra a API a um detalhe de interface.
}
procedure TfTransmitir.v2Stopwatch(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  acaoPedida: string;
  rodando: Boolean;
  tempo, modo, alvo, voltas: string;
begin
  acaoPedida := v2Acao(ARequestInfo);

  //stop e note são os nomes da v1, mantidos como apelidos
  if (acaoPedida = 'stop') then
    acaoPedida := 'reset';
  if (acaoPedida = 'note') then
    acaoPedida := 'lap';

  if (acaoPedida = 'set-mode') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
      Exit;
    v2StopwatchModo(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if (acaoPedida = 'start') or (acaoPedida = 'pause') or
     (acaoPedida = 'reset') or (acaoPedida = 'lap') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
      Exit;
    v2StopwatchComando(AResponseInfo, acao, acaoPedida);
    Exit;
  end;

  if (acaoPedida <> 'status') then
  begin
    respondeV2AcaoInvalida(AResponseInfo, acao,
      'status (GET); start, pause, reset, lap, set-mode (POST)');
    Exit;
  end;

  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
    Exit;

  rodando := False;
  tempo := '';
  modo := '';
  alvo := '';
  voltas := '';

  if not executaNaInterface(
    procedure
    var
      //Variável capturada não pode ser controle de for: precisa ser local
      //deste bloco
      i: Integer;
    begin
      rodando := DM.tmrCrono.Enabled;
      tempo := fmIndex.lmdCrono.Caption;

      if (fmIndex.rbDirecao.ItemIndex = 0) then
        modo := 'countup'
      else
      begin
        modo := 'countdown';
        alvo := fmIndex.txtDecr.Text;
      end;

      for i := 0 to fmIndex.lbCrono.Items.Count - 1 do
      begin
        if (voltas <> '') then
          voltas := voltas + ',';
        voltas := voltas + '"' + escapaJson(fmIndex.lbCrono.Items[i].Caption) + '"';
      end;
    end, TIMEOUT_INTERFACE) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  respondeV2Ok(AResponseInfo, acao,
    IfThen(rodando, 'STOPWATCH_RUNNING', 'STOPWATCH_STOPPED'), '',
    '"running":' + IfThen(rodando, 'true', 'false') +
    ',"time":"' + escapaJson(tempo) + '"' +
    ',"mode":"' + modo + '"' +
    IfThen(alvo <> '', ',"target":"' + escapaJson(alvo) + '"', '') +
    ',"laps":[' + voltas + ']');
end;

{
  Troca entre progressivo e regressivo e, no regressivo, define o tempo.

  O tempo é validado aqui, antes de chegar ao campo da tela. O txtDecrExit do
  programa, diante de um valor inválido, abre uma caixa de mensagem modal -
  que travaria a interface esperando o operador, por causa de uma requisição.

  Zerar faz parte da troca: é o que o programa faz quando o operador muda o
  modo pelo próprio botão.
}
procedure TfTransmitir.v2StopwatchModo(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  modo, alvo, tempo: string;
  hora: TDateTime;
  regressivo, rodando: Boolean;
begin
  modo := LowerCase(Trim(v2Param(ARequestInfo, 'mode')));
  alvo := Trim(v2Param(ARequestInfo, 'target'));

  if (modo <> 'countup') and (modo <> 'countdown') then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_MODE',
      'Parâmetro mode deve ser countup ou countdown');
    Exit;
  end;

  regressivo := (modo = 'countdown');

  if regressivo then
  begin
    if (alvo = '') then
    begin
      respondeV2Erro(AResponseInfo, 400, acao, 'MISSING_TARGET',
        'No modo countdown informe o tempo em target, no formato hh:mm:ss');
      Exit;
    end;

    //Espaço vira zero, como o campo mascarado da tela faz
    alvo := StringReplace(alvo, ' ', '0', [rfReplaceAll]);

    if not TryStrToTime(alvo, hora) then
    begin
      respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_TARGET',
        'Tempo inválido em target. Use o formato hh:mm:ss, por exemplo 00:05:00');
      Exit;
    end;

    if (hora <= 0) then
    begin
      respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_TARGET',
        'O tempo em target precisa ser maior que zero');
      Exit;
    end;
  end;

  rodando := False;
  tempo := '';

  if not executaNaInterface(
    procedure
    begin
      if (fmIndex.cbFormatoTempoCrono.ItemIndex < 0) then
        fmIndex.carregaConfiguracoes('CRONO');

      if regressivo then
        fmIndex.rbDirecao.ItemIndex := 1
      else
        fmIndex.rbDirecao.ItemIndex := 0;

      fmIndex.txtDecr.Enabled := regressivo;

      if regressivo then
      begin
        fmIndex.txtDecr.Text := alvo;
        fmIndex.gravaParam('Cronometro', 'Tempo Decrescente', alvo);
      end;

      fmIndex.gravaParam('Cronometro', 'Direcao',
        IntToStr(fmIndex.rbDirecao.ItemIndex));

      //Zera para a troca valer já na próxima largada. Também é o que
      //acontece quando o operador troca o modo pela tela.
      if fmIndex.btZerarCrono.Enabled then
        fmIndex.btZerarCronoClick(fmIndex.btZerarCrono);

      rodando := DM.tmrCrono.Enabled;
      tempo := fmIndex.lmdCrono.Caption;
    end, TIMEOUT_COMANDO) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  respondeV2Ok(AResponseInfo, acao, 'STOPWATCH_MODE_SET', '',
    '"running":' + IfThen(rodando, 'true', 'false') +
    ',"mode":"' + modo + '"' +
    ',"time":"' + escapaJson(tempo) + '"' +
    IfThen(regressivo, ',"target":"' + escapaJson(alvo) + '"', ''));
end;

{
  Comandos do cronômetro.

  As ações são idempotentes: repetir "start" mantém andando em vez de
  alternar. O botão da tela é um alternador - o mesmo botão vira "Pausar"
  depois de iniciado -, então na v1 chamar start duas vezes pausava sem que
  o cliente tivesse pedido isso. Aqui o estado real é consultado antes.
}
procedure TfTransmitir.v2StopwatchComando(AResponseInfo: TIdHTTPResponseInfo;
  const acao, acaoPedida: string);
var
  rodandoAntes, habilitado, agiu: Boolean;
  tempo, ultimaVolta: string;
begin
  rodandoAntes := False;
  habilitado := True;
  agiu := False;
  tempo := '';
  ultimaVolta := '';

  if not executaNaInterface(
    procedure
    begin
      //A página do cronômetro só é inicializada quando o operador a abre:
      //antes disso a lista de formatos de tempo está vazia e o ItemIndex é
      //-1, e o timer estoura ao formatar a legenda. Comandar pela API não
      //pode depender de alguém ter aberto a aba antes, então a mesma rotina
      //que o programa usa é chamada aqui quando ainda não rodou.
      if (fmIndex.cbFormatoTempoCrono.ItemIndex < 0) then
        fmIndex.carregaConfiguracoes('CRONO');

      rodandoAntes := DM.tmrCrono.Enabled;

      if (acaoPedida = 'start') or (acaoPedida = 'pause') then
      begin
        //O botão fica desabilitado quando o tempo regressivo digitado é
        //inválido; clicar nele não faria nada e a resposta mentiria
        habilitado := fmIndex.btIniciarCrono.Enabled;
        if not habilitado then
          Exit;

        //Só clica se o estado atual for diferente do pedido
        if (acaoPedida = 'start') and (not rodandoAntes) then
        begin
          fmIndex.btIniciarCronoClick(fmIndex.btIniciarCrono);
          agiu := True;
        end
        else if (acaoPedida = 'pause') and rodandoAntes then
        begin
          fmIndex.btIniciarCronoClick(fmIndex.btIniciarCrono);
          agiu := True;
        end;
      end
      else if (acaoPedida = 'reset') then
      begin
        habilitado := fmIndex.btZerarCrono.Enabled;
        if not habilitado then
          Exit;
        fmIndex.btZerarCronoClick(fmIndex.btZerarCrono);
        agiu := True;
      end
      else if (acaoPedida = 'lap') then
      begin
        habilitado := fmIndex.btAnotTempo.Enabled;
        if not habilitado then
          Exit;
        fmIndex.btAnotTempoClick(fmIndex.btAnotTempo);
        agiu := True;
        if (fmIndex.lbCrono.Items.Count > 0) then
          ultimaVolta :=
            fmIndex.lbCrono.Items[fmIndex.lbCrono.Items.Count - 1].Caption;
      end;

      tempo := fmIndex.lmdCrono.Caption;
    end, TIMEOUT_COMANDO) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  if not habilitado then
  begin
    respondeV2Erro(AResponseInfo, 409, acao, 'CONTROL_DISABLED',
      'O controle correspondente está desabilitado no programa. ' +
      'No modo regressivo isso costuma indicar tempo inválido.');
    Exit;
  end;

  if (acaoPedida = 'lap') then
  begin
    respondeV2Ok(AResponseInfo, acao, 'LAP_ADDED', '',
      '"time":"' + escapaJson(tempo) + '"' +
      ',"lap":"' + escapaJson(ultimaVolta) + '"');
    Exit;
  end;

  if (acaoPedida = 'reset') then
  begin
    respondeV2Ok(AResponseInfo, acao, 'STOPWATCH_RESET', '',
      '"running":false,"time":"' + escapaJson(tempo) + '"');
    Exit;
  end;

  //Já estar no estado pedido não é erro: o pedido foi atendido de todo jeito
  if (acaoPedida = 'start') then
    respondeV2Ok(AResponseInfo, acao,
      IfThen(agiu, 'STOPWATCH_STARTED', 'STOPWATCH_ALREADY_RUNNING'), '',
      '"running":true,"time":"' + escapaJson(tempo) + '"')
  else
    respondeV2Ok(AResponseInfo, acao,
      IfThen(agiu, 'STOPWATCH_PAUSED', 'STOPWATCH_ALREADY_PAUSED'), '',
      '"running":false,"time":"' + escapaJson(tempo) + '"');
end;

{
  Estado do sorteio e lista de participantes.

  Aqui some o Sleep da v1: em vez de prender a thread do Indy por até 3
  segundos esperando o botão habilitar, o estado do sorteio é exposto em
  "drawing" e o cliente decide se consulta de novo.
}
procedure TfTransmitir.v2DrawingNumber(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  acaoPedida: string;
  sorteando: Boolean;
  ultimo, participantes, sorteados: string;
  totalParticipantes: Integer;
begin
  acaoPedida := v2Acao(ARequestInfo);

  if (acaoPedida = 'draw') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
      Exit;
    v2Draw(AResponseInfo, acao);
    Exit;
  end;

  if (acaoPedida <> 'status') and (acaoPedida <> 'participants') then
  begin
    respondeV2AcaoInvalida(AResponseInfo, acao,
      'status, participants (GET); draw (POST)');
    Exit;
  end;

  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
    Exit;

  sorteando := False;
  ultimo := '';
  participantes := '';
  sorteados := '';
  totalParticipantes := 0;

  if not executaNaInterface(
    procedure
    var
      i: Integer;
    begin
      //tmrSortear roda durante a animação do sorteio e se desliga sozinho
      //ao final, quando o número sai
      sorteando := DM.tmrSortear.Enabled;
      ultimo := fmIndex.lmdSorteio.Caption;
      totalParticipantes := fmIndex.lbSorteio.Items.Count;

      if (acaoPedida = 'participants') then
        for i := 0 to fmIndex.lbSorteio.Items.Count - 1 do
        begin
          if (participantes <> '') then
            participantes := participantes + ',';
          participantes := participantes +
            '"' + escapaJson(fmIndex.lbSorteio.Items[i].Caption) + '"';
        end;

      for i := 0 to fmIndex.lbSorteado.Items.Count - 1 do
      begin
        if (sorteados <> '') then
          sorteados := sorteados + ',';
        sorteados := sorteados +
          '"' + escapaJson(fmIndex.lbSorteado.Items[i].Caption) + '"';
      end;
    end, TIMEOUT_INTERFACE) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  if (acaoPedida = 'participants') then
  begin
    //Lista de verdade. Na v1 os nomes vinham grudados num único texto
    //separado por vírgula, o que quebra em nome que contenha vírgula.
    respondeV2Ok(AResponseInfo, acao, 'PARTICIPANTS', '',
      '"count":' + IntToStr(totalParticipantes) +
      ',"participants":[' + participantes + ']');
    Exit;
  end;

  respondeV2Ok(AResponseInfo, acao,
    IfThen(sorteando, 'DRAWING_IN_PROGRESS', 'DRAWING_IDLE'), '',
    '"drawing":' + IfThen(sorteando, 'true', 'false') +
    ',"last":"' + escapaJson(ultimo) + '"' +
    ',"count":' + IntToStr(totalParticipantes) +
    ',"drawn":[' + sorteados + ']');
end;

{
  Dispara um sorteio.

  Os dois impedimentos são checados antes de clicar no botão porque o
  btSortearClick, sem itens para sortear, abre uma caixa de mensagem modal.
  Ela travaria a interface esperando o operador, e a requisição só sairia
  daqui por prazo esgotado.
}
procedure TfTransmitir.v2Draw(AResponseInfo: TIdHTTPResponseInfo;
  const acao: string);
var
  jaSorteando, semParticipantes, habilitado: Boolean;
begin
  jaSorteando := False;
  semParticipantes := False;
  habilitado := True;

  if not executaNaInterface(
    procedure
    begin
      //tmrSortear liga durante a animação e se desliga ao final
      jaSorteando := DM.tmrSortear.Enabled;
      if jaSorteando then
        Exit;

      //A faixa inicial/final também alimenta a lista, então lista vazia só
      //impede de fato quando os dois campos de faixa estão vazios
      semParticipantes := (fmIndex.lbSorteio.Items.Count = 0) and
                          (Trim(fmIndex.opSort_Ini.Text) = '') and
                          (Trim(fmIndex.opSort_Fin.Text) = '');
      if semParticipantes then
        Exit;

      habilitado := fmIndex.btSortear.Enabled;
      if not habilitado then
        Exit;

      fmIndex.btSortearClick(fmIndex.btSortear);
    end, TIMEOUT_COMANDO) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  if jaSorteando then
  begin
    respondeV2Erro(AResponseInfo, 409, acao, 'DRAWING_IN_PROGRESS',
      'Já há um sorteio em andamento');
    Exit;
  end;

  if semParticipantes then
  begin
    respondeV2Erro(AResponseInfo, 409, acao, 'EMPTY_PARTICIPANTS',
      'Nenhum participante adicionado ao sorteio');
    Exit;
  end;

  if not habilitado then
  begin
    respondeV2Erro(AResponseInfo, 409, acao, 'CONTROL_DISABLED',
      'O botão de sortear está desabilitado no programa');
    Exit;
  end;

  //O número só existe quando a animação termina. Quem quiser o resultado
  //consulta action=status até "drawing" ficar false - era para isso que a
  //v1 tinha um Sleep de até 3 segundos aqui dentro.
  respondeV2Ok(AResponseInfo, acao, 'DRAWING_STARTED',
    'Sorteio iniciado. Consulte action=status até drawing ficar false.',
    '"drawing":true');
end;

{
  Simula o pressionamento de uma tecla.

  A janela precisa estar em primeiro plano para receber a tecla, por isso o
  SetForegroundWindow antes - mesmo comportamento da v1.
}
procedure TfTransmitir.v2Keyboard(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  tecla: Integer;
begin
  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
    Exit;

  tecla := StrToIntDef(Trim(v2Param(ARequestInfo, 'key')), -1);

  //Códigos virtuais válidos vão de 1 a 254
  if (tecla < 1) or (tecla > 254) then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_KEY',
      'Informe em key um código de tecla entre 1 e 254');
    Exit;
  end;

  if not executaNaInterface(
    procedure
    begin
      if (fMusica <> nil) and fMusica.Visible and fMusica.HandleAllocated then
        SetForegroundWindow(fMusica.Handle)
      else if (fmIndex <> nil) and fmIndex.HandleAllocated then
        SetForegroundWindow(fmIndex.Handle);

      keybd_event(tecla, 0, 0, 0);
      keybd_event(tecla, 0, KEYEVENTF_KEYUP, 0);
    end, TIMEOUT_COMANDO) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  respondeV2Ok(AResponseInfo, acao, 'KEY_SENT', '',
    '"key":' + IntToStr(tecla));
end;

{
  Abre uma música pelo ID.

  O parâmetro "modo" substitui o "tag" numérico da v1, que era 1, 2 ou 3 sem
  nada no código nem na resposta explicando o que cada número fazia.
}
procedure TfTransmitir.v2OpenSong(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  idMusica: Integer;
  modo, txtModo: string;
  tocarAudio: Boolean;
begin
  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'POST') then
    Exit;

  idMusica := StrToIntDef(Trim(v2Param(ARequestInfo, 'id')), 0);
  if (idMusica <= 0) then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_ID',
      'Informe em id o código da música, obtido em /api/v2/search-songs');
    Exit;
  end;

  modo := LowerCase(Trim(v2Param(ARequestInfo, 'modo')));
  if (modo = '') then
    modo := 'normal';

  txtModo := '';
  tocarAudio := True;

  if (modo = 'pb') then
    txtModo := 'PB'
  else if (modo = 'sem-audio') then
    tocarAudio := False
  else if (modo <> 'normal') then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'INVALID_MODE',
      'Parâmetro modo deve ser normal, pb ou sem-audio');
    Exit;
  end;

  if not executaNaInterface(
    procedure
    begin
      if Assigned(fmIndex) then
        fmIndex.abreLetraMusica('BD', txtModo, idMusica, tocarAudio);
    end, TIMEOUT_COMANDO) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  respondeV2Ok(AResponseInfo, acao, 'SONG_OPENED', '',
    '"id":' + IntToStr(idMusica) + ',"modo":"' + modo + '"');
end;

{
  Busca de músicas.

  A v1 usava o qrBUSCA do formulário, um único TFDQuery compartilhado por
  todas as requisições: duas buscas ao mesmo tempo e uma fecha a consulta
  enquanto a outra percorre os registros. Aqui a consulta é criada por
  requisição e roda dentro da thread da interface, sobre a mesma conexão que
  o resto do programa usa - sem conexão nova e sem concorrência.
}
procedure TfTransmitir.v2SearchSongs(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const acao: string);
var
  termo, musicas: string;
  total: Integer;
begin
  if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
    Exit;

  termo := Trim(v2Param(ARequestInfo, 'q'));
  if (termo = '') then
  begin
    respondeV2Erro(AResponseInfo, 400, acao, 'MISSING_SEARCH_TERM',
      'Informe o termo de busca no parâmetro q');
    Exit;
  end;

  musicas := '';
  total := 0;

  if not executaNaInterface(
    procedure
    var
      consulta: TFDQuery;
    begin
      consulta := TFDQuery.Create(nil);
      try
        consulta.Connection := DM.ADO;
        consulta.SQL.Text := qrBUSCA.SQL.Text;
        consulta.ParamByName('VALOR').AsString := fmIndex.termo_busca(termo);
        consulta.Open;

        while not consulta.Eof do
        begin
          if (musicas <> '') then
            musicas := musicas + ',';

          musicas := musicas +
            '{"id":' + consulta.FieldByName('ID').AsString +
            ',"nome":"' + escapaJson(consulta.FieldByName('NOME').AsString) + '"' +
            ',"album":"' + escapaJson(consulta.FieldByName('NOME_ALBUM_COM').AsString) + '"}';

          Inc(total);
          consulta.Next;
        end;
      finally
        consulta.Free;
      end;
    end, TIMEOUT_INTERFACE) then
  begin
    respondeV2Ocupado(AResponseInfo, acao);
    Exit;
  end;

  //O campo continua se chamando "musicas", como na v1, para que migrar o
  //controle remoto para a v2 não exija reescrever quem lê a lista
  respondeV2Ok(AResponseInfo, acao,
    IfThen(total > 0, 'SONGS_FOUND', 'NO_SONGS_FOUND'), '',
    '"count":' + IntToStr(total) + ',"musicas":[' + musicas + ']');
end;

{
  O Indy só entrega GET, POST e HEAD ao OnCommandGet. Os demais verbos caem
  aqui - entre eles o OPTIONS, que o navegador manda antes de uma requisição
  com cabeçalho Authorization ou com método POST.

  Sem isto o preflight nunca chegava ao roteador da v2 e o navegador
  desistia da requisição seguinte.
}
procedure TfTransmitir.IdHTTPServer1CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  //Fora da v2, nada muda: o verbo segue sem tratamento, como antes
  trataApiV2(AContext, ARequestInfo, AResponseInfo);
end;

{
  O Indy interpreta o cabeçalho Authorization por conta própria e, diante de
  um esquema que não conhece, levanta EIdHTTPUnsupportedAuthorisationScheme e
  derruba a conexão - o cliente nem chega a receber resposta.

  Como o esquema Bearer não é um dos que ele trata, é preciso declarar aqui
  que a autenticação já está resolvida. Quem lê e confere o token é a v2, em
  v2TokenValido, direto do cabeçalho bruto.
}
procedure TfTransmitir.IdHTTPServer1ParseAuthentication(AContext: TIdContext;
  const AAuthType, AAuthData: String; var VUsername, VPassword: String;
  var VHandled: Boolean);
begin
  if SameText(Trim(AAuthType), 'Bearer') then
    VHandled := True;
end;

{
  Roteamento da v2.

  Devolve True quando a requisição era da v2 e já foi respondida - nesse caso
  o handler principal encerra e a v1 nem chega a ser consultada.
}
function TfTransmitir.trataApiV2(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo): Boolean;
var
  rota, acao, metodo: string;
begin
  Result := False;

  rota := Trim(ARequestInfo.Document);
  //Barra final não muda a rota: /api/v2/ping/ e /api/v2/ping são a mesma
  while (Length(rota) > 1) and rota.EndsWith('/') do
    Delete(rota, Length(rota), 1);

  //Comparação por segmento: /api/v2x não pertence à v2. A v1 usava
  //Pos('/api', arq) = 1, que aceita /apiary como rota de API.
  if not (SameText(rota, ROTA_V2) or StartsText(ROTA_V2 + '/', rota)) then
    Exit;

  Result := True;

  //Nome curto da rota, usado no campo "action" da resposta
  acao := Copy(rota, Length(ROTA_V2) + 2, MaxInt);

  AResponseInfo.ContentType := 'application/json';
  AResponseInfo.CharSet := 'utf-8';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, POST, OPTIONS';
  AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Headers'] := 'Authorization, Content-Type';
  AResponseInfo.CustomHeaders.Values['Access-Control-Max-Age'] := '600';

  metodo := UpperCase(Trim(ARequestInfo.Command));

  //Preflight: o navegador só quer saber o que é permitido. Nada é executado,
  //e responder antes da autenticação é proposital - o preflight não carrega
  //token nem cookie.
  if (metodo = 'OPTIONS') then
  begin
    AResponseInfo.ResponseNo := 204;
    AResponseInfo.ContentText := '';
    Exit;
  end;

  if (not v2PaginaInterna(AContext, ARequestInfo)) and
     (not v2TokenValido(ARequestInfo)) then
  begin
    respondeV2Erro(AResponseInfo, 401, acao, 'INVALID_TOKEN',
      'Token ausente ou inválido');
    Exit;
  end;

  // ---------------------------------------------------------------
  // Rotas
  // ---------------------------------------------------------------

  //Falha inesperada vira 500 em JSON, com a mensagem. Sem isto o Indy
  //devolve 500 com corpo vazio e não há como saber o que aconteceu.
  try
    v2Despacha(ARequestInfo, AResponseInfo, rota, acao);
  except
    on E: Exception do
      respondeV2Erro(AResponseInfo, 500, acao, 'INTERNAL_ERROR',
        E.ClassName + ': ' + E.Message);
  end;
end;

procedure TfTransmitir.v2Despacha(ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo; const rota, acao: string);
begin
  if SameText(rota, ROTA_V2 + '/ping') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
      Exit;
    respondeV2Ok(AResponseInfo, acao, 'PONG', '',
      '"app":"LouvorJA","version":"' + escapaJson(fmIndex.VersaoExe) + '"');
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/clock') then
  begin
    if not v2ExigeMetodo(ARequestInfo, AResponseInfo, acao, 'GET') then
      Exit;
    v2Clock(AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/song-slides') then
  begin
    v2SongSlides(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/stopwatch') then
  begin
    v2Stopwatch(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/drawing-number') then
  begin
    v2DrawingNumber(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/search-songs') then
  begin
    v2SearchSongs(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/keyboard') then
  begin
    v2Keyboard(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  if SameText(rota, ROTA_V2 + '/open-song') then
  begin
    v2OpenSong(ARequestInfo, AResponseInfo, acao);
    Exit;
  end;

  //Rota desconhecida sob /api/v2 responde JSON. Na v1 ela escapa para o
  //servidor de arquivos e devolve o 404.html com status 200.
  respondeV2Erro(AResponseInfo, 404, acao, 'UNKNOWN_ROUTE',
    'Rota não encontrada');
end;

end.


