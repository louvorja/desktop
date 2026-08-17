unit fmListaMusica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinCtrls,
  bsdbctrls, Vcl.ExtCtrls, Vcl.DBCGrids,
  bsPngImageList, Vcl.StdCtrls;

type
  TfListaMusica = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    Panel1: TPanel;
    imgCapa: TImage;
    GridPanel1: TGridPanel;
    lblTitulo: TbsSkinStdLabel;
    lblSubtitulo: TbsSkinStdLabel;
    DBCtrlGrid: TDBCtrlGrid;
    Panel2: TPanel;
    GridPanel2: TGridPanel;
    bsSkinDBText1: TbsSkinDBText;
    ico: TbsPngImageView;
    bsSkinDBText2: TbsSkinDBText;
    Panel3: TPanel;
    pnlBotoes: TPanel;
    lblDicaPB: TbsSkinStdLabel;
    bsSkinSpeedButton6: TbsSkinSpeedButton;
    btExp_MenuMusicas: TbsSkinMenuSpeedButton;
    bsPngImageView1: TbsPngImageView;
    btSlidePB: TbsPngImageView;
    btMusica: TbsPngImageView;
    btMusicaPB: TbsPngImageView;
    btLetra: TbsPngImageView;
    btSlideLetra: TbsPngImageView;
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBCtrlGridClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton6Click(Sender: TObject);
    procedure btExp_MenuMusicasClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBCtrlGridPaintPanel(DBCtrlGrid: TDBCtrlGrid; Index: Integer);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btExp_MenuMusicasShowTrackMenu(Sender: TObject);
  private
    { Private declarations }
    // Estado da linha ativa, guardado enquanto o painel dela e pintado
    ativoConhecido, ativoSlide, ativoPB, ativoAudio, ativoAudioPB,
    ativoLetra: boolean;
    reaplicando: boolean;
    wpGrid: TWndMethod;
    procedure aplicaBotoesItem(slide, temPB, temAudio, temAudioPB,
      temLetra: boolean);
    procedure restauraLinhaAtiva;
    procedure gridWindowProc(var Message: TMessage);
  public
    { Public declarations }
    id_album: integer;
    dir: string;
    inicio: Boolean;
  end;

var
  fListaMusica: TfListaMusica;

implementation

{$R *.dfm}

uses fmMenu, dmComponentes, fmMonitorMenuMusicas, Data.DB;

procedure TfListaMusica.bsSkinSpeedButton6Click(Sender: TObject);
begin
  //Coletanea personalizada: a fila e a pasta, nao um album do banco
  if (DBCtrlGrid.DataSource <> DM.dsMUSICAS) then
    fmIndex.abreSlidesPasta(dir)
  else
    fmIndex.abreLetraMusicaAlbum(DM.qrMUSICAS.FieldByName('ID_ALBUM').AsInteger);
end;

procedure TfListaMusica.btExp_MenuMusicasClick(Sender: TObject);
begin
  fmIndex.expandirArea(Sender);
end;

procedure TfListaMusica.btExp_MenuMusicasShowTrackMenu(Sender: TObject);
var
  tag: integer;
begin
  fmIndex.botao_trmenu := TbsSkinMenuSpeedButton(Sender);
  tag := fmIndex.botao_trmenu.tag;
  fmIndex.monitores(tag);
end;

procedure TfListaMusica.DBCtrlGridClick(Sender: TObject);
var
  ds: TDataSet;
  tag: integer;
begin
  if DBCtrlGrid.DataSource = DM.dsMUSICAS then
  begin
    fmIndex.dbctrlMusicasClick(Sender);
    Exit;
  end;

  ds := DBCtrlGrid.DataSource.DataSet;
  tag := TComponent(Sender).Tag;

  // Fora dos pacotes de slides nao ha botao algum: o clique so pode ter vindo
  // do corpo do item, que abre o arquivo como sempre abriu. No corpo de um
  // pacote vale o mesmo, e DIR ja aponta para a versao cantada - ou para o
  // playback, quando so ele existe.
  if (tag < 1) or (tag > 5) or not ds.FieldByName('EH_SLIDE').AsBoolean
    then fmIndex.abrirArquivo(ds.FieldByName('DIR').AsString)
    else fmIndex.abreSlidesArquivo(ds.FieldByName('DIR').AsString,
                                   ds.FieldByName('DIR_PB').AsString, tag);
