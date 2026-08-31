unit fmMonitorCronometroCulto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, bsSkinCtrls;

type
  TfMonitorCronometroCulto = class(TForm)
    pnlEscSB: TPanel;
    imgEscSB: TImage;
    lmdEscSbR: TLabel;
    lmdEscSb: TLabel;
    gEscSbR: TbsSkinGauge;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorCronometroCulto: TfMonitorCronometroCulto;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorCronometroCulto.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorCronometroCulto.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_EscolaSabatina.ImageIndex := 11;
end;

procedure TfMonitorCronometroCulto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_EscolaSabatina.ImageIndex := 10;
end;

procedure TfMonitorCronometroCulto.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMonitorCronometroCulto.FormResize(Sender: TObject);
begin
  lmdEscSb.Top := 0;
  lmdEscSb.Left := 0;
  lmdEscSb.Width := pnlEscSB.Width;
  lmdEscSb.Height := round(pnlEscSB.Height / 2);
  lmdEscSbR.Top := round(pnlEscSB.Height / 2);
  lmdEscSbR.Left := 0;
  lmdEscSbR.Width := pnlEscSB.Width;
  lmdEscSbR.Height := round(pnlEscSB.Height / 2);
end;

end.
