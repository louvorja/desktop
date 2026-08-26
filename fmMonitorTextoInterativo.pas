unit fmMonitorTextoInterativo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, bsSkinCtrls;

type
  TfMonitorTextoInterativo = class(TForm)
    RichEdit0: TbsSkinRichEdit;
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
  fMonitorTextoInterativo: TfMonitorTextoInterativo;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorTextoInterativo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorTextoInterativo.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_TextoInterativo.ImageIndex := 11;
end;

procedure TfMonitorTextoInterativo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmIndex.fadeJanela(Self, 0);

  fmIndex.btExp_TextoInterativo.ImageIndex := 10;
end;

procedure TfMonitorTextoInterativo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
