unit fmLiturgia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls,
  bsdbctrls, bsribbon, Data.DB, Data.Win.ADODB, bsColorCtrls, StrUtils, ShellApi,
  Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfLiturgia = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel2: TGridPanel;
    btAdd: TbsSkinButton;
    bsSkinPanel1: TbsSkinPanel;
    lblItem: TbsSkinLabel;
    txtItem: TbsSkinEdit;
    bsSkinLabel2: TbsSkinLabel;
    cbItens: TbsSkinComboBox;
    ScrollBox1: TScrollBox;
    dsHinos: TDataSource;
    qrHinos: TFDQuery;
    pnlHinos: TbsSkinPanel;
    bsRibbonDivider10: TbsRibbonDivider;
    bsSkinPanel2: TbsSkinPanel;
    opcHinosOpc1: TbsSkinRadioButton;
    pnlHinosOpc1: TbsSkinPanel;
    skLitLabel: TbsSkinStdLabel;
    bsSkinPanel4: TbsSkinPanel;
    dbLitHinoLista: TbsSkinDBLookupComboBox;
    csCor: TbsSkinColorButton;
    bsSkinLabel3: TbsSkinLabel;
    btDel: TbsSkinButton;
    pnlAnotacoes: TbsSkinPanel;
    bsRibbonDivider1: TbsRibbonDivider;
    bsSkinPanel6: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    pnlSite: TbsSkinPanel;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    edtAnotacao: TbsSkinEdit;
    bsRibbonDivider2: TbsRibbonDivider;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    urlSite: TbsSkinURLEdit;
    bsSkinSpeedButton2: TbsSkinSpeedButton;
    pnlArquivo: TbsSkinPanel;
    bsRibbonDivider3: TbsRibbonDivider;
    bsSkinPanel7: TbsSkinPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    edtDiretorio: TbsSkinEdit;
    bsSkinSpeedButton3: TbsSkinSpeedButton;
    bsSkinSpeedButton4: TbsSkinSpeedButton;
    edtDiretorioInfo: TbsSkinEdit;
    pnlItensAgendados: TbsSkinPanel;
    bsRibbonDivider4: TbsRibbonDivider;
    bsSkinPanel8: TbsSkinPanel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    dblItem: TDBLookupComboBox;
    bsSkinPanel5: TbsSkinPanel;
    procedure cbItensChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure executaOpcoes();
    procedure opcHinosOpc1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure txtItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton2Click(Sender: TObject);
    function validaURL(url: string): string;
    procedure urlSiteExit(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure edtDiretorioEnter(Sender: TObject);
    procedure edtDiretorioExit(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    procedure ajustaOpcoesArquivo;
  public
    { Public declarations }
    id: string;
    arquivoInicial: string;
  end;

var
  fLiturgia: TfLiturgia;

implementation

{$R *.dfm}

uses fmMenu, fmBuscaMusica, dmComponentes, fmIniciando;

const
  AVISO_SEM_PASTA =
    'Na guia Avulsa só é possível usar arquivos, não pastas.'#13#10#13#10 +
    'A liturgia avulsa é guardada dentro do pacote .llja, e uma pasta não '
    + 'pode viajar dentro dele.';

procedure TfLiturgia.edtDiretorioEnter(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, true);
end;

procedure TfLiturgia.edtDiretorioExit(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, false);
  edtDiretorio.SelStart := Length(edtDiretorio.Text);
  edtDiretorio.Perform(EM_SCROLLCARET, 0, 0);
end;

procedure TfLiturgia.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
  fBuscaMusica.ShowModal;
  if (fBuscaMusica.id) > 0
    then dbLitHinoLista.KeyValue := fBuscaMusica.id;
end;

procedure TfLiturgia.bsSkinSpeedButton2Click(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
  fmIndex.abrirArquivo(urlSite.Text);
end;

//Na guia Avulsa só arquivo: a liturgia mora dentro do .llja, e a
//sincronização copia para dentro do pacote o arquivo que o item aponta --
//o que não existe para diretório. Um item de pasta ficaria preso a esta
//máquina e daria "não encontrado" na outra, que é por isso que a exportação
//de um dia normal já converte pasta em anotação. Aqui a opção nem aparece.
procedure TfLiturgia.ajustaOpcoesArquivo;
var
  avulsa: Boolean;
begin
  avulsa := fmIndex.liturgiaAvulsaAberta;

  bsSkinSpeedButton3.Visible := not avulsa;

  if avulsa
    then bsSkinStdLabel3.Caption := 'Arquivo:'
    else bsSkinStdLabel3.Caption := 'Arquivo/Diretório:';
end;

procedure TfLiturgia.bsSkinSpeedButton3Click(Sender: TObject);
var
  dir: string;
begin
  //O botão fica oculto na Avulsa; a guarda é barata e cobre o clique que
  //venha de outro caminho.
  if fmIndex.liturgiaAvulsaAberta then
  begin
    Application.MessageBox(AVISO_SEM_PASTA, fmIndex.titulo,
                           mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  dir := fmIndex.openDialog('pasta', '', 'Liturgia',false,edtDiretorio.Text);
  if dir <> '' then edtDiretorio.Text := dir;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.bsSkinSpeedButton4Click(Sender: TObject);
var
  arq, inicial: string;
begin
  inicial := ExtractFilePath(edtDiretorio.Text);

  //Sem caminho digitado, a guia Avulsa abre o seletor nos arquivos do .llja.
  if (Trim(inicial) = '') then
    inicial := fmIndex.pastaInicialSeletorLiturgia;

  arq := fmIndex.openDialog('arquivo', '', 'Liturgia', False, inicial);
  if arq <> '' then edtDiretorio.Text := arq;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.btAddClick(Sender: TObject);
var
  semana: string;
  tipo: string;
  subitem: string;
  param: string;
  itens: array of TParamItem;

  procedure Add(const p, v: string);
  begin
    SetLength(itens, Length(itens)+1);
    itens[High(itens)].Grupo := id;
    itens[High(itens)].Param := p;
    itens[High(itens)].Valor := v;
  end;
begin
  if (cbItens.ItemIndex < 0) then
  begin
    application.MessageBox('Escolha o tipo de item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    cbItens.SetFocus;
    Exit;
  end;

  if (txtItem.Visible) and (Trim(txtItem.Text) = '') then
  begin
    application.MessageBox('Defina o nome do item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    txtItem.SetFocus;
    Exit;
  end;

  if (pnlItensAgendados.Visible) and (trim(dblItem.KeyValue) = '') then
  begin
    application.MessageBox('Escolha o item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    dblItem.SetFocus;
    Exit;
  end;

  semana := fmIndex.loadCol.Strings.Values['LITURGIA:SEMANA'];

  if (Trim(id) = '') then
    id := 'item_'+FormatDateTime('yyyymmddhhnnsszzz', Now);

  tipo := '';
  case cbItens.ItemIndex of
    0: tipo := 'anotacao';
    1: tipo := 'arquivo';
    2: tipo := 'categoria';
    3: tipo := 'itensagendados';
    4: tipo := 'musica';
    5: tipo := 'site';
  end;

  Add('tipo', tipo);
  Add('item', txtItem.Text);
  Add('cor', ColorToString(csCor.ColorValue));

  try
    fmIndex.gravaLog('btAddClick: pre-build id=' + id + ' pnlArquivo=' + BoolToStr(pnlArquivo.Visible, True) + ' edtDiretorio=' + edtDiretorio.Text + ' edtDiretorioInfo=' + edtDiretorioInfo.Text);
  except
    // silencioso
  end;

  if (pnlAnotacoes.Visible) then
  begin
    Add('subitem', edtAnotacao.Text);
  end
  else
  if (pnlItensAgendados.Visible) then
  begin
    Add('item', dblItem.Text);
    Add('subitem', '');
    Add('id', dblItem.KeyValue);
  end
  else
  if (pnlSite.Visible) then
  begin
    urlSite.text := validaURL(urlSite.text);
    Add('subitem', 'Site '+urlSite.Text);
    Add('url', urlSite.Text);
  end
  else
  if (pnlArquivo.Visible) then
  begin
    edtDiretorio.Text := trim(edtDiretorio.Text);
    if (edtDiretorioInfo.Text = 'I')
      then param := ExtractFilePath(Application.ExeName)+edtDiretorio.Text
      else param := edtDiretorio.Text;

    //O botão de diretório não aparece na Avulsa, mas o caminho pode ter
    //sido digitado ou vir de um arrastar-e-soltar. Ver ajustaOpcoesArquivo.
    if fmIndex.liturgiaAvulsaAberta and
       ((Copy(param, Length(param), 1) = PathDelim) or
        DirectoryExists(param)) then
    begin
      Application.MessageBox(AVISO_SEM_PASTA, fmIndex.titulo,
                             mb_ok + MB_ICONEXCLAMATION);
      if edtDiretorio.CanFocus then edtDiretorio.SetFocus;
      Exit;
    end;

    if (Copy(param,Length(param),1) = '\') then
    begin
      Add('subtipo', 'dir');
      Add('subitem', 'Pasta '+edtDiretorio.Text);
    end
    else if FileExists(param) then
    begin
      Add('subtipo', 'arq');
      Add('subitem', 'Arquivo '+edtDiretorio.Text);
    end
    else if DirectoryExists(param) then
    begin
      edtDiretorio.Text := edtDiretorio.Text+'\';
      Add('subtipo', 'dir');
      Add('subitem', 'Pasta '+edtDiretorio.Text);
    end
    else
    begin
      Add('subtipo', 'arq');
      Add('subitem', 'Arquivo '+edtDiretorio.Text);
    end;

    Add('dir', edtDiretorio.Text);
    Add('dir_info', edtDiretorioInfo.Text);
  end
  else
  if (pnlHinos.Visible) then
  begin
    if (dbLitHinoLista.KeyValue < 0)
      then opcHinosOpc1.Checked := true;

    if opcHinosOpc1.Checked then
    begin
      Add('escolha', '1');
      Add('musica', '-1');
      Add('subtipo', 'escolha');
      subitem := 'Clique para escolher a música';
      Add('subitem', subitem);
    end
    else
    begin
      Add('escolha', '0');
      Add('musica', IntToStr(dbLitHinoLista.KeyValue));
      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then Add('subtipo', 'hasd')
      else if (qrHinos.FieldByName('TIPO_JA').AsString = 'S')
        then Add('subtipo', 'ja')
      else Add('subtipo', 'div');

      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then subitem := 'Hino nº '
        else subitem := 'Música ';
      subitem := subitem + qrHinos.FieldByName('NOME').AsString;
      Add('subitem', subitem);
    end;
  end;

  fmIndex.gravaParamLote(fmIndex.arq_liturgia, itens);

  try
    fmIndex.gravaLog('btAddClick: salvando item ' + id + ' tipo=' + tipo);
  except
    // silencioso: log falhou -> continua
  end;

  if fmIndex.lbLiturgia.Items.IndexOf(id) < 0 then
  begin
    fmIndex.lbLiturgia.Items.Add(id);
    fmIndex.salvaItensLiturgia;
    fmIndex.carregaItemLiturgia(id,fmIndex.lbLiturgia.Items.Count);
  end
  else fmIndex.carregaItemLiturgia(id);

  close;
end;

procedure TfLiturgia.btDelClick(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente excluir este item?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;
  fmIndex.apagaItemLiturgia(id);
  Close;
end;

procedure TfLiturgia.cbItensChange(Sender: TObject);
const
  IDX_ANOTACAO       = 0;
  IDX_ARQUIVO        = 1;
  IDX_ITENSAGENDADOS = 3;
  IDX_MUSICA         = 4;
  IDX_SITE           = 5;
var
  idx: Integer;
begin
  idx := cbItens.ItemIndex;

  pnlAnotacoes.Visible      := (idx = IDX_ANOTACAO);
  pnlArquivo.Visible        := (idx = IDX_ARQUIVO);
  pnlItensAgendados.Visible := (idx = IDX_ITENSAGENDADOS);
  pnlHinos.Visible          := (idx = IDX_MUSICA);
  pnlSite.Visible           := (idx = IDX_SITE);

  lblItem.Visible := not pnlItensAgendados.Visible;
  txtItem.Visible := not pnlItensAgendados.Visible;

  ajustaOpcoesArquivo;

  if idx < 0 then Exit;
  executaOpcoes;
end;

procedure TfLiturgia.executaOpcoes;
var
  item: string;
begin
  try
    if (pnlHinos.Visible) then
    begin
      opcHinosOpc1Click(nil);
      qrHinos.Close;
      qrHinos.Open;
    end
    else if pnlItensAgendados.Visible then
    begin
      item := '';
      if (dblItem.KeyValue <> null) then
        item := dblItem.KeyValue;
      if not DM.cdsCategoriasItensAgendados.Active then
      begin
        DM.cdsCategoriasItensAgendados.CreateDataSet;
        DM.cdsCategoriasItensAgendados.IndexName := '';
        DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
        DM.cdsCategoriasItensAgendados.LogChanges := False;
      end;

      if (FileExists(fmIndex.dir_dados + 'itensAgendadosCategorias.xml')) then
        DM.cdsCategoriasItensAgendados.LoadFromFile(fmIndex.dir_dados + 'itensAgendadosCategorias.xml');
      DM.cdsCategoriasItensAgendados.Open;
      dblItem.KeyValue := item;
    end;
  except
    // Silencioso - erros em opções não devem quebrar a UI
  end;
end;

procedure TfLiturgia.FormActivate(Sender: TObject);
var
  tipo: string;
  idx: Integer;
  function FindIndexForTipo(const code: string): Integer;
  var
    i: Integer;
    c: string;
  begin
    Result := -1;
    if Trim(code) = '' then Exit;
    // try direct code-index mapping (legacy behavior)
    Result := AnsiIndexStr(code, ['anotacao','arquivo','categoria','itensagendados','musica','site']);
    if (Result >= 0) and (Result < cbItens.Items.Count) then Exit;

    // fallback: match by partial label (case-insensitive)
    for i := 0 to cbItens.Items.Count - 1 do
    begin
      c := cbItens.Items[i];
      if AnsiContainsText(c, 'Anot') and ((code = 'anotacao')) then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Arquiv') or AnsiContainsText(c, 'Diretor') or AnsiContainsText(c, 'Diret')) and (code = 'arquivo') then
      begin
        Result := i; Exit;
      end;
      if AnsiContainsText(c, 'Categor') and (code = 'categoria') then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Itens') or AnsiContainsText(c, 'Agend')) and (code = 'itensagendados') then
      begin
        Result := i; Exit;
      end;
      if (AnsiContainsText(c, 'Músic') or AnsiContainsText(c, 'Musica') or AnsiContainsText(c, 'Hino')) and (code = 'musica') then
      begin
        Result := i; Exit;
      end;
      if AnsiContainsText(c, 'Site') and (code = 'site') then
      begin
        Result := i; Exit;
      end;
    end;
  end;
begin
  pnlAnotacoes.Visible := False;
  pnlHinos.Visible := False;
  pnlSite.Visible := False;
  pnlArquivo.Visible := False;
  pnlItensAgendados.Visible := False;
  ScrollBox1.Visible := True;

  if (Trim(id) = '') then
  begin
    btAdd.Caption := ' Adicionar';
    btAdd.ImageIndex := 44;
    btDel.Visible := False;
  end
  else
  begin
    btAdd.Caption := ' Salvar';
    btAdd.ImageIndex := 2;
    btDel.Visible := True;
  end;

  try
    fmIndex.gravaLog('FormActivate: carrega item ' + id);
    tipo := fmIndex.lerParam(id, 'tipo', '', fmIndex.arq_liturgia);

    // Prefill simple controls that do not require datasets
    if tipo = 'anotacao' then
      edtAnotacao.Text := fmIndex.lerParam(id, 'subitem', '', fmIndex.arq_liturgia)
    else
      edtAnotacao.Text := '';

    if tipo = 'site' then
      urlSite.Text := fmIndex.lerParam(id, 'url', '', fmIndex.arq_liturgia)
    else
      urlSite.Text := '';

    if tipo = 'arquivo' then
    begin
      edtDiretorio.Text := fmIndex.lerParam(id, 'dir', '', fmIndex.arq_liturgia);
      edtDiretorioInfo.Text := fmIndex.lerParam(id, 'dir_info', '', fmIndex.arq_liturgia);
      edtDiretorio.SelStart := Length(edtDiretorio.Text);
      edtDiretorio.Perform(EM_SCROLLCARET, 0, 0);
    end
    else
    begin
      edtDiretorio.Text := '';
      edtDiretorioInfo.Text := '';
    end;

      opcHinosOpc1.Checked := (fmIndex.lerParam(id, 'escolha', '0', fmIndex.arq_liturgia) = '1');
      txtItem.Text := fmIndex.lerParam(id, 'item', '', fmIndex.arq_liturgia);
      csCor.ColorValue := StringToColor(fmIndex.lerParam(id, 'cor', '$004F0000', fmIndex.arq_liturgia));

      // Map and set ItemIndex so cbItensChange opens datasets before KeyValue assignment
      try
        idx := FindIndexForTipo(tipo);
        if idx >= 0 then
          cbItens.ItemIndex := idx
        else
        begin
          cbItens.ItemIndex := -1;
          fmIndex.gravaLog('FormActivate: tipo desconhecido para item ' + id + ' -> "' + tipo + '"');
        end;
      except
        cbItens.ItemIndex := -1;
        fmIndex.gravaLog('FormActivate: erro ao mapear tipo para item ' + id);
      end;

    // Ensure datasets and lookup lists are initialized
    cbItensChange(Sender);

    // Now safe to assign DB lookup KeyValues
    if tipo = 'itensagendados' then
      dblItem.KeyValue := fmIndex.lerParam(id, 'id', '', fmIndex.arq_liturgia)
    else
      dblItem.KeyValue := '';

    dbLitHinoLista.KeyValue := fmIndex.lerParam(id, 'musica', '-1', fmIndex.arq_liturgia);

  except
    cbItens.ItemIndex := -1;
    try fmIndex.gravaLog('FormActivate: excecao ao carregar item ' + id); except end;
  end;

  // Pré-preenchimento via drag-and-drop de arquivo na liturgia
  if (Trim(arquivoInicial) <> '') and (Trim(id) = '') then
  begin
    cbItens.ItemIndex := 1; // Arquivo
    cbItensChange(nil);
    edtDiretorio.Text := arquivoInicial;
    edtDiretorioExit(nil);
    arquivoInicial := '';
    if txtItem.CanFocus then txtItem.SetFocus;
  end;
end;

procedure TfLiturgia.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfLiturgia.opcHinosOpc1Click(Sender: TObject);
begin
  pnlHinosOpc1.Visible := not opcHinosOpc1.Checked;
end;

procedure TfLiturgia.txtItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.edtKeyUp(Sender,Key,Shift);
end;

procedure TfLiturgia.urlSiteExit(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
end;

function TfLiturgia.validaURL(url: string): string;
begin
  if (Copy(url,1,7) <> 'http://') and
     (Copy(url,1,8) <> 'https://') and
     (Copy(url,1,6) <> 'ftp://')
    then url := 'http://'+url;

  Result := url;
end;

end.
