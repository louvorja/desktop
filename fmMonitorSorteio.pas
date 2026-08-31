unit fmMonitorSorteio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinExCtrls, bsSkinCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorSorteio = class(TForm)
    pnlSorteio: TPanel;
    imgSorteio: TImage;
    lmdSorteio: TLabel;
    gSorteio: TbsSkinGauge;
    pnlSorteioE: TbsSkinExPanel;
    lbSorteio: TbsSkinOfficeListBox;
    pnlSorteioD: TbsSkinExPanel;
    lbSorteado: TbsSkinOfficeListBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbSorteioItemCheckClick(Sender: TObject);
    procedure pnlSorteioDClose(Sender: TObject);
    procedure pnlSorteioEClose(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorSorteio: TfMonitorSorteio;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorSorteio.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorSorteio.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_Sorteio.ImageIndex := 11;
end;

procedure TfMonitorSorteio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_Sorteio.ImageIndex := 10;
end;

procedure TfMonitorSorteio.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMonitorSorteio.lbSorteioItemCheckClick(Sender: TObject);
begin
  fmIndex.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  fmIndex.lbSorteio.Items[lbSorteio.ItemIndex].Checked := lbSorteio.Items[lbSorteio.ItemIndex].Checked;
  fmIndex.lbSorteioItemCheckClick(Sender);
end;

procedure TfMonitorSorteio.pnlSorteioDClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExp.ItemChecked[1] := false;
end;

procedure TfMonitorSorteio.pnlSorteioEClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExp.ItemChecked[0] := false;
end;

end.
