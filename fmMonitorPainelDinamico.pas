unit fmMonitorPainelDinamico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorPainelDinamico = class(TForm)
    pnlTxtPainelD: TPanel;
    imgTxtPainelD: TImage;
    lmdTxtPainelD: TLabel;
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
  fMonitorPainelDinamico: TfMonitorPainelDinamico;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorPainelDinamico.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorPainelDinamico.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_PainelD.ImageIndex := 11;
end;

procedure TfMonitorPainelDinamico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_PainelD.ImageIndex := 10;
end;

procedure TfMonitorPainelDinamico.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
