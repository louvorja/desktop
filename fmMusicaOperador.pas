unit fmMusicaOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, bsSkinGrids, bsDBGrids, Vcl.StdCtrls, System.Types;

type
  TfMusicaOperador = class(TForm)
    Panel2: TPanel;
    DBGrid1: TbsSkinDBGrid;
    bsSkinScrollBar7: TbsSkinScrollBar;
    Panel: TPanel;
    pnlLetra: TPanel;
    imgFundo: TImage;
    imgFundoTexto: TImage;
    lblLetra: TbsSkinStdLabel;
    lblLetra_aux: TbsSkinStdLabel;
    pnlProgress: TGridPanel;
    gSlide: TbsSkinGauge;
    Panel3: TPanel;
    gSlideTotal: TbsSkinGauge;
    lblTempo: TbsSkinLabel;
    GridPanel2: TGridPanel;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    btPausePlay: TbsSkinSpeedButton;
    bsSkinSpeedButton3: TbsSkinSpeedButton;
    bsSkinSpeedButton4: TbsSkinSpeedButton;
    bsSkinSpeedButton5: TbsSkinSpeedButton;
    Panel1: TPanel;
    lblSlides: TbsSkinLabel;
    pnlInfo: TPanel;
    pnlErroMsg: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TbsColumn);
    procedure bsSkinSpeedButton5Click(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure btPausePlayClick(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    inicio: Boolean;
    recno: Integer;
  end;

var
  fMusicaOperador: TfMusicaOperador;

implementation

{$R *.dfm}

uses
  fmMusica, fmMenu, dmComponentes;

{ TfSlidesMusica }

procedure TfMusicaOperador.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fMusica.acaoSlide('ant');
end;

procedure TfMusicaOperador.btPausePlayClick(Sender: TObject);
begin
  fMusica.pauseplay;
end;

procedure TfMusicaOperador.bsSkinSpeedButton3Click(Sender: TObject);
begin
  fMusica.acaoSlide('prox');
end;

procedure TfMusicaOperador.bsSkinSpeedButton4Click(Sender: TObject);
begin
  fMusica.acaoSlide('ult');
end;

procedure TfMusicaOperador.bsSkinSpeedButton5Click(Sender: TObject);
begin
  fMusica.acaoSlide('pri');
end;

procedure TfMusicaOperador.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    Params.WndParent := 0;
end;

procedure TfMusicaOperador.DBGrid1CellClick(Column: TbsColumn);
begin
  fMusica.irSlide(DM.cdsSLIDE_MUSICA.RecNo);
end;

procedure TfMusicaOperador.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
var
  R: TRect;
begin
  if DM.cdsSLIDE_MUSICA.RecNo = 1 then
    DBGrid1.Canvas.Font.Color := $02AC3F6;
  DBGrid1.Canvas.Brush.Color := $00353535;

  if DM.cdsSLIDE_MUSICA.RecNo = fMusica.nslide then
  begin
    DBGrid1.Canvas.Brush.Color := $00FFFFFF;
    DBGrid1.Canvas.Font.Color := $00353535;
  end;
//  if gdSelected in State then


  R := Rect;
  Dec(R.Bottom, 0);
  R.Top := R.Top + 10;
  R.Left := R.Left + 10;

  if Column.Index = 0 then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DrawText(DBGrid1.Canvas.Handle, IntToStr(DM.cdsSLIDE_MUSICA.RecNo), Length(IntToStr(DM.cdsSLIDE_MUSICA.RecNo)), R, DT_WORDBREAK);
  end
  else if Column.Field = DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE') then
  begin
    DBGrid1.Canvas.FillRect(Rect);
    DrawText(DBGrid1.Canvas.Handle, PChar(DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString), Length(DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString), R, DT_WORDBREAK);
  end;

end;

procedure TfMusicaOperador.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Key := 0;
end;

procedure TfMusicaOperador.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TfMusicaOperador.FormActivate(Sender: TObject);
begin
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') <> '1') then
  begin
    fMusicaOperador.AlphaBlend := True;
    fMusicaOperador.AlphaBlendValue := 0;
  end;

  if (inicio <> true) then
  begin
    inicio := True;
    recno := 0;
    fMusicaOperador.Tag := 1;
  end;
end;

procedure TfMusicaOperador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') <> '1') then
  begin
    fMusicaOperador.Tag := 0;
    fMusica.fecharSlides := True;
    fMusica.Close;
  end
  else
  begin
    if fMusicaOperador.Tag = 1 then
    begin
      if (application.MessageBox('Ao fechar esta tela, os slides também serão fechados! Deseja fechar os slides?', fmIndex.titulo,
          mb_yesno + mb_iconquestion + MB_TOPMOST + MB_SETFOREGROUND) <> 6) then
      begin
        Abort;
        Exit;
      end;
      fMusicaOperador.Tag := 0;
    end;
    fMusica.fecharSlides := True;
    fMusica.Close;
  end;
end;

procedure TfMusicaOperador.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMusicaOperador.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfMusicaOperador.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;

end.

