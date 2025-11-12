unit dmComponentes;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, bsSkinExCtrls,
  Windows, Forms, Data.Win.ADODB, Data.DB, Datasnap.DBClient, IdCoder,
  IdCoder3to4, IdCoderMIME, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, bsDialogs, bsSkinShellCtrls,
  bsPngImageList, System.ImageList, Vcl.ImgList, Vcl.Controls, bsSkinData,
  Vcl.Menus, Vcl.ExtDlgs, Vcl.Dialogs, Graphics, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, Data.DBXMySQL, Data.FMTBcd,
  Datasnap.Provider, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs;

type
  TDM = class(TDataModule)
    tmrSortearNM: TTimer;
    tmrSair: TTimer;
    tmrRelogio: TTimer;
    tmrVersao: TTimer;
    tmrSortear: TTimer;
    tmrSorteio: TTimer;
    tmrCrono: TTimer;
    tmrMediaPlayer: TTimer;
    qrALBUNS: TFDQuery;
    qrMUSICA: TFDQuery;
    qrSEL_MUSICAS_IDMUS: TFDQuery;
    qrONL_CANAIS: TFDQuery;
    ADOQuery: TFDQuery;
    qrLETRA_MUSICA: TFDQuery;
    qrONL_PLAYLISTS_TUDO: TFDQuery;
    qrONL_VIDEOS_TUDO: TFDQuery;
    qrHINOS_LITURGIA: TFDQuery;
    qrSEL_COLETANEAS_ID: TFDQuery;
    qrVERSAO: TFDQuery;
    qrMUSICAS_INFANTIS: TFDQuery;
    qrSLIDE_MUSICA_ALBUM: TFDQuery;
    qrONL_PLAYLISTS: TFDQuery;
    qrBIBLIA_LIVROS: TFDQuery;
    qrHINOS: TFDQuery;
    qrBIBLIA_VERSAO: TFDQuery;
    qrDOXOLOGIA_CATE: TFDQuery;
    qrLETRA: TFDQuery;
    qrBUSCA_MAX_CAPITULOS: TFDQuery;
    qrSLIDE_MUSICA_GRAVA: TFDQuery;
    qrONL_VIDEOS: TFDQuery;
    qrBUSCA_MAX_VERSOS: TFDQuery;
    qrBUSCA: TFDQuery;
    qrMUSICAS: TFDQuery;
    qrSLIDE_MUSICA_TEMPOS: TFDQuery;
    qrSLIDE_MUSICA: TFDQuery;
    ADO: TFDConnection;
    cdsVideosOnPerso: TClientDataSet;
    StringField3: TStringField;
    StringField5: TStringField;
    StringField7: TStringField;
    cdsVideosOnPersoVIDEOID: TStringField;
    cdsFavoritos: TClientDataSet;
    StringField6: TStringField;
    cdsFavoritosNOME: TStringField;
    cdsFavoritosNOME_ABA: TStringField;
    cdsFavoritosIMAGEM: TIntegerField;
    cdsFavoritosORDEM: TIntegerField;
    cdsSLIDE_MUSICA2: TClientDataSet;
    cdsItensAgendadosClone: TClientDataSet;
    cdsSLIDE_MUSICA: TClientDataSet;
    cdsItensAgendados: TClientDataSet;
    cdsCategoriasItensAgendados: TClientDataSet;
    cdsCOLETANEAS_PERSO: TClientDataSet;
    cdsCOLETANEAS_PERSOID: TStringField;
    cdsCOLETANEAS_PERSONOME: TStringField;
    cdsCOLETANEAS_PERSOURL_INFO: TStringField;
    cdsCOLETANEAS_PERSOURL: TStringField;
    cdsCOLETANEAS_PERSOIMAGEM_INFO: TStringField;
    cdsCOLETANEAS_PERSOIMAGEM: TStringField;
    dsLETRA_MUSICA: TDataSource;
    dsFavoritos: TDataSource;
    dsMUSICAS: TDataSource;
    dsSLIDE_MUSICA: TDataSource;
    dsBIBLIA_LIVROS: TDataSource;
    dsVideosOnPerso: TDataSource;
    dsMUSICAS_INFANTIS: TDataSource;
    dsItensAgendados: TDataSource;
    dsItensAgendadosClone: TDataSource;
    dsBIBLIA_VERSAO: TDataSource;
    dsCOLETANEAS_PERSO: TDataSource;
    dsSLIDE_MUSICA2: TDataSource;
    dsHINOS: TDataSource;
    dsHINOS_LITURGIA: TDataSource;
    dsBUSCA: TDataSource;
    dsCategoriasItensAgendados: TDataSource;
    dsBD: TDataSource;
    IdDecoderMIME: TIdDecoderMIME;
    IdEncoderMIME: TIdEncoderMIME;
    IdHTTP1: TIdHTTP;
    DirectoryDialog: TbsSkinSelectDirectoryDialog;
    SaveDialog_: TbsSkinSaveDialog;
    progressDialog: TbsSkinProgressDialog;
    bsSkinData1: TbsSkinData;
    bsCompressedSkinList1: TbsCompressedSkinList;
    imCapas: TImageList;
    ico_janela_hot: TImageList;
    ico_albuns: TImageList;
    ico_janela_dis: TImageList;
    ico_on_canais: TImageList;
    ico_janela: TImageList;
    ico_janela_clk: TImageList;
    ico_on_playlists: TImageList;
    ico_doxologia: TImageList;
    ico_on_videos: TImageList;
    ico_16x16: TbsPngImageList;
    ico_64x64: TbsPngImageList;
    ico_24x24: TbsPngImageList;
    ico_40x40: TbsPngImageList;
    OpenDialog: TOpenDialog;
    OpenPictureDialog: TOpenPictureDialog;
    OpenTextFileDialog: TOpenTextFileDialog;
    ColorDialog: TColorDialog;
    SaveDialog: TSaveDialog;
    SaveTextFileDialog: TSaveTextFileDialog;
    SavePictureDialog: TSavePictureDialog;
    qrARQUIVOS_HELP_DELETE: TFDQuery;
    qrARQUIVOS_HELP: TFDQuery;
    qrBD: TFDQuery;
    tmrBusca: TTimer;
    PasswordDialog: TbsSkinPasswordDialog;
    qrBIBLIA_CAPITULOS: TFDQuery;
    dsBIBLIA_CAPITULOS: TDataSource;
    qrBIBLIA_VERSICULOS: TFDQuery;
    dsBIBLIA_VERSICULOS: TDataSource;
    cdsBIBLIA_HISTORICO: TClientDataSet;
    dsBIBLIA_HISTORICO: TDataSource;
    cdsBIBLIA_HISTORICOVERSAO: TStringField;
    cdsBIBLIA_HISTORICOLIVRO: TIntegerField;
    cdsBIBLIA_HISTORICOCAPITULO: TIntegerField;
    cdsBIBLIA_HISTORICOPASSAGEM: TStringField;
    cdsBIBLIA_HISTORICODATAHORA: TDateTimeField;
    cdsBIBLIA_HISTORICOID: TStringField;
    cdsBIBLIA_HISTORICOBRANCO: TStringField;
    qrBIBLIA_BUS_LIVROS: TFDQuery;
    dsBIBLIA_BUSCA: TDataSource;
    qrBIBLIA_BUSCA: TFDQuery;
    qrBIBLIA_VERSAO_2: TFDQuery;
    dsBIBLIA_VERSAO_2: TDataSource;
    pwd: TbsSkinPasswordDialog;
    cdsBIBLIA_HISTORICOVERSICULO: TStringField;
    cdsBIBLIA_HISTORICODESC_PASSAGEM: TStringField;
    qrALBUM_ATIV: TFDQuery;
    dsALBUM_ATIV: TDataSource;
    qrDEL_ALBUM_IGNORAR: TFDQuery;
    qrADD_ALBUM_IGNORAR: TFDQuery;
    qrALBUM_INATIV: TFDQuery;
    dsALBUM_INATIV: TDataSource;
    qrARQUIVOS_SISTEMA: TFDQuery;
    qrGRAVA_TAMANHO_ARQUIVO: TFDQuery;
    qrINSERE_LETRA_MUSICA: TFDQuery;
    cdsArquivos: TClientDataSet;
    dsArquivos: TDataSource;
    tmrPlayer: TTimer;
    qrALTERA_LETRA_MUSICA: TFDQuery;
    qrSELECT_LETRA_MUSICA: TFDQuery;
    qrINSERE_MUSICA: TFDQuery;
    qrSELECT_MAX_MUSICA: TFDQuery;
    qrINSERE_MUSICA_ALBUM: TFDQuery;
    ico_flags: TbsPngImageList;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    qrHINOSN: TFDQuery;
    dsHINOSN: TDataSource;
    qrMUSICA_ATUALIZAR: TFDQuery;
    qrALBUM_IGNORAR: TFDQuery;
    cdsCOLETANEAS_PERSO_IMP: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField4: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    qrDEL_COLETANEAS_PERSO: TFDQuery;
    qrADD_COLETANEAS_PERSO: TFDQuery;
    cdsMonitores: TClientDataSet;
    StringField11: TStringField;
    cdsMonitoresTOP: TIntegerField;
    cdsMonitoresWIDTH: TIntegerField;
    cdsMonitoresHEIGHT: TIntegerField;
    cdsMonitoresNUM: TIntegerField;
    cdsMonitoresLEFT: TIntegerField;
    dsMonitores: TDataSource;
    cdsMonitoresX: TStringField;
    qrBUSCA_VERSAO: TFDQuery;
    qrBUSCA_VERSAO_1: TFDQuery;
    procedure tmrSortearTimer(Sender: TObject);
    procedure tmrSortearNMTimer(Sender: TObject);
    procedure tmrSorteioTimer(Sender: TObject);
    procedure tmrCronoTimer(Sender: TObject);
    procedure tmrMediaPlayerTimer(Sender: TObject);
    procedure tmrSairTimer(Sender: TObject);
    procedure tmrRelogioTimer(Sender: TObject);
    procedure tmrVersaoTimer(Sender: TObject);
    procedure ClientDataSetSaveToFile(DataSet: TDataSet);
    procedure progressDialogCancel(Sender: TObject);
    procedure IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ppVideosOnPersoPopup(Sender: TObject);
    procedure bsPopupMenuFavoritosPopup(Sender: TObject);
    procedure tmrBuscaTimer(Sender: TObject);
    procedure tmrPlayerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses fmMenu, fmArquivosFalta, fmHelp, fmIniciando, fmTransmitir,
  fmMonitorRelogio, fmMonitorCronometro, fmMonitorSorteioNomes,
  fmMonitorSorteio, fmMonitorCronometroCulto;

