unit fmVideoOn;

{
  Player de vídeos online.

  Usava TWebBrowser (motor do Internet Explorer), que o YouTube deixou de
  suportar. Passou a usar o WebView2 (Chromium do Edge) via WebView4Delphi.
  Os componentes são criados em tempo de execução para o projeto compilar sem
  instalar pacote no IDE.

  O contrato com o resto do programa não mudou: definir videoID, Caption e
  BorderStyle, chamar Show; Close encerra.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, bsSkinCtrls, Vcl.ExtCtrls,
  uWVBrowser, uWVWindowParent, uWVLoader, uWVTypes, uWVTypeLibrary;

const
  //Navega direto para a página do player, que já entrega fundo preto e iframe
  //ocupando a tela toda. O video.html local anterior só recriava esse mesmo
  //HTML, numa origem file://.
  URL_PLAYER = 'https://api.louvorja.com.br/player?v=';

  //Tela de projeção: sem controles, marca, anotações nem atalhos de teclado.
  //autoplay depende também de AutoplayPolicy (ver initialization).
  //Legenda não é tratada aqui: cc_load_policy=0 apenas deixa de forçá-la, não
  //a desliga. Quem desliga é o script injetado (ver desligaLegendasYoutube).
  PARAMS_YOUTUBE = 'autoplay=1&controls=0&modestbranding=1&rel=0' +
                   '&iv_load_policy=3&disablekb=1&fs=0&playsinline=1';

type
  TfVideoOn = class(TForm)
    pnlLoading: TPanel;
    lblLoading: TbsSkinLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    wvJanela: TWVWindowParent;
    wvVideo: TWVBrowser;
    tmrCriaBrowser: TTimer;
    url_pendente: string;
    pedido_feito: Boolean;
    encerrando: Boolean;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure tmrCriaBrowserTimer(Sender: TObject);
    procedure wvVideoAfterCreated(Sender: TObject);
    procedure wvVideoNavigationCompleted(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure wvVideoInitializationError(Sender: TObject; aErrorCode: HRESULT;
      const aErrorMessage: wvstring);
    procedure wvVideoAcceleratorKeyPressed(Sender: TObject;
      const aController: ICoreWebView2Controller;
      const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
    procedure desligaLegendasYoutube;
    procedure aplicaParametrosYoutube;
    procedure ajustaTamanho;
    procedure mostraErro(const msg: string);
  protected
    //Sem isso o conteúdo desalinha ao mover a janela entre monitores
    procedure WMMove(var aMessage: TWMMove); message WM_MOVE;
  public
    { Public declarations }
    videoID: string;
    id: string;
  end;

var
  fVideoOn: TfVideoOn;

implementation

{$R *.dfm}

uses
  fmMenu, fmIniciando;

procedure TfVideoOn.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TfVideoOn.FormCreate(Sender: TObject);
begin
  wvJanela := TWVWindowParent.Create(Self);
  wvJanela.Parent := Self;
  wvJanela.Align := alClient;
  //Precisa estar visível quando o navegador for criado: o controlador do
  //WebView2 herda a visibilidade nesse momento e, se nascer invisível, não
  //desenha nada (tela preta) mesmo depois de exibir o controle no VCL.
  //Durante o carregamento quem cobre a tela é o pnlLoading, por cima.
  wvJanela.Visible := True;

  wvVideo := TWVBrowser.Create(Self);
  wvVideo.OnAfterCreated := wvVideoAfterCreated;
  wvVideo.OnNavigationCompleted := wvVideoNavigationCompleted;
  wvVideo.OnInitializationError := wvVideoInitializationError;
  //Com o foco dentro do navegador o OnKeyUp do formulário não recebe mais nada
  wvVideo.OnAcceleratorKeyPressed := wvVideoAcceleratorKeyPressed;

  //O runtime carrega de forma assíncrona: pode não estar pronto no 1º vídeo
  tmrCriaBrowser := TTimer.Create(Self);
  tmrCriaBrowser.Enabled := False;
  tmrCriaBrowser.Interval := 200;
  tmrCriaBrowser.OnTimer := tmrCriaBrowserTimer;
end;

//Na tela, não em caixa de diálogo: ela ficaria atrás da janela de vídeo.
//O rótulo é de linha única, então a mensagem precisa ser curta e direta.
procedure TfVideoOn.mostraErro(const msg: string);
begin
  tmrCriaBrowser.Enabled := False;
  pnlLoading.Visible := True;
  pnlLoading.BringToFront;
  lblLoading.Caption :=
    fIniciando.Translate('Instale o Microsoft Edge WebView2 Runtime para reproduzir vídeos:') +
    ' microsoft.com/pt-br/edge/webview2';
end;

procedure TfVideoOn.FormActivate(Sender: TObject);
begin
  if (Trim(videoID) = '') or (wvVideo = nil) then
    Exit;

  id := videoID;
  videoID := '';
  encerrando := False;
  url_pendente := URL_PLAYER + Trim(id);

  pnlLoading.Visible := True;
  pnlLoading.BringToFront;
  lblLoading.Caption := fIniciando.Translate('Carregando...');

  //Janela reaproveitada entre vídeos: o navegador já existe, só navega
  if wvVideo.Initialized then
    wvVideo.Navigate(url_pendente)
  else
  begin
    pedido_feito := False;
    tmrCriaBrowser.Enabled := True;
    tmrCriaBrowserTimer(nil);
  end;
end;

procedure TfVideoOn.tmrCriaBrowserTimer(Sender: TObject);
begin
  if GlobalWebView2Loader.InitializationError then
  begin
    mostraErro(GlobalWebView2Loader.ErrorMessage);
    Exit;
  end;

  //Ainda esperando o runtime ficar pronto
  if not GlobalWebView2Loader.Initialized then
    Exit;

  tmrCriaBrowser.Enabled := False;

  //CreateBrowser dispara a criação de forma assíncrona: uma vez só
  if not pedido_feito then
    pedido_feito := wvVideo.CreateBrowser(wvJanela.Handle);
end;

//O iframe do YouTube é de outra origem, então a página pai não consegue mexer
//no conteúdo dele. AddScriptToExecuteOnDocumentCreated contorna isso: o
//WebView2 injeta o script dentro de cada documento, inclusive os frames
//filhos, e assim ele roda de dentro do próprio YouTube.
//Desliga a legenda pelo player: os parâmetros da URL não garantem isso.
procedure TfVideoOn.desligaLegendasYoutube;
begin
  wvVideo.AddScriptToExecuteOnDocumentCreated(
    '(function(){' +
    'if(location.host.indexOf("youtube.com")<0)return;' +
    'var por=function(){' +
    'var p=document.querySelector(".html5-video-player");' +
    'if(p&&p.unloadModule){try{p.unloadModule("captions");p.unloadModule("cc");}catch(e){}}' +
    '};' +
    'por();' +
    'document.addEventListener("DOMContentLoaded",por);' +
    //O player carrega a legenda depois: reaplica por alguns segundos
    'var n=0,t=setInterval(function(){por();if(++n>40)clearInterval(t);},250);' +
    '})();');
end;

//A página do projeto monta o iframe sem parâmetros e ignora os que recebe na
//URL, então reescrevemos o src pelo lado do pai. Carregar o embed direto como
//página não serve: o YouTube recusa fora de um iframe com origem válida.
procedure TfVideoOn.aplicaParametrosYoutube;
begin
  if (Trim(id) = '') then
    Exit;

  wvVideo.ExecuteScript(
    '(function(){' +
    'var f=document.querySelector("iframe");' +
    'if(!f)return;' +
    'f.setAttribute("allow","autoplay; encrypted-media; picture-in-picture");' +
    'f.src="https://www.youtube.com/embed/' + Trim(id) + '?' + PARAMS_YOUTUBE + '";' +
    '})();');
end;

//UpdateSize apenas reposiciona a janela filha. A área de renderização vem de
//Bounds, no controlador: sem isso o vídeo fica com o tamanho de projeto do
//formulário, porque a janela só é ajustada ao monitor depois do Show.
procedure TfVideoOn.ajustaTamanho;
begin
  if (wvVideo = nil) or (not wvVideo.Initialized) then
    Exit;

  wvJanela.UpdateSize;
  wvVideo.Bounds := Rect(0, 0, wvJanela.Width, wvJanela.Height);
end;

procedure TfVideoOn.wvVideoAfterCreated(Sender: TObject);
begin
  //É uma tela de projeção: sem menu de contexto, atalhos ou barra de status
  wvVideo.DefaultContextMenusEnabled := False;
  wvVideo.AreBrowserAcceleratorKeysEnabled := False;
  wvVideo.StatusBarEnabled := False;

  //Precisa valer antes de navegar: aplica-se aos documentos seguintes
  desligaLegendasYoutube;

  if (Trim(url_pendente) <> '') then
    wvVideo.Navigate(url_pendente);
end;

procedure TfVideoOn.wvVideoNavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  //Ao fechar navegamos para about:blank; esse retorno não deve reexibir nada
  if encerrando then
    Exit;

  aplicaParametrosYoutube;

  pnlLoading.Visible := False;
  ajustaTamanho;
end;

procedure TfVideoOn.wvVideoInitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  mostraErro(aErrorMessage);
end;

//Depois de clicar no vídeo o foco fica no navegador e as teclas param de
//chegar ao formulário. Aqui elas voltam para o programa.
procedure TfVideoOn.wvVideoAcceleratorKeyPressed(Sender: TObject;
  const aController: ICoreWebView2Controller;
  const aArgs: ICoreWebView2AcceleratorKeyPressedEventArgs);
var
  tipo: COREWEBVIEW2_KEY_EVENT_KIND;
  tecla: Cardinal;
  chave: Word;
begin
  if (aArgs = nil) then
    Exit;

  aArgs.Get_KeyEventKind(tipo);
  if (tipo <> COREWEBVIEW2_KEY_EVENT_KIND_KEY_UP) and
     (tipo <> COREWEBVIEW2_KEY_EVENT_KIND_SYSTEM_KEY_UP) then
    Exit;

  aArgs.Get_VirtualKey(tecla);
  chave := Word(tecla);
  aArgs.Set_Handled(1);

  if (chave = VK_ESCAPE) then
    Close
  else
    fmIndex.FormKeyUp(Self, chave, []);
end;

procedure TfVideoOn.FormResize(Sender: TObject);
begin
  //A janela é ajustada ao monitor depois do Show, e o usuário pode
  //redimensionar: o navegador precisa ser avisado sempre
  ajustaTamanho;
end;

procedure TfVideoOn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  encerrando := True;
  tmrCriaBrowser.Enabled := False;
  url_pendente := '';

  //Interrompe o vídeo: a janela só é escondida, então sem isso o áudio
  //continuaria tocando depois de fechada
  if (wvVideo <> nil) and wvVideo.Initialized then
    wvVideo.Navigate('about:blank');
end;

procedure TfVideoOn.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfVideoOn.WMMove(var aMessage: TWMMove);
begin
  inherited;
  if (wvVideo <> nil) then
    wvVideo.NotifyParentWindowPositionChanged;
end;

initialization
  //Sobe o runtime na abertura do programa, para o primeiro vídeo não esperar
  GlobalWebView2Loader                   := TWVLoader.Create(nil);
  //Carregador interno: dispensa distribuir o WebView2Loader.dll
  GlobalWebView2Loader.UseInternalLoader := True;
  //Sem isso o Chromium bloqueia o autoplay com som e o vídeo fica parado
  GlobalWebView2Loader.AutoplayPolicy    := appNoUserGestureRequired;
  GlobalWebView2Loader.UserDataFolder    := GetEnvironmentVariable('APPDATA') + '\LouvorJA\WebView2';
  GlobalWebView2Loader.StartWebView2;

end.
