unit fmMonitorMenuMusicas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, bsPngImageList,
  Vcl.StdCtrls, bsSkinCtrls, bsdbctrls, Vcl.DBCGrids;

type
  TfMonitorMenuMusicas = class(TForm)
    Panel1: TPanel;
    DBCtrlGrid: TDBCtrlGrid;
    Panel2: TPanel;
    GridPanel2: TGridPanel;
    bsSkinDBText1: TbsSkinDBText;
    ico: TbsPngImageView;
    bsSkinDBText2: TbsSkinDBText;
    Panel3: TPanel;
    Panel4: TPanel;
    imgCapa: TImage;
    GridPanel1: TGridPanel;
    lblTitulo: TbsSkinStdLabel;
    lblSubtitulo: TbsSkinStdLabel;
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
  fMonitorMenuMusicas: TfMonitorMenuMusicas;

implementation

{$R *.dfm}

uses fmMenu, fmListaMusica;

{ TfMonitorMenuMusicas }

procedure TfMonitorMenuMusicas.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorMenuMusicas.FormActivate(Sender: TObject);
begin
  fListaMusica.btExp_MenuMusicas.ImageIndex := 54;
end;

procedure TfMonitorMenuMusicas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fListaMusica.btExp_MenuMusicas.ImageIndex := 53;
end;

procedure TfMonitorMenuMusicas.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
