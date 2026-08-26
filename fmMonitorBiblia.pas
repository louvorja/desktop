unit fmMonitorBiblia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorBiblia = class(TForm)
    pnlBiblia: TPanel;
    imgBiblia: TImage;
    lmdBibliaTxt: TLabel;
    lmdBibliaInfo: TLabel;
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
  fMonitorBiblia: TfMonitorBiblia;

implementation

{$R *.dfm}

uses fmMenu;

{ TfMonitorBiblia }

procedure TfMonitorBiblia.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorBiblia.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_Biblia.ImageIndex := 11;
end;

procedure TfMonitorBiblia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_Biblia.ImageIndex := 10;
end;

procedure TfMonitorBiblia.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
