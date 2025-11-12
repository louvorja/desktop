unit fmNovaVersao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ValEdit, OleCtrls, ShellApi, bsSkinCtrls,
  bsSkinShellCtrls, BusinessSkinForm,
  bsPngImageList, WinInet, bsDialogs, Vcl.ComCtrls, IdBaseComponent,
  IdAntiFreezeBase, IdAntiFreeze;

type
  TfNovaVersao = class(TForm)
    OpenDialog1: TbsSkinOpenDialog;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinButton2: TbsSkinButton;
    bsSkinButton3: TbsSkinButton;
    bsSkinPanel2: TbsSkinPanel;
    Image1: TbsPngImageView;
    bsSkinPanel3: TbsSkinPanel;
    lbl1: TbsSkinStdLabel;
    lblMsg: TbsSkinStdLabel;
    GridPanel4: TGridPanel;
    lbl2: TbsSkinStdLabel;
    lblVAtu: TbsSkinStdLabel;
    lbl3: TbsSkinStdLabel;
    lblVNova: TbsSkinStdLabel;
    progress: TProgressBar;
    Timer1: TTimer;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    setup_dir: string;
  public
    { Public declarations }

  end;

var
  fNovaVersao: TfNovaVersao;

implementation

uses
  fmMenu, fmAtualiza, fmIniciando, dmComponentes;


{$R *.dfm}

procedure TfNovaVersao.bsSkinButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfNovaVersao.bsSkinButton3Click(Sender: TObject);
var
  lista: TStringList;
  Flags: Cardinal;
  inst: string;
begin

  if not (InternetGetConnectedState(@Flags, 0)) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  progress.Visible := true;
  bsSkinButton3.Enabled := false;
  bsSkinButton2.Enabled := false;
  lbl1.Caption := 'Aguarde... atualizando o programa...';

  timer1.Enabled := true;
end;

procedure TfNovaVersao.FormActivate(Sender: TObject);
begin
  progress.Visible := false;
  bsSkinButton3.Enabled := true;
  bsSkinButton2.Enabled := true;
  lbl1.Caption := 'Há uma nova versão disponível de sua coletânea.';
end;

procedure TfNovaVersao.FormCreate(Sender: TObject);
var
  Result : Integer;
  SearchRec: TSearchRec;
begin
  if (DirectoryExists(ExtractFilePath(application.ExeName)+'setup\Output')) then
  begin
    result := FindFirst(ExtractFilePath(application.ExeName)+'setup\Output\*.*', faAnyFile, SearchRec);
    While Result = 0 do
    begin
      DeleteFile(ExtractFilePath(application.ExeName)+'setup\Output\' + SearchRec.Name);
      Result := FindNext(SearchRec);
    end;
  end;
end;

procedure TfNovaVersao.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfNovaVersao.Timer1Timer(Sender: TObject);
var
  arquivo: string;
  baixado: Boolean;
begin
  timer1.Enabled := false;


  arquivo := fmIndex.dir_temp + '\'+LowerCase(fIniciando.LANG)+'_'+fmIndex.param.Strings.Values['setup_name'];
  baixado := fmIndex.DownloadArquivo(fmIndex.param.Strings.Values[LowerCase(fIniciando.LANG)+'_download']+'?lang='+fIniciando.LANG,arquivo);


  if (not FileExists(arquivo)) or (baixado = false) then
  begin
    Application.MessageBox('Não foi possível baixar/executar a atualização do menu!'+#13#10+'Favor, acesse o site https://louvorja.com.br/ e efetue a instalação manual da nova versão.',fmIndex.TITULO,mb_ok+mb_iconerror);
    Exit;
  end
  else
  begin
    fmIndex.abrirArquivo(arquivo);
    DM.tmrSair.enabled := true;
    Application.Terminate;
  end;
end;

end.

