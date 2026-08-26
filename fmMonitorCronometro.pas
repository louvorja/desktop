unit fmMonitorCronometro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinExCtrls, bsSkinCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfMonitorCronometro = class(TForm)
    lmdCrono: TLabel;
    pnlCrono: TPanel;
    imgCrono: TImage;
    gCrono: TbsSkinGauge;
    pnlTempoGravado: TbsSkinExPanel;
    lbCrono: TbsSkinOfficeListBox;
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
  fMonitorCronometro: TfMonitorCronometro;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorCronometro.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorCronometro.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_Cronometro.ImageIndex := 11;
end;

procedure TfMonitorCronometro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_Cronometro.ImageIndex := 10;
end;

procedure TfMonitorCronometro.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
