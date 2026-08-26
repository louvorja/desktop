unit fmMonitorRelogio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorRelogio = class(TForm)
    pnlRelogio: TPanel;
    imgRelogio: TImage;
    lmdRelogio: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorRelogio: TfMonitorRelogio;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorRelogio.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorRelogio.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_Relogio.ImageIndex := 11;
end;

procedure TfMonitorRelogio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_Relogio.ImageIndex := 10;
end;

procedure TfMonitorRelogio.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
