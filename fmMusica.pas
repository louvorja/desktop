unit fmMusica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Data.Win.ADODB, Bass,
  Vcl.Grids, Vcl.DBGrids, bsSkinGrids, bsDBGrids,
  Vcl.Imaging.pngimage, Datasnap.DBClient, Vcl.DBCtrls;

type
  TfMusica = class(TForm)
    pnlLetra: TPanel;
    imgFundo: TImage;
    lblLetra: TbsSkinStdLabel;
    tmrTempo: TTimer;
    pnlAdm: TPanel;
    pnGrid: TPanel;
    dbGrid: TbsSkinDBGrid;
    bsSkinScrollBar1: TbsSkinScrollBar;
    imgFundoTexto: TImage;
    lblLetra_aux: TbsSkinStdLabel;
    lbTempos: TListBox;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Edit1: TEdit;
    btProxGrava: TButton;
    btGravaA: TButton;
    btGravaR: TButton;
    btRefresh: TButton;
    Edit2: TMemo;
    Edit3: TEdit;
    Button2: TButton;
    Button3: TButton;
    DBMemo1: TDBMemo;
    Button4: TButton;
    lbLetras: TListBox;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ajustaTexto();
    procedure FormResize(Sender: TObject);
    procedure carregaImagem(dir: string);
    procedure FormActivate(Sender: TObject);
    procedure acaoSlide(acao:string; setPosicao: Boolean = True; ac_album: Boolean = True);
    procedure acaoAlbum(acao:string);
    procedure acaoArquivo(acao:string);
    procedure defineFila(lista: TStringList; indice: Integer);
    procedure irSlide(num: integer);
    procedure slide(setPosicao: Boolean = True);
    procedure btGravaRClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Error(msg: string);
    procedure tmrTempoTimer(Sender: TObject);
    procedure pauseplay();
    procedure btProxGravaClick(Sender: TObject);
    procedure bsSkinDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
    procedure dbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
    procedure btRefreshClick(Sender: TObject);
    procedure btGravaAClick(Sender: TObject);
    procedure refresh();
    procedure Button1Click(Sender: TObject);
    procedure carregaTempos();
    procedure carregaSlides();
    procedure carregaMusica();
    procedure carregaAlbum();
    procedure converteTempos();
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure slideInfo(p: string);
    procedure cursor();
    function IsNumeric(const str: string): Boolean;
  private
    { Private declarations }
    bass_musica: HSAMPLE;
    bass_channel: HCHANNEL;
    next_time: Integer;
    pause: Boolean;
    letraID: Integer;
    uslide: integer;
    pcTexto: Integer;
    pcTexto_aux: Integer;
    uImagem: string;
    uPosicao: Integer;
    imgPosicao: Integer;

    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    musicaID,albumID: Integer;
    inicio: Boolean;
    //Fila de arquivos de slides de uma coletânea personalizada. Vazia
    //quando a exibição veio de album ou de arquivo avulso.
    filaArquivos: TStringList;
    filaIndice: Integer;
    audio: Boolean;
    fecharSlides,fecharSlidesRetorno: Boolean;
    tipo,param: string;
    nslide: integer;
    nslideOrdem: integer;
    monitor:integer;
    ult_format:string;
  end;

var
  fMusica: TfMusica;

implementation

{$R *.dfm}

uses fmMenu, fmMusicaOperador, fmAtualiza, dmComponentes, fmIniciando,
  fmTransmitir, fmMusicaRetorno;

{ TfMusica }

procedure TfMusica.acaoAlbum(acao: string);
begin
  if (acao = 'prox')
    then DM.qrSLIDE_MUSICA_ALBUM.Next
  else if (acao = 'ant')
    then DM.qrSLIDE_MUSICA_ALBUM.Prior;

  if (audio) then
  begin
		BASS_MusicFree(bass_musica);
    BASS_Free();
  end;
  uslide := -1;
  musicaID := DM.qrSLIDE_MUSICA_ALBUM.FieldByName('ID').AsInteger;
  carregaMusica;
end;

{
  Assume a fila de arquivos de uma coletânea personalizada.

  A lista é copiada: quem chamou a libera logo em seguida.
}
procedure TfMusica.defineFila(lista: TStringList; indice: Integer);
begin
  if (filaArquivos = nil) then
    filaArquivos := TStringList.Create;

  filaArquivos.Assign(lista);
  filaIndice := indice;
end;

{
  Troca de arquivo dentro da fila, como acaoálbum faz dentro do álbum.

  O .slja precisa ser extraído a cada troca, e o parâmetro de áudio vale por
  arquivo - por isso passa de novo por preparaArquivoSlides.
}
procedure TfMusica.acaoArquivo(acao: string);
var
  pronto: string;
  temAudio: Boolean;
begin
  if (filaArquivos = nil) then
    Exit;

  if (acao = 'prox') and (filaIndice < filaArquivos.Count - 1) then
    Inc(filaIndice)
  else if (acao = 'ant') and (filaIndice > 0) then
    Dec(filaIndice)
  else
    Exit;

  pronto := fmIndex.preparaArquivoSlides(filaArquivos[filaIndice], temAudio);
  if (pronto = '') then
    Exit;

  if (audio) then
  begin
    BASS_MusicFree(bass_musica);
    BASS_Free();
  end;

  uslide := -1;
  tipo := 'EXT';
  param := pronto;
  audio := temAudio;
  carregaMusica;
end;

procedure TfMusica.acaoSlide(acao: string;setPosicao: Boolean; ac_album: Boolean);
var
  tempo,rec: integer;
begin
  DM.cdsSLIDE_MUSICA.RecNo := nslide;
//  ShowMessage(acao+' / '+inttostr(nslide));

  if ((acao = 'pri') or (acao = 'ant'))
     and (DM.cdsSLIDE_MUSICA.RecNo <= 1) then
  begin
    if (ac_album = true) and (albumID > 0) and (DM.qrSLIDE_MUSICA_ALBUM.RecNo > 1) then
    begin
      acaoAlbum('ant');
      exit;
    end
    else if (ac_album = true) and (filaArquivos <> nil) and (filaIndice > 0) then
    begin
      acaoArquivo('ant');
      exit;
    end
    else uslide := -1;
//    else setPosicao := false;
  end;

  if ((acao = 'ult') or (acao = 'prox'))
     and (DM.cdsSLIDE_MUSICA.RecNo >= DM.cdsSLIDE_MUSICA.RecordCount) then
  begin
    if (ac_album = true) and (albumID > 0) and (DM.qrSLIDE_MUSICA_ALBUM.RecNo < DM.qrSLIDE_MUSICA_ALBUM.RecordCount) then
    begin
      acaoAlbum('prox');
      exit;
    end
    else if (ac_album = true) and (filaArquivos <> nil) and
            (filaIndice < filaArquivos.Count - 1) then
    begin
      acaoArquivo('prox');
      exit;
    end
    else setPosicao := false;
  end;

  if (acao = 'pri') then DM.cdsSLIDE_MUSICA.First
  else if (acao = 'ult') then DM.cdsSLIDE_MUSICA.Last
  else if (acao = 'prox') then DM.cdsSLIDE_MUSICA.Next
  else if (acao = 'ant') then DM.cdsSLIDE_MUSICA.Prior
  else if (acao = 'prox_grava') then
  begin
    if pnGrid.Visible = false then Exit;

    tempo := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
    acaoSlide('prox',false);
    DM.qrSLIDE_MUSICA_GRAVA.ParamByName('MUSICA_ID').Value := letraID;
    DM.qrSLIDE_MUSICA_GRAVA.ParamByName('TEMPO').Value := tempo;
    DM.qrSLIDE_MUSICA_GRAVA.ExecSQL;

    rec := DM.cdsSLIDE_MUSICA.RecNo;
    lbTempos.Items[rec-1] := IntToStr(tempo);
    DM.cdsSLIDE_MUSICA.Close;
    DM.cdsSLIDE_MUSICA.Open;
    DM.cdsSLIDE_MUSICA.RecNo := rec;
    rec := DM.qrLETRA_MUSICA.RecNo;
    DM.qrLETRA_MUSICA.Close;
    DM.qrLETRA_MUSICA.Open;
    DM.qrLETRA_MUSICA.RecNo := rec;
    fmIndex.AjustaLarguraCamposDBGrid(dbGrid);
  end;