end;

{
  Configura os botoes do item para um registro.

  Os botoes sao um jogo unico, compartilhado por todas as linhas: o grid
  reconfigura e redesenha esse mesmo jogo uma vez por linha. Por isso tudo o
  que distingue uma linha da outra passa por aqui.
}
procedure TfListaMusica.aplicaBotoesItem(slide, temPB, temAudio, temAudioPB,
  temLetra: boolean);
begin
  bsPngImageView1.Visible := slide;
  btSlideLetra.Visible := slide;
  btLetra.Visible := slide and temLetra;
  btSlidePB.Visible := slide and temPB;
  // Sem faixa no pacote nao ha o que tocar sozinho
  btMusica.Visible := slide and temAudio;
  btMusicaPB.Visible := slide and temPB and temAudioPB;

  if btSlidePB.Visible
    then GridPanel2.ColumnCollection[4].Value := 40
    else GridPanel2.ColumnCollection[4].Value := 0;
  if btMusicaPB.Visible
    then GridPanel2.ColumnCollection[7].Value := 40
    else GridPanel2.ColumnCollection[7].Value := 0;
end;

{
  Reaplica na linha ativa o estado que e dela.

  Na linha ativa os botoes nao sao pixels ja gravados: sao as janelas reais,
  sobrepostas ao painel. O grid desenha uma linha de cada vez reconfigurando
  esse mesmo jogo de botoes, entao ao fim da passada eles ficam com o estado do
  ultimo registro desenhado - e era isso que a linha ativa exibia.

  Tem de ser depois da passada inteira: dentro do OnPaintPanel os controles
  filhos daquela linha ainda nao foram desenhados, e mexer neles ali estraga o
  desenho da propria linha.
}
procedure TfListaMusica.restauraLinhaAtiva;
begin
  if not ativoConhecido or reaplicando then
    Exit;

  reaplicando := True;
  try
    aplicaBotoesItem(ativoSlide, ativoPB, ativoAudio, ativoAudioPB, ativoLetra);
  finally
    reaplicando := False;
  end;
end;

{
  O WM_PAINT do grid so retorna depois de desenhados todos os paineis, entao e
  aqui que da para deixar os botoes como a linha ativa pede.

  Sendo sincrono, tambem acerta o clique: WMLButtonDown chama SetPanelIndex, que
  repinta o grid na hora, e so entao usa WindowFromPoint para saber em que botao
  o usuario clicou. Com o layout do registro anterior as colunas de playback
  deslocavam os botoes em 40px e o clique caia no vizinho.
}
procedure TfListaMusica.gridWindowProc(var Message: TMessage);
begin
  wpGrid(Message);
  if (Message.Msg = WM_PAINT) then
    restauraLinhaAtiva;
end;

procedure TfListaMusica.DBCtrlGridPaintPanel(DBCtrlGrid: TDBCtrlGrid;
  Index: Integer);
var
  ds: TDataSet;
  slide, temPB, temAudio, temAudioPB, temLetra: boolean;
