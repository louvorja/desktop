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
  System.JSON, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, bsSkinCtrls, Vcl.ExtCtrls,
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
  //enablejsapi=1 abre o canal de comandos usado pelo painel do programa: sem
  //ele o iframe ignora tudo que for enviado por postMessage.
  PARAMS_YOUTUBE = 'autoplay=1&controls=0&modestbranding=1&rel=0' +
                   '&iv_load_policy=3&disablekb=1&fs=0&playsinline=1' +
                   '&enablejsapi=1';

  //Identificador do ExecuteScript que devolve o estado, para distinguir a
  //resposta dele das dos outros scripts no OnExecuteScriptCompleted
  EXEC_ESTADO = 101;

  //Estados do player do YouTube (os que interessam aqui)
  YT_ENCERRADO   = 0;
  YT_REPRODUZIDO = 1;
  YT_PAUSADO     = 2;
  YT_BUFFER      = 3;

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
    procedure instalaScriptPlayer;
    procedure wvVideoExecuteScriptCompleted(Sender: TObject; aErrorCode: HRESULT;
      const aResultObjectAsJson: wvstring; aExecutionID: integer);
    procedure comando(const funcao, argumentos: string);
    procedure ajustaTamanho;
    procedure mostraErro(const msg: string);
  protected
    //Sem isso o conteúdo desalinha ao mover a janela entre monitores
    procedure WMMove(var aMessage: TWMMove); message WM_MOVE;
  public
    { Public declarations }
    videoID: string;
    id: string;

    //Estado do vídeo, alimentado por consultaEstado. É cache: o YouTube não
    //responde de forma síncrona, então quem lê aqui vê o último valor
    //recebido, com no máximo um ciclo de atraso.
    tempoAtual: Double;
    duracao: Double;
    estado: Integer;

    //Controle pelo painel do programa
    procedure reproduz;
    procedure pausa;
    procedure buscaSegundos(segundos: Double);
    procedure consultaEstado;
    function tocando: Boolean;
    function terminou: Boolean;
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
  //Retorno das consultas de estado feitas pelo painel de controle
  wvVideo.OnExecuteScriptCompleted := wvVideoExecuteScriptCompleted;

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

  //Vídeo novo: o estado do anterior não vale mais
  tempoAtual := 0;
  duracao := 0;
  estado := -1;

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
    {
      Sem prazo para terminar. Antes este ciclo parava depois de dez segundos,
      e o YouTube recarrega o módulo de legendas ao saltar no tempo - passado
      esse prazo, a legenda voltava. É uma consulta ao DOM a cada 400 ms, e o
      intervalo morre junto com o documento, então trocar de vídeo não acumula
      temporizador.
    }
    'setInterval(por,400);' +
    '})();');
end;

