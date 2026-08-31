unit fmQRCode;

{
  Janela com o QR Code de um endereço.

  A janela é montada em tempo de execução, sem .dfm, porque é simples demais
  para justificar um formulário de projeto: um quadro com o código e o texto
  do endereço embaixo.

  O código é desenhado em escala inteira - cada módulo ocupa um número exato
  de pixels. Redimensionar um QR com interpolação borra a borda dos módulos e
  faz leitor de celular falhar.
}

interface

//Exibe o QR do texto informado. Modal: a janela é pequena e serve para
//alguém apontar a câmera, então não faz sentido deixá-la solta.
procedure mostraQRCode(const texto, titulo: string);

implementation

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, DelphiZXingQRCode;

const
  //Lado desejado para a área do código, em pixels. A escala real é derivada
  //disto e arredondada para baixo, para caber em múltiplos exatos.
  LADO_ALVO = 320;

  //Sobra em volta do quadro branco, para o código não encostar na borda
  MARGEM = 16;

procedure desenhaQRCode(destino: TBitmap; const texto: string; out lado: Integer);
var
  qr: TDelphiZXingQRCode;
  escala, linha, coluna: Integer;
begin
  qr := TDelphiZXingQRCode.Create;
  try
    //UTF-8 sem BOM é o que os leitores de celular esperam num endereço
    qr.Encoding := qrUTF8NoBOM;
    //Quatro módulos de silêncio em volta são exigidos pelo padrão; sem eles
    //muita câmera não reconhece o código
    qr.QuietZone := 4;
    qr.Data := texto;

    if (qr.Rows <= 0) then
    begin
      lado := 0;
      Exit;
    end;

    escala := LADO_ALVO div qr.Rows;
    if (escala < 1) then
      escala := 1;

    lado := qr.Rows * escala;

    destino.PixelFormat := pf24bit;
    destino.SetSize(lado, lado);

    //Fundo branco sempre, independente do tema do programa: QR escuro sobre
    //claro é o que os leitores esperam
    destino.Canvas.Brush.Color := clWhite;
    destino.Canvas.FillRect(Rect(0, 0, lado, lado));
    destino.Canvas.Brush.Color := clBlack;

    for linha := 0 to qr.Rows - 1 do
      for coluna := 0 to qr.Columns - 1 do
        if qr.IsBlack[linha, coluna] then
          destino.Canvas.FillRect(
            Rect(coluna * escala, linha * escala,
                 (coluna + 1) * escala, (linha + 1) * escala));
  finally
    qr.Free;
  end;
end;

procedure mostraQRCode(const texto, titulo: string);
var
  janela: TForm;
  imagem: TImage;
  rotulo: TLabel;
  lado: Integer;
begin
  if (Trim(texto) = '') then
    Exit;

  janela := TForm.CreateNew(nil);
  try
    janela.Caption := titulo;
    janela.BorderStyle := bsDialog;
    janela.Position := poMainFormCenter;
    janela.Color := clWhite;
    //Esc fecha, como em qualquer diálogo
    janela.KeyPreview := True;

    imagem := TImage.Create(janela);
    imagem.Parent := janela;
    imagem.Left := MARGEM;
    imagem.Top := MARGEM;
    imagem.AutoSize := False;

    desenhaQRCode(imagem.Picture.Bitmap, texto, lado);
    if (lado = 0) then
      Exit;

    imagem.Width := lado;
    imagem.Height := lado;

    rotulo := TLabel.Create(janela);
    rotulo.Parent := janela;
    rotulo.Caption := texto;
    rotulo.Left := MARGEM;
    rotulo.Top := imagem.Top + imagem.Height + 10;
    rotulo.Width := lado;
    rotulo.AutoSize := False;
    rotulo.Alignment := taCenter;
    rotulo.WordWrap := True;
    rotulo.Font.Color := clBlack;

    janela.ClientWidth := lado + (MARGEM * 2);
    janela.ClientHeight := rotulo.Top + rotulo.Height + MARGEM;

    janela.ShowModal;
  finally
    janela.Free;
  end;
end;

end.