begin
  if (DBCtrlGrid.DataSource = nil) or (DBCtrlGrid.DataSource.DataSet = nil) then
    Exit;

  ds := DBCtrlGrid.DataSource.DataSet;

  if (DBCtrlGrid.DataSource = DM.dsMUSICAS) then
  begin
    slide := True;
    temPB := (ds.FieldByName('URL_INSTRUMENTAL').AsString <> '');
    temAudio := True;
    temAudioPB := temPB;
    temLetra := True;
  end
  else
  begin
    // Coletanea personalizada: so os pacotes de slides tem o que oferecer.
    // Qualquer outro arquivo segue sem botao nenhum, como sempre foi.
    slide := ds.FieldByName('EH_SLIDE').AsBoolean;
    temPB := ds.FieldByName('DIR_PB').AsString <> '';
    temAudio := ds.FieldByName('TEM_AUDIO').AsBoolean;
    temAudioPB := ds.FieldByName('TEM_AUDIO_PB').AsBoolean;
    // A letra sozinha nao entra nas personalizadas: exigiria outro form
    temLetra := False;
  end;

  aplicaBotoesItem(slide, temPB, temAudio, temAudioPB, temLetra);

  // Guarda o que a linha ativa pede; restauraLinhaAtiva devolve isso ao fim
  if (Index = DBCtrlGrid.PanelIndex) then
  begin
    ativoSlide := slide;
    ativoPB := temPB;
    ativoAudio := temAudio;
    ativoAudioPB := temAudioPB;
    ativoLetra := temLetra;
    ativoConhecido := True;
  end;
end;

procedure TfListaMusica.FormActivate(Sender: TObject);
var
  sr : TSearchRec;
  iRetorno : Integer;
  i: integer;
  naoSlides, comCantado, semAudio: integer;
  ext, nome, chave, arqCantado, arqPB: string;
  ehPB, ehSlide, temAudio, temAudioPB: boolean;
  ordem, dados: TStringList;