{
  Prepara a página do player: reescreve o iframe com os parâmetros e instala a
  ponte de controle.

  Roda como script de documento, não a partir do OnNavigationCompleted. O
  motivo é uma corrida real: ao reaproveitar a janela, o about:blank disparado
  pelo fechamento anterior ainda está a caminho quando a nova navegação
  começa, e o evento chegava duas vezes. O iframe era reescrito duas vezes em
  menos de um segundo e o player do YouTube ficava presoem "buffer", sem
  nunca começar a tocar - o primeiro vídeo funcionava, os seguintes não.

  Como script de documento, isto roda uma vez por documento por construção, e
  o identificador do vídeo vem da própria URL, sem depender do estado do
  Delphi no instante certo.

  A página do projeto monta o iframe sem parâmetro nenhum e ignora os que
  recebe na URL, por isso a reescrita. Carregar o embed direto como página não
  serve: o YouTube recusa fora de um iframe com origem válida.
}
procedure TfVideoOn.instalaScriptPlayer;
begin
  wvVideo.AddScriptToExecuteOnDocumentCreated(
    '(function(){' +
    //Só na página do player, e uma vez por documento
    'if(location.href.indexOf("' + URL_PLAYER + '")!==0)return;' +
    'if(window.__lja)return;' +

    'var id="";' +
    'try{id=new URLSearchParams(location.search).get("v")||"";}catch(e){}' +
    'if(!id)return;' +

    'window.__lja={tempo:0,duracao:0,estado:-1,pronto:false};' +

    'window.addEventListener("message",function(e){' +
    'if(String(e.origin).indexOf("youtube.com")<0)return;' +
    'var d=e.data;' +
    'try{if(typeof d==="string")d=JSON.parse(d);}catch(x){return;}' +
    'if(!d)return;' +
    'if(d.event==="onReady"||d.event==="initialDelivery")window.__lja.pronto=true;' +
    'var i=d.info||{};' +
    'if(typeof i.currentTime==="number")window.__lja.tempo=i.currentTime;' +
    'if(typeof i.duration==="number"&&i.duration>0)window.__lja.duracao=i.duration;' +
    'if(typeof i.playerState==="number")window.__lja.estado=i.playerState;' +
    //progressState chega junto e costuma ser o valor mais atual
    'if(i.progressState){' +
    'if(typeof i.progressState.current==="number")window.__lja.tempo=i.progressState.current;' +
    'if(typeof i.progressState.duration==="number"&&i.progressState.duration>0)' +
    'window.__lja.duracao=i.progressState.duration;' +
    '}' +
    '});' +

    'window.__ljaCmd=function(f,a){' +
    'var fr=document.querySelector("iframe");' +
    'if(!fr||!fr.contentWindow)return false;' +
    'fr.contentWindow.postMessage(JSON.stringify({event:"command",func:f,args:a||[]}),"*");' +
    'return true;' +
    '};' +

    //Sem o "listening" o YouTube não devolve informação nenhuma
    'var ouvir=function(){' +
    'var fr=document.querySelector("iframe");' +
    'if(!fr||!fr.contentWindow)return;' +
    'fr.contentWindow.postMessage(JSON.stringify(' +
    '{event:"listening",id:1,channel:"widget"}),"*");' +
    '};' +

    //O iframe é criado pela página depois deste script: espera aparecer e
    //marca para não reescrever de novo
    'var aplicar=function(){' +
    'var f=document.querySelector("iframe");' +
    'if(!f)return false;' +
    'if(f.getAttribute("data-lja")==="1")return true;' +
    'f.setAttribute("data-lja","1");' +
    'f.setAttribute("allow","autoplay; encrypted-media; picture-in-picture");' +
    'f.src="https://www.youtube.com/embed/"+id+"?' + PARAMS_YOUTUBE +
    '&origin="+encodeURIComponent(location.origin);' +
    'return true;' +
    '};' +

    'var pronto=false,n=0;' +
    'var t=setInterval(function(){' +
    'if(!pronto)pronto=aplicar();' +
    'if(pronto)ouvir();' +
    'if(++n>80||(pronto&&window.__lja.pronto))clearInterval(t);' +
    '},250);' +
    '})();');
end;

procedure TfVideoOn.comando(const funcao, argumentos: string);
begin
  if (wvVideo = nil) or (not wvVideo.Initialized) or encerrando then
    Exit;

  wvVideo.ExecuteScript(
    'window.__ljaCmd&&window.__ljaCmd("' + funcao + '",[' + argumentos + ']);');
end;

procedure TfVideoOn.reproduz;
begin
  comando('playVideo', '');
  //Não espera a confirmação: o painel precisa responder na hora, e o valor
  //real chega no próximo ciclo de consultaEstado
  estado := YT_REPRODUZIDO;
end;

procedure TfVideoOn.pausa;
begin
  comando('pauseVideo', '');
  estado := YT_PAUSADO;
end;

procedure TfVideoOn.buscaSegundos(segundos: Double);
var
  txt: string;
