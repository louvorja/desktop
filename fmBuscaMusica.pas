unit fmBuscaMusica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, Data.DB,
  Data.Win.ADODB, bsSkinCtrls, bsDBGrids, Vcl.Mask, pngimage, DBGrids,
  bsSkinBoxCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, bsSkinGrids, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfBuscaMusica = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel3: TGridPanel;
    txtBusca: TbsSkinEdit;
    bsSkinStdLabel5: TbsSkinStdLabel;
    DBGrid1: TbsSkinDBGrid;
    qrBUSCA: TFDQuery;
    dsBUSCA: TDataSource;
    stBusca: TbsSkinStatusBar;
    bsSkinScrollBar7: TbsSkinScrollBar;
    stBusca_0: TbsSkinStatusPanel;
    stBusca_1: TbsSkinStatusPanel;
    procedure txtBuscaChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtBuscaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure txtBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    id: integer;
  end;

var
  fBuscaMusica: TfBuscaMusica;

implementation

{$R *.dfm}

uses fmMenu, dmComponentes;

procedure TfBuscaMusica.DBGrid1DblClick(Sender: TObject);
begin
  id := qrBUSCA.FieldByName('ID').AsInteger;
  close;
end;

procedure TfBuscaMusica.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TbsColumn;
  State: TGridDrawState);
var
  icon: TPngImage;
  fixRect: TRect;
begin
  Canvas.Brush.Style := bsClear;
  if (qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    icon := TPngImage.Create;
    try
      icon := DM.ico_16x16.PngImages[82].PngImage;
      fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      //TDBGrid(Sender).Canvas.CopyMode := cmMergeCopy;
      TDBGrid(Sender).Canvas.StretchDraw(fixRect, icon);
    except
      FreeAndNil(icon);
    end;
  end;
  if (qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') and (Column.FieldName = 'ICONE1') then
  begin
    icon := TPngImage.Create;
    try
      icon := DM.ico_16x16.PngImages[37].PngImage;
      fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      //TDBGrid(Sender).Canvas.CopyMode := cmMergeCopy;
      TDBGrid(Sender).Canvas.StretchDraw(fixRect, icon);
    except
      FreeAndNil(icon);
    end;
  end;
  if (qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '') and (Column.FieldName = 'ICONE2') then
  begin
    icon := TPngImage.Create;
    try
      icon := DM.ico_16x16.PngImages[103].PngImage;
      fixRect := Rect;
      fixRect.Top := Rect.Top + 1;
      fixRect.Bottom := Rect.Top + 17;
      fixRect.Left := Rect.Left + 1;
      fixRect.Right := Rect.Left + 17;
      //TDBGrid(Sender).Canvas.CopyMode := cmMergeCopy;
      TDBGrid(Sender).Canvas.StretchDraw(fixRect, icon);
    except
      FreeAndNil(icon);
    end;
  end;
end;

procedure TfBuscaMusica.FormActivate(Sender: TObject);
begin
  id := -1;
  txtBusca.Text := '';
  txtBuscaChange(Sender);
end;

procedure TfBuscaMusica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_UP) or (Key = VK_DOWN)) and (Shift = []) and
     (Screen.ActiveControl = txtBusca) then
    Exit;

  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfBuscaMusica.FormResize(Sender: TObject);
begin
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
end;

procedure TfBuscaMusica.txtBuscaChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
begin
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
  valor := trim(txtBusca.Text);
  stBusca_0.caption := '';
  if trim(valor) <> '' then
  begin
    val(txtBusca.Text, nr, c);
    if c = 0 then
    begin
      stBusca_0.caption := 'Buscando hino nº: ' + valor;
    end
    else
    begin
      stBusca_0.caption := 'Buscando música nome: ''' + valor + '''';
    end;
  end;

  qrBUSCA.Close;
  qrBUSCA.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
  qrBUSCA.Open;

  stBusca_1.caption := fmIndex.qtItens(qrBUSCA,'música encontrada','músicas encontrados','Nenhuma música encontrado');
  fmIndex.corCampoBusca(qrBUSCA, txtBusca,DBGrid1);
  dbGrid1.Columns[2].Width := dbGrid1.Width - dbGrid1.Columns[0].Width - dbGrid1.Columns[1].Width;
end;

procedure TfBuscaMusica.txtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1DblClick(Sender);
  end;
end;

procedure TfBuscaMusica.txtBuscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift <> []) then Exit;
  if (Key <> VK_UP) and (Key <> VK_DOWN) then Exit;
  if (qrBUSCA.Active = False) or (qrBUSCA.RecordCount <= 0) then Exit;

  if (Key = VK_DOWN)
    then qrBUSCA.Next
    else qrBUSCA.Prior;

  Key := 0;
end;

procedure TfBuscaMusica.txtBuscaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.edtKeyUp(Sender,Key,Shift);
end;

end.