{$R *.dfm}

procedure TDM.bsPopupMenuFavoritosPopup(Sender: TObject);
begin
  if not DM.cdsFavoritos.Active then
    fmIndex.carregaFavoritos;
end;

procedure TDM.ClientDataSetSaveToFile(DataSet: TDataSet);
var
  nome,arquivo:string;
begin
  nome := DataSet.Name;
  if nome = 'cdsCategoriasItensAgendados'
    then arquivo := fmIndex.dir_dados + 'itensAgendadosCategorias.xml'
  else if nome = 'cdsItensAgendados'
    then arquivo := fmIndex.dir_dados + 'itensAgendados.xml'
  else if nome = 'cdsCOLETANEAS_PERSO'
    then arquivo := fmIndex.dir_dados + 'coletaneasUsuario.xml'
  else if nome = 'cdsFavoritos'
    then arquivo := fmIndex.dir_dados + 'favoritos.xml'
  else if nome = 'cdsVideosOnPerso'
    then arquivo := fmIndex.dir_dados + 'videosOnUsuario.xml';

  TClientDataSet(FindComponent(nome)).MergeChangeLog;
  TClientDataSet(FindComponent(nome)).SaveToFile(arquivo);

  if nome = 'cdsItensAgendados'
    then cdsItensAgendadosClone.LoadFromFile(arquivo);