//  nslide := DM.cdsSLIDE_MUSICA.RecNo;
  if (acao <> 'prox_grava') then
    slide(setPosicao);
end;

procedure TfMusica.ajustaTexto;
var
  vTop: Real;
begin
  lblLetra.Font.Height := Trunc((fMusica.Height/100)*pcTexto);
  lblLetra.Top := fMusica.Height;
  lblLetra.Left := fMusica.Width;
  lblLetra.AutoSize := False;
  lblLetra.Height := 1;
  lblLetra.Width := fMusica.Width;
  lblLetra.AutoSize := True;
  lblLetra.Refresh;
  vTop := 0.5;
  if (inicio) then
  begin
    if fmIndex.sbAlinhMusica.ItemIndex = 0 then vTop := 0.25
    else if fmIndex.sbAlinhMusica.ItemIndex = 2 then vTop := 0.75;
    lblLetra.Top := Trunc((pnlLetra.Height*vTop) - (lblLetra.Height/2));
    lblLetra.Left := Trunc((pnlLetra.Width/2) - (lblLetra.Width/2));
  end;
  imgFundoTexto.Top := lblLetra.Top-5;
  imgFundoTexto.Left := lblLetra.Left-10;
  imgFundoTexto.Width := lblLetra.Width+20;
  imgFundoTexto.Height := lblLetra.Height+10;

  if (Trim(lblLetra_aux.Caption) <> '') then
  begin
    lblLetra_aux.Font.Height := Trunc((fMusica.Height/100)*pcTexto_aux);

    lblLetra_aux.AutoSize := False;
    lblLetra_aux.Height := 1;
    lblLetra_aux.Width := lblLetra.Width;
    lblLetra_aux.AutoSize := True;
    lblLetra_aux.Refresh;

    lblLetra_aux.Top := lblLetra.Top-lblLetra_aux.Height;
    lblLetra_aux.Left := lblLetra.Left;

    imgFundoTexto.Top := lblLetra_aux.Top-5;
    imgFundoTexto.Height := lblLetra_aux.Height + lblLetra.Height+10;
  end;

  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.lblLetra.Font.Height := Trunc((fMusicaOperador.pnlLetra.Height/100)*pcTexto);
    fMusicaOperador.lblLetra.Top := fMusicaOperador.pnlLetra.Height;
    fMusicaOperador.lblLetra.Left := fMusicaOperador.pnlLetra.Width;
    fMusicaOperador.lblLetra.AutoSize := False;
    fMusicaOperador.lblLetra.Height := 1;
    fMusicaOperador.lblLetra.Width := fMusicaOperador.pnlLetra.Width;
    fMusicaOperador.lblLetra.AutoSize := True;
    fMusicaOperador.lblLetra.Refresh;
    if (inicio) then
    begin
      fMusicaOperador.lblLetra.Top := Trunc((fMusicaOperador.pnlLetra.Height*vTop) - (fMusicaOperador.lblLetra.Height/2));
      fMusicaOperador.lblLetra.Left := Trunc((fMusicaOperador.pnlLetra.Width/2) - (fMusicaOperador.lblLetra.Width/2));
    end;
    fMusicaOperador.imgFundoTexto.Top := fMusicaOperador.lblLetra.Top-5;
    fMusicaOperador.imgFundoTexto.Left := fMusicaOperador.lblLetra.Left-10;
    fMusicaOperador.imgFundoTexto.Width := fMusicaOperador.lblLetra.Width+20;
    fMusicaOperador.imgFundoTexto.Height := fMusicaOperador.lblLetra.Height+10;

    if (Trim(fMusicaOperador.lblLetra_aux.Caption) <> '') then
    begin
      fMusicaOperador.lblLetra_aux.Font.Height := Trunc((fMusicaOperador.pnlLetra.Height/100)*pcTexto_aux);

      fMusicaOperador.lblLetra_aux.AutoSize := False;
      fMusicaOperador.lblLetra_aux.Height := 1;
      fMusicaOperador.lblLetra_aux.Width := fMusicaOperador.lblLetra.Width;
      fMusicaOperador.lblLetra_aux.AutoSize := True;
      fMusicaOperador.lblLetra_aux.Refresh;

      fMusicaOperador.lblLetra_aux.Top := fMusicaOperador.lblLetra.Top-fMusicaOperador.lblLetra_aux.Height;
      fMusicaOperador.lblLetra_aux.Left := fMusicaOperador.lblLetra.Left;

      fMusicaOperador.imgFundoTexto.Top := fMusicaOperador.lblLetra_aux.Top-5;
      fMusicaOperador.imgFundoTexto.Height := fMusicaOperador.lblLetra_aux.Height + fMusicaOperador.lblLetra.Height+10;
    end;

  end;

  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
  begin
//    fMusicaRetorno.lblLetra.Font.Height := Trunc((fMusicaRetorno.Height/100)*pcTexto)+5;
    fMusicaRetorno.lblLetra.Font.Height := Trunc((fMusicaRetorno.Height/100)*StrToInt(fmIndex.seTamanhoTextoRetorno.Text));
    fMusicaRetorno.lblLetra.Top := fMusicaRetorno.Height;
    fMusicaRetorno.lblLetra.Left := fMusicaRetorno.Width;
    fMusicaRetorno.lblLetra.AutoSize := False;
    fMusicaRetorno.lblLetra.Height := 1;
    fMusicaRetorno.lblLetra.Width := fMusicaRetorno.Width;
    fMusicaRetorno.lblLetra.AutoSize := True;
    fMusicaRetorno.lblLetra.Refresh;
    if (inicio) then
    begin
      fMusicaRetorno.lblLetra.Top := Trunc((fMusicaRetorno.pnlLetra.Height*vTop) - (fMusicaRetorno.lblLetra.Height/2));
      fMusicaRetorno.lblLetra.Left := Trunc((fMusicaRetorno.pnlLetra.Width/2) - (fMusicaRetorno.lblLetra.Width/2));
    end;

    if (Trim(fMusicaRetorno.lblLetra_aux.Caption) <> '') then
    begin
      fMusicaRetorno.lblLetra_aux.Font.Height := Trunc((fMusicaRetorno.Height/100)*10);

      fMusicaRetorno.lblLetra_aux.AutoSize := False;
      fMusicaRetorno.lblLetra_aux.Height := 1;
      fMusicaRetorno.lblLetra_aux.Width := fMusicaRetorno.lblLetra.Width;
      fMusicaRetorno.lblLetra_aux.AutoSize := True;
      fMusicaRetorno.lblLetra_aux.Refresh;

      fMusicaRetorno.lblLetra_aux.Top := fMusicaRetorno.lblLetra.Top-fMusicaRetorno.lblLetra_aux.Height;
      fMusicaRetorno.lblLetra_aux.Left := fMusicaRetorno.lblLetra.Left;
    end;

    fMusicaRetorno.lblLetra_prox.Font.Height := Trunc((fMusicaRetorno.Height/100)*12);
    fMusicaRetorno.lblLetra_prox.Top := 0;
    fMusicaRetorno.lblLetra_prox.Refresh;
  end;