begin
  if (segundos < 0) then
    segundos := 0;

  //Ponto decimal independe da configuração regional do Windows
  txt := FormatFloat('0.###', segundos, TFormatSettings.Invariant);

  //O segundo argumento manda buscar mesmo fora do trecho já baixado
  comando('seekTo', txt + ',true');

  {
    Saltar no tempo faz o YouTube recarregar o módulo de legendas, e elas
    voltam a aparecer mesmo em vídeo que começou sem elas.

    Aqui vale setOption e não unloadModule: pelo canal de comandos o
    unloadModule é ignorado - testado, a legenda continuava na tela -, e quem
    de fato desliga é a opção de faixa vazia. O unloadModule só funciona
    chamado direto no objeto do player, que é o que o script injetado faz
    dentro do próprio frame do YouTube.
  }
  comando('setOption', '"captions","track",{}');

  tempoAtual := segundos;
end;

//Pede o estado. A resposta chega em wvVideoExecuteScriptCompleted.
procedure TfVideoOn.consultaEstado;
begin
  if (wvVideo = nil) or (not wvVideo.Initialized) or encerrando then
    Exit;

  wvVideo.ExecuteScript('JSON.stringify(window.__lja||null);', EXEC_ESTADO);
end;

{
  Se o vídeo está em reprodução do ponto de vista de quem assiste.

  O buffer conta como tocando. Todo salto no tempo passa por ele por um
  instante, e tratá-lo como pausa fazia os botões do painel alternarem para
  "pausado" e voltarem logo em seguida, a cada salto.
}
function TfVideoOn.tocando: Boolean;
begin
  Result := (estado = YT_REPRODUZIDO) or (estado = YT_BUFFER);
end;

function TfVideoOn.terminou: Boolean;
begin
  Result := (estado = YT_ENCERRADO);
end;

{
  Retorno do ExecuteScript.

  O resultado vem como JSON: uma string JSON contendo, por sua vez, o objeto
  serializado. Por isso o texto é desempacotado duas vezes.
}
procedure TfVideoOn.wvVideoExecuteScriptCompleted(Sender: TObject;
  aErrorCode: HRESULT; const aResultObjectAsJson: wvstring;
  aExecutionID: integer);
var
  externo, interno: TJSONValue;
  obj: TJSONObject;
  txt: string;
begin
  if (aExecutionID <> EXEC_ESTADO) or (aErrorCode <> S_OK) then
    Exit;

  externo := nil;
  interno := nil;
  try
    externo := TJSONObject.ParseJSONValue(string(aResultObjectAsJson));
    if not (externo is TJSONString) then
      Exit;

    txt := TJSONString(externo).Value;
    //Antes de a ponte ser instalada a resposta é nula, e não há o que ler
    if (txt = '') or SameText(txt, 'null') then
      Exit;

    interno := TJSONObject.ParseJSONValue(txt);
    if not (interno is TJSONObject) then
      Exit;

    //Campo que não vier mantém o último valor conhecido, em vez de zerar
    obj := TJSONObject(interno);
    obj.TryGetValue<Double>('tempo', tempoAtual);
    obj.TryGetValue<Double>('duracao', duracao);
    obj.TryGetValue<Integer>('estado', estado);
  finally
    interno.Free;
    externo.Free;
  end;
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

  //Precisam valer antes de navegar: aplicam-se aos documentos seguintes
  desligaLegendasYoutube;
  instalaScriptPlayer;

  if (Trim(url_pendente) <> '') then
    wvVideo.Navigate(url_pendente);
end;

procedure TfVideoOn.wvVideoNavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
var
  atual: string;
begin
  //Ao fechar navegamos para about:blank; esse retorno não deve reexibir nada
  if encerrando then
    Exit;

  atual := string(wvVideo.Source);

  {
    Reaproveitando a janela, o about:blank disparado pelo fechamento anterior
    ainda está a caminho quando a nova navegação começa, e o retorno dele cai
    aqui como se fosse a página do player. Preparar a página a partir daqui
    fazia isso acontecer duas vezes; quem prepara agora é o script de
    documento, em instalaScriptPlayer. Aqui só resta o que é de tela.
  }
  if (Pos(LowerCase(URL_PLAYER), LowerCase(atual)) <> 1) then
    Exit;

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