begin
  if (inicio <> true) then
  begin
    inicio := True;

    fmIndex.monitor_bt_label(btExp_MenuMusicas);

    // O WM_PAINT do grid so termina depois de desenhados todos os paineis:
    // e de la que a linha ativa recupera o estado que e dela
    wpGrid := DBCtrlGrid.WindowProc;
    DBCtrlGrid.WindowProc := gridWindowProc;

    bsPngImageView1.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btSlidePB.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btSlideLetra.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btMusica.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btMusicaPB.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btLetra.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);

    // Na pasta estes so aparecem se o conteudo dela permitir
    lblDicaPB.Visible := False;
    bsSkinSpeedButton6.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);
    btExp_MenuMusicas.Visible := (DBCtrlGrid.DataSource = DM.dsMUSICAS);

    if DBCtrlGrid.DataSource = DM.dsMUSICAS then
    begin
      DM.qrMUSICAS.Close;
      DM.qrMUSICAS.ParamByName('ID_ALBUM').Value := id_album;
      DM.qrMUSICAS.Open;

      if (fMonitorMenuMusicas <> nil) then
      begin
        fmIndex.copiaDadosTelaExtendida();
      end;
    end
    else
    begin
      DBCtrlGrid.Visible := False;
      if not DM.cdsArquivos.Active then
      begin
        DM.cdsArquivos.CreateDataSet;
      end;
      DM.cdsArquivos.Open;
      DM.cdsArquivos.EmptyDataSet;

      dir := dir+'\';
      dir := StringReplace(dir,'\\','\',[rfIgnoreCase, rfReplaceAll]);

      if not(DirectoryExists(dir)) then
        Exit;

      naoSlides := 0;
      comCantado := 0;
      semAudio := 0;

      // Cada entrada de "ordem" e uma musica da lista: a chave ordena e o
      // objeto carrega o que foi encontrado para ela na pasta
      //   [0] nome exibido  [1] arquivo cantado  [2] arquivo playback
      ordem := TStringList.Create;
      try
        iRetorno := FindFirst(dir + '*.*', faAnyFile, sr);
        try
          while iRetorno = 0 do
          begin
            if (sr.Name <> '.') and (sr.Name <> '..') and
               (sr.Attr <> faDirectory) then
            begin
              ext := LowerCase(ExtractFileExt(sr.Name));
              nome := Trim(ChangeFileExt(sr.Name, ''));
              ehSlide := (ext = '.slja') or (ext = '.lja');

              if ehSlide then
              begin
                // Cantado e playback sao dois arquivos, mas uma musica so na
                // lista. O sufixo de playback e reconhecido pelo fmMenu, que
                // devolve o nome sem ele; o pareamento vale ainda que as
                // extensoes dos dois sejam diferentes.
                ehPB := fmIndex.ehNomePlayback(nome);
                chave := LowerCase(nome);
              end
              else
              begin
                // Arquivo comum nao pareia com nada; entra como item avulso
                ehPB := False;
                chave := LowerCase(sr.Name);
              end;

              i := ordem.IndexOf(chave);
              if (i < 0) or not ehSlide then
              begin
                dados := TStringList.Create;
                // A primeira grafia encontrada e a que aparece na lista
                dados.Add(nome);
                dados.Add('');
                dados.Add('');
                if ehSlide then dados.Add('1') else dados.Add('0');
                i := ordem.AddObject(chave, dados);
              end;

              dados := TStringList(ordem.Objects[i]);
              if ehPB
                then dados[2] := dir + sr.Name
                else dados[1] := dir + sr.Name;

              if not ehSlide then
                Inc(naoSlides);
            end;
            iRetorno := FindNext(sr);
          end;
        finally
          FindClose(sr);
        end;

        ordem.Sort;

        for i := 0 to ordem.Count - 1 do
        begin
          dados := TStringList(ordem.Objects[i]);
          ehSlide := (dados[3] = '1');
          arqCantado := dados[1];
          arqPB := dados[2];

          // Um pacote sem musica, ou com a musica desligada nas opcoes, se
          // comporta como se fosse so letra: nada toca
          temAudio := (arqCantado <> '') and fmIndex.slidesTemAudio(arqCantado);
          temAudioPB := (arqPB <> '') and fmIndex.slidesTemAudio(arqPB);

          if (arqCantado <> '') then
          begin
            Inc(comCantado);
            if not temAudio then
              Inc(semAudio);
          end;

          DM.cdsArquivos.Append;
          DM.cdsArquivos.FieldByName('FAIXA').Value := i + 1;
          DM.cdsArquivos.FieldByName('NOME').Value := dados[0];
          // Sem versao cantada, o corpo do item abre o playback
          if (arqCantado <> '')
            then DM.cdsArquivos.FieldByName('DIR').Value := arqCantado
            else DM.cdsArquivos.FieldByName('DIR').Value := arqPB;
          DM.cdsArquivos.FieldByName('DIR_PB').Value := arqPB;
          DM.cdsArquivos.FieldByName('TEM_AUDIO').Value := temAudio;
          DM.cdsArquivos.FieldByName('TEM_AUDIO_PB').Value := temAudioPB;
          DM.cdsArquivos.FieldByName('EH_SLIDE').Value := ehSlide;
          DM.cdsArquivos.Post;
        end;
      finally
        for i := 0 to ordem.Count - 1 do
          ordem.Objects[i].Free;
        ordem.Free;
      end;

      DM.cdsArquivos.First;

      // Reproduzir todas encadeia as versoes cantadas de uma pasta so de
      // slides. Fica escondido quando ha arquivo de outro tipo, quando algum
      // item nao toca audio (a fila pararia nele) ou quando nao ha nenhuma
      // versao cantada para tocar.
      bsSkinSpeedButton6.Visible := (naoSlides = 0) and (semAudio = 0) and
                                    (comCantado > 0);
      // O -PB e uma convencao de nome, entao precisa estar dita em algum lugar
      lblDicaPB.Visible := (naoSlides = 0) and (DM.cdsArquivos.RecordCount > 0);
      DBCtrlGrid.Visible := True;
    end;

    FormResize(Sender);
  end;
end;

procedure TfListaMusica.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if (btExp_MenuMusicas.ImageIndex = 54)
  //  then btExp_MenuMusicasClick(btExp_MenuMusicas);
end;

procedure TfListaMusica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfListaMusica.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfListaMusica.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  fmIndex.MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;

procedure TfListaMusica.FormResize(Sender: TObject);
begin
  DBCtrlGrid.RowCount := Trunc(DBCtrlGrid.ClientHeight / 40);
end;

end.
