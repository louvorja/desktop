unit fmHelp;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, BusinessSkinForm,
  Vcl.StdCtrls, Data.DB, Data.Win.ADODB, Vcl.ComCtrls, bsSkinCtrls, strUtils,
  SHDocVw, Vcl.OleCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  windows, bsSkinTabs, ActiveX, ShellApi, WinInet;

type
  TfHelp = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    lblStatus: TbsSkinStdLabel;
    bsSkinButton2: TbsSkinButton;
    wbNew: TWebBrowser;
    bsSkinButton1: TbsSkinButton;
    procedure bsSkinButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tabPage: string;
  end;

var
  fHelp: TfHelp;

implementation

uses
  fmMenu, dmComponentes, fmIniciando;

{$R *.dfm}

procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string) ;
var
   sl: TStringList;
   ms: TMemoryStream;
begin
   WebBrowser.Navigate('about:blank') ;
   while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

   if Assigned(WebBrowser.Document) then
   begin
     sl := TStringList.Create;
     try
       ms := TMemoryStream.Create;
       try
         sl.Text := '<html><head><style>*{font-family:verdana;}</style></head><body>'+HTMLCode+'</body></html>';
         sl.SaveToStream(ms) ;
         ms.Seek(0, 0) ;
         (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms)) ;
       finally
         ms.Free;
       end;
     finally
       sl.Free;
     end;
   end;
end;

procedure TfHelp.bsSkinButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfHelp.bsSkinButton2Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['help'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar a ajuda! Acesse a ajuda em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
end;

procedure TfHelp.FormActivate(Sender: TObject);
var
  LinkPag,txt: string;
  url: string;
  Flags: Cardinal;
begin

  DM.IdHTTP1.Request.CustomHeaders.Values['Api-Token'] := '02@v2nFB2Dc';
  if (fmIndex.param.Strings.Values['help'] = '') then
  begin
    try
      LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
    except
      Sleep(2000);
      LinkPag := DM.IdHTTP1.Get(fmIndex.url_params);
    end;
//    txt := fmIndex.ExtraiTexto(LinkPag, '<params>', '</params>');
    txt := IfThen(trim(txt) = '', '=', txt);
    fmIndex.Param.Strings.Text := txt;
    fmIndex.Param.Strings.SaveToFile(fmIndex.dir_dados + 'configweb.ja');
  end;


  if not InternetGetConnectedState(@Flags, 0) then
  begin
    WBLoadHTML(wbNew,'<b>Não foi possível conectar à internet para obter dados da versão!</b>');
    Exit;
  end
  else
  begin
    WBLoadHTML(wbNew,'<b>Carregando...</b>');
    if (fmIndex.param.Strings.Values['version_log'] <> '') then
    begin
      url := fmIndex.param.Strings.Values['version_log']+'?lang='+fIniciando.LANG+'&version='+fmIndex.lblVersao.Caption;
      wbNew.Navigate(url);
    end;
  end;

end;

end.