end;

procedure TDM.IdHTTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if AWorkCount >= progressDialog.MaxValue then
    progressDialog.MaxValue := AWorkCount + 1;

  progressDialog.Value := AWorkCount;
  fmIndex.Buffer := AWorkCount;
end;

procedure TDM.IdHTTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if (AWorkCountMax > 0) then
    progressDialog.MaxValue := AWorkCountMax;
end;

procedure TDM.ppVideosOnPersoPopup(Sender: TObject);
begin
  if DM.cdsVideosOnPerso.Active = false then
  begin
    Abort;
    Exit;
  end;
  if DM.cdsVideosOnPerso.RecordCount <= 0 then
  begin
    Abort;
    Exit;
  end;
end;

procedure TDM.progressDialogCancel(Sender: TObject);
begin
  if progressDialog.Value < progressDialog.MaxValue then
    progressDialog.Execute;
end;

procedure TDM.tmrBuscaTimer(Sender: TObject);
begin
  tmrBusca.Enabled := False;
  fmIndex.buscaMusicas();
end;

procedure TDM.tmrCronoTimer(Sender: TObject);
var
  MyHora, MyMinuto, MySegundo, MyMiliSegundo: Word;
  Segundos: integer;
begin
  with fmIndex do
  begin
    if rbDirecao.ItemIndex = 0 then
    begin
      tCronoT := tCrono + Now - tCronoOld;
      lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], tCrono + Now - tCronoOld);
      if (gCrono.MaxValue <= 1) then
        gCrono.MaxValue := 1000;
      gCrono.Value := gCrono.Value + 1;
      gCrono.MaxValue := gCrono.MaxValue + 2;
      if fMonitorCronometro <> nil then
      begin
        fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        fMonitorCronometro.gCrono.Value := gCrono.Value;
        fMonitorCronometro.gCrono.MaxValue := gCrono.MaxValue;
        fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
      end;
    end
    else
    begin
      tCronoT := tCrono - (Now - tCronoOld);
      lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], tCrono - (Now - tCronoOld));

      DecodeTime(tCrono - (Now - tCronoOld), MyHora, MyMinuto, MySegundo, MyMiliSegundo);
      Segundos := MyMiliSegundo + (MySegundo * 1000) + (MyMinuto * 60000) + (MyHora * 3600000);
      if (Segundos > gCrono.MaxValue) then
        gCrono.MaxValue := Segundos;
      gCrono.Value := Segundos;

      if fMonitorCronometro <> nil then
      begin
        fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        fMonitorCronometro.gCrono.Value := gCrono.Value;
        fMonitorCronometro.gCrono.MaxValue := gCrono.MaxValue;
        fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
      end;

      if tCronoT <= 0 then
      begin
        tmrCrono.enabled := false;
        lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime('00:00:00'));
        if fMonitorCronometro <> nil then
          fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
        if tsCronometro.TabVisible = false then
          abrePagina(tsCronometro);
        PageControl1.ActivePage := tsCronometro;
        //application.messagebox('Tempo esgotado!', PChar(TITULO + ' - Cronômetro'), mb_ok + mb_iconinformation);
        btZerarCrono.Tag := 1;
        btZerarCronoClick(Sender);
      end;
    end;
  end;