end;

procedure TfMusica.bsSkinDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TbsColumn;
  State: TGridDrawState);
begin
  fmIndex.DBGridDrawColumnCell(Sender,Rect,DataCol,Column,State);
end;

procedure TfMusica.Button1Click(Sender: TObject);
begin
  pauseplay;
end;

procedure TfMusica.Button2Click(Sender: TObject);
begin
  lbTempos.Visible := not lbTempos.Visible;
end;

procedure TfMusica.Button3Click(Sender: TObject);
begin
  DBGrid1.Visible := not DBGrid1.Visible;
end;

procedure TfMusica.Button4Click(Sender: TObject);
begin
  DBMemo1.Visible := not DBMemo1.Visible;
end;

procedure TfMusica.btProxGravaClick(Sender: TObject);
begin
  if (fmIndex.pnlModDes.Visible) then
    acaoSlide('prox_grava');
end;

procedure TfMusica.btRefreshClick(Sender: TObject);
var
  reg: integer;
begin
  refresh;
  reg := DM.cdsSLIDE_MUSICA.RecNo;
  DM.cdsSLIDE_MUSICA.EmptyDataSet;
  carregaSlides;
  DM.cdsSLIDE_MUSICA.RecNo := reg;
  slide(false);
end;

procedure TfMusica.btGravaRClick(Sender: TObject);
var
  tempo,rec: integer;
begin
  if not (fmIndex.pnlModDes.Visible) then Exit;

  rec := DM.cdsSLIDE_MUSICA.RecNo;

//  tempo := DM.cdsSLIDE_MUSICA.fieldbyname('TEMPO').AsInteger-100000;
  tempo := StrToInt(lbTempos.Items[rec-1])-100000;
  DM.qrSLIDE_MUSICA_GRAVA.ParamByName('MUSICA_ID').Value := letraID;
  DM.qrSLIDE_MUSICA_GRAVA.ParamByName('TEMPO').Value := tempo;
  DM.qrSLIDE_MUSICA_GRAVA.ExecSQL;

  lbTempos.Items[rec-1] := IntToStr(tempo);
  DM.cdsSLIDE_MUSICA.Close;
  DM.cdsSLIDE_MUSICA.Open;
  DM.cdsSLIDE_MUSICA.RecNo := rec;
  rec := DM.qrLETRA_MUSICA.RecNo;
  DM.qrLETRA_MUSICA.Close;
  DM.qrLETRA_MUSICA.Open;

  DM.qrLETRA_MUSICA.RecNo := rec;
  fmIndex.AjustaLarguraCamposDBGrid(dbGrid);
  BASS_ChannelSetPosition(bass_channel, tempo, BASS_POS_BYTE);
end;

procedure TfMusica.btGravaAClick(Sender: TObject);
var
  tempo,rec: integer;
begin
  if not (fmIndex.pnlModDes.Visible) then Exit;

  tempo := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
  DM.qrSLIDE_MUSICA_GRAVA.ParamByName('MUSICA_ID').Value := letraID;
  DM.qrSLIDE_MUSICA_GRAVA.ParamByName('TEMPO').Value := tempo;
  DM.qrSLIDE_MUSICA_GRAVA.ExecSQL;
  rec := DM.cdsSLIDE_MUSICA.RecNo;
  lbTempos.Items[rec-1] := IntToStr(tempo);
  DM.cdsSLIDE_MUSICA.Close;
  DM.cdsSLIDE_MUSICA.Open;
  DM.cdsSLIDE_MUSICA.RecNo := rec;
  rec := DM.qrLETRA_MUSICA.RecNo;
  DM.qrLETRA_MUSICA.Close;
  DM.qrLETRA_MUSICA.Open;
  DM.qrLETRA_MUSICA.RecNo := rec;
  fmIndex.AjustaLarguraCamposDBGrid(dbGrid);
end;

procedure TfMusica.carregaAlbum;
begin
  DM.qrSLIDE_MUSICA_ALBUM.Close;
  DM.qrSLIDE_MUSICA_ALBUM.ParamByName('ID_ALBUM').Value := albumID;
  DM.qrSLIDE_MUSICA_ALBUM.Open;
  if musicaID <= 0
    then DM.qrSLIDE_MUSICA_ALBUM.First
    else DM.qrSLIDE_MUSICA_ALBUM.Locate('ID', musicaID, []);
  musicaID := DM.qrSLIDE_MUSICA_ALBUM.FieldByName('ID').AsInteger;
  tipo := 'BD';
  carregaMusica;
end;

procedure TfMusica.carregaImagem(dir: string);
var
  Bitmap : TBitMap;
begin
  imgFundo.Visible := false;
  if not (FileExists(dir))
    then imgFundo.Picture := nil
  else
  begin
    try
      imgFundo.Picture.LoadFromFile(dir);
    except
      imgFundo.Picture := nil;
    end;

    if imgFundo.Picture.Height <= 0 then
    begin
      imgFundo.Picture := nil;
      if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
        then fMusicaOperador.imgFundo.Picture := nil;
      fMusicaOperador.pnlErroMsg.Caption := 'Imagem de fundo "'+dir+'" danificada!';
      fMusicaOperador.pnlErroMsg.Visible := True;
    end
    else
    begin
      fmIndex.ajustaImagem(imgFundo,pnlLetra,imgPosicao);

      if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
      begin
        try
          fMusicaOperador.imgFundo.Picture.LoadFromFile(dir);
        except
          fMusicaOperador.imgFundo := nil;
        end;
        fmIndex.ajustaImagem(fMusicaOperador.imgFundo,fMusicaOperador.pnlLetra,imgPosicao);
      end;

      try
        Bitmap := TBitmap.Create;
        Bitmap.Assign(imgFundo.Picture.Graphic);
        try
          with Bitmap do
          begin
            fMusica.Canvas.Draw(0,0,BitMap);
          end;
        finally
          Bitmap.Free;
        end;
      except
        //
      end;

    end;

    imgFundo.Visible := true;
  end;
end;

procedure TfMusica.carregaMusica;
var
  f: PChar;
  musica: string;
  lista: TStringList;
