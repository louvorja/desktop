unit fmMonitorBibliaBusca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorBibliaBusca = class(TForm)
    pnlBibliaBusca: TPanel;
    imgBibliaBusca: TImage;
    lmdBibliaBuscaTxt: TLabel;
    lmdBibliaBuscaInfo: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorBibliaBusca: TfMonitorBibliaBusca;

implementation

{$R *.dfm}

uses fmMenu;

{ TfMonitorBibliaBusca }

procedure TfMonitorBibliaBusca.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorBibliaBusca.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_BibliaBusca.ImageIndex := 11;
end;

procedure TfMonitorBibliaBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_BibliaBusca.ImageIndex := 10;
end;

procedure TfMonitorBibliaBusca.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