end;

procedure TDM.tmrMediaPlayerTimer(Sender: TObject);
begin
  with fmIndex do
  begin
    try
      if (mpMusica.Position >= mpMusica.Length) then
      begin
        mpMusica.Stop;
        btOuvir.Caption := 'Ouvir';
        btOuvir.Down := False;
        btOuvir.ImageIndex := 7;
        tmrMediaPlayer.Enabled := false;
      end;
    except
      btOuvir.Caption := 'Ouvir';
      btOuvir.Down := False;
      btOuvir.ImageIndex := 7;
      tmrMediaPlayer.Enabled := false;
    end;
  end;
end;

procedure TDM.tmrPlayerTimer(Sender: TObject);
begin
  fmIndex.pbPlayer.Value := fmIndex.MediaPlayer1.Position;
  if fmIndex.MediaPlayer1.Position >= fmIndex.MediaPlayer1.Length
    then fmIndex.btplFecharClick(Sender);
end;

procedure TDM.tmrRelogioTimer(Sender: TObject);
begin
  with fmIndex do
  begin
    spData.Caption := formatdatetime('dd/mm/yyyy', now());
    spRelogio.Caption := formatdatetime('hh:mm:ss', now());
    if (PageControl1.ActivePage = tsRelogio) or (fMonitorRelogio <> nil) then
    begin
      pnlRelogio.DoubleBuffered := True;
      lmdRelogio.Caption := formatdatetime(cbFormatoHora.Items[cbFormatoHora.ItemIndex], now());
      if fMonitorRelogio <> nil then
      begin
        fMonitorRelogio.lmdRelogio.Caption := lmdRelogio.Caption;
        fMonitorRelogio.pnlRelogio.DoubleBuffered := pnlRelogio.DoubleBuffered;
      end;
    end;


    if (PageControl1.ActivePage = tsCronoCulto) or (fMonitorCronometroCulto <> nil) then
    begin
      pnlEscSB.DoubleBuffered := True;
      if (cbEscSBRelogioFunc.Checked) or (btLigar.Caption <> 'Ligar')
        then lmdEscSb.Caption := formatdatetime(cbFormatoHoraES.Items[cbFormatoHoraES.ItemIndex], Now())
        else lmdEscSb.Caption := formatdatetime(cbFormatoHoraES.Items[cbFormatoHoraES.ItemIndex], StrToTime('00:00:00'));

      if (btLigar.Caption = 'Ligar') then
      begin
        lmdEscSbR.Caption := formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], StrToTime('00:00:00'));
        lblCronoCFim.Caption := '00:00';
      end
      else
      begin
        escSBTempo;
        lblCronoCFim.Caption := FormatDateTime('hh:mm',tEscSBCrono);
      end;

      if fMonitorCronometroCulto <> nil then
      begin
        fMonitorCronometroCulto.lmdEscSb.Caption := lmdEscSb.Caption;
        fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
        fMonitorCronometroCulto.pnlEscSB.DoubleBuffered := pnlEscSB.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSairTimer(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TDM.tmrSortearNMTimer(Sender: TObject);
var
  sorteado: string;
  Item: TbsSkinOfficeItem;
begin
  with fmIndex do
  begin
    if vSorteioAnimFimNM <= Now then
    begin
      pnlSorteioNM.DoubleBuffered := False;
      tmrSortearNM.Enabled := false;

      btLimpaSorteioNM.Enabled := true;
      btSortearNM.Enabled := true;
      btLimpaSorteioReiniciaNM.Enabled := true;
      btLimpaSorteioLimpaNM.Enabled := true;
      btAddSorteioNM.Enabled := true;
      btImpSorteioNM.Enabled := true;

      sorteado := opNumSorteadoNM.text;
      lmdSorteioNM.Caption := sorteado;

      lbSorteioNM.ItemIndex := StrToInt(vlSorteioNM.Strings.Values[sorteado]);
      lbSorteioNM.Items[lbSorteioNM.ItemIndex].Checked := True;
      lbSorteioNMItemCheckClick(Sender);

      Item := lbSorteadoNM.Items.Insert(0);
      Item.Caption := sorteado;

      SorteioContador();
      gSorteioNM.Value := gSorteioNM.MaxValue;

      if fMonitorSorteioNomes <> nil then
      begin
        fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
        fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
        fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
        fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
        fMonitorSorteioNomes.lbSorteadoNM.ItemIndex := lbSorteadoNM.ItemIndex;
        fMonitorSorteioNomes.gSorteioNM.MaxValue := gSorteioNM.MaxValue;
        fMonitorSorteioNomes.gSorteioNM.MinValue := gSorteioNM.MinValue;
        fMonitorSorteioNomes.gSorteioNM.Value := gSorteioNM.Value;
        fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;
      end;
    end
    else
    begin
      btLimpaSorteioNM.Enabled := false;
      btSortearNM.Enabled := false;
      btLimpaSorteioReiniciaNM.Enabled := false;
      btLimpaSorteioLimpaNM.Enabled := false;
      btAddSorteioNM.Enabled := false;
      btImpSorteioNM.Enabled := false;

      lmdSorteioNM.Caption := opNumSorteadoNM.text;
      gSorteioNM.Value := trunc(now * 10000000000);

      if fMonitorSorteioNomes <> nil then
      begin
        fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
        fMonitorSorteioNomes.gSorteioNM.MaxValue := gSorteioNM.MaxValue;
        fMonitorSorteioNomes.gSorteioNM.MinValue := gSorteioNM.MinValue;
        fMonitorSorteioNomes.gSorteioNM.Value := gSorteioNM.Value;
        fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSortearTimer(Sender: TObject);
var
  sorteado: string;
  Item: TbsSkinOfficeItem;
begin
  with fmIndex do
  begin
    if vSorteioAnimFim <= Now then
    begin
      pnlSorteio.DoubleBuffered := False;
      tmrSortear.Enabled := false;

      btLimpaSorteio.Enabled := true;
      btSortear.Enabled := true;
      btLimpaSorteioReinicia.Enabled := true;
      btLimpaSorteioLimpa.Enabled := true;
      btAddSorteio.Enabled := true;

      sorteado := opNumSorteado.text;
      lmdSorteio.Caption := sorteado;

      lbSorteio.ItemIndex := StrToInt(vlSorteio.Strings.Values[sorteado]);
      lbSorteio.Items[lbSorteio.ItemIndex].Checked := True;
      lbSorteioItemCheckClick(Sender);

      Item := lbSorteado.Items.Insert(0);
      Item.Caption := sorteado;

      SorteioContador();
      gSorteio.Value := gSorteio.MaxValue;

      if fMonitorSorteio <> nil then
      begin
        fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
        fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
        fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
        fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
        fMonitorSorteio.lbSorteado.ItemIndex := lbSorteado.ItemIndex;
        fMonitorSorteio.gSorteio.MaxValue := gSorteio.MaxValue;
        fMonitorSorteio.gSorteio.MinValue := gSorteio.MinValue;
        fMonitorSorteio.gSorteio.Value := gSorteio.Value;
        fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;
      end;
    end
    else
    begin
      btLimpaSorteio.Enabled := false;
      btSortear.Enabled := false;
      btLimpaSorteioReinicia.Enabled := false;
      btLimpaSorteioLimpa.Enabled := false;
      btAddSorteio.Enabled := false;

      lmdSorteio.Caption := opNumSorteado.text;
      gSorteio.Value := trunc(now * 10000000000);

      if fMonitorSorteio <> nil then
      begin
        fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
        fMonitorSorteio.gSorteio.MaxValue := gSorteio.MaxValue;
        fMonitorSorteio.gSorteio.MinValue := gSorteio.MinValue;
        fMonitorSorteio.gSorteio.Value := gSorteio.Value;
        fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;
      end;
    end;
  end;
end;

procedure TDM.tmrSorteioTimer(Sender: TObject);
var
  Rnd: integer;
begin
  with fmIndex do
  begin
    if vlSorteio.Strings.Count > 0 then
    begin
      Rnd := 0 + Random(vlSorteio.Strings.Count);
      opNumSorteado.text := vlSorteio.Cells[0, Rnd + 1];
      opNumIndice.Text := IntToStr(Rnd);
    end;

    if vlSorteioNM.Strings.Count > 0 then
    begin
      Rnd := 0 + Random(vlSorteioNM.Strings.Count);
      opNumSorteadoNM.text := vlSorteioNM.Cells[0, Rnd + 1];
      opNumIndiceNM.Text := IntToStr(Rnd);
    end;
  end;
end;

procedure TDM.tmrVersaoTimer(Sender: TObject);
var
  versao_atu: TStringList;
  versao_hlp: TStringList;
begin
  with fmIndex do
  begin
    tmrVersao.Enabled := False;
    verVersao();

    if(tmrSair.enabled) then
      Exit;

    if lerParam('Config', 'AbreHelp', '0') <> lblVersao.caption then
    begin
      atualizaIgnoreAlbum;
      DM.qrALBUM_ATIV.Close;
      DM.qrALBUM_ATIV.Open;
      DM.qrALBUM_INATIV.Close;
      DM.qrALBUM_INATIV.Open;

      fIniciando.AppCreateForm(TfArquivosFalta, fArquivosFalta);
      fArquivosFalta.ShowModal;

      versao_atu := TStringList.Create;
      versao_atu.Delimiter := '.';
      versao_atu.DelimitedText := fmIndex.VersaoExe;

      versao_hlp := TStringList.Create;
      versao_hlp.Delimiter := '.';
      versao_hlp.DelimitedText := lerParam('Config', 'AbreHelp', '0.0.0.0');

      if (versao_atu[0] <>  versao_hlp[0])
        or (versao_atu[1] <>  versao_hlp[1]) then
      begin
        fIniciando.AppCreateForm(TfHelp, fHelp);
        fHelp.tabPage := '';
        fHelp.ShowModal;
      end;

      gravaParam('Config', 'AbreHelp', lblVersao.caption);
    end;

    if (fTransmitir.ckSrvConectar.Checked) then
      if fTransmitir.btServidor.ImageIndex = 8 then
        fTransmitir.btServidorClick(Sender);
  end;
end;

end.
