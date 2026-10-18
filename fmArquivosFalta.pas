unit fmArquivosFalta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinCtrls,
  Vcl.ComCtrls, Data.DB, Data.Win.ADODB,
  Vcl.ExtCtrls, WinInet, Vcl.StdCtrls;

type
  TfArquivosFalta = class(TForm)
    bsSkinPanel1: TbsSkinPanel;
    bsSkinButton2: TbsSkinButton;
    btBaixa: TbsSkinButton;
    bsSkinPanel2: TbsSkinPanel;
    lvArquivos: TbsSkinListView;
    lbl1: TbsSkinStdLabel;
    gProgresso: TbsSkinGauge;
    bsSkinScrollBar8: TbsSkinScrollBar;
    lblStatus: TbsSkinStdLabel;
    tmrFecha: TTimer;
    gpBotoes: TGridPanel;
    bsSkinSpeedButton53: TbsSkinSpeedButton;
    bsSkinSpeedButton54: TbsSkinSpeedButton;
    bsSkinSpeedButton55: TbsSkinSpeedButton;
    btVerifica: TbsSkinButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure FormActivate(Sender: TObject);
    procedure verificaArquivos();
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btBaixaClick(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure tmrFechaTimer(Sender: TObject);
    procedure bsSkinSpeedButton53Click(Sender: TObject);
    procedure bsSkinSpeedButton54Click(Sender: TObject);
    procedure bsSkinSpeedButton55Click(Sender: TObject);
    procedure btVerificaClick(Sender: TObject);
  private
    { Private declarations }
    alerta: Boolean;
  public
    { Public declarations }
  end;

var
  fArquivosFalta: TfArquivosFalta;

implementation

uses
  fmMenu, fmAtualiza, dmComponentes, fmIniciando;

{$R *.dfm}

procedure TfArquivosFalta.btVerificaClick(Sender: TObject);
begin
  verificaArquivos();
end;

procedure TfArquivosFalta.bsSkinButton2Click(Sender: TObject);
begin
  tmrFecha.Enabled := False;
  alerta := False;
  DM.qrARQUIVOS_SISTEMA.Last;
  tmrFecha.Enabled := True;
end;

procedure TfArquivosFalta.bsSkinSpeedButton53Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := True;
end;

procedure TfArquivosFalta.bsSkinSpeedButton54Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := False;
end;

procedure TfArquivosFalta.bsSkinSpeedButton55Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lvArquivos.Items.Count - 1
    do lvArquivos.Items.Item[i].Checked := not lvArquivos.Items.Item[i].Checked;
end;

procedure TfArquivosFalta.btBaixaClick(Sender: TObject);
var
  lista: TStringList;
  i: integer;
  Flags: Cardinal;
  Item: TListItem;
begin
  lista := TStringList.Create;
  for i := 0 to lvArquivos.Items.Count - 1 do
  begin
    if (lvArquivos.Items.Item[i].Checked) then
      lista.Add(lvArquivos.Items.Item[i].SubItems[0]);
  end;

  if (lista.Count <= 0) then
  begin
    application.MessageBox(PChar('Nenhum arquivo selecionado!'), fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  if not (InternetGetConnectedState(@Flags, 0)) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
  fAtualiza.cancela := false;
  fAtualiza.arquivos := lista;
  fAtualiza.ShowModal;

  lvArquivos.Items.Clear;
  if (fAtualiza.cancela = true) then
  begin
    application.MessageBox(PChar('Operação cancelada!'), fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    tmrFecha.Enabled := False;
    alerta := False;
    DM.qrARQUIVOS_SISTEMA.Last;
    tmrFecha.Enabled := True;
  end
  else if (fAtualiza.arquivos_falha.Count > 0) then
  begin
    gProgresso.Value := 0;
    lblStatus.Caption := '';

    gProgresso.MaxValue := fAtualiza.arquivos_falha.Count;
    btBaixa.Enabled := False;
    btVerifica.Enabled := False;
    for i := 0 to fAtualiza.arquivos_falha.Count-1 do
    begin
      lblStatus.Caption := 'Verificando falhas... '+inttostr(DM.qrARQUIVOS_SISTEMA.RecNo)+' / '+inttostr(DM.qrARQUIVOS_SISTEMA.RecordCount);

      Item := lvArquivos.Items.Add;
      Item.Checked := True;
      Item.Caption := ExtractFileName(fAtualiza.arquivos_falha[i]);
      Item.SubItems.Add(fAtualiza.arquivos_falha[i]);
      Item.SubItems.Add('Falha no Download');

      gProgresso.Value := DM.qrARQUIVOS_SISTEMA.RecNo;
      Application.ProcessMessages;
    end;

    btBaixa.Enabled := True;
    btVerifica.Enabled := True;
    lblStatus.Caption := 'Falha no Download: '+inttostr(fAtualiza.arquivos_falha.Count);

    application.MessageBox('Alguns arquivos não puderam ser baixados!'+#13#10+'Pode ser que seu firewall ou antivírus esteja impedindo o download. Adicione este programa à lista de exeções ou desative temporariamente o firewall e antivírus, tente novamente.', fmIndex.titulo, mb_ok + MB_ICONINFORMATION);
//    if (application.MessageBox('Alguns arquivos não puderam ser baixados!'+#13#10+'Pode ser que seu firewall ou antivírus esteja impedindo o download. Adicione este programa à lista de exeções ou desative temporariamente o firewall e antivírus para baixar os arquivos.'+#13#10+#13#10+'Deseja tentar baixá-los novamente?', fmIndex.titulo, mb_yesno + mb_iconquestion) = 6) then
//    begin
//      btBaixaClick(Sender);
//      Exit;
//    end;
  end
  else
  begin
    if (fAtualiza.erro <> true) then
      application.MessageBox(PChar('Arquivos atualizados com sucesso!'), fmIndex.titulo, mb_ok + mb_iconinformation);
    tmrFecha.Enabled := False;
    alerta := False;
    DM.qrARQUIVOS_SISTEMA.Last;
    tmrFecha.Enabled := True;
  end;
end;

procedure TfArquivosFalta.FormActivate(Sender: TObject);
begin
  verificaArquivos();
end;

procedure TfArquivosFalta.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  alerta := true;
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfArquivosFalta.tmrFechaTimer(Sender: TObject);
begin
  lblStatus.Caption := '';
  Close;
end;

//Existencia e tamanho numa chamada so ao sistema de arquivos, em vez de um
//FileExists seguido de um FileSize. Pasta nao conta como arquivo.
//
//O tamanho vinha de fmIndex.FileSize(url), com o caminho RELATIVO, enquanto a
//existencia era conferida no caminho absoluto. Fora da pasta do exe o relativo
//nao resolvia, o tamanho voltava -1 e a checagem de arquivo danificado nunca
//rodava: truncado passava por integro.
function dadosDoArquivo(const caminho: string; out tamanho: Int64): Boolean;
var
  info: TWin32FileAttributeData;
begin
  tamanho := -1;

  Result := GetFileAttributesEx(PChar(caminho), GetFileExInfoStandard, @info);
  if not Result then
    Exit;

  Result := (info.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0;
  if Result then
    tamanho := Int64(info.nFileSizeHigh) shl 32 or Int64(info.nFileSizeLow);
end;

procedure TfArquivosFalta.verificaArquivos;
const
  //De quantos em quantos arquivos a tela acompanha a varredura.
  PASSO_INTERFACE = 100;
var
  Item: TListItem;
  existe: Boolean;
  a_sim,a_nao: Integer;
  tamanho: Int64;
  url, completo: string;
  usa_mp3: Boolean;
  lidos: Integer;

  procedure mostraProgresso;
  begin
    lblStatus.Caption := 'Verificando... ' +
      inttostr(DM.qrARQUIVOS_SISTEMA.RecNo) + ' / ' +
      inttostr(DM.qrARQUIVOS_SISTEMA.RecordCount);
    gProgresso.Value := DM.qrARQUIVOS_SISTEMA.RecNo;
    Application.ProcessMessages;
  end;

begin
  gpBotoes.Visible := False;

  alerta := true;
  gProgresso.Value := 0;
  lvArquivos.Items.Clear;
  lblStatus.Caption := '';
  a_sim := 0;
  a_nao := 0;
  lidos := 0;

  DM.qrARQUIVOS_SISTEMA.Close;
  DM.qrARQUIVOS_SISTEMA.Open;
  DM.qrARQUIVOS_SISTEMA.First;
  gProgresso.MaxValue := DM.qrARQUIVOS_SISTEMA.RecordCount;
  btBaixa.Enabled := False;
  btVerifica.Enabled := False;
  //Sem isto o ListView recalcula o layout e repinta a cada item inserido.
  //Numa instalacao nova, com milhares de arquivos em falta, e o que trava a
  //tela: assim ele desenha a lista uma vez, no fim.
  lvArquivos.Items.BeginUpdate;
  try
    while not DM.qrARQUIVOS_SISTEMA.eof do
    begin
      url := DM.qrARQUIVOS_SISTEMA.FieldByName('URL').AsString;
      if (fIniciando.paramexec.Strings.Values['dir_config'] <> '') then
        url := StringReplace(url,'config\',fIniciando.paramexec.Strings.Values['dir_config']+'\',[rfIgnoreCase, rfReplaceAll]);
  //      showmessage(url);
      completo := ExtractFilePath(application.ExeName)+'/'+url;
      existe := dadosDoArquivo(completo, tamanho);

      //Transicao mp3 -> opus: quem ja tem o .mp3 de mesmo nome nao precisa
      //baixar o .opus. O TAMANHO do registro e o do opus, entao nesse caso
      //nao faz sentido conferir o tamanho do arquivo.
      usa_mp3 := False;
      if not existe then
      begin
        usa_mp3 := (fmIndex.audioComAlternativaMp3(completo) <> completo);
        existe := usa_mp3;
      end;

      if not existe then
      begin
        Item := lvArquivos.Items.Add;
        Item.Checked := not existe;
        Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
        Item.SubItems.Add(url);
        a_nao := a_nao + 1;
        Item.SubItems.Add('Não encontrado');
      end
      else if usa_mp3 then
        a_sim := a_sim + 1
      else if (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger > 0) then
      begin
        if (tamanho >= 0) and (tamanho < DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger) then
        begin
          Item := lvArquivos.Items.Add;
          Item.Checked := True;
          Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
          Item.SubItems.Add(url);
          Item.SubItems.Add('Danificado');
          a_nao := a_nao + 1;
        end
        else a_sim := a_sim + 1;
      end
      else a_sim := a_sim + 1;

      Inc(lidos);
      if (lidos mod PASSO_INTERFACE = 0) then
        mostraProgresso;

      DM.qrARQUIVOS_SISTEMA.Next;
    end;

  finally
    lvArquivos.Items.EndUpdate;
  end;

  gProgresso.Value := gProgresso.MaxValue;
  btBaixa.Enabled := True;
  btVerifica.Enabled := True;
  lblStatus.Caption := 'Encontrados: '+inttostr(a_sim)+#13#10+'Em falta/danificado(s): '+inttostr(a_nao);

  if (alerta) and (a_nao <= 0) then
  begin
    application.MessageBox('Sua coletânea está completa! Nenhum arquivo está faltando.', fmIndex.titulo, mb_ok + MB_ICONINFORMATION);
  end
  else if (alerta) then
  begin
    if (application.MessageBox(PChar('Sua coletânea possui '+inttostr(a_nao) + ' arquivo(s) faltando ou danificado(s)!' + #13#10 + 'Deseja baixar estes arquivos agora? (necessário conexão com a internet)'), fmIndex.titulo, mb_yesno + mb_iconquestion) = 6) then
      btBaixaClick(nil)
  end;

  gpBotoes.Visible := True;
end;

end.


