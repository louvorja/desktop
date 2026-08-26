unit fmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.MMSystem, System.SysUtils,
  System.Variants, System.Classes, System.Math, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.MPlayer;

type
  TfPlayer = class(TForm)
    Panel1: TPanel;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    procedure ajustaProporcao;
  end;

var
  fPlayer: TfPlayer;

implementation

{$R *.dfm}

uses fmMenu, dmComponentes;

procedure TfPlayer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TfPlayer.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if (fPlayer.AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := fPlayer.AlphaBlendValue downto 0 do
      begin
        fPlayer.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fPlayer.AlphaBlendValue := 0;
  end;

  //Stop exige o device aberto; sem a guarda ele levanta EMCIDeviceError sempre
  //que o Open falhou antes
  if (fmIndex.MediaPlayer1.DeviceID <> 0) then
    fmIndex.MediaPlayer1.Stop;
  fmIndex.MediaPlayer1.Close;
  fmIndex.MediaPlayer1.FileName := '';
  fmIndex.pnlPlayer.Visible := False;
  fmIndex.lblPlayer.Caption := '';
  DM.tmrPlayer.Enabled := False;
  fmIndex.pbPlayer.Value := 0;
end;

procedure TfPlayer.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

//Encaixa o video na area preservando a proporcao original. Preencher a area
//inteira, como era feito antes, distorce qualquer video cuja proporcao nao
//seja a mesma da tela. As sobras ficam pretas, cor do Panel1.
procedure TfPlayer.ajustaProporcao;
var
  consulta: TMCI_Anim_Rect_Parms;
  area, destino: TRect;
  larg, alt, w, h: Integer;
  escala: Double;
begin
  area := Panel1.ClientRect;

  larg := 0;
  alt := 0;

  //O MCI devolve o retangulo da origem como (esquerda, topo, largura, altura)
  FillChar(consulta, SizeOf(consulta), 0);
  if (fmIndex.MediaPlayer1.DeviceID <> 0)
    and (mciSendCommand(fmIndex.MediaPlayer1.DeviceID, MCI_WHERE,
                        MCI_ANIM_WHERE_SOURCE, DWORD_PTR(@consulta)) = 0) then
  begin
    larg := consulta.rc.Right;
    alt := consulta.rc.Bottom;
  end;

  //Sem dimensao conhecida (audio, ou formato que o MCI nao informa):
  //mantem o comportamento anterior
  if (larg <= 0) or (alt <= 0) then
  begin
    fmIndex.MediaPlayer1.DisplayRect := area;
    Exit;
  end;

  escala := Min(area.Width / larg, area.Height / alt);
  w := Round(larg * escala);
  h := Round(alt * escala);

  //Atencao: o MCI le este retangulo como (esquerda, topo, LARGURA, ALTURA),
  //e nao como coordenadas. Preencher Right/Bottom com as bordas faz o video
  //passar da tela. A propria VCL usa essa convencao em SetDisplayRect.
  destino.Left := area.Left + (area.Width - w) div 2;
  destino.Top := area.Top + (area.Height - h) div 2;
  destino.Right := w;
  destino.Bottom := h;

  fmIndex.MediaPlayer1.DisplayRect := destino;
end;

procedure TfPlayer.FormResize(Sender: TObject);
begin
  ajustaProporcao;
end;

end.