begin
  carregaSlides();
  carregaTempos();

  if DM.tmrSair.Enabled = true then Exit;


  if (fmIndex.pnlModDes.Visible) then
  begin
    DM.qrLETRA_MUSICA.Close;
    DM.qrLETRA_MUSICA.ParamByName('MUSICA_ID').Value := musicaID;
    DM.qrLETRA_MUSICA.Open;
  end;

  nslide := 1;
  acaoSlide('pri',False,False);

  fmIndex.AjustaLarguraCamposDBGrid(dbGrid);

  if (audio) then
  begin
    musica := DM.cdsSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString;
    musica := StringReplace(musica,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
    if (musica <> '') and (musicaID > 0) then
      musica := fmIndex.dir_config+'musicas\'+musica
    else if FileExists(ExtractFilePath(param)+'\'+musica) then
      musica := ExtractFilePath(param)+'\'+musica;

    musica := StringReplace(musica,'/', '\', [rfIgnoreCase, rfReplaceAll]);
    musica := StringReplace(musica,'\\', '\', [rfIgnoreCase, rfReplaceAll]);
    if (Trim(musica) = '') then audio := false;

    if (audio) and not (FileExists(musica)) then
    begin
      if (musicaID <= 0) then
        audio := false
      else if (application.MessageBox(PChar('Arquivo "'+musica+'" não encontrado! Deseja baixar este arquivo agora?'), fmIndex.titulo, mb_yesno + mb_iconerror) = 6) then
      begin
        lista := TStringList.Create;
        lista.Clear;
        lista.Add('config\musicas\'+StringReplace(DM.cdsSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString,'/', '\', [rfIgnoreCase, rfReplaceAll]));

        fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
        fAtualiza.arquivos := lista;
        fAtualiza.ShowModal;

        if not (FileExists(musica)) then
        begin
          application.MessageBox(PChar('Não foi possível baixar o arquivo "'+musica+'"! Os slides serão executados sem áudio!'), fmIndex.titulo, mb_ok + mb_iconerror);
          audio := False;
        end;
      end
      else
        audio := False;
    end
    else
    begin

      // check the correct BASS was loaded
      if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
      begin
        application.MessageBox('A versão do seu arquivo "BASS.DLL" está incorreta!', fmIndex.titulo, mb_ok + mb_iconerror);
        audio := false;
        //Halt;
      end;

      // Initialize audio - default device, 44100hz, stereo, 16 bits
      try
        BASS_Init(-1, 44100, 0, Handle, nil);
      except
        //
      end;
//      if not BASS_Init(-1, 44100, 0, Handle, nil) then
//      begin
//        Error('Erro ao iniciar áudio "'+musica+'"!');
//        audio := false;
//      end;

      f := PChar(musica);
      try
        bass_musica := BASS_SampleLoad(FALSE, PChar(f), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
        bass_channel := BASS_SampleGetChannel(bass_musica, False);
  //      BASS_ChannelSetAttribute(bass_channel, BASS_ATTRIB_PAN, 0);
  //      BASS_ChannelSetAttribute(bass_channel, BASS_ATTRIB_VOL, 1);
        if not BASS_ChannelPlay(bass_channel, False) then
        begin
          Error('Erro ao reproduzir áudio "'+musica+'"!');
          audio := false;
        end;
      except
        Application.MessageBox(PChar('O programa travou ao tentar reproduzir áudio "'+musica+'"'),fmIndex.TITULO,MB_OK+MB_ICONERROR);
        audio := false;
      end;

      converteTempos();
      if (audio) then
      begin
        next_time := strtoint(lbTempos.Items[DM.cdsSLIDE_MUSICA.RecNo]);
      end;

      tmrTempo.Enabled := audio;

    end;

    if not audio then
    begin
      slideInfo('SEM_AUDIO');
      if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
      begin
        fMusicaOperador.pnlProgress.Visible := audio;
        fMusicaOperador.btPausePlay.Visible := audio;
      end;
    end;
  end;
end;

procedure TfMusica.carregaSlides;
var
  i: integer;
  tempo: string;
  info: string;
  aimg,uimg: string;
  apos,upos: string;
  uCor,uLetra: string;
begin
  DM.cdsSLIDE_MUSICA.Open;
  DM.cdsSLIDE_MUSICA.EmptyDataSet;
  lbLetras.Items.Clear;

  uimg := '';
  upos := '0';
  aimg := '';
  apos := '0';
  uCor := '';
  uLetra := '';
  info := '';
  if not audio then
    info := 'SEM_AUDIO'
  else
    info := 'COM_AUDIO';

  if (tipo = 'BD') then
  begin
    DM.qrSLIDE_MUSICA.Close;
    DM.qrSLIDE_MUSICA.ParamByName('MUSICA_ID').Value := musicaID;
    DM.qrSLIDE_MUSICA.Open;

    while not DM.qrSLIDE_MUSICA.eof do
    begin
      if (DM.qrSLIDE_MUSICA.RecNo <= 1) and (param = 'PB') and (DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString = '') then
      begin
        application.MessageBox(PChar('Esta música não possui playback. Será utilizado o áudio cantado!'), fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
        param := '';
      end;

      if (audio) and (param = 'PB') then
        info := 'PB'
      else if (audio) then
        info := 'CANTADO';

      slideInfo(param);

      DM.cdsSLIDE_MUSICA.Append;
      DM.cdsSLIDE_MUSICA.FieldByName('LOCAL').Value := 'BD';
      DM.cdsSLIDE_MUSICA.FieldByName('TIPO').Value := DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString;
      DM.cdsSLIDE_MUSICA.FieldByName('MUSICA_ID').Value := DM.qrSLIDE_MUSICA.FieldByName('MUSICA_ID').AsInteger;
      DM.cdsSLIDE_MUSICA.FieldByName('LETRA_ID').Value := DM.qrSLIDE_MUSICA.FieldByName('LETRA_ID').AsInteger;
      if (param = 'PB') and (DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString <> '')
        then DM.cdsSLIDE_MUSICA.FieldByName('URL_MUSICA').Value := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString
        else DM.cdsSLIDE_MUSICA.FieldByName('URL_MUSICA').Value := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString;
      DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE').Value := Ansiuppercase(DM.qrSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString);
      lbLetras.Items.Add(Ansiuppercase(DM.qrSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString));
      DM.cdsSLIDE_MUSICA.FieldByName('LETRA_AUX').Value := DM.qrSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString;
      DM.cdsSLIDE_MUSICA.FieldByName('ORDEM').Value := DM.qrSLIDE_MUSICA.FieldByName('ORDEM').AsInteger;
      if (param = 'PB')
        then DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').Value := DM.qrSLIDE_MUSICA.FieldByName('TEMPO_PB').AsString
        else DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').Value := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsString;

      if fmIndex.ckSlideTxtFormatPerso.Checked then
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('FUNDO_LETRA').Value := not fmIndex.ckMusicaFundoTransparente.Checked;
        if DM.qrSLIDE_MUSICA.RecNo = 1 then
        begin
          DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTitulo.Text;
          DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTituloMusica.ColorValue);
        end
        else
        begin
          DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTexto.Text;
          if (uLetra <> '') and (Trim(uLetra) = Trim(DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString)) then
          begin
            if uCor = '' then
            begin
              DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoRepetido.ColorValue);
              uCor := 'S';
            end
            else
            begin
              DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoMusica.ColorValue);
              uCor := '';
            end;
          end
          else
          begin
            DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTextoMusica.ColorValue);
            uCor := '';
          end;
          uLetra := DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString;
        end;
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').Value := fmIndex.seTamanhoTextoAux.Text;
        DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').Value := ColorToString(fmIndex.corTextoRepetido.ColorValue);
      end
      else
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('FUNDO_LETRA').Value := (DM.qrSLIDE_MUSICA.FieldByName('FUNDO_LETRA').AsInteger = 1);
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsInteger;
        DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString;
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').Value := DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsInteger;
        DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').Value := DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString;
      end;
      if fmIndex.ckSlideImgFormatPerso.Checked then
      begin
        if (fmIndex.ckFundoTransparente.Checked) then
        begin
          DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').Value := fMusica.Color;
          DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').Value := '';
          DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').Value := fmIndex.posicaoFundo.ItemIndex+1;
        end
        else
        begin
          DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').Value := ColorToString(fmIndex.corFundoMusica.ColorValue);
          DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').Value := fmIndex.imgFundoMusica.Text;
          DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').Value := fmIndex.posicaoFundo.ItemIndex+1;
        end;
      end
      else
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').Value := '$0000000';
        aimg := DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString;
        apos := DM.qrSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').AsString;
        if aimg = '' then
        begin
          aimg := uimg;
          apos := upos;
        end
        else
        begin
          uimg := aimg;
          upos := apos;
        end;
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').Value := fmIndex.dir_config+'imagens\'+aimg;
        DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').Value := '0'+apos;
      end;

      DM.cdsSLIDE_MUSICA.FieldByName('LETRA').Value := DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString;
      DM.cdsSLIDE_MUSICA.Post;

      DM.qrSLIDE_MUSICA.Next;
    end;
    DM.qrSLIDE_MUSICA.Close;
  end
  else if (tipo = 'EXT') then
  begin
    fmIndex.copiaArquivoParaSlides(param,DM.cdsSLIDE_MUSICA);
    lbTempos.Items.Clear;
    DM.cdsSLIDE_MUSICA.First;
    while not DM.cdsSLIDE_MUSICA.Eof do
    begin
      tempo := '0'+DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').AsString;
      lbTempos.Items.Add(tempo);
      lbLetras.Items.Add(DM.cdsSLIDE_MUSICA.FieldByName('LETRA_UCASE').AsString);
      DM.cdsSLIDE_MUSICA.Next;
    end;
    DM.cdsSLIDE_MUSICA.First;
  end
  else if (tipo = 'TXT') then
  begin
    fmIndex.copiaTextoParaSlides(param,DM.cdsSLIDE_MUSICA);
    lbTempos.Items.Clear;
    for i := 0 to DM.cdsSLIDE_MUSICA.RecordCount-1 do
      lbTempos.Items.Add('0');
  end
  else if (tipo = 'CDS') then
  begin
    DM.cdsSLIDE_MUSICA.LoadFromFile(param);
    DeleteFile(param);
    lbTempos.Items.Clear;
    DM.cdsSLIDE_MUSICA.First;
    while not DM.cdsSLIDE_MUSICA.Eof do
    begin
      tempo := '0'+DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').AsString;
    //  if audio
    //    then tempo := '0'+DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').AsString
    //    else tempo := '0';
      lbTempos.Items.Add(tempo);
      DM.cdsSLIDE_MUSICA.Next;
    end;
    if lbTempos.Items.Count > 0 then lbTempos.Items[0] := '0';
    DM.cdsSLIDE_MUSICA.First;
  end;

  slideInfo(info);
end;

procedure TfMusica.carregaTempos;
var
  lista,lista_img: TStringList;
begin
  if (tipo <> 'BD') then Exit;

  lista_img := TStringList.Create;
  lbTempos.Items.Clear;
  DM.qrSLIDE_MUSICA_TEMPOS.Close;
  DM.qrSLIDE_MUSICA_TEMPOS.ParamByName('MUSICA_ID').Value := musicaID;
  DM.qrSLIDE_MUSICA_TEMPOS.Open;
  while not DM.qrSLIDE_MUSICA_TEMPOS.eof do
  begin
    if (param = 'PB')
      then lbTempos.Items.Add('0'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('TEMPO_PB').AsString)
      else lbTempos.Items.Add('0'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('TEMPO').AsString);
    if (DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString <> '')
    and (not FileExists(fmIndex.dir_config+'imagens\'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString))
    and (lista_img.IndexOf(DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString) = -1) then
    begin
      lista_img.Add(DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString);
      if (application.MessageBox(PChar('Arquivo "'+fmIndex.dir_config+'imagens\'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString+'" não encontrado! Deseja baixar este arquivo agora?'), fmIndex.titulo, mb_yesno + mb_iconerror) = 6) then
      begin
        lista := TStringList.Create;
        lista.Clear;
        lista.Add('config\imagens\'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString);

        fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
        fAtualiza.arquivos := lista;
        fAtualiza.ShowModal;

        if not (FileExists(fmIndex.dir_config+'imagens\'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString)) then
          application.MessageBox(PChar('Não foi possível baixar o arquivo "'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('IMAGEM').AsString+'"! A tela ficará preta ao utilizar esta imagem!'), fmIndex.titulo, mb_ok + mb_iconerror);
      end
    end;
    DM.qrSLIDE_MUSICA_TEMPOS.Next;
  end;
  DM.qrSLIDE_MUSICA_TEMPOS.Close;
end;

procedure TfMusica.converteTempos;
var
  i: Integer;
  tempo: string;
  txt: TStringList;
begin
  txt := TStringList.Create;
  for i := 0 to lbTempos.Items.Count-1 do
  begin
    txt.Clear;
    tempo := lbTempos.Items[i];
    if Pos(':',tempo) > 0 then
    begin
      ExtractStrings([':'], [], PChar(tempo), txt);
      if (txt.Count) = 3 then
        tempo := inttostr((StrToInt('0'+txt[0])*60*60)+(StrToInt('0'+txt[1])*60)+StrToInt('0'+txt[2]))
      else
        tempo := inttostr((StrToInt('0'+txt[0])*60)+StrToInt('0'+txt[1]));

      tempo := IntToStr(BASS_ChannelSeconds2Bytes(bass_channel,StrToFloat(tempo)));
      lbTempos.Items[i] := tempo;
    end;
  end;
end;

procedure TfMusica.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if not FileExists(ParamStr(1))
    then Params.WndParent := 0;
end;

procedure TfMusica.cursor;
//var
//  pt: TPoint;
begin
  (*
  GetCursorPos(pt);
  if  (fMusica.left < pt.X) and (fMusica.left+fMusica.width > pt.X)
  and (fMusica.top < pt.Y) and (fMusica.top+fMusica.height > pt.Y) then
  begin
    ShowCursor(false);
//    Edit3.Text := 'OK';
  end
  else
  begin
    ShowCursor(true);
//    Edit3.Text := 'NOK';
  end;
  *)
end;

procedure TfMusica.dbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
begin
  fmIndex.DBGridDrawColumnCell(Sender,Rect,DataCol,Column,State);
end;

procedure TfMusica.Error(msg: string);
var
	s: string;
begin
	s := msg + #13#10 + 'Verifique se o dispositivo de áudio está conectado em seu computador.' + #13#10 + '(Código do Erro: ' + IntToStr(BASS_ErrorGetCode) + ')';
  application.MessageBox(PChar(s), fmIndex.titulo, mb_ok + mb_iconerror);
end;

procedure TfMusica.FormActivate(Sender: TObject);
begin

  ult_format := '';

  if fmIndex.ckMusicaTopo.Checked then
    FormStyle := fsStayOnTop;
  fmIndex.desenvolvedor(fmIndex.pnlModDes.Visible);
  if not DM.cdsSLIDE_MUSICA.Active then
  begin
    DM.cdsSLIDE_MUSICA.CreateDataSet;
    DM.cdsSLIDE_MUSICA.IndexName := '';
    DM.cdsSLIDE_MUSICA.IndexFieldNames := 'ORDEM';
    DM.cdsSLIDE_MUSICA.LogChanges := False;
  end;

  if (inicio <> true) then
  begin
    slideInfo('');
    lblLetra.Font.Name := 'DIN Condensed';
    lblLetra_aux.Font.Name := 'DIN Condensed';

    fMusica.Caption := '';
    uslide := 0;
    imgPosicao := 5;
    pcTexto := 0;
    pcTexto_aux := 0;
    fecharSlides := False;
    fecharSlidesRetorno := False;

    next_time := 0;
    pause := false;
    letraID := -1;
    lblLetra.Visible := False;
    lblLetra_aux.Visible := False;
    imgFundoTexto.Visible := False;
    imgFundo.Picture := nil;

    pnlLetra.DoubleBuffered := True;

    if fmIndex.ckSlideImgFormatPerso.Checked then
    begin
      if (fmIndex.ckFundoTransparente.Checked) then
      begin
        imgFundo.Visible := False;
        fMusica.Color := 1;
        fMusica.TransparentColor := True;
        fMusica.TransparentColorValue := fMusica.Color;
      end
      else
      begin
        fMusica.Color := clBlack;
        imgFundo.Visible := true;
        fMusica.TransparentColor := False;
      end;
    end
    else
    begin
      fMusica.Color := clBlack;
      imgFundo.Visible := true;
      fMusica.TransparentColor := False;
    end;


    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    begin
      fMusicaOperador.Caption := fMusica.Caption;
      fMusicaOperador.lblLetra.Font.Name := lblLetra.Font.Name;
      fMusicaOperador.lblLetra_aux.Font.Name := lblLetra_aux.Font.Name;
      fMusicaOperador.lblLetra.Visible := lblLetra.Visible;
      fMusicaOperador.lblLetra_aux.Visible := lblLetra_aux.Visible;
      fMusicaOperador.imgFundoTexto.Visible := imgFundoTexto.Visible;
      fMusicaOperador.imgFundo.Picture := imgFundo.Picture;
      fMusicaOperador.pnlLetra.DoubleBuffered := pnlLetra.DoubleBuffered;
    end;

    if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
    begin
      fMusicaRetorno.Caption := fMusica.Caption;
      fMusicaRetorno.lblLetra.Font.Name := lblLetra.Font.Name;
      fMusicaRetorno.lblLetra_aux.Font.Name := lblLetra_aux.Font.Name;
      fMusicaRetorno.lblLetra_prox.Font.Name := lblLetra.Font.Name;
      fMusicaRetorno.pnlLetra.DoubleBuffered := pnlLetra.DoubleBuffered;
    end;


    if (albumID > 0)
      then carregaAlbum()
      else carregaMusica();

    inicio := True;
  end;
end;

procedure TfMusica.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  //A fila só vale para esta exibição: some junto com a janela
  FreeAndNil(filaArquivos);
  filaIndice := 0;

  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('MUSICA', 'letra', '');
     fmIndex.gravaParamServer('MUSICA', 'letra_prox', '');
  end;

  if (fMusica.AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := fMusica.AlphaBlendValue downto 0 do
      begin
        fMusica.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fMusica.AlphaBlendValue := 0;
  end;

  if (audio) then
  begin
		BASS_MusicFree(bass_musica);
    BASS_Free();
  end;
  tmrTempo.Enabled := False;

  ShowCursor(true);

  DM.cdsSLIDE_MUSICA.Close;
  DM.qrSLIDE_MUSICA_ALBUM.Close;
  DM.qrLETRA_MUSICA.Close;

  if (fMusicaOperador <> nil) and (fecharSlides <> True) then
  begin
    fMusicaOperador.Tag := 0;
    fMusicaOperador.Close;
  end;

  if (fMusicaRetorno <> nil) and (fecharSlidesRetorno <> True)  then
  begin
    fMusicaRetorno.Tag := 0;
    fMusicaRetorno.Close;
  end;

  if (fmIndex.externo) then DM.tmrSair.Enabled := True;

end;

procedure TfMusica.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMusica.FormResize(Sender: TObject);
begin
  if (imgFundo.Visible) then
    fmIndex.ajustaImagem(imgFundo,pnlLetra,imgPosicao);

  ajustaTexto;

  pnlLetra.Refresh;
  pnlLetra.Repaint;
end;

procedure TfMusica.irSlide(num: integer);
begin
//  DM.cdsSLIDE_MUSICA.RecNo := num;
  nslide := DM.cdsSLIDE_MUSICA.RecNo;
  slide();
end;

function TfMusica.IsNumeric(const str: string): Boolean;
var
  tempValue: Double;
begin
  Result := TryStrToFloat(str, tempValue);
end;

procedure TfMusica.pauseplay;
begin
  if (pause) then
  begin
    BASS_ChannelPlay(bass_channel, False);
    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
      then fMusicaOperador.btPausePlay.ImageIndex := 15;
  end
  else
  begin
    BASS_ChannelPause(bass_channel);
    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
      then fMusicaOperador.btPausePlay.ImageIndex := 8;
  end;

  pause := not pause;
  tmrTempo.Enabled := not pause;
end;

procedure TfMusica.refresh;
var
  rec:integer;
begin
  rec := DM.cdsSLIDE_MUSICA.RecNo;
  DM.cdsSLIDE_MUSICA.Close;
  DM.cdsSLIDE_MUSICA.Open;
  DM.cdsSLIDE_MUSICA.RecNo := rec;
  rec := DM.qrLETRA_MUSICA.RecNo;
  DM.qrLETRA_MUSICA.Close;
  DM.qrLETRA_MUSICA.Open;
  DM.qrLETRA_MUSICA.RecNo := rec;
  fmIndex.AjustaLarguraCamposDBGrid(dbGrid);

  lbTempos.Items.Clear;
  DM.qrSLIDE_MUSICA_TEMPOS.Close;
  DM.qrSLIDE_MUSICA_TEMPOS.ParamByName('MUSICA_ID').Value := musicaID;
  DM.qrSLIDE_MUSICA_TEMPOS.Open;
  while not DM.qrSLIDE_MUSICA_TEMPOS.eof do
  begin
    lbTempos.Items.Add('0'+DM.qrSLIDE_MUSICA_TEMPOS.FieldByName('TEMPO').AsString);
    DM.qrSLIDE_MUSICA_TEMPOS.Next;
  end;
  DM.qrSLIDE_MUSICA_TEMPOS.Close;

  uslide := -1;
  slide(false);
end;


procedure TfMusica.slide(setPosicao:boolean);
var
  img: string;
  letra,letra_aux: string;
  pos: integer;
  cor_letra,cor_letra_aux: TColor;
  format: string;
begin
  format := '';

  nslide := DM.cdsSLIDE_MUSICA.RecNo;
  fMusicaOperador.DBGrid1.Refresh;
  if (DM.cdsSLIDE_MUSICA.RecNo = uslide) then exit;
  uslide := DM.cdsSLIDE_MUSICA.RecNo;

//  pnlLetra.DoubleBuffered := True;

  Edit1.Text := IntToStr(DM.cdsSLIDE_MUSICA.RecNo);
  if (lbTempos.Items.count >= uslide)
    then pos := strtoint(StringReplace(lbTempos.Items[uslide-1],':','', [rfIgnoreCase, rfReplaceAll]))//DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;
    else pos := 0;

  letraID := DM.cdsSLIDE_MUSICA.FieldByName('LETRA_ID').AsInteger;
  if ((DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') and
     (fmIndex.ckMusicaTituloSlide.Checked))
     or
     (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString <> 'CAPA')
  then
  begin
    letra := trim(DM.cdsSLIDE_MUSICA.FieldByName('LETRA').AsString);
    letra_aux := trim(DM.cdsSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString);
  end
  else
  begin
    letra := '';
    letra_aux := '';
  end;


  if (DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsInteger  > 0)
    then pcTexto := DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsInteger
  else if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA')
    then pcTexto := 18
  else if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString <> 'CAPA') and (fmIndex.pnlModDes.Visible)
    then pcTexto := 15
    else pcTexto := 14;

  if (DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsInteger  > 0)
    then pcTexto_aux := DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsInteger
    else pcTexto_aux := 10;

  if (DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').AsString <> '')
    then cor_letra := StringToColor(DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').AsString)
  else if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA')
    then cor_letra := $000b4ef
    else cor_letra := clWhite;

  if (DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString <> '')
    then cor_letra_aux := StringToColor(DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString)
    else cor_letra_aux := $000b4ef;

  if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA')
    then fMusica.Caption := letra;

  if (DM.qrLETRA_MUSICA.Active) then
    DM.qrLETRA_MUSICA.Locate('ID',letraID,[]);

  format := DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString
            + '|' + IntToStr(pcTexto)
            + '|' + letra
            + '|' + ColorToString(cor_letra)
            + '|' + DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').AsString;

  if (format = ult_format) then
  begin
    cor_letra := $000b4ef;
    format := DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString
              + '|' + IntToStr(pcTexto)
              + '|' + letra
              + '|' + ColorToString(cor_letra)
              + '|' + DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').AsString;
  end;
  ult_format := format;


  lblLetra.Visible := False;
  lblLetra_aux.Visible := False;
  imgFundoTexto.Visible := False;
  lblLetra.Caption := Ansiuppercase(letra);
  lblLetra.Font.Color := cor_letra;
  lblLetra_aux.Caption := Ansiuppercase(letra_aux);
  lblLetra_aux.Font.Color := cor_letra_aux;
  pnlLetra.Color := StringToColor(DM.cdsSLIDE_MUSICA.FieldByName('COR_FUNDO').AsString);

  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('MUSICA', 'letra', lblLetra.Caption);
     //fmIndex.gravaParamServer('MUSICA', 'cor_letra', fmIndex.ColorToHtml(lblLetra.Font.Color));
     fmIndex.gravaParamServer('MUSICA', 'class',AnsiLowerCase(DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString));
     if (lbLetras.Items.Count > nslide+1) then
      fmIndex.gravaParamServer('MUSICA', 'letra_prox', lbLetras.Items[nslide])
     else
      fmIndex.gravaParamServer('MUSICA', 'letra_prox', '');
  end;

  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA')
      then fMusicaOperador.Caption := 'Tela de Operador - '+fMusica.Caption;
    fMusicaOperador.lblLetra.Visible := False;
    fMusicaOperador.lblLetra_aux.Visible := False;
    fMusicaOperador.imgFundoTexto.Visible := False;
    fMusicaOperador.lblLetra.Caption := Ansiuppercase(letra);
    fMusicaOperador.lblLetra.Font.Color := cor_letra;
    fMusicaOperador.lblLetra_aux.Caption := Ansiuppercase(letra_aux);
    fMusicaOperador.lblLetra_aux.Font.Color := cor_letra_aux;
    fMusicaOperador.pnlLetra.Color := pnlLetra.Color;
    fMusicaOperador.lblSlides.Caption := 'SLIDE    '+inttostr(DM.cdsSLIDE_MUSICA.RecNo)+' / '+inttostr(DM.cdsSLIDE_MUSICA.RecordCount);
  end;

  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
  begin
    if (DM.cdsSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') then
    begin
      fMusicaRetorno.Caption := 'Tela de Retorno - '+fMusica.Caption;
      fMusicaRetorno.lblLetra.Font.Color := $000b4ef;
    end
    else
    begin
      fMusicaRetorno.lblLetra.Font.Color := clWhite;
    end;
    fMusicaRetorno.lblLetra.Caption := Ansiuppercase(letra);
    fMusicaRetorno.lblLetra_aux.Caption := Ansiuppercase(letra_aux);
    fMusicaRetorno.lblLetra_aux.Font.Color := $000b4ef;
    if (Trim(fMusicaRetorno.lblLetra.Caption) = '') then
    begin
      if (DM.cdsSLIDE_MUSICA.RecNo = DM.cdsSLIDE_MUSICA.RecordCount)
        then fMusicaRetorno.lblLetra.Caption := '< FIM >'
        else fMusicaRetorno.lblLetra.Caption := '< PAUSA >';
    end;
    if (lbLetras.Items.Count > nslide+1) then
    begin
      fMusicaRetorno.lblLetra_prox.Caption := lbLetras.Items[nslide];
      if trim(fMusicaRetorno.lblLetra_prox.Caption) = '' then
        fMusicaRetorno.lblLetra_prox.Caption := '< PAUSA >';
    end
    else
      fMusicaRetorno.lblLetra_prox.Caption := '< FIM >';
    fMusicaRetorno.lblSlides.Caption := inttostr(DM.cdsSLIDE_MUSICA.RecNo)+' / '+inttostr(DM.cdsSLIDE_MUSICA.RecordCount);
  end;

  if (Trim(lblLetra.Caption) <> '') or (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
  begin
    ajustaTexto;
    if (lblLetra.Visible <> true) and (Trim(lblLetra.Caption) <> '') then
    begin
      lblLetra.Visible := True;
      imgFundoTexto.Visible := DM.cdsSLIDE_MUSICA.FieldByName('FUNDO_LETRA').AsBoolean;
    end;
    if Trim(lblLetra_aux.Caption) <> ''
      then lblLetra_aux.Visible := True;

    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    begin
      fMusicaOperador.lblLetra.Visible := lblLetra.Visible;
      fMusicaOperador.imgFundoTexto.Visible := imgFundoTexto.Visible;
      fMusicaOperador.lblLetra_aux.Visible := lblLetra_aux.Visible;
    end;

  end;

  if (setPosicao) and (audio) then
  begin
    BASS_ChannelSetPosition(bass_channel, pos, BASS_POS_BYTE);
  end;

//  if (fmIndex.ckMusicaImagemFundo.Checked) or (not (fmIndex.ckMusicaImagemFundo.Checked) and (tipo <> 'BD')) then
//  begin
    img := DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM').AsString;
    if (img <> '') then
    begin
      imgPosicao := DM.cdsSLIDE_MUSICA.FieldByName('IMAGEM_POSICAO').AsInteger;
      if (imgPosicao <= 0) then imgPosicao := 5;

      if (img <> uImagem) then
      begin
        uImagem := img;
        uPosicao := imgPosicao;
        img := StringReplace(img,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
        if FileExists(ExtractFilePath(param)+'\'+img) then
          img := ExtractFilePath(param)+'\'+img;

        img := StringReplace(img,'/', '\', [rfIgnoreCase, rfReplaceAll]);
        img := StringReplace(img,'\\', '\', [rfIgnoreCase, rfReplaceAll]);

        carregaImagem(img);
      end
      else if uPosicao <> imgPosicao then
      begin
        uPosicao := imgPosicao;
        fmIndex.ajustaImagem(imgFundo,pnlLetra,imgPosicao);
        if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
        begin
          fmIndex.ajustaImagem(fMusicaOperador.imgFundo,fMusicaOperador.pnlLetra,imgPosicao);
        end;
      end;
    end;
//  end
//  else imgFundo.Visible := False;

  pnlLetra.Refresh;
  pnlLetra.Repaint;

  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
    then fMusicaOperador.gSlide.MinValue := StrToInt(StringReplace(lbTempos.Items[DM.cdsSLIDE_MUSICA.RecNo-1],':','', [rfIgnoreCase, rfReplaceAll]));//DM.cdsSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;

  if (audio) and (DM.cdsSLIDE_MUSICA.RecNo < DM.cdsSLIDE_MUSICA.RecordCount) then
  begin
    next_time := strtoint(StringReplace(lbTempos.Items[DM.cdsSLIDE_MUSICA.RecNo],':','', [rfIgnoreCase, rfReplaceAll]));
    Edit2.Text := 'TEMPO ATUAL: '+inttostr(pos)+#13#10+'PROX. TEMPO: '+IntToStr(next_time);

    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
      then fMusicaOperador.gSlide.MaxValue := next_time;
  end
  else
  begin
    next_time := -1;
    Edit2.Text := '-1';
    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1')
      then fMusicaOperador.gSlide.MaxValue := fMusicaOperador.gSlide.MinValue+1;
  end;

  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.gSlide.Value := fMusicaOperador.gSlide.MinValue;
    fMusicaOperador.gSlideTotal.Value := fMusicaOperador.gSlide.MinValue;
    if (trim(fMusicaOperador.lblTempo.Caption) <> '') then
      fMusicaOperador.lblTempo.Caption := fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE))))
                                       +' / '
                                       +fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,BASS_ChannelGetLength(bass_channel, BASS_POS_BYTE))));
  end;
//  pnlLetra.DoubleBuffered := False;

  if (audio) then tmrTempo.Enabled := True;
  cursor();
end;

procedure TfMusica.slideInfo(p: string);
begin
  if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.pnlInfo.Visible := False;

    if (p = 'PB') then
    begin
      fMusicaOperador.pnlInfo.Caption := 'PLAYBACK';
      fMusicaOperador.pnlInfo.Color := $006F3700;
    end
    else if (p = 'SEM_AUDIO') then
    begin
      fMusicaOperador.pnlInfo.Caption := 'SEM ÁUDIO';
      fMusicaOperador.pnlInfo.Color := clRed;
    end
    else if (p = 'COM_AUDIO') then
    begin
      fMusicaOperador.pnlInfo.Caption := 'COM ÁUDIO';
      fMusicaOperador.pnlInfo.Color := clNavy;
    end
    else if (p = 'CANTADO') then
    begin
      fMusicaOperador.pnlInfo.Caption := 'CANTADO';
      fMusicaOperador.pnlInfo.Color := clGreen;
    end
    else
    begin
      fMusicaOperador.pnlInfo.Caption := p;
      fMusicaOperador.pnlInfo.Color := clSilver;
    end;

    fMusicaOperador.pnlInfo.Visible := (p <> '');
  end;
end;

procedure TfMusica.tmrTempoTimer(Sender: TObject);
var
  B: Boolean;
  pos,len: DWORD;
begin

  if (inicio <> true) then Exit;
  if (audio <> true) then
  begin
    tmrTempo.Enabled := false;
    exit;
  end;


  B := BASS_ChannelIsActive(bass_channel) = BASS_ACTIVE_Playing;
  if B then
  begin
    pos := BASS_ChannelGetPosition(bass_channel, BASS_POS_BYTE);
    len := BASS_ChannelGetLength(bass_channel, BASS_POS_BYTE);

    if (fmIndex.lerParam('Musicas', 'ModoOperador', '1') = '1') then
    begin
      if next_time < 0
        then fMusicaOperador.gSlide.MaxValue := len
        else fMusicaOperador.gSlide.MaxValue := next_time;
      fMusicaOperador.gSlide.Value := pos;
      fMusicaOperador.gSlideTotal.MaxValue := len;
      fMusicaOperador.gSlideTotal.Value := pos;
      fMusicaOperador.lblTempo.Caption := fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,pos)))
                                       // +'-'+inttostr(pos)
                                       +' / '
                                       +fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,len)));
    end;
    if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
    begin
      if next_time < 0
        then fMusicaRetorno.gSlide.MaxValue := len
        else fMusicaRetorno.gSlide.MaxValue := next_time;
      fMusicaRetorno.gSlide.Value := pos;
      fMusicaRetorno.gSlideTotal.MaxValue := len;
      fMusicaRetorno.gSlideTotal.Value := pos;
      fMusicaRetorno.lblTempo.Caption := fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,pos)))
                                       // +'-'+inttostr(pos)
                                       +' / '
                                       +fmIndex.SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,len)));
    end;
    Edit3.Text := IntToStr(pos)+' / '+IntToStr(len);//+' / '+FormatDateTime('dd/mm/yyyy HH:MM:SS.ZZZ', now());

    if (next_time > 0) and (pos >= next_time) then
    begin
      fMusicaOperador.gSlide.MinValue := next_time;
      tmrTempo.Enabled := False;
      acaoSlide('prox',False);
    end;
  end
  else
  begin
    tmrTempo.Enabled := False;
    if not (pause) then
    begin
      if (albumID > 0) and (DM.qrSLIDE_MUSICA_ALBUM.RecNo < DM.qrSLIDE_MUSICA_ALBUM.RecordCount)
        then acaoAlbum('prox')
        else close;
    end;
  end;

  if fmIndex.ckMusicaJanela.Checked then
  begin

    if monitor <= Screen.MonitorCount-1 then
    begin
      if (fMusica.Left <> fmIndex.monitorInfo(monitor).Left)
        then fMusica.Left := fmIndex.monitorInfo(monitor).Left;
      if (fMusica.Top <> fmIndex.monitorInfo(monitor).Top)
        then fMusica.Top := fmIndex.monitorInfo(monitor).Top;
      if (fMusica.Width <> fmIndex.monitorInfo(monitor).Width)
        then fMusica.Width := fmIndex.monitorInfo(monitor).Width;
      if (fMusica.Height <> fmIndex.monitorInfo(monitor).Height)
        then fMusica.Height := fmIndex.monitorInfo(monitor).Height;
    end
    else
    begin
      if (fMusica.Left <> fmIndex.monitorInfo(0).Left)
        then fMusica.Left := fmIndex.monitorInfo(0).Left;
      if (fMusica.Top <> fmIndex.monitorInfo(0).Top)
        then fMusica.Top := fmIndex.monitorInfo(0).Top;
      if (fMusica.Width <> fmIndex.monitorInfo(0).Width)
        then fMusica.Width := fmIndex.monitorInfo(0).Width;
      if (fMusica.Height <> fmIndex.monitorInfo(0).Height)
        then fMusica.Height := fmIndex.monitorInfo(0).Height;
    end;
  end;

  cursor();
end;

end.
