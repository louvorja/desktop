unit fmCopiaLiturgiaDia;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfCopiaLiturgiaDia = class(TForm)
  private
    FDiaOrigem: Integer;
    FCbDias: array[1..7] of TCheckBox;
    FCbSobrescrever: TCheckBox;
  public
    constructor CreateDialog(AOwner: TComponent; ADiaOrigem: Integer);
    function GetDiasSelecionados: TArray<Integer>;
    function GetSobrescrever: Boolean;
  end;

implementation

uses
  //NOMES_DIAS vem de la: a liturgia exportada usa os mesmos nomes de dia,
  //entao eles moram na unit pura do formato.
  uLiturgiaTroca;

constructor TfCopiaLiturgiaDia.CreateDialog(AOwner: TComponent; ADiaOrigem: Integer);
var
  lbl: TLabel;
  grp: TGroupBox;
  btn: TButton;
  i: Integer;
  pnlBotoes: TPanel;
begin
  inherited CreateNew(AOwner);
  FDiaOrigem := ADiaOrigem;

  Caption := 'Colar Itens em Outros Dias';
  Width := 330;
  Height := 340;
  BorderStyle := bsDialog;
  Position := poOwnerFormCenter;

  lbl := TLabel.Create(Self);
  lbl.Parent := Self;
  lbl.AutoSize := False;
  lbl.Left := 12;
  lbl.Top := 12;
  lbl.Width := Width - 24;
  lbl.Height := 32;
  lbl.WordWrap := True;
  lbl.Caption := 'Selecione os dias para colar os itens copiados:';

  grp := TGroupBox.Create(Self);
  grp.Parent := Self;
  grp.Left := 12;
  grp.Top := 50;
  grp.Width := 295;
  grp.Height := 168;
  grp.Caption := 'Dias da Semana';

  for i := 1 to 7 do
  begin
    FCbDias[i] := TCheckBox.Create(Self);
    FCbDias[i].Parent := grp;
    FCbDias[i].Left := 16;
    FCbDias[i].Top := 18 + (i - 1) * 21;
    FCbDias[i].Width := 240;
    FCbDias[i].Caption := NOMES_DIAS[i];
    FCbDias[i].Tag := i;
    if i = ADiaOrigem then
    begin
      FCbDias[i].Checked := False;
      FCbDias[i].Enabled := False;
      FCbDias[i].Caption := NOMES_DIAS[i] + ' (origem)';
    end
    else
      FCbDias[i].Checked := True;
  end;

  FCbSobrescrever := TCheckBox.Create(Self);
  FCbSobrescrever.Parent := Self;
  FCbSobrescrever.Left := 12;
  FCbSobrescrever.Top := 228;
  FCbSobrescrever.Width := 295;
  FCbSobrescrever.Caption := 'Sobrescrever todo o conte'#250'do dos dias selecionados';
  FCbSobrescrever.Checked := False;

  pnlBotoes := TPanel.Create(Self);
  pnlBotoes.Parent := Self;
  pnlBotoes.Left := 0;
  pnlBotoes.Top := 260;
  pnlBotoes.Width := 322;
  pnlBotoes.Height := 44;
  pnlBotoes.BevelOuter := bvNone;
  pnlBotoes.Align := alBottom;

  btn := TButton.Create(Self);
  btn.Parent := pnlBotoes;
  btn.Left := 146;
  btn.Top := 8;
  btn.Width := 80;
  btn.Height := 28;
  btn.Caption := 'OK';
  btn.Default := True;
  btn.ModalResult := mrOk;

  btn := TButton.Create(Self);
  btn.Parent := pnlBotoes;
  btn.Left := 234;
  btn.Top := 8;
  btn.Width := 80;
  btn.Height := 28;
  btn.Caption := 'Cancelar';
  btn.Cancel := True;
  btn.ModalResult := mrCancel;
end;

function TfCopiaLiturgiaDia.GetDiasSelecionados: TArray<Integer>;
var
  i, count: Integer;
begin
  count := 0;
  for i := 1 to 7 do
    if FCbDias[i].Enabled and FCbDias[i].Checked then
      Inc(count);

  SetLength(Result, count);
  count := 0;
  for i := 1 to 7 do
    if FCbDias[i].Enabled and FCbDias[i].Checked then
    begin
      Result[count] := i;
      Inc(count);
    end;
end;

function TfCopiaLiturgiaDia.GetSobrescrever: Boolean;
begin
  Result := FCbSobrescrever.Checked;
end;

end.
