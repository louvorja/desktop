unit fmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, CustomizeDlg, DB, ADODB, ComCtrls, ImgList, Grids,
  DBGrids, IniFiles, Menus, ExtCtrls, IdBaseComponent, IdIPWatch,
  IdAntiFreeze, DBClient, IdHTTP, AppEvnts, ValEdit, Mask, MPlayer, DateUtils,
  ActiveX, ShellApi, DBCtrls, OleCtrls, WinInet, OleCtnrs, CheckLst, pngimage,
  ToolWin, jpeg, IdCoder, IdCoderMIME, bsSkinBoxCtrls, bsSkinCtrls,
  bsribbon, BusinessSkinForm, bsSkinTabs, bsSkinExCtrls, bsSkinMenus,
  bsSkinGrids, bsDBGrids, bsdbctrls, bsColorCtrls, bsSkinShellCtrls,
  bsDialogs, Vcl.DBCGrids, ClipBrd, urlmon, RichEdit, bsButtonGroup,
  bsPngImageList, IdAntiFreezeBase, System.Zip, System.UITypes,
  MidasLib, IdStack, System.Types, Bass, Generics.Collections,
  Generics.Defaults, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.RegularExpressions;
  (*"MidasLib" NECESSÁRIA PARA EVITAR ERRO DE ACCESS VIOLATION NO DM.cds*)

type
  TMonitorInfo = record
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
  end;
  TfmIndex = class(TForm)
    IdAntiFreeze1: TIdAntiFreeze;
    bsRibbon1: TbsRibbon;
    bsColetaneas: TbsRibbonPage;
    bsBiblia: TbsRibbonPage;
    bsHinario: TbsRibbonPage;
    pnlImagemCapa: TPanel;
    imgImagemCapa: TImage;
    PageControl1: TbsSkinPageControl;
    TabSheet14: TbsSkinTabSheet;
    tsJA: TbsSkinTabSheet;
    sbColJA: TbsSkinScrollBox;
    tsDiversas: TbsSkinTabSheet;
    sbColDIV: TbsSkinScrollBox;
    tsPersonalizadas: TbsSkinTabSheet;
    tsHinario: TbsSkinTabSheet;
    DBGrid1: TbsSkinDBGrid;
    tsBuscaMusica: TbsSkinTabSheet;
    tsBiblia: TbsSkinTabSheet;
    tsBuscaBiblica: TbsSkinTabSheet;
    tsCronoCulto: TbsSkinTabSheet;
    mpMusica: TMediaPlayer;
    tsSorteio: TbsSkinTabSheet;
    pnlSorteio: TPanel;
    lmdSorteio: TLabel;
    gSorteio: TbsSkinGauge;
    opNumSorteado: TbsSkinEdit;
    opNumIndice: TbsSkinEdit;
    tsCronometro: TbsSkinTabSheet;
    pnlCrono: TPanel;
    lmdCrono: TLabel;
    gCrono: TbsSkinGauge;
    bsButtonModel: TbsSkinButtonEx;
    bsPopupMenuRibon: TbsSkinPopupMenu;
    mnFechaAba: TMenuItem;
    mnFechaTodasAbas: TMenuItem;
    N1: TMenuItem;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinScrollBar2: TbsSkinScrollBar;
    bsSkinScrollBar7: TbsSkinScrollBar;
    bsRibbonGroup5: TbsRibbonGroup;
    bsBuscaMusica: TbsRibbonPage;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsRibbonGroup7: TbsRibbonGroup;
    btAbreColJA: TbsSkinSpeedButton;
    bsRibbonGroup8: TbsRibbonGroup;
    bsSkinSpeedButton14: TbsSkinSpeedButton;
    bsSkinDBText1: TbsSkinDBText;
    bsRibbonGroup11: TbsRibbonGroup;
    ckgFiltros: TbsSkinCheckGroup;
    bsRibbonGroup2: TbsRibbonGroup;
    bsSkinSpeedButton10: TbsSkinSpeedButton;
    bsSkinSpeedButton9: TbsSkinSpeedButton;
    bsConfBiblia: TbsRibbonPage;
    bsRibbonGroup3: TbsRibbonGroup;
    btLimpar: TbsSkinSpeedButton;
    bsRibbonGroup10: TbsRibbonGroup;
    btExp_Biblia: TbsSkinMenuSpeedButton;
    bsRibbonGroup14: TbsRibbonGroup;
    sButton7: TbsSkinSpeedButton;
    bsUtilitarios: TbsRibbonPage;
    bsConfBuscaBiblica: TbsRibbonPage;
    bsRibbonGroup15: TbsRibbonGroup;
    btLimparBBusca: TbsSkinSpeedButton;
    bsRibbonGroup17: TbsRibbonGroup;
    bsSkinSpeedButton19: TbsSkinSpeedButton;
    bsRibbonGroup18: TbsRibbonGroup;
    btExp_BibliaBusca: TbsSkinMenuSpeedButton;
    bsRibbonGroup19: TbsRibbonGroup;
    ckLivros: TbsSkinCheckListBox;
    bsRibbonGroup20: TbsRibbonGroup;
    bsSkinSpeedButton20: TbsSkinSpeedButton;
    bsColetPerso: TbsRibbonPage;
    ppColetaneasPerso: TbsSkinPopupMenu;
    Modificar1: TMenuItem;
    Excluir1: TMenuItem;
    bsRibbonGroup22: TbsRibbonGroup;
    btAddColPerso: TbsSkinSpeedButton;
    btAltColPerso: TbsSkinSpeedButton;
    bsSkinSpeedButton24: TbsSkinSpeedButton;
    txtUrlInfoColetV: TbsSkinEdit;
    pnlreHino: TbsSkinPanel;
    bsSkinScrollBar11: TbsSkinScrollBar;
    reHino: TbsSkinRichEdit;
    bsRibbonGroup23: TbsRibbonGroup;
    bsSkinSpeedButton25: TbsSkinSpeedButton;
    bsSkinSpeedButton26: TbsSkinSpeedButton;
    bsRibbonGroup24: TbsRibbonGroup;
    bsSkinSpeedButton28: TbsSkinSpeedButton;
    bsSkinSpeedButton30: TbsSkinSpeedButton;
    GridPanel2: TGridPanel;
    txtHino: TbsSkinEdit;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsLiturgia: TbsRibbonPage;
    bsRibbonGroup25: TbsRibbonGroup;
    bsRibbonGroup27: TbsRibbonGroup;
    cbMarcarConc: TbsSkinCheckBox;
    pnLivros: TbsSkinExPanel;
    GridPanel15: TGridPanel;
    Button5: TbsSkinButton;
    Button6: TbsSkinButton;
    Button9: TbsSkinButton;
    GridPanel14: TGridPanel;
    Button7: TbsSkinButton;
    Button8: TbsSkinButton;
    GridPanel13: TGridPanel;
    ckLivros2: TbsSkinCheckListBox;
    pnlAltColPerso: TbsSkinExPanel;
    pnlAddColPerso: TbsSkinExPanel;
    GridPanel18: TGridPanel;
    bsSkinStdLabel24: TbsSkinStdLabel;
    txtAbrirColet: TbsSkinFileEdit;
    bsSkinStdLabel25: TbsSkinStdLabel;
    bsSkinStdLabel26: TbsSkinStdLabel;
    txtCapaColet: TbsSkinFileEdit;
    txtImgInfoColet: TbsSkinEdit;
    txtColetanea: TbsSkinEdit;
    txtUrlInfoColet: TbsSkinEdit;
    GridPanel19: TGridPanel;
    btAddColetPerso: TbsSkinButton;
    GridPanel22: TGridPanel;
    bsSkinStdLabel28: TbsSkinStdLabel;
    txtAbrirColet2: TbsSkinFileEdit;
    bsSkinStdLabel29: TbsSkinStdLabel;
    bsSkinStdLabel30: TbsSkinStdLabel;
    txtCapaColet2: TbsSkinFileEdit;
    txtImgInfoColet2: TbsSkinEdit;
    txtColetanea2: TbsSkinEdit;
    txtUrlInfoColet2: TbsSkinEdit;
    bsSkinStdLabel31: TbsSkinStdLabel;
    cbColetaneasPerso: TbsSkinDBLookupComboBox;
    GridPanel17: TGridPanel;
    bsSkinButton1: TbsSkinButton;
    bsCronoCulto: TbsRibbonPage;
    bsRibbonGroup28: TbsRibbonGroup;
    btLigar: TbsSkinSpeedButton;
    bsRibbonGroup30: TbsRibbonGroup;
    bsSkinSpeedButton33: TbsSkinSpeedButton;
    bsRibbonGroup31: TbsRibbonGroup;
    btExp_EscolaSabatina: TbsSkinMenuSpeedButton;
    rbgAudioES: TbsRibbonGroup;
    cgEscSBAudio: TbsSkinCheckGroup;
    bsRibbonDivider11: TbsRibbonDivider;
    GridPanel21: TGridPanel;
    cbMusica: TbsSkinComboBox;
    btOuvir: TbsSkinSpeedButton;
    bsRibbonGroup33: TbsRibbonGroup;
    bsRibbonGroup34: TbsRibbonGroup;
    bsSkinSpeedButton31: TbsSkinSpeedButton;
    bsSkinSpeedButton27: TbsSkinSpeedButton;
    bsSorteio: TbsRibbonPage;
    bsRibbonGroup35: TbsRibbonGroup;
    btLimpaSorteio: TbsSkinSpeedButton;
    bsRibbonDivider14: TbsRibbonDivider;
    GridPanel25: TGridPanel;
    btLimpaSorteioReinicia: TbsSkinSpeedButton;
    btLimpaSorteioLimpa: TbsSkinSpeedButton;
    bsRibbonGroup36: TbsRibbonGroup;
    btAddSorteio: TbsSkinSpeedButton;
    pnlSorteioE: TbsSkinExPanel;
    lbSorteio: TbsSkinOfficeListBox;
    pnlSorteioD: TbsSkinExPanel;
    lbSorteado: TbsSkinOfficeListBox;
    GridPanel26: TGridPanel;
    bsSkinStdLabel41: TbsSkinStdLabel;
    bsSkinStdLabel42: TbsSkinStdLabel;
    opSort_Ini: TbsSkinEdit;
    opSort_Fin: TbsSkinEdit;
    bsRibbonGroup37: TbsRibbonGroup;
    btExp_Sorteio: TbsSkinMenuSpeedButton;
    bsRibbonGroup38: TbsRibbonGroup;
    btSortear: TbsSkinSpeedButton;
    bsRibbonGroup39: TbsRibbonGroup;
    bsRibbonDivider16: TbsRibbonDivider;
    GridPanel29: TGridPanel;
    lblNumSortDisp: TbsSkinStdLabel;
    lblNumSortSort: TbsSkinStdLabel;
    bsRibbonDivider18: TbsRibbonDivider;
    ckSorteioExp: TbsSkinCheckGroup;
    bsRibbonGroup41: TbsRibbonGroup;
    bsSkinSpeedButton32: TbsSkinSpeedButton;
    btFormatBiblia: TbsSkinSpeedButton;
    pnlFormatBibliaB: TbsSkinExPanel;
    bsSkinScrollPanel2: TbsSkinScrollPanel;
    bsSkinDivider2: TbsSkinDivider;
    bsSkinPanel5: TbsSkinPanel;
    btFormatBibliaB: TbsSkinSpeedButton;
    btFormatEscSB: TbsSkinSpeedButton;
    pnlFormatEscSB: TbsSkinExPanel;
    bsSkinScrollPanel3: TbsSkinScrollPanel;
    bsSkinDivider7: TbsSkinDivider;
    bsSkinPanel6: TbsSkinPanel;
    gEscSbR: TbsSkinGauge;
    pnlEscSB: TPanel;
    pnlFormatSorteio: TbsSkinExPanel;
    bsSkinScrollPanel4: TbsSkinScrollPanel;
    bsSkinGroupBox8: TbsSkinGroupBox;
    bsSkinGroupBox9: TbsSkinGroupBox;
    btFormatSorteio: TbsSkinSpeedButton;
    bsRibbonGroup13: TbsRibbonGroup;
    bsSkinSpeedButton29: TbsSkinSpeedButton;
    tsSorteioNM: TbsSkinTabSheet;
    pnlFormatSorteioNM: TbsSkinExPanel;
    bsSkinScrollPanel5: TbsSkinScrollPanel;
    bsSkinDivider13: TbsSkinDivider;
    pnlSorteioNME: TbsSkinExPanel;
    lbSorteioNM: TbsSkinOfficeListBox;
    pnlSorteioNMD: TbsSkinExPanel;
    lbSorteadoNM: TbsSkinOfficeListBox;
    pnlSorteioNM: TPanel;
    lmdSorteioNM: TLabel;
    gSorteioNM: TbsSkinGauge;
    opNumSorteadoNM: TbsSkinEdit;
    opNumIndiceNM: TbsSkinEdit;
    bsSorteioNM: TbsRibbonPage;
    bsRibbonGroup16: TbsRibbonGroup;
    btLimpaSorteioNM: TbsSkinSpeedButton;
    bsRibbonDivider1: TbsRibbonDivider;
    GridPanel44: TGridPanel;
    btLimpaSorteioReiniciaNM: TbsSkinSpeedButton;
    btLimpaSorteioLimpaNM: TbsSkinSpeedButton;
    bsRibbonGroup29: TbsRibbonGroup;
    bsRibbonDivider5: TbsRibbonDivider;
    GridPanel46: TGridPanel;
    lblNumSortDispNM: TbsSkinStdLabel;
    lblNumSortSortNM: TbsSkinStdLabel;
    bsRibbonGroup40: TbsRibbonGroup;
    btSortearNM: TbsSkinSpeedButton;
    bsRibbonGroup42: TbsRibbonGroup;
    bsSkinSpeedButton40: TbsSkinSpeedButton;
    btFormatSorteioNM: TbsSkinSpeedButton;
    bsRibbonGroup43: TbsRibbonGroup;
    bsRibbonGroup44: TbsRibbonGroup;
    btExp_SorteioNM: TbsSkinMenuSpeedButton;
    bsRibbonDivider6: TbsRibbonDivider;
    ckSorteioExpNM: TbsSkinCheckGroup;
    GridPanel47: TGridPanel;
    bsSkinButton3: TbsSkinButton;
    bsSkinButton4: TbsSkinButton;
    bsSkinButton5: TbsSkinButton;
    bsSkinButton6: TbsSkinButton;
    GridPanel48: TGridPanel;
    bsSkinButton9: TbsSkinButton;
    GridPanel49: TGridPanel;
    bsSkinButton7: TbsSkinButton;
    GridPanel50: TGridPanel;
    bsSkinButton8: TbsSkinButton;
    bsSkinButton10: TbsSkinButton;
    bsSkinButton11: TbsSkinButton;
    bsSkinButton12: TbsSkinButton;
    GridPanel51: TGridPanel;
    bsSkinStdLabel48: TbsSkinStdLabel;
    opSort_Nm: TbsSkinEdit;
    btAddSorteioNM: TbsSkinSpeedButton;
    bsRibbonDivider7: TbsRibbonDivider;
    btImpSorteioNM: TbsSkinSpeedButton;
    bsCronometro: TbsRibbonPage;
    pnlFormatCrono: TbsSkinExPanel;
    bsSkinScrollPanel6: TbsSkinScrollPanel;
    bsSkinDivider18: TbsSkinDivider;
    pnlTempoGravado: TbsSkinExPanel;
    GridPanel56: TGridPanel;
    bsSkinButton13: TbsSkinButton;
    lbCrono: TbsSkinOfficeListBox;
    bsRibbonGroup46: TbsRibbonGroup;
    btExp_Cronometro: TbsSkinMenuSpeedButton;
    bsRibbonDivider12: TbsRibbonDivider;
    cbCronoEl: TbsSkinCheckGroup;
    bsRibbonGroup45: TbsRibbonGroup;
    bsSkinSpeedButton35: TbsSkinSpeedButton;
    btFormatCrono: TbsSkinSpeedButton;
    bsRibbonGroup47: TbsRibbonGroup;
    btIniciarCrono: TbsSkinSpeedButton;
    btZerarCrono: TbsSkinSpeedButton;
    bsRibbonGroup48: TbsRibbonGroup;
    rbDirecao: TbsSkinRadioGroup;
    GridPanel57: TGridPanel;
    txtDecr: TbsSkinMaskEdit;
    bsRibbonDivider20: TbsRibbonDivider;
    btAnotTempo: TbsSkinSpeedButton;
    tsPainelD: TbsSkinTabSheet;
    pnlFormatPainelD: TbsSkinExPanel;
    bsSkinScrollPanel7: TbsSkinScrollPanel;
    bsSkinDivider21: TbsSkinDivider;
    pnlTxtPainelD: TPanel;
    lmdTxtPainelD: TLabel;
    bsPainelD: TbsRibbonPage;
    bsRibbonGroup49: TbsRibbonGroup;
    bsSkinSpeedButton36: TbsSkinSpeedButton;
    btFormatPainelD: TbsSkinSpeedButton;
    bsRibbonGroup50: TbsRibbonGroup;
    btExp_PainelD: TbsSkinMenuSpeedButton;
    bsRibbonGroup51: TbsRibbonGroup;
    btExibeTxtPainelD: TbsSkinSpeedButton;
    bsSkinPanel7: TbsSkinPanel;
    mmPainelD: TbsSkinMemo;
    tsTextoInterativo: TbsSkinTabSheet;
    RichEdit0: TbsSkinRichEdit;
    bsTextoInterativo: TbsRibbonPage;
    bsRibbonGroup52: TbsRibbonGroup;
    btExp_TextoInterativo: TbsSkinMenuSpeedButton;
    bsRibbonGroup53: TbsRibbonGroup;
    GridPanel62: TGridPanel;
    fcTxtI0: TbsSkinFontComboBox;
    btfsBold0: TbsSkinSpeedButton;
    btfsItalic0: TbsSkinSpeedButton;
    btfsUnderline0: TbsSkinSpeedButton;
    btfsStrikeOut0: TbsSkinSpeedButton;
    cbFontSizeModel: TbsSkinComboBox;
    GridPanel63: TGridPanel;
    seTxtITamanho0: TbsSkinComboBox;
    bsRibbonDivider22: TbsRibbonDivider;
    cbColorTxtI0: TbsSkinColorButton;
    cbColorFTxtI0: TbsSkinColorButton;
    bsRibbonGroup54: TbsRibbonGroup;
    GridPanel64: TGridPanel;
    bsSkinSpeedButton39: TbsSkinSpeedButton;
    bsSkinSpeedButton41: TbsSkinSpeedButton;
    bsSkinSpeedButton42: TbsSkinSpeedButton;
    bsRibbonGroup55: TbsRibbonGroup;
    bsSkinSpeedButton38: TbsSkinSpeedButton;
    bsSkinSpeedButton43: TbsSkinSpeedButton;
    bsSkinScrollBar12: TbsSkinScrollBar;
    bsSkinScrollBar13: TbsSkinScrollBar;
    cbColorRTxtI0: TbsSkinColorButton;
    bsSkinSpeedButton44: TbsSkinSpeedButton;
    bsRibbonDivider23: TbsRibbonDivider;
    bsRibbonGroup56: TbsRibbonGroup;
    bsSkinSpeedButton45: TbsSkinSpeedButton;
    bsRibbonDivider24: TbsRibbonDivider;
    GridPanel65: TGridPanel;
    bttaLeftJustify0: TbsSkinSpeedButton;
    bttaRightJustify0: TbsSkinSpeedButton;
    bttaCenter0: TbsSkinSpeedButton;
    bsAppMenu1: TbsAppMenu;
    bsSkinTabSheet3: TbsSkinTabSheet;
    ampAbout: TbsAppMenuPage;
    ampOpcoes: TbsAppMenuPage;
    bsSkinPanel8: TbsSkinPanel;
    bsSkinPanel9: TbsSkinPanel;
    Image19: TbsPngImageView;
    bsSkinStdLabel75: TbsSkinStdLabel;
    bsSkinPanel28: TbsSkinPanel;
    bsSkinPanel29: TbsSkinPanel;
    bsSkinStdLabel77: TbsSkinStdLabel;
    ScrollBox2: TScrollBox;
    bsSkinPanel46: TbsSkinPanel;
    ckMonitorJanela: TbsSkinCheckBox;
    ampDesenvolvedor: TbsAppMenuPage;
    bsSkinPanel34: TbsSkinPanel;
    bsSkinStdLabel82: TbsSkinStdLabel;
    ScrollBox4: TbsSkinPanel;
    PageControl5: TbsSkinPageControl;
    sTabSheet9: TbsSkinTabSheet;
    loadCol: TValueListEditor;
    sTabSheet10: TbsSkinTabSheet;
    param: TValueListEditor;
    sTabSheet11: TbsSkinTabSheet;
    paramAtualiz: TValueListEditor;
    sTabSheet16: TbsSkinTabSheet;
    sTabSheet13: TbsSkinTabSheet;
    mmConfigJA: TbsSkinMemo;
    sPanel22: TbsSkinPanel;
    sTabSheet12: TbsSkinTabSheet;
    sTabSheet14: TbsSkinTabSheet;
    sTabSheet15: TbsSkinTabSheet;
    lvMonitores: TbsSkinListView;
    sTabSheet17: TbsSkinTabSheet;
    sTabSheet18: TbsSkinTabSheet;
    Splitter1: TSplitter;
    slbTabelas: TbsSkinListBox;
    bsSkinTabSheet1: TbsSkinTabSheet;
    bsSkinTabSheet2: TbsSkinTabSheet;
    bsSkinPanel36: TbsSkinPanel;
    lblVersao: TbsSkinStdLabel;
    bsSkinStdLabel85: TbsSkinStdLabel;
    bsRibbonDivider33: TbsRibbonDivider;
    gpSobre: TGridPanel;
    ScrollBox1: TScrollBox;
    bsSkinPanel37: TbsSkinPanel;
    bsSkinStdLabel86: TbsSkinStdLabel;
    bsSkinPanel38: TbsSkinPanel;
    Image29: TbsPngImageView;
    bsSkinLinkLabel10: TbsSkinLinkLabel;
    bsSkinPanel39: TbsSkinPanel;
    bsSkinLinkLabel11: TbsSkinLinkLabel;
    Image30: TbsPngImageView;
    bsSkinPanel40: TbsSkinPanel;
    bsSkinStdLabel89: TbsSkinStdLabel;
    bsSkinPanel41: TbsSkinPanel;
    bsSkinLinkLabel12: TbsSkinLinkLabel;
    Image31: TbsPngImageView;
    bsSkinPanel42: TbsSkinPanel;
    bsSkinLinkLabel13: TbsSkinLinkLabel;
    Image32: TbsPngImageView;
    bsSkinPanel43: TbsSkinPanel;
    bsSkinStdLabel92: TbsSkinStdLabel;
    ScrollBox5: TScrollBox;
    bsSkinPanel22: TbsSkinPanel;
    bsSkinStdLabel69: TbsSkinStdLabel;
    bsSkinPanel23: TbsSkinPanel;
    bsSkinStdLabel70: TbsSkinStdLabel;
    bsSkinPanel24: TbsSkinPanel;
    bsSkinLinkLabel7: TbsSkinLinkLabel;
    Image25: TbsPngImageView;
    bsSkinPanel25: TbsSkinPanel;
    bsSkinLinkLabel8: TbsSkinLinkLabel;
    Image20: TbsPngImageView;
    bsSkinPanel10: TbsSkinPanel;
    bsSkinLinkLabel1: TbsSkinLinkLabel;
    Image21: TbsPngImageView;
    bsErroHino: TbsRibbonGroup;
    bsSkinSpeedButton23: TbsSkinSpeedButton;
    bsErroMusica: TbsRibbonGroup;
    bsSkinSpeedButton37: TbsSkinSpeedButton;
    sButton10: TbsSkinButton;
    bsSkinButton14: TbsSkinButton;
    mmParam: TbsSkinMemo;
    DBGrid3: TbsSkinDBGrid;
    bsSkinScrollBar16: TbsSkinScrollBar;
    bsSkinScrollBar17: TbsSkinScrollBar;
    paramtemp: TbsSkinMemo;
    bsSkinPanel11: TbsSkinPanel;
    bsSkinScrollBar20: TbsSkinScrollBar;
    bsSkinScrollBar21: TbsSkinScrollBar;
    bsSkinDBGrid2: TbsSkinDBGrid;
    bsSkinPanel12: TbsSkinPanel;
    bsSkinButton15: TbsSkinButton;
    bsSkinTabSheet4: TbsSkinTabSheet;
    mmLog: TbsSkinMemo;
    bsSkinScrollBar22: TbsSkinScrollBar;
    bsRibbonDivider40: TbsRibbonDivider;
    ppExcluirPersonalizadas: TbsSkinPopupMenu;
    Excluir2: TMenuItem;
    ExcluirTodas1: TMenuItem;
    bsSkinSpeedButton46: TbsSkinMenuSpeedButton;
    bsRibbonGroup26: TbsRibbonGroup;
    cbBibliaHistorico: TbsSkinCheckBox;
    bsSkinTabSheet5: TbsSkinTabSheet;
    bsSkinSpeedButton50: TbsSkinSpeedButton;
    tsRelogio: TbsSkinTabSheet;
    pnlFormatRelogio: TbsSkinExPanel;
    bsSkinScrollPanel8: TbsSkinScrollPanel;
    bsSkinDivider24: TbsSkinDivider;
    pnlRelogio: TPanel;
    lmdRelogio: TLabel;
    bsRelogio: TbsRibbonPage;
    bsRibbonGroup57: TbsRibbonGroup;
    bsSkinSpeedButton51: TbsSkinSpeedButton;
    btFormatRelogio: TbsSkinSpeedButton;
    bsRibbonGroup58: TbsRibbonGroup;
    btExp_Relogio: TbsSkinMenuSpeedButton;
    pnlImagemCapaModel: TPanel;
    imgImagemCapaModel: TImage;
    bsSkinPanel18: TbsSkinPanel;
    bsSkinStdLabel59: TbsSkinStdLabel;
    corCapaPrograma: TbsSkinColorButton;
    bsSkinPanel19: TbsSkinPanel;
    bsSkinStdLabel63: TbsSkinStdLabel;
    imgCapaPrograma: TbsSkinFileEdit;
    bsSkinPanel21: TbsSkinPanel;
    bsSkinStdLabel60: TbsSkinStdLabel;
    cbAlinhamentoCapaPrograma: TbsSkinComboBox;
    btRestaurarCapaPrograma: TbsSkinButton;
    txtImgCapaProgramaInfo: TbsSkinEdit;
    bsRibbonGroup59: TbsRibbonGroup;
    GridPanel75: TGridPanel;
    bsSkinSpeedButton53: TbsSkinSpeedButton;
    bsSkinSpeedButton54: TbsSkinSpeedButton;
    bsSkinSpeedButton55: TbsSkinSpeedButton;
    bsRibbonDivider43: TbsRibbonDivider;
    btApagaLitSel: TbsSkinSpeedButton;
    imgCrono: TImage;
    imgEscSB: TImage;
    lmdEscSb: TLabel;
    lmdEscSbR: TLabel;
    imgSorteio: TImage;
    imgSorteioNM: TImage;
    imgTxtPainelD: TImage;
    imgRelogio: TImage;
    bsColetaneasOnline: TbsRibbonPage;
    bsRibbonGroup60: TbsRibbonGroup;
    bsSkinSpeedButton58: TbsSkinSpeedButton;
    tsColetaneasOnline: TbsSkinTabSheet;
    bsSkinExPanel6: TbsSkinExPanel;
    bsSkinButton25: TbsSkinButton;
    bgOnlCanais: TbsSkinButtonGroup;
    imgYoutubeCapa: TImage;
    pnlOnlPlaylists: TbsSkinExPanel;
    bsSkinButton24: TbsSkinButton;
    bgOnlPlaylists: TbsSkinButtonGroup;
    pnlOnlVideos: TbsSkinExPanel;
    GridPanel81: TGridPanel;
    bsSkinButton26: TbsSkinButton;
    lbbgOnlCanais: TbsSkinListBox;
    lbbgOnlPlaylists: TbsSkinListBox;
    lbbgOnlVideos: TbsSkinListBox;
    gaOnlVideos: TbsSkinGauge;
    bgOnlVideos: TbsSkinButtonGroup;
    bsSkinPanel13: TbsSkinPanel;
    bsSkinStdLabel96: TbsSkinStdLabel;
    sbVideoOnAreaExtendida: TbsSkinComboBox;
    bsSkinPanel48: TbsSkinPanel;
    ckVideoOnJanela: TbsSkinCheckBox;
    bsConfigColetaneasOnline: TbsRibbonPage;
    bsRibbonGroup61: TbsRibbonGroup;
    bsSkinSpeedButton60: TbsSkinSpeedButton;
    bsRibbonGroup62: TbsRibbonGroup;
    bsSkinSpeedButton62: TbsSkinSpeedButton;
    btUrlVideoOn: TbsSkinSpeedButton;
    bsRibbonDivider42: TbsRibbonDivider;
    GridPanel82: TGridPanel;
    bsSkinStdLabel97: TbsSkinStdLabel;
    txtUrlVideoOn: TbsSkinEdit;
    Image37: TbsPngImageView;
    bsSkinPanel49: TbsSkinPanel;
    bsSkinStdLabel98: TbsSkinStdLabel;
    sbVideoOnAbreLiturgia: TbsSkinComboBox;
    bsRibbonGroup63: TbsRibbonGroup;
    bsRibbonGroup64: TbsRibbonGroup;
    bsSkinSpeedButton59: TbsSkinSpeedButton;
    bsSkinSpeedButton61: TbsSkinSpeedButton;
    bsRibbonGroup65: TbsRibbonGroup;
    btColetaneasOnlinePerso: TbsSkinSpeedButton;
    bsRibbonGroup66: TbsRibbonGroup;
    btUrlVideoOn2: TbsSkinSpeedButton;
    bsSkinSpeedButton66: TbsSkinSpeedButton;
    GridPanel83: TGridPanel;
    bsSkinStdLabel99: TbsSkinStdLabel;
    txtUrlVideoOn2: TbsSkinEdit;
    Image23: TbsPngImageView;
    tsColetaneasOnlinePerso: TbsSkinTabSheet;
    bsConfigColetaneasOnlinePerso: TbsRibbonPage;
    DBGrid4: TbsSkinDBGrid;
    bsSkinScrollBar24: TbsSkinScrollBar;
    stVideosOnPerso: TbsSkinStatusBar;
    bsRibbonGroup67: TbsRibbonGroup;
    btAddVideoOn3: TbsSkinSpeedButton;
    GridPanel84: TGridPanel;
    bsSkinStdLabel100: TbsSkinStdLabel;
    txtUrlVideoOn3: TbsSkinEdit;
    txtNomeVideoOn3: TbsSkinEdit;
    bsSkinStdLabel101: TbsSkinStdLabel;
    bsSkinSpeedButton68: TbsSkinSpeedButton;
    bsSkinTabSheet6: TbsSkinTabSheet;
    bsSkinDBGrid3: TbsSkinDBGrid;
    bsSkinScrollBar25: TbsSkinScrollBar;
    ppVideosOnPerso: TbsSkinPopupMenu;
    Excluir3: TMenuItem;
    N3: TMenuItem;
    Executar1: TMenuItem;
    CopiarLink1: TMenuItem;
    AbrirnoNavegador1: TMenuItem;
    pnlfmBarraTituloForm: TPanel;
    bsFmIndex: TbsBusinessSkinForm;
    btwsformBotoes: TbsSkinToolBar;
    btwsMinimize: TbsSkinSpeedButton;
    btwsMaximized: TbsSkinSpeedButton;
    btwsClose: TbsSkinSpeedButton;
    pnlfmTituloRib: TPanel;
    pnlTitForm: TPanel;
    btwsspDownload: TbsSkinBevel;
    btwsDownload: TbsSkinSpeedButton;
    lblfmTituloRib: TbsSkinStdLabel;
    bsFavoritos: TbsRibbonPage;
    bsRibbonGroup68: TbsRibbonGroup;
    ogFavoritos: TbsSkinOfficeGallery;
    bsRibbonGroup69: TbsRibbonGroup;
    btAddFav: TbsSkinSpeedButton;
    bsSkinTabSheet7: TbsSkinTabSheet;
    bsSkinDBGrid4: TbsSkinDBGrid;
    bsPopupMenuFavoritos: TbsSkinPopupMenu;
    MenuItem1: TMenuItem;
    miAddFav: TMenuItem;
    miDelFav: TMenuItem;
    GridPanel85: TGridPanel;
    btDelFav: TbsSkinSpeedButton;
    btOrdFav: TbsSkinSpeedButton;
    AlterarOrdem1: TMenuItem;
    pnlfmSubTituloRib: TPanel;
    pnlModDes: TPanel;
    bsSkinPanel15: TbsSkinPanel;
    bsSkinLinkLabel2: TbsSkinLinkLabel;
    bsPngImageView1: TbsPngImageView;
    bsRibbonDivider44: TbsRibbonDivider;
    bsSkinSpeedButton63: TbsSkinSpeedButton;
    bsSkinSpeedButton64: TbsSkinSpeedButton;
    bsRibbonDivider45: TbsRibbonDivider;
    bsSkinPanel16: TbsSkinPanel;
    bsSkinScrollBar9: TbsSkinScrollBar;
    sbColPERSO: TbsSkinScrollBox;
    GridPanel86: TGridPanel;
    txtBuscaColetPeso: TbsSkinEdit;
    bsSkinStdLabel57: TbsSkinStdLabel;
    stColetPerso: TbsSkinStatusBar;
    bsSkinScrollBar14: TbsSkinScrollBar;
    bsSkinScrollBar15: TbsSkinScrollBar;
    bsSkinPanel14: TbsSkinPanel;
    bsSkinStdLabel71: TbsSkinStdLabel;
    bsSkinPanel17: TbsSkinPanel;
    bsSkinLinkLabel3: TbsSkinLinkLabel;
    bsPngImageView2: TbsPngImageView;
    bsSkinPanel50: TbsSkinPanel;
    bsSkinLinkLabel4: TbsSkinLinkLabel;
    bsPngImageView3: TbsPngImageView;
    bsSkinPanel20: TbsSkinPanel;
    bsRibbonDivider30: TbsRibbonDivider;
    bsSkinPanel52: TbsSkinPanel;
    bsSkinStdLabel72: TbsSkinStdLabel;
    sbMusicaAreaExtendida: TbsSkinComboBox;
    bsSkinPanel53: TbsSkinPanel;
    ckMusicaJanela: TbsSkinCheckBox;
    bsRibbonGroup21: TbsRibbonGroup;
    btAbreHinos: TbsSkinSpeedButton;
    bsSkinSpeedButton4: TbsSkinSpeedButton;
    bsSkinPanel54: TbsSkinPanel;
    ckMusicaOperador: TbsSkinCheckBox;
    btAddItemLiturgia: TbsSkinSpeedButton;
    ampImpExp: TbsAppMenuPage;
    bsSkinPanel31: TbsSkinPanel;
    bsSkinPanel32: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    ScrollBox3: TScrollBox;
    bsSkinPanel62: TbsSkinPanel;
    bsSkinButton17: TbsSkinButton;
    bsSkinButton18: TbsSkinButton;
    bsSkinPanel56: TbsSkinPanel;
    bsSkinButton16: TbsSkinButton;
    bsSkinButton19: TbsSkinButton;
    bsSkinPanel57: TbsSkinPanel;
    bsSkinButton28: TbsSkinButton;
    bsSkinButton29: TbsSkinButton;
    bsSkinPanel58: TbsSkinPanel;
    bsSkinButton30: TbsSkinButton;
    bsSkinButton31: TbsSkinButton;
    bsSkinPanel60: TbsSkinPanel;
    bsSkinButton32: TbsSkinButton;
    bsSkinButton33: TbsSkinButton;
    ampDoe: TbsAppMenuPage;
    bsSkinPanel33: TbsSkinPanel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    ScrollBox6: TScrollBox;
    bsSkinPanel61: TbsSkinPanel;
    bsSkinStdLabel83: TbsSkinStdLabel;
    tsDoxologia: TbsSkinTabSheet;
    bsSkinExPanel1: TbsSkinExPanel;
    bgDoxologiaCate: TbsSkinButtonGroup;
    lbbgDoxologiaCate: TbsSkinListBox;
    pnlDoxologiaMusicas: TbsSkinExPanel;
    dbctrlDoxologiaMusicas: TbsSkinDBCtrlGrid;
    Panel6: TPanel;
    bsSkinDBText4: TbsSkinDBText;
    bsSkinPanel64: TbsSkinPanel;
    imgDoxologiaCate: TImage;
    lblDoxologiaCate: TbsSkinLabel;
    btErro: TbsSkinButton;
    tsLiturgia: TbsSkinTabSheet;
    sbLiturgia: TbsSkinScrollBox;
    bsSkinScrollBar3: TbsSkinScrollBar;
    GridPanel23: TGridPanel;
    lcal_2: TbsSkinSpeedButton;
    lcal_3: TbsSkinSpeedButton;
    lcal_4: TbsSkinSpeedButton;
    lcal_5: TbsSkinSpeedButton;
    lcal_6: TbsSkinSpeedButton;
    lcal_7: TbsSkinSpeedButton;
    lcal_1: TbsSkinSpeedButton;
    bsRibbonDivider9: TbsRibbonDivider;
    bsRibbonDivider13: TbsRibbonDivider;
    bsRibbonDivider15: TbsRibbonDivider;
    bsRibbonDivider17: TbsRibbonDivider;
    bsRibbonDivider19: TbsRibbonDivider;
    bsRibbonDivider21: TbsRibbonDivider;
    lit_modItem: TbsSkinPanel;
    lit_modItem_icomus6: TbsPngImageView;
    lit_modItem_icomus4: TbsPngImageView;
    lit_modItem_icomus3: TbsPngImageView;
    lit_modItem_icomus1: TbsPngImageView;
    lit_modItem_btedit: TbsPngImageView;
    lit_modItem_divider: TbsRibbonDivider;
    lit_modItem_btmove: TPanel;
    lit_modItem_bticon: TPanel;
    lit_modItem_bticon_img: TbsPngImageView;
    lit_modItem_checkb: TbsSkinCheckBox;
    lit_modItem_texto: TbsSkinPanel;
    lit_modItem_subtitulo: TbsSkinStdLabel;
    lit_modItem_titulo: TbsSkinStdLabel;
    lit_modItem_btmove_img: TbsPngImageView;
    mmLiturgia: TbsSkinMemo;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinButton34: TbsSkinButton;
    bsSkinButton35: TbsSkinButton;
    bsSkinPanel65: TbsSkinPanel;
    ckMusicaTituloSlide: TbsSkinCheckBox;
    ampSincroniza: TbsAppMenuPage;
    bsSkinPanel66: TbsSkinPanel;
    bsSkinPanel67: TbsSkinPanel;
    bsSkinStdLabel33: TbsSkinStdLabel;
    ScrollBox7: TScrollBox;
    tabLetras: TbsSkinTabControl;
    DBGrid2: TbsSkinDBGrid;
    bsSkinScrollBar8: TbsSkinScrollBar;
    pnlreBusca: TbsSkinPanel;
    bsSkinScrollBar10: TbsSkinScrollBar;
    reBusca: TbsSkinRichEdit;
    GridPanel3: TGridPanel;
    txtBusca: TbsSkinEdit;
    bsSkinStdLabel5: TbsSkinStdLabel;
    txtIDMusica: TbsSkinDBText;
    bsFormatSlPerso: TbsSkinPanel;
    ckSlideTxtFormatPerso: TbsSkinCheckBox;
    GridPanel1: TGridPanel;
    bsSkinStdLabel103: TbsSkinStdLabel;
    seSorteioTempo: TbsSkinSpinEdit;
    GridPanel4: TGridPanel;
    bsSkinStdLabel104: TbsSkinStdLabel;
    seSorteioTempoNM: TbsSkinSpinEdit;
    bsRibbonGroup1: TbsRibbonGroup;
    btExportarHino: TbsSkinMenuSpeedButton;
    bsExportarMusica: TbsSkinPopupMenu;
    miOpcExportar1: TMenuItem;
    miOpcExportar3: TMenuItem;
    bsRibbonGroup4: TbsRibbonGroup;
    btExportarMusica: TbsSkinMenuSpeedButton;
    bsFormatSlidePerso: TbsSkinPanel;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    rbHinoTipo: TbsSkinRadioGroup;
    lit_modItem_icomus2: TbsPngImageView;
    bsRibbonGroup71: TbsRibbonGroup;
    GridPanel27: TGridPanel;
    bsSkinStdLabel107: TbsSkinStdLabel;
    cbFormatoHora: TbsSkinComboBox;
    tsMusicasInfantis: TbsSkinTabSheet;
    dbctrlMusicasInfantis: TbsSkinDBCtrlGrid;
    Panel1: TPanel;
    bsSkinDBText3: TbsSkinDBText;
    bsPngImageView6: TbsPngImageView;
    bsPngImageView7: TbsPngImageView;
    bsPngImageView8: TbsPngImageView;
    bsPngImageView9: TbsPngImageView;
    bsPngImageView10: TbsPngImageView;
    bsSkinStdLabel108: TbsSkinStdLabel;
    fcSorteioFonte: TbsSkinFontComboBox;
    GridPanel28: TGridPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    bsSkinStdLabel18: TbsSkinStdLabel;
    bsSkinStdLabel109: TbsSkinStdLabel;
    csSorteioCor: TbsSkinColorButton;
    seSorteioTamanho: TbsSkinSpinEdit;
    bsSkinStdLabel19: TbsSkinStdLabel;
    tsSorteioImagem: TbsSkinFileEdit;
    tsSorteioImagemInfo: TbsSkinEdit;
    GridPanel38: TGridPanel;
    Panel4: TPanel;
    bsSkinStdLabel37: TbsSkinStdLabel;
    Panel5: TPanel;
    bsSkinStdLabel110: TbsSkinStdLabel;
    csSorteioCorFundo: TbsSkinColorButton;
    cbSorteioPosicaoFundo: TbsSkinComboBoxEx;
    bsSkinDivider12: TbsSkinDivider;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinStdLabel12: TbsSkinStdLabel;
    fcSorteioFonteNM: TbsSkinFontComboBox;
    GridPanel10: TGridPanel;
    Panel7: TPanel;
    bsSkinStdLabel14: TbsSkinStdLabel;
    seSorteioTamanhoNM: TbsSkinSpinEdit;
    Panel8: TPanel;
    bsSkinStdLabel15: TbsSkinStdLabel;
    csSorteioCorNM: TbsSkinColorButton;
    bsSkinGroupBox11: TbsSkinGroupBox;
    bsSkinStdLabel16: TbsSkinStdLabel;
    tsSorteioNMImagem: TbsSkinFileEdit;
    tsSorteioNMImagemInfo: TbsSkinEdit;
    GridPanel20: TGridPanel;
    Panel9: TPanel;
    bsSkinStdLabel17: TbsSkinStdLabel;
    cbSorteioNMPosicaoFundo: TbsSkinComboBoxEx;
    Panel10: TPanel;
    bsSkinStdLabel38: TbsSkinStdLabel;
    csSorteioCorFundoNM: TbsSkinColorButton;
    bsSkinGroupBox10: TbsSkinGroupBox;
    bsSkinStdLabel13: TbsSkinStdLabel;
    tsEscSBImagem: TbsSkinFileEdit;
    tsEscSBImagemInfo: TbsSkinEdit;
    GridPanel16: TGridPanel;
    Panel11: TPanel;
    bsSkinStdLabel39: TbsSkinStdLabel;
    cbEscsbPosicaoFundo: TbsSkinComboBoxEx;
    Panel12: TPanel;
    bsSkinStdLabel43: TbsSkinStdLabel;
    csEscsbCorFundo: TbsSkinColorButton;
    bsSkinGroupBox18: TbsSkinGroupBox;
    bsSkinStdLabel64: TbsSkinStdLabel;
    tsCronoImagem: TbsSkinFileEdit;
    tsCronoImagemInfo: TbsSkinEdit;
    GridPanel30: TGridPanel;
    Panel13: TPanel;
    bsSkinStdLabel65: TbsSkinStdLabel;
    cbCronoPosicaoFundo: TbsSkinComboBoxEx;
    Panel14: TPanel;
    bsSkinStdLabel111: TbsSkinStdLabel;
    csCronoCorFundo: TbsSkinColorButton;
    bsSkinGroupBox19: TbsSkinGroupBox;
    bsSkinStdLabel112: TbsSkinStdLabel;
    tsTxtPainelDImagem: TbsSkinFileEdit;
    tsTxtPainelDImagemInfo: TbsSkinEdit;
    GridPanel40: TGridPanel;
    Panel16: TPanel;
    bsSkinStdLabel113: TbsSkinStdLabel;
    cbTxtPainelDPosicaoFundo: TbsSkinComboBoxEx;
    Panel17: TPanel;
    bsSkinStdLabel114: TbsSkinStdLabel;
    csPainelDCorFundo: TbsSkinColorButton;
    bsSkinGroupBox20: TbsSkinGroupBox;
    bsSkinStdLabel115: TbsSkinStdLabel;
    tsRelogioImagem: TbsSkinFileEdit;
    tsRelogioImagemInfo: TbsSkinEdit;
    GridPanel41: TGridPanel;
    Panel18: TPanel;
    bsSkinStdLabel116: TbsSkinStdLabel;
    cbRelogioPosicaoFundo: TbsSkinComboBoxEx;
    Panel19: TPanel;
    bsSkinStdLabel117: TbsSkinStdLabel;
    csRelogioCorFundo: TbsSkinColorButton;
    bsSkinGroupBox21: TbsSkinGroupBox;
    bsSkinStdLabel118: TbsSkinStdLabel;
    fcRelogioFonte: TbsSkinFontComboBox;
    GridPanel42: TGridPanel;
    Panel20: TPanel;
    bsSkinStdLabel119: TbsSkinStdLabel;
    seRelogioTamanho: TbsSkinSpinEdit;
    Panel21: TPanel;
    bsSkinStdLabel120: TbsSkinStdLabel;
    csRelogioCor: TbsSkinColorButton;
    bsSkinGroupBox16: TbsSkinGroupBox;
    bsSkinStdLabel21: TbsSkinStdLabel;
    fcPainelDFonte: TbsSkinFontComboBox;
    GridPanel43: TGridPanel;
    Panel22: TPanel;
    bsSkinStdLabel22: TbsSkinStdLabel;
    sePainelDTamanho: TbsSkinSpinEdit;
    Panel23: TPanel;
    bsSkinStdLabel27: TbsSkinStdLabel;
    csPainelDCor: TbsSkinColorButton;
    bsSkinGroupBox14: TbsSkinGroupBox;
    bsSkinStdLabel32: TbsSkinStdLabel;
    fcCronoFonte: TbsSkinFontComboBox;
    GridPanel45: TGridPanel;
    Panel24: TPanel;
    bsSkinStdLabel34: TbsSkinStdLabel;
    seCronoTamanho: TbsSkinSpinEdit;
    Panel25: TPanel;
    bsSkinStdLabel36: TbsSkinStdLabel;
    csCronoCor: TbsSkinColorButton;
    bsSkinGroupBox12: TbsSkinGroupBox;
    bsSkinStdLabel44: TbsSkinStdLabel;
    GridPanel52: TGridPanel;
    Panel26: TPanel;
    bsSkinStdLabel45: TbsSkinStdLabel;
    seEscsbTamanho2: TbsSkinSpinEdit;
    Panel27: TPanel;
    bsSkinStdLabel46: TbsSkinStdLabel;
    csEscsbCor2: TbsSkinColorButton;
    bsSkinStdLabel47: TbsSkinStdLabel;
    bsSkinStdLabel49: TbsSkinStdLabel;
    GridPanel53: TGridPanel;
    Panel28: TPanel;
    bsSkinStdLabel50: TbsSkinStdLabel;
    seEscsbTamanho: TbsSkinSpinEdit;
    Panel29: TPanel;
    bsSkinStdLabel51: TbsSkinStdLabel;
    csEscsbCor: TbsSkinColorButton;
    bsSkinSpeedButton5: TbsSkinSpeedButton;
    tsItensAgendados: TbsSkinTabSheet;
    bsSkinExPanel4: TbsSkinExPanel;
    pnlItensAgendados: TbsSkinExPanel;
    dbctrlCategoriasItensAgendados: TDBCtrlGrid;
    Panel30: TPanel;
    Panel31: TPanel;
    bsItensAgendados: TbsRibbonPage;
    bsRibbonGroup72: TbsRibbonGroup;
    btAddCategoriaAgendados: TbsSkinSpeedButton;
    bsRibbonGroup73: TbsRibbonGroup;
    bsSkinSpeedButton8: TbsSkinSpeedButton;
    cbRemoveItensAgendados: TbsSkinCheckBox;
    bsRibbonDivider26: TbsRibbonDivider;
    GridPanel9: TGridPanel;
    bsSkinDBText5: TbsSkinDBText;
    bsPngImageView13: TbsPngImageView;
    Panel34: TPanel;
    dbctrlItensAgendados: TDBCtrlGrid;
    Panel32: TPanel;
    GridPanel11: TGridPanel;
    bsSkinDBText6: TbsSkinDBText;
    bsPngImageView11: TbsPngImageView;
    bsSkinDBText7: TbsSkinDBText;
    Panel33: TPanel;
    Panel35: TPanel;
    bsSkinDBText8: TbsSkinDBText;
    bsRibbonDivider28: TbsRibbonDivider;
    Panel36: TPanel;
    MonthCalendar1: TMonthCalendar;
    bsSkinStdLabel52: TbsSkinStdLabel;
    txtCategoria: TEdit;
    bsSkinPanel68: TbsSkinPanel;
    bsSkinButton37: TbsSkinButton;
    bsSkinButton39: TbsSkinButton;
    bsSkinPanel71: TbsSkinPanel;
    bsSkinButton40: TbsSkinButton;
    bsSkinButton41: TbsSkinButton;
    cbAnotacoesLiturgia: TbsSkinCheckBox;
    pnlAnotacoesLiturgia: TbsSkinExPanel;
    RichEdit1: TbsSkinRichEdit;
    bsSkinScrollBar5: TbsSkinScrollBar;
    bsPopupExpand: TbsSkinPopupMenu;
    mmPopMonitor1: TMenuItem;
    bsRibbonGroup70: TbsRibbonGroup;
    GridPanel59: TGridPanel;
    cbFormatoHoraES: TbsSkinComboBox;
    Panel15: TPanel;
    GridPanel60: TGridPanel;
    fcTxtI1: TbsSkinFontComboBox;
    btfsBold1: TbsSkinSpeedButton;
    btfsItalic1: TbsSkinSpeedButton;
    btfsUnderline1: TbsSkinSpeedButton;
    btfsStrikeOut1: TbsSkinSpeedButton;
    GridPanel61: TGridPanel;
    seTxtITamanho1: TbsSkinComboBox;
    bsRibbonDivider55: TbsRibbonDivider;
    cbColorTxtI1: TbsSkinColorButton;
    cbColorRTxtI1: TbsSkinColorButton;
    bsSkinSpeedButton34: TbsSkinSpeedButton;
    bsRibbonDivider57: TbsRibbonDivider;
    bsSkinSpeedButton47: TbsSkinSpeedButton;
    bsSkinScrollBar6: TbsSkinScrollBar;
    GridPanel66: TGridPanel;
    bttaLeftJustify1: TbsSkinSpeedButton;
    bttaRightJustify1: TbsSkinSpeedButton;
    bttaCenter1: TbsSkinSpeedButton;
    bsSkinTabSheet8: TbsSkinTabSheet;
    bsSkinPanel72: TbsSkinPanel;
    bsSkinButton43: TbsSkinButton;
    GridPanel68: TGridPanel;
    Label3: TLabel;
    Label1: TLabel;
    lbHlpArquivos: TListBox;
    lbHlpImagens: TListBox;
    lblStatusHlp: TLabel;
    Label4: TLabel;
    lbHlpFalta: TListBox;
    lbHlpTemp: TMemo;
    bsSkinStatusBar1: TbsSkinStatusBar;
    spVersao: TbsSkinStatusPanel;
    spRelogio: TbsSkinStatusPanel;
    spData: TbsSkinStatusPanel;
    spNomePC: TbsSkinStatusPanel;
    bsPngImageView12: TbsPngImageView;
    bsPngImageView5: TbsPngImageView;
    bsPngImageView14: TbsPngImageView;
    bsPngImageView15: TbsPngImageView;
    bsPngImageView16: TbsPngImageView;
    bsPngImageView17: TbsPngImageView;
    bsPngImageView18: TbsPngImageView;
    lit_modItem_icomus5: TbsPngImageView;
    gpLiturgiaDes: TGridPanel;
    lbLiturgia: TListBox;
    lbLiturgiaPos: TListBox;
    mmBD: TMemo;
    btExecSQL: TbsSkinButton;
    GridPanel71: TGridPanel;
    Label5: TLabel;
    Label6: TLabel;
    GridPanel72: TGridPanel;
    Label7: TLabel;
    Label8: TLabel;
    vlSorteioNM: TValueListEditor;
    vlSorteadosNM: TValueListEditor;
    vlSorteio: TValueListEditor;
    vlSorteados: TValueListEditor;
    stHinos: TbsSkinStatusBar;
    stHinos0: TbsSkinStatusPanel;
    stHinos1: TbsSkinStatusPanel;
    pnlStatusBuscaMusicas: TbsSkinStatusBar;
    pnlStatusBuscaMusicas0: TbsSkinStatusPanel;
    pnlStatusBuscaMusicas1: TbsSkinStatusPanel;
    miOpcExportar2: TMenuItem;
    bsRibbonGroup75: TbsRibbonGroup;
    cbEscSBZerarTempo: TbsSkinCheckBox;
    cbEscSBRelogioFunc: TbsSkinCheckBox;
    bsRibbonGroup76: TbsRibbonGroup;
    GridPanel73: TGridPanel;
    bsSkinStdLabel73: TbsSkinStdLabel;
    cbFormatoTempoCrono: TbsSkinComboBox;
    cbFormatoTempoES: TbsSkinComboBox;
    bsSkinStdLabel131: TbsSkinStdLabel;
    bsSkinStdLabel132: TbsSkinStdLabel;
    bsSkinPanel26: TbsSkinPanel;
    bsRibbonDivider62: TbsRibbonDivider;
    bsSkinPanel27: TbsSkinPanel;
    bsSkinStdLabel129: TbsSkinStdLabel;
    bsSkinPanel35: TbsSkinPanel;
    bsSkinLinkLabel5: TbsSkinLinkLabel;
    bsPngImageView4: TbsPngImageView;
    bsSkinPanel73: TbsSkinPanel;
    bsSkinLinkLabel6: TbsSkinLinkLabel;
    bsPngImageView19: TbsPngImageView;
    bsSkinPanel74: TbsSkinPanel;
    bsSkinLinkLabel9: TbsSkinLinkLabel;
    bsPngImageView20: TbsPngImageView;
    Panel52: TPanel;
    bsSkinStdLabel133: TbsSkinStdLabel;
    csEscsbCor3: TbsSkinColorButton;
    fcEscsbFonte: TbsSkinFontComboBox;
    pnlFormatBiblia: TbsSkinExPanel;
    bsSkinScrollPanel1: TbsSkinScrollPanel;
    bsSkinDivider1: TbsSkinDivider;
    GridPanel74: TGridPanel;
    bsSkinExPanel7: TbsSkinExPanel;
    bsSkinExPanel8: TbsSkinExPanel;
    bsSkinExPanel5: TbsSkinExPanel;
    DBCtrlGridBibliaLivro: TbsSkinDBCtrlGrid;
    DBCtrlGridBibliaCapitulo: TbsSkinDBCtrlGrid;
    DBCtrlGridBibliaVersiculo: TbsSkinDBCtrlGrid;
    bsSkinStdLabel137: TbsSkinStdLabel;
    bsSkinStdLabel136: TbsSkinStdLabel;
    bsSkinStdLabel138: TbsSkinStdLabel;
    busBibliaVersiculo: TbsSkinEdit;
    bsRibbonGroup77: TbsRibbonGroup;
    pnlBibliaHistorico: TbsSkinExPanel;
    DBCtrlGridBibliaHistorico: TbsSkinDBCtrlGrid;
    GridPanel70: TGridPanel;
    bsSkinButton20: TbsSkinButton;
    bsSkinPanel4: TbsSkinPanel;
    pnlBiblia: TPanel;
    imgBiblia: TImage;
    lmdBibliaTxt: TLabel;
    lmdBibliaInfo: TLabel;
    bsSkinGroupBox15: TbsSkinGroupBox;
    bsSkinStdLabel7: TbsSkinStdLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinStdLabel9: TbsSkinStdLabel;
    GridPanel76: TGridPanel;
    Panel56: TPanel;
    bsSkinStdLabel140: TbsSkinStdLabel;
    seBibliaTamanho2: TbsSkinSpinEdit;
    Panel57: TPanel;
    bsSkinStdLabel141: TbsSkinStdLabel;
    csBibliaCor2: TbsSkinColorButton;
    fcBibliaFonte: TbsSkinFontComboBox;
    GridPanel77: TGridPanel;
    Panel58: TPanel;
    bsSkinStdLabel142: TbsSkinStdLabel;
    seBibliaTamanho: TbsSkinSpinEdit;
    Panel59: TPanel;
    bsSkinStdLabel143: TbsSkinStdLabel;
    csBibliaCor: TbsSkinColorButton;
    bsSkinGroupBox3: TbsSkinGroupBox;
    bsSkinStdLabel10: TbsSkinStdLabel;
    tsBibliaImagem: TbsSkinFileEdit;
    tsBibliaImagemInfo: TbsSkinEdit;
    GridPanel5: TGridPanel;
    Panel53: TPanel;
    bsSkinStdLabel11: TbsSkinStdLabel;
    cbBibliaPosicaoFundo: TbsSkinComboBoxEx;
    Panel54: TPanel;
    bsSkinStdLabel139: TbsSkinStdLabel;
    csBibliaCorFundo: TbsSkinColorButton;
    bsRibbonGroup78: TbsRibbonGroup;
    btBibVersAnt: TbsSkinSpeedButton;
    btBibVersSeg: TbsSkinSpeedButton;
    bsRibbonGroup79: TbsRibbonGroup;
    bsSkinExPanel9: TbsSkinExPanel;
    GridPanel12: TGridPanel;
    bsSkinStdLabel20: TbsSkinStdLabel;
    btBibLocaliza: TbsSkinButton;
    txtBibLocaliza: TbsSkinEdit;
    DBCtrlGridBibliaBusca: TbsSkinDBCtrlGrid;
    pnlBibliaBusca: TPanel;
    imgBibliaBusca: TImage;
    lmdBibliaBuscaTxt: TLabel;
    lmdBibliaBuscaInfo: TLabel;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinStdLabel23: TbsSkinStdLabel;
    bsSkinStdLabel144: TbsSkinStdLabel;
    bsSkinStdLabel145: TbsSkinStdLabel;
    GridPanel31: TGridPanel;
    Panel55: TPanel;
    bsSkinStdLabel146: TbsSkinStdLabel;
    seBibliabTamanho2: TbsSkinSpinEdit;
    Panel60: TPanel;
    bsSkinStdLabel147: TbsSkinStdLabel;
    csBibliabCor2: TbsSkinColorButton;
    fcBibliabFonte: TbsSkinFontComboBox;
    GridPanel32: TGridPanel;
    Panel61: TPanel;
    bsSkinStdLabel148: TbsSkinStdLabel;
    seBibliabTamanho: TbsSkinSpinEdit;
    Panel62: TPanel;
    bsSkinStdLabel149: TbsSkinStdLabel;
    csBibliabCor: TbsSkinColorButton;
    bsSkinGroupBox5: TbsSkinGroupBox;
    bsSkinStdLabel150: TbsSkinStdLabel;
    tsBibliabImagem: TbsSkinFileEdit;
    tsBibliabImagemInfo: TbsSkinEdit;
    GridPanel8: TGridPanel;
    Panel63: TPanel;
    bsSkinStdLabel151: TbsSkinStdLabel;
    cbBibliabPosicaoFundo: TbsSkinComboBoxEx;
    Panel64: TPanel;
    bsSkinStdLabel152: TbsSkinStdLabel;
    csBibliabCorFundo: TbsSkinColorButton;
    bsRibbonGroup80: TbsRibbonGroup;
    btBibBusVersAnt: TbsSkinSpeedButton;
    btBibBusVersSeg: TbsSkinSpeedButton;
    bsSkinPanel80: TbsSkinPanel;
    bsSkinStdLabel153: TbsSkinStdLabel;
    bsSkinPanel81: TbsSkinPanel;
    bsRibbonDivider64: TbsRibbonDivider;
    bsSkinPanel82: TbsSkinPanel;
    bsSkinLinkLabel18: TbsSkinLinkLabel;
    bsPngImageView24: TbsPngImageView;
    bsSkinPanel83: TbsSkinPanel;
    bsSkinLinkLabel19: TbsSkinLinkLabel;
    bsPngImageView25: TbsPngImageView;
    bsSkinSpeedButton18: TbsSkinSpeedButton;
    bsRibbonGroup81: TbsRibbonGroup;
    GridPanel6: TGridPanel;
    btVidOnlPExcluir: TbsSkinSpeedButton;
    btVidOnlPCopiarLink: TbsSkinSpeedButton;
    btVidOnlPAbrirNaveg: TbsSkinSpeedButton;
    btVidOnlPExec: TbsSkinSpeedButton;
    bsRibbonDivider65: TbsRibbonDivider;
    ampAtivDesAlbum: TbsAppMenuPage;
    bsSkinPanel84: TbsSkinPanel;
    bsSkinStdLabel154: TbsSkinStdLabel;
    bsSkinPanel63: TbsSkinPanel;
    bsSkinPanel85: TbsSkinPanel;
    bsSkinStdLabel91: TbsSkinStdLabel;
    GridPanel7: TGridPanel;
    Panel65: TPanel;
    Panel66: TPanel;
    bsSkinSpeedButton17: TbsSkinSpeedButton;
    bsSkinSpeedButton21: TbsSkinSpeedButton;
    Panel67: TPanel;
    gridAlbAt: TbsSkinDBGrid;
    bsSkinScrollBar18: TbsSkinScrollBar;
    Panel68: TPanel;
    gridAlbInat: TbsSkinDBGrid;
    bsSkinScrollBar19: TbsSkinScrollBar;
    bsSkinPanel75: TbsSkinPanel;
    bsSkinStdLabel134: TbsSkinStdLabel;
    bsSkinPanel76: TbsSkinPanel;
    bsSkinStdLabel135: TbsSkinStdLabel;
    bsSkinPanel79: TbsSkinPanel;
    bsSkinLinkLabel17: TbsSkinLinkLabel;
    bsPngImageView23: TbsPngImageView;
    bsSkinPanel77: TbsSkinPanel;
    bsSkinLinkLabel15: TbsSkinLinkLabel;
    bsPngImageView21: TbsPngImageView;
    bsSkinPanel78: TbsSkinPanel;
    bsSkinLinkLabel16: TbsSkinLinkLabel;
    bsPngImageView22: TbsPngImageView;
    imagemFundoInfo: TbsSkinEdit;
    audioFundoInfo: TbsSkinEdit;
    bsSkinTabSheet9: TbsSkinTabSheet;
    bsSkinPanel86: TbsSkinPanel;
    Label2: TLabel;
    bsSkinButton21: TbsSkinButton;
    bsSkinButton22: TbsSkinButton;
    lvArquivos: TbsSkinListView;
    gProgresso: TbsSkinGauge;
    bsSkinButton23: TbsSkinButton;
    bsSkinButton27: TbsSkinButton;
    bsSkinPanel59: TbsSkinPanel;
    bsSkinStdLabel56: TbsSkinStdLabel;
    bsRibbonDivider51: TbsRibbonDivider;
    bsSkinPanel88: TbsSkinPanel;
    bsSkinStdLabel66: TbsSkinStdLabel;
    bsSkinStdLabel68: TbsSkinStdLabel;
    bsRibbonDivider67: TbsRibbonDivider;
    bsRibbonDivider68: TbsRibbonDivider;
    bsSkinStdLabel102: TbsSkinStdLabel;
    bsRibbonDivider69: TbsRibbonDivider;
    corTextoMusica: TbsSkinColorButton;
    corTextoAuxMusica: TbsSkinColorButton;
    ckMusicaFundoTransparente: TbsSkinCheckBox;
    seTamanhoTexto: TbsSkinSpinEdit;
    bsSkinStdLabel106: TbsSkinStdLabel;
    seTamanhoTextoAux: TbsSkinSpinEdit;
    bsSkinStdLabel61: TbsSkinStdLabel;
    bsRibbonDivider54: TbsRibbonDivider;
    seTamanhoTitulo: TbsSkinSpinEdit;
    corTituloMusica: TbsSkinColorButton;
    bsSkinPanel89: TbsSkinPanel;
    bsSkinStdLabel121: TbsSkinStdLabel;
    bsSkinPanel90: TbsSkinPanel;
    bsRibbonDivider70: TbsRibbonDivider;
    bsSkinPanel91: TbsSkinPanel;
    bsSkinLinkLabel20: TbsSkinLinkLabel;
    bsPngImageView26: TbsPngImageView;
    bsSkinPanel92: TbsSkinPanel;
    bsSkinLinkLabel21: TbsSkinLinkLabel;
    bsPngImageView27: TbsPngImageView;
    bsSkinPanel93: TbsSkinPanel;
    bsSkinLinkLabel22: TbsSkinLinkLabel;
    bsPngImageView28: TbsPngImageView;
    bsSkinStdLabel122: TbsSkinStdLabel;
    bsRibbonDivider71: TbsRibbonDivider;
    corTextoRepetido: TbsSkinColorButton;
    bsSkinTabSheet10: TbsSkinTabSheet;
    lbTempos: TListBox;
    Panel37: TPanel;
    Label9: TbsSkinLabel;
    idMusica: TbsSkinEdit;
    Button1: TbsSkinButton;
    dbGrid: TbsSkinDBGrid;
    bsSkinPanel44: TbsSkinPanel;
    bsSkinStdLabel93: TbsSkinStdLabel;
    bsSkinPanel45: TbsSkinPanel;
    bsSkinStdLabel94: TbsSkinStdLabel;
    bsSkinPanel47: TbsSkinPanel;
    bsSkinLinkLabel14: TbsSkinLinkLabel;
    Image33: TbsPngImageView;
    bsSkinTabSheet11: TbsSkinTabSheet;
    cboard: TListBox;
    bsRibbonDivider72: TbsRibbonDivider;
    btPersoClipBoard: TbsSkinSpeedButton;
    bsSkinPanel51: TbsSkinPanel;
    ckFadeForm: TbsSkinCheckBox;
    btLitClipBoard: TbsSkinSpeedButton;
    cbBloqItens: TbsSkinCheckBox;
    bsSkinPanel94: TbsSkinPanel;
    bsSkinStdLabel124: TbsSkinStdLabel;
    cbLayout: TbsSkinComboBox;
    bsSkinPanel95: TbsSkinPanel;
    bsSkinStdLabel78: TbsSkinStdLabel;
    bsSkinPanel96: TbsSkinPanel;
    bsSkinStdLabel125: TbsSkinStdLabel;
    bsSkinPanel98: TbsSkinPanel;
    bsRibbonDivider8: TbsRibbonDivider;
    bsSkinPanel97: TbsSkinPanel;
    bsRibbonDivider73: TbsRibbonDivider;
    bsSkinPanel99: TbsSkinPanel;
    bsRibbonDivider48: TbsRibbonDivider;
    bsSkinPanel100: TbsSkinPanel;
    bsRibbonDivider31: TbsRibbonDivider;
    bsSkinPanel101: TbsSkinPanel;
    bsRibbonDivider74: TbsRibbonDivider;
    bsSkinPanel102: TbsSkinPanel;
    bsSkinStdLabel123: TbsSkinStdLabel;
    bsSkinPanel103: TbsSkinPanel;
    bsSkinStdLabel67: TbsSkinStdLabel;
    bsSkinPanel104: TbsSkinPanel;
    bsSkinStdLabel58: TbsSkinStdLabel;
    bsSkinPanel105: TbsSkinPanel;
    bsRibbonDivider35: TbsRibbonDivider;
    bsSkinPanel106: TbsSkinPanel;
    bsRibbonDivider36: TbsRibbonDivider;
    bsSkinPanel107: TbsSkinPanel;
    bsRibbonDivider41: TbsRibbonDivider;
    bsSkinPanel108: TbsSkinPanel;
    bsRibbonDivider29: TbsRibbonDivider;
    bsSkinPanel109: TbsSkinPanel;
    bsRibbonDivider34: TbsRibbonDivider;
    bsSkinPanel110: TbsSkinPanel;
    bsRibbonDivider2: TbsRibbonDivider;
    bsSkinPanel111: TbsSkinPanel;
    bsRibbonDivider32: TbsRibbonDivider;
    bsSkinPanel112: TbsSkinPanel;
    bsRibbonDivider37: TbsRibbonDivider;
    bsSkinPanel113: TbsSkinPanel;
    bsRibbonDivider49: TbsRibbonDivider;
    bsSkinPanel114: TbsSkinPanel;
    bsRibbonDivider39: TbsRibbonDivider;
    bsSkinPanel115: TbsSkinPanel;
    bsRibbonDivider46: TbsRibbonDivider;
    bsSkinPanel116: TbsSkinPanel;
    bsSkinStdLabel84: TbsSkinStdLabel;
    bsSkinPanel117: TbsSkinPanel;
    bsSkinStdLabel81: TbsSkinStdLabel;
    bsSkinPanel118: TbsSkinPanel;
    bsSkinStdLabel126: TbsSkinStdLabel;
    bsSkinPanel119: TbsSkinPanel;
    bsSkinStdLabel127: TbsSkinStdLabel;
    bsSkinPanel120: TbsSkinPanel;
    bsSkinStdLabel128: TbsSkinStdLabel;
    bsSkinPanel121: TbsSkinPanel;
    bsSkinStdLabel130: TbsSkinStdLabel;
    bsSkinPanel122: TbsSkinPanel;
    bsSkinStdLabel155: TbsSkinStdLabel;
    bsSkinPanel124: TbsSkinPanel;
    bsSkinStdLabel74: TbsSkinStdLabel;
    bsSkinPanel70: TbsSkinPanel;
    bsSkinButton38: TbsSkinButton;
    bsSkinPanel127: TbsSkinPanel;
    bsSkinStdLabel35: TbsSkinStdLabel;
    bsSkinPanel130: TbsSkinPanel;
    bsRibbonDivider38: TbsRibbonDivider;
    bsSkinPanel126: TbsSkinPanel;
    bsSkinStdLabel54: TbsSkinStdLabel;
    bsSkinPanel69: TbsSkinPanel;
    bsSkinButton36: TbsSkinButton;
    bsSkinPanel128: TbsSkinPanel;
    bsSkinStdLabel90: TbsSkinStdLabel;
    bsSkinPanel123: TbsSkinPanel;
    bsRibbonDivider27: TbsRibbonDivider;
    bsSkinPanel125: TbsSkinPanel;
    bsSkinPanel129: TbsSkinPanel;
    bsSkinPanel131: TbsSkinPanel;
    bsSkinPanel132: TbsSkinPanel;
    bsSkinPanel133: TbsSkinPanel;
    bsRibbonDivider52: TbsRibbonDivider;
    bsSkinPanel134: TbsSkinPanel;
    bsSkinTabSheet12: TbsSkinTabSheet;
    layoutValue: TValueListEditor;
    bsSkinPanel135: TbsSkinPanel;
    bsSkinStdLabel53: TbsSkinStdLabel;
    bsSkinPanel136: TbsSkinPanel;
    bsRibbonDivider56: TbsRibbonDivider;
    bsSkinPanel138: TbsSkinPanel;
    bsSkinLinkLabel24: TbsSkinLinkLabel;
    bsPngImageView30: TbsPngImageView;
    bsSkinPanel139: TbsSkinPanel;
    bsRibbonDivider59: TbsRibbonDivider;
    bsSkinPanel140: TbsSkinPanel;
    bsSkinStdLabel79: TbsSkinStdLabel;
    bsSkinPanel141: TbsSkinPanel;
    bsSkinLinkLabel25: TbsSkinLinkLabel;
    bsPngImageView31: TbsPngImageView;
    bsFormatSlImgPerso: TbsSkinPanel;
    ckSlideImgFormatPerso: TbsSkinCheckBox;
    bsFormatSlideImgPerso: TbsSkinPanel;
    bsSkinPanel87: TbsSkinPanel;
    bsSkinStdLabel105: TbsSkinStdLabel;
    bsRibbonDivider10: TbsRibbonDivider;
    corFundoMusica: TbsSkinColorButton;
    bsSkinStdLabel55: TbsSkinStdLabel;
    imgFundoMusica: TbsSkinFileEdit;
    bsSkinStdLabel62: TbsSkinStdLabel;
    bsRibbonDivider66: TbsRibbonDivider;
    txtImgFundoMusicaInfo: TbsSkinEdit;
    posicaoFundo: TbsSkinComboBoxEx;
    bsSkinButton2: TbsSkinButton;
    bsRibbonGroup9: TbsRibbonGroup;
    bsSkinSpeedButton2: TbsSkinSpeedButton;
    bsRibbonDivider25: TbsRibbonDivider;
    bsSkinSpeedButton16: TbsSkinSpeedButton;
    bsSkinPanel142: TbsSkinPanel;
    bsRibbonDivider63: TbsRibbonDivider;
    bsSkinPanel143: TbsSkinPanel;
    bsSkinStdLabel87: TbsSkinStdLabel;
    bsSkinPanel144: TbsSkinPanel;
    bsSkinLinkLabel26: TbsSkinLinkLabel;
    bsPngImageView32: TbsPngImageView;
    bsSkinPanel145: TbsSkinPanel;
    bsSkinLinkLabel27: TbsSkinLinkLabel;
    bsPngImageView33: TbsPngImageView;
    stColetPerso_0: TbsSkinStatusPanel;
    stColetPerso_1: TbsSkinStatusPanel;
    stVideosOnPerso_1: TbsSkinStatusPanel;
    DBCtrlGridBibliaLivro_pnl: TPanel;
    txtdbBibliaLivro: TbsSkinDBText;
    txtdbBibliaLivroSg: TbsSkinDBText;
    DBCtrlGridBibliaCapitulo_pnl: TPanel;
    txtdbBibliaCapitulo: TbsSkinDBText;
    DBCtrlGridBibliaVersiculo_pnl: TPanel;
    txtdbBibliaVersiculoTxt: TbsSkinDBText;
    txtdbBibliaVersiculo: TbsSkinDBText;
    DBCtrlGridBibliaHistorico_pnl: TPanel;
    txtBibliaHistoricoPassagem: TbsSkinDBText;
    txtBibliaHistorico: TbsSkinDBText;
    DBCtrlGridBibliaBusca_pnl: TPanel;
    txtBibliaBusca: TbsSkinDBText;
    txtBibliaBuscaPassagem: TbsSkinDBText;
    txtdbBibliaLivroNm: TbsSkinDBText;
    bsSkinPanel146: TbsSkinPanel;
    bsSkinStdLabel95: TbsSkinStdLabel;
    bsSkinPanel147: TbsSkinPanel;
    bsRibbonDivider47: TbsRibbonDivider;
    bsSkinPanel148: TbsSkinPanel;
    bsRibbonDivider53: TbsRibbonDivider;
    bsSkinPanel149: TbsSkinPanel;
    bsRibbonDivider58: TbsRibbonDivider;
    bsSkinPanel150: TbsSkinPanel;
    bsSkinStdLabel88: TbsSkinStdLabel;
    bsSkinPanel151: TbsSkinPanel;
    bsSkinStdLabel156: TbsSkinStdLabel;
    bsSkinPanel152: TbsSkinPanel;
    bsSkinLinkLabel28: TbsSkinLinkLabel;
    bsPngImageView34: TbsPngImageView;
    bsSkinPanel153: TbsSkinPanel;
    bsSkinLinkLabel29: TbsSkinLinkLabel;
    bsPngImageView35: TbsPngImageView;
    bsSkinPanel154: TbsSkinPanel;
    bsSkinLinkLabel30: TbsSkinLinkLabel;
    bsPngImageView36: TbsPngImageView;
    bsSkinPanel155: TbsSkinPanel;
    bsSkinLinkLabel31: TbsSkinLinkLabel;
    bsPngImageView37: TbsPngImageView;
    bsSkinPanel156: TbsSkinPanel;
    bsSkinLinkLabel32: TbsSkinLinkLabel;
    bsPngImageView38: TbsPngImageView;
    bsSkinPanel157: TbsSkinPanel;
    bsSkinLinkLabel33: TbsSkinLinkLabel;
    bsPngImageView39: TbsPngImageView;
    pnlPlayer: TbsSkinPanel;
    MediaPlayer1: TMediaPlayer;
    lblPlayer: TbsSkinLabel;
    btplPlay: TbsSkinSpeedButton;
    btplPause: TbsSkinSpeedButton;
    bsRibbonDivider60: TbsRibbonDivider;
    btplFechar: TbsSkinSpeedButton;
    pbPlayer: TbsSkinGauge;
    bsSkinPanel158: TbsSkinPanel;
    bsRibbonDivider61: TbsRibbonDivider;
    bsSkinPanel159: TbsSkinPanel;
    bsSkinStdLabel157: TbsSkinStdLabel;
    bsSkinPanel160: TbsSkinPanel;
    bsSkinStdLabel158: TbsSkinStdLabel;
    sbPlayerAreaExtendida: TbsSkinComboBox;
    bsSkinPanel161: TbsSkinPanel;
    ckPlayerTelaCheia: TbsSkinCheckBox;
    bsSkinPanel162: TbsSkinPanel;
    ckPlayerVideo: TbsSkinCheckBox;
    bsSkinPanel163: TbsSkinPanel;
    ckPlayerAudio: TbsSkinCheckBox;
    bsSkinPanel164: TbsSkinPanel;
    bsSkinStdLabel159: TbsSkinStdLabel;
    bsRibbonDivider75: TbsRibbonDivider;
    bsRibbonGroup12: TbsRibbonGroup;
    btHinoSlideMusica: TbsSkinSpeedButton;
    GridPanel69: TGridPanel;
    btHinoSlideMusicaPB: TbsSkinSpeedButton;
    btHinoSlideMusicaSA: TbsSkinSpeedButton;
    bsRibbonGroup74: TbsRibbonGroup;
    GridPanel87: TGridPanel;
    bsSkinSpeedButton13: TbsSkinSpeedButton;
    bsSkinSpeedButton3: TbsSkinSpeedButton;
    bsSkinSpeedButton12: TbsSkinSpeedButton;
    bsRibbonGroup82: TbsRibbonGroup;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinDBText2: TbsSkinDBText;
    bsRibbonDivider4: TbsRibbonDivider;
    btMusicaLetra: TbsSkinSpeedButton;
    bsRibbonGroup83: TbsRibbonGroup;
    btMusicaSlideMusica: TbsSkinSpeedButton;
    GridPanel33: TGridPanel;
    btMusicaSlideMusicaPB: TbsSkinSpeedButton;
    btMusicaSlideMusicaSA: TbsSkinSpeedButton;
    bsRibbonGroup84: TbsRibbonGroup;
    GridPanel34: TGridPanel;
    btMusicaAudioMusicaPB: TbsSkinSpeedButton;
    btMusicaAudioMusica: TbsSkinSpeedButton;
    bsSkinSpeedButton6: TbsSkinSpeedButton;
    bsRibbonDivider3: TbsRibbonDivider;
    dblBibVersao: TbsSkinDBLookupComboBox;
    bsSkinStdLabel160: TbsSkinStdLabel;
    bsSkinStdLabel161: TbsSkinStdLabel;
    dblBibVersao2: TbsSkinDBLookupComboBox;
    busBibliaLivro: TbsSkinComboBox;
    busBibliaCapitulo: TbsSkinComboBox;
    bsSkinDBGrid1: TbsSkinDBGrid;
    bsSkinScrollBar4: TbsSkinScrollBar;
    bsSkinScrollBar23: TbsSkinScrollBar;
    bsRibbonGroup6: TbsRibbonGroup;
    opcCronoCTempo: TbsSkinRadioGroup;
    GridPanel35: TGridPanel;
    meESHora: TbsSkinMaskEdit;
    meESDuracao: TbsSkinSpinEdit;
    bsSkinPanel165: TbsSkinPanel;
    bsSkinStdLabel40: TbsSkinStdLabel;
    lblCronoCFim: TbsSkinStdLabel;
    bsRibbonGroup85: TbsRibbonGroup;
    GridPanel24: TGridPanel;
    bsAddT1: TbsSkinSpeedButton;
    bsAddT5: TbsSkinSpeedButton;
    bsAddT10: TbsSkinSpeedButton;
    bsAddTm1: TbsSkinSpeedButton;
    bsAddTm5: TbsSkinSpeedButton;
    bsAddTm10: TbsSkinSpeedButton;
    bsSkinStdLabel162: TbsSkinStdLabel;
    paramexec: TValueListEditor;
    Label10: TbsSkinLabel;
    idAlbum: TbsSkinEdit;
    Label11: TbsSkinLabel;
    idFaixa: TbsSkinEdit;
    bsSkinPanel166: TbsSkinPanel;
    ckMesmaJanela: TbsSkinCheckBox;
    bsSkinPanel167: TbsSkinPanel;
    bsSkinStdLabel76: TbsSkinStdLabel;
    sbAlinhMusica: TbsSkinComboBox;
    bsSkinStdLabel163: TbsSkinStdLabel;
    cbRelogioAlinhamento: TbsSkinComboBox;
    bsSkinStdLabel164: TbsSkinStdLabel;
    cbPainelDAlinhamento: TbsSkinComboBox;
    bsSkinStdLabel165: TbsSkinStdLabel;
    cbCronometroAlinhamento: TbsSkinComboBox;
    bsSkinStdLabel166: TbsSkinStdLabel;
    cbSorteioNMAlinhamento: TbsSkinComboBox;
    bsSkinStdLabel167: TbsSkinStdLabel;
    cbSorteioAlinhamento: TbsSkinComboBox;
    bsSkinPanel168: TbsSkinPanel;
    ckMusicaTopo: TbsSkinCheckBox;
    spServer: TbsSkinStatusPanel;
    bsSkinPanel170: TbsSkinPanel;
    bsRibbonDivider76: TbsRibbonDivider;
    bsSkinPanel171: TbsSkinPanel;
    bsSkinStdLabel168: TbsSkinStdLabel;
    bsSkinPanel172: TbsSkinPanel;
    bsSkinLinkLabel34: TbsSkinLinkLabel;
    bsPngImageView40: TbsPngImageView;
    bsSkinPanel173: TbsSkinPanel;
    bsSkinLinkLabel35: TbsSkinLinkLabel;
    bsPngImageView41: TbsPngImageView;
    bsPngImageView42: TbsPngImageView;
    bsPngImageView43: TbsPngImageView;
    bsPngImageView44: TbsPngImageView;
    bsPngImageView45: TbsPngImageView;
    bsPngImageView46: TbsPngImageView;
    bsPngImageView47: TbsPngImageView;
    bsPngImageView48: TbsPngImageView;
    bsPngImageView49: TbsPngImageView;
    bsSkinPanel174: TbsSkinPanel;
    bsRibbonDivider77: TbsRibbonDivider;
    bsSkinPanel175: TbsSkinPanel;
    bsSkinStdLabel169: TbsSkinStdLabel;
    bsPngImageView50: TbsPngImageView;
    bsSkinPanel176: TbsSkinPanel;
    bsSkinLinkLabel36: TbsSkinLinkLabel;
    bsPngImageView51: TbsPngImageView;
    bsSkinPanel177: TbsSkinPanel;
    bsSkinLinkLabel37: TbsSkinLinkLabel;
    bsPngImageView52: TbsPngImageView;
    bsSkinPanel178: TbsSkinPanel;
    bsSkinStdLabel170: TbsSkinStdLabel;
    bsPngImageView53: TbsPngImageView;
    bsSkinPanel179: TbsSkinPanel;
    bsSkinLinkLabel38: TbsSkinLinkLabel;
    bsPngImageView54: TbsPngImageView;
    bsSkinPanel180: TbsSkinPanel;
    bsSkinLinkLabel39: TbsSkinLinkLabel;
    bsPngImageView55: TbsPngImageView;
    bsSkinPanel181: TbsSkinPanel;
    bsRibbonDivider78: TbsRibbonDivider;
    bsSkinPanel182: TbsSkinPanel;
    bsRibbonDivider79: TbsRibbonDivider;
    bsSkinPanel183: TbsSkinPanel;
    bsSkinStdLabel171: TbsSkinStdLabel;
    bsPngImageView56: TbsPngImageView;
    bsSkinPanel184: TbsSkinPanel;
    bsSkinLinkLabel40: TbsSkinLinkLabel;
    bsPngImageView57: TbsPngImageView;
    bsSkinPanel185: TbsSkinPanel;
    bsSkinLinkLabel41: TbsSkinLinkLabel;
    bsPngImageView58: TbsPngImageView;
    bsSkinPanel186: TbsSkinPanel;
    bsSkinStdLabel172: TbsSkinStdLabel;
    bsPngImageView59: TbsPngImageView;
    bsSkinPanel187: TbsSkinPanel;
    bsSkinLinkLabel42: TbsSkinLinkLabel;
    bsPngImageView60: TbsPngImageView;
    bsSkinPanel188: TbsSkinPanel;
    bsSkinLinkLabel43: TbsSkinLinkLabel;
    bsPngImageView61: TbsPngImageView;
    bsSkinPanel189: TbsSkinPanel;
    bsRibbonDivider80: TbsRibbonDivider;
    bsSkinTabSheet13: TbsSkinTabSheet;
    erro_log: TbsSkinMemo;
    Panel38: TPanel;
    Button2: TButton;
    bsSkinPanel137: TbsSkinPanel;
    bsRibbonDivider81: TbsRibbonDivider;
    bsSkinPanel190: TbsSkinPanel;
    bsSkinStdLabel173: TbsSkinStdLabel;
    bsPngImageView29: TbsPngImageView;
    bsSkinPanel191: TbsSkinPanel;
    bsSkinLinkLabel23: TbsSkinLinkLabel;
    bsPngImageView62: TbsPngImageView;
    bsSkinPanel192: TbsSkinPanel;
    bsSkinLinkLabel44: TbsSkinLinkLabel;
    bsPngImageView63: TbsPngImageView;
    bsSkinPanel30: TbsSkinPanel;
    bsSkinButton42: TbsSkinButton;
    sbMusicaOperadorAreaExtendida: TbsSkinComboBox;
    ckFundoTransparente: TbsSkinCheckBox;
    bsFormatSlideImgPerso2: TbsSkinPanel;
    bsRibbonDivider82: TbsRibbonDivider;
    btAbreHinosN: TbsSkinSpeedButton;
    tsHinarioN: TbsSkinTabSheet;
    GridPanel36: TGridPanel;
    txtHinoN: TbsSkinEdit;
    bsSkinStdLabel80: TbsSkinStdLabel;
    rbHinoTipoN: TbsSkinRadioGroup;
    DBGrid1N: TbsSkinDBGrid;
    pnlreHinoN: TbsSkinPanel;
    bsSkinScrollBar26: TbsSkinScrollBar;
    reHinoN: TbsSkinRichEdit;
    stHinosN: TbsSkinStatusBar;
    stHinos0N: TbsSkinStatusPanel;
    stHinos1N: TbsSkinStatusPanel;
    bsSkinScrollBar7N: TbsSkinScrollBar;
    bsHinarioN: TbsRibbonPage;
    bsRibbonGroup32: TbsRibbonGroup;
    bsRibbonDivider83: TbsRibbonDivider;
    bsSkinSpeedButton12N: TbsSkinSpeedButton;
    bsSkinPanel193: TbsSkinPanel;
    bsSkinStdLabel174: TbsSkinStdLabel;
    bsSkinDBText1N: TbsSkinDBText;
    bsRibbonGroup86: TbsRibbonGroup;
    btHinoSlideMusicaN: TbsSkinSpeedButton;
    bsSkinSpeedButton6N: TbsSkinSpeedButton;
    bsRibbonDivider84: TbsRibbonDivider;
    GridPanel37: TGridPanel;
    btHinoSlideMusicaPBN: TbsSkinSpeedButton;
    btHinoSlideMusicaSAN: TbsSkinSpeedButton;
    bsRibbonGroup87: TbsRibbonGroup;
    GridPanel39: TGridPanel;
    bsSkinSpeedButton13N: TbsSkinSpeedButton;
    bsSkinSpeedButton3N: TbsSkinSpeedButton;
    bsRibbonGroup88: TbsRibbonGroup;
    btExportarHinoN: TbsSkinMenuSpeedButton;
    bsRibbonGroup89: TbsRibbonGroup;
    bsSkinSpeedButton23N: TbsSkinSpeedButton;
    bsSkinTabSheet14: TbsSkinTabSheet;
    bsSkinPanel194: TbsSkinPanel;
    bsSkinButton44: TbsSkinButton;
    Memo1: TMemo;
    bsSkinButton45: TbsSkinButton;
    pnlHinario1996Ativo: TPanel;
    pnlHinario1996Inativo: TbsSkinPanel;
    bsSkinStdLabel175: TbsSkinStdLabel;
    bsSkinStdLabel176: TbsSkinStdLabel;
    bsSkinButton46: TbsSkinButton;
    bsSkinStdLabel177: TbsSkinStdLabel;
    ckgColetaneas: TbsSkinCheckGroup;
    bsSkinPanel195: TbsSkinPanel;
    GridPanel54: TGridPanel;
    bsknbtn1: TbsSkinButton;
    bsSkinPanel55: TbsSkinPanel;
    bsRibbonDivider50: TbsRibbonDivider;
    bsSkinPanel196: TbsSkinPanel;
    bsSkinStdLabel178: TbsSkinStdLabel;
    bsSkinPanel197: TbsSkinPanel;
    ctrlMonitores: TbsSkinDBCtrlGrid;
    Panel39: TPanel;
    GridPanel55: TGridPanel;
    bsSkinDBText9: TbsSkinDBText;
    bsSkinDBText10: TbsSkinDBText;
    bsSkinDBText11: TbsSkinDBText;
    bsSkinPanel198: TbsSkinPanel;
    bsRibbonDivider85: TbsRibbonDivider;
    bsSkinPanel199: TbsSkinPanel;
    bsSkinStdLabel179: TbsSkinStdLabel;
    bsPngImageView64: TbsPngImageView;
    bsSkinPanel200: TbsSkinPanel;
    bsSkinLinkLabel45: TbsSkinLinkLabel;
    bsPngImageView65: TbsPngImageView;
    bsSkinPanel201: TbsSkinPanel;
    bsSkinLinkLabel46: TbsSkinLinkLabel;
    bsPngImageView66: TbsPngImageView;
    bsSkinPanel202: TbsSkinPanel;
    bsPngImageView67: TbsPngImageView;
    bsSkinLinkLabel47: TbsSkinLinkLabel;
    bsSkinPanel203: TbsSkinPanel;
    bsPngImageView68: TbsPngImageView;
    bsSkinLinkLabel48: TbsSkinLinkLabel;
    bsSkinPanel204: TbsSkinPanel;
    bsPngImageView69: TbsPngImageView;
    bsSkinLinkLabel49: TbsSkinLinkLabel;
    bsSkinPanel205: TbsSkinPanel;
    bsSkinStdLabel180: TbsSkinStdLabel;
    bsSkinDBText12: TbsSkinDBText;
    bsSkinSpeedButton7: TbsSkinSpeedButton;
    bsSkinPanel206: TbsSkinPanel;
    ckSlideFormatPersoExt: TbsSkinCheckBox;
    ckMusicaRetorno: TbsSkinCheckBox;
    sbMusicaRetornoAreaExtendida: TbsSkinComboBox;
    bsFormatSlRetorno: TbsSkinPanel;
    bsFormatSlideRetorno: TbsSkinPanel;
    bsSkinPanel207: TbsSkinPanel;
    bsSkinStdLabel183: TbsSkinStdLabel;
    seTamanhoTextoRetorno: TbsSkinSpinEdit;
    bsSkinButton47: TbsSkinButton;
    function VersaoExe: String;
    procedure FormCreate(Sender: TObject);
    procedure fExibeColetaneas(Tipo: string; ScrollBox: TbsSkinScrollBox);
    procedure fExibeColetaneasPerso(ScrollBox: TbsSkinScrollBox);
    procedure sbClick(Sender: TObject);
    procedure sbClickPerso(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tsHinarioShow(Sender: TObject);
    procedure txtHinoChange(Sender: TObject);
    procedure corCampoBusca(Query: TFDQuery; Campo: TbsSkinEdit; DBGrid: TbsSkinDBGrid);
    function qtItens(Query: TFDQuery;texto_sing,texto_plu,texto_nenh:string): string;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure txtHinoKeyPress(Sender: TObject; var Key: Char);
    procedure abreLetra(ID: integer; BUSCA: string = '');
    procedure tsJAShow(Sender: TObject);
    procedure tsDiversasShow(Sender: TObject);
    procedure tsBuscaMusicaShow(Sender: TObject);
    procedure txtBuscaChange(Sender: TObject);
    procedure buscaMusicas();
    procedure DBGrid2DblClick(Sender: TObject);
    procedure txtBuscaKeyPress(Sender: TObject; var Key: Char);
    procedure SorteioContador();
    function isFolderEmpty(szPath: string): Boolean;
    function IsNumeric(S: string): boolean;
    function verVersao():Boolean;
    procedure tsSorteioShow(Sender: TObject);
    procedure tsCronometroShow(Sender: TObject);
    procedure tsCronoCultoShow(Sender: TObject);
    procedure txtDecrExit(Sender: TObject);
    function lerParam(Grupo, Param, Valor: string;Arquivo: string = ''; Diretorio:string = ''): string;
    procedure gravaParam(Grupo, Param, Valor: string;Arquivo: string = '');
    procedure gravaParamServer(Grupo, Param, Valor: string);
    procedure apagaParam(Grupo: string; Param: string = '';Arquivo: string = '');
    procedure cbMusicaChange(Sender: TObject);
    procedure selMusica();
    procedure meESHoraChange(Sender: TObject);
    procedure tsBuscaBiblicaShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Link(Sender: TObject);
    procedure tsPersonalizadasShow(Sender: TObject);
    procedure btOuvirClick(Sender: TObject);
    procedure btLigarClick(Sender: TObject);
    procedure btIniciarCronoClick(Sender: TObject);
    procedure btZerarCronoClick(Sender: TObject);
    procedure btAnotTempoClick(Sender: TObject);
    procedure btSortearClick(Sender: TObject);
    procedure Localizar(ValorBusca: string; RichEdit: TbsSkinRichEdit; recolore: boolean);
    procedure formataTexto(RichEdit: TbsSkinRichEdit);
    procedure FormResize(Sender: TObject);
    procedure tsBibliaShow(Sender: TObject);
    function ExtraiTexto(const Str, Str1, Str2: string): string;
    procedure carregaParams();
    function GetComputerNameFunc: string;
    procedure BitmapFileToPNG(const Source, Dest: string);
    procedure LiturgiaCalendarClick(Sender: TObject);
    function verificaURL(url: string; input: TbsSkinEdit; reverso: Boolean = False): string;
    procedure sListView1DblClick(Sender: TObject);
    procedure expandirArea(Sender: TObject);
    procedure copiaDadosTelaExtendida();
    procedure fcOpcFonteChange(Sender: TObject);
    procedure seOpcTamanhoChange(Sender: TObject);
    procedure csOpcCorChange(Sender: TObject);
    procedure btOpcResetClick(Sender: TObject);
    procedure btOpcFileNameEditExit(Sender: TObject);
    function ColorToHtml(DColor: TColor): string;
    function termo_busca(busca: string): string;
    procedure sButton10Click(Sender: TObject);
    procedure sTabSheet15Show(Sender: TObject);
    procedure sTabSheet16Show(Sender: TObject);
    procedure sTabSheet13Show(Sender: TObject);
    procedure sTabSheet18Show(Sender: TObject);
    procedure abrePagina(TabSheet: TbsSkinTabSheet);
    procedure btAbreHinosClick(Sender: TObject);
    procedure mnFechaAbaClick(Sender: TObject);
    procedure mnFechaTodasAbasClick(Sender: TObject);
    procedure confereAbasAbertas();
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure btAbreColJAClick(Sender: TObject);
    procedure PaginaMenuAtiva(page: TbsRibbonPage;tabvinc: TbsSkinTabSheet = nil);
    procedure marcaAbaAberta(TabSheet: TbsSkinTabSheet);
    procedure mnSelecionaAbaClick(Sender: TObject);
    procedure mnAbreFavoritoClick(Sender: TObject);
    procedure btHinoSlideMusicaClick(Sender: TObject);
    procedure bsSkinSpeedButton13Click(Sender: TObject);
    procedure bsSkinSpeedButton12Click(Sender: TObject);
    procedure bsSkinSpeedButton14Click(Sender: TObject);
    procedure PageControl1Close(Sender: TObject; var CanClose: Boolean);
    procedure bsSkinSpeedButton9Click(Sender: TObject);
    procedure ShowTrackMenu(Sender: TObject);
    function RemoveTags(const s: string): string;
    procedure carregaConfiguracoes(pagina: string);
    procedure bsSkinSpeedButton10Click(Sender: TObject);
    procedure bsRibbonGroup19DialogButtonClick(Sender: TObject);
    procedure ckLivrosClickCheck(Sender: TObject);
    procedure ckLivros2ClickCheck(Sender: TObject);
    procedure bsSkinSpeedButton20Click(Sender: TObject);
    procedure txtAbrirColetExit(Sender: TObject);
    procedure txtCapaColetExit(Sender: TObject);
    procedure txtCapaColetEnter(Sender: TObject);
    procedure txtAbrirColetEnter(Sender: TObject);
    procedure btOpcFileNameEditEnter(Sender: TObject);
    procedure Excluir1Click(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure btAddColPersoClick(Sender: TObject);
    procedure btAddColetPersoClick(Sender: TObject);
    procedure btAltColPersoClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure txtAbrirColet2Enter(Sender: TObject);
    procedure txtAbrirColet2Exit(Sender: TObject);
    procedure txtCapaColet2Enter(Sender: TObject);
    procedure txtCapaColet2Exit(Sender: TObject);
    procedure cbColetaneasPersoChange(Sender: TObject);
    procedure bsSkinSpeedButton24Click(Sender: TObject);
    procedure bsSkinSpeedButton26Click(Sender: TObject);
    procedure cbMarcarConcClick(Sender: TObject);
    procedure pnlAddColPersoClose(Sender: TObject);
    procedure pnlAltColPersoClose(Sender: TObject);
    procedure bsSkinSpeedButton25Click(Sender: TObject);
    procedure ckMonitorJanelaClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cgEscSBAudioClick(Sender: TObject);
    procedure meESHoraExit(Sender: TObject);
    procedure bsSkinSpeedButton30Click(Sender: TObject);
    procedure opSortKeyPress(Sender: TObject; var Key: Char);
    procedure lbSorteioItemCheckClick(Sender: TObject);
    procedure btAddSorteioClick(Sender: TObject);
    procedure btLimpaSorteioReiniciaClick(Sender: TObject);
    procedure btLimpaSorteioLimpaClick(Sender: TObject);
    procedure btLimpaSorteioClick(Sender: TObject);
    procedure ckSorteioExpClick(Sender: TObject);
    procedure btFormatClick(Sender: TObject);
    procedure pnlFormatClose(Sender: TObject);
    procedure bsSkinSpeedButton28Click(Sender: TObject);
    procedure tsSorteioNMShow(Sender: TObject);
    procedure bsSkinButton3Click(Sender: TObject);
    procedure bsSkinButton4Click(Sender: TObject);
    procedure bsSkinButton6Click(Sender: TObject);
    procedure bsSkinButton5Click(Sender: TObject);
    procedure bsSkinButton9Click(Sender: TObject);
    procedure bsSkinButton8Click(Sender: TObject);
    procedure lbSorteioNMItemCheckClick(Sender: TObject);
    procedure bsSkinButton10Click(Sender: TObject);
    procedure bsSkinButton12Click(Sender: TObject);
    procedure bsSkinButton11Click(Sender: TObject);
    procedure bsSkinButton7Click(Sender: TObject);
    procedure opSort_IniKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure opSort_NmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btAddSorteioNMClick(Sender: TObject);
    procedure btImpSorteioNMClick(Sender: TObject);
    procedure btSortearNMClick(Sender: TObject);
    procedure ckSorteioExpNMClick(Sender: TObject);
    procedure btLimpaSorteioLimpaNMClick(Sender: TObject);
    procedure btLimpaSorteioReiniciaNMClick(Sender: TObject);
    procedure btLimpaSorteioNMClick(Sender: TObject);
    procedure cbCronoElClick(Sender: TObject);
    procedure bsSkinSpeedButton29Click(Sender: TObject);
    procedure bsSkinButton13Click(Sender: TObject);
    procedure rbDirecaoClick(Sender: TObject);
    procedure txtDecrChange(Sender: TObject);
    procedure bsSkinSpeedButton27Click(Sender: TObject);
    procedure tsPainelDShow(Sender: TObject);
    procedure btExibeTxtPainelDClick(Sender: TObject);
    procedure bsSkinSpeedButton31Click(Sender: TObject);
    procedure tsTextoInterativoShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RichEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RichEditEnter(Sender: TObject);
    procedure fcTxtIChange(Sender: TObject);
    procedure seTxtITamanhoChange(Sender: TObject);
    procedure btfsStrikeOutClick(Sender: TObject);
    procedure btfsUnderlineClick(Sender: TObject);
    procedure btfsItalicClick(Sender: TObject);
    procedure btfsBoldClick(Sender: TObject);
    procedure cbColorTxtIChangeColor(Sender: TObject);
    procedure cbColorFTxtIChangeColor(Sender: TObject);
    procedure bsSkinSpeedButton42Click(Sender: TObject);
    procedure bsSkinSpeedButton41Click(Sender: TObject);
    procedure bsSkinSpeedButton39Click(Sender: TObject);
    procedure bsSkinSpeedButton38Click(Sender: TObject);
    procedure bsSkinSpeedButton43Click(Sender: TObject);
    procedure cbColorRTxtIChangeColor(Sender: TObject);
    procedure RE_SetSelBgColor(RichEdit: TbsSkinRichEdit; AColor: TColor);
    procedure bsSkinSpeedButton44Click(Sender: TObject);
    procedure bsSkinSpeedButton45Click(Sender: TObject);
    procedure bttaLeftJustifyClick(Sender: TObject);
    procedure bttaRightJustifyClick(Sender: TObject);
    procedure bttaCenterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmPainelDKeyPress(Sender: TObject; var Key: Char);
    function GetEnvVarValue(const VarName: string): string;
    procedure bsAppMenu1Items6Click(Sender: TObject);
    procedure bsSkinSpeedButton23Click(Sender: TObject);
    procedure bsSkinSpeedButton37Click(Sender: TObject);
    procedure sTabSheet12Show(Sender: TObject);
    procedure sTabSheet14Show(Sender: TObject);
    procedure slbTabelasListBoxClick(Sender: TObject);
    procedure bsSkinButton15Click(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
    procedure AjustaLarguraCamposDBGrid(DBGrid: TbsSkinDbGrid);
    procedure abrirArquivo(url: string;externo: Boolean = false);
    procedure bsSkinSpeedButton46Click(Sender: TObject);
    procedure bsRibbon1Buttons3Click(Sender: TObject);
    procedure ExcluirTodas1Click(Sender: TObject);
    procedure inputOpenDialog(Sender: TObject);
    procedure inputOpenPictureDialog(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheel(Direction: string; Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure cbBibliaHistoricoClick(Sender: TObject);
    procedure bsSkinSpeedButton50Click(Sender: TObject);
    procedure tsRelogioShow(Sender: TObject);
    procedure imgCapaProgramaEnter(Sender: TObject);
    procedure imgCapaProgramaExit(Sender: TObject);
    procedure corCapaProgramaChangeColor(Sender: TObject);
    procedure btRestaurarCapaProgramaClick(Sender: TObject);
    procedure cbAlinhamentoCapaProgramaChange(Sender: TObject);
    procedure bsSkinSpeedButton53Click(Sender: TObject);
    procedure bsSkinSpeedButton54Click(Sender: TObject);
    procedure bsSkinSpeedButton55Click(Sender: TObject);
    procedure btApagaLitSelClick(Sender: TObject);
    procedure bsSkinSpeedButton58Click(Sender: TObject);
    procedure bsSkinButton25Click(Sender: TObject);
    procedure atualiza_coletaneas_web(p: string; id: string = '');
    procedure lista_coletaneas_web(p: string; id: string = '');
    procedure tsColetaneasOnlineShow(Sender: TObject);
    function DownloadArquivo(const Origem, Destino: string): Boolean;
    procedure bgOnlCanaisButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlOnlPlaylistsClose(Sender: TObject);
    procedure bsSkinButton24Click(Sender: TObject);
    procedure bgOnlPlaylistsButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlOnlVideosClose(Sender: TObject);
    procedure bsSkinButton26Click(Sender: TObject);
    procedure bgOnlVideosButtonClicked(Sender: TObject; Index: Integer);
    procedure abreVideoOn(videoID: string; videoTITULO: string = '');
    procedure abreLetraMusica(tipo: string;param: string;musicaID: Integer;audio: boolean = True);
    procedure abreLetraMusicaAlbum(albumID: Integer;musicaID: Integer = 0);
    procedure abreArquivoMusica(musicaID: Integer;album: string = '';url: string = '');
    procedure player(url: string;video: Boolean = true);
    procedure sbVideoOnAreaExtendidaChange(Sender: TObject);
    procedure ckVideoOnJanelaClick(Sender: TObject);
    procedure bsSkinSpeedButton60Click(Sender: TObject);
    procedure bsSkinSpeedButton62Click(Sender: TObject);
    procedure btUrlVideoOnClick(Sender: TObject);
    procedure btExecVideoOn(campo: TbsSkinEdit; limpa: Boolean = true);
    function getVideoID(link: string):string;
    procedure btAbreSaveVideoOn(campo: TbsSkinEdit);
    procedure txtUrlVideoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbVideoOnAbreLiturgiaChange(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
    procedure bsSkinSpeedButton59Click(Sender: TObject);
    procedure btUrlVideoOn2Click(Sender: TObject);
    procedure bsSkinSpeedButton66Click(Sender: TObject);
    procedure bsSkinSpeedButton61Click(Sender: TObject);
    procedure btColetaneasOnlinePersoClick(Sender: TObject);
    procedure tsColetaneasOnlinePersoShow(Sender: TObject);
    procedure bsSkinSpeedButton68Click(Sender: TObject);
    procedure btAddVideoOn3Click(Sender: TObject);
    procedure txtUrlVideoOn2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrlVideoOn3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid4DblClick(Sender: TObject);
    procedure bsSkinTabSheet6Show(Sender: TObject);
    procedure Excluir3Click(Sender: TObject);
    procedure CopiarLink1Click(Sender: TObject);
    procedure AbrirnoNavegador1Click(Sender: TObject);
    procedure btwsCloseClick(Sender: TObject);
    procedure btwsMinimizeClick(Sender: TObject);
    procedure btwsMaximizedClick(Sender: TObject);
    procedure pnlfmBarraTituloFormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlfmBarraTituloFormDblClick(Sender: TObject);
    procedure focoAplicacao(acao: Boolean);
    procedure btwsDownloadClick(Sender: TObject);
    procedure bsRibbon1ChangePage(Sender: TObject);
    procedure carregaFavoritos();
    procedure btAddFavClick(Sender: TObject);
    procedure bsSkinTabSheet7Show(Sender: TObject);
    procedure ogFavoritosItemClick(Sender: TObject);
    procedure btDelFavClick(Sender: TObject);
    procedure bsRibbon1Buttons4Click(Sender: TObject);
    procedure btwsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btwsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure botoesFavoritos(acao: string);
    procedure btOrdFavClick(Sender: TObject);
    procedure pnlfmSubTituloRibMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnlfmSubTituloRibMouseLeave(Sender: TObject);
    procedure pnlfmSubTituloRibClick(Sender: TObject);
    procedure desenvolvedor(ativo: boolean);
    procedure txtBuscaColetPesoChange(Sender: TObject);
    procedure sbMusicaAreaExtendidaChange(Sender: TObject);
    procedure ckMusicaJanelaClick(Sender: TObject);
    procedure edtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure usaFontes(usar: Boolean = true);
    procedure ckMusicaOperadorClick(Sender: TObject);
    procedure btMusicaSlideMusicaClick(Sender: TObject);
    procedure btMusicaLetraClick(Sender: TObject);
    procedure btMusicaAudioMusicaClick(Sender: TObject);
    procedure btAddItemLiturgiaClick(Sender: TObject);
    function FonteExiste(Fonte:STring):Boolean;
    procedure FormDestroy(Sender: TObject);
    procedure ImpExpClick(Sender: TObject);
    procedure bsSkinSpeedButton16Click(Sender: TObject);
    procedure tsDoxologiaShow(Sender: TObject);
    procedure bgDoxologiaCateButtonClicked(Sender: TObject; Index: Integer);
    procedure pnlDoxologiaMusicasClose(Sender: TObject);
    procedure btErroClick(Sender: TObject);
    procedure move_MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure move_MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure move_MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PanelColorClick(Sender: TObject);
    procedure tsLiturgiaShow(Sender: TObject);
    procedure carregaLiturgia(semana: Integer);
    procedure carregaItemLiturgia(item: string;ordem: Integer = 0);
    procedure apagaItemLiturgia(item: string);
    procedure salvaItensLiturgia();
    function CopyComponent(Component,AParent: TComponent; NewComponentName: String): TComponent;
    procedure lit_modItem_checkbClick(Sender: TObject);
    procedure lit_modItem_bteditClick(Sender: TObject);
    procedure lit_modItem_textoClick(Sender: TObject);
    procedure bsSkinButton34Click(Sender: TObject);
    procedure bsRibbon1Buttons5Click(Sender: TObject);
    procedure bsRibbon1Buttons0Click(Sender: TObject);
    procedure ckMusicaTituloSlideClick(Sender: TObject);
    procedure bsSkinButton38Click(Sender: TObject);
    procedure bsSkinButton36Click(Sender: TObject);
    procedure tabLetrasChange(Sender: TObject);
    procedure ckSlideTxtFormatPersoClick(Sender: TObject);
    procedure seSorteioTempoChange(Sender: TObject);
    procedure seSorteioTempoNMChange(Sender: TObject);
    function diretorio(dir:string):string;
    procedure processaArquivo(arq: string);
    procedure ExportarMusicaClick(Sender: TObject);
    procedure miOpcExportar1Click(Sender: TObject);
    procedure exportarMusica(id:integer;audio:boolean;nome:string = '';param:string = '');
    function SegundosToTime( Segundos : Cardinal ) : String;
    procedure gravaLog(txt:string);
    procedure corFundoMusicaChangeColor(Sender: TObject);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure DBGrid2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid2CellClick(Column: TbsColumn);
    procedure cbFormatoChange(Sender: TObject);
    procedure tsMusicasInfantisShow(Sender: TObject);
    procedure bsSkinSpeedButton2Click(Sender: TObject);
    procedure dbctrlMusicasClick(Sender: TObject);
    procedure cbPosicaoFundoClick(Sender: TObject);
    procedure ajustaImagem(imagem:TImage;panel:TPanel;posicao:integer);
    function RemoveAcento(Str: string): string;
    procedure tsItensAgendadosShow(Sender: TObject);
    procedure bsSkinSpeedButton5Click(Sender: TObject);
    procedure MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal;
      var MonthBoldInfo: Cardinal);
    procedure btAddCategoriaAgendadosClick(Sender: TObject);
    procedure bsPngImageView13Click(Sender: TObject);
    procedure categoriasItensAgendadosClick(Sender: TObject);
    procedure itensAgendadosClick(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
    procedure bsPngImageView11Click(Sender: TObject);
    procedure bsSkinSpeedButton8Click(Sender: TObject);
    procedure removeItensAgendadosPassados();
    procedure cbRemoveItensAgendadosClick(Sender: TObject);
    procedure refreshCalendar();
    procedure copiaTextoParaSlides(texto: string; cds: TClientDataSet);
    procedure copiaArquivoParaSlides(url: string; cds: TClientDataSet; fechaerro: boolean = true; ListBox: TListBox = nil; editor: boolean = false);
    procedure copiaSlidesParaArquivo(url: string; cds: TClientDataSet);
    function cds2texto(cds: TClientDataSet;campo: string): TStringList;
    function HtmlToColor(Color: string): String;
    procedure cbAnotacoesLiturgiaClick(Sender: TObject);
    procedure pnlAnotacoesLiturgiaClose(Sender: TObject);
    procedure RichEdit1Exit(Sender: TObject);
    procedure mmPopMonitorClick(Sender: TObject);
    procedure identifica_monitores(Sender: TObject);
    function lista_monitores(): TArray<TMonitorInfo>;
    procedure carrega_monitores();
    procedure ppVideosOnPersoPopup(Sender: TObject);
    procedure bsPopupMenuFavoritosPopup(Sender: TObject);
    procedure carregaComboFormatoTempo(combo:TbsSkinComboBox;formato:string);
    function openDialog(tipo:string = '';filtros:string = '';param:string = '';multiplos:boolean = False;diretorio_inicial:string = '';titulo_dialog: string = '';nome_arquivo:string = ''):string;
    function saveDialog(tipo:string = '';filtros:string = '';param:string = '';diretorio_inicial:string = '';titulo_dialog: string = '';nome_arquivo:string = ''):string;
    procedure bsSkinButton43Click(Sender: TObject);
    procedure bsAppMenu1Items7Click(Sender: TObject);
    procedure btExecSQLClick(Sender: TObject);
    procedure mmBDKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbEscSBRelogioFuncClick(Sender: TObject);
    procedure cbEscSBZerarTempoClick(Sender: TObject);
    procedure escSBTempo();
    procedure DBCtrlGridBibliaLivroClick(Sender: TObject);
    procedure carregaBiblia(tipo:string);
    procedure DBCtrlGridBibliaCapituloClick(Sender: TObject);
    procedure DBCtrlGridBibliaVersiculoClick(Sender: TObject);
    procedure busBibliaVersiculoChange(Sender: TObject);
    function GetStrNumber(const S: string): string;
    function GetStrNumber2(const S: string): string;
    function geraIntervaloNum(S: string): string;
    function formataIntervaloNum(S: string): string;
    function maiorLista(L: string): string;
    function menorLista(L: string): string;
    procedure DBCtrlGridBibliaHistoricoClick(Sender: TObject);
    procedure bsSkinButton20Click(Sender: TObject);
    procedure pnlBibliaHistoricoClose(Sender: TObject);
    procedure ajustaTexto(pagina:string;areaExpandida: Boolean = false);
    procedure btLimparClick(Sender: TObject);
    procedure busBibliaVersiculoKeyPress(Sender: TObject; var Key: Char);
    procedure btBibVersAntClick(Sender: TObject);
    procedure btBibVersSegClick(Sender: TObject);
    procedure btBibLocalizaClick(Sender: TObject);
    procedure txtBibLocalizaKeyPress(Sender: TObject; var Key: Char);
    procedure dblBibVersao2Click(Sender: TObject);
    procedure DBCtrlGridBibliaBuscaClick(Sender: TObject);
    procedure btLimparBBuscaClick(Sender: TObject);
    procedure btBibBusVersSegClick(Sender: TObject);
    procedure btBibBusVersAntClick(Sender: TObject);
    procedure pnLivrosClose(Sender: TObject);
    procedure ckgFiltrosClick(Sender: TObject);
    procedure aSort(var Vetor: Array of Integer);
    procedure atualizaIgnoreAlbum();
    procedure gridAlbAtDblClick(Sender: TObject);
    procedure gridAlbInatDblClick(Sender: TObject);
    procedure bsSkinButton21Click(Sender: TObject);
    function FileSize(const FileName: string): Int64;
    procedure corTituloMusicaChangeColor(Sender: TObject);
    procedure corTextoMusicaChangeColor(Sender: TObject);
    procedure corTextoAuxMusicaChangeColor(Sender: TObject);
    procedure ckMusicaFundoTransparenteClick(Sender: TObject);
    procedure seTamanhoTituloChange(Sender: TObject);
    procedure seTamanhoTextoChange(Sender: TObject);
    procedure seTamanhoTextoAuxChange(Sender: TObject);
    procedure imgFundoMusicaEnter(Sender: TObject);
    procedure imgFundoMusicaExit(Sender: TObject);
    procedure posicaoFundoClick(Sender: TObject);
    procedure corTextoRepetidoChangeColor(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure getClipboard();
    procedure btPersoClipBoardClick(Sender: TObject);
    procedure ckFadeFormClick(Sender: TObject);
    function RecursiveDelete(FullPath: String;nivel: integer = 0): Boolean;
    procedure btLitClipBoardClick(Sender: TObject);
    procedure cbBloqItensClick(Sender: TObject);
    procedure cbLayoutChange(Sender: TObject);
    procedure ckSlideImgFormatPersoClick(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure DBCtrlGridBibliaLivroPaintPanel(DBCtrlGrid: TbsSkinDBCtrlGrid;
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaCapituloPaintPanel(DBCtrlGrid: TbsSkinDBCtrlGrid;
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGrid: TbsSkinDBCtrlGrid;
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaHistoricoPaintPanel(DBCtrlGrid: TbsSkinDBCtrlGrid;
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure DBCtrlGridBibliaBuscaPaintPanel(DBCtrlGrid: TbsSkinDBCtrlGrid;
      Index: Integer; Cnvs: TCanvas; ClRect: TRect);
    procedure bsAppMenu1Click(Sender: TObject);
    procedure bsAppMenu1Items1Click(Sender: TObject);
    procedure bsAppMenu1ChangePage(Sender: TObject);
    procedure pbPlayerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btplPlayClick(Sender: TObject);
    procedure btplPauseClick(Sender: TObject);
    procedure btplFecharClick(Sender: TObject);
    procedure sbPlayerAreaExtendidaChange(Sender: TObject);
    procedure ckPlayerTelaCheiaClick(Sender: TObject);
    procedure ckPlayerVideoClick(Sender: TObject);
    procedure ckPlayerAudioClick(Sender: TObject);
    procedure bsSkinSpeedButton6Click(Sender: TObject);
    procedure dblBibVersaoClick(Sender: TObject);
    procedure busBibliaLivroChange(Sender: TObject);
    procedure busBibliaLivroExit(Sender: TObject);
    procedure busBibliaCapituloExit(Sender: TObject);
    procedure busBibliaCapituloChange(Sender: TObject);
    procedure bsSkinTabSheet5Show(Sender: TObject);
    procedure opcCronoCTempoClick(Sender: TObject);
    procedure meESDuracaoChange(Sender: TObject);
    procedure bsAddTClick(Sender: TObject);
    procedure ckMesmaJanelaClick(Sender: TObject);
    procedure sbAlinhMusicaChange(Sender: TObject);
    procedure cbRelogioAlinhamentoChange(Sender: TObject);
    procedure bsAppMenu1Items10Click(Sender: TObject);
    procedure bsAppMenu1Items3Click(Sender: TObject);
    procedure ckMusicaTopoClick(Sender: TObject);
    procedure spServerClick(Sender: TObject);
    procedure ckMusicaRetornoClick(Sender: TObject);
    procedure sbMusicaRetornoAreaExtendidaChange(Sender: TObject);
    function GetIP(): string;
    procedure Button2Click(Sender: TObject);
    procedure monitores(padrao: integer = -1);
    procedure monitor_bt_label(botao: TbsSkinMenuSpeedButton);
    function monitor_tp_config(botao: TbsSkinMenuSpeedButton):string;
    procedure sbMusicaOperadorAreaExtendidaChange(Sender: TObject);
    procedure ckFundoTransparenteClick(Sender: TObject);
    procedure btAbreHinosNClick(Sender: TObject);
    procedure tsHinarioNShow(Sender: TObject);
    procedure txtHinoNKeyPress(Sender: TObject; var Key: Char);
    procedure txtHinoNChange(Sender: TObject);
    procedure DBGrid1NDblClick(Sender: TObject);
    procedure bsSkinSpeedButton13NClick(Sender: TObject);
    procedure bsSkinSpeedButton3NClick(Sender: TObject);
    procedure bsSkinSpeedButton6NClick(Sender: TObject);
    procedure btHinoSlideMusicaNClick(Sender: TObject);
    procedure bsSkinSpeedButton12NClick(Sender: TObject);
    procedure bsSkinButton44Click(Sender: TObject);
    procedure bsSkinButton45Click(Sender: TObject);
    procedure bsSkinButton46Click(Sender: TObject);
    function monitorInfo(index: integer): TMonitorInfo;
    procedure importColetaneasPerso();
    procedure ckgColetaneasClick(Sender: TObject);
    function arquivoCodificado(arq: string): TStringList;
    procedure bsknbtn1Click(Sender: TObject);
    procedure bsSkinSpeedButton7Click(Sender: TObject);
    procedure ckSlideFormatPersoExtClick(Sender: TObject);
    procedure bsSkinButton47Click(Sender: TObject);
    procedure seTamanhoTextoRetornoChange(Sender: TObject);
    function removeTagsHTML(texto: string): string;
  private
    { Private declarations }
    move_x,move_y:integer;
    move_panel: TPanel;
    move: Boolean;

    const
      VERSAO_MIN_BD: string = '19.0';
      fonte: string = 'Arial Rounded MT Bold';

    //Permite arrastar form via Panel
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    //Define tamanho da tel maximizada (evita que form fique embaixo da barra de tarefas)
    procedure WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo); message WM_GETMINMAXINFO;

    //Define as ações para quando perder ou receber o foco
    procedure ApplicationDeactivate(Sender: TObject);
    procedure ApplicationActivate(Sender: TObject);

  public
    { Public declarations }
    dir_dados: string;
    dir_temp: string;
    dir_config: string;
    url_params: string;

    carrega_opc: Boolean;

    vSorteioAnimFim, vSorteioAnimFimNM: TDateTime;
    tCrono: TDateTime;
    tCronoOld: TDateTime;
    tCronoT: TDateTime;

    tEscSBCrono: TDateTime;

    buffer: integer;
    botao_trmenu: TbsSkinMenuSpeedButton;


    TITULO: PChar;
    arq_liturgia: string;
    senha_bd: string;

    externo: Boolean;

  end;

var
  fmIndex: TfmIndex;

implementation

uses
  fmLetra, fmAtualiza, StrUtils, Math, fmNovaVersao,
  fmHelp, fmVideoOn, fmFavoritos, fmMusica, fmListaMusica,
  fmMusicaOperador, fmLiturgia, fmArquivosFalta, fmBuscaMusica, fmArquivosExcesso,
  fmItensAgendados, dmComponentes, fmEditorSlides, fmPlayer, fmIniciando,
  fmTransmitir, fmMusicaRetorno, fmMonitorRelogio, fmMonitorTextoInterativo,
  fmMonitorPainelDinamico, fmMonitorCronometro, fmMonitorSorteioNomes,
  fmMonitorSorteio, fmMonitorCronometroCulto, fmMonitorBibliaBusca,
  fmMonitorBiblia, fmMonitorMenuMusicas, fmIdentificaMonitores;

{$R *.dfm}


Function TfmIndex.VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F : PFFI;
  Handle : Dword;
  Len : Longint;
  Data : Pchar;
  Buffer : Pointer;
  Tamanho : Dword;
  Parquivo: Pchar;
  Arquivo : String;
begin
  Arquivo := Application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data:=StrAlloc(Len+1);
    if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
    begin
      VerQueryValue(Data, '\',Buffer,Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d',
        [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs),
        HiWord(F^.dwFileVersionLs),
        Loword(F^.dwFileVersionLs)]
      );
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

procedure TfmIndex.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RichEdit1Exit(RichEdit1);
  DM.tmrSair.Enabled := true;
end;

procedure TfmIndex.FormCreate(Sender: TObject);
begin
  Application.OnDeactivate := ApplicationDeactivate;
  Application.OnActivate := ApplicationActivate;
  SysUtils.FormatSettings.DecimalSeparator := '.';

  SetWindowLong(fmIndex.Handle,
                GWL_STYLE,
                GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
end;

procedure TfmIndex.FormDestroy(Sender: TObject);
begin
  RichEdit1Exit(Sender);
  usaFontes(false);
  RecursiveDelete(dir_temp);
end;

procedure TfmIndex.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  t: integer;
begin
  if (Key = VK_ESCAPE) then
  begin
    if bsRibbon1.AppMenu.Visible then
      bsRibbon1.AppMenu.Visible := false
    else if (Screen.ActiveForm.Name <> 'fmIndex') then
      Screen.ActiveForm.Close
    else
    begin
      if (fMusica <> nil) and (fMusica.Visible) then
        fMusica.Close
      else if (fVideoOn <> nil) and (fVideoOn.Visible) then
        fVideoOn.Close
      ;
    end;
  end
  else if (((Chr(Key) = 'V') or (Chr(Key) = 'v')) and (Shift = [ssCtrl])) then
  begin
    cboard.Items.Clear;
    getClipboard();
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsPersonalizadas)
      then btPersoClipBoardClick(Sender)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsLiturgia)
      then btLitClipBoardClick(Sender);
  end
  else if (((Chr(Key) = 'W') or (Chr(Key) = 'w')) and (Shift = [ssCtrl])) then
  begin
    if ((Screen.ActiveForm.Name = 'fmIndex') and (PageControl1.Visible = True)) then
    begin
      t := TbsSkinTabSheet(PageControl1.ActivePage).Tag;
      PageControl1.ActivePage.TabVisible := False;
      bsPopupMenuRibon.Items.Delete(t);
      confereAbasAbertas();
    end;
  end
  else if (((Chr(Key) = 'F') or (Chr(Key) = 'f')) and (Shift = [ssCtrl])) then
  begin
    bsRibbon1Buttons0Click(Sender);
  end
  else if (Key = VK_F2) and (Shift = [ssShift,ssCtrl]) then
  begin
    if pnlModDes.Visible then
    begin
      desenvolvedor(false);
      if not pnlModDes.Visible then Application.MessageBox(PChar('Modo ''Desenvolvedor'' desativado!'), TITULO, mb_ok + mb_iconinformation);
    end
    else
    begin
      desenvolvedor(true);
      if pnlModDes.Visible then Application.MessageBox(PChar('Modo ''Desenvolvedor'' ativado!'), TITULO, mb_ok + mb_iconinformation);
    end;
  end
  else if (Key = VK_F1) then
    bsRibbon1Buttons5Click(Sender)

  else if ((Key = VK_F5) or (Key = VK_F9)) then
  begin
    if (fListaMusica <> nil) and (fListaMusica.Visible) and (fListaMusica.Active) and (fListaMusica.btExp_MenuMusicas.ImageIndex = 53)
      then fListaMusica.btExp_MenuMusicasClick(fListaMusica.btExp_MenuMusicas)

    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsHinario)
      then DBGrid1DblClick(DBGrid1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaMusica)
      then DBGrid2DblClick(DBGrid2)

    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBiblia) and (btExp_Biblia.ImageIndex = 10)
      then expandirArea(btExp_Biblia)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaBiblica) and (btExp_BibliaBusca.ImageIndex = 10)
      then expandirArea(btExp_BibliaBusca)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto) and (btExp_EscolaSabatina.ImageIndex = 10)
      then expandirArea(btExp_EscolaSabatina)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio) and (btExp_Sorteio.ImageIndex = 10)
      then expandirArea(btExp_Sorteio)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM) and (btExp_SorteioNM.ImageIndex = 10)
      then expandirArea(btExp_SorteioNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro) and (btExp_Cronometro.ImageIndex = 10)
      then expandirArea(btExp_Cronometro)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsPainelD) and (btExp_PainelD.ImageIndex = 10)
      then expandirArea(btExp_PainelD)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsTextoInterativo) and (btExp_TextoInterativo.ImageIndex = 10)
      then expandirArea(btExp_TextoInterativo)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsRelogio) and (btExp_Relogio.ImageIndex = 10)
      then expandirArea(btExp_Relogio)

    else if (fMusica <> nil) and (fMusica.Visible) and (pnlModDes.Visible)
      then fMusica.btRefreshClick(Sender)

    else if (fEditorSlides <> nil) and (fEditorSlides.Visible)
      then fEditorSlides.btProjetaClick(Sender);

  end

  else if (fMusica <> nil) and (fMusica.Visible) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if (fMusica.Active) or (fMusicaOperador.Active) then
      begin
        if (Key = VK_DOWN) and (Shift = [ssCtrl])  then
          fMusica.btProxGravaClick(Sender)
        else if (Key = VK_UP) and (Shift = [ssCtrl])  then
          fMusica.btGravaRClick(Sender)
        else if (Key = VK_LEFT) and (Shift = [ssCtrl])  then
          fMusica.btGravaAClick(Sender)
        else if (Key = VK_F5) then
          fMusica.refresh
        else if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
          fMusica.acaoSlide('ant')
        else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
          fMusica.acaoSlide('prox')
        else if (Key = VK_HOME) then
          fMusica.acaoSlide('pri')
        else if (Key = VK_END) then
          fMusica.acaoSlide('ult')
        else if (Key = VK_PAUSE) or (Key = VK_SPACE) or (Key = VK_PLAY) or ((Shift = [ssCtrl]) and ((Key = 50) or (Key = 80))) then
          fMusica.pauseplay
        ;
      end;
    end;

  end

  else if (fEditorSlides <> nil) and (fEditorSlides.Visible) and (fEditorSlides.Active) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_RIGHT) and (Shift = [ssCtrl])) or ((Key = VK_DOWN) and (Shift = [ssCtrl]))  then
        fEditorSlides.btGravaAClick(Sender)
      else if ((Key = VK_LEFT) and (Shift = [ssCtrl])) or ((Key = VK_UP) and (Shift = [ssCtrl]))  then
        fEditorSlides.btGravaRClick(Sender)

      else if (Key = VK_F5) then
        fEditorSlides.carregaSlide
      else if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
        fEditorSlides.acaoSlide('ant')
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
        fEditorSlides.acaoSlide('prox')
      else if (Key = VK_HOME) then
        fEditorSlides.acaoSlide('pri')
      else if (Key = VK_END) then
        fEditorSlides.acaoSlide('ult')
      else if (Key = VK_PAUSE) or (Key = VK_SPACE) or (Key = VK_PLAY) or ((Shift = [ssCtrl]) and ((Key = 50) or (Key = 80))) then
        fEditorSlides.pauseplay
      else if (((Chr(Key) = 'N') or (Chr(Key) = 'n')) and (Shift = [ssShift,ssCtrl])) then
        fEditorSlides.btNovoClick(fEditorSlides.btNovo)
      else if (((Chr(Key) = 'N') or (Chr(Key) = 'n')) and (Shift = [ssCtrl])) then
        fEditorSlides.btNovoSlideClick(fEditorSlides.btNovoSlide)
      else if (((Chr(Key) = 'S') or (Chr(Key) = 's')) and (Shift = [ssCtrl])) then
        fEditorSlides.btSalvarClick(fEditorSlides.btSalvar)
      else if (((Chr(Key) = 'A') or (Chr(Key) = 'a')) and (Shift = [ssCtrl])) then
        fEditorSlides.btAbrirClick(fEditorSlides.btAbrir)
      else if (((Chr(Key) = 'D') or (Chr(Key) = 'd')) and (Shift = [ssCtrl])) then
        fEditorSlides.btNovoSlideClick(fEditorSlides.btDuplicaSlide)
      else if (Key = VK_DELETE) then
        fEditorSlides.btExcluiSlideClick(fEditorSlides.btExcluiSlide)
      ;
    end;

  end

  else if (PageControl1.Visible) and (PageControl1.ActivePage = tsBiblia) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then
      begin
        btBibVersAntClick(Sender)
      end
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then
      begin
        btBibVersSegClick(Sender);
      end;
    end;
  end
  else if (PageControl1.Visible) and (PageControl1.ActivePage = tsBuscaBiblica) then
  begin
    if (Screen.ActiveControl.Tag <> 9999) then
    begin
      if ((Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_PRIOR)) then btBibBusVersAntClick(Sender)
      else if ((Key = VK_DOWN) or (Key = VK_RIGHT) or (Key = VK_NEXT)) then btBibBusVersSegClick(Sender);
    end;
  end

  else if (Key = VK_PRIOR) then  //PASSADOR DE SLIDES
  begin
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto)
      then bsAddTClick(bsAddTm1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio)
      then btLimpaSorteioReiniciaClick(btLimpaSorteioReinicia)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM)
      then btLimpaSorteioReiniciaNMClick(btLimpaSorteioReiniciaNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro)
      then btZerarCronoClick(btZerarCrono);
  end
  else if (Key = VK_NEXT) then  //PASSADOR DE SLIDES
  begin
    if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronoCulto)
      then bsAddTClick(bsAddT1)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteio)
      then btSortearClick(btSortear)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsSorteioNM)
      then btSortearNMClick(btSortearNM)
    else if (fmIndex.Active) and (PageControl1.Visible) and (PageControl1.ActivePage = tsCronometro)
      then btIniciarCronoClick(btIniciarCrono);
  end;
end;

procedure TfmIndex.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  MouseWheel('Down', Sender, Shift, MousePos, Handled);
end;

procedure TfmIndex.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  MouseWheel('Up', Sender, Shift, MousePos, Handled);
end;

procedure TfmIndex.fExibeColetaneas(Tipo: string; ScrollBox: TbsSkinScrollBox);
var
  Button: TbsSkinButtonEx;
  gLeft, gTop, gWidth, gHeight: Integer;
  mLeft: integer;
  dirIMG: string;
  id: string;
  formWidth: Integer;
  bitmap: TBitmap;
  idimg: Integer;
begin
  DM.qrALBUNS.Close;
  DM.qrALBUNS.ParamByName('TIPO').Value := Tipo;
  DM.qrALBUNS.Open;

  formWidth := ScrollBox.Width;

  ScrollBox.VScroll(0);
  gLeft := 0;
  gTop := 10;
  gWidth := 165;
  gHeight := 190;

  while ((gLeft + gWidth + 10 + gWidth + 20) < formWidth) do
    gLeft := gLeft + gWidth + 10;
  mLeft := trunc((formWidth - (gLeft + gWidth + 10)) / 2);
  gLeft := mLeft;


  while not DM.qrALBUNS.Eof do
  begin
    id := DM.qrALBUNS.FieldByName('ID').AsString;

    Button := TbsSkinButtonEx(FindComponent('gb_' + Tipo + '_' + id));
    Button.Free;
    if Assigned(Button) then
      continue;

    try
      Button := TbsSkinButtonEx.Create(ScrollBox);
      Button.Visible := False;
      dirIMG := dir_config + 'capas\' + DM.qrALBUNS.FieldByName('IMAGEM').AsString;
      with Button do
      begin
        Parent := ScrollBox;
        Name := 'gb_' + Tipo + '_' + id;
        Tag := DM.qrALBUNS.FieldByName('ID_ALBUM').AsInteger;
        Title := ' ' + DM.qrALBUNS.FieldByName('NOME').AsString + ' ';
        Caption := DM.qrALBUNS.FieldByName('SUBTITULO').AsString + ' ';
        OnClick := sbClick;
        Layout := bsButtonModel.Layout;
        SkinData := bsButtonModel.SkinData;
        ImageList := bsButtonModel.ImageList;
        if (fileexists(dirIMG) and (UpperCase(copy(dirIMG, length(dirIMG) - 3, 4)) = '.BMP')) then
        begin
          bitmap := TBitmap.Create;
          bitmap.LoadFromFile(dirIMG);
          bitmap.TransparentColor := clFuchsia;
          bitmap.Transparent := false;
          idimg := DM.imCapas.Add(bitmap, nil);
          ImageIndex := idimg;
          bitmap.Free;
        end;
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    except
      with Button do
      begin
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    end;
    Button.Visible := True;

    if ((gLeft + gWidth + 10 + gWidth + 20) >= formWidth) then
    begin
      gLeft := mLeft;
      gTop := gTop + gHeight + 10;
    end
    else
      gLeft := gLeft + gWidth + 10;

    DM.qrALBUNS.Next;
  end;

  ScrollBox.VScroll(0);
  ScrollBox.VScrollBar.Visible := True;
  ScrollBox.VScrollBar.Position := 0;
end;

procedure TfmIndex.salvaItensLiturgia;
var
  semana: string;
begin
  semana := fmIndex.loadCol.Strings.Values['LITURGIA:SEMANA'];
  gravaParam('Geral', semana, StringReplace(lbLiturgia.Items.Text, #13#10, ';', [rfIgnoreCase, rfReplaceAll]), arq_liturgia);
  gravaParam('Geral', 'AlteraOrdem-'+semana, FormatDateTime('dd/mm/yyyy hh:mm:ss',now()), arq_liturgia);
end;

procedure TfmIndex.sbAlinhMusicaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Alinhamento', inttostr(sbAlinhMusica.ItemIndex));
end;

procedure TfmIndex.sbClick(Sender: TObject);
var
  id_album: integer;
  titulo_album: string;
  subtitulo_album: string;
  titulo_form: string;
begin
  id_album := TComponent(Sender).Tag;
  titulo_album := TbsSkinButtonEx(Sender).Title;
  subtitulo_album := TbsSkinButtonEx(Sender).Caption;
  titulo_form := titulo_album;
  if (trim(subtitulo_album) <> '') then
    titulo_form := titulo_form+' ('+trim(subtitulo_album)+')';

  fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
  fListaMusica.id_album := id_album;
  fListaMusica.inicio := false;
  fListaMusica.Caption := titulo_form;
  fListaMusica.lblTitulo.Caption := titulo_album;
  fListaMusica.lblSubtitulo.Caption := subtitulo_album;
  fListaMusica.dir := '';
  fListaMusica.DBCtrlGrid.DataSource := DM.dsMUSICAS;
  fListaMusica.pnlBotoes.Visible := True;
  TbsSkinButtonEx(Sender).ImageList.GetBitmap(
    TbsSkinButtonEx(Sender).ImageIndex,
    fListaMusica.imgCapa.Picture.Bitmap
  );
  fListaMusica.showmodal;
end;

function TfmIndex.FonteExiste(Fonte: STring): Boolean;
begin
  with Screen.Fonts do
    Result := IndexOf(Trim(Fonte)) > 0;
end;

procedure TfmIndex.FormActivate(Sender: TObject);
begin
  //ROTINAS DE INICIALIZAÇÃO NO FORM FMINICANDO....
end;

procedure TfmIndex.tsHinarioNShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsHinarioN,tsHinarioN);
  marcaAbaAberta(tsHinarioN);

  DM.qrALBUM_IGNORAR.Close;
  DM.qrALBUM_IGNORAR.ParamByName('ID').Value := 629;
  DM.qrALBUM_IGNORAR.Open;
  if (DM.qrALBUM_IGNORAR.RecordCount > 0) then
  begin
    pnlHinario1996Ativo.Visible := False;
    pnlHinario1996Inativo.Visible := True;
    pnlHinario1996Inativo.Align := alClient;
  end
  else
  begin
    pnlHinario1996Ativo.Visible := True;
    pnlHinario1996Inativo.Visible := False;

    dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;

    txtHinoNChange(Sender);
    txtHinoN.SetFocus;
  end;
end;

procedure TfmIndex.tsHinarioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsHinario,tsHinario);
  marcaAbaAberta(tsHinario);
  dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;

  txtHinoChange(Sender);
  txtHino.SetFocus;
end;

procedure TfmIndex.tsItensAgendadosShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsItensAgendados,tsItensAgendados);
  marcaAbaAberta(tsItensAgendados);
  carrega_opc := True;

  if (loadCol.Strings.Values['ITENS_AGENDADOS'] <> 'okf') then
  begin
    loadCol.Strings.Values['ITENS_AGENDADOS'] := 'okf';
    cbRemoveItensAgendados.Checked := (lerParam('Itens Agendados', 'RemovePassados', '1') = '1');

    if not DM.cdsCategoriasItensAgendados.Active then
    begin
      DM.cdsCategoriasItensAgendados.CreateDataSet;
      DM.cdsCategoriasItensAgendados.IndexName := '';
      DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
      DM.cdsCategoriasItensAgendados.LogChanges := False;
    end;

    if (FileExists(dir_dados + 'itensAgendadosCategorias.xml')) then
      DM.cdsCategoriasItensAgendados.LoadFromFile(dir_dados + 'itensAgendadosCategorias.xml');
    DM.cdsCategoriasItensAgendados.Open;


    if not DM.cdsItensAgendados.Active then
    begin
      DM.cdsItensAgendados.CreateDataSet;
      DM.cdsItensAgendados.IndexName := '';
      DM.cdsItensAgendados.IndexFieldNames := 'DATA';
      DM.cdsItensAgendados.LogChanges := False;
    end;

    if not DM.cdsItensAgendadosClone.Active then
    begin
      DM.cdsItensAgendadosClone.CreateDataSet;
      DM.cdsItensAgendadosClone.IndexName := '';
      DM.cdsItensAgendadosClone.IndexFieldNames := 'DATA';
      DM.cdsItensAgendadosClone.LogChanges := False;
    end;

    if (FileExists(dir_dados + 'itensAgendados.xml')) then
    begin
      DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
      DM.cdsItensAgendadosClone.LoadFromFile(dir_dados + 'itensAgendados.xml');
    end;
    DM.cdsItensAgendados.Open;
    DM.cdsItensAgendadosClone.Open;

    if cbRemoveItensAgendados.Checked  then removeItensAgendadosPassados;
  end;

  dbctrlCategoriasItensAgendados.RowCount := Trunc(dbctrlCategoriasItensAgendados.ClientHeight / 60);
  dbctrlCategoriasItensAgendados.ColCount := 1;

  carrega_opc := False;
end;

procedure TfmIndex.txtHinoChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
  letra: string;
begin
  pnlreHino.Visible := False;
  bsSkinScrollBar7.Visible := true;
  dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
  valor := trim(txtHino.Text);
  stHinos0.Caption := '';
  if trim(valor) <> '' then
  begin
    val(txtHino.Text, nr, c);
    if c = 0 then
    begin
      stHinos0.Caption := fIniciando.Translate('Buscando nº: ') + valor;
    end
    else
    begin
      stHinos0.Caption := fIniciando.Translate('Buscando nome: ')+'''' + valor + '''';
    end;
  end;

  DM.qrHINOS.Close;
  DM.qrHINOS.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
  DM.qrHINOS.Open;

  if (DM.qrHINOS.RecordCount = 1) then
  begin
    reHino.Lines.Clear;
    DM.qrLETRA.Close;
    DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrHINOS.fieldbyname('ID').AsInteger;
    DM.qrLETRA.Open;
    while not DM.qrLETRA.Eof do
    begin
      letra := '';
      if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
        letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

      letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
      letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
      reHino.Lines.Add(letra);
      DM.qrLETRA.Next;
    end;

    pnlreHino.Height := DBGrid1.Height - stHinos.Height - 22;
    pnlreHino.Top := 0;
    formataTexto(reHino);
    pnlreHino.Visible := true;
    bsSkinScrollBar7.Visible := False;
    dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
  end
  else
  begin
    pnlreHino.Visible := False;
  end;

  corCampoBusca(DM.qrHinos, txtHino, DBGrid1);
  stHinos1.Caption := qtItens(DM.qrHinos,'hino encontrado','hinos encontrados','Nenhum hino encontrado');;
  dbGrid1.Columns[1].Width := dbGrid1.Width - dbGrid1.Columns[0].Width;
end;

procedure TfmIndex.corCampoBusca(Query: TFDQuery; Campo: TbsSkinEdit; DBGrid: TbsSkinDBGrid);
begin
  if DBGrid <> nil then
    DBGrid.VScrollBar.Visible := False;

  if (Query.Active = false) or (Query.RecordCount > 0) then
  begin
    Campo.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_input']);
    if (DBGrid <> nil) and (Query.RecordCount > 1) then
      DBGrid.VScrollBar.Visible := True;
  end
  else
  begin
    Campo.Font.Color := clRed;
  end;
end;

procedure TfmIndex.corCapaProgramaChangeColor(Sender: TObject);
begin
  pnlImagemCapa.Color := TbsSkinColorButton(Sender).ColorValue;
  gravaParam('Config', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;


procedure TfmIndex.corFundoMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;

procedure TfmIndex.corTextoAuxMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto Aux', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;

procedure TfmIndex.corTextoMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;

procedure TfmIndex.corTextoRepetidoChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Texto Repetido', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;

procedure TfmIndex.corTituloMusicaChangeColor(Sender: TObject);
begin
  gravaParam('Musicas', 'Cor Titulo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
end;

function TfmIndex.qtItens(Query: TFDQuery; texto_sing,
  texto_plu,texto_nenh: string): string;
begin
  if Query.Active = false then
    result := texto_nenh
  else if Query.RecordCount > 1 then
//    result := inttostr(Query.RecordCount) +' '+ texto_plu
    result := ''
  else if Query.RecordCount = 1 then
    result := inttostr(Query.RecordCount) +' '+ texto_sing
  else
    result := texto_nenh;
end;

procedure TfmIndex.DBGrid1DblClick(Sender: TObject);
begin
  if (rbHinoTipo.ItemIndex = 0) then btHinoSlideMusicaClick(btHinoSlideMusica)
  else if (rbHinoTipo.ItemIndex = 1) then btHinoSlideMusicaClick(btHinoSlideMusicaPB)
  else if (rbHinoTipo.ItemIndex = 2) then btHinoSlideMusicaClick(btHinoSlideMusicaSA)
  else btHinoSlideMusicaClick(Sender);
end;

procedure TfmIndex.DBGrid1NDblClick(Sender: TObject);
begin
  if (rbHinoTipoN.ItemIndex = 0) then btHinoSlideMusicaNClick(btHinoSlideMusica)
  else if (rbHinoTipoN.ItemIndex = 1) then btHinoSlideMusicaNClick(btHinoSlideMusicaPB)
  else if (rbHinoTipoN.ItemIndex = 2) then btHinoSlideMusicaNClick(btHinoSlideMusicaSA)
  else btHinoSlideMusicaNClick(Sender);
end;

procedure TfmIndex.txtHinoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1DblClick(Sender);
  end;
end;

procedure TfmIndex.txtHinoNChange(Sender: TObject);
var
  valor: string;
  nr: integer;
  c: integer;
  letra: string;
begin
  pnlreHinoN.Visible := False;
  bsSkinScrollBar7N.Visible := true;
  dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
  valor := trim(txtHinoN.Text);
  stHinos0N.Caption := '';
  if trim(valor) <> '' then
  begin
    val(txtHinoN.Text, nr, c);
    if c = 0 then
    begin
      stHinos0N.Caption := fIniciando.Translate('Buscando nº: ') + valor;
    end
    else
    begin
      stHinos0N.Caption := fIniciando.Translate('Buscando nome: ')+'''' + valor + '''';
    end;
  end;

  DM.qrHINOSN.Close;
  DM.qrHINOSN.ParamByName('VALOR').AsString := fmIndex.termo_busca(valor);
  DM.qrHINOSN.Open;

  if (DM.qrHINOSN.RecordCount = 1) then
  begin
    reHinoN.Lines.Clear;
    DM.qrLETRA.Close;
    DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrHINOSN.fieldbyname('ID').AsInteger;
    DM.qrLETRA.Open;
    while not DM.qrLETRA.Eof do
    begin
      letra := '';
      if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
        letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

      letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
      letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
      reHinoN.Lines.Add(letra);
      DM.qrLETRA.Next;
    end;

    pnlreHinoN.Height := DBGrid1N.Height - stHinosN.Height - 22;
    pnlreHinoN.Top := 0;
    formataTexto(reHinoN);
    pnlreHinoN.Visible := true;
    bsSkinScrollBar7N.Visible := False;
    dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
  end
  else
  begin
    pnlreHinoN.Visible := False;
  end;

  corCampoBusca(DM.qrHinosN, txtHinoN, DBGrid1N);
  stHinos1N.Caption := qtItens(DM.qrHinosN,'hino encontrado','hinos encontrados','Nenhum hino encontrado');
  dbGrid1N.Columns[1].Width := dbGrid1N.Width - dbGrid1N.Columns[0].Width;
end;

procedure TfmIndex.txtHinoNKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid1NDblClick(Sender);
  end;
end;

procedure TfmIndex.txtBibLocalizaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btBibLocalizaClick(Sender);
  end;
end;

procedure TfmIndex.abreArquivoMusica(musicaID: Integer; album, url: string);
var
  musica: string;
  lista: TStringList;
begin
  if (url = '') then
  begin
    DM.qrMUSICA.Close;
    DM.qrMUSICA.ParamByName('ID').Value := musicaID;
    DM.qrMUSICA.Open;
    album := DM.qrMUSICA.FieldByName('ALBUM').AsString;
    url := DM.qrMUSICA.FieldByName('URL').AsString;
    DM.qrMUSICA.Close;
  end;
  musica := dir_config+'musicas\'+album+'\'+url;
  if not (FileExists(musica)) then
  begin
    if (application.MessageBox(PChar('Arquivo "'+musica+'" não encontrado! Deseja baixar este arquivo agora?'), fmIndex.titulo, mb_yesno + mb_iconerror) = 6) then
    begin
      lista := TStringList.Create;
      lista.Clear;
      lista.Add('config\musicas\'+album+'\'+url);

      fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
      fAtualiza.arquivos := lista;
      fAtualiza.ShowModal;

      if not (FileExists(musica))
        then application.MessageBox(PChar('Não foi possível baixar o arquivo "'+ExtractFilePath(application.ExeName)+musica+'"!'), fmIndex.titulo, mb_ok + mb_iconerror)
        else fmIndex.abrirArquivo(musica);
    end;
  end
  else
    fmIndex.abrirArquivo(musica);
end;

procedure TfmIndex.abreLetra(ID: integer; BUSCA: string);
begin
  fIniciando.AppCreateForm(TfLetra, fLetra);
  fLetra.id_mus := ID;
  fLetra.txtLocaliz.Text := BUSCA;
  fLetra.txtLocalizChange(nil);
  fLetra.ShowModal;
end;

procedure TfmIndex.abreLetraMusica(tipo: string;param: string;musicaID: Integer;audio:boolean);
var
  monitor,monitor_ret,monitor_ope: integer;
  i: Integer;
begin
  monitor := strtoint(lerParam('Musicas', 'Monitor', '2'));
  monitor_ret := strtoint(lerParam('Musicas', 'MonitorRetorno', '3'));
  monitor_ope := strtoint(lerParam('Musicas', 'MonitorOperador', '1'));

  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if (Screen.MonitorCount < monitor_ret) then
    monitor_ret := 0
  else
    monitor_ret := monitor_ret - 1;

  if (Screen.MonitorCount < monitor_ope) then
    monitor_ope := 0
  else
    monitor_ope := monitor_ope - 1;

  if fMusica <> nil then
    fMusica.Close;

  if fMusicaOperador <> nil then
    fMusicaOperador.Close;

  if fMusicaRetorno <> nil then
    fMusicaRetorno.Close;

  fIniciando.AppCreateForm(TfMusicaOperador, fMusicaOperador);
  fIniciando.AppCreateForm(TfMusicaRetorno, fMusicaRetorno);

  if (lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.lblTempo.Caption := '';
    fMusicaOperador.gSlide.Value := 0;
    fMusicaOperador.gSlideTotal.Value := 0;
    fMusicaOperador.lblSlides.Caption := '';
    fMusicaOperador.pnlProgress.Visible := audio;
    fMusicaOperador.btPausePlay.Visible := audio;
    fMusicaOperador.Show;

    fMusicaOperador.Left := monitorInfo(monitor_ope).Left;
    fMusicaOperador.Top := monitorInfo(monitor_ope).Top;
    fMusicaOperador.Width := monitorInfo(monitor_ope).Width;
    fMusicaOperador.Height := monitorInfo(monitor_ope).Height;
  end;

  if (lerParam('Musicas', 'ModoRetorno', '1') = '1') then
  begin
    fMusicaRetorno.lblTempo.Caption := '';
    fMusicaRetorno.gSlide.Value := 0;
    fMusicaRetorno.gSlideTotal.Value := 0;
    fMusicaRetorno.lblSlides.Caption := '';
    fMusicaRetorno.pnlProgress.Visible := audio;
    fMusicaRetorno.Show;

    fMusicaRetorno.Left := monitorInfo(monitor_ret).Left;
    fMusicaRetorno.Top := monitorInfo(monitor_ret).Top;
    fMusicaRetorno.Width := monitorInfo(monitor_ret).Width;
    fMusicaRetorno.Height := monitorInfo(monitor_ret).Height;
  end;

  fIniciando.AppCreateForm(TfMusica, fMusica);
  fMusica.AlphaBlend := True;
  fMusica.AlphaBlendValue := 0;

  fMusica.tipo := tipo;
  fMusica.param := param;
  fMusica.musicaID := musicaID;
  fMusica.albumID := 0;
  fMusica.audio := audio;
  fMusica.inicio := false;
  fMusica.monitor := monitor;

  if ckMusicaJanela.Checked then
    fMusica.BorderStyle := bsNone
  else
    fMusica.BorderStyle := bsSizeable;

  fMusica.show;


  if (pnlModDes.Visible) then
  begin
    fMusica.Left := StrToInt(lerParam('Desenvolvedor', 'SlideLeft', IntToStr(monitorInfo(monitor).Left)));
    fMusica.Top := StrToInt(lerParam('Desenvolvedor', 'SlideTop', IntToStr(monitorInfo(monitor).Top)));
    fMusica.Width := StrToInt(lerParam('Desenvolvedor', 'SlideWidth', IntToStr(monitorInfo(monitor).Width)));
    fMusica.Height := StrToInt(lerParam('Desenvolvedor', 'SlideHeight', IntToStr(monitorInfo(monitor).Height)));
  end
  else
  begin
    if (fMusica.BorderStyle = bsNone) then
    begin
      fMusica.Left := monitorInfo(monitor).Left;
      fMusica.Top := monitorInfo(monitor).Top;
      fMusica.Width := monitorInfo(monitor).Width;
      fMusica.Height := monitorInfo(monitor).Height;
    end
    else
    begin
      fMusica.Left := monitorInfo(monitor).Left;
      fMusica.Top := monitorInfo(monitor).Top;
      fMusica.Width := 800;
      fMusica.Height := 600;
    end;
  end;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fMusica.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fMusica.AlphaBlendValue := 255;
end;

procedure TfmIndex.abreLetraMusicaAlbum(albumID: Integer;musicaID: Integer);
var
  monitor: integer;
  i: integer;
begin
  monitor := strtoint(lerParam('Musicas', 'Monitor', '2'));
  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if fMusica <> nil then
    fMusica.Close;


  if fMusicaOperador <> nil then
    fMusicaOperador.Close;

  fIniciando.AppCreateForm(TfMusicaOperador, fMusicaOperador);

  if (lerParam('Musicas', 'ModoOperador', '1') = '1') then
  begin
    fMusicaOperador.pnlErroMsg.Visible := false;
    fMusicaOperador.lblTempo.Caption := '';
    fMusicaOperador.gSlide.Value := 0;
    fMusicaOperador.gSlideTotal.Value := 0;
    fMusicaOperador.lblSlides.Caption := '';
    fMusicaOperador.pnlProgress.Visible := true;
    fMusicaOperador.btPausePlay.Visible := true;
    fMusicaOperador.Show;
  end;

  fIniciando.AppCreateForm(TfMusica, fMusica);
  fMusica.AlphaBlend := True;
  fMusica.AlphaBlendValue := 0;

  fMusica.musicaID := musicaID;
  fMusica.albumID := albumID;
  fMusica.tipo := 'BD';
  fMusica.audio := true;
  fMusica.inicio := false;
  fMusica.monitor := monitor;

  if ckMusicaJanela.Checked then
    fMusica.BorderStyle := bsNone
  else
    fMusica.BorderStyle := bsSizeable;

  fMusica.show;


  if pnlModDes.Visible then
  begin
    fMusica.Left := StrToInt(lerParam('Desenvolvedor', 'SlideLeft', IntToStr(monitorInfo(monitor).Left)));
    fMusica.Top := StrToInt(lerParam('Desenvolvedor', 'SlideTop', IntToStr(monitorInfo(monitor).Top)));
    fMusica.Width := StrToInt(lerParam('Desenvolvedor', 'SlideWidth', IntToStr(monitorInfo(monitor).Width)));
    fMusica.Height := StrToInt(lerParam('Desenvolvedor', 'SlideHeight', IntToStr(monitorInfo(monitor).Height)));
  end
  else
  begin
    fMusica.Left := monitorInfo(monitor).Left;
    fMusica.Top := monitorInfo(monitor).Top;
    fMusica.Width := monitorInfo(monitor).Width;
    fMusica.Height := monitorInfo(monitor).Height;
  end;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fMusica.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fMusica.AlphaBlendValue := 255;
end;

procedure TfmIndex.abrePagina(TabSheet: TbsSkinTabSheet);
var
  item: TMenuItem;
begin
  PageControl1.Visible := True;
  TabSheet.Tag := -1;
  if TabSheet.TabVisible = False then
  begin
    TabSheet.TabVisible := True;
    PageControl1.ActivePage := TabSheet;
    PageControl1.Pages[PageControl1.ActivePageIndex].PageIndex := PageControl1.PageCount - 1;

    item := TMenuItem.Create(bsPopupMenuRibon);
    item.Caption := TabSheet.Caption;
    item.ImageIndex := TabSheet.ImageIndex;
    item.OnClick := mnSelecionaAbaClick;
    item.Checked := False;
    item.RadioItem := True;

    bsPopupMenuRibon.Items.Insert(bsPopupMenuRibon.Items.Count - 3, item);
  end
  else
    PageControl1.ActivePage := TabSheet;

  confereAbasAbertas();
  marcaAbaAberta(TabSheet);
end;

procedure TfmIndex.abreVideoOn(videoID, videoTITULO: string);
var
  monitor: integer;
  Flags: Cardinal;
  i: integer;
begin
  if not InternetGetConnectedState(@Flags, 0) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  if (trim(param.Strings.Values['embed_youtube']) = '') then
  begin
    gravaParam('Config', 'UltimaConexao', '-');
    carregaParams;
  end;

  monitor := strtoint(lerParam('Videos Online', 'Monitor', '2'));
  if (Screen.MonitorCount < monitor) then
    monitor := 0
  else
    monitor := monitor - 1;

  if fVideoOn <> nil then
    fVideoOn.Close;

  fIniciando.AppCreateForm(TfVideoOn, fVideoOn);
  fVideoOn.videoID := videoID;
  fVideoOn.Caption := videoTITULO;

  if ckVideoOnJanela.Checked then
    fVideoOn.BorderStyle := bsNone
  else
    fVideoOn.BorderStyle := bsSizeable;

  fVideoOn.AlphaBlend := True;
  fVideoOn.AlphaBlendValue := 0;
  fVideoOn.show;

  fVideoOn.Left := monitorInfo(monitor).Left;
  fVideoOn.Top := monitorInfo(monitor).Top;
  fVideoOn.Width := monitorInfo(monitor).Width;
  fVideoOn.Height := monitorInfo(monitor).Height;


  if ckFadeForm.Checked then
  begin
    for i := 0 to 255 do
    begin
      fVideoOn.AlphaBlendValue := i;
      sleep(1);
    end;
  end
  else fVideoOn.AlphaBlendValue := 255;

end;

procedure TfmIndex.abrirArquivo(url: string;externo: Boolean);
var
  ext: string;
begin
  if url <> '' then
  begin
    gravaLog('Abrindo arquivo: '+url);
    ext := (ExtractFileExt(url));
    if externo
      then ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE)
    else if (ext = '.slja') or (ext = '.lja')
      then processaArquivo(url)
    else if (ckPlayerAudio.Checked)
      and ((ext = '.mp3') or (ext = '.wma') or (ext = '.wav')) then
    begin
      player(url,false);
    end
    else if (ckPlayerVideo.Checked)
      and ((ext = '.mp4') or (ext = '.avi') or (ext = '.wmv') or (ext = '.mkv')) then
    begin
      player(url);
    end
    else
      ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
  end;
end;

procedure TfmIndex.AbrirnoNavegador1Click(Sender: TObject);
var
  txt: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  txt := DM.cdsVideosOnPerso.FieldByName('URL').AsString;
  HlinkNavigateString(nil, PChar(txt));
end;

procedure TfmIndex.ajustaImagem(imagem: TImage; panel: TPanel;
  posicao: integer);
var
  w,h: integer;
begin
  w := imagem.Picture.Width;
  h := imagem.Picture.Height;

  imagem.Width := panel.Width;
  imagem.Height := Trunc(imagem.Width*h/w);

  if (imagem.Height < panel.Height) then
  begin
    imagem.Height := panel.Height;
    imagem.Width := Trunc(imagem.Height*w/h);
  end;

  case posicao of
    1: begin
         imagem.Top := 0;
         imagem.Left := 0;
       end;
    2: begin
         imagem.Top := 0;
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    3: begin
         imagem.Top := 0;
         imagem.Left := (panel.Width-imagem.Width);
       end;
    4: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := 0;
       end;
    5: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    6: begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := (panel.Width-imagem.Width);
       end;
    7: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := 0;
       end;
    8: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
       end;
    9: begin
         imagem.Top := (panel.Height-imagem.Height);
         imagem.Left := (panel.Width-imagem.Width);
       end;
    else
      begin
         imagem.Top := Trunc((panel.Height-imagem.Height)/2);
         imagem.Left := Trunc((panel.Width-imagem.Width)/2);
      end;
  end;
end;

procedure TfmIndex.AjustaLarguraCamposDBGrid(DBGrid: TbsSkinDbGrid);
var
  i: integer;
begin
  for i := 0 to DBGrid.Columns.Count - 1 do
    DBGrid.Columns[i].Width := 5 + DBGrid.Canvas.TextWidth(DBGrid.Columns[i].title.caption)
end;

procedure TfmIndex.tsJAShow(Sender: TObject);
var
  i: Integer;
begin
  PaginaMenuAtiva(bsColetaneas);
  marcaAbaAberta(tsJA);
  if (loadCol.Strings.Values['JA'] <> 'ok') then
  begin
    loadCol.Strings.Values['JA'] := 'ok';

    for i := sbColJA.ComponentCount - 1 downto 0 do
      sbColJA.Components[i].Free;

    fExibeColetaneas('JA_ANO', sbColJA);
  end;
end;

procedure TfmIndex.tsLiturgiaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsLiturgia,tsLiturgia);
  marcaAbaAberta(tsLiturgia);

  if (loadCol.Strings.Values['LITURGIA'] <> 'okf') then
  begin
    loadCol.Strings.Values['LITURGIA'] := 'okf';

    cbMarcarConc.Checked := (lerParam('Liturgia', 'MarcarConcluido', '1') = '1');
    cbBloqItens.Checked := (lerParam('Liturgia', 'BloquearItens', '0') = '1');
    cbAnotacoesLiturgia.Checked := (lerParam('Liturgia', 'ExibirAnotacoes', '1') = '1');

//    LiturgiaCalendarClick(nil); //ESTÁ DENTRO DE BLOQUEAR ITENS
  end;
end;

procedure TfmIndex.tsMusicasInfantisShow(Sender: TObject);
begin
  marcaAbaAberta(tsMusicasInfantis);
  carrega_opc := True;

  if (loadCol.Strings.Values['INFANTIS'] <> 'okf') then
  begin
    loadCol.Strings.Values['INFANTIS'] := 'okf';

    DM.qrMUSICAS_INFANTIS.Close;
    DM.qrMUSICAS_INFANTIS.Open;
  end;

  dbctrlMusicasInfantis.RowCount := Trunc(dbctrlMusicasInfantis.ClientHeight / 60);
  dbctrlMusicasInfantis.ColCount := Trunc(dbctrlMusicasInfantis.ClientWidth / 350);

  carrega_opc := False;
end;

procedure TfmIndex.tsColetaneasOnlinePersoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfigColetaneasOnlinePerso,tsColetaneasOnlinePerso);
  marcaAbaAberta(tsColetaneasOnlinePerso);
  dbGrid4.Columns[1].Width := dbGrid4.Width - dbGrid4.Columns[0].Width;
  carrega_opc := True;

  if (loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] <> 'okf') then
  begin
    loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] := 'okf';
    bsSkinScrollBar24.Visible := True;

    if not DM.cdsVideosOnPerso.Active then
    begin
      DM.cdsVideosOnPerso.CreateDataSet;
      DM.cdsVideosOnPerso.IndexName := '';
      DM.cdsVideosOnPerso.IndexFieldNames := 'NOME';
      DM.cdsVideosOnPerso.LogChanges := False;
    end;

    if (FileExists(dir_dados + 'videosOnUsuario.xml')) then
      DM.cdsVideosOnPerso.LoadFromFile(dir_dados + 'videosOnUsuario.xml');
    DM.cdsVideosOnPerso.Open;

    if (DM.cdsVideosOnPerso.RecordCount <= 1) then
    begin
      bsSkinScrollBar24.Visible := False;
      dbGrid4.Columns[1].Width := dbGrid4.Width - dbGrid4.Columns[0].Width;
    end;

    btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
    btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));


    stVideosOnPerso_1.caption := qtItens(TFDQuery(DM.cdsVideosOnPerso),'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsColetaneasOnlineShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfigColetaneasOnline,tsColetaneasOnline);
  marcaAbaAberta(tsColetaneasOnline);
  carrega_opc := True;

  if (loadCol.Strings.Values['COLETANEAS_ONL'] <> 'okf') then
  begin
    loadCol.Strings.Values['COLETANEAS_ONL'] := 'okf';

    DM.qrONL_CANAIS.Close;
    DM.qrONL_CANAIS.Open;
    if DM.qrONL_CANAIS.RecordCount <= 0 then
      atualiza_coletaneas_web('canais')
    else
      lista_coletaneas_web('canais');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsDiversasShow(Sender: TObject);
var
  i: integer;
begin
  PaginaMenuAtiva(bsColetaneas);
  marcaAbaAberta(tsDiversas);
  if (loadCol.Strings.Values['DIV'] <> 'ok') then
  begin
    loadCol.Strings.Values['DIV'] := 'ok';

    for i := sbColDIV.ComponentCount - 1 downto 0 do
      sbColDIV.Components[i].Free;

    fExibeColetaneas('DIV', sbColDIV);
  end;
end;

procedure TfmIndex.tsDoxologiaShow(Sender: TObject);
var
  Jpg: TJPEGImage;
  bmp: TBitmap;
  i: integer;
  dir: string;
begin
  marcaAbaAberta(tsDoxologia);
  carrega_opc := True;

  if (loadCol.Strings.Values['DOXOLOGIA'] <> 'okf') then
  begin
    loadCol.Strings.Values['DOXOLOGIA'] := 'okf';

    DM.qrDOXOLOGIA_CATE.Close;
    DM.qrDOXOLOGIA_CATE.Open;
    bgDoxologiaCate.Items.Clear;
    bgDoxologiaCate.ItemIndex := -1;
    lbbgDoxologiaCate.Items.Clear;
    pnlDoxologiaMusicas.Visible := False;
    DM.ico_doxologia.Clear;
    while not DM.qrDOXOLOGIA_CATE.eof do
    begin
      dir := dir_config + 'capas\';
      bgDoxologiaCate.Items.Add.Caption := DM.qrDOXOLOGIA_CATE.FieldByName('NOME').AsString;
      lbbgDoxologiaCate.Items.Add(DM.qrDOXOLOGIA_CATE.FieldByName('ID').AsString);
      i := bgDoxologiaCate.Items.Count - 1;

      Jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      if FileExists(dir + DM.qrDOXOLOGIA_CATE.FieldByName('IMAGEM').AsString) then
        Jpg.LoadFromFile(dir + DM.qrDOXOLOGIA_CATE.FieldByName('IMAGEM').AsString);
      bmp.Assign(Jpg);
      bmp.Height := 88;
      bmp.Width := 88;
      DM.ico_doxologia.Add(bmp, nil);

      bgDoxologiaCate.Items[i].ImageIndex := i;

      DM.qrDOXOLOGIA_CATE.Next;
    end;
  end;

  if (loadCol.Strings.Values['DOXOLOGIA_MUSICAS'] <> 'ok') then
  begin
    dbctrlDoxologiaMusicas.RowCount := Trunc(dbctrlDoxologiaMusicas.ClientHeight / 60);
    dbctrlDoxologiaMusicas.ColCount := Trunc(dbctrlDoxologiaMusicas.ClientWidth / 350);
  end;
  carrega_opc := False;
end;

procedure TfmIndex.ApplicationActivate(Sender: TObject);
begin
  focoAplicacao(true);
end;

procedure TfmIndex.ApplicationDeactivate(Sender: TObject);
begin
  focoAplicacao(false);
end;

function TfmIndex.arquivoCodificado(arq: string): TStringList;
var
  fileStream: TFileStream;
  utf8Stream: TStringStream;
  lista: TStringList;
begin
  lista := TStringList.Create;

  try
    fileStream := TFileStream.Create(arq, fmOpenRead);
    try
      utf8Stream := TStringStream.Create('', TEncoding.UTF8);
      try
        try
          utf8Stream.CopyFrom(fileStream, 0);
          lista.Text := utf8Stream.DataString;
        except
          // Se ocorrer uma exceção durante a conversão para UTF-8, carregue o arquivo sem a conversão
          fileStream.Position := 0; // Volte ao início do arquivo
          lista.LoadFromStream(fileStream);
        end;
      finally
        utf8Stream.Free;
      end;
    finally
      fileStream.Free;
    end;
  except
    lista.LoadFromStream(fileStream);
  end;

  Result := lista;
end;

procedure TfmIndex.aSort(var Vetor: array of Integer);
var
  i, temp: Integer;
  changed: Boolean;
begin
  changed := True;

  while changed do
  begin
    changed := False;
    for i := Low(Vetor) to High(Vetor)-1 do
    begin
      if (Vetor[i] > Vetor[i+1]) then // Para ordem crescente altere o sinal para ">" nesta linha
      begin
        temp := Vetor[i+1];
        Vetor[i+1] := Vetor[i];
        Vetor[i] := temp;
        changed := True;
      end;
    end;
  end;
end;

procedure TfmIndex.atualizaIgnoreAlbum;
var
  ids: string;
begin
  if lerParam('Config','IgnorarAlbumHASD1996','1') = '1' then
  begin
    ids := lerParam('Config','IgnorarAlbuns','');
    if ids <> '' then ids := ids+',';
    ids := ids+'629';
    gravaParam('Config','IgnorarAlbuns',ids);
  end;

  DM.qrDEL_ALBUM_IGNORAR.ExecSQL;
  if lerParam('Config','IgnorarAlbuns','0') <> '0' then
  begin
    DM.qrADD_ALBUM_IGNORAR.SQL.Clear;
    DM.qrADD_ALBUM_IGNORAR.SQL.Add('INSERT INTO _ALBUM_IGNORAR (ID) SELECT ID FROM ALBUM WHERE ID IN (0'+lerParam('Config','IgnorarAlbuns','0')+')');
    DM.qrADD_ALBUM_IGNORAR.ExecSQL;
  end;

  if lerParam('Config','IgnorarAlbumHASD1996','1') = '1' then
  begin
    gravaParam('Config','IgnorarAlbumHASD1996','0');
    DM.qrALBUM_ATIV.Close;
    DM.qrALBUM_ATIV.Open;
    DM.qrALBUM_INATIV.Close;
    DM.qrALBUM_INATIV.Open;
  end;
end;

procedure TfmIndex.atualiza_coletaneas_web(p: string; id: string);
var
  Flags: Cardinal;
  url_conexao: string;
  txt: TStringList;
  sql: string;
  i: integer;
  dir: string;
  QUERY: TFDQuery;
begin
  if not InternetGetConnectedState(@Flags, 0) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  DM.progressDialog.Caption := 'Coletânea JA';
  DM.progressDialog.LabelCaption := 'Atualizando... Aguarde...';
  DM.progressDialog.Value := 0;
  DM.progressDialog.MaxValue := 100;
  DM.progressDialog.Execute;

  url_conexao := Trim(param.Strings.Values['coletaneas_online']);
  if (url_conexao = '') then
  begin
    gravaParam('Config', 'UltimaConexao', '-');
    carregaParams;
  end;

  url_conexao := Trim(param.Strings.Values['coletaneas_online']);
  if (url_conexao = '') then
  begin
    application.messagebox(PChar('Não foi possível atualizar coletâneas on-line! Algum firewall ou antivírus pode estar impedidno o programa de se conectar a internet!'), TITULO, MB_OK + mb_iconerror);
    DM.progressDialog.MaxValue := 1;
    DM.progressDialog.Value := DM.progressDialog.MaxValue;
    DM.progressDialog.Close;
    Exit;
  end;

  DM.progressDialog.MaxValue := 100;
  DM.progressDialog.Value := 20;

  txt := TStringList.Create;

  try
    sql := DM.IdHTTP1.Get(url_conexao + '?tipo=' + p + '&id=' + id + '&atualiza_playlist=1&lang=' + fIniciando.LANG);
  except
    try
      url_conexao := StringReplace(url_conexao, 'https://', 'http://', [rfIgnoreCase, rfReplaceAll]);
      sql := DM.IdHTTP1.Get(url_conexao + '?tipo=' + p + '&id=' + id + '&atualiza_playlist=1');
    except
      application.messagebox(PChar('O sistema não conseguiu se conectar ao servidor! Tente novamente mais tarde.'), TITULO, MB_OK + mb_iconerror);
      DM.progressDialog.MaxValue := 1;
      DM.progressDialog.Value := DM.progressDialog.MaxValue;
      DM.progressDialog.Close;
      Exit;
    end;
  end;

  DM.progressDialog.MaxValue := 100;
  DM.progressDialog.Value := 40;
  ExtractStrings(['|'], [], PChar(sql), txt);
  try
    for i := 0 to txt.Count - 1 do
    begin
      if Trim(txt[i]) <> '' then
      begin
        DM.ADOQuery.SQL.Text := txt[i];
        DM.ADOQuery.ExecSQL;
      end;
    end;
  except
    application.messagebox(PChar('Houve um erro ao tentar atualizar! Tente novamente mais tarde.'), TITULO, MB_OK + mb_iconerror);
    DM.progressDialog.MaxValue := 1;
    DM.progressDialog.Value := DM.progressDialog.MaxValue;
    DM.progressDialog.Close;
    Exit;
  end;

  DM.progressDialog.MaxValue := 100;
  DM.progressDialog.Value := 60;

  if (p = 'canais') or (p = 'tudo') then
  begin
    //BAIXA IMAGENS
    DM.qrONL_CANAIS.Close;
    DM.qrONL_CANAIS.Open;

    dir := dir_config + 'imagens_onl\canais';
    if not (DirectoryExists(dir)) then
      forceDirectories(dir);

    while not DM.qrONL_CANAIS.eof do
    begin
      DownloadArquivo(DM.qrONL_CANAIS.FieldByName('IMAGEM').AsString, dir + '\' + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg');
      DM.qrONL_CANAIS.Next;
    end;

    if (p = 'canais') then
      application.messagebox(PChar('Canais atualizados com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  end;
  if (p = 'playlists') or (p = 'tudo') then
  begin
    //BAIXA IMAGENS
    if (p = 'tudo') then
    begin
      DM.qrONL_PLAYLISTS_TUDO.Close;
      DM.qrONL_PLAYLISTS_TUDO.Open;
      QUERY := DM.qrONL_PLAYLISTS_TUDO;
    end
    else
    begin
      DM.qrONL_PLAYLISTS.Close;
      DM.qrONL_PLAYLISTS.ParamByName('CANAL_ID').Value := id;
      DM.qrONL_PLAYLISTS.Open;
      QUERY := DM.qrONL_PLAYLISTS;
    end;

    dir := dir_config + 'imagens_onl\playlists';
    if not (DirectoryExists(dir)) then
      forceDirectories(dir);

    while not QUERY.eof do
    begin
      DownloadArquivo(QUERY.FieldByName('IMAGEM').AsString, dir + '\' + QUERY.FieldByName('PLAYLIST_ID').AsString + '.jpg');
      QUERY.Next;
    end;

    if (p = 'playlists') then
      application.messagebox(PChar('Listas de Reprodução atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  end;
  if (p = 'videos') or (p = 'tudo') then
  begin
    //BAIXA IMAGENS
    if (p = 'tudo') then
    begin
      DM.qrONL_VIDEOS_TUDO.Close;
      DM.qrONL_VIDEOS_TUDO.Open;
      QUERY := DM.qrONL_VIDEOS_TUDO;
    end
    else
    begin
      DM.qrONL_VIDEOS.Close;
      DM.qrONL_VIDEOS.ParamByName('PLAYLIST_ID').Value := id;
      DM.qrONL_VIDEOS.Open;
      QUERY := DM.qrONL_VIDEOS;
    end;

    dir := dir_config + 'imagens_onl\videos';
    if not (DirectoryExists(dir)) then
      forceDirectories(dir);

    while not QUERY.eof do
    begin
      DownloadArquivo(QUERY.FieldByName('IMAGEM').AsString, dir + '\' + QUERY.FieldByName('VIDEO_ID').AsString + '.jpg');
      QUERY.Next;
    end;

    if (p = 'videos') then
      application.messagebox(PChar('Vídeos atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);
  end;

  if (p = 'tudo') then
    application.messagebox(PChar('Vídeos atualizadas com sucesso!'), TITULO, MB_OK + mb_iconinformation);

  DM.progressDialog.MaxValue := 1;
  DM.progressDialog.Value := DM.progressDialog.MaxValue;
  DM.progressDialog.Close;

  if (p = 'tudo') then
    p := 'canais';

  lista_coletaneas_web(p, id);
end;

procedure TfmIndex.bgDoxologiaCateButtonClicked(Sender: TObject;
  Index: Integer);
begin
  DM.qrMUSICAS.Close;
  DM.qrMUSICAS.ParamByName('ID_ALBUM').Value := lbbgDoxologiaCate.Items[Index];
  DM.qrMUSICAS.Open;
  lblDoxologiaCate.Caption := bgDoxologiaCate.Items[Index].Caption;
  pnlDoxologiaMusicas.Visible := True;

  imgDoxologiaCate.Picture.Bitmap:= nil;
  DM.ico_doxologia.GetBitmap(Index, imgDoxologiaCate.Picture.Bitmap);
  dbctrlDoxologiaMusicas.Visible := (DM.qrMUSICAS.RecordCount > 0);

  loadCol.Strings.Values['DOXOLOGIA_MUSICAS'] := '';
  tsDoxologiaShow(Sender);
end;

procedure TfmIndex.bgOnlCanaisButtonClicked(Sender: TObject; Index: Integer);
begin
  bgOnlPlaylists.Items.Clear;
  pnlOnlPlaylists.Visible := True;

  DM.qrONL_PLAYLISTS.Close;
  DM.qrONL_PLAYLISTS.ParamByName('CANAL_ID').Value := lbbgOnlCanais.Items[Index];
  DM.qrONL_PLAYLISTS.Open;
  if DM.qrONL_PLAYLISTS.RecordCount <= 0 then
    atualiza_coletaneas_web('playlists', lbbgOnlCanais.Items[Index])
  else
    lista_coletaneas_web('playlists', lbbgOnlCanais.Items[Index]);
end;

procedure TfmIndex.bgOnlPlaylistsButtonClicked(Sender: TObject; Index: Integer);
begin
  bgOnlVideos.Items.Clear;
  pnlOnlVideos.Visible := True;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;

  DM.qrONL_VIDEOS.Close;
  DM.qrONL_VIDEOS.ParamByName('PLAYLIST_ID').Value := lbbgOnlPlaylists.Items[Index];
  DM.qrONL_VIDEOS.Open;
  if DM.qrONL_VIDEOS.RecordCount <= 0 then
    atualiza_coletaneas_web('videos', lbbgOnlPlaylists.Items[Index])
  else
    lista_coletaneas_web('videos', lbbgOnlPlaylists.Items[Index]);
end;

procedure TfmIndex.bgOnlVideosButtonClicked(Sender: TObject; Index: Integer);
begin
  abreVideoOn(lbbgOnlVideos.Items[Index], bgOnlVideos.Items[Index].Caption);
end;

procedure TfmIndex.tsBuscaMusicaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsBuscaMusica,tsBuscaMusica);
  marcaAbaAberta(tsBuscaMusica);
  carrega_opc := true;
  dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;

  loadCol.Strings.Values['BUSCA:CARREGADO'] := 'N';
  if (loadCol.Strings.Values['BUSCA'] <> 'okf') then
  begin
//    loadCol.Strings.Values['BUSCA'] := 'okf';
    txtBusca.Text := '';
    DM.tmrBusca.Enabled := False;

    ckgFiltros.ItemChecked[0] := (lerParam('Busca', 'Filtro 1', '1') = '1');
    ckgFiltros.ItemChecked[1] := (lerParam('Busca', 'Filtro 2', '0') = '1');
    ckgFiltros.ItemChecked[2] := (lerParam('Busca', 'Filtro 3', '0') = '1');

    ckgColetaneas.ItemChecked[0] := (lerParam('Busca', 'Baixadas', '1') = '1');
    ckgColetaneas.ItemChecked[1] := (lerParam('Busca', 'Web', '0') = '1');
    ckgColetaneas.ItemChecked[2] := (lerParam('Busca', 'Personalizadas', '0') = '1');

//    ckgIdiomas.ItemChecked[0] := True;
//    ckgIdiomas.ItemChecked[1] := True;
//    ckgIdiomas.ItemChecked[2] := True;
    DM.tmrBusca.Enabled := False;

//    buscaMusicas;
  end;
  loadCol.Strings.Values['BUSCA:CARREGADO'] := 'S';
  txtBusca.SetFocus;
  carrega_opc := false;
  DM.tmrBusca.Enabled := False;

  if (loadCol.Strings.Values['BUSCA'] <> 'okf') then
  begin
    loadCol.Strings.Values['BUSCA'] := 'okf';
    buscaMusicas;
  end;
end;

procedure TfmIndex.txtAbrirColet2Enter(Sender: TObject);
begin
  txtAbrirColet2.Text := verificaURL(txtAbrirColet2.Text, txtUrlInfoColet2, true);
end;

procedure TfmIndex.txtAbrirColet2Exit(Sender: TObject);
begin
  if trim(txtColetanea2.Text) = '' then
    txtColetanea2.Text := ChangeFileExt(ExtractFileName(txtAbrirColet2.Text), '');
  txtAbrirColet2.Text := verificaURL(txtAbrirColet2.Text, txtUrlInfoColet2);
end;

procedure TfmIndex.txtAbrirColetEnter(Sender: TObject);
begin
  txtAbrirColet.Text := verificaURL(txtAbrirColet.Text, txtUrlInfoColet, true);
end;

procedure TfmIndex.txtAbrirColetExit(Sender: TObject);
begin
  if trim(txtColetanea.Text) = '' then
    txtColetanea.Text := ChangeFileExt(ExtractFileName(txtAbrirColet.Text), '');
  txtAbrirColet.Text := verificaURL(txtAbrirColet.Text, txtUrlInfoColet);
end;

procedure TfmIndex.txtBuscaChange(Sender: TObject);
begin
  if carrega_opc then exit;

  if ckgFiltros.ItemChecked[1] then
  begin
    DM.tmrBusca.Enabled := False;
    DM.tmrBusca.Enabled := True;
  end
  else buscaMusicas();
end;

procedure TfmIndex.txtBuscaColetPesoChange(Sender: TObject);
begin
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.DBGrid2CellClick(Column: TbsColumn);
begin
  if (DM.qrBUSCA.Active = false) then Exit;
  if (DM.qrBUSCA.RecordCount <= 0) then Exit;

  btExportarMusica.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');

  btMusicaSlideMusicaPB.Enabled := (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '');
  btMusicaAudioMusicaPB.Enabled := (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '');
  btMusicaSlideMusicaSA.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
  btMusicaAudioMusica.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
  btMusicaLetra.Enabled := not(DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and not(DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S');
end;

procedure TfmIndex.DBGrid2DblClick(Sender: TObject);
begin
  btMusicaSlideMusicaClick(Sender);
end;

procedure TfmIndex.DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
var
  icon: TPngImage;
  fixRect: TRect;
begin
  Canvas.Brush.Style := bsClear;
  if (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') and (Column.FieldName = 'ICONE1') then
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
  if (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') and (Column.FieldName = 'ICONE1') then
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
  if (DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString <> '') and (Column.FieldName = 'ICONE2') then
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

procedure TfmIndex.DBGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DBGrid2CellClick(nil);
end;

procedure TfmIndex.DBGrid4DblClick(Sender: TObject);
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  abreVideoOn(DM.cdsVideosOnPerso.FieldByName('VIDEOID').AsString, DM.cdsVideosOnPerso.fieldbyname('NOME').AsString);
end;

procedure TfmIndex.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TbsColumn; State: TGridDrawState);
var
  w: Integer;
begin
  w := 10 + TbsSkinDBGrid(Sender).Canvas.TextExtent(Column.Field.DisplayText).cx;
  if w > Column.Width then
    Column.Width := w;
end;

procedure TfmIndex.txtBuscaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    DBGrid2DblClick(Sender);
  end;
end;

function TfmIndex.RemoveAcento(Str: string): string;
const
  ComAcento = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  SemAcento = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
var
   x: Integer;
begin;
  for x := 1 to Length(Str) do
  if Pos(Str[x],ComAcento) <> 0 then
    Str[x] := SemAcento[Pos(Str[x], ComAcento)];
  Result := Str;
end;

procedure TfmIndex.removeItensAgendadosPassados;
var
  filter: string;
begin
  DM.cdsItensAgendados.Filtered := true;
  filter := DM.cdsItensAgendados.Filter;
  DM.cdsItensAgendados.Filter := 'DATA < '''+formatdatetime('dd/mm/yyyy',now())+'''';
  DM.cdsItensAgendados.First;
  while not DM.cdsItensAgendados.eof do
  begin
    DM.cdsItensAgendados.Delete;
    DM.cdsItensAgendados.First;
//    DM.cdsItensAgendados.Next;
  end;
  DM.cdsItensAgendados.Filter := filter;
end;


function TfmIndex.RemoveTags(const s: string): string;
var
  i: Integer;
  InTag: Boolean;
begin
  Result := '';
  InTag := False;
  for i := 1 to Length(s) do
  begin
    if s[i] = '<' then
      InTag := True
    else if s[i] = '>' then
      InTag := False
    else if not InTag then
      Result := Result + s[i];
  end;
end;

function TfmIndex.removeTagsHTML(texto: string): string;
begin
  result := TRegEx.Replace(texto, '<[^>]+>', '');
end;

procedure TfmIndex.RichEditChange(Sender: TObject);
begin
  copiaDadosTelaExtendida;
  RichEditEnter(Sender);
end;

procedure TfmIndex.RichEditEnter(Sender: TObject);
var
  tag: Integer;
  RichEdit: TbsSkinRichEdit;
  fcTxtI:  TbsSkinFontComboBox;
  seTxtITamanho: TbsSkinComboBox;
  btfsBold: TbsSkinSpeedButton;
  btfsItalic: TbsSkinSpeedButton;
  btfsUnderline: TbsSkinSpeedButton;
  btfsStrikeOut: TbsSkinSpeedButton;
  cbColorFTxtI: TbsSkinColorButton;
  cbColorTxtI: TbsSkinColorButton;
  bttaLeftJustify: TbsSkinSpeedButton;
  bttaCenter: TbsSkinSpeedButton;
  bttaRightJustify: TbsSkinSpeedButton;
begin
  if carrega_opc = True then
    Exit;

  RichEdit := TbsSkinRichEdit(Sender);
  tag := RichEdit.Tag;

  fcTxtI := TbsSkinFontComboBox(FindComponent('fcTxtI'+inttostr(tag)));
  if (Assigned(fcTxtI))
    then fcTxtI.FontName := RichEdit.SelAttributes.Name;

  seTxtITamanho := TbsSkinComboBox(FindComponent('seTxtITamanho'+inttostr(tag)));
  if (Assigned(seTxtITamanho))
    then seTxtITamanho.Text := IntToStr(RichEdit.SelAttributes.Size);

  btfsBold := TbsSkinSpeedButton(FindComponent('btfsBold'+inttostr(tag)));
  if (Assigned(btfsBold)) then
  begin
    if RichEdit.SelAttributes.Style - [fsItalic] - [fsUnderline] - [fsStrikeOut] = [fsBold] then
      btfsBold.Down := true
    else
      btfsBold.Down := false;
  end;

  btfsItalic := TbsSkinSpeedButton(FindComponent('btfsItalic'+inttostr(tag)));
  if (Assigned(btfsItalic)) then
  begin
    if RichEdit.SelAttributes.Style - [fsBold] - [fsUnderline] - [fsStrikeOut] = [fsItalic] then
      btfsItalic.Down := true
    else
      btfsItalic.Down := false;
  end;

  btfsUnderline := TbsSkinSpeedButton(FindComponent('btfsUnderline'+inttostr(tag)));
  if (Assigned(btfsUnderline)) then
  begin
    if RichEdit.SelAttributes.Style - [fsItalic] - [fsBold] - [fsStrikeOut] = [fsUnderline] then
      btfsUnderline.Down := true
    else
      btfsUnderline.Down := false;
  end;

  btfsStrikeOut := TbsSkinSpeedButton(FindComponent('btfsStrikeOut'+inttostr(tag)));
  if (Assigned(btfsStrikeOut)) then
  begin
    if RichEdit.SelAttributes.Style - [fsItalic] - [fsUnderline] - [fsBold] = [fsStrikeOut] then
      btfsStrikeOut.Down := true
    else
      btfsStrikeOut.Down := false;
  end;

  cbColorFTxtI := TbsSkinColorButton(FindComponent('cbColorFTxtI'+inttostr(tag)));
  if (Assigned(cbColorFTxtI))
    then cbColorFTxtI.ColorValue := RichEdit.Color;

  cbColorTxtI := TbsSkinColorButton(FindComponent('cbColorTxtI'+inttostr(tag)));
  if (Assigned(cbColorTxtI))
    then cbColorTxtI.ColorValue := RichEdit.SelAttributes.Color;

  bttaLeftJustify := TbsSkinSpeedButton(FindComponent('bttaLeftJustify'+inttostr(tag)));
  if (Assigned(bttaLeftJustify)) then
  begin
    if RichEdit.Paragraph.Alignment = taLeftJustify then
      bttaLeftJustify.Down := true
    else
      bttaLeftJustify.Down := false;
  end;

  bttaCenter := TbsSkinSpeedButton(FindComponent('bttaCenter'+inttostr(tag)));
  if (Assigned(bttaCenter)) then
  begin
    if RichEdit.Paragraph.Alignment = taCenter then
      bttaCenter.Down := true
    else
      bttaCenter.Down := false;
  end;

  bttaRightJustify := TbsSkinSpeedButton(FindComponent('bttaRightJustify'+inttostr(tag)));
  if (Assigned(bttaRightJustify)) then
  begin
    if RichEdit.Paragraph.Alignment = taRightJustify then
      bttaRightJustify.Down := true
    else
      bttaRightJustify.Down := false;
  end;

end;

procedure TfmIndex.RichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  RichEditEnter(Sender);
end;

procedure TfmIndex.RichEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RichEditEnter(Sender);
end;

procedure TfmIndex.RE_SetSelBgColor(RichEdit: TbsSkinRichEdit; AColor: TColor);
var
  Format: CHARFORMAT2;
begin
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_BACKCOLOR;
    crBackColor := AColor;
    RichEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));
  end;
end;

procedure TfmIndex.SorteioContador;
begin
  lblNumSortDisp.Caption := 'Disponíveis: ' + IntToStr(vlSorteio.Strings.Count);
  lblNumSortSort.Caption := 'Sorteados: ' + IntToStr(vlSorteados.Strings.Count);

  lblNumSortDispNM.Caption := 'Disponíveis: ' + IntToStr(vlSorteioNM.Strings.Count);
  lblNumSortSortNM.Caption := 'Sorteados: ' + IntToStr(vlSorteadosNM.Strings.Count);
end;

procedure TfmIndex.tabLetrasChange(Sender: TObject);
begin
  txtBuscaChange(Sender);
end;

function TfmIndex.termo_busca(busca: string): string;
var
  busca_ori: string;
begin
  busca_ori := busca;
  busca := RemoveAcento(busca);
  busca := StringReplace(busca,'*','%',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'a','[aáàâãä]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'e','[eéèêë]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'i','[iíìîï]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'o','[oóòôõö]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'u','[uúùûü]',[rfIgnoreCase, rfReplaceAll]);
//  busca := StringReplace(busca,'c','[cç]',[rfIgnoreCase, rfReplaceAll]);
//  loadCol.Strings.Values['BUSCA:'+busca_ori] := busca;
  busca := LowerCase(busca);
  Result := busca;
end;

procedure TfmIndex.ogFavoritosItemClick(Sender: TObject);
var
  i: Integer;
  tabsheet: TbsSkinTabSheet;
  nome,nome_aba: string;
begin
  if carrega_opc = true then Exit;

  i := ogFavoritos.ItemIndex+1;
  DM.cdsFavoritos.RecNo := i;

  tabsheet := TbsSkinTabSheet(FindComponent(DM.cdsFavoritos.FieldByName('NOME_ABA').AsString));
  if assigned(tabsheet)
    then abrePagina(tabsheet)
  else
  begin
    nome_aba := DM.cdsFavoritos.FieldByName('NOME_ABA').AsString;
    nome := DM.cdsFavoritos.FieldByName('NOME').AsString;
    if (application.MessageBox(PChar('Esta página não existe ou foi removida nesta versão! Deseja remover '''+nome+''' dos favoritos?'), titulo, mb_yesno + mb_iconquestion) = 6) then
    begin
      DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
      DM.cdsFavoritos.Delete;

      carregaFavoritos();
      botoesFavoritos('add');
      application.messagebox(PChar('Página '''+nome+''' removida com sucesso dos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
      exit;
    end
    else
    begin
      carregaFavoritos();
      botoesFavoritos('add');
    end;
  end;

end;

function TfmIndex.openDialog(tipo, filtros, param: string;
  multiplos: boolean;diretorio_inicial:string;titulo_dialog:string;nome_arquivo:string): string;
var
  titulo_dialog_def: string;
  filtros_def: string;
  param_def: string;
  dir,arq,a: string;
  i: Integer;
begin
  if (tipo = 'arquivo') then
  begin
    titulo_dialog_def := 'Abrir arquivo';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end
  else
  if (tipo = 'imagem') then
  begin
    titulo_dialog_def := 'Abrir imagem';
    filtros_def := 'Arquivos de Imagem (*.png_old;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.ico;*.emf;*.wmf)|*.png_old;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff;*.ico;*.emf;*.wmf';
    param_def := 'GeralImagem';
  end
  else
  if (tipo = 'musica_mp3') then
  begin
    titulo_dialog_def := 'Abrir música';
    filtros_def := 'Arquivos de Áudio MP3 (*.mp3)|*.mp3';
    param_def := 'GeralAudio';
  end
  else
  if (tipo = 'texto') then
  begin
    titulo_dialog_def := 'Abrir arquivo de texto';
    filtros_def := 'Arquivo de Texto (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Todos os Arquivos (*.*)|*.*';
    param_def := 'GeralTexto';
  end
  else
  if (tipo = 'pasta') then
  begin
    titulo_dialog_def := 'Selecione o Diretório';
    filtros_def := '';
    param_def := 'GeralPasta';
  end
  else
  begin
    titulo_dialog_def := 'Abrir';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end;

  if trim(filtros) = '' then filtros := filtros_def;
  if trim(param) = '' then param := param_def;
  if trim(titulo_dialog) = '' then titulo_dialog := titulo_dialog_def;
  nome_arquivo := Trim(nome_arquivo);

  dir := '';
  arq := '';
  if (trim(diretorio_inicial) <> '') then
  begin
    dir := diretorio(diretorio_inicial);
    if not DirectoryExists(dir) then dir := '';
  end;
  if (Trim(dir) <> '') and (DirectoryExists(ExtractFilePath(Application.ExeName)+dir))
    then dir := ExtractFilePath(Application.ExeName)+dir;
  if Trim(dir) = '' then
  begin
    dir := lerParam('OpenDialog', param, param_def);
    dir := diretorio(dir);
    if not DirectoryExists(dir) then dir := '';
  end;

  if (tipo = 'imagem') then
  begin
    DM.OpenPictureDialog.Title := titulo_dialog;
    DM.OpenPictureDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenPictureDialog.Options := DM.OpenPictureDialog.Options + [ofAllowMultiSelect]
      else DM.OpenPictureDialog.Options := DM.OpenPictureDialog.Options - [ofAllowMultiSelect];
    DM.OpenPictureDialog.FileName := nome_arquivo;
    DM.OpenPictureDialog.InitialDir := dir;
    if (DM.OpenPictureDialog.Execute) then
    begin
      for i := 0 to DM.OpenPictureDialog.Files.Count - 1 do
      begin
        a := DM.OpenPictureDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenPictureDialog.Files.Count = 1
            then application.messagebox(PChar('Imagem '+arq+' não localizada!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end
  else
  if (tipo = 'texto') then
  begin
    DM.OpenTextFileDialog.Title := titulo_dialog;
    DM.OpenTextFileDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenTextFileDialog.Options := DM.OpenTextFileDialog.Options + [ofAllowMultiSelect]
      else DM.OpenTextFileDialog.Options := DM.OpenTextFileDialog.Options - [ofAllowMultiSelect];
    DM.OpenTextFileDialog.FileName := nome_arquivo;
    DM.OpenTextFileDialog.InitialDir := dir;
    if (DM.OpenTextFileDialog.Execute) then
    begin
      for i := 0 to DM.OpenTextFileDialog.Files.Count - 1 do
      begin
        a := DM.OpenTextFileDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenTextFileDialog.Files.Count = 1
            then application.messagebox(PChar('Arquivo '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end
  else
  if (tipo = 'pasta') then
  begin
    DM.DirectoryDialog.Title := titulo_dialog;
    DM.DirectoryDialog.Directory := dir;
    if (DM.DirectoryDialog.Execute) then
    begin
      a := DM.DirectoryDialog.Directory;
      a := diretorio(a+'\');

      if not DirectoryExists(a) then
      begin
        application.messagebox(PChar('Diretório '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
        a := '';
      end;

      if a <> '' then
      begin
        if param <> '' then gravaParam('OpenDialog', param, diretorio(a+'\'));
        arq := a;
      end;
    end;
  end
  else
  begin
    DM.OpenDialog.Title := titulo_dialog;
    DM.OpenDialog.Filter := filtros;
    if (multiplos)
      then DM.OpenDialog.Options := DM.OpenDialog.Options + [ofAllowMultiSelect]
      else DM.OpenDialog.Options := DM.OpenDialog.Options - [ofAllowMultiSelect];
    DM.OpenDialog.FileName := nome_arquivo;
    DM.OpenDialog.InitialDir := dir;
    if (DM.OpenDialog.Execute) then
    begin
      for i := 0 to DM.OpenDialog.Files.Count - 1 do
      begin
        a := DM.OpenDialog.Files[i];
        a := diretorio(a);

        if not FileExists(a) then
        begin
          if DM.OpenDialog.Files.Count = 1
            then application.messagebox(PChar('Arquivo '+arq+' não localizado!'), TITULO, MB_ok + mb_iconerror);
          a := '';
        end;

        if a <> '' then
        begin
          if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(a)+'\'));
          if arq <> '' then arq := arq + '|';
          arq := arq + a;
        end;
      end;
    end;
  end;

  if (Trim(arq) = '') then arq := Trim(arq);

  Result := arq;
end;

function TfmIndex.saveDialog(tipo, filtros, param, diretorio_inicial,
  titulo_dialog: string;nome_arquivo:string): string;
var
  titulo_dialog_def: string;
  filtros_def: string;
  param_def: string;
  dir,arq: string;
  ext: TStringList;
  ext_info: string;
begin
  if (tipo = 'arquivo') then
  begin
    titulo_dialog_def := 'Salvar arquivo';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end
  else
  if (tipo = 'imagem') then
  begin
    titulo_dialog_def := 'Salvar imagem';
    filtros_def := 'PNG (*.png)|*.png|GIF (*.gif)|*.gif|JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|BMP (*.bmp)|*.bmp|TIFF (*.tif;*.tiff)|*.tif;*.tiff|ICO (*.ico)|*.ico|EMF (*.emf)|*.emf|WMF (*.wmf)|*.wmf';
    param_def := 'GeralImagem';
  end
  else
  if (tipo = 'texto') then
  begin
    titulo_dialog_def := 'Salvar arquivo de texto';
    filtros_def := 'Arquivo de Texto (*.txt)|*.txt|Arquivo CSV (*.csv)';
    param_def := 'GeralTexto';
  end
  else
  begin
    titulo_dialog_def := 'Salvar';
    filtros_def := 'Todos os Arquivos (*.*)|*.*';
    param_def := 'Geral';
  end;

  if trim(filtros) = '' then filtros := filtros_def;
  if trim(param) = '' then param := param_def;
  if trim(titulo_dialog) = '' then titulo_dialog := titulo_dialog_def;
  nome_arquivo := Trim(nome_arquivo);

  ext := TStringList.Create;
  ExtractStrings(['|'], [], PChar(filtros), ext);

  dir := '';
  arq := '';
  if (trim(diretorio_inicial) <> '') then
  begin
    dir := diretorio(diretorio_inicial);
    if not DirectoryExists(dir) then dir := '';
  end;
  if (Trim(dir) <> '') and (DirectoryExists(ExtractFilePath(Application.ExeName)+dir))
    then dir := ExtractFilePath(Application.ExeName)+dir;
  if Trim(dir) = '' then
  begin
    dir := lerParam('OpenDialog', param, param_def);
    dir := diretorio(dir);
    if not DirectoryExists(dir) then dir := '';
  end;

  if (tipo = 'imagem') then
  begin
    DM.SavePictureDialog.Title := titulo_dialog;
    DM.SavePictureDialog.Filter := filtros;
    DM.SavePictureDialog.FileName := nome_arquivo;
    DM.SavePictureDialog.InitialDir := dir;
    if (DM.SavePictureDialog.Execute) then
    begin
      arq := DM.SavePictureDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SavePictureDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe uma imagem com este nome neste diretório. Deseja substituir a imagem?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end
  else
  if (tipo = 'texto') then
  begin
    DM.SaveTextFileDialog.Title := titulo_dialog;
    DM.SaveTextFileDialog.Filter := filtros;
    DM.SaveTextFileDialog.FileName := nome_arquivo;
    DM.SaveTextFileDialog.InitialDir := dir;
    if (DM.SaveTextFileDialog.Execute) then
    begin
      arq := DM.SaveTextFileDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SaveTextFileDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe um arquivo com este nome neste diretório. Deseja substituir o arquivo?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end
  else
  begin
    DM.SaveDialog.Title := titulo_dialog;
    DM.SaveDialog.Filter := filtros;
    DM.SaveDialog.FileName := nome_arquivo;
    DM.SaveDialog.InitialDir := dir;
    if (DM.SaveDialog.Execute) then
    begin
      arq := DM.SaveDialog.FileName;
      arq := diretorio(arq);

      if ExtractFileExt(arq) = '' then
      begin
        ext_info := ext[(DM.SaveDialog.FilterIndex*2)-1]+';';
        ext_info := Copy(ext_info,1,Pos(';',ext_info)-1);
        if Pos('.',ext_info) > 0
          then ext_info := Copy(ext_info,Pos('.',ext_info)+1,length(ext_info));
        ext_info := StringReplace(ext_info, '*', '', [rfIgnoreCase, rfReplaceAll]);

        if ext_info <> ''
          then arq := arq+'.'+ext_info;
      end;

      if FileExists(arq) then
        if application.messagebox(PChar('Já existe um arquivo com este nome neste diretório. Deseja substituir o arquivo?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
          arq := '';

      if arq <> '' then
        if param <> '' then gravaParam('OpenDialog', param, diretorio(ExtractFileDir(arq)+'\'));
    end;
  end;

  if (Trim(arq) = '') then arq := Trim(arq);

  Result := arq;
end;

procedure TfmIndex.opSortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key,['0'..'9',#8])) then
    Key := #0;
end;

procedure TfmIndex.opSort_IniKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btAddSorteioClick(nil);
end;

procedure TfmIndex.PageControl1Close(Sender: TObject; var CanClose: Boolean);
var
  t: integer;
begin
  t := TbsSkinTabSheet(Sender).Tag;
  PageControl1.Pages[TbsSkinTabSheet(Sender).PageIndex].TabVisible := False;
  bsPopupMenuRibon.Items.Delete(t);
  confereAbasAbertas();
end;

procedure TfmIndex.PaginaMenuAtiva(page: TbsRibbonPage;tabvinc: TbsSkinTabSheet);
var
  i: integer;
  tl,idx: integer;
begin
  if page <> nil then
  begin
    page.Visible := True;
    bsRibbon1.ActivePage := page;
  end;

  bsRibbon1.Refresh;
  tl := 0;
  idx := -1;
  for i := 0 to bsRibbon1.Tabs.Count - 1 do
  begin
    if (bsRibbon1.Tabs[i].page.Tag = -1) then
    begin
      if ((page <> nil) and (bsRibbon1.Tabs[i].page <> page) or (page = nil)) then
        bsRibbon1.Tabs[i].Visible := False;

      if (page <> nil) and (bsRibbon1.Tabs[i].page = page) and (bsRibbon1.Tabs[i].Visible = True) then
        idx := i;
    end
    else tl := tl + bsRibbon1.Tabs[i].Width+1;
  end;

  pnlfmSubTituloRib.Visible := false;
  if idx >= 0 then
  begin
    pnlTitForm.Align := alLeft;
    pnlTitForm.Width := tl+bsRibbon1.AppButtonWidth-2;

    if tabvinc <> nil then lblfmTituloRib.Caption := tabvinc.Caption
    else lblfmTituloRib.Caption := '';

    pnlfmTituloRib.width := bsRibbon1.Tabs[idx].Width;
    pnlfmTituloRib.Left := pnlTitForm.Width;
    pnlfmTituloRib.Visible := true;

    pnlfmSubTituloRib.width := pnlfmTituloRib.width;
    pnlfmSubTituloRib.Left := pnlfmTituloRib.Left;
    pnlfmSubTituloRib.Top := pnlfmTituloRib.Top+pnlfmTituloRib.height;
    pnlfmSubTituloRib.Height := 31;
    pnlfmSubTituloRib.Caption := bsRibbon1.ActivePage.Caption;
    pnlfmSubTituloRib.Tag := 1;
  end
  else
  begin
    pnlTitForm.Align := alClient;
    pnlfmTituloRib.Visible := false;
    pnlfmSubTituloRib.Caption := '';
    pnlfmSubTituloRib.Tag := 0;
  end;

end;

procedure TfmIndex.PanelColorClick(Sender: TObject);
var
  Panel: TPanel;
begin
  if Sender is TPanel
    then Panel := TPanel(TPanel(Sender))
    else Panel := TPanel(TPanel(Sender).Parent);

  DM.ColorDialog.Color := Panel.Color;
  DM.ColorDialog.Execute;
  Panel.Color := DM.ColorDialog.Color;

  gravaParam(Panel.Parent.Name, 'cor', ColorToString(DM.ColorDialog.Color), arq_liturgia);
end;

procedure TfmIndex.pnlfmBarraTituloFormDblClick(Sender: TObject);
begin
  btwsMaximizedClick(Sender);
end;

procedure TfmIndex.pnlfmBarraTituloFormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (fmIndex.WindowState = wsMaximized) then Exit;
  if (Button = mbLeft) then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND,$F012,0);
  end;
end;

procedure TfmIndex.pnlfmSubTituloRibClick(Sender: TObject);
begin
  if PageControl1.Visible = true then
  begin
    try
      PageControl1.Pages[PageControl1.ActivePageIndex].OnShow(Sender);
    except
      //
    end;
  end;
end;

procedure TfmIndex.pnlfmSubTituloRibMouseLeave(Sender: TObject);
begin
  pnlfmSubTituloRib.Color := pnlfmTituloRib.Color;
  pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_marc']);
end;

procedure TfmIndex.pnlfmSubTituloRibMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  pnlfmSubTituloRib.Color := StringToColor(layoutValue.Strings.Values['cor_sel']);
  pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_sel']);
end;

function TfmIndex.isFolderEmpty(szPath: string): Boolean;
var
  res: TSearchRec;
begin
  szPath := IncludeTrailingPathDelimiter(szPath);
  Result := (FindFirst(szPath + '*.*', faAnyFile - faDirectory, res) <> 0);
  FindClose(res);
end;

procedure TfmIndex.carregaBiblia(tipo: string);
var
  bus,busp:string;
  i:integer;
begin
  if (tipo = 'VER') then
  begin
    DM.qrBIBLIA_VERSAO.Close;
    DM.qrBIBLIA_VERSAO.Open;
    dblBibVersao.KeyValue := loadCol.Strings.Values['BIBLIA_VERSAO'];
  end
  else if (tipo = 'VER2') then
  begin
    DM.qrBIBLIA_VERSAO_2.Close;
    DM.qrBIBLIA_VERSAO_2.Open;
    dblBibVersao2.KeyValue := loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'];
  end
  else if (tipo = 'LIV') then
  begin
    DM.qrBIBLIA_LIVROS.Close;
    DM.qrBIBLIA_LIVROS.Open;
    DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_LIVRO'],[]);
    busBibliaLivro.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_LIVRO'])-1;
  end
  else if (tipo = 'CAP') then
  begin
    DM.qrBIBLIA_CAPITULOS.Close;
    DM.qrBIBLIA_CAPITULOS.ParamByName('LIVRO').Value := StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
    DM.qrBIBLIA_CAPITULOS.ParamByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_VERSAO'];
    DM.qrBIBLIA_CAPITULOS.Open;
    busBibliaCapitulo.Items.Clear;
    for i := 1 to DM.qrBIBLIA_LIVROS.FieldByName('CAPITULOS').AsInteger do
    begin
      busBibliaCapitulo.Items.Add(IntToStr(i));
    end;
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_CAPITULO'],[]);
    busBibliaCapitulo.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_CAPITULO'])-1;
  end
  else if (tipo = 'VSC') then
  begin
    DM.qrBIBLIA_VERSICULOS.Close;
    DM.qrBIBLIA_VERSICULOS.SQL.Clear;

    if (trim(busBibliaVersiculo.Text) <> '') then
    begin
      busp := geraIntervaloNum(GetStrNumber2(trim(busBibliaVersiculo.Text)));
      bus := termo_busca(trim(busBibliaVersiculo.Text));
      DM.qrBIBLIA_VERSICULOS.SQL.Add('SELECT ID, LIVRO, CAPITULO, VERSICULO, VERSICULO || " " AS VERSICULO_TXT, PASSAGEM || "" AS PASSAGEM, PASSAGEM AS PASSAGEM_ORI FROM BIBLIA');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('WHERE LIVRO = 0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND VERSAO = '''+loadCol.Strings.Values['BIBLIA_VERSAO']+'''');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND CAPITULO = 0'+loadCol.Strings.Values['BIBLIA_CAPITULO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND (VERSICULO IN (0'+busp+')');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('OR PASSAGEM LIKE ''%'+bus+'%'')');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('ORDER BY VERSICULO');
    end
    else
    begin
      DM.qrBIBLIA_VERSICULOS.SQL.Add('SELECT ID, LIVRO, CAPITULO, VERSICULO, VERSICULO || " " AS VERSICULO_TXT, PASSAGEM || "" AS PASSAGEM, PASSAGEM AS PASSAGEM_ORI FROM BIBLIA');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('WHERE LIVRO = 0'+loadCol.Strings.Values['BIBLIA_LIVRO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND VERSAO = '''+loadCol.Strings.Values['BIBLIA_VERSAO']+'''');
      DM.qrBIBLIA_VERSICULOS.SQL.Add('AND CAPITULO = 0'+loadCol.Strings.Values['BIBLIA_CAPITULO']);
      DM.qrBIBLIA_VERSICULOS.SQL.Add('ORDER BY VERSICULO');
    end;
    DM.qrBIBLIA_VERSICULOS.Open;
    corCampoBusca(TFDQuery(DM.qrBIBLIA_VERSICULOS),busBibliaVersiculo,nil);

    if (not (DM.qrBIBLIA_LIVROS.Eof)) and (trim(loadCol.Strings.Values['BIBLIA_VERSICULO']) <> '') then
      DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',loadCol.Strings.Values['BIBLIA_VERSICULO'],[]);

  end
  else if (tipo = 'BUS') then
  begin
    DM.qrBIBLIA_BUSCA.Close;
    DM.qrBIBLIA_BUSCA.SQL.Clear;
    if (Trim(txtBibLocaliza.Text) <> '') then
    begin
      bus := termo_busca(trim(txtBibLocaliza.Text));
      DM.qrBIBLIA_BUSCA.SQL.Add('SELECT "" AS BRANCO,');
      DM.qrBIBLIA_BUSCA.SQL.Add('BIBLIA.VERSAO,BIBLIA.LIVRO,');
      DM.qrBIBLIA_BUSCA.SQL.Add('BIBLIA.CAPITULO,BIBLIA.VERSICULO,BIBLIA.PASSAGEM || "" AS PASSAGEM,');
      DM.qrBIBLIA_BUSCA.SQL.Add('" " || LIVRO.LIVRO || " " || BIBLIA.CAPITULO || ":" || BIBLIA.VERSICULO || " (" || BIBLIA.VERSAO || ")" AS DESC_PASSAGEM,');
      DM.qrBIBLIA_BUSCA.SQL.Add('LIVRO.LIVRO || " " || BIBLIA.CAPITULO || ":" || BIBLIA.VERSICULO || " (" || BIBLIA.VERSAO || ")" AS DESC_PASSAGEM2');
      DM.qrBIBLIA_BUSCA.SQL.Add('FROM BIBLIA,LIVRO');
      DM.qrBIBLIA_BUSCA.SQL.Add('WHERE BIBLIA.LIVRO = LIVRO.ID');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.VERSAO = '''+loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO']+'''');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.PASSAGEM LIKE ''%'+bus+'%''');
      DM.qrBIBLIA_BUSCA.SQL.Add('AND BIBLIA.LIVRO IN (0');
      for i := 0 to ckLivros.Items.Count-1 do
      begin
        if (ckLivros.Checked[i]) then
        begin
          DM.qrBIBLIA_BUSCA.SQL.Add(','+IntToStr(i+1));
        end;
      end;
      DM.qrBIBLIA_BUSCA.SQL.Add(')');
      DM.qrBIBLIA_BUSCA.SQL.Add('ORDER BY BIBLIA.LIVRO,BIBLIA.CAPITULO,BIBLIA.VERSICULO');

      DM.qrBIBLIA_BUSCA.Open;
    end;
  end;
end;

procedure TfmIndex.carregaComboFormatoTempo(combo: TbsSkinComboBox;
  formato: string);
begin
  combo.ItemIndex := combo.Items.IndexOf(formato);
  if combo.ItemIndex < 0 then
  begin
    combo.Items.Add(formato);
    combo.ItemIndex := combo.Items.IndexOf(formato);
  end;
end;

procedure TfmIndex.carregaConfiguracoes(pagina: string);
begin
  carrega_opc := True;
  if (pagina = 'BIBLIA') then
  begin
    monitor_bt_label(btExp_Biblia);
    cbBibliaHistorico.Checked := (lerParam('Biblia', 'Historico', '1') = '1');
    fcBibliaFonte.FontName := lerParam('Biblia', 'Fonte', fonte);
    seBibliaTamanho.Text := lerParam('Biblia', 'Tamanho', '7');
    seBibliaTamanho2.Text := lerParam('Biblia', 'Tamanho Passagem', '7');
    csBibliaCor.ColorValue := StringToColor(lerParam('Biblia', 'Cor', 'clWhite'));
    csBibliaCor2.ColorValue := StringToColor(lerParam('Biblia', 'Cor Passagem', '$000066FF'));
    csBibliaCorFundo.ColorValue := StringToColor(lerParam('Biblia', 'Cor Fundo', 'clBlack'));

    //cbBibliaAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));

    lmdBibliaTxt.Font.Name := fcBibliaFonte.FontName;
    lmdBibliaTxt.Font.Height := Trunc((pnlBiblia.Height/100)*seBibliaTamanho.Value);
    lmdBibliaTxt.Font.Color := csBibliaCor.ColorValue;

    lmdBibliaInfo.Font.Name := fcBibliaFonte.FontName;
    lmdBibliaInfo.Font.Height := Trunc((pnlBiblia.Height/100)*seBibliaTamanho2.Value);
    lmdBibliaInfo.Font.Color := csBibliaCor2.ColorValue;

    pnlBiblia.Color := csBibliaCorFundo.ColorValue;
    pnlBiblia.DoubleBuffered := True;
    if (loadCol.Strings.Values['BIBLIA_IMG'] <> lerParam('Biblia', 'Imagem Fundo', '')) then
    begin
      tsBibliaImagem.Text := lerParam('Biblia', 'Imagem Fundo', '');
      tsBibliaImagemInfo.Text := lerParam('Biblia', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['BIBLIA_IMG'] := tsBibliaImagem.Text;
      if (Trim(tsBibliaImagem.Text) <> '') and (FileExists(tsBibliaImagem.Text)) then
        imgBiblia.Picture.LoadFromFile(tsBibliaImagem.Text)
      else
        imgBiblia.Picture := nil;
      imgBiblia.Refresh;
      imgBiblia.Repaint;
      pnlBiblia.Refresh;
      pnlBiblia.Invalidate;
      pnlBiblia.Repaint;

      cbBibliaPosicaoFundo.ItemIndex := StrToInt(lerParam('Biblia', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgBiblia,pnlBiblia,cbBibliaPosicaoFundo.ItemIndex+1);
    end;
    ajustaTexto(pagina);
  end
  else if (pagina = 'BIBLIA_BUSCA') then
  begin
    monitor_bt_label(btExp_BibliaBusca);
    fcBibliabFonte.FontName := lerParam('Busca Biblica', 'Fonte', fonte);
    seBibliabTamanho.Text := lerParam('Busca Biblica', 'Tamanho', '7');
    seBibliabTamanho2.Text := lerParam('Busca Biblica', 'Tamanho Passagem', '7');
    csBibliabCor.ColorValue := StringToColor(lerParam('Busca Biblica', 'Cor', 'clWhite'));
    csBibliabCor2.ColorValue := StringToColor(lerParam('Busca Biblica', 'Cor Passagem', '$000066FF'));
    csBibliabCorFundo.ColorValue := StringToColor(lerParam('Busca Biblica', 'Cor Fundo', 'clBlack'));

    //cbBibliabAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));

		lmdBibliaBuscaTxt.Font.Name := fcBibliabFonte.FontName;
    lmdBibliaBuscaTxt.Font.Height := Trunc((pnlBibliaBusca.Height/100)*seBibliabTamanho.Value);
    lmdBibliaBuscaTxt.Font.Color := csBibliabCor.ColorValue;

    lmdBibliaBuscaInfo.Font.Name := fcBibliabFonte.FontName;
    lmdBibliaBuscaInfo.Font.Height := Trunc((pnlBibliaBusca.Height/100)*seBibliabTamanho2.Value);
    lmdBibliaBuscaInfo.Font.Color := csBibliabCor2.ColorValue;

    pnlBibliaBusca.Color := csBibliabCorFundo.ColorValue;
    pnlBibliaBusca.DoubleBuffered := True;
    if (loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] <> lerParam('Busca Biblica', 'Imagem Fundo', '')) then
    begin
      tsBibliabImagem.Text := lerParam('Busca Biblica', 'Imagem Fundo', '');
      tsBibliabImagemInfo.Text := lerParam('Busca Biblica', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := tsBibliabImagem.Text;
      if (Trim(tsBibliabImagem.Text) <> '') and (FileExists(tsBibliabImagem.Text)) then
        imgBibliaBusca.Picture.LoadFromFile(tsBibliabImagem.Text)
      else
        imgBibliaBusca.Picture := nil;
      imgBibliaBusca.Refresh;
      imgBibliaBusca.Repaint;
      pnlBibliaBusca.Refresh;
      pnlBibliaBusca.Invalidate;
      pnlBibliaBusca.Repaint;

      cbBibliabPosicaoFundo.ItemIndex := StrToInt(lerParam('Busca Biblica', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgBibliaBusca,pnlBibliaBusca,cbBibliabPosicaoFundo.ItemIndex+1);
    end;
    ajustaTexto(pagina);
  end
  else if (pagina = 'ES') then
  begin
    monitor_bt_label(btExp_EscolaSabatina);
    fcEscsbFonte.FontName := lerParam('Escola Sabatina', 'Fonte', fonte);
    seEscsbTamanho.Value := StrToFloat(lerParam('Escola Sabatina', 'Tamanho', '30'));
    csEscsbCor.ColorValue := StringToColor(lerParam('Escola Sabatina', 'Cor', 'clBlack'));
    seEscsbTamanho2.Value := StrToFloat(lerParam('Escola Sabatina', 'Tamanho 2', '20'));
    csEscsbCor2.ColorValue := StringToColor(lerParam('Escola Sabatina', 'Cor 2', 'clBlue'));
    csEscsbCor3.ColorValue := StringToColor(lerParam('Escola Sabatina', 'Cor 3', 'clRed'));
    csEscsbCorFundo.ColorValue := StringToColor(lerParam('Escola Sabatina', 'Cor Fundo', 'clWhite'));

    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);


    lmdEscSb.Font.Name := fcEscsbFonte.FontName;
    lmdEscSb.Font.Height := Trunc((pnlEscSB.Height/100)*seEscsbTamanho.Value);
    lmdEscSb.Font.Color := csEscsbCor.ColorValue;

    lmdEscSbR.Font.Name := fcEscsbFonte.FontName;
    lmdEscSbR.Font.Height := Trunc((pnlEscSB.Height/100)*seEscsbTamanho2.Value);
    lmdEscSbR.Font.Color := csEscsbCor2.ColorValue;

    pnlEscSB.Color := csEscsbCorFundo.ColorValue;

    carregaComboFormatoTempo(cbFormatoHoraES,lerParam('Escola Sabatina', 'FormatoHora', 'hh:mm:ss'));
    carregaComboFormatoTempo(cbFormatoTempoES,lerParam('Escola Sabatina', 'FormatoTempo', 'hh:mm:ss'));

    //selMusica();
    opcCronoCTempo.ItemIndex := StrToInt(lerParam('Escola Sabatina', 'TempoFim', '0'));
    meESHora.text := lerParam('Escola Sabatina', 'Hora', '10:00');
    meESDuracao.Value := StrToInt(lerParam('Escola Sabatina', 'Duracao', '40'));
    opcCronoCTempoClick(nil);

    cgEscSBAudio.ItemChecked[0] := (lerParam('Escola Sabatina', 'Abertura', '1') = '1');
    cgEscSBAudio.ItemChecked[1] := (lerParam('Escola Sabatina', '5 min.', '1') = '1');
    cgEscSBAudio.ItemChecked[2] := (lerParam('Escola Sabatina', '1 min.', '1') = '1');

    cbEscSBRelogioFunc.Checked := (lerParam('Escola Sabatina', 'RelogioSempreAtivo', '1') = '1');
    cbEscSBZerarTempo.Checked := (lerParam('Escola Sabatina', 'DesligarZerarTempo', '1') = '1');

    pnlEscSB.DoubleBuffered := True;
    if (loadCol.Strings.Values['ES_IMG'] <> lerParam('Escola Sabatina', 'Imagem Fundo', '')) then
    begin
      tsEscSBImagem.Text := lerParam('Escola Sabatina', 'Imagem Fundo', '');
      tsEscSBImagemInfo.Text := lerParam('Escola Sabatina', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['ES_IMG'] := tsEscSBImagem.Text;
      if (Trim(tsEscSBImagem.Text) <> '') and (FileExists(tsEscSBImagem.Text)) then
        imgEscSB.Picture.LoadFromFile(tsEscSBImagem.Text)
      else
        imgEscSB.Picture := nil;
      imgEscSB.Refresh;
      imgEscSB.Repaint;
      pnlEscSB.Refresh;
      pnlEscSB.Invalidate;
      pnlEscSB.Repaint;

      cbEscSBPosicaoFundo.ItemIndex := StrToInt(lerParam('Escola Sabatina', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgEscSB,pnlEscSB,cbEscSBPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'SORTEIO') then
  begin
    monitor_bt_label(btExp_Sorteio);
    seSorteioTempo.Value := StrToFloat(lerParam('Sorteio', 'TempoAnimacao','1.0'));

    fcSorteioFonte.FontName := lerParam('Sorteio', 'Fonte', fonte);
    seSorteioTamanho.Value := StrToFloat(lerParam('Sorteio', 'Tamanho', '35'));
    csSorteioCor.ColorValue := StringToColor(lerParam('Sorteio', 'Cor', 'clBlack'));
    csSorteioCorFundo.ColorValue := StringToColor(lerParam('Sorteio', 'Cor Fundo', 'clWhite'));

    cbSorteioAlinhamento.ItemIndex := strtoint(lerParam('Sorteio', 'Alinhamento', '1'));
    if cbSorteioAlinhamento.ItemIndex = 0 then
    begin
      lmdSorteio.Align := alTop;
      lmdSorteio.Height := Trunc(pnlSorteio.Height/2);
    end
    else
    if cbSorteioAlinhamento.ItemIndex = 1 then
    begin
      lmdSorteio.Align := alClient;
      lmdSorteio.Height := Trunc(pnlSorteio.Height);
    end
    else
    if cbSorteioAlinhamento.ItemIndex = 2 then
    begin
      lmdSorteio.Align := alBottom;
      lmdSorteio.Height := Trunc(pnlSorteio.Height/2);
    end;


    lmdSorteio.Font.Name := fcSorteioFonte.FontName;
    lmdSorteio.Font.Height := Trunc((pnlSorteio.Height/100)*seSorteioTamanho.Value);
    lmdSorteio.Font.Color := csSorteioCor.ColorValue;
    pnlSorteio.Color := csSorteioCorFundo.ColorValue;

    ckSorteioExp.ItemChecked[0] := (lerParam('Sorteio', 'Numeros Sorteio (Extendido)', '1') = '1');
    ckSorteioExp.ItemChecked[1] := (lerParam('Sorteio', 'Numeros Sorteados (Extendido)', '1') = '1');

    pnlSorteio.DoubleBuffered := True;
    if (loadCol.Strings.Values['SORTEIO_IMG'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      tsSorteioImagem.Text := lerParam('Sorteio', 'Imagem Fundo', '');
      tsSorteioImagemInfo.Text := lerParam('Sorteio', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['SORTEIO_IMG'] := tsSorteioImagem.Text;
      if (Trim(tsSorteioImagem.Text) <> '') and (FileExists(tsSorteioImagem.Text)) then
        imgSorteio.Picture.LoadFromFile(tsSorteioImagem.Text)
      else
        imgSorteio.Picture := nil;
      imgSorteio.Refresh;
      imgSorteio.Repaint;
      pnlSorteio.Refresh;
      pnlSorteio.Invalidate;
      pnlSorteio.Repaint;

      cbSorteioPosicaoFundo.ItemIndex := StrToInt(lerParam('Sorteio', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgSorteio,pnlSorteio,cbSorteioPosicaoFundo.ItemIndex+1);
    end;
    DM.tmrSorteio.Enabled := true;
  end
  else if (pagina = 'SORTEIO_NOMES') then
  begin
    monitor_bt_label(btExp_SorteioNM);
    seSorteioTempoNM.Value := StrToFloat(lerParam('Sorteio Nomes', 'TempoAnimacao','1.0'));

    fcSorteioFonteNM.FontName := lerParam('Sorteio Nomes', 'Fonte', fonte);
    seSorteioTamanhoNM.Value := StrToFloat(lerParam('Sorteio Nomes', 'Tamanho', '15'));
    csSorteioCorNM.ColorValue := StringToColor(lerParam('Sorteio Nomes', 'Cor', 'clBlack'));
    csSorteioCorFundoNM.ColorValue := StringToColor(lerParam('Sorteio Nomes', 'Cor Fundo', 'clWhite'));

    cbSorteioNMAlinhamento.ItemIndex := strtoint(lerParam('Sorteio Nomes', 'Alinhamento', '1'));
    if cbSorteioNMAlinhamento.ItemIndex = 0 then
    begin
      lmdSorteioNM.Align := alTop;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height/2);
    end
    else
    if cbSorteioNMAlinhamento.ItemIndex = 1 then
    begin
      lmdSorteioNM.Align := alClient;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height);
    end
    else
    if cbSorteioNMAlinhamento.ItemIndex = 2 then
    begin
      lmdSorteioNM.Align := alBottom;
      lmdSorteioNM.Height := Trunc(pnlSorteioNM.Height/2);
    end;

    lmdSorteioNM.Font.Name := fcSorteioFonteNM.FontName;
    lmdSorteioNM.Font.Height := Trunc((pnlSorteioNM.Height/100)*seSorteioTamanhoNM.Value);
    lmdSorteioNM.Font.Color := csSorteioCorNM.ColorValue;
    pnlSorteioNM.Color := csSorteioCorFundoNM.ColorValue;

    ckSorteioExpNM.ItemChecked[0] := (lerParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '1') = '1');
    ckSorteioExpNM.ItemChecked[1] := (lerParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '1') = '1');

    pnlSorteioNM.DoubleBuffered := True;
    if (loadCol.Strings.Values['SORTEIO_NOMES_IMG'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      tsSorteioNMImagem.Text := lerParam('Sorteio Nomes', 'Imagem Fundo', '');
      tsSorteioNMImagemInfo.Text := lerParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := tsSorteioNMImagem.Text;

      if (Trim(tsSorteioNMImagem.Text) <> '') and (FileExists(tsSorteioNMImagem.Text)) then
        imgSorteioNM.Picture.LoadFromFile(tsSorteioNMImagem.Text)
      else
        imgSorteioNM.Picture := nil;
      imgSorteioNM.Refresh;
      imgSorteioNM.Repaint;
      pnlSorteioNM.Refresh;
      pnlSorteioNM.Invalidate;
      pnlSorteioNM.Repaint;

      cbSorteioNMPosicaoFundo.ItemIndex := StrToInt(lerParam('Sorteio Nomes', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgSorteioNM,pnlSorteioNM,cbSorteioNMPosicaoFundo.ItemIndex+1);
    end;

    DM.tmrSorteio.Enabled := true;
  end
  else if (pagina = 'CRONO') then
  begin
    monitor_bt_label(btExp_Cronometro);
    fcCronoFonte.FontName := lerParam('Cronometro', 'Fonte', fonte);
    seCronoTamanho.Value := StrToFloat(lerParam('Cronometro', 'Tamanho', '22'));

    cbCronometroAlinhamento.ItemIndex := strtoint(lerParam('Cronometro', 'Alinhamento', '1'));
    if cbCronometroAlinhamento.ItemIndex = 0 then
    begin
      lmdCrono.Align := alTop;
      lmdCrono.Height := Trunc(pnlCrono.Height/2);
    end
    else
    if cbCronometroAlinhamento.ItemIndex = 1 then
    begin
      lmdCrono.Align := alClient;
      lmdCrono.Height := Trunc(pnlCrono.Height);
    end
    else
    if cbCronometroAlinhamento.ItemIndex = 2 then
    begin
      lmdCrono.Align := alBottom;
      lmdCrono.Height := Trunc(pnlCrono.Height/2);
    end;

    csCronoCor.ColorValue := StringToColor(lerParam('Cronometro', 'Cor', 'clBlack'));
    csCronoCorFundo.ColorValue := StringToColor(lerParam('Cronometro', 'Cor Fundo', 'clWhite'));
    cbCronoEl.ItemChecked[0] := (lerParam('Cronometro', 'Tempos Gravados (Extendido)', '1') = '1');

    carregaComboFormatoTempo(cbFormatoTempoCrono,lerParam('Cronometro', 'FormatoTempo', 'hh:mm:ss.zzz'));
    txtDecr.Text := lerParam('Cronometro', 'Tempo Decrescente', '00:01:00');

    lmdCrono.Font.Name := fcCronoFonte.FontName;
    lmdCrono.Font.Height := Trunc((pnlCrono.Height/100)*seCronoTamanho.Value);
    lmdCrono.Font.Color := csCronoCor.ColorValue;
    pnlCrono.Color := csCronoCorFundo.ColorValue;

    pnlCrono.DoubleBuffered := True;
    if (loadCol.Strings.Values['CRONO_IMG'] <> lerParam('Cronometro', 'Imagem Fundo', '')) then
    begin
      tsCronoImagem.Text := lerParam('Cronometro', 'Imagem Fundo', '');
      tsCronoImagemInfo.Text := lerParam('Cronometro', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['CRONO_IMG'] := tsCronoImagem.Text;
      if (Trim(tsCronoImagem.Text) <> '') and (FileExists(tsCronoImagem.Text)) then
        imgCrono.Picture.LoadFromFile(tsCronoImagem.Text)
      else
        imgCrono.Picture := nil;
      imgCrono.Refresh;
      imgCrono.Repaint;
      pnlCrono.Refresh;
      pnlCrono.Invalidate;
      pnlCrono.Repaint;

      cbCronoPosicaoFundo.ItemIndex := StrToInt(lerParam('Cronometro', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgCrono,pnlCrono,cbCronoPosicaoFundo.ItemIndex+1);
    end;

    rbDirecao.ItemIndex := StrToInt(lerParam('Cronometro', 'Direcao', '0'));
    rbDirecaoClick(nil);
  end
  else if (pagina = 'PAINELD') then
  begin
    monitor_bt_label(btExp_PainelD);
    fcPainelDFonte.FontName := lerParam('Painel Dinamico', 'Fonte', fonte);
    sePainelDTamanho.Value := StrToFloat(lerParam('Painel Dinamico', 'Tamanho', '15'));

    cbPainelDAlinhamento.ItemIndex := strtoint(lerParam('Painel Dinamico', 'Alinhamento', '1'));
    if cbPainelDAlinhamento.ItemIndex = 0 then
    begin
      lmdTxtPainelD.Align := alTop;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height/2);
    end
    else
    if cbPainelDAlinhamento.ItemIndex = 1 then
    begin
      lmdTxtPainelD.Align := alClient;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height);
    end
    else
    if cbPainelDAlinhamento.ItemIndex = 2 then
    begin
      lmdTxtPainelD.Align := alBottom;
      lmdTxtPainelD.Height := Trunc(pnlTxtPainelD.Height/2);
    end;


    csPainelDCor.ColorValue := StringToColor(lerParam('Painel Dinamico', 'Cor', 'clBlack'));
    csPainelDCorFundo.ColorValue := StringToColor(lerParam('Painel Dinamico', 'Cor Fundo', 'clWhite'));

    lmdTxtPainelD.Font.Name := fcPainelDFonte.FontName;
    lmdTxtPainelD.Font.Height := Trunc((pnlTxtPainelD.Height/100)*sePainelDTamanho.Value);
    lmdTxtPainelD.Font.Color := csPainelDCor.ColorValue;
    pnlTxtPainelD.Color := csPainelDCorFundo.ColorValue;

    pnlTxtPainelD.DoubleBuffered := True;
    if (loadCol.Strings.Values['PAINELD_IMG'] <> lerParam('Painel Dinamico', 'Imagem Fundo', '')) then
    begin
      tsTxtPainelDImagem.Text := lerParam('Painel Dinamico', 'Imagem Fundo', '');
      tsTxtPainelDImagemInfo.Text := lerParam('Painel Dinamico', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['PAINELD_IMG'] := tsTxtPainelDImagem.Text;
      if (Trim(tsTxtPainelDImagem.Text) <> '') and (FileExists(tsTxtPainelDImagem.Text)) then
        imgTxtPainelD.Picture.LoadFromFile(tsTxtPainelDImagem.Text)
      else
        imgTxtPainelD.Picture := nil;
      imgTxtPainelD.Refresh;
      imgTxtPainelD.Repaint;
      pnlTxtPainelD.Refresh;
      pnlTxtPainelD.Invalidate;
      pnlTxtPainelD.Repaint;

      cbTxtPainelDPosicaoFundo.ItemIndex := StrToInt(lerParam('Painel Dinamico', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgTxtPainelD,pnlTxtPainelD,cbTxtPainelDPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'TEXTOI') then
  begin
    monitor_bt_label(btExp_TextoInterativo);
  end
  else if (pagina = 'RELOGIO') then
  begin
    monitor_bt_label(btExp_Relogio);
    fcRelogioFonte.FontName := lerParam('Relogio', 'Fonte', fonte);
    seRelogioTamanho.Value := StrToFloat(lerParam('Relogio', 'Tamanho', '30'));

    cbRelogioAlinhamento.ItemIndex := strtoint(lerParam('Relogio', 'Alinhamento', '1'));
    if cbRelogioAlinhamento.ItemIndex = 0 then
    begin
      lmdRelogio.Align := alTop;
      lmdRelogio.Height := Trunc(pnlRelogio.Height/2);
    end
    else
    if cbRelogioAlinhamento.ItemIndex = 1 then
    begin
      lmdRelogio.Align := alClient;
      lmdRelogio.Height := Trunc(pnlRelogio.Height);
    end
    else
    if cbRelogioAlinhamento.ItemIndex = 2 then
    begin
      lmdRelogio.Align := alBottom;
      lmdRelogio.Height := Trunc(pnlRelogio.Height/2);
    end;

    csRelogioCor.ColorValue := StringToColor(lerParam('Relogio', 'Cor', 'clBlack'));
    csRelogioCorFundo.ColorValue := StringToColor(lerParam('Relogio', 'Cor Fundo', 'clWhite'));

    lmdRelogio.Font.Name := fcRelogioFonte.FontName;
    lmdRelogio.Font.Height := Trunc((pnlRelogio.Height/100)*seRelogioTamanho.Value);
    lmdRelogio.Font.Color := csRelogioCor.ColorValue;
    pnlRelogio.Color := csRelogioCorFundo.ColorValue;

    carregaComboFormatoTempo(cbFormatoHora,lerParam('Relogio', 'FormatoHora', 'hh:mm:ss'));

    pnlRelogio.DoubleBuffered := True;
    if (loadCol.Strings.Values['RELOGIO_IMG'] <> lerParam('Relogio', 'Imagem Fundo', '')) then
    begin
      tsRelogioImagem.Text := lerParam('Relogio', 'Imagem Fundo', '');
      tsRelogioImagemInfo.Text := lerParam('Relogio', 'Imagem Fundo - UrlInfo', '');

      loadCol.Strings.Values['RELOGIO_IMG'] := tsRelogioImagem.Text;
      if (Trim(tsRelogioImagem.Text) <> '') and (FileExists(tsRelogioImagem.Text)) then
        imgRelogio.Picture.LoadFromFile(tsRelogioImagem.Text)
      else
        imgRelogio.Picture := nil;
      imgRelogio.Refresh;
      imgRelogio.Repaint;
      pnlRelogio.Refresh;
      pnlRelogio.Invalidate;
      pnlRelogio.Repaint;

      cbRelogioPosicaoFundo.ItemIndex := StrToInt(lerParam('Relogio', 'Posicao Fundo', '5'))-1;
      ajustaImagem(imgRelogio,pnlRelogio,cbRelogioPosicaoFundo.ItemIndex+1);
    end;
  end
  else if (pagina = 'SLIDESD') then
  begin
    //
  end
  else
    application.MessageBox(PChar('Não localizado parâmetro ''' + pagina + ''' para a função ''carregaConfiguracoes''!'), titulo, mb_ok + mb_iconerror);

  copiaDadosTelaExtendida;
  carrega_opc := False;
end;

procedure TfmIndex.carregaFavoritos();
var
  item: TbsSkinOfficeGalleryItem;
  itemMenu: TMenuItem;
  i: integer;
begin
  if not DM.cdsFavoritos.Active then
  begin
    DM.cdsFavoritos.CreateDataSet;
    DM.cdsFavoritos.IndexName := '';
    DM.cdsFavoritos.IndexFieldNames := 'ORDEM';
    DM.cdsFavoritos.LogChanges := False;

    if (FileExists(dir_dados + 'favoritos.xml')) then
      DM.cdsFavoritos.LoadFromFile(dir_dados + 'favoritos.xml');
    DM.cdsFavoritos.Open;
  end;

  carrega_opc := True;
  ogFavoritos.ItemIndex := 0;
  carrega_opc := False;

  ogFavoritos.Items.Clear;
  for i := bsPopupMenuFavoritos.Items.Count-5 downto 0 do
    bsPopupMenuFavoritos.Items.Delete(i);


  i := DM.cdsFavoritos.RecordCount;
  DM.cdsFavoritos.First;
  while not DM.cdsFavoritos.Eof do
  begin
    item := ogFavoritos.Items.Add;
    item.Caption := DM.cdsFavoritos.FieldByName('NOME').AsString;
    item.ImageIndex := DM.cdsFavoritos.FieldByName('IMAGEM').AsInteger;

    itemMenu := TMenuItem.Create(bsPopupMenuFavoritos);
    itemMenu.Caption := item.Caption;
    itemMenu.ImageIndex := item.ImageIndex;
    itemMenu.OnClick := mnAbreFavoritoClick;
    itemMenu.Tag := ogFavoritos.Items.Count-1;
    itemMenu.Checked := false;
    itemMenu.RadioItem := True;

    if (PageControl1.Visible = true) and (DM.cdsFavoritos.FieldByName('NOME_ABA').AsString = PageControl1.ActivePage.Name) then
    begin
      i := ogFavoritos.Items.Count-1;
      itemMenu.Checked := True;
    end;

    bsPopupMenuFavoritos.Items.Insert(bsPopupMenuFavoritos.Items.Count - 4, itemMenu);
    DM.cdsFavoritos.Next;
  end;

  ogFavoritos.ItemIndex := i;
end;

procedure TfmIndex.carregaItemLiturgia(item: string; ordem: integer);
var
  i: integer;
  tipo,subtipo: string;
  panel,panel2: TPanel;
  image: TbsPngImageView;
  checkbox: TbsSkinCheckBox;
  slabel: TbsSkinStdLabel;
  pb: Boolean;
begin
  tipo := lerParam(item, 'tipo', '', arq_liturgia);
  subtipo := lerParam(item, 'subtipo', '', arq_liturgia);

  panel := TPanel(FindComponent(item));
  if Assigned(Panel) then
  begin
    for i := pred(panel.ControlCount) downto 0 do
    begin
      try
        if (panel.Controls[i].Visible) and (panel.Controls[i].Tag <> 9999)
          then panel.Controls[i].Destroy;
      except
        //
      end;
    end;
  end
  else
  begin
    panel := TPanel(CopyComponent(lit_modItem,sbLiturgia,item));
    panel.OnClick := lit_modItem.OnClick;

    panel2 := TPanel(CopyComponent(lit_modItem_btmove,panel,item+'_btmove'));
    panel2.OnMouseDown := lit_modItem_btmove.OnMouseDown;
    panel2.OnMouseMove := lit_modItem_btmove.OnMouseMove;
    panel2.OnMouseUp := lit_modItem_btmove.OnMouseUp;
    panel2.Visible := not cbBloqItens.Checked;
    image := TbsPngImageView(CopyComponent(lit_modItem_btmove_img,panel2,item+'_btmove_img'));
    image.OnMouseDown := lit_modItem_btmove_img.OnMouseDown;
    image.OnMouseMove := lit_modItem_btmove_img.OnMouseMove;
    image.OnMouseUp := lit_modItem_btmove_img.OnMouseUp;
    image := TbsPngImageView(CopyComponent(lit_modItem_btedit,panel,item+'_btedit'));
    image.OnClick := lit_modItem_btedit.OnClick;
    image.Visible := not cbBloqItens.Checked;
    CopyComponent(lit_modItem_divider,panel,item+'_divider');
  end;

  if (tipo <> 'categoria') then
  begin
    panel2 := TPanel(CopyComponent(lit_modItem_bticon,panel,item+'_bticon'));
    panel2.OnClick := lit_modItem_bticon.OnClick;
    panel2.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    image := TbsPngImageView(CopyComponent(lit_modItem_bticon_img,panel2,item+'_bticon_img'));
    image.OnClick := lit_modItem_bticon_img.OnClick;
    panel2 := TPanel(CopyComponent(lit_modItem_texto,panel,item+'_texto'));
    panel2.OnClick := lit_modItem_texto.OnClick;
    slabel := TbsSkinStdLabel(CopyComponent(lit_modItem_subtitulo,panel2,item+'_subtitulo'));
    slabel.OnClick := lit_modItem_subtitulo.OnClick;
    if (tipo = 'itensagendados') then
    begin
      slabel.Caption := '';
      if not DM.cdsItensAgendados.Active then
      begin
        DM.cdsItensAgendados.CreateDataSet;
        DM.cdsItensAgendados.IndexName := '';
        DM.cdsItensAgendados.IndexFieldNames := 'DATA';
        DM.cdsItensAgendados.LogChanges := False;
      end;

      if (FileExists(dir_dados + 'itensAgendados.xml')) then
        DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
      DM.cdsItensAgendados.Open;

      DM.cdsItensAgendados.Filtered := false;
      if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([lerParam(item, 'id', '', arq_liturgia),IncDay(now(),strtoint(loadCol.Strings.Values['LITURGIA:SEMANA']) - dayofweek(now()))]), []))
        then slabel.Caption := 'Arquivo '+DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString
        else slabel.Caption := 'Não há arquivo agendado para esta data!';
    end
    else slabel.Caption := lerParam(item, 'subitem', '', arq_liturgia);
    slabel := TbsSkinStdLabel(CopyComponent(lit_modItem_titulo,panel2,item+'_titulo'));
    slabel.OnClick := lit_modItem_titulo.OnClick;
    slabel.Caption := lerParam(item, 'item', '', arq_liturgia);
    slabel.Align := alTop;
    checkbox := TbsSkinCheckBox(CopyComponent(lit_modItem_checkb,panel,item+'_checkb'));
    checkbox.OnClick := lit_modItem_checkb.OnClick;
    checkbox.Checked := (lerParam(item, 'checked', '', arq_liturgia) = FormatDateTime('dd/mm/yyyy',Now()));
    panel.AlignWithMargins := false;
    panel.Height := 56;
  end
  else
  begin
    panel2 := TPanel(CopyComponent(lit_modItem_bticon,panel,item+'_bticon'));
    panel2.OnClick := PanelColorClick;
    panel2.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    panel2.Align := alClient;
//    panel.Color := StringToColor(lerParam(item, 'cor', '$004F0000', arq_liturgia));
    panel.Height := 36;
    panel.AlignWithMargins := True;
    panel.Margins.Top := 20;
    panel.Margins.Left := 0;
    panel.Margins.Right := 0;
    panel.Margins.Bottom := 0;
    //panel3 := TPanel(CopyComponent(lit_modItem_texto,panel2,item+'_texto'));
    //panel3.OnClick := lit_modItem_texto.OnClick;
    slabel := TbsSkinStdLabel(CopyComponent(lit_modItem_titulo,panel2,item+'_titulo'));
    slabel.Align := alClient;
    slabel.UseSkinColor := false;
    slabel.Font.Color := clWhite;
//    slabel.OnClick := lit_modItem_titulo.OnClick;
    slabel.Caption := lerParam(item, 'item', '', arq_liturgia);
    slabel.Font.Color := clWhite;
    slabel.Align := alClient;
    slabel.Alignment := taCenter;
    slabel.Layout := tlCenter;
  end;

  if (pnlModDes.Visible)
    then slabel.Caption := slabel.Caption + ' | ' + item + ' ['+inttostr(ordem)+']';

  if (tipo = 'musica') then
  begin
    if (subtipo = 'hasd')
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 47
    else if (subtipo = 'ja')
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 46
    else if (subtipo = 'div')
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 45
    else TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 60;

    if lerParam(item, 'musica', '0', arq_liturgia) = '-1'
      then pb := true
    else
    begin
      DM.qrMUSICA.Close;
      DM.qrMUSICA.ParamByName('ID').Value := StrToInt('0'+lerParam(item, 'musica', '0', arq_liturgia));
      DM.qrMUSICA.Open;
      if DM.qrMUSICA.RecordCount <= 0
        then pb := true
      else if (DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString <> '')
        then pb := True
        else pb := False;
    end;

    image := TbsPngImageView(CopyComponent(lit_modItem_icomus1,panel,item+'_icomus1'));
    image.OnClick := lit_modItem_icomus1.OnClick;
    if pb then
    begin
      image := TbsPngImageView(CopyComponent(lit_modItem_icomus2,panel,item+'_icomus2'));
      image.OnClick := lit_modItem_icomus2.OnClick;
    end;
    image := TbsPngImageView(CopyComponent(lit_modItem_icomus3,panel,item+'_icomus3'));
    image.OnClick := lit_modItem_icomus3.OnClick;
    image := TbsPngImageView(CopyComponent(lit_modItem_icomus4,panel,item+'_icomus4'));
    image.OnClick := lit_modItem_icomus4.OnClick;
    if pb then
    begin
      image := TbsPngImageView(CopyComponent(lit_modItem_icomus5,panel,item+'_icomus5'));
      image.OnClick := lit_modItem_icomus5.OnClick;
    end;
    image := TbsPngImageView(CopyComponent(lit_modItem_icomus6,panel,item+'_icomus6'));
    image.OnClick := lit_modItem_icomus6.OnClick;
    TbsPngImageView(FindComponent(item+'_icomus6')).Left := 0;
    if pb then TbsPngImageView(FindComponent(item+'_icomus5')).Left := 0;
    TbsPngImageView(FindComponent(item+'_icomus4')).Left := 0;
    TbsPngImageView(FindComponent(item+'_icomus3')).Left := 0;
    if pb then TbsPngImageView(FindComponent(item+'_icomus2')).Left := 0;
    TbsPngImageView(FindComponent(item+'_icomus1')).Left := 0;
  end
  else if (tipo = 'site') then
  begin
    subtipo := lerParam(item, 'subitem', '', arq_liturgia);
    if  (Pos('.youtube.',subtipo) > 0)
     or (Pos('/youtube.',subtipo) > 0)
     or (Pos('.youtu.be.',subtipo) > 0)
     or (Pos('/youtu.be.',subtipo) > 0)
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 38
      else TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 49;
  end
  else
  if (tipo = 'arquivo') then
  begin
    if (subtipo = 'dir')
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 32
    else if (subtipo = 'arq')
      then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 4;
  end
  else
  if (tipo = 'anotacao')
    then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 63
  else
  if (tipo = 'itensagendados')
    then TbsPngImageView(FindComponent(item+'_bticon_img')).ImageIndex := 83;

  if (ordem > 0) then
    panel.Top := (panel.Height + 20) * (ordem + 3);

  panel.Visible := True;
end;

procedure TfmIndex.carregaLiturgia(semana: Integer);
var
  itens: TStringList;
  i: integer;
begin
  itens := TStringList.Create;
  itens.Delimiter := ';';
  itens.DelimitedText := lerParam('Geral', IntToStr(semana), '', arq_liturgia);

  lbLiturgia.Items.Clear;
  lbLiturgia.Items := itens;

  for i := pred(sbLiturgia.ControlCount) downto 0 do
  begin
    if sbLiturgia.Controls[i].Visible
      then sbLiturgia.Controls[i].Destroy;
  end;

  if (lbLiturgia.Items.Count > 0) and
    (trim(lbLiturgia.Items[lbLiturgia.Items.Count-1]) = '')
    then lbLiturgia.Items.Delete(lbLiturgia.Items.Count-1);

  for i := 0 to lbLiturgia.Items.Count-1 do
    carregaItemLiturgia(lbLiturgia.Items[i],i+1);
end;

function TfmIndex.IsNumeric(S: string): boolean;
var
  i: integer;
begin
  Result := TryStrToInt(S, i);
end;

procedure TfmIndex.btRestaurarCapaProgramaClick(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a imagem de fundo?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  pnlImagemCapa.Color := pnlImagemCapaModel.Color;
  corCapaPrograma.ColorValue := pnlImagemCapa.Color;
  apagaParam('Config', 'Cor Fundo');

  cbAlinhamentoCapaPrograma.ItemIndex := 0;
  imgImagemCapa.Stretch := (cbAlinhamentoCapaPrograma.ItemIndex = 1);
  apagaParam('Config', 'Alinhamento Imagem Fundo');

  imgImagemCapa.Picture := imgImagemCapaModel.Picture;
  imgCapaPrograma.Text := '';
  txtImgCapaProgramaInfo.Text := '';
  apagaParam('Config', 'Imagem Fundo');
  apagaParam('Config', 'Imagem Fundo Info');
end;

function TfmIndex.verVersao():Boolean;
var
  versao_atu: TStringList;
  versao_new: TStringList;
  versao_min: TStringList;
begin
  DM.qrVERSAO.Close;
  DM.qrVERSAO.Open;

  versao_atu := TStringList.Create;
  versao_atu.Delimiter := '.';
  versao_atu.DelimitedText := VersaoExe + '.' + DM.qrVERSAO.fieldbyname('VERSAO_BD').AsString;

  versao_min := TStringList.Create;
  versao_min.Delimiter := '.';
  versao_min.DelimitedText := VERSAO_MIN_BD;

  lblVersao.Caption := versao_atu[0] + '.' + versao_atu[1] + '.' + versao_atu[4] + '.' + versao_atu[5];
  spVersao.Caption := 'versão '+lblVersao.Caption+' ';

  if (StrToInt(trim(versao_atu[4])) < StrToInt(trim(versao_min[0]))) or
     (
        (StrToInt(trim(versao_atu[4])) = StrToInt(trim(versao_min[0]))) and
        (StrToInt(trim(versao_atu[5])) < StrToInt(trim(versao_min[1])))
     ) then
  begin
    Result := True;
    Application.MessageBox(PChar('Esta versão do sistema exige o banco de dados (config/BD.mdb) mais recente.' + #13#10 + 'Utilize o banco de dados disponibilizado no pacote desta versão!'), TITULO, mb_ok + mb_iconexclamation);
    Application.Terminate;
    Exit;
  end;

  if (Trim(param.Strings.Values['versao'+fIniciando.LANG]) = '') then
  begin
    Result := false;
    Exit;
  end;

  versao_new := TStringList.Create;
  versao_new.Delimiter := '.';
  versao_new.DelimitedText := param.Strings.Values['versao'+fIniciando.LANG];

  if (StrToInt(trim(versao_atu[0])) < StrToInt(trim(versao_new[0]))) or
     (
        (StrToInt(trim(versao_atu[0])) = StrToInt(trim(versao_new[0]))) and
        (StrToInt(trim(versao_atu[1])) < StrToInt(trim(versao_new[1])))
     ) or
     (
        (StrToInt(trim(versao_atu[0])) = StrToInt(trim(versao_new[0]))) and
        (StrToInt(trim(versao_atu[1])) = StrToInt(trim(versao_new[1]))) and
        (StrToInt(trim(versao_atu[4])) < StrToInt(trim(versao_new[2])))
     ) or
     (
        (StrToInt(trim(versao_atu[0])) = StrToInt(trim(versao_new[0]))) and
        (StrToInt(trim(versao_atu[1])) = StrToInt(trim(versao_new[1]))) and
        (StrToInt(trim(versao_atu[4])) = StrToInt(trim(versao_new[2]))) and
        (StrToInt(trim(versao_atu[5])) < StrToInt(trim(versao_new[3])))
     ) then
  begin
    Result := True;
    btwsspDownload.Left := 0;
    btwsspDownload.Visible := true;
    btwsDownload.Left := 0;
    btwsDownload.Visible := true;

    fIniciando.AppCreateForm(TfNovaVersao, fNovaVersao);
    fNovaVersao.lblVAtu.Caption := versao_atu[0]+'.'+versao_atu[1]+'.'+versao_atu[4]+'.'+versao_atu[5];
    fNovaVersao.lblVNova.Caption := versao_new[0]+'.'+versao_new[1]+'.'+versao_new[2]+'.'+versao_new[3];
    fNovaVersao.showmodal;
  end
  else Result := False;
end;

procedure TfmIndex.tsSorteioNMShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsSorteioNM,tsSorteioNM);
  marcaAbaAberta(tsSorteioNM);
  carrega_opc := True;

  if (loadCol.Strings.Values['SORTEIO_NOMES'] <> 'ok') then
  begin
    loadCol.Strings.Values['SORTEIO_NOMES'] := 'ok';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO_NOMES');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsSorteioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsSorteio,tsSorteio);
  marcaAbaAberta(tsSorteio);
  carrega_opc := True;

  if (loadCol.Strings.Values['SORTEIO'] <> 'ok') then
  begin
    loadCol.Strings.Values['SORTEIO'] := 'ok';
    loadCol.Strings.Values['SORTEIO_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsTextoInterativoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsTextoInterativo,tsTextoInterativo);
  marcaAbaAberta(tsTextoInterativo);
  carrega_opc := True;

  if (loadCol.Strings.Values['TEXTOI'] <> 'okf') then
  begin
    loadCol.Strings.Values['TEXTOI'] := 'okf';
    RichEdit0.Lines.Clear;
    carregaConfiguracoes('TEXTOI');
    RichEdit0.DefaultFont.Name := 'Tahoma';
    fcTxtI0.FontName := RichEdit0.DefaultFont.Name;
    seTxtITamanho0.Text := IntToStr(RichEdit0.DefaultFont.Size);
    RichEditEnter(RichEdit0);
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsCronometroShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsCronometro,tsCronometro);
  marcaAbaAberta(tsCronometro);
  carrega_opc := True;

  if (loadCol.Strings.Values['CRONO'] <> 'ok') then
  begin
    loadCol.Strings.Values['CRONO'] := 'ok';
    loadCol.Strings.Values['CRONO_IMG'] := '|';
    loadCol.Strings.Values['CRONO_IMG_E'] := '|';

    carregaConfiguracoes('CRONO');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsCronoCultoShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsCronoCulto,tsCronoCulto);
  marcaAbaAberta(tsCronoCulto);
  carrega_opc := True;

  if (loadCol.Strings.Values['ES'] <> 'ok') then
  begin
    loadCol.Strings.Values['ES'] := 'ok';
    loadCol.Strings.Values['ES_IMG'] := '|';
    loadCol.Strings.Values['ES_IMG_E'] := '|';

    rbgAudioES.Visible := (fIniciando.LANG <> 'ES');

    carregaConfiguracoes('ES');
  end;
  DM.tmrRelogioTimer(Sender);
  carrega_opc := False;
end;

procedure TfmIndex.txtDecrChange(Sender: TObject);
begin
  btZerarCronoClick(Sender);
end;

procedure TfmIndex.txtDecrExit(Sender: TObject);
begin
  txtDecr.text := StringReplace(txtDecr.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);

  try
    StrToTime(txtDecr.Text)
  except
    application.MessageBox('Tempo inválido!', TITULO, mb_ok + mb_iconerror);
    txtDecr.text := '00:01:00';
    txtDecr.SetFocus;
  end;

  gravaParam('Cronometro', 'Tempo Decrescente', txtDecr.Text);
end;

function TfmIndex.lerParam(Grupo, Param, Valor, Arquivo, Diretorio:string): string;
var
  ArqIni: TIniFile;
  vl: string;
  dir: string;
begin
  if Arquivo = '' then
    Arquivo := 'config'+fIniciando.LANG+'.ja';

  vl := Valor;
  if (Trim(Diretorio) <> '')
    then dir := Diretorio
    else dir := dir_dados;

  try
    ArqIni := TIniFile.Create(dir + Arquivo);
    try
      vl := ArqIni.ReadString(Grupo, Param, Valor);
    finally
      ArqIni.Free;
    end;
  except
    //
  end;
  result := vl;
end;

function TfmIndex.getVideoID(link: string): string;
begin
  if Pos('v=', link) > 0 then
    link := Copy(link, Pos('v=', link) + 2, length(link));

  if Pos('&', link) > 0 then
    link := Copy(link, 0, Pos('&', link) - 1);

  if Pos('#', link) > 0 then
    link := Copy(link, 0, Pos('#', link) - 1);

  result := link;
end;

procedure TfmIndex.gravaLog(txt:string);
begin
  mmLog.Lines.Add(FormatDateTime('dd/mm/yyyy HH:MM:SS.ZZZ', now()) + '    ' + txt);
end;

procedure TfmIndex.gravaParam(Grupo, Param, Valor, Arquivo: string);
var
  ArqIni: TIniFile;
begin
  if Arquivo = '' then
    Arquivo := 'config'+fIniciando.LANG+'.ja';

  try
    ArqIni := TIniFile.Create(dir_dados + Arquivo);
    try
      ArqIni.WriteString(Grupo, Param, Valor);
    finally
      ArqIni.Free;
    end;
  except
    //
  end;
end;

procedure TfmIndex.gravaParamServer(Grupo, Param, Valor: string);
var
  ArqIni: TIniFile;
  Arquivo: string;
begin
  Arquivo := 'file.ja';

  Valor := StringReplace(Valor, #13#10, '|', [rfIgnoreCase, rfReplaceAll]);
  Valor := StringReplace(Valor, #10, '|', [rfIgnoreCase, rfReplaceAll]);
  try
    ArqIni := TIniFile.Create(dir_config + 'server/file/' + Arquivo);
    try
      ArqIni.WriteString(Grupo, Param, Valor);
    finally
      ArqIni.Free;
    end;
  except
    //
  end;
end;

procedure TfmIndex.ajustaTexto(pagina: string;areaExpandida: Boolean);
begin
  if (pagina = 'BIBLIA') then
  begin
    if not (areaExpandida) then
    begin
      lmdBibliaTxt.Top := pnlBiblia.Height;
      lmdBibliaTxt.Left := pnlBiblia.Width;
      lmdBibliaTxt.AutoSize := False;
      lmdBibliaTxt.Height := 1;
      lmdBibliaTxt.Width := pnlBiblia.Width-20;
      lmdBibliaTxt.AutoSize := True;
      lmdBibliaTxt.Top := Trunc((pnlBiblia.Height/2) - (lmdBibliaTxt.Height/2));
      lmdBibliaTxt.Left := Trunc((pnlBiblia.Width/2) - (lmdBibliaTxt.Width/2));
      lmdBibliaTxt.Refresh;

      lmdBibliaInfo.Top := pnlBiblia.Height;
      lmdBibliaInfo.Left := pnlBiblia.Width;
      lmdBibliaInfo.AutoSize := False;
      lmdBibliaInfo.Height := 1;
      lmdBibliaInfo.Width := pnlBiblia.Width-20;
      lmdBibliaInfo.AutoSize := True;
      lmdBibliaInfo.Top := lmdBibliaTxt.Top + lmdBibliaTxt.Height;
      lmdBibliaInfo.Left := Trunc((pnlBiblia.Width) - (lmdBibliaInfo.Width))-10;
      lmdBibliaInfo.Refresh;
    end
    else
    begin
      with fMonitorBiblia do
      begin
        lmdBibliaTxt.Top := pnlBiblia.Height;
        lmdBibliaTxt.Left := pnlBiblia.Width;
        lmdBibliaTxt.AutoSize := False;
        lmdBibliaTxt.Height := 1;
        lmdBibliaTxt.Width := pnlBiblia.Width-20;
        lmdBibliaTxt.AutoSize := True;
        lmdBibliaTxt.Top := Trunc((pnlBiblia.Height/2) - (lmdBibliaTxt.Height/2));
        lmdBibliaTxt.Left := Trunc((pnlBiblia.Width/2) - (lmdBibliaTxt.Width/2));
        lmdBibliaTxt.Refresh;

        lmdBibliaInfo.Top := pnlBiblia.Height;
        lmdBibliaInfo.Left := pnlBiblia.Width;
        lmdBibliaInfo.AutoSize := False;
        lmdBibliaInfo.Height := 1;
        lmdBibliaInfo.Width := pnlBiblia.Width-20;
        lmdBibliaInfo.AutoSize := True;
        lmdBibliaInfo.Top := lmdBibliaTxt.Top + lmdBibliaTxt.Height;
        lmdBibliaInfo.Left := Trunc((pnlBiblia.Width) - (lmdBibliaInfo.Width))-10;
        lmdBibliaInfo.Refresh;
      end;
    end;
  end
  else if (pagina = 'BIBLIA_BUSCA') then
  begin
    if not (areaExpandida) then
    begin
      lmdBibliaBuscaTxt.Top := pnlBibliaBusca.Height;
      lmdBibliaBuscaTxt.Left := pnlBibliaBusca.Width;
      lmdBibliaBuscaTxt.AutoSize := False;
      lmdBibliaBuscaTxt.Height := 1;
      lmdBibliaBuscaTxt.Width := pnlBibliaBusca.Width-20;
      lmdBibliaBuscaTxt.AutoSize := True;
      lmdBibliaBuscaTxt.Top := Trunc((pnlBibliaBusca.Height/2) - (lmdBibliaBuscaTxt.Height/2));
      lmdBibliaBuscaTxt.Left := Trunc((pnlBibliaBusca.Width/2) - (lmdBibliaBuscaTxt.Width/2));
      lmdBibliaBuscaTxt.Refresh;

      lmdBibliaBuscaInfo.Top := pnlBibliaBusca.Height;
      lmdBibliaBuscaInfo.Left := pnlBibliaBusca.Width;
      lmdBibliaBuscaInfo.AutoSize := False;
      lmdBibliaBuscaInfo.Height := 1;
      lmdBibliaBuscaInfo.Width := pnlBibliaBusca.Width-20;
      lmdBibliaBuscaInfo.AutoSize := True;
      lmdBibliaBuscaInfo.Top := lmdBibliaBuscaTxt.Top + lmdBibliaBuscaTxt.Height;
      lmdBibliaBuscaInfo.Left := Trunc((pnlBibliaBusca.Width) - (lmdBibliaBuscaInfo.Width))-10;
      lmdBibliaBuscaInfo.Refresh;
    end
    else
    begin
      with fMonitorBibliaBusca do
      begin
        lmdBibliaBuscaTxt.Top := pnlBibliaBusca.Height;
        lmdBibliaBuscaTxt.Left := pnlBibliaBusca.Width;
        lmdBibliaBuscaTxt.AutoSize := False;
        lmdBibliaBuscaTxt.Height := 1;
        lmdBibliaBuscaTxt.Width := pnlBibliaBusca.Width-20;
        lmdBibliaBuscaTxt.AutoSize := True;
        lmdBibliaBuscaTxt.Top := Trunc((pnlBibliaBusca.Height/2) - (lmdBibliaBuscaTxt.Height/2));
        lmdBibliaBuscaTxt.Left := Trunc((pnlBibliaBusca.Width/2) - (lmdBibliaBuscaTxt.Width/2));
        lmdBibliaBuscaTxt.Refresh;

        lmdBibliaBuscaInfo.Top := pnlBibliaBusca.Height;
        lmdBibliaBuscaInfo.Left := pnlBibliaBusca.Width;
        lmdBibliaBuscaInfo.AutoSize := False;
        lmdBibliaBuscaInfo.Height := 1;
        lmdBibliaBuscaInfo.Width := pnlBibliaBusca.Width-20;
        lmdBibliaBuscaInfo.AutoSize := True;
        lmdBibliaBuscaInfo.Top := lmdBibliaBuscaTxt.Top + lmdBibliaBuscaTxt.Height;
        lmdBibliaBuscaInfo.Left := Trunc((pnlBibliaBusca.Width) - (lmdBibliaBuscaInfo.Width))-10;
        lmdBibliaBuscaInfo.Refresh;
      end;
    end;
  end;
end;

procedure TfmIndex.apagaItemLiturgia(item: string);
var
  Panel: TPanel;
begin
  Panel := TPanel(FindComponent(item));
  Panel.Visible := false;
  apagaParam(item,'',arq_liturgia);
  lbLiturgia.Items.Delete(lbLiturgia.Items.IndexOf(item));

  salvaItensLiturgia;
end;

procedure TfmIndex.apagaParam(Grupo, Param, Arquivo: string);
var
  ArqIni: TIniFile;
begin
  if Arquivo = '' then
    Arquivo := 'config'+fIniciando.LANG+'.ja';

  ArqIni := TIniFile.Create(dir_dados + Arquivo);
  try
    if (trim(Param) <> '') then
      ArqIni.DeleteKey(Grupo, Param)
    else
      ArqIni.EraseSection(Grupo);
  finally
    ArqIni.Free;
  end;
end;

procedure TfmIndex.cbAlinhamentoCapaProgramaChange(Sender: TObject);
begin
  imgImagemCapa.Stretch := (cbAlinhamentoCapaPrograma.ItemIndex = 1);
  gravaParam('Config', 'Alinhamento Imagem Fundo', inttostr(cbAlinhamentoCapaPrograma.ItemIndex));
end;

procedure TfmIndex.cbAnotacoesLiturgiaClick(Sender: TObject);
begin
  if cbAnotacoesLiturgia.Checked then
    gravaParam('Liturgia', 'ExibirAnotacoes', '1')
  else
    gravaParam('Liturgia', 'ExibirAnotacoes', '0');
  pnlAnotacoesLiturgia.Visible := cbAnotacoesLiturgia.Checked;
end;

procedure TfmIndex.cbBibliaHistoricoClick(Sender: TObject);
begin
  if cbBibliaHistorico.Checked then
    gravaParam('Biblia', 'Historico', '1')
  else
    gravaParam('Biblia', 'Historico', '0');
  pnlBibliaHistorico.Visible := cbBibliaHistorico.Checked;
  ajustaTexto('BIBLIA');
end;

procedure TfmIndex.cbBloqItensClick(Sender: TObject);
begin
  if cbBloqItens.Checked then
    gravaParam('Liturgia', 'BloquearItens', '1')
  else
    gravaParam('Liturgia', 'BloquearItens', '0');

  LiturgiaCalendarClick(nil);
  btApagaLitSel.Enabled := not cbBloqItens.Checked;
end;

procedure TfmIndex.cbColetaneasPersoChange(Sender: TObject);
begin
  if DM.cdsCOLETANEAS_PERSO.Active = false then
    Exit;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', cbColetaneasPerso.KeyValue, []);
  txtColetanea2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('NOME').AsString;
  txtAbrirColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('URL').AsString;
  txtUrlInfoColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('URL_INFO').AsString;
  txtCapaColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('IMAGEM').AsString;
  txtImgInfoColet2.Text := DM.cdsCOLETANEAS_PERSO.fieldbyname('IMAGEM_INFO').AsString;
end;

procedure TfmIndex.cbCronoElClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if cbCronoEl.ItemChecked[0] then
    gravaParam('Cronometro', 'Tempos Gravados (Extendido)', '1')
  else
    gravaParam('Cronometro', 'Tempos Gravados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.cbEscSBRelogioFuncClick(Sender: TObject);
begin
  if cbEscSBRelogioFunc.Checked then
    gravaParam('Escola Sabatina', 'RelogioSempreAtivo', '1')
  else
    gravaParam('Escola Sabatina', 'RelogioSempreAtivo', '0');
end;

procedure TfmIndex.cbEscSBZerarTempoClick(Sender: TObject);
begin
  if cbEscSBZerarTempo.Checked then
    gravaParam('Escola Sabatina', 'DesligarZerarTempo', '1')
  else
    gravaParam('Escola Sabatina', 'DesligarZerarTempo', '0');
end;

procedure TfmIndex.cbMarcarConcClick(Sender: TObject);
begin
  if cbMarcarConc.Checked then
    gravaParam('Liturgia', 'MarcarConcluido', '1')
  else
    gravaParam('Liturgia', 'MarcarConcluido', '0');
end;

procedure TfmIndex.cbMusicaChange(Sender: TObject);
begin
  try
    mpMusica.Stop;
  except
    //
  end;
  btOuvir.Caption := 'Ouvir';
  btOuvir.Down := False;
  btOuvir.ImageIndex := 7;
  selMusica();
end;

procedure TfmIndex.cbPosicaoFundoClick(Sender: TObject);
var
  tag: integer;
  valor: string;
begin
  if carrega_opc then
    Exit;

  tag := TbsSkinComboBoxEx(Sender).tag;
  valor := IntToStr(TbsSkinComboBoxEx(Sender).ItemIndex+1);
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Posicao Fundo', valor);
    loadCol.Strings.Values['BIBLIA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Posicao Fundo', valor);
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Posicao Fundo', valor);
    loadCol.Strings.Values['ES_IMG'] := '|';
    loadCol.Strings.Values['ES_IMG_E'] := '|';
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Posicao Fundo', valor);
    loadCol.Strings.Values['SORTEIO_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Posicao Fundo', valor);
    loadCol.Strings.Values['CRONO_IMG'] := '|';
    loadCol.Strings.Values['CRONO_IMG_E'] := '|';
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Posicao Fundo', valor);
    loadCol.Strings.Values['SORTEIO_NOMES_IMG'] := '|';
    loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Posicao Fundo', valor);
    loadCol.Strings.Values['PAINELD_IMG'] := '|';
    loadCol.Strings.Values['PAINELD_IMG_E'] := '|';
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Posicao Fundo', valor);
    loadCol.Strings.Values['RELOGIO_IMG'] := '|';
    loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.cbRelogioAlinhamentoChange(Sender: TObject);
var
  tag: integer;
  valor: string;
begin
  if carrega_opc then
    Exit;

  tag := TbsSkinComboBoxEx(Sender).tag;
  valor := IntToStr(TbsSkinComboBoxEx(Sender).ItemIndex);
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Alinhamento', valor);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Alinhamento', valor);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Alinhamento', valor);
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Alinhamento', valor);
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Alinhamento', valor);
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Alinhamento', valor);
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Alinhamento', valor);
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Alinhamento', valor);
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.cbRemoveItensAgendadosClick(Sender: TObject);
begin
  if cbRemoveItensAgendados.Checked then
    gravaParam('Itens Agendados', 'RemovePassados', '1')
  else
    gravaParam('Itens Agendados', 'RemovePassados', '0');
end;

function TfmIndex.cds2texto(cds: TClientDataSet; campo: string): TStringList;
var
  texto: TStringList;
  linha: string;
  pos: Integer;
begin
  if not cds.Active then
  begin
    cds.CreateDataSet;
    cds.LogChanges := False;
  end;

  texto := TStringList.Create;
  pos := cds.RecNo;
  cds.First;
  while not cds.Eof do
  begin
    linha := cds.FieldByName(campo).AsString;
    linha := StringReplace(linha, #13#10, '|', [rfIgnoreCase, rfReplaceAll]);
    texto.Add(linha);
    cds.Next;
  end;
  cds.RecNo := pos;
  Result := texto;
end;

procedure TfmIndex.selMusica;
begin
  if not rbgAudioES.Visible then Exit;

  if (cbMusica.ItemIndex = 0) then
    mpMusica.FileName := dir_config + 'abertura_escsb.mp3'
  else if (cbMusica.ItemIndex = 1) then
    mpMusica.FileName := dir_config + '5minutos_escsb.mp3'
  else
    mpMusica.FileName := dir_config + '1minuto_escsb.mp3';
  try
    mpMusica.Open;
  except
    //
  end;
end;

function TfmIndex.maiorLista(L: string): string;
var
  str: TStringList;
  m: string;
  i: integer;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(L), str);
  m := '0';
  for i := 0 to str.Count-1 do
  begin
    if StrToInt(str[i]) > StrToInt(m) then
      m := str[i];
  end;
  result := m;
end;

procedure TfmIndex.marcaAbaAberta(TabSheet: TbsSkinTabSheet);
begin
  pnlTitForm.Caption := TITULO;
  if (TabSheet.Tag > -1) then
  begin
    bsPopupMenuRibon.Items[TabSheet.Tag].Checked := True;

    if not DM.cdsFavoritos.Active then
      carregaFavoritos;

    carrega_opc := True;

    if (DM.cdsFavoritos.Locate('NOME_ABA', TabSheet.Name, [])) then
    begin
      ogFavoritos.ItemIndex := DM.cdsFavoritos.recno-1;
      bsPopupMenuFavoritos.Items[DM.cdsFavoritos.recno-1].Checked := True;
      botoesFavoritos('del');
    end
    else
    begin
      ogFavoritos.ItemIndex := DM.cdsFavoritos.RecordCount;
      bsPopupMenuFavoritos.Items[0].Checked := True;
      bsPopupMenuFavoritos.Items[0].Checked := False;
      botoesFavoritos('add');
    end;

    carrega_opc := False;

    pnlTitForm.Caption := TabSheet.Caption + ' - ' + TITULO;
  end;
end;

procedure TfmIndex.meESDuracaoChange(Sender: TObject);
begin
  gravaParam('Escola Sabatina', 'Duracao', meESDuracao.Text);
end;

procedure TfmIndex.meESHoraChange(Sender: TObject);
begin
  gravaParam('Escola Sabatina', 'Hora', meESHora.Text);
end;

procedure TfmIndex.meESHoraExit(Sender: TObject);
begin
  meESHora.text := StringReplace(meESHora.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);

  try
    StrToTime(meESHora.Text)
  except
    application.MessageBox('Hora inválida!', TITULO, mb_ok + mb_iconerror);
    meESHora.Text := '00:00';
    meESHora.SetFocus;
    Exit;
  end;
end;

function TfmIndex.menorLista(L: string): string;
var
  str: TStringList;
  m: string;
  i: integer;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(L), str);
  m := '0';
  for i := 0 to str.Count-1 do
  begin
    if m = '0' then
      m := str[i];

    if (StrToInt(str[i]) > 0) and (StrToInt(str[i]) < StrToInt(m)) then
      m := str[i];
  end;
  result := m;
end;

procedure TfmIndex.tsBuscaBiblicaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfBuscaBiblica,tsBuscaBiblica);
  marcaAbaAberta(tsBuscaBiblica);
  if (loadCol.Strings.Values['BIBLIA_BUSCA_F'] <> 'okf') then
  begin
    loadCol.Strings.Values['BIBLIA_BUSCA_F'] := 'okf';

    lmdBibliaBuscaTxt.Caption := '';
    lmdBibliaBuscainfo.Caption := '';

    if (fIniciando.LANG='ES') then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := lerParam('Busca Biblica', 'Versão', 'RV');
    end
    else
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := lerParam('Busca Biblica', 'Versão', 'ARA');
    end;

    loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := '';

    ckLivros.Items.Clear;
    ckLivros2.Items.Clear;
    DM.qrBIBLIA_BUS_LIVROS.Close;
    DM.qrBIBLIA_BUS_LIVROS.Open;
    DM.qrBIBLIA_BUS_LIVROS.First;
    while not DM.qrBIBLIA_BUS_LIVROS.Eof do
    begin
      ckLivros.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      ckLivros2.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      ckLivros.Checked[ckLivros.Items.Count-1] := true;
      ckLivros2.Checked[ckLivros2.Items.Count-1] := true;
      DM.qrBIBLIA_BUS_LIVROS.Next;
    end;

    carregaBiblia('VER2');
    carregaBiblia('BUS');
  end;

  if (loadCol.Strings.Values['BIBLIA_BUSCA'] <> 'ok') then
  begin
    DBCtrlGridBibliaBusca.RowCount := Trunc(DBCtrlGridBibliaBusca.ClientHeight / 75);
    DBCtrlGridBibliaBusca.ColCount := 1;

    loadCol.Strings.Values['BIBLIA_BUSCA'] := 'ok';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';

    carregaConfiguracoes('BIBLIA_BUSCA');
  end;
  txtBibLocaliza.SetFocus;
end;

procedure TfmIndex.txtUrlVideoOn2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btUrlVideoOn2Click(nil);
end;

procedure TfmIndex.txtUrlVideoOn3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btAddVideoOn3Click(nil);
end;

procedure TfmIndex.txtUrlVideoOnKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edtKeyUp(Sender,Key,Shift);
  if Key = VK_RETURN then
    btUrlVideoOnClick(nil);
end;

procedure TfmIndex.btMusicaSlideMusicaClick(Sender: TObject);
var
  txt: string;
begin
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  if DM.qrBUSCA.Active = false then
    exit;

  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    txtHino.SetFocus;
    Exit;
  end;

  if (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString = 'S') then
  begin
    if (TComponent(Sender).Tag) = 2
      then application.MessageBox('Não é possível abrir side playback de coletâneas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else if (TComponent(Sender).Tag) = 3
      then application.MessageBox('Não é possível abrir slide sem música de coletâneas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else abreVideoOn(DM.qrBUSCA.fieldbyname('ID').AsString, DM.qrBUSCA.fieldbyname('NOME').AsString);
  end
  else if (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString = 'S') then
  begin
    if (TComponent(Sender).Tag) = 2
      then application.MessageBox('Não é possível abrir side playback de coletâneas personalizadas!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else if (TComponent(Sender).Tag) = 3
      then application.MessageBox('Não é possível abrir slide sem música de coletâneas personalizadas!', TITULO, mb_ok + MB_ICONEXCLAMATION)
    else
    begin
      if FileExists(DM.qrBUSCA.fieldbyname('URL').AsString) then
      begin
        abrirArquivo(DM.qrBUSCA.fieldbyname('URL').AsString);
        Exit;
      end
      else
      if DirectoryExists(DM.qrBUSCA.fieldbyname('URL').AsString) then
      begin
        fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
        fListaMusica.id_album := 0;
        fListaMusica.inicio := false;
        fListaMusica.Caption := DM.qrBUSCA.fieldbyname('NOME').AsString;
        fListaMusica.lblTitulo.Caption := DM.qrBUSCA.fieldbyname('NOME').AsString;
        fListaMusica.lblSubtitulo.Caption := '';
        fListaMusica.dir := DM.qrBUSCA.fieldbyname('URL').AsString;
        fListaMusica.DBCtrlGrid.DataSource := DM.dsArquivos;
        fListaMusica.pnlBotoes.Visible := False;
        fListaMusica.showmodal;
      end
      else
      begin
        application.MessageBox(PChar('Arquivo "'+DM.qrBUSCA.fieldbyname('URL').AsString+' não localizado"!'), fmIndex.titulo, mb_ok + mb_iconerror)
      end;
    end;
  end
  else
    abreLetraMusica('BD',txt,DM.qrBUSCA.FieldByName('ID').AsInteger,(TComponent(Sender).Tag) < 3);
end;

procedure TfmIndex.lit_modItem_bteditClick(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
  fLiturgia.Caption := 'Alterar Item';
  fLiturgia.id := TPanel(Sender).Parent.Name;
  fLiturgia.ShowModal;
end;

procedure TfmIndex.lit_modItem_checkbClick(Sender: TObject);
var
  Panel: TPanel;
begin
  Panel := TPanel(TPanel(Sender).Parent);

  if TbsSkinCheckBox(Sender).Checked then
  begin
    gravaParam(Panel.Name, 'checked', FormatDateTime('dd/mm/yyyy',Now()), arq_liturgia);
    TbsSkinStdLabel(FindComponent(Panel.Name+'_titulo')).Font.Style := [fsBold,fsStrikeOut];
    TbsSkinStdLabel(FindComponent(Panel.Name+'_subtitulo')).Font.Style := [fsStrikeOut];
    Panel.Color := $00CED5FF;
  end
  else
  begin
    gravaParam(Panel.Name, 'checked', '', arq_liturgia);
    TbsSkinStdLabel(FindComponent(Panel.Name+'_titulo')).Font.Style := [fsBold];
    TbsSkinStdLabel(FindComponent(Panel.Name+'_subtitulo')).Font.Style := [];
    Panel.Color := clWhite;
  end;
end;

procedure TfmIndex.lit_modItem_textoClick(Sender: TObject);
var
  Panel: TPanel;
  item,subitem: string;
  id,tag: Integer;
  txt:string;
begin
  if Sender is TbsSkinStdLabel
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);
  item := Panel.Name;
  if (lerParam(item, 'tipo', '', arq_liturgia) = 'categoria') then
  begin
    DM.ColorDialog.Color := Panel.Color;
    DM.ColorDialog.Execute;
    Panel.Color := DM.ColorDialog.Color;

    gravaParam(item, 'cor', ColorToString(DM.ColorDialog.Color), arq_liturgia);
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'musica') then
  begin
    if (lerParam(item, 'escolha', '0', arq_liturgia) = '1') then
    begin
      fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
      fBuscaMusica.ShowModal;
      if (fBuscaMusica.id) > 0
        then id := fBuscaMusica.id
        else Exit;
    end
    else
      id := StrToInt('0'+lerParam(item, 'musica', '0', arq_liturgia));

    tag := TComponent(Sender).Tag;

    if (tag = 4) then
      abreArquivoMusica(id)
    else if (tag = 5) then
    begin
      DM.qrMUSICA.Close;
      DM.qrMUSICA.ParamByName('ID').Value := id;
      DM.qrMUSICA.Open;

      if (DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString = '')
        then application.MessageBox(PChar('Esta música não possui playback!'), titulo, mb_ok + MB_ICONEXCLAMATION)
        else abreArquivoMusica(id,DM.qrMUSICA.FieldByName('ALBUM').AsString,DM.qrMUSICA.FieldByName('URL_INSTRUMENTAL').AsString);
    end
    else if (tag = 6) then
      abreLetra(id)
    else
    begin
      if Tag = 2
        then txt := 'PB'
        else txt := '';
      abreLetraMusica('BD',txt,id,(tag < 3));
    end;
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'site') then
  begin
    if (sbVideoOnAbreLiturgia.ItemIndex = 1) then
    begin
      subitem := lerParam(item, 'url', '0', arq_liturgia);
      if
       (Pos('v=', subitem) > 0)
       and (
          (Pos('.youtube.',subitem) > 0)
       or (Pos('/youtube.',subitem) > 0)
       or (Pos('.youtu.be.',subitem) > 0)
       or (Pos('/youtu.be.',subitem) > 0)
       )
        then abreVideoOn(getVideoID(subitem), lerParam(item, 'item', '0', arq_liturgia))
        else abrirArquivo(lerParam(item, 'url', '', arq_liturgia));
    end
    else abrirArquivo(lerParam(item, 'url', '', arq_liturgia));
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'arquivo') then
  begin
    if (lerParam(item, 'dir_info', 'E', arq_liturgia) = 'I')
      then subitem := ExtractFilePath(Application.ExeName)+lerParam(item, 'dir', '', arq_liturgia)
      else subitem := lerParam(item, 'dir', '', arq_liturgia);

    if FileExists(subitem)
      then abrirArquivo(subitem)
    else if DirectoryExists(subitem) then
    begin
      if (Copy(subitem,Length(subitem),1)) <> '\'
        then subitem := subitem + '\';

      abrirArquivo(openDialog('arquivo', '', '.',false,subitem));
    end
    else application.MessageBox('Arquivo ou diretório não encotrado!',TITULO,mb_ok+mb_iconerror);
  end
  else if (lerParam(item, 'tipo', '', arq_liturgia) = 'itensagendados') then
  begin
    subitem := lerParam(item, 'id', '', arq_liturgia);

    if not DM.cdsItensAgendados.Active then
    begin
      DM.cdsItensAgendados.CreateDataSet;
      DM.cdsItensAgendados.IndexName := '';
      DM.cdsItensAgendados.IndexFieldNames := 'DATA';
      DM.cdsItensAgendados.LogChanges := False;
    end;

    if (FileExists(dir_dados + 'itensAgendados.xml')) then
      DM.cdsItensAgendados.LoadFromFile(dir_dados + 'itensAgendados.xml');
    DM.cdsItensAgendados.Open;

    DM.cdsItensAgendados.Filtered := false;
    if not (DM.cdsItensAgendados.Locate('CATEGORIA', subitem, [])) then
    begin
      if not DM.cdsCategoriasItensAgendados.Active then
      begin
        DM.cdsCategoriasItensAgendados.CreateDataSet;
        DM.cdsCategoriasItensAgendados.IndexName := '';
        DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
        DM.cdsCategoriasItensAgendados.LogChanges := False;
      end;

      if (FileExists(dir_dados + 'itensAgendadosCategorias.xml')) then
        DM.cdsCategoriasItensAgendados.LoadFromFile(dir_dados + 'itensAgendadosCategorias.xml');
      DM.cdsCategoriasItensAgendados.Open;

      if not (DM.cdsCategoriasItensAgendados.Locate('ID', subitem, []))
        then application.MessageBox(PChar('Categoria '''+lerParam(item, 'item', '', arq_liturgia)+''' não encontrada. Será necessário corrigir este item!'),TITULO,mb_ok+MB_ICONERROR)
        else application.MessageBox(PChar('Não foi encontrado '''+lerParam(item, 'item', '', arq_liturgia)+''' agendado para esta data!'),TITULO,mb_ok+MB_ICONEXCLAMATION);
    end
    else if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([subitem,IncDay(now(),strtoint(loadCol.Strings.Values['LITURGIA:SEMANA']) - dayofweek(now()))]), [])) then
    begin

      if (DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').AsString = 'I')
        then subitem := ExtractFilePath(Application.ExeName)+DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString
        else subitem := DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString;

      if FileExists(subitem)
        then abrirArquivo(subitem)
      else
      begin
        application.MessageBox('Arquivo não encotrado!',TITULO,mb_ok+mb_iconerror);
        if DirectoryExists(ExtractFileDir(subitem))
          then subitem := ExtractFileDir(subitem)
        else subitem := '';

        abrirArquivo(openDialog('arquivo', '', 'ItemAgendadoLiturgia',false,subitem))
      end;

    end
    else application.MessageBox(PChar('Não foi encontrado '''+lerParam(item, 'item', '', arq_liturgia)+''' agendado para esta data!'),TITULO,mb_ok+MB_ICONEXCLAMATION);
    DM.cdsItensAgendados.Filtered := true;
  end;

  if (lerParam(item, 'tipo', '', arq_liturgia) <> 'categoria')
    and (cbMarcarConc.Checked) then
  begin
    TbsSkinCheckBox(FindComponent(item+'_checkb')).Checked := True;
  end;
end;

procedure TfmIndex.btLimparBBuscaClick(Sender: TObject);
begin
  lmdBibliaBuscaTxt.Caption := '';
  lmdBibliaBuscaInfo.Caption := '';
  loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := '';
  DBCtrlGridBibliaBusca.Refresh;
  copiaDadosTelaExtendida;
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', '');
     fmIndex.gravaParamServer('BIBLIA', 'info', '');
  end;
end;

procedure TfmIndex.btLimparClick(Sender: TObject);
begin
  lmdBibliaTxt.Caption := '';
  lmdBibliaInfo.Caption := '';
  loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
  loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '0';
  DBCtrlGridBibliaVersiculo.Refresh;
  copiaDadosTelaExtendida;
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', '');
     fmIndex.gravaParamServer('BIBLIA', 'info', '');
  end;
end;

procedure TfmIndex.Button1Click(Sender: TObject);
var
  arquivo:string;
  nome_arquivo: string;
  ordem: Integer;
  letra: TStringList;
  letra_ok: string;
  i,l,n: integer;
  uc: string;
  ZipFile: TZipFile;
  dir_t: string;
  str: string;
  nr,c: Integer;
begin
  letra := TStringList.Create;

  fmIndex.openDialog('geral', 'Apresentação LouvorJA (*.slja;*.lja)|*.slja;*.lja', '', true);
  for i := 0 to DM.OpenDialog.Files.Count - 1 do
  begin

    if not DM.cdsSLIDE_MUSICA2.Active then
    begin
      DM.cdsSLIDE_MUSICA2.CreateDataSet;
      DM.cdsSLIDE_MUSICA2.LogChanges := False;
    end;
    DM.cdsSLIDE_MUSICA2.Open;
    DM.cdsSLIDE_MUSICA2.EmptyDataSet;

    arquivo := DM.OpenDialog.Files[i];
    nome_arquivo := ExtractFileName(arquivo);


    if (arquivo <> '') then
    begin
      if (ExtractFileExt(arquivo) = '.slja') then
      begin
        ZipFile := TZipFile.Create;
        try
          dir_t := fmIndex.dir_temp+'~edit_'+FormatDateTime('yyyymmddHHMMSSZZZ', now());
          ZipFile.Open(arquivo, zmRead);
          ZipFile.ExtractAll(dir_t);
          ZipFile.Close;
          arquivo := dir_t+'\slides.lja';
        finally
          ZipFile.Free;
        end;
      end;
      copiaArquivoParaSlides(arquivo,DM.cdsSLIDE_MUSICA2,false,lbTempos);
    end
    else
      Continue;



    if (idMusica.Text = '') or (idMusica.Text = '0') then
    begin
      DM.cdsSLIDE_MUSICA2.First;
      DM.qrINSERE_MUSICA.Close;
      DM.qrINSERE_MUSICA.ParamByName('NOME').Value := DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').AsString;
      DM.qrINSERE_MUSICA.ParamByName('IMAGEM').Value := ExtractFileName(DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').AsString);
      DM.qrINSERE_MUSICA.ExecSQL;

      DM.qrSELECT_MAX_MUSICA.Close;
      DM.qrSELECT_MAX_MUSICA.Open;
      idMusica.Text := DM.qrSELECT_MAX_MUSICA.FieldByName('MAX_ID').AsString;
    end;

    if (idMusica.Text = '') or (idMusica.Text = '0') then
    begin
      application.MessageBox('Não foi possível inserir!', TITULO, mb_ok + mb_iconerror);
      Exit;
    end;

    DM.cdsSLIDE_MUSICA2.First;

    DM.qrSELECT_LETRA_MUSICA.Close;
    DM.qrSELECT_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
    DM.qrSELECT_LETRA_MUSICA.Open;
    DM.qrSELECT_LETRA_MUSICA.First;

    ordem := 0;
    while not DM.cdsSLIDE_MUSICA2.Eof do
    begin
      letra.Clear;
      letra_ok := '';
      uc := '';
      letra.Text := DM.cdsSLIDE_MUSICA2.FieldByName('LETRA').AsString;
      letra.Text := trim(letra.Text);
      letra.Text := AnsiUpperCase(Copy(letra.Text,1,1))+Copy(letra.Text,2,Length(letra.Text));
      letra.Text := StringReplace(letra.Text, '|', #13#10, [rfIgnoreCase, rfReplaceAll]);
      for l := 0 to letra.Count-1 do
      begin
        letra[l] := Trim(letra[l]);
        uc := Copy(letra[l],Length(letra[l]),1);
        if (uc = '.') or (uc = ',') or (uc = ';') then
          letra[l] := Copy(letra[l],1,Length(letra[l])-1);
        letra[l] := Trim(letra[l]);

        if Trim(letra[l]) <> '' then
        begin
          if Trim(letra_ok) <> '' then
            letra_ok := letra_ok+#13#10;
          letra_ok := letra_ok+letra[l];
        end;
      end;

      if DM.cdsSLIDE_MUSICA2.RecNo > 1 then
      begin
        if DM.qrSELECT_LETRA_MUSICA.Eof then
        begin
          ordem := ordem+1;
          DM.qrINSERE_LETRA_MUSICA.Close;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('LETRA').Value := letra_ok;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('TEMPO').Value := DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('ORDEM').Value := ordem;
          DM.qrINSERE_LETRA_MUSICA.ParamByName('IMAGEM').Value := ExtractFileName(DM.cdsSLIDE_MUSICA2.FieldByName('IMAGEM').AsString);
          DM.qrINSERE_LETRA_MUSICA.ExecSQL;
        end
        else
        begin
          DM.qrALTERA_LETRA_MUSICA.Close;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('MUSICA').Value := idMusica.Text;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('LETRA').Value := letra_ok;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('TEMPO').Value := DM.cdsSLIDE_MUSICA2.FieldByName('TEMPO').AsString;
          DM.qrALTERA_LETRA_MUSICA.ParamByName('ID').Value := DM.qrSELECT_LETRA_MUSICA.FieldByName('ID').AsInteger;
          DM.qrALTERA_LETRA_MUSICA.ExecSQL;
          DM.qrSELECT_LETRA_MUSICA.Next;
          ordem := DM.qrSELECT_LETRA_MUSICA.FieldByName('ORDEM').AsInteger;
        end;
      end;
      DM.cdsSLIDE_MUSICA2.Next;
    end;

    if ((idAlbum.Text <> '') and (idAlbum.Text <> '0')) then
    begin
      if (Trim(idFaixa.Text) = '') then idFaixa.Text := '0';
      if (idFaixa.Text = '0') then
      begin
        for n := 1 to Length(nome_arquivo) do
        begin
          str := Copy(nome_arquivo,n,1);
          val(str, nr, c);
          if c = 0 then
          begin
            idFaixa.Text := idFaixa.Text + str;
          end
          else Break;
        end;
      end;

      DM.qrINSERE_MUSICA_ALBUM.Close;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('ID_ALBUM').Value := idAlbum.Text;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('ID_MUSICA').Value := idMusica.Text;
      DM.qrINSERE_MUSICA_ALBUM.ParamByName('FAIXA').Value := idFaixa.Text;
      DM.qrINSERE_MUSICA_ALBUM.ExecSQL;
    end;

    idMusica.Text := '0';
    idFaixa.Text := '0';
  end;
  idMusica.SetFocus;
  application.MessageBox(PChar('Arquivos importados com sucesso!'), TITULO, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.Button2Click(Sender: TObject);
var
  lista: TStringList;
  Flags: Cardinal;
begin
  lista := TStringList.Create;
  lista.Add('_teste_ftp.txt');

  if not (InternetGetConnectedState(@Flags, 0)) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  fIniciando.AppCreateForm(TfAtualiza, fAtualiza);
  fAtualiza.cancela := false;
  fAtualiza.arquivos := lista;
  fAtualiza.ShowModal;
end;

procedure TfmIndex.getClipboard();
var
  f: THandle;
  buffer: Array [0..MAX_PATH] of Char;
  i, numFiles: Integer;
begin
  cboard.Items.Clear;
  Clipboard.Open;
  try
    f := Clipboard.GetAsHandle(CF_HDROP);
    if f <> 0 then
    begin
      numFiles := DragQueryFile(f, $FFFFFFFF, nil, 0);
      for i:= 0 to numfiles - 1 do
      begin
        buffer[0] := #0;
        DragQueryFile( f, i, buffer, sizeof(buffer));
        cboard.Items.Add(buffer);
      end;
    end
    else cboard.Items.Add(Clipboard.AsText);
  finally
    Clipboard.close;
  end;
end;

procedure TfmIndex.Button5Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := true;
    ckLivros2.Checked[i] := true;
  end;
end;

procedure TfmIndex.Button6Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := false;
    ckLivros2.Checked[i] := false;
  end;
end;

procedure TfmIndex.Button7Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := (i <= 38);
    ckLivros2.Checked[i] := (i <= 38);
  end;
end;

procedure TfmIndex.Button8Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := (i > 38);
    ckLivros2.Checked[i] := (i > 38);
  end;
end;

procedure TfmIndex.Button9Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
  begin
    ckLivros.Checked[i] := not ckLivros.Checked[i];
    ckLivros2.Checked[i] := ckLivros.Checked[i];
  end;
end;

procedure TfmIndex.Link(Sender: TObject);
begin
  try
    abrirArquivo(TLabel(Sender).Caption);
  except
  end;
end;

procedure TfmIndex.lista_coletaneas_web(p: string; id: string);
var
  Jpg: TJPEGImage;
  bmp: TBitmap;
  i: integer;
  dir: string;
begin
  if (p = 'canais') then
  begin
    DM.qrONL_CANAIS.Close;
    DM.qrONL_CANAIS.Open;
    bgOnlCanais.Items.Clear;
    bgOnlCanais.ItemIndex := -1;
    lbbgOnlCanais.Items.Clear;
    pnlOnlPlaylists.Visible := False;
    pnlOnlVideos.Visible := False;
    DM.ico_on_canais.Clear;
    dir := dir_config + 'imagens_onl\canais\';
    while not DM.qrONL_CANAIS.eof do
    begin
      bgOnlCanais.Items.Add.Caption := DM.qrONL_CANAIS.FieldByName('NOME').AsString;
      lbbgOnlCanais.Items.Add(DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString);
      i := bgOnlCanais.Items.Count - 1;

      Jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      if FileExists(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg') then
        Jpg.LoadFromFile(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg')
      (*else
      begin
        DownloadArquivo(DM.qrONL_CANAIS.FieldByName('IMAGEM').AsString, dir + '\' + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg');
        if FileExists(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg') then
          Jpg.LoadFromFile(dir + DM.qrONL_CANAIS.FieldByName('CANAL_ID').AsString + '.jpg');
      end*);
      bmp.Assign(Jpg);
      bmp.Height := 88;
      bmp.Width := 88;
      DM.ico_on_canais.Add(bmp, nil);

      bgOnlCanais.Items[i].ImageIndex := i;

      DM.qrONL_CANAIS.Next;
    end;
  end
  else if (p = 'playlists') then
  begin
    DM.qrONL_PLAYLISTS.Close;
    DM.qrONL_PLAYLISTS.ParamByName('CANAL_ID').Value := id;
    DM.qrONL_PLAYLISTS.Open;
    bgOnlPlaylists.Items.Clear;
    bgOnlPlaylists.ItemIndex := -1;
    lbbgOnlPlaylists.Items.Clear;
    pnlOnlVideos.Visible := False;
    DM.ico_on_playlists.Clear;
    dir := dir_config + 'imagens_onl\playlists\';
    while not DM.qrONL_PLAYLISTS.eof do
    begin
      bgOnlPlaylists.Items.Add.Caption := DM.qrONL_PLAYLISTS.FieldByName('NOME').AsString;
      lbbgOnlPlaylists.Items.Add(DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString);
      i := bgOnlPlaylists.Items.Count - 1;

      Jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      if FileExists(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg') then
        Jpg.LoadFromFile(dir + DM.qrONL_PLAYLISTS.FieldByName('PLAYLIST_ID').AsString + '.jpg');
      bmp.Assign(Jpg);
      bmp.Height := 90;
      bmp.Width := 120;
      DM.ico_on_playlists.Add(bmp, nil);

      bgOnlPlaylists.Items[i].ImageIndex := i;

      DM.qrONL_PLAYLISTS.Next;
    end;
  end
  else if (p = 'videos') then
  begin
    DM.qrONL_VIDEOS.Close;
    DM.qrONL_VIDEOS.ParamByName('PLAYLIST_ID').Value := id;
    DM.qrONL_VIDEOS.Open;
    bgOnlVideos.ScrollBy(0, 0);
    bgOnlVideos.Items.Clear;
    bgOnlVideos.ItemIndex := -1;
    lbbgOnlVideos.Items.Clear;
    DM.ico_on_videos.Clear;
    dir := dir_config + 'imagens_onl\videos\';

    gaOnlVideos.Visible := True;
    gaOnlVideos.Value := 0;
    gaOnlVideos.MaxValue := DM.qrONL_VIDEOS.RecordCount;

    while not DM.qrONL_VIDEOS.eof do
    begin
      gaOnlVideos.Value := DM.qrONL_VIDEOS.RecNo;
      Application.ProcessMessages;

      bgOnlVideos.Items.Add.Caption := DM.qrONL_VIDEOS.FieldByName('NOME').AsString;
      lbbgOnlVideos.Items.Add(DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString);
      i := bgOnlVideos.Items.Count - 1;

      Jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      if FileExists(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg') then
        Jpg.LoadFromFile(dir + DM.qrONL_VIDEOS.FieldByName('VIDEO_ID').AsString + '.jpg');
      bmp.Assign(Jpg);
      bmp.Height := 90;
      bmp.Width := 120;
      DM.ico_on_videos.Add(bmp, nil);

      bgOnlVideos.Items[i].ImageIndex := i;

      DM.qrONL_VIDEOS.Next;
    end;
    bgOnlVideos.ScrollBy(0, 0);

    gaOnlVideos.Visible := False;
  end;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;
end;

function TfmIndex.lista_monitores: TArray<TMonitorInfo>;
var
  qtd_monitores: integer;
  i: Integer;
  MonitorsArray: TArray<TMonitorInfo>;
begin
  qtd_monitores := Screen.MonitorCount;
  SetLength(MonitorsArray, qtd_monitores);

  for i := 0 to qtd_monitores-1 do
  begin
    MonitorsArray[i].Left := Screen.Monitors[i].Left;
    MonitorsArray[i].Top := Screen.Monitors[i].Top;
    MonitorsArray[i].Width := Screen.Monitors[i].Width;
    MonitorsArray[i].Height := Screen.Monitors[i].Height;
  end;

  TArray.Sort<TMonitorInfo>(MonitorsArray,
    TComparer<TMonitorInfo>.Construct(
      function(const A, B: TMonitorInfo): Integer
      begin
        Result := A.Top - B.Top;
        if Result = 0 then
          Result := A.Left - B.Left;
      end
    )
  );

  result := MonitorsArray;
end;

procedure TfmIndex.tsPainelDShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsPainelD,tsPainelD);
  marcaAbaAberta(tsPainelD);
  carrega_opc := True;

  if (loadCol.Strings.Values['PAINELD'] <> 'ok') then
  begin
    loadCol.Strings.Values['PAINELD'] := 'ok';
    loadCol.Strings.Values['PAINELD_IMG'] := '|';
    loadCol.Strings.Values['PAINELD_IMG_E'] := '|';

    lmdTxtPainelD.Caption := '';
    carregaConfiguracoes('PAINELD');
  end;
  carrega_opc := False;
end;

procedure TfmIndex.tsPersonalizadasShow(Sender: TObject);
var
  i: Integer;
begin
  PaginaMenuAtiva(bsColetPerso,tsPersonalizadas);
  marcaAbaAberta(tsPersonalizadas);
  if (loadCol.Strings.Values['PERSO'] <> 'ok') then
  begin
    loadCol.Strings.Values['PERSO'] := 'ok';

    if not DM.cdsCOLETANEAS_PERSO.Active then
    begin
      DM.cdsCOLETANEAS_PERSO.CreateDataSet;
      DM.cdsCOLETANEAS_PERSO.IndexName := '';
      DM.cdsCOLETANEAS_PERSO.IndexFieldNames := 'NOME';
      DM.cdsCOLETANEAS_PERSO.LogChanges := False;
    end;

    if (FileExists(dir_dados + 'coletaneasUsuario.xml')) then
      DM.cdsCOLETANEAS_PERSO.LoadFromFile(dir_dados + 'coletaneasUsuario.xml');
    DM.cdsCOLETANEAS_PERSO.Open;

    for i := sbColPERSO.ComponentCount - 1 downto 0 do
      sbColPERSO.Components[i].Free;

    if trim(txtBuscaColetPeso.Text) <> '' then
    begin
      DM.cdsCOLETANEAS_PERSO.Filtered := true;
      DM.cdsCOLETANEAS_PERSO.Filter := 'UPPER(NOME) LIKE UPPER(' + (QuotedStr('%'+txtBuscaColetPeso.Text+'%')) + ')';
      stColetPerso_0.Caption := 'Buscando nome: ''' + txtBuscaColetPeso.Text + '''';
    end
    else
    begin
      DM.cdsCOLETANEAS_PERSO.Filtered := false;
      stColetPerso_0.Caption := '';
    end;

    stColetPerso_1.Caption := qtItens(TFDQuery(DM.cdsCOLETANEAS_PERSO),'álbum encontrado','álbuns encontrados','Nenhum álbum encontrado');

    corCampoBusca(TFDQuery(DM.cdsCOLETANEAS_PERSO),txtBuscaColetPeso,nil);
    fExibeColetaneasPerso(sbColPERSO);
  end;
end;

procedure TfmIndex.tsRelogioShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsRelogio,tsRelogio);
  marcaAbaAberta(tsRelogio);
  carrega_opc := True;

  if (loadCol.Strings.Values['RELOGIO'] <> 'ok') then
  begin
    loadCol.Strings.Values['RELOGIO'] := 'ok';
    loadCol.Strings.Values['RELOGIO_IMG'] := '|';
    loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';

    carregaConfiguracoes('RELOGIO');
  end;
  DM.tmrRelogioTimer(Sender);
  DM.tmrRelogio.Enabled := True;

  carrega_opc := False;
end;

procedure TfmIndex.fExibeColetaneasPerso(ScrollBox: TbsSkinScrollBox);
var
  Button: TbsSkinButtonEx;
  gLeft, gTop, gWidth, gHeight: Integer;
  mLeft: integer;
  dirIMG: string;
  id: string;
  formWidth: Integer;
  bitmap: TBitmap;
  idimg: integer;
const
  Tipo = 'PERSO';
begin
  formWidth := ScrollBox.Width;

  ScrollBox.VScroll(0);
  gLeft := 0;
  gTop := 10;
  gWidth := 165;
  gHeight := 190;

  bitmap := nil;

  while ((gLeft + gWidth + 10 + gWidth + 20) < formWidth) do
    gLeft := gLeft + gWidth + 10;
  mLeft := trunc((formWidth - (gLeft + gWidth + 10)) / 2);
  gLeft := mLeft;

  DM.cdsCOLETANEAS_PERSO.First;
  while not DM.cdsCOLETANEAS_PERSO.Eof do
  begin
    id := DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value;

    Button := TbsSkinButtonEx(FindComponent('gbPerso_' + id));
    Button.Free;
    if Assigned(Button) then
      continue;

    try
      Button := TbsSkinButtonEx.Create(ScrollBox);
      Button.Visible := False;

      with Button do
      begin
        Parent := ScrollBox;
        Name := 'gbPerso_' + id;
        Caption := '';
//        Tag := DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value;

        Layout := bsButtonModel.Layout;
        SkinData := bsButtonModel.SkinData;
        ImageList := bsButtonModel.ImageList;
        OnClick := sbClickPerso;
        PopupMenu := ppColetaneasPerso;

        dirIMG := DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value;
        if (trim(dirIMG) <> '') and (DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value = 'I') then
          dirIMG := ExtractFilePath(Application.ExeName) + dirIMG;
        try
          if (Trim(dirIMG) = '') then
            ImageIndex := 0
          else if (fileexists(dirIMG)) then
          begin
            bitmap := TBitmap.Create;
            bitmap.LoadFromFile(dirIMG);
            bitmap.TransparentColor := clFuchsia;
            bitmap.Transparent := false;
            idimg := DM.imCapas.Add(bitmap, bitmap);
            ImageIndex := idimg;
            bitmap.Free;
          end
          else
          begin
            Caption := 'Imagem de capa não localizada!';
            ImageIndex := 0;
          end;
        except
          Caption := 'Tamanho ou formato de imagem inválido!';
          ImageIndex := 0;
          bitmap.Free;
        end;

        Title := ' ' + DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').AsString + ' ';

        if ((not FileExists(DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString)) and
           (not DirectoryExists(DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString))) then
        begin
          Caption := 'Coletânea não localizada! Clique para corrigir.';
        end;

        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    except
      with Button do
      begin
        Width := gWidth;
        Height := gHeight;
        Left := gLeft;
        Top := gTop;
      end;
    end;
    Button.Visible := True;

    if ((gLeft + gWidth + 10 + gWidth + 20) >= formWidth) then
    begin
      gLeft := mLeft;
      gTop := gTop + gHeight + 10;
    end
    else
      gLeft := gLeft + gWidth + 10;

    DM.cdsCOLETANEAS_PERSO.Next;
  end;
  ScrollBox.VScroll(0);
  ScrollBox.VScrollBar.Visible := True;
  ScrollBox.VScrollBar.Position := 0;
end;

function TfmIndex.FileSize(const FileName: string): Int64;
var
  AttributeData: TWin32FileAttributeData;
begin
  if GetFileAttributesEx(PChar(FileName), GetFileExInfoStandard, @AttributeData) then
  begin
    result := Int64(AttributeData.nFileSizeLow) or Int64(AttributeData.nFileSizeHigh shl 32);
  end
  else
    Result := -1;
end;

procedure TfmIndex.focoAplicacao(acao: Boolean);
begin
  if btwsMinimize.Enabled <> acao then btwsMinimize.Enabled := acao;
  if btwsMaximized.Enabled <> acao then btwsMaximized.Enabled := acao;
  if btwsClose.Enabled <> acao then btwsClose.Enabled := acao;
  if btwsDownload.Enabled <> acao then btwsDownload.Enabled := acao;

  if acao = true
    then pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto'])
    else pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_dis']);
end;

procedure TfmIndex.sbClickPerso(Sender: TObject);
var
  mComponente: string;
  URL: string;
  id: string;
begin
  mComponente := TSpeedButton(Sender).Name;

  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  URL := DM.cdsCOLETANEAS_PERSO.FieldByName('URL').AsString;

  if FileExists(URL) then
  begin
    abrirArquivo(URL);
    Exit;
  end
  else
  if DirectoryExists(URL) then
  begin
    fIniciando.AppCreateForm(TfListaMusica, fListaMusica);
    fListaMusica.id_album := 0;
    fListaMusica.inicio := false;
    fListaMusica.Caption := TbsSkinButtonEx(Sender).Title;
    fListaMusica.lblTitulo.Caption := TbsSkinButtonEx(Sender).Title;
    fListaMusica.lblSubtitulo.Caption := '';
    fListaMusica.dir := URL;
    fListaMusica.DBCtrlGrid.DataSource := DM.dsArquivos;
    fListaMusica.pnlBotoes.Visible := False;
    TbsSkinButtonEx(Sender).ImageList.GetBitmap(
      TbsSkinButtonEx(Sender).ImageIndex,
      fListaMusica.imgCapa.Picture.Bitmap
    );
    fListaMusica.showmodal;
  end
  else
  begin
    pnlAltColPerso.Visible := False;
    btAltColPersoClick(Sender);
    cbColetaneasPerso.KeyValue := id;
    cbColetaneasPersoChange(Sender);
    cbColetaneasPerso.Enabled := False;
    exit;
  end;
end;

procedure TfmIndex.sButton10Click(Sender: TObject);
begin
  abrirArquivo(dir_dados + 'config.ja');
end;

procedure TfmIndex.sbVideoOnAbreLiturgiaChange(Sender: TObject);
begin
  gravaParam('Videos Online', 'Player Liturgia', IntToStr(sbVideoOnAbreLiturgia.ItemIndex));
end;

procedure TfmIndex.sbVideoOnAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Videos Online', 'Monitor', sbVideoOnAreaExtendida.Items[sbVideoOnAreaExtendida.ItemIndex]);
end;

function TfmIndex.SegundosToTime(Segundos: Cardinal): String;
var
  Seg, Min, Hora: Cardinal;
  retorno: string;
begin
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;

  retorno := '';
  if (Hora > 0) then retorno := retorno+FormatFloat(',00', Hora) + ':';
  retorno := retorno + FormatFloat('00', Min) + ':' + FormatFloat('00', Seg);

  Result := retorno;
end;

procedure TfmIndex.btOuvirClick(Sender: TObject);
begin
  if not rbgAudioES.Visible then Exit;

  selMusica();
  if btOuvir.Caption = 'Ouvir' then
  begin
    try
      DM.tmrMediaPlayer.Enabled := true;
      mpMusica.Play;
    except
      DM.tmrMediaPlayer.Enabled := false;
      btOuvir.Caption := 'Ouvir';
      btOuvir.Down := False;
      btOuvir.ImageIndex := 7;
      abrirArquivo(mpMusica.FileName,true);
      Exit;
    end;
    btOuvir.Caption := 'Parar';
    btOuvir.Down := True;
    btOuvir.ImageIndex := 9;
  end
  else
  begin
    DM.tmrMediaPlayer.Enabled := false;
    try
      mpMusica.Stop;
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;
  end;
end;

procedure TfmIndex.btLigarClick(Sender: TObject);
var
  fmt: TFormatSettings;
begin
  if btLigar.Caption = 'Ligar' then
  begin
    try
      mpMusica.Stop;
    except
      //
    end;

    fmt.ShortDateFormat:='dd/mm/yyyy';
    fmt.DateSeparator  :='/';
    fmt.LongTimeFormat :='hh:nn:ss';
    fmt.TimeSeparator  :=':';

    if opcCronoCTempo.ItemIndex = 0 then
    begin
      try
        StrToTime(meESHora.Text)
      except
        application.MessageBox('Hora inválida!', TITULO, mb_ok + mb_iconerror);
        btOuvir.Down := False;
        meESHora.SetFocus;
        Exit;
      end;
      tEscSBCrono := StrToDateTime(FormatDateTime('dd/mm/yyyy',Now())+' '+meESHora.Text + ':00',fmt);
    end
    else
    begin
      tEscSBCrono := StrToDateTime(FormatDateTime('dd/mm/yyyy hh:nn:ss',Now()),fmt);
      tEscSBCrono := IncSecond(IncMinute(tEscSBCrono,StrToInt(meESDuracao.Text)),1);
    end;

    if (tEscSBCrono < now())
      then tEscSBCrono := tEscSBCrono+1;

    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    DM.tmrRelogioTimer(Sender);
    btLigar.Caption := 'Desligar';
    btLigar.Down := True;
    btLigar.ImageIndex := 21;

    if (cgEscSBAudio.ItemChecked[0]) then
    begin
      cbMusica.ItemIndex := 0;
      selMusica();
      btOuvirClick(Sender);
    end;
  end
  else
  begin
    DM.tmrRelogioTimer(Sender);
    btLigar.Caption := 'Ligar';
    btLigar.Down := False;
    btLigar.ImageIndex := 20;
    gEscSbR.MaxValue := 1;
    gEscSbR.Value := 1;

    try
      mpMusica.Stop;
    except
      //
    end;
    DM.tmrMediaPlayer.Enabled := false;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    lmdEscSbR.Font.Color := csEscsbCor2.ColorValue;
    if (fMonitorCronometroCulto <> nil) then
    begin
      fMonitorCronometroCulto.lmdEscSbR.Font.Color := lmdEscSbR.Font.Color;
    end;
  end;

  bsAddT1.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddT5.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddT10.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm1.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm5.Enabled := not(btLigar.Caption = 'Ligar');
  bsAddTm10.Enabled := not(btLigar.Caption = 'Ligar');
end;

procedure TfmIndex.pbPlayerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  newPosition : integer;
begin
  DM.tmrPlayer.Enabled := false;
  newPosition := Round(x * pbPlayer.MaxValue / pbPlayer.ClientWidth);
//  MediaPlayer1.Pause;
  MediaPlayer1.Position := newPosition;
  DM.tmrPlayer.Enabled := True;
  if btplPlay.Down then MediaPlayer1.Play;
end;

procedure TfmIndex.player(url: string;video: Boolean);
var
  monitor,i: integer;
begin
  if (fPlayer <> nil) then
    fPlayer.Close;

  if (video) then
  begin
      monitor := strtoint(lerParam('Player', 'Monitor', '2'));
    if (Screen.MonitorCount < monitor) then
      monitor := 0
    else
      monitor := monitor - 1;

    fIniciando.AppCreateForm(TfPlayer, fPlayer);

    if ckPlayerTelaCheia.Checked then
      fPlayer.BorderStyle := bsNone
    else
      fPlayer.BorderStyle := bsSizeable;
    fPlayer.AlphaBlend := True;
    fPlayer.AlphaBlendValue := 0;
    fPlayer.Show;

    fPlayer.Left := monitorInfo(monitor).Left;
    fPlayer.Top := monitorInfo(monitor).Top;
    fPlayer.Width := monitorInfo(monitor).Width;
    fPlayer.Height := monitorInfo(monitor).Height;

    if ckFadeForm.Checked then
    begin
      for i := 0 to 255 do
      begin
        fPlayer.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fPlayer.AlphaBlendValue := 255;
    fPlayer.Caption := ExtractFileName(url);
  end;

  try
    pbPlayer.Value := 0;
    lblPlayer.Caption := 'Reproduzindo: '+ExtractFileName(url);
    pnlPlayer.Visible := True;
    MediaPlayer1.Display := fPlayer.Panel1;
    MediaPlayer1.FileName := url;
    MediaPlayer1.Open;
    MediaPlayer1.DisplayRect := fPlayer.Panel1.ClientRect;
    MediaPlayer1.Play;
    btplPlay.Down := True;
    btplPause.Down := False;
    pbPlayer.MaxValue := MediaPlayer1.Length;
    DM.tmrPlayer.Enabled := True;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar('Ocorreu um erro ao executar arquivo: '+E.Message+#13#10+'Pressione Ok para abrir o arquivo!'),TITULO,mb_ok+mb_iconerror);
      abrirArquivo(url,true);
      btplFecharClick(nil);
    end;
  end;
end;

procedure TfmIndex.pnlAddColPersoClose(Sender: TObject);
begin
  btAddColPerso.Down := False;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.pnlAltColPersoClose(Sender: TObject);
begin
  btAltColPerso.Down := False;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
end;

procedure TfmIndex.pnlDoxologiaMusicasClose(Sender: TObject);
begin
  bgDoxologiaCate.ItemIndex := -1;
end;

procedure TfmIndex.pnlFormatClose(Sender: TObject);
var
  tag: integer;
begin
  tag := TbsSkinExPanel(Sender).tag;
  if (tag = 1) then
  begin
    pnlFormatBiblia.Visible := False;
    btFormatBiblia.Down := pnlFormatBiblia.Visible;
    ajustaTexto('BIBLIA');
  end
  else if (tag = 2) then
  begin
    pnlFormatBibliaB.Visible := False;
    btFormatBibliaB.Down := pnlFormatBibliaB.Visible;
    ajustaTexto('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    pnlFormatEscSB.Visible := False;
    btFormatEscSB.Down := pnlFormatEscSB.Visible;
    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);
  end
  else if (tag = 4) then
  begin
    pnlFormatSorteio.Visible := False;
    btFormatSorteio.Down := pnlFormatSorteio.Visible;
  end
  else if (tag = 5) then
  begin
    pnlFormatCrono.Visible := False;
    btFormatCrono.Down := pnlFormatCrono.Visible;
  end
  else if (tag = 6) then
  begin
    pnlFormatSorteioNM.Visible := False;
    btFormatSorteioNM.Down := pnlFormatSorteioNM.Visible;
  end
  else if (tag = 7) then
  begin
    pnlFormatPainelD.Visible := False;
    btFormatPainelD.Down := pnlFormatPainelD.Visible;
  end
  else if (tag = 9) then
  begin
    pnlFormatRelogio.Visible := False;
    btFormatRelogio.Down := pnlFormatRelogio.Visible;
  end;
end;

procedure TfmIndex.pnLivrosClose(Sender: TObject);
begin
  ajustaTexto('BIBLIA_BUSCA');
end;

procedure TfmIndex.pnlOnlPlaylistsClose(Sender: TObject);
begin
  bgOnlCanais.ItemIndex := -1;
  pnlOnlVideos.Visible := False;
  imgYoutubeCapa.Visible := not pnlOnlVideos.Visible;
end;

procedure TfmIndex.pnlOnlVideosClose(Sender: TObject);
begin
  bgOnlPlaylists.ItemIndex := -1;
  imgYoutubeCapa.Visible := True;
end;

procedure TfmIndex.posicaoFundoClick(Sender: TObject);
begin
  gravaParam('Musicas', 'Imagem Fundo Posicao', IntToStr(fmIndex.posicaoFundo.ItemIndex+1))
end;

procedure TfmIndex.ppVideosOnPersoPopup(Sender: TObject);
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

procedure TfmIndex.btImpSorteioNMClick(Sender: TObject);
var
  i: Integer;
  arq: string;
begin
  arq := openDialog('texto', '', '');
  paramtemp.Lines.Clear;

  if Trim(arq) <> '' then
  begin
    paramtemp.Lines := arquivoCodificado(arq);

    for i := 0 to paramtemp.Lines.Count - 1 do
    begin
      try
        opSort_Nm.Text := paramtemp.Lines[i];
        btAddSorteioNMClick(nil);
      except
      end;
    end;
  end;
end;



procedure TfmIndex.btIniciarCronoClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;
  pnlCrono.DoubleBuffered := True;
  if btIniciarCrono.Caption = 'Iniciar' then
  begin
    if txtDecr.Enabled = true then
      txtDecrExit(Sender);
    tCrono := tCronoT;
    tCronoOld := Now;
    DM.tmrCrono.Enabled := True;
    btIniciarCrono.Caption := 'Pausar';
    btIniciarCrono.ImageIndex := 28;
    btIniciarCrono.Down := True;
  end
  else
  begin
    DM.tmrCrono.Enabled := False;
    btIniciarCrono.Caption := 'Iniciar';
    btIniciarCrono.ImageIndex := 20;
    btIniciarCrono.Down := False;
  end;
end;

procedure TfmIndex.btZerarCronoClick(Sender: TObject);
var
  hora: string;
begin
//  pnlCrono.DoubleBuffered := False;
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;
  DM.tmrCrono.Enabled := false;
  btIniciarCrono.Caption := 'Iniciar';
  btIniciarCrono.ImageIndex := 20;
  btIniciarCrono.Down := False;
  gCrono.MaxValue := 1;
  gCrono.Value := 1;

  tCronoT := 0;
  if rbDirecao.ItemIndex = 0 then
  begin
    tCronoT := 0;
    lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime('00:00:00'));
  end
  else
  begin
    hora := StringReplace(txtDecr.text, ' ', '0', [rfIgnoreCase, rfReplaceAll]);
    btIniciarCrono.Enabled := true;
    try
      tCronoT := strtotime(hora);
    except
      btIniciarCrono.Enabled := false;
    end;

    if btZerarCrono.Tag = 0 then
    begin
      try
        lmdCrono.Caption := FormatDateTime(cbFormatoTempoCrono.Items[cbFormatoTempoCrono.ItemIndex], StrToTime(hora));
      except
      end;
    end;
    btZerarCrono.Tag := 0;
  end;
  if fMonitorCronometro <> nil then
  begin
    fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
    fMonitorCronometro.gCrono.MaxValue := gCrono.MaxValue;
    fMonitorCronometro.gCrono.Value := gCrono.Value;
    fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;
  end;
end;

procedure TfmIndex.buscaMusicas;
var
  valor: string;
  i: Integer;
  tabela: string;
  letra: string;
  opc_colet: string;
begin
  if carrega_opc then exit;
  if loadCol.Strings.Values['BUSCA:CARREGADO'] <> 'S' then Exit;
  if loadCol.Strings.Values['BUSCA:STATUS'] = 'I' then Exit;

  loadCol.Strings.Values['BUSCA:STATUS'] := 'I';

  pnlreBusca.Visible := False;
  bsSkinScrollBar8.Visible := true;
  valor := trim(txtBusca.Text);

  if (ckgFiltros.ItemChecked[0] = False) and (ckgFiltros.ItemChecked[1] = False) and (ckgFiltros.ItemChecked[2] = False)
    then ckgFiltros.ItemChecked[0] := True;

  if (ckgColetaneas.ItemChecked[0] = False) and (ckgColetaneas.ItemChecked[1] = False) and (ckgColetaneas.ItemChecked[2] = False)
    then ckgColetaneas.ItemChecked[0] := True;

  opc_colet := ',';
  if (ckgColetaneas.ItemChecked[0] = True) then opc_colet := opc_colet + 'B,';
  if (ckgColetaneas.ItemChecked[1] = True) then opc_colet := opc_colet + 'W,';
  if (ckgColetaneas.ItemChecked[2] = True) then opc_colet := opc_colet + 'P,';

  if (trim(valor) = '')
    then pnlStatusBuscaMusicas0.caption := ''
    else pnlStatusBuscaMusicas0.caption := 'Buscando nome: ''' + valor + '''';


  DM.qrBUSCA.Close;
  DM.qrBUSCA.ParamByName('TIPO').AsString := opc_colet;
  DM.qrBUSCA.ParamByName('VALOR').AsString := termo_busca(valor);

  if (ckgFiltros.ItemChecked[0]) then
    DM.qrBUSCA.ParamByName('OPC_NOME').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_NOME').AsString := 'N';

  if (ckgFiltros.ItemChecked[1]) then
    DM.qrBUSCA.ParamByName('OPC_LETRA').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_LETRA').AsString := 'N';

  if (ckgFiltros.ItemChecked[2]) then
    DM.qrBUSCA.ParamByName('OPC_ALBUM').AsString := 'S'
  else
    DM.qrBUSCA.ParamByName('OPC_ALBUM').AsString := 'N';

  if tabLetras.Tabs[tabLetras.TabIndex] <> 'Todas'  then
    DM.qrBUSCA.ParamByName('INICIAL').AsString := tabLetras.Tabs[tabLetras.TabIndex]
  else
    DM.qrBUSCA.ParamByName('INICIAL').AsString := '';

  DM.qrBUSCA.Open;

  pnlStatusBuscaMusicas1.Caption := qtItens(DM.qrBUSCA,'música encontrada','músicas encontradas','Nenhuma música encontrada');
  loadCol.Strings.Values['BUSCA:STATUS'] := '';



  if (DM.qrBUSCA.RecordCount = 1) then
  begin
    if (ckgColetaneas.ItemIndex = 0) or ((ckgColetaneas.ItemIndex = 2) and (DM.qrBUSCA.fieldbyname('TIPO_WEB').AsString <> 'S') and (DM.qrBUSCA.fieldbyname('TIPO_PERSO').AsString <> 'S')) then
    begin
      reBusca.Lines.Clear;
      DM.qrLETRA.Close;
      DM.qrLETRA.ParamByName('MUSICA').Value := DM.qrBUSCA.fieldbyname('ID').AsInteger;
      DM.qrLETRA.Open;
      while not DM.qrLETRA.Eof do
      begin
        letra := '';
        if (DM.qrLETRA.fieldbyname('LETRA_AUX').AsString <> '') then
          letra := letra+'['+DM.qrLETRA.fieldbyname('LETRA_AUX').AsString+'] ';

        letra := letra+DM.qrLETRA.fieldbyname('LETRA').AsString;
        letra := StringReplace(letra, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]);
        reBusca.Lines.Add(letra);

        DM.qrLETRA.Next;
      end;

      pnlreBusca.Height := DBGrid2.Height - pnlStatusBuscaMusicas.Height - 22;
      pnlreBusca.Top := 0;
      formataTexto(reBusca);
      pnlreBusca.Visible := true;
    end;
    bsSkinScrollBar8.Visible := False;
    dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;
  end
  else
  begin
    pnlreBusca.Visible := False;
  end;
//  bsErroMusica.Visible := pnlreBusca.Visible;

  corCampoBusca(DM.qrBUSCA, txtBusca, DBGrid2);
  pnlStatusBuscaMusicas1.Caption := qtItens(DM.qrBUSCA,'música encontrada','músicas encontradas','Nenhuma música encontrada');;
  dbGrid2.Columns[2].Width := dbGrid2.Width - dbGrid2.Columns[0].Width - dbGrid2.Columns[1].Width - dbGrid2.Columns[3].Width;
  loadCol.Strings.Values['BUSCA:STATUS'] := '';

  DBGrid2CellClick(nil);
end;

procedure TfmIndex.btplFecharClick(Sender: TObject);
begin
  try
    MediaPlayer1.Stop;
  except
    //
  end;
  MediaPlayer1.Close;
  MediaPlayer1.FileName := '';
  pnlPlayer.Visible := False;
  lblPlayer.Caption := '';
  DM.tmrPlayer.Enabled := False;
  pbPlayer.Value := 0;

  if (fPlayer <> nil) and (fPlayer.Visible) then
    fPlayer.Close;
end;

procedure TfmIndex.btplPauseClick(Sender: TObject);
begin
  if btplPause.Down <> True then
  begin
    btplPause.Down := True;
    Exit;
  end;

  MediaPlayer1.Pause;
  btplPlay.Down := false;
end;

procedure TfmIndex.btplPlayClick(Sender: TObject);
begin
  if btplPlay.Down <> True then
  begin
    btplPlay.Down := True;
    Exit;
  end;

  MediaPlayer1.Play;
  btplPause.Down := false;
end;

procedure TfmIndex.botoesFavoritos(acao: string);
begin
  btAddFav.Enabled := (acao = 'add');
  miAddFav.Enabled := (acao = 'add');

  btDelFav.Enabled := (acao = 'del');
  miDelFav.Enabled := (acao = 'del');
end;

procedure TfmIndex.bsAddTClick(Sender: TObject);
var
  t: integer;
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;

  t := TComponent(Sender).Tag;
  try
    mpMusica.Stop;
  except
    //
  end;
  tEscSBCrono := IncMinute(tEscSBCrono,t);
  DM.tmrRelogioTimer(Sender);
end;

procedure TfmIndex.bsAppMenu1ChangePage(Sender: TObject);
begin
  bsAppMenu1Items1Click(Sender);
end;

procedure TfmIndex.bsAppMenu1Click(Sender: TObject);
begin
  bsAppMenu1Items1Click(Sender);
end;

procedure TfmIndex.bsAppMenu1Items10Click(Sender: TObject);
begin
  DM.tmrSair.Enabled := True;
end;

procedure TfmIndex.bsAppMenu1Items1Click(Sender: TObject);
begin
  fmIndex.gpSobre.Align := alClient;
  fmIndex.ScrollBox1.Align := alClient;
  fmIndex.ScrollBox5.Align := alClient;
  carrega_monitores();
end;

procedure TfmIndex.bsAppMenu1Items3Click(Sender: TObject);
begin
//  fIniciando.AppCreateForm(TfTransmitir, fTransmitir);
  fTransmitir.Show;
end;

procedure TfmIndex.bsAppMenu1Items6Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
//  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
//  fEnviaMensagem.edAssunto.Text := '';
//  fEnviaMensagem.param := 'FEEDBACK';
//  fEnviaMensagem.mmMensagem.Text := '';
//  fEnviaMensagem.ShowModal;
end;

procedure TfmIndex.bsAppMenu1Items7Click(Sender: TObject);
var
  Flags: Cardinal;
begin
  if not (InternetGetConnectedState(@Flags, 0)) then
  begin
    application.messagebox(PChar('Não foi possível conectar à internet! Verifique sua conexão e tente novamente.'), fmIndex.TITULO, MB_OK + mb_iconerror);
    Exit;
  end;

  DM.progressDialog.Caption := 'Coletânea JA';
  DM.progressDialog.LabelCaption := 'Procurando atualizações... aguarde...';
  DM.progressDialog.Value := 0;
  DM.progressDialog.MaxValue := 2;
  DM.progressDialog.Execute;
  application.ProcessMessages;
  Sleep(1000);

  DM.progressDialog.Value := 1;
  application.ProcessMessages;

  gravaParam('Config', 'UltimaConexao', '-');
  carregaParams;
  if verVersao() = false then
  begin
    Sleep(1000);
    application.messagebox(PChar('Não foram encontradas novas versões do programa!'), fmIndex.TITULO, MB_OK + mb_iconinformation);
    application.ProcessMessages;
  end;
  DM.progressDialog.MaxValue := 1;
  DM.progressDialog.Value := DM.progressDialog.MaxValue;
  DM.progressDialog.Close;


end;

procedure TfmIndex.bsknbtn1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://louvorja.com.br/doacao/'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfmIndex.bsPngImageView11Click(Sender: TObject);
begin
  if (DM.cdsItensAgendados.FieldByName('ID').AsString = '') then
  begin
    MonthCalendar1DblClick(MonthCalendar1);
    Exit;
  end;

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := DM.cdsItensAgendados.FieldByName('ID').AsString;
  fItensAgendados.tipo := 'ITEM';
  fItensAgendados.ShowModal;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.bsPngImageView13Click(Sender: TObject);
begin
  if (DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString = '') then
  begin
    btAddCategoriaAgendadosClick(Sender);
    Exit;
  end;

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString;
  fItensAgendados.tipo := 'CATEGORIA';
  fItensAgendados.ShowModal;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.bsPopupMenuFavoritosPopup(Sender: TObject);
begin
  if not DM.cdsFavoritos.Active then
    fmIndex.carregaFavoritos;
end;

procedure TfmIndex.bsRibbon1Buttons0Click(Sender: TObject);
begin
  if (fBuscaMusica <> nil) and (fBuscaMusica.Visible) and (fBuscaMusica.Active)
    then exit;

  fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
  fBuscaMusica.ShowModal;
  if (fBuscaMusica.id) > 0
    then abreLetraMusica('BD','',fBuscaMusica.id,true);
end;

procedure TfmIndex.bsRibbon1Buttons3Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
end;

procedure TfmIndex.bsRibbon1Buttons4Click(Sender: TObject);
begin
  bsRibbon1.AppMenu.ItemIndex := 1;
  if not bsRibbon1.AppMenu.Visible then
    bsRibbon1.ShowAppMenu;
end;

procedure TfmIndex.bsRibbon1Buttons5Click(Sender: TObject);
begin
  if (fHelp <> nil) and (fHelp.Visible) then
  begin
    fHelp.Close;
    fmIndex.Refresh;
  end;

  fIniciando.AppCreateForm(TfHelp, fHelp);
  if (Screen.ActiveForm.Name <> 'fmIndex') then
    fHelp.tabPage := Screen.ActiveForm.Name
  else if PageControl1.Visible then
    fHelp.tabPage := PageControl1.ActivePage.Name
  else
    fHelp.tabPage := '';
  fHelp.ShowModal;
end;

procedure TfmIndex.bsRibbon1ChangePage(Sender: TObject);
begin
  if (bsRibbon1.ActivePage.Tag = 0) and (pnlfmSubTituloRib.Tag = 1) then
    pnlfmSubTituloRib.Visible := True
  else
    pnlfmSubTituloRib.Visible := False;

  if bsRibbon1.ActivePage = bsFavoritos then
  begin
    if (loadCol.Strings.Values['RIBP_FAVORITOS'] <> 'okf') then
    begin
      loadCol.Strings.Values['RIBP_FAVORITOS'] := 'okf';
      carregaFavoritos();
    end;
  end;
end;

procedure TfmIndex.bsRibbonGroup19DialogButtonClick(Sender: TObject);
begin
  pnLivros.Visible := not pnLivros.Visible;
  ajustaTexto('BIBLIA_BUSCA');
end;

procedure TfmIndex.bsSkinButton10Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Items[i].Checked := False;
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton11Click(Sender: TObject);
var
  i: integer;
  item: string;
  linha: integer;
begin
  for i := lbSorteioNM.Items.Count - 1 downto 0 do
  begin
    lbSorteioNM.ItemIndex := i;
    if (lbSorteioNM.Items[i].Checked = True) then
    begin
      item := lbSorteioNM.Items[lbSorteioNM.ItemIndex].Caption;
      lbSorteioNM.Items.Delete(i);
      vlSorteadosNM.FindRow(item, linha);
      if linha >= 0 then
        vlSorteadosNM.DeleteRow(linha);
    end;
  end;

  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    item := lbSorteioNM.Items[lbSorteioNM.ItemIndex].Caption;
    vlSorteioNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton12Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Items[i].Checked := not lbSorteioNM.Items[i].Checked;
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton13Click(Sender: TObject);
begin
  lbCrono.Items.Clear;
  loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := '1';
  if fMonitorCronometro <> nil then
  begin
    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
  end;
end;

procedure TfmIndex.bsSkinButton15Click(Sender: TObject);
begin
  abrirArquivo(dir_config + 'BD.mdb');
end;

procedure TfmIndex.bsSkinButton1Click(Sender: TObject);
var
  id: string;
begin
  txtAbrirColetExit(Sender);
  id := cbColetaneasPerso.KeyValue;

  if cbColetaneasPerso.KeyValue <= 0 then
  begin
    application.messagebox('Escolha uma coletânea para aterar!', TITULO, MB_OK + mb_iconexclamation);
    cbColetaneasPerso.SetFocus;
    cbColetaneasPerso.DropDown;
    exit;
  end;

  if (trim(txtColetanea2.Text) = '') then
  begin
    application.messagebox('Digite o nome da coletânea!', TITULO, MB_OK + mb_iconexclamation);
    txtColetanea2.SetFocus;
    exit;
  end;

  DM.cdsCOLETANEAS_PERSO.Filtered := false;
  DM.cdsCOLETANEAS_PERSO.Filter := 'UPPER(NOME) = UPPER(' + (QuotedStr(txtColetanea2.Text)) + ') AND ID <> ' + id;
  DM.cdsCOLETANEAS_PERSO.Filtered := True;
  if (DM.cdsCOLETANEAS_PERSO.RecordCount > 0) then
  begin
    application.messagebox('Já existe uma coletânea com este nome!', TITULO, MB_OK + mb_iconexclamation);
    txtColetanea2.SetFocus;
    DM.cdsCOLETANEAS_PERSO.Filtered := false;
    exit;
  end
  else
    DM.cdsCOLETANEAS_PERSO.Filtered := false;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  DM.cdsCOLETANEAS_PERSO.Edit;
  DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := txtColetanea2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := txtAbrirColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := txtImgInfoColet2.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := txtCapaColet2.text;
  DM.cdsCOLETANEAS_PERSO.Post;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  txtColetanea2.text := '';
  txtUrlInfoColet2.text := '';
  txtAbrirColet2.text := '';
  txtImgInfoColet2.text := '';
  txtCapaColet2.text := '';
  cbColetaneasPersoChange(Sender);

  importColetaneasPerso();
end;

procedure TfmIndex.bsSkinButton20Click(Sender: TObject);
begin
  if DM.cdsBIBLIA_HISTORICO.RecordCount <= 0 then Exit;

  if (DM.cdsBIBLIA_HISTORICO.Locate('VERSAO;LIVRO;CAPITULO;VERSICULO', VarArrayOf([loadCol.Strings.Values['BIBLIA_P_VERSAO'],loadCol.Strings.Values['BIBLIA_P_LIVRO'],loadCol.Strings.Values['BIBLIA_P_CAPITULO'],loadCol.Strings.Values['BIBLIA_P_VERSICULO']]), [])) then
    DM.cdsBIBLIA_HISTORICO.Delete;
end;

procedure TfmIndex.bsSkinButton21Click(Sender: TObject);
var
  Item: TListItem;
  existe: Boolean;
  a_sim: Integer;
//  a_nao: Integer;
  tag: integer;
  tabela,campo,campo_a,campo_id: string;
  tamanho: Longint;
  url: string;
begin
  gProgresso.Value := 0;
  lvArquivos.Items.Clear;
  a_sim := 0;
//  a_nao := 0;
  tag := TbsSkinButton(Sender).Tag;

  DM.qrARQUIVOS_SISTEMA.Close;
  DM.qrARQUIVOS_SISTEMA.Open;
  DM.qrARQUIVOS_SISTEMA.First;
  gProgresso.MaxValue := DM.qrARQUIVOS_SISTEMA.RecordCount;

  while not DM.qrARQUIVOS_SISTEMA.eof do
  begin
    url := DM.qrARQUIVOS_SISTEMA.FieldByName('URL').AsString;
    if (fIniciando.paramexec.Strings.Values['dir_config'] <> '') then
      url := StringReplace(url,'config\',fIniciando.paramexec.Strings.Values['dir_config']+'\',[rfIgnoreCase, rfReplaceAll]);
    existe := (FileExists(ExtractFilePath(application.ExeName)+'/'+url));

    if not existe then
    begin
      Item := lvArquivos.Items.Add;
      Item.Checked := not existe;
      Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
      Item.SubItems.Add(url);
//      a_nao := a_nao + 1;
      Item.SubItems.Add('0');
      Item.SubItems.Add('Não encontrado');
    end
    else
    begin
      tamanho := FileSize(url);

      if   ((tag = 1) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger <= 0))
        or ((tag = 2) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger < tamanho))
        or ((tag = 3) and (DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger > tamanho))
        or (tag < 1) then
      begin
        tabela := '';
        campo := '';
        campo_a := '';

        if DM.qrARQUIVOS_SISTEMA.FieldByName('TABELA').AsString <> '' then
        begin
          tabela := DM.qrARQUIVOS_SISTEMA.FieldByName('TABELA').AsString;
          campo_a := DM.qrARQUIVOS_SISTEMA.FieldByName('CAMPO_ARQ').AsString;
          campo := DM.qrARQUIVOS_SISTEMA.FieldByName('CAMPO_ARQ_TAM').AsString;
          campo_id := DM.qrARQUIVOS_SISTEMA.FieldByName('CHAVE').AsString;
        end;

        if (tabela <> '') then
        begin

          DM.qrGRAVA_TAMANHO_ARQUIVO.Close;
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Clear;
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add('UPDATE '+tabela+' SET');
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add(campo+' = '+inttostr(tamanho));
          DM.qrGRAVA_TAMANHO_ARQUIVO.SQL.Add('WHERE '+campo_a+' = "'+campo_id+'"');
          DM.qrGRAVA_TAMANHO_ARQUIVO.ExecSQL;

          Item := lvArquivos.Items.Add;
          Item.Checked := not existe;
          Item.Caption := DM.qrARQUIVOS_SISTEMA.FieldByName('ARQUIVO').AsString;
          Item.SubItems.Add(url);
//          a_nao := a_nao + 1;
          Item.SubItems.Add(IntToStr(tamanho)+'/'+inttostr(DM.qrARQUIVOS_SISTEMA.FieldByName('TAMANHO').AsInteger));
          Item.SubItems.Add('Atualizado');

          a_sim := a_sim + 1;
        end;
      end;
    end;

    gProgresso.Value := DM.qrARQUIVOS_SISTEMA.RecNo;
    Application.ProcessMessages;
    DM.qrARQUIVOS_SISTEMA.Next;
  end;

  application.MessageBox(PChar('Arquivos atualizados: '+inttostr(a_sim)), fmIndex.titulo, mb_ok + MB_ICONINFORMATION);

end;

procedure TfmIndex.bsSkinButton24Click(Sender: TObject);
begin
  atualiza_coletaneas_web('playlists', lbbgOnlCanais.Items[bgOnlCanais.ItemIndex]);
end;

procedure TfmIndex.bsSkinButton25Click(Sender: TObject);
begin
  atualiza_coletaneas_web('canais');
end;

procedure TfmIndex.bsSkinButton26Click(Sender: TObject);
begin
  atualiza_coletaneas_web('videos', lbbgOnlPlaylists.Items[bgOnlPlaylists.ItemIndex]);
end;

procedure TfmIndex.bsSkinButton2Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a formatação do texto?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  apagaParam('Musicas', 'Cor Titulo');
  apagaParam('Musicas', 'Cor Texto');
  apagaParam('Musicas', 'Cor Texto Repetido');
  apagaParam('Musicas', 'Cor Texto Aux');
  apagaParam('Musicas', 'FundoTransparente');
  apagaParam('Musicas', 'Tamanho Titulo');
  apagaParam('Musicas', 'Tamanho Texto');
  apagaParam('Musicas', 'Tamanho Texto Aux');

  corTituloMusica.ColorValue := StringToColor(fmIndex.lerParam('Musicas', 'Cor Titulo', '$000b4ef'));
  corTextoMusica.ColorValue := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto', '$0FFFFFF'));
  corTextoRepetido.ColorValue := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto Repetido', '$000b4ef'));
  corTextoAuxMusica.ColorValue := StringToColor(fmIndex.lerParam('Musicas', 'Cor Texto Aux', '$000b4ef'));
  ckMusicaFundoTransparente.Checked := (fmIndex.lerParam('Musicas', 'FundoTransparente', '0') = '1');
  seTamanhoTitulo.Text := fmIndex.lerParam('Musicas', 'Tamanho Titulo', '18');
  seTamanhoTexto.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto', '14');
  seTamanhoTextoAux.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Aux', '10');

end;

procedure TfmIndex.btAddColetPersoClick(Sender: TObject);
var
  id: string;
begin
  txtAbrirColetExit(Sender);
  if (trim(txtColetanea.Text) = '') then
  begin
    application.messagebox('Digite o nome da coletânea!', fmIndex.TITULO, MB_OK + mb_iconexclamation);
    txtColetanea.SetFocus;
    exit;
  end;

  if (DM.cdsCOLETANEAS_PERSO.Locate('NOME', txtColetanea.text, [])) then
  begin
    application.messagebox('Já existe uma coletânea com este nome!', fmIndex.TITULO, MB_OK + mb_iconexclamation);
    txtColetanea.SetFocus;
    exit;
  end;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsCOLETANEAS_PERSO.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível salvar. Clique em salvar novamente!', fmIndex.TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsCOLETANEAS_PERSO.Append;
  DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value := id;
  DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := txtColetanea.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := txtAbrirColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := txtImgInfoColet.text;
  DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := txtCapaColet.text;
  DM.cdsCOLETANEAS_PERSO.Post;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  txtColetanea.text := '';
  txtUrlInfoColet.text := '';
  txtAbrirColet.text := '';
  txtImgInfoColet.text := '';
  txtCapaColet.text := '';

  importColetaneasPerso();
end;

procedure TfmIndex.bsSkinButton34Click(Sender: TObject);
begin
  abrirArquivo(dir_dados + 'liturgia.ja');
end;

procedure TfmIndex.bsSkinButton36Click(Sender: TObject);
begin
  if bsRibbon1.AppMenu.Visible then
    bsRibbon1.AppMenu.Visible := false;
  fIniciando.AppCreateForm(TfArquivosExcesso,fArquivosExcesso);
  fArquivosExcesso.showmodal;
end;

procedure TfmIndex.bsSkinButton38Click(Sender: TObject);
begin
  if bsRibbon1.AppMenu.Visible then
    bsRibbon1.AppMenu.Visible := false;
  fIniciando.AppCreateForm(TfArquivosFalta,fArquivosFalta);
  fArquivosFalta.showmodal;
end;

procedure TfmIndex.bsSkinButton3Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Items[i].Checked := True;
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton43Click(Sender: TObject);
var
  item: TStringList;
  i,id: integer;
  str: string;
begin
  item := TStringList.Create;
  lbHlpTemp.lines.Clear;
  lbHlpArquivos.Items.Clear;
  lbHlpImagens.Items.Clear;
  lbHlpFalta.Items.Clear;

  lblStatusHlp.Caption := 'Inicando Verificação...';
  Application.ProcessMessages;
  //Sleep(500);

  lblStatusHlp.Caption := 'Apagando tabela de arquivos Help...';
  Application.ProcessMessages;
  DM.qrARQUIVOS_HELP_DELETE.ExecSQL;
  //Sleep(500);

  lblStatusHlp.Caption := 'Buscando Arquivos de Ajuda...';
  Application.ProcessMessages;
  if not FileExists(dir_config+'help\menu.hja') then
  begin
    lbHlpFalta.Items.Add('menu.hja');
    lblStatusHlp.Caption := 'Arquivo de Menu não encontrado. Finalizado!';
    Exit;
  end;

  lbHlpTemp.lines.LoadFromFile(dir_config+'help\menu.hja');
  lbHlpArquivos.Items.Add('menu.hja');
  for i := 0 to lbHlpTemp.lines.Count-1 do
  begin
    item.Clear;
    ExtractStrings(['|'], [], PChar(lbHlpTemp.lines[i]+'|_|_|_'), item);

    if item[1] = '_' then Continue;

    if not FileExists(dir_config+'help\'+item[1]) then
    begin
      if lbHlpFalta.Items.IndexOf(item[1]) < 0
        then lbHlpFalta.Items.Add(item[1]);
    end
    else
    begin
      if lbHlpArquivos.Items.IndexOf(item[1]) < 0
        then lbHlpArquivos.Items.Add(item[1]);
    end;
  end;
  //Sleep(500);

  lblStatusHlp.Caption := 'Buscando Imagens...';
  Application.ProcessMessages;
  for i := 0 to lbHlpArquivos.Items.Count-1 do
  begin
    lblStatusHlp.Caption := 'Buscando Imagens... Arquivo '+inttostr(i+1)+' de '+inttostr(lbHlpArquivos.Items.Count)+' ('+lbHlpArquivos.Items[i]+')';
    Application.ProcessMessages;

    lbHlpTemp.Lines.Clear;
    lbHlpTemp.Lines.LoadFromFile(dir_config+'help\'+lbHlpArquivos.Items[i]);
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, #13#10, '', [rfIgnoreCase, rfReplaceAll]);
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, ' ', '', [rfIgnoreCase, rfReplaceAll]);
    lbHlpTemp.Text := StringReplace(lbHlpTemp.Text, '[DIR_HLP]', '', [rfIgnoreCase, rfReplaceAll]);
    while (pos('<imgsrc',lbHlpTemp.Text) > 0) do
    begin
      lbHlpTemp.Text := Copy(lbHlpTemp.Text,pos('<imgsrc',lbHlpTemp.Text)+9,length(lbHlpTemp.Text));
      str := Copy(lbHlpTemp.Text,0,pos('''',lbHlpTemp.Text)-1);
      lbHlpTemp.Text := Copy(lbHlpTemp.Text,pos('''',lbHlpTemp.Text)+1,length(lbHlpTemp.Text));

      if not FileExists(dir_config+'help\imgs\'+str) then
      begin
        if lbHlpFalta.Items.IndexOf(str) < 0
          then lbHlpFalta.Items.Add(str);
      end
      else
      begin
        if lbHlpImagens.Items.IndexOf(str) < 0
          then lbHlpImagens.Items.Add(str);
      end;
    end;
  end;
  //Sleep(500);


  lblStatusHlp.Caption := 'Gravando no Banco de Dados...';
  Application.ProcessMessages;
  id := 0;
  for i := 0 to lbHlpArquivos.Items.Count-1 do
  begin
    id := id + 1;
    lblStatusHlp.Caption := 'Gravando no Banco de Dados... Registro '+inttostr(id)+' de '+inttostr(lbHlpArquivos.Items.Count+lbHlpImagens.Items.Count)+' ('+lbHlpArquivos.Items[i]+')';
    Application.ProcessMessages;

    DM.qrARQUIVOS_HELP.Close;
    DM.qrARQUIVOS_HELP.ParamByName('ID').Value := id;
    DM.qrARQUIVOS_HELP.ParamByName('ARQUIVO').Value := ExtractFileName(lbHlpArquivos.Items[i]);
    DM.qrARQUIVOS_HELP.ParamByName('URL').Value := 'config\help\'+lbHlpArquivos.Items[i];
    DM.qrARQUIVOS_HELP.ExecSQL;
  end;
  for i := 0 to lbHlpImagens.Items.Count-1 do
  begin
    id := id + 1;
    lblStatusHlp.Caption := 'Gravando no Banco de Dados... Registro '+inttostr(id)+' de '+inttostr(lbHlpArquivos.Items.Count+lbHlpImagens.Items.Count)+' ('+lbHlpImagens.Items[i]+')';
    Application.ProcessMessages;

    DM.qrARQUIVOS_HELP.Close;
    DM.qrARQUIVOS_HELP.ParamByName('ID').Value := id;
    DM.qrARQUIVOS_HELP.ParamByName('ARQUIVO').Value := ExtractFileName(lbHlpImagens.Items[i]);
    DM.qrARQUIVOS_HELP.ParamByName('URL').Value := 'config\help\imgs\'+lbHlpImagens.Items[i];
    DM.qrARQUIVOS_HELP.ExecSQL;
  end;

  lblStatusHlp.Caption := 'Finalizado!';
  Application.ProcessMessages;
end;

procedure TfmIndex.bsSkinButton44Click(Sender: TObject);
var
  bass_musica: HSAMPLE;
  bass_channel: HCHANNEL;
  mus: Boolean;
  musica: string;
  tempo: QWORD;
  ntempo: string;
  query: string;
  erro: boolean;
begin
  mus := false;
  erro := False;

  Memo1.Lines.clear();
  Memo1.Lines.Add('****INICIANDO****');

  DM.qrMUSICA_ATUALIZAR.Close;
  DM.qrMUSICA_ATUALIZAR.Open;


  while not DM.qrMUSICA_ATUALIZAR.eof do
  begin
    erro := False;
    Memo1.Lines.Add(DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsString+' - '+DM.qrMUSICA_ATUALIZAR.FieldByName('NOME').AsString);

    DM.qrSLIDE_MUSICA.Close;
    DM.qrSLIDE_MUSICA.ParamByName('MUSICA_ID').Value := DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsInteger;
    DM.qrSLIDE_MUSICA.Open;
    DM.qrSLIDE_MUSICA.First;

    Memo1.Lines.Add(' >> Verifica PLAYBACK!');
    while not DM.qrSLIDE_MUSICA.eof do
    begin
      if (DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') then
      begin
        musica := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString;
        if (musica <> '') then
        begin
          musica := diretorio(ExtractFilePath(Application.ExeName)+'\config\musicas\'+musica);
          Memo1.Lines.Add(musica);
          if (mus) then
          begin
            BASS_MusicFree(bass_musica);
            BASS_Free();
          end;

          try
            BASS_Init(-1, 44100, 0, Handle, nil);
          except
            //
          end;
          bass_musica := BASS_SampleLoad(FALSE, PChar(musica), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
          bass_channel := BASS_SampleGetChannel(bass_musica, False);
          if not BASS_ChannelPlay(bass_channel, False) then
          begin
            Memo1.Lines.Add(' >> Erro ao carregar audio!');
            musica := '';
            erro := True;
          end;
          mus := True;
        end;
      end
      else
      begin

        if (musica <> '') then
        begin
          tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO_PB').AsInteger;
          if (tempo <= 0) then
            tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;

          ntempo := floattostr(BASS_ChannelBytes2Seconds(bass_channel,tempo));
          Memo1.Lines.Add('TEMPO: '+inttostr(tempo)+' >> '+ntempo);

          Try
            query := 'UPDATE MUSICAS_LETRA SET TEMPO_PB_s='+ntempo+' WHERE ID='+DM.qrSLIDE_MUSICA.FieldByName('LETRA_ID').AsString;
            DM.qrBD.Close;
            DM.qrBD.SQL.Clear;
            DM.qrBD.SQL.Text := query;
            DM.qrBD.ExecSQL;
          Except
            on E: Exception do
            begin
              Memo1.Lines.Add('ERRO SQL: '+E.Message);
              musica := '';
              erro := True;
            end;
          end;
        end;

      end;

      Application.ProcessMessages;
      DM.qrSLIDE_MUSICA.Next;
    end;

    Memo1.Lines.Add(' >> Verifica VOCAL!');
    DM.qrSLIDE_MUSICA.First;
    while not DM.qrSLIDE_MUSICA.eof do
    begin
      if (DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString = 'CAPA') then
      begin
        musica := DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString;
        if (musica <> '') then
        begin
          musica := diretorio(ExtractFilePath(Application.ExeName)+'\config\musicas\'+musica);
          Memo1.Lines.Add(musica);
          if (mus) then
          begin
            BASS_MusicFree(bass_musica);
            BASS_Free();
          end;

          try
            BASS_Init(-1, 44100, 0, Handle, nil);
          except
            //
          end;
          bass_musica := BASS_SampleLoad(FALSE, PChar(musica), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
          bass_channel := BASS_SampleGetChannel(bass_musica, False);
          if not BASS_ChannelPlay(bass_channel, False) then
          begin
            Memo1.Lines.Add(' >> Erro ao carregar audio!');
            musica := '';
            erro := True;
          end;
          mus := True;
        end;
      end
      else
      begin

        if (musica <> '') then
        begin
          tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsInteger;
          ntempo := floattostr(BASS_ChannelBytes2Seconds(bass_channel,tempo));
          Memo1.Lines.Add('TEMPO: '+inttostr(tempo)+' >> '+ntempo);

          Try
            query := 'UPDATE MUSICAS_LETRA SET TEMPO_S='+ntempo+' WHERE ID='+DM.qrSLIDE_MUSICA.FieldByName('LETRA_ID').AsString;
            DM.qrBD.Close;
            DM.qrBD.SQL.Clear;
            DM.qrBD.SQL.Text := query;
            DM.qrBD.ExecSQL;
          Except
            on E: Exception do
            begin
              Memo1.Lines.Add('ERRO SQL: '+E.Message);
              musica := '';
              erro := True;
            end;
          end;
        end;

      end;

      Application.ProcessMessages;
      DM.qrSLIDE_MUSICA.Next;
    end;
    DM.qrSLIDE_MUSICA.Close;

    if (musica <> '') and (erro <> True) then
    begin
      Memo1.Lines.Add(' >> Salva no Banco de Dados!');
      query := 'UPDATE MUSICAS SET `_AJUSTADO`=1  WHERE ID='+DM.qrMUSICA_ATUALIZAR.FieldByName('ID').AsString;
      DM.qrBD.Close;
      DM.qrBD.SQL.Clear;
      DM.qrBD.SQL.Text := query;
      DM.qrBD.ExecSQL;
    end;

    Application.ProcessMessages;
    DM.qrMUSICA_ATUALIZAR.Next;
  end;
  DM.qrMUSICA_ATUALIZAR.Close;

  Memo1.Lines.Add('****FIM****');
end;

procedure TfmIndex.bsSkinButton45Click(Sender: TObject);
begin
  atualizaIgnoreAlbum;
  sTabSheet13Show(Sender);
end;

procedure TfmIndex.bsSkinButton46Click(Sender: TObject);
var
  ids: string;
begin
  ids := lerParam('Config','IgnorarAlbuns','');
  ids := StringReplace(','+ids+',', ',629,', ',', [rfIgnoreCase, rfReplaceAll]);
  ids := StringReplace(ids,',,', ',', [rfIgnoreCase, rfReplaceAll]);
  if (copy(ids,1,1) = ',') then
    ids := copy(ids,2,length(ids));
  if (copy(ids,length(ids),1) = ',') then
    ids := copy(ids,1,length(ids)-1);

  gravaParam('Config','IgnorarAlbuns',ids);

  atualizaIgnoreAlbum;

  DM.qrALBUM_ATIV.Close;
  DM.qrALBUM_ATIV.Open;
  DM.qrALBUM_INATIV.Close;
  DM.qrALBUM_INATIV.Open;

  tsHinarioNShow(Sender);
end;

procedure TfmIndex.bsSkinButton47Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('Deseja restaurar a formatação do texto na tela de retorno?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  apagaParam('Musicas', 'Tamanho Texto Retorno');

  seTamanhoTextoRetorno.Text := fmIndex.lerParam('Musicas', 'Tamanho Texto Retorno', '17');
end;

procedure TfmIndex.bsSkinButton4Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Items[i].Checked := False;
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton5Click(Sender: TObject);
var
  i: integer;
  item: string;
  linha: integer;
begin
  for i := lbSorteio.Items.Count - 1 downto 0 do
  begin
    lbSorteio.ItemIndex := i;
    if (lbSorteio.Items[i].Checked = True) then
    begin
      item := lbSorteio.Items[lbSorteio.ItemIndex].Caption;
      lbSorteio.Items.Delete(i);
      vlSorteados.FindRow(item, linha);
      if linha >= 0 then
        vlSorteados.DeleteRow(linha);
    end;
  end;

  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    item := lbSorteio.Items[lbSorteio.ItemIndex].Caption;
    vlSorteio.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton6Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Items[i].Checked := not lbSorteio.Items[i].Checked;
    lbSorteioItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton7Click(Sender: TObject);
begin
  lbSorteadoNM.Items.Clear;
  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
  end;
end;

procedure TfmIndex.bsSkinButton8Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Items[i].Checked := True;
    lbSorteioNMItemCheckClick(Sender);
  end;
  SorteioContador;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.bsSkinButton9Click(Sender: TObject);
begin
  lbSorteado.Items.Clear;
  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
  end;
end;

procedure TfmIndex.opcCronoCTempoClick(Sender: TObject);
begin
  meESHora.Enabled := (opcCronoCTempo.ItemIndex = 0);
  meESDuracao.Enabled := (opcCronoCTempo.ItemIndex = 1);
  if carrega_opc then exit;

  if (meESHora.Enabled) then meESHora.SetFocus;
  if (meESDuracao.Enabled) then meESDuracao.SetFocus;

  gravaParam('Escola Sabatina', 'TempoFim', inttostr(opcCronoCTempo.ItemIndex));
end;

procedure TfmIndex.busBibliaCapituloChange(Sender: TObject);
begin
  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',(busBibliaCapitulo.ItemIndex+1),[]);
end;

procedure TfmIndex.busBibliaCapituloExit(Sender: TObject);
begin
  busBibliaCapitulo.Text := busBibliaCapitulo.Items[busBibliaCapitulo.ItemIndex];
  DBCtrlGridBibliaCapituloClick(Sender);
end;

procedure TfmIndex.busBibliaLivroChange(Sender: TObject);
begin
  DM.qrBIBLIA_LIVROS.Locate('ID',(busBibliaLivro.ItemIndex+1),[]);
end;

procedure TfmIndex.busBibliaLivroExit(Sender: TObject);
begin
  busBibliaLivro.Text := busBibliaLivro.Items[busBibliaLivro.ItemIndex];
  DBCtrlGridBibliaLivroClick(Sender);
end;

procedure TfmIndex.gridAlbAtDblClick(Sender: TObject);
var
  ids: string;
  DataSet : TDataSet;
  DBGrid: TbsSkinDBGrid;
  Query: TFDQuery;
  i: integer;
begin
  DBGrid := gridAlbAt;
  DataSet := DBGrid.DataSource.DataSet;
  Query := DM.qrALBUM_ATIV;

  if not Query.Active then Exit;
  if Query.RecNo <= 0 then Exit;
  if DBGrid.SelectedRows.Count <= 0
    then DBGrid.SelectedRows.CurrentRowSelected := True;

  ids := lerParam('Config','IgnorarAlbuns','');
  try
   DataSet.DisableControls;
   for i := 0 to DBGrid.SelectedRows.Count-1 do
   begin
//     DataSet.GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
     if ids <> '' then ids := ids+',';
     ids := ids+Query.FieldByName('ID').AsString;
   end;
  finally
    DataSet.EnableControls;
  end;


  gravaParam('Config','IgnorarAlbuns',ids);
  atualizaIgnoreAlbum;
  Query.Close;
  Query.Open;

  DM.qrALBUM_INATIV.Close;
  DM.qrALBUM_INATIV.Open;
  FormResize(Sender);
end;

procedure TfmIndex.gridAlbInatDblClick(Sender: TObject);
var
  ids: string;
  DataSet : TDataSet;
  DBGrid: TbsSkinDBGrid;
  Query: TFDQuery;
  i: integer;
begin
  DBGrid := gridAlbInat;
  DataSet := DBGrid.DataSource.DataSet;
  Query := DM.qrALBUM_INATIV;

  if not Query.Active then Exit;
  if Query.RecNo <= 0 then Exit;
  if DBGrid.SelectedRows.Count <= 0
    then DBGrid.SelectedRows.CurrentRowSelected := True;

  ids := lerParam('Config','IgnorarAlbuns','');
  try
   DataSet.DisableControls;
   for i := 0 to DBGrid.SelectedRows.Count-1 do
   begin
//     DataSet.GotoBookmark(Pointer(DBGrid.SelectedRows.Items[i]));
      ids := StringReplace(','+ids+',', ','+Query.FieldByName('ID').AsString+',', ',', [rfIgnoreCase, rfReplaceAll]);
      if Copy(ids,1,1)=',' then
        ids := copy(ids,2,length(ids));
      if Copy(ids,length(ids),1)=',' then
        ids := copy(ids,1,length(ids)-1);
   end;
  finally
    DataSet.EnableControls;
  end;

  gravaParam('Config','IgnorarAlbuns',ids);
  atualizaIgnoreAlbum;
  Query.Close;
  Query.Open;
  DM.qrALBUM_ATIV.Close;
  DM.qrALBUM_ATIV.Open;
  FormResize(Sender);
end;

procedure TfmIndex.busBibliaVersiculoChange(Sender: TObject);
begin
  carregaBiblia('VSC');
end;

procedure TfmIndex.busBibliaVersiculoKeyPress(Sender: TObject; var Key: Char);
var
  desc_passagem:string;
begin
  if Key = #13 then
  begin
    Key := #0;

    if DBCtrlGridBibliaVersiculo.DataSource.DataSet.Eof
      then Exit;

//    DBCtrlGridBibliaVersiculoClick(Sender);
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := geraIntervaloNum(GetStrNumber2(trim(busBibliaVersiculo.Text)));

    if (loadCol.Strings.Values['BIBLIA_VERSICULO'] = '0') or (trim(loadCol.Strings.Values['BIBLIA_VERSICULO']) = '') then
    begin
      DBCtrlGridBibliaVersiculoClick(Sender);
      exit;
    end;

    loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

    lmdBibliaTxt.Caption := '';
    DBCtrlGridBibliaVersiculo.DataSource.DataSet.First;
    while not DBCtrlGridBibliaVersiculo.DataSource.DataSet.Eof do
    begin
      if lmdBibliaTxt.Caption <> ''
        then lmdBibliaTxt.Caption := lmdBibliaTxt.Caption+#13#10;

      lmdBibliaTxt.Caption := lmdBibliaTxt.Caption+DBCtrlGridBibliaVersiculo.DataSource.DataSet.FieldByName('PASSAGEM').AsString;
      DBCtrlGridBibliaVersiculo.DataSource.DataSet.Next;
    end;
    lmdBibliaTxt.Caption := '"'+removeTagsHTML(lmdBibliaTxt.Caption)+'"';

    lmdBibliaInfo.Caption := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']+' '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+formataIntervaloNum(loadCol.Strings.Values['BIBLIA_P_VERSICULO'])+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
    ajustaTexto('BIBLIA');
    copiaDadosTelaExtendida;

    if (fTransmitir.btServidor.ImageIndex <> 8) then
    begin
       fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaTxt.Caption);
       fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaInfo.Caption);
    end;

    gravaParam('Biblia', 'Versão',loadCol.Strings.Values['BIBLIA_P_VERSAO']);
    gravaParam('Biblia', 'Livro',loadCol.Strings.Values['BIBLIA_P_LIVRO']);
    gravaParam('Biblia', 'Livro Sigla',loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']);
    gravaParam('Biblia', 'Livro Nome',loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']);
    gravaParam('Biblia', 'Capitulo',loadCol.Strings.Values['BIBLIA_P_CAPITULO']);
    gravaParam('Biblia', 'Versiculo',loadCol.Strings.Values['BIBLIA_P_VERSICULO']);

    desc_passagem := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']+'. '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+formataIntervaloNum(loadCol.Strings.Values['BIBLIA_P_VERSICULO'])+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
    if (DM.cdsBIBLIA_HISTORICO.Locate('DESC_PASSAGEM', desc_passagem, [])) then
    begin
      DM.cdsBIBLIA_HISTORICO.Edit;
    end
    else
    begin
      DM.cdsBIBLIA_HISTORICO.Append;
      DM.cdsBIBLIA_HISTORICO.FieldByName('ID').Value := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
      DM.cdsBIBLIA_HISTORICO.FieldByName('DATAHORA').Value := Now;
    end;
    DM.cdsBIBLIA_HISTORICO.FieldByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_P_VERSAO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('LIVRO').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('CAPITULO').Value := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('VERSICULO').Value := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
    DM.cdsBIBLIA_HISTORICO.FieldByName('PASSAGEM').Value := DBCtrlGridBibliaVersiculo.DataSource.DataSet.FieldByName('PASSAGEM_ORI').AsString;
    DM.cdsBIBLIA_HISTORICO.FieldByName('DESC_PASSAGEM').Value := desc_passagem;
    DM.cdsBIBLIA_HISTORICO.Post;


    DBCtrlGridBibliaVersiculo.Refresh;
    DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGridBibliaVersiculo,0,nil,Rect(1, 1, DBCtrlGridBibliaVersiculo.PanelWidth-2, DBCtrlGridBibliaVersiculo.PanelHeight-2));
  end;
end;

procedure TfmIndex.pnlAnotacoesLiturgiaClose(Sender: TObject);
begin
  cbAnotacoesLiturgia.Checked := False;
end;

procedure TfmIndex.pnlBibliaHistoricoClose(Sender: TObject);
begin
  cbBibliaHistorico.Checked := false;
  cbBibliaHistoricoClick(Sender);
end;

procedure TfmIndex.itensAgendadosClick(Sender: TObject);
var
  arquivo: string;
  info: string;
begin
  if (DM.cdsItensAgendados.FieldByName('ID').AsString = '') then
  begin
    MonthCalendar1DblClick(MonthCalendar1);
    Exit;
  end;

  arquivo := DM.cdsItensAgendados.FieldByName('ARQUIVO').AsString;
  info := DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').AsString;

  if info = 'I' then
    arquivo := diretorio(ExtractFilePath(Application.ExeName)+'\')+arquivo;


  if (arquivo <> '') then
  begin
    if (FileExists(arquivo)) then
      abrirArquivo(arquivo)
    else
      application.MessageBox(PChar('Arquivo '''+arquivo+''' não encontrado!'),TITULO,mb_ok+mb_iconerror);
  end;
end;

procedure TfmIndex.categoriasItensAgendadosClick(Sender: TObject);
begin
  if (DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString = '') then
  begin
    btAddCategoriaAgendadosClick(Sender);
    Exit;
  end;

  txtCategoria.Text := DM.cdsCategoriasItensAgendados.FieldByName('ID').AsString;
  DM.cdsItensAgendados.Filtered := true;
  DM.cdsItensAgendados.Filter := 'CATEGORIA = '''+txtCategoria.Text+'''';
  pnlItensAgendados.Visible := True;
  dbctrlItensAgendados.RowCount := Trunc(dbctrlItensAgendados.ClientHeight / 60);
  dbctrlItensAgendados.ColCount := 1;

  refreshCalendar();
end;

procedure TfmIndex.move_MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Panel: TPanel;
  w: integer;
begin
  if Sender is TbsPngImageView
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  move_panel := TPanel.Create(Self);
//  move_panel.Color := Panel.Color;

  move_x := x;
  move_y := y;
  move := True;

  Panel.BringToFront;
  w := Panel.Width;
  Panel.Align := alNone;
  Panel.Width := w;
  Panel.Color := $0085F8FE;
  panel.DoubleBuffered := True;
  sbLiturgia.DoubleBuffered := True;
end;

procedure TfmIndex.move_MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Panel: TPanel;
begin
  if Sender is TbsPngImageView
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  if move then
  begin
    Panel.Left := Panel.Left + (x - move_x);
    Panel.Top := Panel.Top + (y - move_y);
  end;
end;

procedure TfmIndex.move_MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Panel: TPanel;
  i: integer;
  itens: TStringList;
begin
  if Sender is TbsPngImageView
    then Panel := TPanel(TPanel(Sender).Parent.Parent)
    else Panel := TPanel(TPanel(Sender).Parent);

  move := False;
  Panel.Align := alTop;
  Panel.Color := move_panel.Color;

  move_panel.Free;
  panel.DoubleBuffered := False;
  sbLiturgia.DoubleBuffered := False;

  itens := TStringList.Create;
  for i := 0 to pred(sbLiturgia.ControlCount) do
  begin
    if sbLiturgia.Controls[i].Visible
      then itens.Add(FormatFloat('000000000',(sbLiturgia.VScrollBar.RealClientHeight*100)+sbLiturgia.Controls[i].Top)+'|'+sbLiturgia.Controls[i].Name);
  end;
  itens.Sort;
  lbLiturgiaPos.Items.Clear;
  lbLiturgiaPos.Items := itens;
  lbLiturgia.Items.Clear;
  for i := 0 to itens.Count-1 do
    lbLiturgia.Items.Add(Copy(itens[i], Pos('|',itens[i])+1, Length(itens[i])));

  salvaItensLiturgia;
end;

procedure TfmIndex.ckVideoOnJanelaClick(Sender: TObject);
begin
  if ckVideoOnJanela.Checked then
    gravaParam('Videos Online', 'MonitorTelaCheia', '1')
  else
    gravaParam('Videos Online', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.imgCapaProgramaEnter(Sender: TObject);
begin
  imgCapaPrograma.Text := verificaURL(imgCapaPrograma.Text, txtImgCapaProgramaInfo, true);
end;

procedure TfmIndex.imgCapaProgramaExit(Sender: TObject);
begin
  if trim(imgCapaPrograma.Text) <> '' then
  begin
    try
      imgImagemCapa.Picture.LoadFromFile(imgCapaPrograma.Text);
      imgCapaPrograma.Text := verificaURL(imgCapaPrograma.Text, txtImgCapaProgramaInfo);
    except
      application.messagebox(PChar('Arquivo de imagem ''' + imgCapaPrograma.Text + ''' inválido!'), TITULO, MB_OK + mb_iconerror);
      imgImagemCapa.Picture := imgImagemCapaModel.Picture;
      imgCapaPrograma.Text := '';
      txtImgCapaProgramaInfo.Text := '';
    end;
  end
  else
  begin
    imgImagemCapa.Picture := imgImagemCapaModel.Picture;
    txtImgCapaProgramaInfo.Text := '';
  end;
  gravaParam('Config', 'Imagem Fundo', imgCapaPrograma.Text);
  gravaParam('Config', 'Imagem Fundo Info', txtImgCapaProgramaInfo.Text);
end;

procedure TfmIndex.imgFundoMusicaEnter(Sender: TObject);
begin
  imgFundoMusica.Text := verificaURL(imgFundoMusica.Text, txtImgFundoMusicaInfo, true);
end;

procedure TfmIndex.imgFundoMusicaExit(Sender: TObject);
begin
  if trim(imgFundoMusica.Text) <> '' then
  begin
    imgFundoMusica.Text := verificaURL(imgFundoMusica.Text, txtImgFundoMusicaInfo);
  end
  else
  begin
    imgImagemCapa.Picture := imgImagemCapaModel.Picture;
    txtImgCapaProgramaInfo.Text := '';
  end;
  gravaParam('Musicas', 'Imagem Fundo', imgFundoMusica.Text);
  gravaParam('Musicas', 'Imagem Fundo Info', txtImgFundoMusicaInfo.Text);
end;

procedure TfmIndex.cbColorFTxtIChangeColor(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinColorButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Color := TbsSkinColorButton(Sender).ColorValue;
  copiaDadosTelaExtendida;
end;

procedure TfmIndex.cbColorRTxtIChangeColor(Sender: TObject);
var
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  tag := TbsSkinColorButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RE_SetSelBgColor(RichEdit, TbsSkinColorButton(Sender).ColorValue);
end;

procedure TfmIndex.cbColorTxtIChangeColor(Sender: TObject);
var
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  tag := TbsSkinColorButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.SelAttributes.Color := TbsSkinColorButton(Sender).ColorValue;
end;

procedure TfmIndex.cbFormatoChange(Sender: TObject);
var
  nome,param,subparam: string;
begin
  nome := TbsSkinComboBox(Sender).Name;
  if nome = 'cbFormatoHora' then
  begin
    param := 'Relogio';
    subparam := 'FormatoHora';
  end
  else if nome = 'cbFormatoHoraES' then
  begin
    param := 'Escola Sabatina';
    subparam := 'FormatoHora';
  end
  else if nome = 'cbFormatoTempoES' then
  begin
    param := 'Escola Sabatina';
    subparam := 'FormatoTempo';
  end
  else if nome = 'cbFormatoTempoCrono' then
  begin
    param := 'Cronometro';
    subparam := 'FormatoTempo';
  end;


  gravaParam(param, subparam, TbsSkinComboBox(Sender).Items[TbsSkinComboBox(Sender).ItemIndex])
end;

procedure TfmIndex.cbLayoutChange(Sender: TObject);
begin
  gravaParam('Config', 'Layout', IntToStr(cbLayout.ItemIndex));
  DM.bsSkinData1.SkinIndex := cbLayout.ItemIndex;
  layoutValue.Strings.Text := DM.bsSkinData1.SkinList.Skins[cbLayout.ItemIndex].Description;

  if (layoutValue.Strings.Values['cor'] <> '')
    then pnlfmBarraTituloForm.Color := StringToColor(layoutValue.Strings.Values['cor']);

  if (layoutValue.Strings.Values['cor_escura'] <> '')
    then pnlfmTituloRib.Color := StringToColor(layoutValue.Strings.Values['cor_escura']);

  if (layoutValue.Strings.Values['cor_texto'] <> '')
    then pnlTitForm.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto']);

  if (layoutValue.Strings.Values['cor_texto_marc'] <> '')
    then pnlfmSubTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_marc']);

  if (layoutValue.Strings.Values['cor_texto_tit_ribbon'] <> '')
    then lblfmTituloRib.Font.Color := StringToColor(layoutValue.Strings.Values['cor_texto_tit_ribbon']);

  pnlTitForm.Color := pnlfmBarraTituloForm.Color;
  pnlfmSubTituloRib.Color := pnlfmTituloRib.Color;

  btwsMinimize.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMinimize']);
  if (fmIndex.WindowState = wsMaximized)
    then btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btRestore'])
    else btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMaximized']);
  btwsClose.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btClose']);
  btwsDownload.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btDownload']);
end;

procedure TfmIndex.rbDirecaoClick(Sender: TObject);
begin
  txtDecr.Enabled := (rbDirecao.ItemIndex = 1);
  if txtDecr.Enabled then
    txtDecr.Setfocus;

  btZerarCronoClick(Sender);
  gravaParam('Cronometro', 'Direcao', IntToStr(rbDirecao.ItemIndex));
end;

function TfmIndex.RecursiveDelete(FullPath: String;nivel: integer): Boolean;
Var
  sr : TSearchRec;
  iRetorno : Integer;
begin
  Result := False;
  FullPath := IncludeTrailingPathDelimiter(FullPath);
  if not(DirectoryExists(FullPath)) then
    Exit;

  iRetorno := FindFirst(FullPath + '*.*', faAnyFile, sr);
  while iRetorno = 0 do
  begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
      if sr.Attr = faDirectory then
        RecursiveDelete(FullPath + sr.Name,nivel+1)
      else
      begin
        if GetFileAttributes(PWideChar(FullPath + sr.Name)) > 0 then
          SetFileAttributes(PWideChar(FullPath + sr.Name), 0);
        DeleteFile(PWideChar(FullPath + sr.Name));
      end;
      iRetorno := FindNext(sr);
  end;
  FindClose(sr);
  if (nivel > 0) then
    Result := RemoveDir(FullPath)
end;

procedure TfmIndex.refreshCalendar;
//var
//  data: TDate;
begin
//  data := MonthCalendar1.Date;
//  MonthCalendar1.Visible := False;
//  MonthCalendar1.Date := IncMonth(data,12);
//  MonthCalendar1.Date := data;
//  MonthCalendar1.Visible := True;
end;

procedure TfmIndex.opSort_NmKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btAddSorteioNMClick(nil);
end;

procedure TfmIndex.lbSorteioNMItemCheckClick(Sender: TObject);
var
  item: string;
  linha: integer;
begin
  item := lbSorteioNM.Items[lbSorteioNM.ItemIndex].Caption;
  if lbSorteioNM.Items[lbSorteioNM.ItemIndex].Checked = true then
  begin
    vlSorteadosNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
    vlSorteioNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteioNM.DeleteRow(linha);
  end
  else
  begin
    vlSorteioNM.Strings.Values[item] := IntToStr(lbSorteioNM.ItemIndex);
    vlSorteadosNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteadosNM.DeleteRow(linha);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  SorteioContador;
end;

procedure TfmIndex.ckMonitorJanelaClick(Sender: TObject);
begin
  if ckMonitorJanela.Checked then
    gravaParam('Config', 'MonitorTelaCheia', '1')
  else
    gravaParam('Config', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckSlideFormatPersoExtClick(Sender: TObject);
begin
  if ckSlideFormatPersoExt.Checked then
    gravaParam('Musicas', 'ExternoPersonalizado', '1')
  else
    gravaParam('Musicas', 'ExternoPersonalizado', '0');
end;

procedure TfmIndex.ckSlideImgFormatPersoClick(Sender: TObject);
begin
  bsFormatSlideImgPerso.Visible := False;
  if ckSlideImgFormatPerso.Checked
    then bsFormatSlImgPerso.Height := 48
    else bsFormatSlImgPerso.Height := 24;
  bsFormatSlideImgPerso.Visible := ckSlideImgFormatPerso.Checked;
  if ckSlideImgFormatPerso.Checked then
    gravaParam('Musicas', 'FundoPersonalizado', '1')
  else
    gravaParam('Musicas', 'FundoPersonalizado', '0');
end;

procedure TfmIndex.ckSlideTxtFormatPersoClick(Sender: TObject);
begin
  bsFormatSlidePerso.Visible := False;
  if ckSlideTxtFormatPerso.Checked
    then bsFormatSlPerso.Height := 72
    else bsFormatSlPerso.Height := 24;
  bsFormatSlidePerso.Visible := ckSlideTxtFormatPerso.Checked;
  if ckSlideTxtFormatPerso.Checked then
    gravaParam('Musicas', 'TextoPersonalizado', '1')
  else
    gravaParam('Musicas', 'TextoPersonalizado', '0');
end;

procedure TfmIndex.ckMusicaFundoTransparenteClick(Sender: TObject);
begin
  if ckMusicaFundoTransparente.Checked then
    gravaParam('Musicas', 'FundoTransparente', '1')
  else
    gravaParam('Musicas', 'FundoTransparente', '0');
end;

procedure TfmIndex.ckMusicaJanelaClick(Sender: TObject);
begin
  if ckMusicaJanela.Checked then
    gravaParam('Musicas', 'MonitorTelaCheia', '1')
  else
    gravaParam('Musicas', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckMusicaOperadorClick(Sender: TObject);
begin
  if ckMusicaOperador.Checked then
    gravaParam('Musicas', 'ModoOperador', '1')
  else
    gravaParam('Musicas', 'ModoOperador', '0');
end;

procedure TfmIndex.ckMusicaRetornoClick(Sender: TObject);
begin
  bsFormatSlideRetorno.Visible := False;
  if ckMusicaRetorno.Checked
    then bsFormatSlRetorno.Height := 48
    else bsFormatSlRetorno.Height := 24;
  bsFormatSlideRetorno.Visible := ckMusicaRetorno.Checked;
  if ckMusicaRetorno.Checked then
    gravaParam('Musicas', 'ModoRetorno', '1')
  else
    gravaParam('Musicas', 'ModoRetorno', '0');
end;

procedure TfmIndex.ckMusicaTituloSlideClick(Sender: TObject);
begin
  if ckMusicaTituloSlide.Checked then
    gravaParam('Musicas', 'TituloSlide', '1')
  else
    gravaParam('Musicas', 'TituloSlide', '0');
end;

procedure TfmIndex.ckMusicaTopoClick(Sender: TObject);
begin
  if ckMusicaTopo.Checked then
    gravaParam('Musicas', 'Topo', '1')
  else
    gravaParam('Musicas', 'Topo', '0');
end;

procedure TfmIndex.ckPlayerAudioClick(Sender: TObject);
begin
  if ckPlayerAudio.Checked then
    gravaParam('Player', 'Audio', '1')
  else
    gravaParam('Player', 'Audio', '0');
end;

procedure TfmIndex.ckPlayerTelaCheiaClick(Sender: TObject);
begin
  if ckPlayerTelaCheia.Checked then
    gravaParam('Player', 'MonitorTelaCheia', '1')
  else
    gravaParam('Player', 'MonitorTelaCheia', '0');
end;

procedure TfmIndex.ckPlayerVideoClick(Sender: TObject);
begin
  if ckPlayerVideo.Checked then
    gravaParam('Player', 'Video', '1')
  else
    gravaParam('Player', 'Video', '0');
end;

procedure TfmIndex.ckSorteioExpClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if ckSorteioExp.ItemChecked[0] then
    gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '1')
  else
    gravaParam('Sorteio', 'Numeros Sorteio (Extendido)', '0');

  if ckSorteioExp.ItemChecked[1] then
    gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '1')
  else
    gravaParam('Sorteio', 'Numeros Sorteados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.ckSorteioExpNMClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if ckSorteioExpNM.ItemChecked[0] then
    gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '1')
  else
    gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '0');

  if ckSorteioExpNM.ItemChecked[1] then
    gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '1')
  else
    gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '0');

  copiaDadosTelaExtendida;
end;

procedure TfmIndex.ckMesmaJanelaClick(Sender: TObject);
begin
  if ckMesmaJanela.Checked then
    gravaParam('Config', 'ckMesmaJanela', '1')
  else
    gravaParam('Config', 'ckMesmaJanela', '0');
end;

procedure TfmIndex.bsSkinSpeedButton10Click(Sender: TObject);
begin
  abrePagina(tsBuscaBiblica);
end;

procedure TfmIndex.bsSkinSpeedButton12Click(Sender: TObject);
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  abreLetra(DM.qrHINOS.FieldByName('ID').AsInteger, txtHino.Text);
end;

procedure TfmIndex.bsSkinSpeedButton12NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  abreLetra(DM.qrHINOSN.FieldByName('ID').AsInteger, txtHino.Text);
end;

procedure TfmIndex.bsSkinSpeedButton13Click(Sender: TObject);
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOS.fieldbyname('ID').AsInteger,DM.qrHINOS.fieldbyname('ALBUM').AsString,DM.qrHINOS.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOS.fieldbyname('ID').AsInteger,DM.qrHINOS.fieldbyname('ALBUM').AsString,DM.qrHINOS.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.bsSkinSpeedButton13NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.bsSkinSpeedButton14Click(Sender: TObject);
begin
  abrePagina(tsBuscaMusica);
//  ckgColetaneas.ItemIndex := 0;
end;

procedure TfmIndex.bsSkinSpeedButton16Click(Sender: TObject);
begin
  abrePagina(tsDoxologia);
end;

procedure TfmIndex.btBibVersAntClick(Sender: TObject);
begin
  if (trim(busBibliaVersiculo.Text) <> '') then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
    busBibliaVersiculo.Text := '';
    busBibliaVersiculoChange(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaLivroClick(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaCapituloClick(Sender);
  end;

  if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = '0')
    then loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '1';

  DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',menorLista(loadCol.Strings.Values['BIBLIA_P_VERSICULO']),[]);
  DM.qrBIBLIA_VERSICULOS.Prior;
  if (DM.qrBIBLIA_VERSICULOS.Bof) then
  begin
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_P_CAPITULO'],[]);
    DM.qrBIBLIA_CAPITULOS.Prior;
    if (DM.qrBIBLIA_CAPITULOS.Bof) then
    begin
      DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_P_LIVRO'],[]);
      DM.qrBIBLIA_LIVROS.Prior;
      if (DM.qrBIBLIA_LIVROS.Bof) then
      begin
        DM.qrBIBLIA_LIVROS.Last;
      end;
      DBCtrlGridBibliaLivroClick(Sender);
      DM.qrBIBLIA_CAPITULOS.Last;
    end;
    DBCtrlGridBibliaCapituloClick(Sender);
    DM.qrBIBLIA_VERSICULOS.Last;
  end;
  DBCtrlGridBibliaVersiculoClick(Sender);
end;

procedure TfmIndex.btBibVersSegClick(Sender: TObject);
begin
  if (trim(busBibliaVersiculo.Text) <> '') then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';
    busBibliaVersiculo.Text := '';
    busBibliaVersiculoChange(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaLivroClick(Sender);
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    DBCtrlGridBibliaCapituloClick(Sender);
  end;

  if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = '0')
    then loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := '1';

  DM.qrBIBLIA_VERSICULOS.Locate('VERSICULO',maiorLista(loadCol.Strings.Values['BIBLIA_P_VERSICULO']),[]);
  DM.qrBIBLIA_VERSICULOS.Next;
  if (DM.qrBIBLIA_VERSICULOS.Eof) then
  begin
    DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_P_CAPITULO'],[]);
    DM.qrBIBLIA_CAPITULOS.Next;
    if (DM.qrBIBLIA_CAPITULOS.Eof) then
    begin
      DM.qrBIBLIA_LIVROS.Locate('ID',loadCol.Strings.Values['BIBLIA_P_LIVRO'],[]);
      DM.qrBIBLIA_LIVROS.Next;
      if (DM.qrBIBLIA_LIVROS.Eof) then
      begin
        DM.qrBIBLIA_LIVROS.First;
      end;
      DBCtrlGridBibliaLivroClick(Sender);
      DM.qrBIBLIA_CAPITULOS.First;
    end;
    DBCtrlGridBibliaCapituloClick(Sender);
    DM.qrBIBLIA_VERSICULOS.First;
  end;
  DBCtrlGridBibliaVersiculoClick(Sender);
end;

procedure TfmIndex.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfEditorSlides, fEditorSlides);
  fEditorSlides.Show;
end;

procedure TfmIndex.bsSkinSpeedButton20Click(Sender: TObject);
begin
  abrePagina(tsPersonalizadas);
end;

procedure TfmIndex.bsSkinSpeedButton23Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
(*
  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
  fEnviaMensagem.edAssunto.Text := 'Erro no Hino "' + DM.qrHINOS.FieldByName('NOME_COM').AsString + '"';
  fEnviaMensagem.param := 'MUSICA.ID=' + DM.qrHINOS.FieldByName('ID').AsString;
  fEnviaMensagem.mmMensagem.Lines.Add('Especifique o erro:');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Erro nos tempos dos slides');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Erro de ortografia');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Imagem inapropriada');
  fEnviaMensagem.mmMensagem.Lines.Add('(    ) Outro: [especifique]');
  fEnviaMensagem.mmMensagem.Lines.Add('');
  fEnviaMensagem.mmMensagem.Lines.Add('[Informe aqui mais detalhes]');
  fEnviaMensagem.ShowModal;    *)
end;

procedure TfmIndex.bsSkinSpeedButton24Click(Sender: TObject);
var
  i, j: Integer;
  id: string;
  url: string;
  nome: string;
  arquivos: TStringList;
begin
  arquivos := TStringList.Create;
  ExtractStrings(['|'], [], PChar(openDialog('arquivo', '', '',true)), arquivos);

  for i := 0 to arquivos.Count - 1 do
  begin
    id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    while (DM.cdsCOLETANEAS_PERSO.Locate('ID', id, [])) do
    begin
      id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
      Sleep(100);
    end;

    j := 0;
    nome := ChangeFileExt(ExtractFileName(arquivos[i]), '');
    while (DM.cdsCOLETANEAS_PERSO.Locate('NOME', nome, [])) do
    begin
      j := j + 1;
      nome := ChangeFileExt(ExtractFileName(arquivos[i]), '') + inttostr(j);
    end;

    txtUrlInfoColetV.Text := '';
    url := verificaURL(arquivos[i], txtUrlInfoColetV);

    DM.cdsCOLETANEAS_PERSO.Append;
    DM.cdsCOLETANEAS_PERSO.FieldByName('ID').Value := id;
    DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').Value := nome;
    DM.cdsCOLETANEAS_PERSO.FieldByName('URL_INFO').Value := txtUrlInfoColetV.Text;
    DM.cdsCOLETANEAS_PERSO.FieldByName('URL').Value := url;
    DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM_INFO').Value := '';
    DM.cdsCOLETANEAS_PERSO.FieldByName('IMAGEM').Value := '';
    DM.cdsCOLETANEAS_PERSO.Post;
  end;

  if arquivos.Count > 0 then
  begin
    loadCol.Strings.Values['PERSO'] := '';
    tsPersonalizadasShow(Sender);
  end;
end;

procedure TfmIndex.bsSkinSpeedButton25Click(Sender: TObject);
begin
  abrePagina(tsCronoCulto);
end;

procedure TfmIndex.bsSkinSpeedButton26Click(Sender: TObject);
begin
  abrePagina(tsLiturgia);
end;

procedure TfmIndex.bsSkinSpeedButton27Click(Sender: TObject);
begin
  abrePagina(tsPainelD);
end;

procedure TfmIndex.bsSkinSpeedButton28Click(Sender: TObject);
begin
  abrePagina(tsSorteioNM);
end;

procedure TfmIndex.bsSkinSpeedButton29Click(Sender: TObject);
begin
  abrePagina(tsCronometro);
end;

procedure TfmIndex.bsSkinSpeedButton2Click(Sender: TObject);
begin
  abrePagina(tsMusicasInfantis);
end;

procedure TfmIndex.btAddColPersoClick(Sender: TObject);
begin
  pnlAddColPerso.Visible := not pnlAddColPerso.Visible;
  btAddColPerso.Down := pnlAddColPerso.Visible;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
  if pnlAddColPerso.Visible then
  begin
    txtColetanea.text := '';
    txtUrlInfoColet.text := '';
    txtAbrirColet.text := '';
    txtImgInfoColet.text := '';
    txtCapaColet.text := '';
    txtAbrirColet.SetFocus;
  end;
end;

procedure TfmIndex.btAltColPersoClick(Sender: TObject);
begin
  pnlAltColPerso.Visible := not pnlAltColPerso.Visible;
  btAltColPerso.Down := pnlAltColPerso.Visible;
  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);
  if pnlAltColPerso.Visible then
  begin
    cbColetaneasPerso.KeyValue := -1;
    cbColetaneasPerso.Enabled := True;
    txtColetanea2.text := '';
    txtUrlInfoColet2.text := '';
    txtAbrirColet2.text := '';
    txtImgInfoColet2.text := '';
    txtCapaColet2.text := '';
    txtAbrirColet2.SetFocus;
  end;
end;

procedure TfmIndex.btAbreHinosClick(Sender: TObject);
begin
  abrePagina(tsHinario);
end;

procedure TfmIndex.btAbreHinosNClick(Sender: TObject);
begin
  abrePagina(tsHinarioN);
end;

procedure TfmIndex.btAbreSaveVideoOn(campo: TbsSkinEdit);
begin
  if (campo.Text = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    campo.SetFocus;
    exit;
  end;

  btColetaneasOnlinePersoClick(nil);
  txtNomeVideoOn3.Text := '';
  txtUrlVideoOn3.Text := campo.Text;
  campo.Text := '';
  txtNomeVideoOn3.SetFocus;
end;

procedure TfmIndex.bsSkinSpeedButton30Click(Sender: TObject);
begin
  abrePagina(tsSorteio);
end;

procedure TfmIndex.bsSkinSpeedButton31Click(Sender: TObject);
begin
  abrePagina(tsTextoInterativo);
end;

procedure TfmIndex.bsSkinSpeedButton37Click(Sender: TObject);
var
  url: string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
end;

procedure TfmIndex.btErroClick(Sender: TObject);
var
url:string;
begin
  url := fmIndex.param.Strings.Values['form'+fIniciando.LANG];
  if (url = '') then
    Application.MessageBox(PChar('Não foi possível acessar o formulário de contato! Acesse o formulário em https://louovorja.com.br!'), fmIndex.TITULO, mb_ok + mb_iconinformation)
  else
    ShellExecute(handle, nil, PChar(url), nil, nil, SW_MAXIMIZE);
(*  fIniciando.AppCreateForm(TfEnviaMensagem, fEnviaMensagem);
  fEnviaMensagem.edAssunto.Text := 'Sugestão de Música para a Categoria "' + lblDoxologiaCate.Caption + '"';
  fEnviaMensagem.param := 'DOXOLOGIA=' + lblDoxologiaCate.Caption;
  fEnviaMensagem.mmMensagem.Lines.Add('Música a ser sugerida para esta categoria: [Especifique]');
  fEnviaMensagem.ShowModal;    *)
end;

procedure TfmIndex.btExecSQLClick(Sender: TObject);
begin
  DM.qrBD.Close;
  DM.qrBD.SQL.Clear;
  DM.qrBD.SQL.Text := mmBD.Text;
  DM.qrBD.Open;

  AjustaLarguraCamposDBGrid(bsSkinDBGrid2);
end;

procedure TfmIndex.btExecVideoOn(campo: TbsSkinEdit; limpa: Boolean);
var
  videoID: string;
begin
  videoID := trim(campo.Text);

  if (videoID = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    campo.SetFocus;
    exit;
  end;

  videoID := getVideoID(videoID);

  if (limpa = True) then
    campo.Text := '';
  abreVideoOn(videoID, 'Vídeo do Youtube');
end;

procedure TfmIndex.btExibeTxtPainelDClick(Sender: TObject);
begin
  pnlTxtPainelD.DoubleBuffered := True;
  lmdTxtPainelD.Caption := mmPainelD.Text;
  copiaDadosTelaExtendida;
  pnlTxtPainelD.DoubleBuffered := False;
end;

procedure TfmIndex.bsSkinSpeedButton38Click(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('arquivo', 'Formato Rich Text (*.rtf)|*.rtf|Arquivos de Texto (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*');
  if arq <> '' then
  begin
    RichEdit0.Lines.Clear;
    RichEdit0.Lines.LoadFromFile(arq);
  end;
end;

procedure TfmIndex.bsSkinSpeedButton39Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.CutToClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton3NClick(Sender: TObject);
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrHINOSN.fieldbyname('ID').AsInteger,DM.qrHINOSN.fieldbyname('ALBUM').AsString,DM.qrHINOSN.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.btSortearNMClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if (Trim(opSort_NM.Text) <> '') then
    btAddSorteioNMClick(Sender);

  if vlSorteioNM.Strings.Count <= 0 then
  begin
    lmdSorteioNM.Caption := '----';
    if fMonitorSorteioNomes <> nil then
      fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
    application.messagebox('Não há nomes disponíveis para serem sorteados!', TITULO, mb_ok + mb_iconexclamation);
    opSort_NM.SetFocus;
    exit;
  end;

  vSorteioAnimFimNM := IncMilliSecond(Now,trunc(seSorteioTempoNM.Value*1000));
  gSorteioNM.MaxValue := trunc(vSorteioAnimFimNM * 10000000000);
  gSorteioNM.MinValue := trunc(now * 10000000000);

  pnlSorteioNM.DoubleBuffered := True;
  DM.tmrSortearNM.Enabled := true;
end;

procedure TfmIndex.btFormatClick(Sender: TObject);
var
  tag: integer;
  pwd: string;
begin
  if TbsSkinSpeedButton(Sender).Down then
  begin
    pwd := lerParam('Senha', 'Formatacao', '');

    if Trim(pwd) <> '' then
    begin
      application.MessageBox('O administrador do sistema bloqueou o acesso à este recurso! Para continuar, será necessário colocar a senha de acesso!', titulo, mb_ok + MB_ICONINFORMATION);

      DM.pwd.Password := '';
      DM.pwd.Execute;

      if (DM.pwd.Password = '') then
      begin
        TbsSkinSpeedButton(Sender).Down := False;
        exit;
      end;

      if (DM.pwd.Password = pwd)
        then pwd := '';
    end;
  end
  else pwd := '';


  if Trim(pwd) <> '' then
  begin
    application.MessageBox('Senha incorreta!', titulo, mb_ok + mb_iconerror);
    TbsSkinSpeedButton(Sender).Down := False;
    exit;
  end;

  tag := TbsSkinSpeedButton(Sender).tag;
  if (tag = 1) then
  begin
    pnlFormatBiblia.Visible := btFormatBiblia.Down;
      ajustaTexto('BIBLIA');
  end
  else if (tag = 2) then
  begin
    pnlFormatBibliaB.Visible := btFormatBibliaB.Down;
    ajustaTexto('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    pnlFormatEscSB.Visible := btFormatEscSB.Down;
    lmdEscSb.Top := 0;
    lmdEscSb.Left := 0;
    lmdEscSb.Width := pnlEscSB.Width;
    lmdEscSb.Height := round(pnlEscSB.Height / 2);
    lmdEscSbR.Top := round(pnlEscSB.Height / 2);
    lmdEscSbR.Left := 0;
    lmdEscSbR.Width := pnlEscSB.Width;
    lmdEscSbR.Height := round(pnlEscSB.Height / 2);
  end
  else if (tag = 4) then
    pnlFormatSorteio.Visible := btFormatSorteio.Down
  else if (tag = 5) then
    pnlFormatCrono.Visible := btFormatCrono.Down
  else if (tag = 6) then
    pnlFormatSorteioNM.Visible := btFormatSorteioNM.Down
  else if (tag = 7) then
    pnlFormatPainelD.Visible := btFormatPainelD.Down
  else if (tag = 9) then
    pnlFormatRelogio.Visible := btFormatRelogio.Down;
end;

procedure TfmIndex.btLimpaSorteioClick(Sender: TObject);
var
  i: integer;
begin
  if application.messagebox(PChar('Deseja realmente reiniciar o sorteio?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteio.Caption := '0000';
  lbSorteado.items.Clear;
  for i := 0 to lbSorteio.Items.Count - 1 do
  begin
    lbSorteio.ItemIndex := i;
    lbSorteio.Items[i].Checked := False;
    lbSorteioItemCheckClick(Sender);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.items.Clear;
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
  end;
end;

procedure TfmIndex.btLimpaSorteioReiniciaClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteio.Caption := '0000';
  if fMonitorSorteio <> nil then
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
end;

procedure TfmIndex.btLimpaSorteioReiniciaNMClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteioNM.Caption := '----';
  if fMonitorSorteioNomes <> nil then
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
end;

procedure TfmIndex.btLitClipBoardClick(Sender: TObject);
var
  i: Integer;
begin
  if (application.MessageBox('Colar itens da área de transferência?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;

  for i := 0 to cboard.Items.Count-1 do
  begin
    fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
    fLiturgia.Caption := 'Adicionar Item';
    fLiturgia.id := '';
    fLiturgia.Show;
    if (FileExists(cboard.Items[i])) or (DirectoryExists(cboard.Items[i])) then
    begin
      fLiturgia.cbItens.ItemIndex := fLiturgia.cbItens.Items.IndexOf('Arquivo/Diretório');
      fLiturgia.txtItem.Text := ChangeFileExt(ExtractFileName(cboard.Items[i]),'');
      fLiturgia.edtDiretorio.Text := cboard.Items[i];
      fLiturgia.btAddClick(Sender);
    end
    else
    begin
      fLiturgia.cbItens.ItemIndex := fLiturgia.cbItens.Items.IndexOf('Anotação');
      fLiturgia.txtItem.Text := cboard.Items[i];
      fLiturgia.edtAnotacao.Text := cboard.Items[i];
      fLiturgia.btAddClick(Sender);
    end;
  end;
end;

procedure TfmIndex.btBibBusVersAntClick(Sender: TObject);
begin
  if not DM.qrBIBLIA_BUSCA.Active then exit;
  if DM.qrBIBLIA_BUSCA.RecordCount <= 0 then exit;

  if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = '')
    then DM.qrBIBLIA_BUSCA.First
  else
  begin
    DM.qrBIBLIA_BUSCA.Locate('DESC_PASSAGEM2',loadCol.Strings.Values['BIBLIA_BUSCA_INFO'],[]);
    DM.qrBIBLIA_BUSCA.Prior;
  end;

  if (DM.qrBIBLIA_BUSCA.Bof) then DM.qrBIBLIA_BUSCA.Last;

  DBCtrlGridBibliaBuscaClick(Sender);
end;

procedure TfmIndex.btBibBusVersSegClick(Sender: TObject);
begin
  if not DM.qrBIBLIA_BUSCA.Active then exit;
  if DM.qrBIBLIA_BUSCA.RecordCount <= 0 then exit;

  if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = '')
    then DM.qrBIBLIA_BUSCA.First
  else
  begin
    DM.qrBIBLIA_BUSCA.Locate('DESC_PASSAGEM2',loadCol.Strings.Values['BIBLIA_BUSCA_INFO'],[]);
    DM.qrBIBLIA_BUSCA.Next;
  end;

  if (DM.qrBIBLIA_BUSCA.Eof) then DM.qrBIBLIA_BUSCA.First;

  DBCtrlGridBibliaBuscaClick(Sender);
end;

procedure TfmIndex.btBibLocalizaClick(Sender: TObject);
begin
  carregaBiblia('BUS');
end;

procedure TfmIndex.btLimpaSorteioLimpaClick(Sender: TObject);
var
  i, linha: integer;
  item: string;
begin
  if application.messagebox(PChar('Deseja realmente zerar o sorteio?' + #13 + 'Todos os números serão apagados!'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  for i := lbSorteio.Items.Count - 1 downto 0 do
  begin
    lbSorteio.ItemIndex := i;
    item := lbSorteio.Items[lbSorteio.ItemIndex].Caption;
    lbSorteio.Items.Delete(i);
    vlSorteio.FindRow(item, linha);
    if linha >= 0 then
      vlSorteio.DeleteRow(linha);
    vlSorteados.FindRow(item, linha);
    if linha >= 0 then
      vlSorteados.DeleteRow(linha);
  end;

  lbSorteado.Items.Clear;
  lmdSorteio.Caption := '0000';
  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteado.items.Clear;
    fMonitorSorteio.lbSorteio.items.Clear;
    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
  end;
  SorteioContador();
end;

procedure TfmIndex.btLimpaSorteioLimpaNMClick(Sender: TObject);
var
  i, linha: integer;
  item: string;
begin
  if application.messagebox(PChar('Deseja realmente zerar o sorteio?' + #13 + 'Todos os nomes serão apagados!'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  for i := lbSorteioNM.Items.Count - 1 downto 0 do
  begin
    lbSorteioNM.ItemIndex := i;
    item := lbSorteioNM.Items[lbSorteioNM.ItemIndex].Caption;
    lbSorteioNM.Items.Delete(i);
    vlSorteioNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteioNM.DeleteRow(linha);
    vlSorteadosNM.FindRow(item, linha);
    if linha >= 0 then
      vlSorteadosNM.DeleteRow(linha);
  end;

  lbSorteadoNM.Items.Clear;
  lmdSorteioNM.Caption := '----';
  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.items.Clear;
    fMonitorSorteioNomes.lbSorteioNM.items.Clear;
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
  end;
  SorteioContador();
end;

procedure TfmIndex.btLimpaSorteioNMClick(Sender: TObject);
var
  i: integer;
begin
  if application.messagebox(PChar('Deseja realmente reiniciar o sorteio?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  lmdSorteioNM.Caption := '----';
  lbSorteadoNM.items.Clear;
  for i := 0 to lbSorteioNM.Items.Count - 1 do
  begin
    lbSorteioNM.ItemIndex := i;
    lbSorteioNM.Items[i].Checked := False;
    lbSorteioNMItemCheckClick(Sender);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteadoNM.items.Clear;
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
  end;
end;

procedure TfmIndex.btAddSorteioClick(Sender: TObject);
var
  i, ini, fin, linha: integer;
  Item: TbsSkinOfficeItem;
  Numero: string;
begin
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if trim(opSort_Ini.text) = '' then
  begin
    if (trim(opSort_Fin.text) = '') then
    begin
      if (Sender <> nil) then
        application.MessageBox('Coloque o número para ser adicionado!', TITULO, mb_ok + mb_iconexclamation);
      opSort_Ini.SetFocus;
      Exit;
    end;
    opSort_Ini.text := opSort_Fin.text;
    opSort_Fin.text := '';
  end;

  if trim(opSort_Fin.text) = '' then
    opSort_Fin.text := opSort_Ini.text;

  ini := strtoint(opSort_Ini.text);
  fin := strtoint(opSort_Fin.text);

  if ini > fin then
  begin
    fin := strtoint(opSort_Ini.text);
    ini := strtoint(opSort_Fin.text);
  end;

  for i := ini to fin do
  begin

    Numero := formatfloat('0000', i);
    if Trim(vlSorteio.Strings.Values[Numero]) <> '' then
    begin
      lbSorteio.Items[StrToInt(vlSorteio.Strings.Values[Numero])].Checked := False;
    end
    else if Trim(vlSorteados.Strings.Values[Numero]) <> '' then
    begin
      lbSorteio.Items[StrToInt(vlSorteados.Strings.Values[Numero])].Checked := False;
      vlSorteio.Strings.Values[Numero] := vlSorteados.Strings.Values[Numero];
      vlSorteados.FindRow(Numero, linha);
      vlSorteados.DeleteRow(linha);
    end
    else
    begin
      Item := lbSorteio.Items.Add();
      Item.Caption := Numero;

      vlSorteio.Strings.Values[Numero] := IntToStr(Item.Index);
    end;

  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  opSort_Ini.text := '';
  opSort_Fin.text := '';
  SorteioContador();
  opSort_Ini.SetFocus;
end;

procedure TfmIndex.btAddSorteioNMClick(Sender: TObject);
var
  linha: integer;
  Item: TbsSkinOfficeItem;
  nome: string;
begin
  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if trim(opSort_Nm.text) = '' then
  begin
    if (Sender <> nil) then
      application.MessageBox('Digite o nome para ser adicionado!', TITULO, mb_ok + mb_iconexclamation);
    opSort_Nm.SetFocus;
    Exit;
  end;

  nome := Copy(opSort_Nm.Text, 0, opSort_Nm.MaxLength);
  if Trim(vlSorteioNM.Strings.Values[nome]) <> '' then
  begin
    lbSorteioNM.Items[StrToInt(vlSorteioNM.Strings.Values[nome])].Checked := False;
  end
  else if Trim(vlSorteadosNM.Strings.Values[nome]) <> '' then
  begin
    lbSorteioNM.Items[StrToInt(vlSorteadosNM.Strings.Values[nome])].Checked := False;
    vlSorteioNM.Strings.Values[nome] := vlSorteadosNM.Strings.Values[nome];
    vlSorteadosNM.FindRow(nome, linha);
    vlSorteadosNM.DeleteRow(linha);
  end
  else
  begin
    Item := lbSorteioNM.Items.Add();
    Item.Caption := nome;

    vlSorteioNM.Strings.Values[nome] := IntToStr(Item.Index);
  end;

  if fMonitorSorteioNomes <> nil then
  begin
    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  end;

  opSort_NM.text := '';
  SorteioContador();
  opSort_NM.SetFocus;
end;

procedure TfmIndex.btfsBoldClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  if (fsBold in RichEdit.SelAttributes.Style) then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsBold]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsBold];
end;

procedure TfmIndex.btfsItalicClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  if (fsItalic in RichEdit.SelAttributes.Style) then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsItalic]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsItalic];
end;

procedure TfmIndex.btfsStrikeOutClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  if (fsStrikeOut in RichEdit.SelAttributes.Style) then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsStrikeOut]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsStrikeOut];
end;

procedure TfmIndex.btfsUnderlineClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  if (fsUnderline in RichEdit.SelAttributes.Style) then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsUnderline]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsUnderline];
end;

procedure TfmIndex.bsSkinSpeedButton41Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.CopyToClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton42Click(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.PasteFromClipboard;
end;

procedure TfmIndex.bsSkinSpeedButton43Click(Sender: TObject);
var
  arq: string;
begin
  arq := saveDialog('texto', 'Formato Rich Text (*.rtf)|*.rtf');
  if arq <> '' then RichEdit0.Lines.SaveToFile(arq);
end;

procedure TfmIndex.bsSkinSpeedButton44Click(Sender: TObject);
var
  SelStart, SelLength: integer;
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));

  paramtemp.Lines.Clear;
  SelStart := RichEdit.SelStart;
  SelLength := RichEdit.SelLength;
  paramtemp.Text := RichEdit.SelText;
  RichEdit.ClearSelection;
  RichEdit.SelText := paramtemp.Text;
  RichEdit.SelStart := SelStart;
  RichEdit.SelLength := SelLength;
  RichEdit.SelAttributes.Name := RichEdit.DefaultFont.Name;
  RichEdit.SelAttributes.Size := RichEdit.DefaultFont.Size;
  RichEdit.SelAttributes.Color := RichEdit.DefaultFont.Color;
  RichEdit.SelAttributes.Style := RichEdit.DefaultFont.Style;
  RE_SetSelBgColor(RichEdit, clWhite);
end;

procedure TfmIndex.bsSkinSpeedButton45Click(Sender: TObject);
var
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  if application.messagebox(PChar('Deseja realmente apagar o texto?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    exit;

  tag := TbsSkinFontComboBox(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Lines.Clear;
end;

procedure TfmIndex.bsSkinSpeedButton46Click(Sender: TObject);
begin
  Application.MessageBox('Para excluir uma coletânea, clique com o botão direito sobre ela, e em seguida, opção "Excluir".', TITULO, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.bttaLeftJustifyClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Paragraph.Alignment := taLeftJustify;
end;

procedure TfmIndex.bttaRightJustifyClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Paragraph.Alignment := taRightJustify;
end;

procedure TfmIndex.bttaCenterClick(Sender: TObject);
var
  tag: integer;
  RichEdit: TbsSkinRichEdit;
begin
  tag := TbsSkinSpeedButton(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.Paragraph.Alignment := taCenter;
end;

procedure TfmIndex.bsSkinSpeedButton4Click(Sender: TObject);
begin
  abrePagina(tsDiversas);
end;

procedure TfmIndex.bsSkinSpeedButton50Click(Sender: TObject);
begin
  abrePagina(tsRelogio);
end;

procedure TfmIndex.bsSkinSpeedButton53Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TbsSkinCheckBox;
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TbsSkinCheckBox(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := True;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton54Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TbsSkinCheckBox;
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TbsSkinCheckBox(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := False;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton55Click(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TbsSkinCheckBox;
begin
  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TbsSkinCheckBox(FindComponent(item+'_checkb'));
    if Assigned(checkbox)
      then checkbox.Checked := not checkbox.Checked;
  end;
end;

procedure TfmIndex.btApagaLitSelClick(Sender: TObject);
var
  i: integer;
  item: string;
  checkbox: TbsSkinCheckBox;
begin
  if application.messagebox(PChar('Deseja realmente apagar todos os itens marcados?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  for i := lbLiturgia.Items.Count-1 downto 0 do
  begin
    item := lbLiturgia.Items[i];
    checkbox := TbsSkinCheckBox(FindComponent(item+'_checkb'));
    if Assigned(checkbox) then
    begin
      if checkbox.Checked
        then apagaItemLiturgia(item);
    end;
  end;
end;

procedure TfmIndex.bsSkinSpeedButton58Click(Sender: TObject);
begin
  abrePagina(tsColetaneasOnline);
end;

procedure TfmIndex.bsSkinSpeedButton59Click(Sender: TObject);
begin
  abrePagina(tsBuscaMusica);
//  ckgColetaneas.ItemIndex := 1;
end;

procedure TfmIndex.bsSkinSpeedButton5Click(Sender: TObject);
begin
  abrePagina(tsItensAgendados);
end;

procedure TfmIndex.btUrlVideoOnClick(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn);
end;

procedure TfmIndex.bsSkinSpeedButton60Click(Sender: TObject);
begin
  if (application.MessageBox(PChar('A atualização de todos os vídeos pode demorar um pouco!' + #13 + #10 + 'Deseja continuar?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;
  atualiza_coletaneas_web('tudo');
end;

procedure TfmIndex.bsSkinSpeedButton61Click(Sender: TObject);
begin
  btAbreSaveVideoOn(txtUrlVideoOn);
end;

procedure TfmIndex.bsSkinSpeedButton62Click(Sender: TObject);
begin
  if (fVideoOn <> nil) and (fVideoOn.Visible) then
    fVideoOn.Close
  else
    application.MessageBox(PChar('Não há nenhum vídeo aberto para ser encerrado!'), titulo, mb_ok + mb_iconinformation);
end;

procedure TfmIndex.btMusicaLetraClick(Sender: TObject);
begin
  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;
  if DM.qrBUSCA.FieldByName('TIPO_WEB').AsString = 'S' then
  begin
    application.MessageBox('Não há letras cadastradas para músicas da web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
    exit;
  end;
  abreLetra(DM.qrBUSCA.FieldByName('ID').AsInteger, txtBusca.Text);
end;

procedure TfmIndex.btOrdFavClick(Sender: TObject);
begin
  if DM.cdsFavoritos.RecordCount <= 0 then
  begin
    application.messagebox(PChar('Não há nenhuma página nos favoritos para alterar a ordem!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  if DM.cdsFavoritos.RecordCount = 1 then
  begin
    application.messagebox(PChar('É necessário pelo menos, duas páginas nos favoritos para alterar a ordem!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  fIniciando.AppCreateForm(TfFavoritos, fFavoritos);
  fFavoritos.ShowModal;

  if PageControl1.Visible = false then exit;

  if (DM.cdsFavoritos.Locate('NOME_ABA', PageControl1.ActivePage.Name, [])) then
  begin
    botoesFavoritos('del');
  end
  else
  begin
    botoesFavoritos('add');
  end;
end;

procedure TfmIndex.btAddFavClick(Sender: TObject);
var
  id,nome,nome_aba: string;
  imagem,ordem: Integer;
begin
  if not DM.cdsFavoritos.Active then
    carregaFavoritos;


  if PageControl1.Visible = false then
  begin
    application.messagebox(PChar('Não há nenhuma página aberta para adicionar aos favoritos!'+#13#10+'Clique neste botão após abrir uma página.'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  nome := PageControl1.ActivePage.Caption;
  nome_aba := PageControl1.ActivePage.Name;
  imagem := PageControl1.ActivePage.ImageIndex;

  if (DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, [])) then
  begin
    application.messagebox(PChar('A página '''+nome+''' já está nos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONEXCLAMATION);
    DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
    DM.cdsFavoritos.Edit;
    DM.cdsFavoritos.FieldByName('NOME').Value := nome;
    DM.cdsFavoritos.FieldByName('IMAGEM').Value := imagem;
    DM.cdsFavoritos.Post;
    exit;
  end;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsFavoritos.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível adicionar. Clique novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsFavoritos.Last;
  if DM.cdsFavoritos.RecordCount <= 0 then
    ordem := 1
  else
    ordem := DM.cdsFavoritos.FieldByName('ORDEM').AsInteger + 1;

  DM.cdsFavoritos.Append;
  DM.cdsFavoritos.FieldByName('ID').Value := id;
  DM.cdsFavoritos.FieldByName('ORDEM').Value := ordem;
  DM.cdsFavoritos.FieldByName('NOME').Value := nome;
  DM.cdsFavoritos.FieldByName('NOME_ABA').Value := nome_aba;
  DM.cdsFavoritos.FieldByName('IMAGEM').Value := imagem;
  DM.cdsFavoritos.Post;

  carregaFavoritos();
  botoesFavoritos('del');
  application.messagebox(PChar('Página '''+nome+''' adicionada com sucesso aos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfmIndex.btDelFavClick(Sender: TObject);
var
  nome,nome_aba: string;
begin
  if PageControl1.Visible = false then
  begin
    application.messagebox(PChar('Não há nenhuma página aberta para remover dos favoritos!'), TITULO, MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;

  nome := PageControl1.ActivePage.Caption;
  nome_aba := PageControl1.ActivePage.Name;

  if not (DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, [])) then
  begin
    application.messagebox(PChar('A página '''+nome+''' não está nos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONEXCLAMATION);
    exit;
  end;

  DM.cdsFavoritos.Locate('NOME_ABA', nome_aba, []);
  DM.cdsFavoritos.Delete;

  carregaFavoritos();
  botoesFavoritos('add');
  application.messagebox(PChar('Página '''+nome+''' removida com sucesso dos favoritos!'), fmIndex.TITULO, MB_OK + MB_ICONINFORMATION);
end;

procedure TfmIndex.btwsCloseClick(Sender: TObject);
begin
//  close;
  Application.Terminate;
  DM.tmrSair.Enabled := true;
end;

procedure TfmIndex.btwsDownloadClick(Sender: TObject);
begin
  verVersao();
end;

procedure TfmIndex.btwsMaximizedClick(Sender: TObject);
begin
  if (fmIndex.WindowState = wsMaximized) then
  begin
    fmIndex.WindowState := wsNormal;
    btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btMaximized']);
    fmIndex.BorderStyle := bsSizeable;
    SetWindowLong(fmIndex.Handle,
                  GWL_STYLE,
                  GetWindowLong(Handle,GWL_STYLE) and not WS_CAPTION);
  end
  else
  begin
    fmIndex.WindowState := wsMaximized;
    btwsMaximized.ImageIndex := StrToInt('0'+layoutValue.Strings.Values['btRestore']);
    fmIndex.BorderStyle := bsNone;
  end;

end;

procedure TfmIndex.btwsMinimizeClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TfmIndex.btwsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  btwsformBotoes.HotImages := DM.ico_janela_clk;
end;

procedure TfmIndex.btwsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  btwsformBotoes.HotImages := DM.ico_janela_hot;
end;

procedure TfmIndex.btColetaneasOnlinePersoClick(Sender: TObject);
begin
  abrePagina(tsColetaneasOnlinePerso);
end;

procedure TfmIndex.btUrlVideoOn2Click(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn2);
end;

procedure TfmIndex.bsSkinSpeedButton66Click(Sender: TObject);
begin
  btAbreSaveVideoOn(txtUrlVideoOn2);
end;

procedure TfmIndex.btMusicaAudioMusicaClick(Sender: TObject);
begin
  if DM.qrBUSCA.RecordCount <= 0 then
  begin
    application.MessageBox('Música não encontrada!', TITULO, mb_ok + mb_iconerror);
    Exit;
  end;

  if DM.qrBUSCA.FieldByName('TIPO_WEB').AsString = 'S' then
  begin
    application.MessageBox('Não é possível abrir arquivo da músicas de músicas na web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
    exit;
  end;

  if TComponent(Sender).Tag = 1
    then abreArquivoMusica(DM.qrBUSCA.fieldbyname('ID').AsInteger,DM.qrBUSCA.fieldbyname('ALBUM').AsString,DM.qrBUSCA.fieldbyname('URL').AsString)
    else abreArquivoMusica(DM.qrBUSCA.fieldbyname('ID').AsInteger,DM.qrBUSCA.fieldbyname('ALBUM').AsString,DM.qrBUSCA.fieldbyname('URL_INSTRUMENTAL').AsString);
end;

procedure TfmIndex.btAddVideoOn3Click(Sender: TObject);
var
  videoID: string;
  nomeVIDEO: string;
  id: string;
  url: string;
begin
  nomeVIDEO := trim(txtNomeVideoOn3.Text);
  videoID := trim(txtUrlVideoOn3.Text);

  if (videoID = '') then
  begin
    application.MessageBox(PChar('Digite a URL ou ID do vídeo do Youtube!'), titulo, mb_ok + MB_ICONEXCLAMATION);
    txtUrlVideoOn3.SetFocus;
    exit;
  end;

  videoID := getVideoID(videoID);

  url := 'https://www.youtube.com/watch?v=' + videoID;

  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsVideosOnPerso.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível adicionar vídeo. Tente novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsVideosOnPerso.Append;
  DM.cdsVideosOnPerso.FieldByName('ID').Value := id;
  DM.cdsVideosOnPerso.FieldByName('NOME').Value := nomeVIDEO;
  DM.cdsVideosOnPerso.FieldByName('URL').Value := url;
  DM.cdsVideosOnPerso.FieldByName('VIDEOID').Value := videoID;
  DM.cdsVideosOnPerso.Post;

  txtNomeVideoOn3.Text := '';
  txtUrlVideoOn3.Text := '';
  stVideosOnPerso_1.Caption := qtItens(TFDQuery(DM.cdsVideosOnPerso),'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');

  btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
end;

procedure TfmIndex.bsSkinSpeedButton68Click(Sender: TObject);
begin
  btExecVideoOn(txtUrlVideoOn3, false);
end;

procedure TfmIndex.bsSkinSpeedButton6Click(Sender: TObject);
begin
  abreLetraMusicaAlbum(712,DM.qrHINOS.FieldByName('ID').AsInteger);
end;

procedure TfmIndex.bsSkinSpeedButton6NClick(Sender: TObject);
begin
  abreLetraMusicaAlbum(629,DM.qrHINOSN.FieldByName('ID').AsInteger);
end;

procedure TfmIndex.bsSkinSpeedButton7Click(Sender: TObject);
var
  arq: string;
begin
    arq := openDialog('pasta');
    if arq <> '' then
    begin
      arq := ExcludeTrailingPathDelimiter(arq);
      txtAbrirColet.Text := arq;
      txtAbrirColetExit(txtAbrirColet);
      btAddColetPersoClick(btAddColetPerso);
    end;
end;

procedure TfmIndex.btPersoClipBoardClick(Sender: TObject);
var
  i: Integer;
begin
  if pnlAddColPerso.Visible then exit;
  if pnlAltColPerso.Visible then exit;
  if txtBuscaColetPeso.Focused then Exit;

  if (application.MessageBox('Colar itens da área de transferência?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;

  for i := 0 to cboard.Items.Count-1 do
  begin
    if (FileExists(cboard.Items[i])) or (DirectoryExists(cboard.Items[i])) then
    begin
      txtCapaColet.Text := '';
      txtColetanea.Text := '';
      txtAbrirColet.Text := cboard.Items[i];
      txtAbrirColetExit(Sender);

      if (DM.cdsCOLETANEAS_PERSO.Locate('NOME', txtColetanea.text, [])) then
        Continue;
      btAddColetPersoClick(Sender);
    end;
  end;
end;

procedure TfmIndex.btAddCategoriaAgendadosClick(Sender: TObject);
var
  id: string;
begin
  id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
  if (DM.cdsCategoriasItensAgendados.Locate('ID', id, [])) then
  begin
    application.messagebox('Não foi possível criar categoria. Tente novamente!', TITULO, MB_OK + mb_iconerror);
    exit;
  end;

  DM.cdsCategoriasItensAgendados.Append;
  DM.cdsCategoriasItensAgendados.FieldByName('ID').Value := id;
  DM.cdsCategoriasItensAgendados.FieldByName('NOME').Value := 'Categoria '+inttostr(DM.cdsCategoriasItensAgendados.RecordCount+1);
  DM.cdsCategoriasItensAgendados.Post;
  categoriasItensAgendadosClick(Sender);

  fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
  fItensAgendados.id := id;
  fItensAgendados.tipo := 'CATEGORIA';
  fItensAgendados.ShowModal;
end;

procedure TfmIndex.btAddItemLiturgiaClick(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfLiturgia, fLiturgia);
  fLiturgia.Caption := 'Adicionar Item';
  fLiturgia.id := '';
  fLiturgia.ShowModal;
end;

procedure TfmIndex.bsSkinSpeedButton8Click(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente remover os itens anteriores a data de hoje?', titulo, mb_yesno + mb_iconquestion) <> 6)
    then Exit;

  removeItensAgendadosPassados;
end;

procedure TfmIndex.btHinoSlideMusicaClick(Sender: TObject);
var
  txt: string;
begin
  if DM.qrHINOS.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    txtHino.SetFocus;
    Exit;
  end;
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  fmIndex.abreLetraMusica('BD',txt,DM.qrHINOS.FieldByName('ID').AsInteger,(TComponent(Sender).Tag < 3));
end;

procedure TfmIndex.btHinoSlideMusicaNClick(Sender: TObject);
var
  txt: string;
begin
  if DM.qrHINOSN.RecordCount <= 0 then
  begin
    application.MessageBox('Hino não encontrado!', TITULO, mb_ok + mb_iconerror);
    txtHinoN.SetFocus;
    Exit;
  end;
  if (TComponent(Sender).Tag = 2)
    then txt := 'PB'
    else txt := '';

  fmIndex.abreLetraMusica('BD',txt,DM.qrHINOSN.FieldByName('ID').AsInteger,(TComponent(Sender).Tag < 3));
end;

procedure TfmIndex.btAbreColJAClick(Sender: TObject);
begin
  abrePagina(tsJA);
end;

procedure TfmIndex.bsSkinSpeedButton9Click(Sender: TObject);
begin
  abrePagina(tsBiblia);
end;

procedure TfmIndex.seTamanhoTextoAuxChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto Aux', TbsSkinComboBox(Sender).Text);
end;

procedure TfmIndex.seTamanhoTextoChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto', TbsSkinComboBox(Sender).Text);
end;

procedure TfmIndex.seTamanhoTextoRetornoChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Texto Retorno', TbsSkinComboBox(Sender).Text);
end;

procedure TfmIndex.seTamanhoTituloChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Tamanho Titulo', TbsSkinComboBox(Sender).Text);
end;

procedure TfmIndex.bsSkinTabSheet5Show(Sender: TObject);
begin
  AjustaLarguraCamposDBGrid(bsSkinDBGrid1);
end;

procedure TfmIndex.bsSkinTabSheet6Show(Sender: TObject);
begin
  loadCol.Strings.Values['COLETANEAS_PERSO_ONL'] := '';
  abrePagina(tsColetaneasOnlinePerso);
  AjustaLarguraCamposDBGrid(bsSkinDBGrid3);
end;

procedure TfmIndex.bsSkinTabSheet7Show(Sender: TObject);
begin
  carregaFavoritos();
  AjustaLarguraCamposDBGrid(bsSkinDBGrid4);
end;

procedure TfmIndex.btAnotTempoClick(Sender: TObject);
var
  i: integer;
  Item: TbsSkinOfficeItem;
  tempo: string;
begin
  if (loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] = '') then
    loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := '1';

  i := StrToInt(loadCol.Strings.Values['CRONO:ID_TEMPO_GR']);
  loadCol.Strings.Values['CRONO:ID_TEMPO_GR'] := IntToStr(i + 1);

  tempo := lmdCrono.Caption;

  Item := lbCrono.Items.Add;
  Item.Caption := formatfloat('00', i) + ' - ' + tempo;
  lbCrono.ItemIndex := Item.Index;
  if (fMonitorCronometro <> nil) then
  begin
    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
    fMonitorCronometro.lbCrono.ItemIndex := lbCrono.ItemIndex;
  end;
end;

procedure TfmIndex.btSortearClick(Sender: TObject);
begin
  if (Sender <> nil) and (not TbsSkinSpeedButton(Sender).Enabled) then Exit;

  if DM.tmrSorteio.Enabled = false then
    DM.tmrSorteio.Enabled := true;

  if (Trim(opSort_Ini.Text) <> '') or (Trim(opSort_Fin.Text) <> '') then
    btAddSorteioClick(Sender);

  if vlSorteio.Strings.Count <= 0 then
  begin
    lmdSorteio.Caption := '0000';
    if fMonitorSorteio <> nil then
      fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
    application.messagebox('Não há números disponíveis para serem sorteados!', TITULO, mb_ok + mb_iconexclamation);
    opSort_Ini.SetFocus;
    exit;
  end;

  vSorteioAnimFim := IncMilliSecond(Now,trunc(seSorteioTempo.Value*1000));
  gSorteio.MaxValue := trunc(vSorteioAnimFim * 10000000000);
  gSorteio.MinValue := trunc(now * 10000000000);

  pnlSorteio.DoubleBuffered := True;
  DM.tmrSortear.Enabled := true;
end;

procedure TfmIndex.desenvolvedor(ativo: boolean);
begin
  if (ativo = true) then
  begin
    if (DM.PasswordDialog.Password <> senha_bd) then
    begin
      DM.PasswordDialog.Execute;
      if (DM.PasswordDialog.Password <> senha_bd) then
      begin
        if (DM.PasswordDialog.Password <> '') then
          Application.MessageBox('Senha incorreta!',TITULO,mb_ok+mb_iconerror);
        Exit;
      end;
    end;
  end;

  bsAppMenu1.Items[0].Visible := ativo;
  pnlModDes.Visible := ativo;
  txtIDMusica.Visible := ativo;
  gpLiturgiaDes.Visible := ativo;

  if (fEditorSlides <> nil) then
  begin
    fEditorSlides.param.Visible := ativo;
    fEditorSlides.dbGrid.Visible := ativo;
    fEditorSlides.lbTempos.Visible := ativo;
  end;
  if (fMusica <> nil) then
  begin
    fMusica.pnlAdm.Visible := ativo;
    fMusica.pnGrid.Visible := ativo;
  end;
end;

function TfmIndex.diretorio(dir:string): string;
begin
  dir := StringReplace(dir,'\\','\',[rfIgnoreCase, rfReplaceAll]);
  result := dir;
end;

function TfmIndex.DownloadArquivo(const Origem, Destino: string): Boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: file;
  sAppName: string;
begin
  sAppName := ExtractFileName(Application.ExeName);
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    hURL := InternetOpenURL(hSession, PChar(Origem), nil, 0, 0, 0);
    try
      AssignFile(f, Destino);
      Rewrite(f, 1);
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(f, Buffer, BufferLen)
      until BufferLen = 0;
      CloseFile(f);
      Result := True;
    finally
      InternetCloseHandle(hURL)
    end
  finally
    InternetCloseHandle(hSession)
  end
end;

procedure TfmIndex.edtKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = 84) and (Shift = [ssCtrl]) or
      (Key = 65) and (Shift = [ssCtrl])) then
  begin
    TbsSkinEdit(Sender).SelectAll;
  end;
end;

procedure TfmIndex.escSBTempo;
var
  agora: TDateTime;
  crono: TTime;
  MyHora, MyMinuto, MySegundo, MyMiliSegundo: Word;
  Segundos: integer;
begin
  agora := now();
  crono := tEscSBCrono - agora;

  if (tEscSBCrono < agora) and (not cbEscSBZerarTempo.Checked)
    then lmdEscSbR.Caption := '-'+formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], crono)
    else lmdEscSbR.Caption := formatdatetime(cbFormatoTempoES.Items[cbFormatoTempoES.ItemIndex], crono);

  if (tEscSBCrono < agora) and (lmdEscSbR.Font.Color <> csEscsbCor3.ColorValue)
    then lmdEscSbR.Font.Color := csEscsbCor3.ColorValue
  else if (tEscSBCrono >= agora) and (lmdEscSbR.Font.Color <> csEscsbCor2.ColorValue)
    then lmdEscSbR.Font.Color := csEscsbCor2.ColorValue;

  DecodeTime(crono, MyHora, MyMinuto, MySegundo, MyMiliSegundo);
  Segundos := MyMiliSegundo + (MySegundo * 1000) + (MyMinuto * 60000) + (MyHora * 3600000);
  if (Segundos > gEscSbR.MaxValue) then
    gEscSbR.MaxValue := Segundos;
  gEscSbR.Value := Segundos;

  if (rbgAudioES.Visible) and (tEscSBCrono > agora) and (formatdatetime('hh:mm:ss', crono) = '00:05:10') and (cgEscSBAudio.ItemChecked[1]) then
  begin
    try
      mpMusica.Stop;
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    cbMusica.ItemIndex := 1;
    selMusica();
    btOuvirClick(btOuvir);
  end;
  if (rbgAudioES.Visible) and (tEscSBCrono > agora) and (formatdatetime('hh:mm:ss', crono) = '00:01:10') and (cgEscSBAudio.ItemChecked[2]) then
  begin
    try
      mpMusica.Stop;
    except
      //
    end;
    btOuvir.Caption := 'Ouvir';
    btOuvir.Down := False;
    btOuvir.ImageIndex := 7;

    cbMusica.ItemIndex := 2;
    selMusica();
    btOuvirClick(btOuvir);
  end;
  if (tEscSBCrono <= now()) and (cbEscSBZerarTempo.Checked) then
  begin
    btLigar.Caption := 'Ligar';
    btLigar.Down := False;
    btLigar.ImageIndex := 20;
    gEscSbR.MaxValue := 1;
    gEscSbR.Value := 1;
    lmdEscSbR.Font.Color := csEscsbCor2.ColorValue;

    bsAddT1.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddT5.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddT10.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm1.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm5.Enabled := not(btLigar.Caption = 'Ligar');
    bsAddTm10.Enabled := not(btLigar.Caption = 'Ligar');
  end;

  if (fMonitorCronometroCulto <> nil) then
  begin
    fMonitorCronometroCulto.gEscSbR.MaxValue := gEscSbR.MaxValue;
    fMonitorCronometroCulto.gEscSbR.Value := gEscSbR.Value;
    fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
    fMonitorCronometroCulto.lmdEscSbR.Font.Color := lmdEscSbR.Font.Color;
  end;
end;

procedure TfmIndex.dblBibVersao2Click(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO'] := DM.qrBIBLIA_VERSAO_2.FieldByName('SIGLA').AsString;
  gravaParam('Busca Biblica', 'Versão', loadCol.Strings.Values['BIBLIA_BUSCA_VERSAO']);
end;

procedure TfmIndex.dblBibVersaoClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_VERSAO'] := dblBibVersao.KeyValue;
  if (loadCol.Strings.Values['BIBLIA_P_LIVRO'] <> loadCol.Strings.Values['BIBLIA_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_LIVRO'] := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
    loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  end;
  if (loadCol.Strings.Values['BIBLIA_P_CAPITULO'] <> loadCol.Strings.Values['BIBLIA_P_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  end;
  carregaBiblia('VSC');
  DBCtrlGridBibliaVersiculoClick(DBCtrlGridBibliaVersiculo);
end;

procedure TfmIndex.Localizar(ValorBusca: string; RichEdit: TbsSkinRichEdit; recolore: boolean);
var
  ProcurePor: LongInt;
  PosInicial, PosFinal: integer;
  vPosAntiga: Integer;
begin
  with RichEdit do
  begin
    SelStart := 0;
    SelLength := Length(Text);
    if recolore = true then
      SelAttributes.Color := clBlack;

    vPosAntiga := SelStart;
    SelStart := 0;
    SelLength := 0;
    while True do
    begin
      PosInicial := SelStart + SelLength;
      PosFinal := Length(Text) - PosInicial;
      ProcurePor := FindText(ValorBusca, PosInicial, PosFinal, []);
      if ProcurePor < 0 then
        Break;
      begin
        SelStart := ProcurePor;
        SelLength := Length(ValorBusca);
      end;
      SelAttributes.Color := clRed;
    end;
    SelStart := vPosAntiga;
    SelLength := 0;
    if recolore = true then
      SelAttributes.Color := clBlack;
  end;
end;

function TfmIndex.formataIntervaloNum(S: string): string;
var
  str: TStringList;
  arr: array of integer;
  i,ant: Integer;
  u: string;
begin
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(S), str);
  str.Sorted := True;
  str.Duplicates := dupIgnore;
  setlength(arr,str.Count);
  u := '';
  for i := 0 to str.Count-1 do
  begin
    if (u <> str[i]) then
    begin
      arr[i] := StrToInt(str[i]);
      u := str[i];
    end;
  end;

  aSort(arr);
  S := '';
  ant := 0;
  for i := 0 to Length(arr)-1 do
  begin
    if (arr[i] > 0) then
    begin
      if (ant = 0) then
      begin
        S := S+IntToStr(arr[i]);
      end
      else if (arr[i]-ant = 1) and (Length(arr)-1 > i) and (arr[i+1]-arr[i] = 1) then
      begin
        S := S+'-';
      end
      else
      begin
        S := S+','+IntToStr(arr[i]);
      end;
      S := StringReplace(S, '-,', '-', [rfIgnoreCase, rfReplaceAll]);
      S := StringReplace(S, '--', '-', [rfIgnoreCase, rfReplaceAll]);
      ant := arr[i];
    end;
  end;
  S := StringReplace(S, '-,', '-', [rfIgnoreCase, rfReplaceAll]);
  S := StringReplace(S, '--', '-', [rfIgnoreCase, rfReplaceAll]);
  Result := S;
end;

procedure TfmIndex.formataTexto(RichEdit: TbsSkinRichEdit);
var
  iPosINI, iPosTAM: integer;
  txt_pre, txt, txt_pos: string;
  i: integer;
begin
  RichEdit.SelStart := 0;
  RichEdit.SelLength := Length(RichEdit.text);
  RichEdit.SelAttributes.Style := [];

  paramtemp.lines.Clear;

  while Pos('[', RichEdit.text) > 0 do
  begin
    iPosINI := Pos('[', RichEdit.text);
    iPosTAM := Pos(']', Copy(RichEdit.text, iPosINI, Length(RichEdit.text)));

    txt_pre := Copy(RichEdit.Text, 1, iPosINI - 1);
    txt := Copy(RichEdit.Text, iPosINI + 1, iPosTAM - 2);
    txt_pos := Copy(RichEdit.Text, iPosINI + iPosTAM, Length(RichEdit.Text));

    RichEdit.text := txt_pre + txt + txt_pos;
    if iPosTAM > 0 then
    begin
      paramtemp.Lines.Add(IntToStr(Length(StringReplace(txt_pre, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]))) + ',' + IntToStr(Length(StringReplace(txt, #13#10, ' ', [rfIgnoreCase, rfReplaceAll]))));

    end;
  end;

  for i := 0 to paramtemp.Lines.Count - 1 do
  begin
    iPosINI := StrToInt(Copy(paramtemp.Lines[i], 1, Pos(',', paramtemp.Lines[i]) - 1));
    iPosTAM := StrToInt(Copy(paramtemp.Lines[i], Pos(',', paramtemp.Lines[i]) + 1, Length(paramtemp.Lines[i])));
    RichEdit.SelStart := iPosINI;
    RichEdit.SelLength := iPosTAM;
    RichEdit.SelAttributes.Style := [fsBold];
//    Application.Processmessages;
  end;

  RichEdit.SelStart := 0;
  RichEdit.SelLength := 0;
end;

procedure TfmIndex.FormResize(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to loadCol.RowCount - 1 do
    if loadCol.Cells[1, i] = 'ok' then
      loadCol.Cells[1, i] := '';

  if PageControl1.Visible = true then
  begin
    try
      PageControl1.Pages[PageControl1.ActivePageIndex].OnShow(Sender);
    except
      //
    end;
  end;
end;

function TfmIndex.geraIntervaloNum(S: string): string;
var
  str: TStringList;
  str2: TStringList;
  mi,ma: integer;
  i,j: Integer;
begin
  S := StringReplace(S, ';', ',', [rfIgnoreCase, rfReplaceAll]);
  str := TStringList.Create;
  ExtractStrings([','], [], PChar(S), str);
  S := '';
  for i := 0 to str.Count-1 do
  begin
    str2 := TStringList.Create;
    ExtractStrings(['-'], [], PChar(str[i]), str2);
    mi := 9999;
    ma := 0;
    for j := 0 to str2.Count-1 do
    begin
      if (StrToInt(str2[j]) > ma)
        then ma := StrToInt(str2[j]);

      if (StrToInt(str2[j]) < mi)
        then mi := StrToInt(str2[j]);
    end;

    for j := mi to ma do
    begin
      if S <> '' then
        S := S + ',';
      S := S + IntToStr(j);
    end;
  end;
  result := S;
end;

procedure TfmIndex.tsBibliaShow(Sender: TObject);
begin
  PaginaMenuAtiva(bsConfBiblia,tsBiblia);
  marcaAbaAberta(tsBiblia);
  if (loadCol.Strings.Values['BIBLIA_F'] <> 'okf') then
  begin
    lmdBibliaTxt.Caption := '';
    lmdBibliainfo.Caption := '';

    if (fIniciando.LANG='ES') then
    begin
      loadCol.Strings.Values['BIBLIA_VERSAO'] := lerParam('Biblia', 'Versão', 'RV');
      loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := lerParam('Biblia', 'Livro Sigla', 'Gn.');
      loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := lerParam('Biblia', 'Livro Nome', 'Génesis');
    end
    else
    begin
      loadCol.Strings.Values['BIBLIA_VERSAO'] := lerParam('Biblia', 'Versão', 'ARA');
      loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := lerParam('Biblia', 'Livro Sigla', 'Gn.');
      loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := lerParam('Biblia', 'Livro Nome', 'Gênesis');
    end;
    loadCol.Strings.Values['BIBLIA_F'] := 'okf';
    loadCol.Strings.Values['BIBLIA_LIVRO'] := lerParam('Biblia', 'Livro', '1');
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := lerParam('Biblia', 'Capitulo', '1');
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '0';

    loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
    loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
    loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

    busBibliaLivro.Items.Clear;
    DM.qrBIBLIA_BUS_LIVROS.Close;
    DM.qrBIBLIA_BUS_LIVROS.Open;
    DM.qrBIBLIA_BUS_LIVROS.First;
    while not DM.qrBIBLIA_BUS_LIVROS.Eof do
    begin
      busBibliaLivro.Items.Add(DM.qrBIBLIA_BUS_LIVROS.FieldByName('LIVRO').AsString);
      DM.qrBIBLIA_BUS_LIVROS.Next;
    end;

    carregaBiblia('VER');
    carregaBiblia('LIV');
    carregaBiblia('CAP');
    carregaBiblia('VSC');

    if not DM.cdsBIBLIA_HISTORICO.Active then
    begin
      DM.cdsBIBLIA_HISTORICO.CreateDataSet;
      DM.cdsBIBLIA_HISTORICO.IndexName := 'ORDER_DATAHORA';
      DM.cdsBIBLIA_HISTORICO.LogChanges := False;
    end;

  end;

  if (loadCol.Strings.Values['BIBLIA'] <> 'ok') then
  begin
    loadCol.Strings.Values['BIBLIA'] := 'ok';

    DBCtrlGridBibliaLivro.RowCount := Trunc(DBCtrlGridBibliaLivro.ClientHeight / 75);
    DBCtrlGridBibliaLivro.ColCount := Trunc(DBCtrlGridBibliaLivro.ClientWidth / 75);

    DBCtrlGridBibliaCapitulo.RowCount := Trunc(DBCtrlGridBibliaCapitulo.ClientHeight / 40);
    DBCtrlGridBibliaCapitulo.ColCount := Trunc(DBCtrlGridBibliaCapitulo.ClientWidth / 40);

    DBCtrlGridBibliaVersiculo.RowCount := Trunc(DBCtrlGridBibliaVersiculo.ClientHeight / 80);
    DBCtrlGridBibliaVersiculo.ColCount := 1;

    DBCtrlGridBibliaHistorico.RowCount := Trunc(DBCtrlGridBibliaHistorico.ClientHeight / 90);
    DBCtrlGridBibliaHistorico.ColCount := 1;

    loadCol.Strings.Values['BIBLIA'] := 'ok';
    loadCol.Strings.Values['BIBLIA_IMG'] := '|';
    loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';

    carregaConfiguracoes('BIBLIA');
  end;

end;

procedure TfmIndex.miOpcExportar1Click(Sender: TObject);
begin
  botao_trmenu.OnClick(Sender);
end;

function TfmIndex.ExtraiTexto(const Str, Str1, Str2: string): string;
var
  Inicio, Fim: string;
begin
  Inicio := Copy(Str, Pos(Str1, Str) + Length(Str1), Length(Str));

  // Pega o Texto Restante, iniciando ao final da variavel Str1;
  Fim := Copy(Inicio, 0, Pos(Str2, Inicio) - 1);

  // Copia o Texto da posição inicial '0' até o Final, que é determinado pela posição inicial da variavel str2 menos '1' para corrigir;
  Result := Fim;
end;

procedure TfmIndex.carregaParams;
var
  LinkPag: string;
  txt: string;
  Flags: Cardinal;
  vers: string;
  ip: TIdIPWatch;
  lParams: TStringList;
  versao_atu: TStringList;
begin
  if (paramexec.Strings.Values['internet'] <> '0') then
  begin
    if not InternetGetConnectedState(@Flags, 0) then
    begin
      if FileExists(dir_dados + 'configweb.ja') then
        Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');
      Param.Strings.Values['internet_conexao'] := '0';
      Param.Strings.Values['download_params'] := '0';
    end
    else
    begin
      Buffer := 0;

      if (lerParam('Config', 'UltimaConexao', '') <> formatdatetime('yyyy-mm-dd', Now())) then
      begin
        gravaParam('Config', 'UltimaConexao', formatdatetime('yyyy-mm-dd', Now()));

        DM.progressDialog.MaxValue := StrToInt(lerParam('Config', 'Param Buffer', '100000'));
        DM.IdHTTP1.Request.CustomHeaders.Values['Api-Token'] := '02@v2nFB2Dc';

        try
          LinkPag := DM.IdHTTP1.Get(url_params);
          //txt := ExtraiTexto(LinkPag, '<params>', '</params>');
          txt := LinkPag;
          txt := IfThen(trim(txt) = '', '=', txt);
          Param.Strings.Text := txt;
          Param.Strings.SaveToFile(dir_dados + 'configweb.ja');
          Param.Strings.Values['internet_conexao'] := '1';
          Param.Strings.Values['download_params'] := '1';
          Param.Strings.Values['tentativas'] := '1';
        except
          Sleep(2000);
          try
            LinkPag := DM.IdHTTP1.Get(url_params);
            //txt := ExtraiTexto(LinkPag, '<params>', '</params>');
            txt := LinkPag;
            txt := IfThen(trim(txt) = '', '=', txt);
            Param.Strings.Text := txt;
            Param.Strings.SaveToFile(dir_dados + 'configweb.ja');
            Param.Strings.Values['internet_conexao'] := '1';
            Param.Strings.Values['download_params'] := '1';
            Param.Strings.Values['tentativas'] := '2';
          except
            on E: Exception do
            begin
              txt := DM.IdDecoderMIME.DecodeString(lerParam('Config', 'Params', '='));
              txt := IfThen(trim(txt) = '', '=', txt);
              Param.Strings.Text := txt;
              Param.Strings.Values['internet_conexao'] := '1';
              Param.Strings.Values['download_params'] := '0';
              erro_log.Lines.Add(E.Message);
              erro_log.Lines.Add(url_params);
              gravaParam('Config', 'UltimaConexao', 'ERR');
            end;
          end;
        end;

        if Buffer > 0 then
          gravaParam('Config', 'Param Buffer', IntToStr(Buffer));
        Buffer := 0;

        if (Trim(Param.Strings.Values['formulario']) <> '') then
        begin
          DM.qrVERSAO.Close;
          DM.qrVERSAO.Open;

          versao_atu := TStringList.Create;
          versao_atu.Delimiter := '.';
          versao_atu.DelimitedText := VersaoExe + '.' + DM.qrVERSAO.fieldbyname('VERSAO_BD').AsString;

          vers := versao_atu[0]+'.'+versao_atu[1]+'.'+versao_atu[4]+'.'+versao_atu[5];
          if (vers <> lerParam('Config', 'EnviaAcesso', '')) then
          begin
            DM.progressDialog.Value := 0;
            DM.progressDialog.MaxValue := StrToInt(lerParam('Config', 'Form Buffer', '200'));

            try
              ip := TIdIPWatch.Create(nil);
              lParams := TStringList.Create;
              lParams.Add('tipo=acesso');
              lParams.Add('versao=' + vers);
              lParams.Add('versao_exe=' + VersaoExe);
              lParams.Add('datahora=' + formatdatetime('yyyy-mm-dd hh:nn:ss', Now()));
              lParams.Add('ip=' + ip.LocalIP);
              lParams.Add('dir=' + Application.ExeName);
              lParams.Add('parametros=' + GetCommandLine);
              paramtemp.Lines.Clear;
              paramtemp.Text := GetComputerNameFunc;
              lParams.Add('nome=' + trim(paramtemp.Lines[0]));
              paramtemp.Text := DM.idHttp1.Post(Param.Strings.Values['formulario'], lParams);
            except
            end;
            gravaParam('Config', 'EnviaAcesso', vers);

            if Buffer > 0 then
              gravaParam('Config', 'Form Buffer', IntToStr(Buffer));
            Buffer := 0;
          end;
        end;
      end
      else
      begin
        if FileExists(dir_dados + 'configweb.ja') then
          Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');

        Param.Strings.Values['internet_conexao'] := '0';
        Param.Strings.Values['download_params'] := '0';
      end;
    end;
  end
  else
  begin
    if FileExists(dir_dados + 'configweb.ja') then
      Param.Strings.LoadFromFile(dir_dados + 'configweb.ja');

    Param.Strings.Values['internet_conexao'] := '-1';
    Param.Strings.Values['download_params'] := '0';
  end;
end;

procedure TfmIndex.carrega_monitores;
var
  i: Integer;
  MonitorsArray: TArray<TMonitorInfo>;
begin
  MonitorsArray := lista_monitores();
  ctrlMonitores.ColCount := ceil(fmIndex.Width / 300);

  if not DM.cdsMonitores.Active then
  begin
    DM.cdsMonitores.CreateDataSet;
    DM.cdsMonitores.LogChanges := False;
  end;
  DM.cdsMonitores.Open;
  DM.cdsMonitores.EmptyDataSet;

  for i := 0 to length(MonitorsArray)-1 do
  begin
    DM.cdsMonitores.Append;
    DM.cdsMonitores.FieldByName('ID').Value := i;
    DM.cdsMonitores.FieldByName('NUM').Value := i+1;
    DM.cdsMonitores.FieldByName('WIDTH').Value := MonitorsArray[i].Width;
    DM.cdsMonitores.FieldByName('HEIGHT').Value := MonitorsArray[i].Height;
    DM.cdsMonitores.FieldByName('TOP').Value := MonitorsArray[i].Top;
    DM.cdsMonitores.FieldByName('LEFT').Value := MonitorsArray[i].Left;
    DM.cdsMonitores.FieldByName('X').Value := 'x';
    DM.cdsMonitores.Post;
  end;
end;

procedure TfmIndex.Excluir1Click(Sender: TObject);
var
  id, mComponente: string;
begin
  mComponente := TbsSkinPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent.Name;
  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  if (application.messagebox(PChar('Deseja realmente remover a coletânea ''' + DM.cdsCOLETANEAS_PERSO.FieldByName('NOME').AsString + ''' do Menu?' + #13#10 + #13#10 + 'Nota: Isto não irá excluir os arquivos desta coletânea, somente o link que aponta para ela.'), fmIndex.TITULO, MB_YESNO + mb_iconquestion)) <> 6 then
    exit;

  DM.cdsCOLETANEAS_PERSO.Locate('ID', id, []);
  DM.cdsCOLETANEAS_PERSO.Delete;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  importColetaneasPerso();
end;

procedure TfmIndex.Excluir3Click(Sender: TObject);
var
  id: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  if application.messagebox(PChar('Deseja realmente excluir este link?'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  id := DM.cdsVideosOnPerso.FieldByName('ID').AsString;

  DM.cdsVideosOnPerso.Locate('ID', id, []);
  DM.cdsVideosOnPerso.Delete;
  stVideosOnPerso_1.Caption := qtItens(TFDQuery(DM.cdsVideosOnPerso),'vídeo encontrado','vídeos encontrados','Nenhum vídeo encontrado');

  btVidOnlPExcluir.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPCopiarLink.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPAbrirNaveg.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
  btVidOnlPExec.Enabled := ((DM.cdsVideosOnPerso.Active = true) and (DM.cdsVideosOnPerso.RecordCount > 0));
end;

procedure TfmIndex.ExcluirTodas1Click(Sender: TObject);
begin
  if application.messagebox(PChar('Deseja realmente excluir todas coletâneas personalizadas?' + #13#10 + #13#10 + 'Nota: Isto não irá excluir os arquivos destas coletâneas, somente os links que apontam para elas.'), TITULO, mb_yesno + mb_iconquestion) <> 6 then
    Exit;

  if FileExists(dir_dados + 'coletaneasUsuario.xml') then
    DeleteFile(dir_dados + 'coletaneasUsuario.xml');

  DM.cdsCOLETANEAS_PERSO.EmptyDataSet;

  loadCol.Strings.Values['PERSO'] := '';
  tsPersonalizadasShow(Sender);

  importColetaneasPerso();
end;

function TfmIndex.GetComputerNameFunc: string;
var
  ipbuffer: string;
  nsize: dword;
begin
  nsize := 255;
  SetLength(ipbuffer, nsize);
  if GetComputerName(pchar(ipbuffer), nsize) then
    Result := ipbuffer;
end;

function TfmIndex.GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;
begin
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    Result := '';
end;

function TfmIndex.GetIP: string;
begin
  TIdStack.IncUsage;
  try
    Result := GStack.LocalAddress;
  finally
    TIdStack.DecUsage;
  end;
end;

function TfmIndex.GetStrNumber(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

function TfmIndex.GetStrNumber2(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9',',',';','-']) then
    {$ELSE}
    if vText^ in ['0'..'9',',',';','-'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

procedure TfmIndex.BitmapFileToPNG(const Source, Dest: string);
var
  Bitmap: TBitmap;
  PNG: TPNGImage;
begin
  Bitmap := TBitmap.Create;
  PNG := TPNGImage.Create;
  {In case something goes wrong, free booth Bitmap and PNG}
  try
    Bitmap.LoadFromFile(Source);
    PNG.Assign(Bitmap);    //Convert data into png
    PNG.SaveToFile(Dest);
  finally
    Bitmap.Free;
    PNG.Free;
  end
end;

procedure TfmIndex.LiturgiaCalendarClick(Sender: TObject);
var
  dia_semana: integer;
  i: integer;
begin
  if Sender <> nil then
    RichEdit1Exit(Sender);

  if Sender = nil then
    dia_semana := dayofweek(now())
  else
    dia_semana := TComponent(Sender).Tag;
  loadCol.Strings.Values['LITURGIA:SEMANA'] := inttostr(dia_semana);
  for i := 1 to 7 do
    TbsSkinSpeedButton(FindComponent('lcal_' + inttostr(i)) as TbsSkinSpeedButton).Down := (TbsSkinSpeedButton(FindComponent('lcal_' + inttostr(i)) as TbsSkinSpeedButton).Tag = dia_semana);

  RichEdit1.Lines.Clear;
  if FileExists(dir_dados+'AnotacoesLiturgia_'+IntToStr(dia_semana)+'.rtf') then
    RichEdit1.Lines.LoadFromFile(dir_dados+'AnotacoesLiturgia_'+IntToStr(dia_semana)+'.rtf');
  RichEdit1.DefaultFont.Name := 'Tahoma';
  fcTxtI1.FontName := RichEdit1.DefaultFont.Name;
  seTxtITamanho1.Text := IntToStr(RichEdit1.DefaultFont.Size);
  RichEditEnter(RichEdit1);

  carregaLiturgia(dia_semana);
end;

procedure TfmIndex.spServerClick(Sender: TObject);
begin
  if (trim(spServer.Caption) <> '') then
    ShellExecute(handle, nil, PChar(spServer.Caption), nil, nil, SW_MAXIMIZE);
end;

procedure TfmIndex.sTabSheet12Show(Sender: TObject);
begin
  loadCol.Strings.Values['PERSO'] := '';
  abrePagina(tsPersonalizadas);
  AjustaLarguraCamposDBGrid(DBGrid3);
end;

procedure TfmIndex.sTabSheet13Show(Sender: TObject);
begin
  mmConfigJA.Lines.LoadFromFile(dir_dados + 'config.ja');
end;

procedure TfmIndex.sTabSheet14Show(Sender: TObject);
begin
  mmLiturgia.Lines.LoadFromFile(dir_dados + 'liturgia.ja');
end;

procedure TfmIndex.sTabSheet15Show(Sender: TObject);
var
  i: integer;
  item: TListItem;
begin
  lvMonitores.Items.Clear;
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    item := lvMonitores.Items.Add;
    item.Caption := 'Monitor ' + inttostr(i + 1);

    item := lvMonitores.Items.Add;
    item.Caption := 'Índice';
    item.SubItems.Add(inttostr(i));

    item := lvMonitores.Items.Add;
    item.Caption := 'Dimensões';
    item.SubItems.Add(inttostr(monitorInfo(i).Width) + ' x ' + inttostr(monitorInfo(i).Height));

    item := lvMonitores.Items.Add;
    item.Caption := 'Posição';
    item.SubItems.Add(inttostr(monitorInfo(i).Top) + ' (Vertical) x ' + inttostr(monitorInfo(i).Left) + ' (Horizontal)');

    item := lvMonitores.Items.Add;
    item.Caption := '';
  end;
end;

procedure TfmIndex.sTabSheet16Show(Sender: TObject);
begin
  mmParam.Text := GetCommandLine;
end;

procedure TfmIndex.sTabSheet18Show(Sender: TObject);
begin
  DM.ADO.GetTableNames('','','',slbTabelas.Items);
end;

function TfmIndex.verificaURL(url: string; input: TbsSkinEdit; reverso: Boolean = False): string;
var
  dirCol: string;
  dirArqPart: string;
begin
  dirCol := ExtractFilePath(Application.ExeName);
  if reverso = true then
  begin
    if input.Text = 'I' then
      url := dirCol + url;
  end
  else
  begin
    dirArqPart := AnsiMidStr(PChar(url), 1, StrLen(PChar(dirCol)));

    if (dirCol = dirArqPart) then
    begin
      url := AnsiMidStr(PChar(url), StrLen(PChar(dirCol)) + 1, StrLen(PChar(url)));
      if trim(url) = '' then
      begin
        url := dirCol;
        input.Text := 'E';
      end
      else
        input.Text := 'I';
    end
    else if (FileExists(dirCol + '\' + dirArqPart)) then
      input.Text := 'I'
    else
      input.Text := 'E';
  end;

  if (Copy(url,1,1) = '\') then
    url := copy(url,2,Length(url));

  Result := url;
end;

procedure TfmIndex.sListView1DblClick(Sender: TObject);
var
  item: Integer;
  URL: string;
begin
  item := TbsSkinListView(Sender).ItemIndex;
  if (item < 0) then
    Exit;

  URL := TbsSkinListView(Sender).Items[item].SubItems[1];
  if (trim(URL) = '') then
    Exit;

  abrirArquivo(URL);
end;

procedure TfmIndex.lbSorteioItemCheckClick(Sender: TObject);
var
  item: string;
  linha: integer;
begin
  item := lbSorteio.Items[lbSorteio.ItemIndex].Caption;
  if lbSorteio.Items[lbSorteio.ItemIndex].Checked = true then
  begin
    vlSorteados.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
    vlSorteio.FindRow(item, linha);
    if linha >= 0 then
      vlSorteio.DeleteRow(linha);
  end
  else
  begin
    vlSorteio.Strings.Values[item] := IntToStr(lbSorteio.ItemIndex);
    vlSorteados.FindRow(item, linha);
    if linha >= 0 then
      vlSorteados.DeleteRow(linha);
  end;

  if fMonitorSorteio <> nil then
  begin
    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
  end;

  SorteioContador;
end;

procedure TfmIndex.processaArquivo(arq: string);
var
  ext: string;
  audio: Boolean;
  ZipFile: TZipFile;
  dir_t: string;
begin
  ext := (ExtractFileExt(arq));
  if (ext = '.slja') then
  begin
    ZipFile := TZipFile.Create;
    try
      dir_t := dir_temp+'~read_'+FormatDateTime('yyyymmddHHMMSSZZZ', now());
      ZipFile.Open(arq, zmRead);
      ZipFile.ExtractAll(dir_t);
      ZipFile.Close;
      arq := dir_t+'\slides.lja';
    finally
      ZipFile.Free;
    end;
    audio := (lerParam('Geral', 'audio', '1', ExtractFileName(arq), ExtractFilePath(arq)) = '1');
    abreLetraMusica('EXT',arq,-1,audio);
  end
  else
  if (ext = '.lja') then
  begin
    audio := (lerParam('Geral', 'audio', '1', ExtractFileName(arq), ExtractFilePath(arq)) = '1');
    abreLetraMusica('EXT',arq,-1,audio);
  end
  else
  begin
    Application.MessageBox(PChar('Arquivo "'+arq+'" inválido!'),TITULO,mb_ok+mb_iconerror);
    DM.tmrSair.Enabled := True;
  end;
//  showmessage(ext);
end;

procedure TfmIndex.RichEdit1Exit(Sender: TObject);
begin
  RichEdit1.Lines.SaveToFile(dir_dados+'AnotacoesLiturgia_'+loadCol.Strings.Values['LITURGIA:SEMANA']+'.rtf');
end;

procedure TfmIndex.mmBDKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F9) or (Key = VK_F5)
    then btExecSQLClick(Sender);
  edtKeyUp(Sender,Key,Shift);
end;

procedure TfmIndex.mmPainelDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    btExibeTxtPainelDClick(Sender);
    mmPainelD.SelectAll;
    Key := #0;
  end
  else if (Key = #10) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    Key := #13;
  end;
end;

procedure TfmIndex.mmPopMonitorClick(Sender: TObject);
var
  tag: integer;
  item_config: string;
begin
  tag := TMenuItem(Sender).Tag;

//  if (botao_trmenu.ImageList.Name = 'ico_40x40')
//    then botao_trmenu.ImageIndex := 10
//    else botao_trmenu.ImageIndex := 53;
  botao_trmenu.Tag := tag;

  item_config := monitor_tp_config(botao_trmenu);
  gravaParam(item_config, 'Monitor', IntToStr(tag+1));

  monitor_bt_label(botao_trmenu);

//  botao_trmenu.OnClick(botao_trmenu);
end;

procedure TfmIndex.mnAbreFavoritoClick(Sender: TObject);
begin
  ogFavoritos.ItemIndex := TMenuItem(Sender).Tag;
end;

procedure TfmIndex.mnFechaAbaClick(Sender: TObject);
var
  t: integer;
begin
  t := PageControl1.Pages[PageControl1.ActivePageIndex].Tag;
  PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible := False;
  bsPopupMenuRibon.Items.Delete(t);
  confereAbasAbertas();
end;

procedure TfmIndex.mnFechaTodasAbasClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if (PageControl1.Pages[i].TabVisible = true) then
    begin
      PageControl1.Pages[i].TabVisible := False;
      bsPopupMenuRibon.Items.Delete(0);
    end;
  end;
  confereAbasAbertas();
  PaginaMenuAtiva(bsColetaneas);
end;

procedure TfmIndex.mnSelecionaAbaClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if (PageControl1.Pages[i].TabVisible = True) and (PageControl1.Pages[i].Tag = TMenuItem(Sender).Tag) then
    begin
      PageControl1.ActivePageIndex := i;
      Break;
    end;
  end;
end;

procedure TfmIndex.Modificar1Click(Sender: TObject);
var
  id, mComponente: string;
begin
  mComponente := TbsSkinPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent.Name;
  id := Copy(mComponente, Pos('_', mComponente) + 1, Length(mComponente));

  pnlAltColPerso.Visible := False;
  btAltColPersoClick(Sender);
  cbColetaneasPerso.KeyValue := id;
  cbColetaneasPersoChange(Sender);
  cbColetaneasPerso.Enabled := False;
  txtAbrirColet2Enter(Sender);
end;

procedure TfmIndex.slbTabelasListBoxClick(Sender: TObject);
begin
  mmBD.Lines.Clear;
  mmBD.Lines.Add('SELECT * FROM '+slbTabelas.Items[slbTabelas.ItemIndex]);
  btExecSQLClick(Sender);
end;

procedure TfmIndex.sbMusicaAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'Monitor', sbMusicaAreaExtendida.Items[sbMusicaAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbMusicaOperadorAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'MonitorOperador', sbMusicaOperadorAreaExtendida.Items[sbMusicaOperadorAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbMusicaRetornoAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Musicas', 'MonitorRetorno', sbMusicaRetornoAreaExtendida.Items[sbMusicaRetornoAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.sbPlayerAreaExtendidaChange(Sender: TObject);
begin
  gravaParam('Player', 'Monitor', sbPlayerAreaExtendida.Items[sbPlayerAreaExtendida.ItemIndex]);
end;

procedure TfmIndex.expandirArea(Sender: TObject);
var
  abre: Boolean;
  monitor: Integer;
  i: integer;
  item_config: string;
  botao: string;
begin
  if Sender = nil then
    abre := False
  else
  begin
    if (TbsSkinMenuSpeedButton(Sender).ImageIndex <> 11) and
       (TbsSkinMenuSpeedButton(Sender).ImageIndex <> 54) then
      abre := True
    else
      abre := False;
  end;

  botao := TbsSkinMenuSpeedButton(Sender).Name;


  if abre = True then
  begin
    item_config := monitor_tp_config(TbsSkinMenuSpeedButton(Sender));
    monitor := strtoint(lerParam(item_config, 'Monitor', '2'));
    if (Screen.MonitorCount < monitor) then
    begin
      if (Application.MessageBox(PChar('Não foi possível localizar monitor '+inttostr(monitor)+'. Deseja abrir no monitor principal?'), TITULO, mb_yesno + mb_iconquestion) <> 6) then
        Exit;

      monitor := 0;
    end
    else
      monitor := monitor - 1;

    if (botao = 'btExp_MenuMusicas') then
    begin
      if fMonitorMenuMusicas <> nil then
        fMonitorMenuMusicas.Close;
      fIniciando.AppCreateForm(TfMonitorMenuMusicas, fMonitorMenuMusicas);
      fMonitorMenuMusicas.AlphaBlend := True;
      fMonitorMenuMusicas.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorMenuMusicas.BorderStyle := bsNone
      else
        fMonitorMenuMusicas.BorderStyle := bsSizeable;

      fMonitorMenuMusicas.show;
      fMonitorMenuMusicas.Left := monitorInfo(monitor).Left;
      fMonitorMenuMusicas.Top := monitorInfo(monitor).Top;
      fMonitorMenuMusicas.Width := monitorInfo(monitor).Width;
      fMonitorMenuMusicas.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorMenuMusicas.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorMenuMusicas.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Biblia') then
    begin
      loadCol.Strings.Values['BIBLIA_IMG_E'] := '|';

      if fMonitorBiblia <> nil then
        fMonitorBiblia.Close;
      fIniciando.AppCreateForm(TfMonitorBiblia, fMonitorBiblia);
      fMonitorBiblia.AlphaBlend := True;
      fMonitorBiblia.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorBiblia.BorderStyle := bsNone
      else
        fMonitorBiblia.BorderStyle := bsSizeable;

      fMonitorBiblia.show;
      fMonitorBiblia.Left := monitorInfo(monitor).Left;
      fMonitorBiblia.Top := monitorInfo(monitor).Top;
      fMonitorBiblia.Width := monitorInfo(monitor).Width;
      fMonitorBiblia.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorBiblia.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorBiblia.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_BibliaBusca') then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := '|';

      if fMonitorBibliaBusca <> nil then
        fMonitorBibliaBusca.Close;
      fIniciando.AppCreateForm(TfMonitorBibliaBusca, fMonitorBibliaBusca);
      fMonitorBibliaBusca.AlphaBlend := True;
      fMonitorBibliaBusca.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorBibliaBusca.BorderStyle := bsNone
      else
        fMonitorBibliaBusca.BorderStyle := bsSizeable;

      fMonitorBibliaBusca.show;
      fMonitorBibliaBusca.Left := monitorInfo(monitor).Left;
      fMonitorBibliaBusca.Top := monitorInfo(monitor).Top;
      fMonitorBibliaBusca.Width := monitorInfo(monitor).Width;
      fMonitorBibliaBusca.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorBibliaBusca.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorBibliaBusca.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_EscolaSabatina') then
    begin
      loadCol.Strings.Values['ES_IMG_E'] := '|';

      if fMonitorCronometroCulto <> nil then
        fMonitorCronometroCulto.Close;
      fIniciando.AppCreateForm(TfMonitorCronometroCulto, fMonitorCronometroCulto);
      fMonitorCronometroCulto.AlphaBlend := True;
      fMonitorCronometroCulto.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorCronometroCulto.BorderStyle := bsNone
      else
        fMonitorCronometroCulto.BorderStyle := bsSizeable;

      fMonitorCronometroCulto.show;
      fMonitorCronometroCulto.Left := monitorInfo(monitor).Left;
      fMonitorCronometroCulto.Top := monitorInfo(monitor).Top;
      fMonitorCronometroCulto.Width := monitorInfo(monitor).Width;
      fMonitorCronometroCulto.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorCronometroCulto.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorCronometroCulto.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Sorteio') then
    begin
      loadCol.Strings.Values['SORTEIO_IMG_E'] := '|';

      if fMonitorSorteio <> nil then
        fMonitorSorteio.Close;
      fIniciando.AppCreateForm(TfMonitorSorteio, fMonitorSorteio);
      fMonitorSorteio.AlphaBlend := True;
      fMonitorSorteio.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorSorteio.BorderStyle := bsNone
      else
        fMonitorSorteio.BorderStyle := bsSizeable;

      fMonitorSorteio.show;
      fMonitorSorteio.Left := monitorInfo(monitor).Left;
      fMonitorSorteio.Top := monitorInfo(monitor).Top;
      fMonitorSorteio.Width := monitorInfo(monitor).Width;
      fMonitorSorteio.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorSorteio.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorSorteio.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_SorteioNM') then
    begin
      loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := '|';

      if fMonitorSorteioNomes <> nil then
        fMonitorSorteioNomes.Close;
      fIniciando.AppCreateForm(TfMonitorSorteioNomes, fMonitorSorteioNomes);
      fMonitorSorteioNomes.AlphaBlend := True;
      fMonitorSorteioNomes.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorSorteioNomes.BorderStyle := bsNone
      else
        fMonitorSorteioNomes.BorderStyle := bsSizeable;

      fMonitorSorteioNomes.show;
      fMonitorSorteioNomes.Left := monitorInfo(monitor).Left;
      fMonitorSorteioNomes.Top := monitorInfo(monitor).Top;
      fMonitorSorteioNomes.Width := monitorInfo(monitor).Width;
      fMonitorSorteioNomes.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorSorteioNomes.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorSorteioNomes.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_Cronometro') then
    begin
      loadCol.Strings.Values['CRONO_IMG_E'] := '|';

      if fMonitorCronometro <> nil then
        fMonitorCronometro.Close;
      fIniciando.AppCreateForm(TfMonitorCronometro, fMonitorCronometro);
      fMonitorCronometro.AlphaBlend := True;
      fMonitorCronometro.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorCronometro.BorderStyle := bsNone
      else
        fMonitorCronometro.BorderStyle := bsSizeable;

      fMonitorCronometro.show;
      fMonitorCronometro.Left := monitorInfo(monitor).Left;
      fMonitorCronometro.Top := monitorInfo(monitor).Top;
      fMonitorCronometro.Width := monitorInfo(monitor).Width;
      fMonitorCronometro.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorCronometro.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorCronometro.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_PainelD') then
    begin
      loadCol.Strings.Values['PAINELD_IMG_E'] := '|';

      if fMonitorPainelDinamico <> nil then
        fMonitorPainelDinamico.Close;
      fIniciando.AppCreateForm(TfMonitorPainelDinamico, fMonitorPainelDinamico);
      fMonitorPainelDinamico.AlphaBlend := True;
      fMonitorPainelDinamico.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorPainelDinamico.BorderStyle := bsNone
      else
        fMonitorPainelDinamico.BorderStyle := bsSizeable;

      fMonitorPainelDinamico.show;
      fMonitorPainelDinamico.Left := monitorInfo(monitor).Left;
      fMonitorPainelDinamico.Top := monitorInfo(monitor).Top;
      fMonitorPainelDinamico.Width := monitorInfo(monitor).Width;
      fMonitorPainelDinamico.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorPainelDinamico.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorPainelDinamico.AlphaBlendValue := 255;
    end
    else
    if (botao = 'btExp_TextoInterativo') then
    begin
      if fMonitorTextoInterativo <> nil then
        fMonitorTextoInterativo.Close;
      fIniciando.AppCreateForm(TfMonitorTextoInterativo, fMonitorTextoInterativo);
      fMonitorTextoInterativo.AlphaBlend := True;
      fMonitorTextoInterativo.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorTextoInterativo.BorderStyle := bsNone
      else
        fMonitorTextoInterativo.BorderStyle := bsSizeable;

      fMonitorTextoInterativo.show;
      fMonitorTextoInterativo.Left := monitorInfo(monitor).Left;
      fMonitorTextoInterativo.Top := monitorInfo(monitor).Top;
      fMonitorTextoInterativo.Width := monitorInfo(monitor).Width;
      fMonitorTextoInterativo.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorTextoInterativo.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorTextoInterativo.AlphaBlendValue := 255;
    end
    else if (botao = 'btExp_Relogio') then
    begin
      loadCol.Strings.Values['RELOGIO_IMG_E'] := '|';

      if fMonitorRelogio <> nil then
        fMonitorRelogio.Close;
      fIniciando.AppCreateForm(TfMonitorRelogio, fMonitorRelogio);
      fMonitorRelogio.AlphaBlend := True;
      fMonitorRelogio.AlphaBlendValue := 0;

      if ckMonitorJanela.Checked then
        fMonitorRelogio.BorderStyle := bsNone
      else
        fMonitorRelogio.BorderStyle := bsSizeable;

      fMonitorRelogio.show;
      fMonitorRelogio.Left := monitorInfo(monitor).Left;
      fMonitorRelogio.Top := monitorInfo(monitor).Top;
      fMonitorRelogio.Width := monitorInfo(monitor).Width;
      fMonitorRelogio.Height := monitorInfo(monitor).Height;

      copiaDadosTelaExtendida();

      if ckFadeForm.Checked then
      begin
        for i := 0 to 255 do
        begin
          fMonitorRelogio.AlphaBlendValue := i;
          sleep(1);
        end;
      end
      else fMonitorRelogio.AlphaBlendValue := 255;
    end;

  end
  else if Sender <> nil then
  begin
    if (botao = 'btExp_MenuMusicas') then
    begin
      if fMonitorMenuMusicas <> nil then
        fMonitorMenuMusicas.Close;
    end
    else
    if (botao = 'btExp_Biblia') then
    begin
      if fMonitorBiblia <> nil then
        fMonitorBiblia.Close;
    end
    else
    if (botao = 'btExp_BibliaBusca') then
    begin
      if fMonitorBibliaBusca <> nil then
        fMonitorBibliaBusca.Close;
    end
    else
    if (botao = 'btExp_EscolaSabatina') then
    begin
      if fMonitorCronometroCulto <> nil then
        fMonitorCronometroCulto.Close;
    end
    else
    if (botao = 'btExp_Sorteio') then
    begin
      if fMonitorSorteio <> nil then
        fMonitorSorteio.Close;
    end
    else
    if (botao = 'btExp_SorteioNM') then
    begin
      if fMonitorSorteioNomes <> nil then
        fMonitorSorteioNomes.Close;
    end
    else
    if (botao = 'btExp_Cronometro') then
    begin
      if fMonitorCronometro <> nil then
        fMonitorCronometro.Close;
    end
    else if (botao = 'btExp_PainelD') then
    begin
      if fMonitorPainelDinamico <> nil then
        fMonitorPainelDinamico.Close;
    end
    else if (botao = 'btExp_TextoInterativo') then
    begin
      if fMonitorTextoInterativo <> nil then
        fMonitorTextoInterativo.Close;
    end
    else if (botao = 'btExp_Relogio') then
    begin
      if fMonitorRelogio <> nil then
        fMonitorRelogio.Close;
    end;

    if (TbsSkinMenuSpeedButton(Sender).ImageList.Name = 'ico_40x40')
      then TbsSkinMenuSpeedButton(Sender).ImageIndex := 10
      else TbsSkinMenuSpeedButton(Sender).ImageIndex := 53;

  end;


end;

procedure TfmIndex.ExportarMusica(id: integer;audio:boolean;nome:string;param:string);
var
  arquivo : TMemIniFile;
  slide: string;
  tempo: string;
  url: string;
  ZipFile: TZipFile;
  arq: string;
  arq_e: string;
  imgList: TStringList;
begin
  url := saveDialog('arquivo', 'Apresentação LouvorJA (*.slja)|*.slja','','','',trim(nome)+'.slja');
  if url <> '' then
  begin

    ZipFile := TZipFile.Create;
    imgList := TStringList.Create;

    try
      imgList.Clear;

      try
        ZipFile.Open(url, zmWrite);

        arq := dir_temp+'~save_'+ExtractFileName(url)+'_'+FormatDateTime('yyyymmddHHMMSSZZZ', now())+'.temp';
        arquivo := Tmeminifile.Create(arq);
        arquivo.Clear;

        try

          DM.qrSLIDE_MUSICA.Close;
          DM.qrSLIDE_MUSICA.ParamByName('MUSICA_ID').Value := id;
          DM.qrSLIDE_MUSICA.Open;

          arquivo.writeString('Geral', 'slides', IntToStr(DM.qrSLIDE_MUSICA.RecordCount));
          if (audio = true)
            then arquivo.writeString('Geral', 'audio', '1')
            else arquivo.writeString('Geral', 'audio', '0');
          if (param = 'PB') then
          begin
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString) <> '' then
            begin
              arq_e := dir_config+'musicas\'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString;
              arq_e := StringReplace(arq_e,'/', '\', [rfIgnoreCase, rfReplaceAll]);
              arq_e := 'audio\'+ExtractFileName(arq_e);
              ZipFile.Add(dir_config+'musicas\'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA_PB').AsString,arq_e);
              arquivo.writeString('Geral', 'url_musica', arq_e);
            end
            else
            begin
              Application.MessageBox('Esta música não possui playback!',TITULO,mb_ok+MB_ICONEXCLAMATION);
              Exit;
            end;
          end
          else
          begin
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString) <> '' then
            begin
              arq_e := dir_config+'musicas\'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString;
              arq_e := StringReplace(arq_e,'/', '\', [rfIgnoreCase, rfReplaceAll]);
              arq_e := 'audio\'+ExtractFileName(arq_e);
              ZipFile.Add(dir_config+'musicas\'+DM.qrSLIDE_MUSICA.FieldByName('URL_MUSICA').AsString,arq_e);
              arquivo.writeString('Geral', 'url_musica', arq_e);
            end;
          end;

          while not DM.qrSLIDE_MUSICA.eof do
          begin
            slide := 'Slide:'+inttostr(DM.qrSLIDE_MUSICA.RecNo);
            arquivo.writeString(slide, 'tipo', DM.qrSLIDE_MUSICA.FieldByName('TIPO').AsString);
            if Trim(DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString) <> ''
              then arquivo.writeString(slide, 'letra', StringReplace(DM.qrSLIDE_MUSICA.FieldByName('LETRA').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

            if DM.qrSLIDE_MUSICA.FieldByName('FUNDO_LETRA').AsInteger = 1
              then arquivo.writeString(slide, 'fundo_letra', '1')
              else arquivo.writeString(slide, 'fundo_letra', '0');

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'tamanho_letra', DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString);

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'cor_letra', ColorToHtml(StringToColor(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA').AsString)));

            if Trim(DM.qrSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString) <> ''
              then arquivo.writeString(slide, 'letra_aux', StringReplace(DM.qrSLIDE_MUSICA.FieldByName('LETRA_AUX').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').AsString) <> '')
              then arquivo.writeString(slide, 'tamanho_letra_aux', DM.qrSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').AsString);

            if (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString) <> '0') and (Trim(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString) <> '')
              then arquivo.writeString(slide, 'cor_letra_aux', ColorToHtml(StringToColor(DM.qrSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').AsString)));

            if Trim(DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString) <> '' then
            begin
              arq_e := dir_config+'imagens\'+DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString;
              arq_e := StringReplace(arq_e,'/', '\', [rfIgnoreCase, rfReplaceAll]);
              arq_e := 'imagens\'+ExtractFileName(arq_e);
              if imgList.IndexOf(arq_e) < 0 then
              begin
                imgList.Add(arq_e);
                ZipFile.Add(dir_config+'imagens\'+DM.qrSLIDE_MUSICA.FieldByName('IMAGEM').AsString,arq_e);
              end;
              arquivo.writeString(slide, 'imagem', arq_e);
            end;

            if (param = 'PB')
              then tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO_PB').AsString
              else tempo := DM.qrSLIDE_MUSICA.FieldByName('TEMPO').AsString;
    //        tempo := SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,pos)))
            arquivo.writeString(slide, 'tempo', tempo);

            DM.qrSLIDE_MUSICA.Next;
          end;
          DM.qrSLIDE_MUSICA.Close;
          arquivo.UpdateFile;
        finally
          arquivo.Free;
        end;

        ZipFile.Add(arq,'slides.lja');
        DeleteFile(arq);
      finally
        ZipFile.Free;
      end;

    finally
      imgList.Free;
    end;

    Application.MessageBox('Slides exportados com sucesso!', TITULO, mb_ok + mb_iconinformation);

  end;
end;

procedure TfmIndex.ExportarMusicaClick(Sender: TObject);
var
  nome:string;
  id,tag: Integer;
  musica:string;
  param: string;
begin
  nome := TComponent(Sender).Name;
  tag := TComponent(Sender).Tag;
  id := 0;
  param := '';

  if (nome = 'miOpcExportar1') or (nome = 'miOpcExportar2') or (nome = 'miOpcExportar3')
    then nome := botao_trmenu.Name;

  if (nome = 'btExportarHino') then
  begin
    id := DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid1.DataSource.DataSet.FieldByName('NOME').AsString;
  end
  else if (nome = 'btExportarHinoN') then
  begin
    id := DBGrid1N.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid1N.DataSource.DataSet.FieldByName('NOME').AsString;
  end
  else if (nome = 'btExportarMusica') then
  begin
    if DBGrid2.DataSource.DataSet.FieldByName('TIPO_WEB').AsString = 'S' then
    begin
      application.MessageBox('Não é possível exportar slides de músicas da web!', TITULO, mb_ok + MB_ICONEXCLAMATION);
      exit;
    end;
    id := DBGrid2.DataSource.DataSet.FieldByName('ID').AsInteger;
    musica := DBGrid2.DataSource.DataSet.FieldByName('NOME').AsString;
  end;

  if tag = 2 then
  begin
    musica := musica + ' - PB';
    param := 'PB';
  end;

  ExportarMusica(id,(tag <= 2),musica,param);
end;

procedure TfmIndex.confereAbasAbertas;
var
  i, t: Integer;
begin
  mnFechaAba.Enabled := False;
  mnFechaTodasAbas.Enabled := False;

  t := 0;
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if PageControl1.Pages[i].TabVisible = true then
    begin
      mnFechaAba.Enabled := True;
      mnFechaTodasAbas.Enabled := True;
      PageControl1.Pages[i].Tag := t;
      bsPopupMenuRibon.Items[t].Tag := t;
      t := t + 1;
    end;
  end;

  if mnFechaAba.Enabled = False then
  begin
    pnlTitForm.Caption := TITULO;
    PageControl1.Visible := false;
    botoesFavoritos('-');
    PaginaMenuAtiva(nil);
    bsPopupMenuFavoritos.Items[0].Checked := True;
    bsPopupMenuFavoritos.Items[0].Checked := False;
  end;
end;

procedure TfmIndex.copiaArquivoParaSlides(url: string; cds: TClientDataSet; fechaerro: boolean; ListBox: TListBox; editor: Boolean);
var
  i,slides: integer;
  slide,letra,letra_aux,tempo: string;
  uCor,uLetra: string;
begin

  uCor := '';
  uLetra := '';

  try
    slides := StrToInt('0'+fmIndex.lerParam('Geral', 'slides', '0',ExtractFileName(url), ExtractFilePath(url)));
    if (slides <= 0) then
    begin
      Application.MessageBox('Ocorreu um erro ao executar este arquivo!', fmIndex.titulo, mb_ok + mb_iconerror);
      if fechaerro then
      begin
        DM.tmrSair.Enabled := true;
        close;
      end;
      Exit;
    end;
  except
    Application.MessageBox('Ocorreu um erro ao executar este arquivo!', fmIndex.titulo, mb_ok + mb_iconerror);
    if fechaerro then
    begin
      DM.tmrSair.Enabled := true;
      close;
    end;
    Exit;
  end;

  for i := 1 to slides do
  begin
    slide := 'Slide:'+inttostr(i);
    letra := fmIndex.lerParam(slide, 'letra', '',ExtractFileName(url), ExtractFilePath(url));
    letra := StringReplace(letra,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);
    letra_aux := fmIndex.lerParam(slide, 'letra_aux', '',ExtractFileName(url), ExtractFilePath(url));
    letra_aux := StringReplace(letra_aux,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);
    tempo := fmIndex.lerParam(slide, 'tempo', '0',ExtractFileName(url), ExtractFilePath(url));

    if ListBox <> nil then
      ListBox.Items.Add(tempo);
    cds.Append;
    cds.FieldByName('LOCAL').Value := 'EXT';
    cds.FieldByName('TIPO').Value := fmIndex.lerParam(slide, 'tipo', 'LETRA',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('MUSICA_ID').Value := '-1';
    cds.FieldByName('LETRA_ID').Value := '-1';
    if not (FileExists(ExtractFilePath(url)+fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url)))) then
      cds.FieldByName('URL_MUSICA').Value := fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url))
    else
      cds.FieldByName('URL_MUSICA').Value := ExtractFilePath(url)+fmIndex.lerParam('Geral', 'url_musica', '',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('LETRA').Value := letra;
    cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
    cds.FieldByName('ORDEM').Value := i;
    if not (FileExists(ExtractFilePath(url)+fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url)))) then
      cds.FieldByName('IMAGEM').Value := fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url))
    else
      cds.FieldByName('IMAGEM').Value := ExtractFilePath(url)+fmIndex.lerParam(slide, 'imagem', '',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('IMAGEM_POSICAO').Value := '0'+fmIndex.lerParam(slide, 'imagem_posicao', '5',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('TEMPO').Value := tempo;
    cds.FieldByName('FUNDO_LETRA').Value := (fmIndex.lerParam(slide, 'fundo_letra', '1',ExtractFileName(url), ExtractFilePath(url)) = '1');
    if (i > 1) then
    begin
      cds.FieldByName('TAMANHO_LETRA').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra', '14',ExtractFileName(url), ExtractFilePath(url));
      cds.FieldByName('COR_LETRA').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra', '#FFFFFF',ExtractFileName(url), ExtractFilePath(url)));
    end
    else
    begin
      cds.FieldByName('TAMANHO_LETRA').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra', '18',ExtractFileName(url), ExtractFilePath(url));
      cds.FieldByName('COR_LETRA').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra', '#efb400',ExtractFileName(url), ExtractFilePath(url)));
    end;
    cds.FieldByName('LETRA_AUX').Value := letra_aux;
    cds.FieldByName('TAMANHO_LETRA_AUX').Value := '0'+fmIndex.lerParam(slide, 'tamanho_letra_aux', '10',ExtractFileName(url), ExtractFilePath(url));
    cds.FieldByName('COR_LETRA_AUX').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_letra_aux', '#efb400',ExtractFileName(url), ExtractFilePath(url)));
    cds.FieldByName('COR_FUNDO').Value := HtmlToColor(fmIndex.lerParam(slide, 'cor_fundo', '#000000',ExtractFileName(url), ExtractFilePath(url)));

    if (fmIndex.ckSlideTxtFormatPerso.Checked and fmIndex.ckSlideFormatPersoExt.Checked and not editor) then
    begin
      DM.cdsSLIDE_MUSICA.FieldByName('FUNDO_LETRA').Value := not fmIndex.ckMusicaFundoTransparente.Checked;

      if i = 1 then
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTitulo.Text;
        DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA').Value := ColorToString(fmIndex.corTituloMusica.ColorValue);
      end
      else
      begin
        DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA').Value := fmIndex.seTamanhoTexto.Text;
        if (uLetra <> '') and (Trim(uLetra) = Trim(AnsiUpperCase(letra))) then
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
        uLetra := AnsiUpperCase(letra);
      end;
      DM.cdsSLIDE_MUSICA.FieldByName('TAMANHO_LETRA_AUX').Value := fmIndex.seTamanhoTextoAux.Text;
      DM.cdsSLIDE_MUSICA.FieldByName('COR_LETRA_AUX').Value := ColorToString(fmIndex.corTextoRepetido.ColorValue);
    end;

    if (fmIndex.ckSlideImgFormatPerso.Checked and fmIndex.ckSlideFormatPersoExt.Checked and not editor) then
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
    end;

    cds.Post;
  end;
end;

procedure TfmIndex.copiaDadosTelaExtendida;
var
  Stream: TStringStream;
begin
  if (fMonitorMenuMusicas <> nil) then
  begin
    fMonitorMenuMusicas.lblTitulo.Caption := fListaMusica.lblTitulo.Caption;
    fMonitorMenuMusicas.lblSubtitulo.Caption := fListaMusica.lblSubtitulo.Caption;
    fMonitorMenuMusicas.imgCapa.Picture := fListaMusica.imgCapa.Picture;
    fMonitorMenuMusicas.DBCtrlGrid.RowCount := Trunc(fMonitorMenuMusicas.DBCtrlGrid.ClientHeight / 80);
  end;


  if (fMonitorBiblia <> nil) then
  begin
    fMonitorBiblia.lmdBibliaTxt.Font := lmdBibliaTxt.Font;
    fMonitorBiblia.lmdBibliaInfo.Font := lmdBibliaInfo.Font;
    fMonitorBiblia.lmdBibliaTxt.Font.Height := Trunc((fMonitorBiblia.pnlBiblia.Height/100)*strtoint(lerParam('Biblia', 'Tamanho', '7')));
    fMonitorBiblia.lmdBibliaInfo.Font.Height := Trunc((fMonitorBiblia.pnlBiblia.Height/100)*strtoint(lerParam('Biblia', 'Tamanho Passagem', '7')));
    fMonitorBiblia.pnlBiblia.Color := pnlBiblia.Color;

    fMonitorBiblia.lmdBibliaTxt.Caption := lmdBibliaTxt.Caption;
    fMonitorBiblia.lmdBibliaInfo.Caption := lmdBibliaInfo.Caption;

    fMonitorBiblia.pnlBiblia.DoubleBuffered := pnlBiblia.DoubleBuffered;
    ajustaTexto('BIBLIA',true);

    if (loadCol.Strings.Values['BIBLIA_IMG_E'] <> lerParam('Biblia', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['BIBLIA_IMG_E'] := lerParam('Biblia', 'Imagem Fundo', '');
      fMonitorBiblia.imgBiblia.Picture := imgBiblia.Picture;

      fMonitorBiblia.imgBiblia.Refresh;
      fMonitorBiblia.imgBiblia.Repaint;
      fMonitorBiblia.pnlBiblia.Refresh;
      fMonitorBiblia.pnlBiblia.Invalidate;
      fMonitorBiblia.pnlBiblia.Repaint;
      ajustaImagem(fMonitorBiblia.imgBiblia,fMonitorBiblia.pnlBiblia,cbBibliaPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorBibliaBusca <> nil) then
  begin
    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Font := lmdBibliaBuscaTxt.Font;
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Font := lmdBibliaBuscaInfo.Font;
    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Font.Height := Trunc((fMonitorBibliaBusca.pnlBibliaBusca.Height/100)*strtoint(lerParam('Busca Biblica', 'Tamanho', '7')));
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Font.Height := Trunc((fMonitorBibliaBusca.pnlBibliaBusca.Height/100)*strtoint(lerParam('Busca Biblica', 'Tamanho Passagem', '7')));
    fMonitorBibliaBusca.pnlBibliaBusca.Color := pnlBibliaBusca.Color;

    fMonitorBibliaBusca.lmdBibliaBuscaTxt.Caption := lmdBibliaBuscaTxt.Caption;
    fMonitorBibliaBusca.lmdBibliaBuscaInfo.Caption := lmdBibliaBuscaInfo.Caption;

    fMonitorBibliaBusca.pnlBibliaBusca.DoubleBuffered := pnlBibliaBusca.DoubleBuffered;
    ajustaTexto('BIBLIA_BUSCA',true);

    if (loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] <> lerParam('Busca Biblica', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['BIBLIA_BUSCA_IMG_E'] := lerParam('Busca Biblica', 'Imagem Fundo', '');
      fMonitorBibliaBusca.imgBibliaBusca.Picture := imgBibliaBusca.Picture;

      fMonitorBibliaBusca.imgBibliaBusca.Refresh;
      fMonitorBibliaBusca.imgBibliaBusca.Repaint;
      fMonitorBibliaBusca.pnlBibliaBusca.Refresh;
      fMonitorBibliaBusca.pnlBibliaBusca.Invalidate;
      fMonitorBibliaBusca.pnlBibliaBusca.Repaint;
      ajustaImagem(fMonitorBibliaBusca.imgBibliaBusca,fMonitorBibliaBusca.pnlBibliaBusca,cbBibliabPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorCronometroCulto <> nil) then
  begin
    fMonitorCronometroCulto.lmdEscSb.Font := lmdEscSb.Font;
    fMonitorCronometroCulto.lmdEscSbR.Font := lmdEscSbR.Font;
    fMonitorCronometroCulto.lmdEscSb.Font.Height := Trunc((fMonitorCronometroCulto.pnlEscSB.Height/100)*strtoint(lerParam('Escola Sabatina', 'Tamanho', '30')));
    fMonitorCronometroCulto.lmdEscSbR.Font.Height := Trunc((fMonitorCronometroCulto.pnlEscSB.Height/100)*strtoint(lerParam('Escola Sabatina', 'Tamanho 2', '20')));
    fMonitorCronometroCulto.pnlEscSB.Color := pnlEscSB.Color;

    fMonitorCronometroCulto.lmdEscSb.Caption := lmdEscSb.Caption;
    fMonitorCronometroCulto.lmdEscSbR.Caption := lmdEscSbR.Caption;
    fMonitorCronometroCulto.gEscSbR.MaxValue := gEscSbR.MaxValue;
    fMonitorCronometroCulto.gEscSbR.Value := gEscSbR.Value;

    fMonitorCronometroCulto.pnlEscSB.DoubleBuffered := pnlEscSB.DoubleBuffered;

    if (loadCol.Strings.Values['ES_IMG_E'] <> lerParam('Escola Sabatina', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['ES_IMG_E'] := lerParam('Escola Sabatina', 'Imagem Fundo', '');
      fMonitorCronometroCulto.imgEscSB.Picture := imgEscSB.Picture;

      fMonitorCronometroCulto.imgEscSB.Refresh;
      fMonitorCronometroCulto.imgEscSB.Repaint;
      fMonitorCronometroCulto.pnlEscSB.Refresh;
      fMonitorCronometroCulto.pnlEscSB.Invalidate;
      fMonitorCronometroCulto.pnlEscSB.Repaint;
      ajustaImagem(fMonitorCronometroCulto.imgEscSB,fMonitorCronometroCulto.pnlEscSB,cbEscSBPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorSorteio <> nil) then
  begin
    fMonitorSorteio.lmdSorteio.Font := lmdSorteio.Font;
    fMonitorSorteio.lmdSorteio.Font.Height := Trunc((fMonitorSorteio.pnlSorteio.Height/100)*strtoint(lerParam('Sorteio', 'Tamanho', '35')));
    fMonitorSorteio.pnlSorteio.Color := pnlSorteio.Color;
    fMonitorSorteio.pnlSorteioE.Visible := ckSorteioExp.ItemChecked[0];
    fMonitorSorteio.pnlSorteioD.Visible := ckSorteioExp.ItemChecked[1];

    fMonitorSorteio.lmdSorteio.Caption := lmdSorteio.Caption;
    fMonitorSorteio.lmdSorteio.Align := lmdSorteio.Align;
    if fMonitorSorteio.lmdSorteio.Align = alClient
      then fMonitorSorteio.lmdSorteio.Height := fMonitorSorteio.pnlSorteio.Height
      else fMonitorSorteio.lmdSorteio.Height := Trunc(fMonitorSorteio.pnlSorteio.Height/2);

    fMonitorSorteio.lbSorteio.Items := lbSorteio.Items;
    try
      fMonitorSorteio.lbSorteio.ItemIndex := lbSorteio.ItemIndex;
    except
    end;
    fMonitorSorteio.lbSorteado.Items := lbSorteado.Items;
    try
      fMonitorSorteio.lbSorteado.ItemIndex := lbSorteado.ItemIndex;
    except
    end;
    fMonitorSorteio.gSorteio.MaxValue := gSorteio.MaxValue;
    fMonitorSorteio.gSorteio.Value := gSorteio.Value;

    fMonitorSorteio.pnlSorteio.DoubleBuffered := pnlSorteio.DoubleBuffered;

    if (loadCol.Strings.Values['SORTEIO_IMG_E'] <> lerParam('Sorteio', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['SORTEIO_IMG_E'] := lerParam('Sorteio', 'Imagem Fundo', '');
      fMonitorSorteio.imgSorteio.Picture := imgSorteio.Picture;
      fMonitorSorteio.imgSorteio.Refresh;
      fMonitorSorteio.imgSorteio.Repaint;
      fMonitorSorteio.pnlSorteio.Refresh;
      fMonitorSorteio.pnlSorteio.Invalidate;
      fMonitorSorteio.pnlSorteio.Repaint;
      ajustaImagem(fMonitorSorteio.imgSorteio,fMonitorSorteio.pnlSorteio,cbSorteioPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorSorteioNomes <> nil) then
  begin
    fMonitorSorteioNomes.lmdSorteioNM.Font := lmdSorteioNM.Font;
    fMonitorSorteioNomes.lmdSorteioNM.Font.Height := Trunc((fMonitorSorteioNomes.pnlSorteioNM.Height/100)*strtoint(lerParam('Sorteio Nomes', 'Tamanho', '15')));
    fMonitorSorteioNomes.pnlSorteioNM.Color := pnlSorteioNM.Color;
    fMonitorSorteioNomes.pnlSorteioNME.Visible := ckSorteioExpNM.ItemChecked[0];
    fMonitorSorteioNomes.pnlSorteioNMD.Visible := ckSorteioExpNM.ItemChecked[1];

    fMonitorSorteioNomes.lmdSorteioNM.Caption := lmdSorteioNM.Caption;
    fMonitorSorteioNomes.lmdSorteioNM.Align := lmdSorteioNM.Align;
    if fMonitorSorteioNomes.lmdSorteioNM.Align = alClient
      then fMonitorSorteioNomes.lmdSorteioNM.Height := fMonitorSorteioNomes.pnlSorteioNM.Height
      else fMonitorSorteioNomes.lmdSorteioNM.Height := Trunc(fMonitorSorteioNomes.pnlSorteioNM.Height/2);

    fMonitorSorteioNomes.lbSorteioNM.Items := lbSorteioNM.Items;
    try
      fMonitorSorteioNomes.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
    except
    end;
    fMonitorSorteioNomes.lbSorteadoNM.Items := lbSorteadoNM.Items;
    try
      fMonitorSorteioNomes.lbSorteadoNM.ItemIndex := lbSorteadoNM.ItemIndex;
    except
    end;
    fMonitorSorteioNomes.gSorteioNM.MaxValue := gSorteioNM.MaxValue;
    fMonitorSorteioNomes.gSorteioNM.Value := gSorteioNM.Value;

    fMonitorSorteioNomes.pnlSorteioNM.DoubleBuffered := pnlSorteioNM.DoubleBuffered;

    if (loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] <> lerParam('Sorteio Nomes', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['SORTEIO_NOMES_IMG_E'] := lerParam('Sorteio Nomes', 'Imagem Fundo', '');
      fMonitorSorteioNomes.imgSorteioNM.Picture := imgSorteioNM.Picture;

      fMonitorSorteioNomes.imgSorteioNM.Refresh;
      fMonitorSorteioNomes.imgSorteioNM.Repaint;
      fMonitorSorteioNomes.pnlSorteioNM.Refresh;
      fMonitorSorteioNomes.pnlSorteioNM.Invalidate;
      fMonitorSorteioNomes.pnlSorteioNM.Repaint;
      ajustaImagem(fMonitorSorteioNomes.imgSorteioNM,fMonitorSorteioNomes.pnlSorteioNM,cbSorteioNMPosicaoFundo.ItemIndex+1);
    end;
  end;


  if (fMonitorCronometro <> nil) then
  begin
    fMonitorCronometro.lmdCrono.Font := lmdCrono.Font;
    fMonitorCronometro.lmdCrono.Font.Height := Trunc((fMonitorCronometro.pnlCrono.Height/100)*strtoint(lerParam('Cronometro', 'Tamanho', '22')));
    fMonitorCronometro.pnlCrono.Color := pnlCrono.Color;
    fMonitorCronometro.pnlTempoGravado.Visible := cbCronoEl.ItemChecked[0];

    fMonitorCronometro.lmdCrono.Caption := lmdCrono.Caption;
    fMonitorCronometro.lmdCrono.Align := lmdCrono.Align;
    if fMonitorCronometro.lmdCrono.Align = alClient
      then fMonitorCronometro.lmdCrono.Height := fMonitorCronometro.pnlCrono.Height
      else fMonitorCronometro.lmdCrono.Height := Trunc(fMonitorCronometro.pnlCrono.Height/2);

    fMonitorCronometro.lbCrono.Items := lbCrono.Items;
    fMonitorCronometro.gCrono.MaxValue := gCrono.MaxValue;
    fMonitorCronometro.gCrono.Value := gCrono.Value;

    fMonitorCronometro.pnlCrono.DoubleBuffered := pnlCrono.DoubleBuffered;

    if (loadCol.Strings.Values['CRONO_IMG_E'] <> lerParam('Cronometro', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['CRONO_IMG_E'] := lerParam('Cronometro', 'Imagem Fundo', '');
      fMonitorCronometro.imgCrono.Picture := imgCrono.Picture;

      fMonitorCronometro.imgCrono.Refresh;
      fMonitorCronometro.imgCrono.Repaint;
      fMonitorCronometro.pnlCrono.Refresh;
      fMonitorCronometro.pnlCrono.Invalidate;
      fMonitorCronometro.pnlCrono.Repaint;
      ajustaImagem(fMonitorCronometro.imgCrono,fMonitorCronometro.pnlCrono,cbCronoPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorPainelDinamico <> nil) then
  begin
    fMonitorPainelDinamico.lmdTxtPainelD.Font := lmdTxtPainelD.Font;
    fMonitorPainelDinamico.lmdTxtPainelD.Font.Height := Trunc((fMonitorPainelDinamico.pnlTxtPainelD.Height/100)*strtoint(lerParam('Painel Dinamico', 'Tamanho', '15')));
    fMonitorPainelDinamico.pnlTxtPainelD.Color := pnlTxtPainelD.Color;

    fMonitorPainelDinamico.lmdTxtPainelD.Caption := lmdTxtPainelD.Caption;
    fMonitorPainelDinamico.lmdTxtPainelD.Align := lmdTxtPainelD.Align;
    if fMonitorPainelDinamico.lmdTxtPainelD.Align = alClient
      then fMonitorPainelDinamico.lmdTxtPainelD.Height := fMonitorPainelDinamico.pnlTxtPainelD.Height
      else fMonitorPainelDinamico.lmdTxtPainelD.Height := Trunc(fMonitorPainelDinamico.pnlTxtPainelD.Height/2);

    fMonitorPainelDinamico.pnlTxtPainelD.DoubleBuffered := pnlTxtPainelD.DoubleBuffered;

    if (loadCol.Strings.Values['PAINELD_IMG_E'] <> lerParam('Painel Dinamico', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['PAINELD_IMG_E'] := lerParam('Painel Dinamico', 'Imagem Fundo', '');
      fMonitorPainelDinamico.imgTxtPainelD.Picture := imgTxtPainelD.Picture;

      fMonitorPainelDinamico.imgTxtPainelD.Refresh;
      fMonitorPainelDinamico.imgTxtPainelD.Repaint;
      fMonitorPainelDinamico.pnlTxtPainelD.Refresh;
      fMonitorPainelDinamico.pnlTxtPainelD.Invalidate;
      fMonitorPainelDinamico.pnlTxtPainelD.Repaint;
      ajustaImagem(fMonitorPainelDinamico.imgTxtPainelD,fMonitorPainelDinamico.pnlTxtPainelD,cbTxtPainelDPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorRelogio <> nil) then
  begin
    fMonitorRelogio.lmdRelogio.Font := lmdRelogio.Font;
    fMonitorRelogio.lmdRelogio.Font.Height := Trunc((fMonitorRelogio.pnlRelogio.Height/100)*strtoint(lerParam('Relogio', 'Tamanho', '30')));
    fMonitorRelogio.pnlRelogio.Color := pnlRelogio.Color;

    fMonitorRelogio.lmdRelogio.Caption := lmdRelogio.Caption;
    fMonitorRelogio.lmdRelogio.Align := lmdRelogio.Align;
    if fMonitorRelogio.lmdRelogio.Align = alClient
      then fMonitorRelogio.lmdRelogio.Height := fMonitorRelogio.pnlRelogio.Height
      else fMonitorRelogio.lmdRelogio.Height := Trunc(fMonitorRelogio.pnlRelogio.Height/2);


    fMonitorRelogio.pnlRelogio.DoubleBuffered := pnlRelogio.DoubleBuffered;

    if (loadCol.Strings.Values['RELOGIO_IMG_E'] <> lerParam('Relogio', 'Imagem Fundo', '')) then
    begin
      loadCol.Strings.Values['RELOGIO_IMG_E'] := lerParam('Relogio', 'Imagem Fundo', '');
      fMonitorRelogio.imgRelogio.Picture := imgRelogio.Picture;

      fMonitorRelogio.imgRelogio.Refresh;
      fMonitorRelogio.imgRelogio.Repaint;
      fMonitorRelogio.pnlRelogio.Refresh;
      fMonitorRelogio.pnlRelogio.Invalidate;
      fMonitorRelogio.pnlRelogio.Repaint;
      ajustaImagem(fMonitorRelogio.imgRelogio,fMonitorRelogio.pnlRelogio,cbRelogioPosicaoFundo.ItemIndex+1);
    end;
  end;

  if (fMonitorTextoInterativo <> nil) then
  begin
    Stream := TStringStream.Create('');
    try
     RichEdit0.Lines.SaveToStream(Stream);

      Stream.Seek(0, soFromBeginning);
     fMonitorTextoInterativo.RichEdit0.Lines.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    fMonitorTextoInterativo.RichEdit0.Color := RichEdit0.Color;
  end;
end;

procedure TfmIndex.CopiarLink1Click(Sender: TObject);
var
  txt: string;
begin
  if (DM.cdsVideosOnPerso.Active = false) or
    (DM.cdsVideosOnPerso.RecordCount <= 0) then
  begin
    application.messagebox(PChar('Nenhum vídeo selecionado!'), TITULO, mb_ok + MB_ICONEXCLAMATION);
    Exit;
  end;

  txt := DM.cdsVideosOnPerso.FieldByName('URL').AsString;

  Clipboard.AsText := txt;
  application.messagebox(PChar('Link ''' + txt + ''' copiado para a Área de Transferência!'), TITULO, mb_ok + MB_ICONINFORMATION)
end;

procedure TfmIndex.copiaSlidesParaArquivo(url: string; cds: TClientDataSet);
var
  arquivo : TMemIniFile;
  slide: string;
  tempo: string;
  pos: integer;
  ZipFile: TZipFile;
  arq: string;
  arq_e: string;
  imgList: TStringList;

  bass_musica: HSAMPLE;
  bass_channel: HCHANNEL;
begin
//url := url+'.zip';
  ZipFile := TZipFile.Create;
  imgList := TStringList.Create;

  try
    imgList.Clear;

    try
      ZipFile.Open(url, zmWrite);

      arq := dir_temp+'~save_'+ExtractFileName(url)+'_'+FormatDateTime('yyyymmddHHMMSSZZZ', now())+'.temp';
      arquivo := Tmeminifile.Create(arq);
      arquivo.Clear;

      pos := 1;
      if cds.RecNo > 0
        then pos := cds.RecNo;
      try
        cds.First;

        arquivo.writeString('Geral', 'slides', IntToStr(cds.RecordCount));
        arquivo.writeString('Geral', 'versao', lblVersao.Caption);

        if Trim(cds.FieldByName('URL_MUSICA').AsString) <> '' then
        begin
          arq_e := StringReplace(cds.FieldByName('URL_MUSICA').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
          arq_e := StringReplace(arq_e,'/', '\', [rfIgnoreCase, rfReplaceAll]);
          arq_e := 'audio\'+ExtractFileName(arq_e);
          ZipFile.Add(StringReplace(cds.FieldByName('URL_MUSICA').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]),arq_e);
          arquivo.writeString('Geral', 'url_musica', arq_e);
          arquivo.writeString('Geral', 'audio', '1');

          try
            BASS_Init(-1, 44100, 0, Handle, nil);
          except
            //
          end;
          try
            bass_musica := BASS_SampleLoad(FALSE, PChar(cds.FieldByName('URL_MUSICA').AsString), 0, 0, 3, BASS_SAMPLE_OVER_POS or BASS_UNICODE);
            bass_channel := BASS_SampleGetChannel(bass_musica, False);
            if not BASS_ChannelPlay(bass_channel, False) then
            begin
              arquivo.writeString('Geral', 'bass', 'error');
            end;
          except
            //
          end;
        end
        else
          arquivo.writeString('Geral', 'audio', '0');

        while not cds.eof do
        begin
          slide := 'Slide:'+inttostr(cds.RecNo);
          if cds.RecNo = 1 then
            arquivo.writeString(slide, 'tipo', 'CAPA')
          else
            arquivo.writeString(slide, 'tipo', 'LETRA');

          if Trim(cds.FieldByName('LETRA').AsString) <> ''
            then arquivo.writeString(slide, 'letra', StringReplace(cds.FieldByName('LETRA').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

          if cds.FieldByName('FUNDO_LETRA').AsBoolean = True
            then arquivo.writeString(slide, 'fundo_letra', '1')
            else arquivo.writeString(slide, 'fundo_letra', '0');

          if (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '0') and (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'tamanho_letra', cds.FieldByName('TAMANHO_LETRA').AsString);

          if (Trim(cds.FieldByName('COR_LETRA').AsString) <> '0') and (Trim(cds.FieldByName('COR_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'cor_letra', ColorToHtml(StringToColor(cds.FieldByName('COR_LETRA').AsString)));

          if (Trim(cds.FieldByName('COR_FUNDO').AsString) <> '0') and (Trim(cds.FieldByName('COR_FUNDO').AsString) <> '')
            then arquivo.writeString(slide, 'cor_fundo', ColorToHtml(StringToColor(cds.FieldByName('COR_FUNDO').AsString)));

          if Trim(cds.FieldByName('LETRA_AUX').AsString) <> ''
            then arquivo.writeString(slide, 'letra_aux', StringReplace(cds.FieldByName('LETRA_AUX').AsString,#13#10,'|',[rfIgnoreCase, rfReplaceAll]));

          if (Trim(cds.FieldByName('TAMANHO_LETRA_AUX').AsString) <> '0') and (Trim(cds.FieldByName('TAMANHO_LETRA').AsString) <> '')
            then arquivo.writeString(slide, 'tamanho_letra_aux', cds.FieldByName('TAMANHO_LETRA_AUX').AsString);

          if (Trim(cds.FieldByName('COR_LETRA_AUX').AsString) <> '0') and (Trim(cds.FieldByName('COR_LETRA_AUX').AsString) <> '')
            then arquivo.writeString(slide, 'cor_letra_aux', ColorToHtml(StringToColor(cds.FieldByName('COR_LETRA_AUX').AsString)));

          if Trim(cds.FieldByName('IMAGEM').AsString) <> '' then
          begin
            arq_e := StringReplace(cds.FieldByName('IMAGEM').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]);
            arq_e := StringReplace(arq_e,'/', '\', [rfIgnoreCase, rfReplaceAll]);
            arq_e := 'imagens\'+ExtractFileName(arq_e);
            if imgList.IndexOf(arq_e) < 0 then
            begin
              imgList.Add(arq_e);
              ZipFile.Add(StringReplace(cds.FieldByName('IMAGEM').AsString,'*', ExtractFilePath(application.ExeName), [rfIgnoreCase, rfReplaceAll]),arq_e);
            end;
            arquivo.writeString(slide, 'imagem', arq_e);
          end;

          if Trim(cds.FieldByName('IMAGEM_POSICAO').AsString) <> ''
            then arquivo.writeString(slide, 'imagem_posicao', cds.FieldByName('IMAGEM_POSICAO').AsString);

          tempo := cds.FieldByName('TEMPO').AsString;
          arquivo.writeString(slide, 'tempo', tempo);

          if Trim(cds.FieldByName('URL_MUSICA').AsString) <> '' then
          begin
            try
              arquivo.writeString(slide, 'tempo_hms', SegundosToTime(Trunc(BASS_ChannelBytes2Seconds(bass_channel,strtoint(tempo)))));
            except
              //
            end;
          end;

          if cds.RecordCount = cds.RecNo then Break;

          cds.Next;
        end;
        arquivo.UpdateFile;
      finally
        arquivo.Free;
      end;

      try
        BASS_MusicFree(bass_musica);
        BASS_Free();
      except
        //
      end;

      ZipFile.Add(arq,'slides.lja');
      DeleteFile(arq);
    finally
      ZipFile.Free;
    end;

  finally
    imgList.Free;
  end;

  if (cds.Active) and (cds.RecordCount > 0) then
    cds.RecNo := pos;
end;

procedure TfmIndex.copiaTextoParaSlides(texto: string;
  cds: TClientDataSet);
var
  linhas: TStringList;
  i,qt_lin,pos: Integer;
  letra: string;
begin
  linhas := TStringList.Create;
  linhas.Text := texto;

  if (linhas.Count <= 0)
    then linhas.Add('');

  if (Trim(linhas[linhas.Count-1]) <> '')
    then linhas.Add('');

  if not cds.Active then
  begin
    cds.CreateDataSet;
    cds.LogChanges := False;
  end;

  pos := 1;
  qt_lin := cds.RecordCount;
  if qt_lin > 0 then pos := cds.RecNo;
  for i := 0 to linhas.Count-1 do
  begin
    letra := linhas[i];
    letra := StringReplace(letra,'|', #13#10, [rfIgnoreCase, rfReplaceAll]);

    if (qt_lin >= i+1) then
    begin
      cds.Locate('ORDEM', i+1, []);
      cds.Edit;
      cds.FieldByName('LETRA').Value := letra;
      cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
      cds.Post;
    end
    else
    begin
      cds.Append;
      cds.FieldByName('LOCAL').Value := 'INT';
      if (i = 0)
        then cds.FieldByName('TIPO').Value := 'CAPA'
        else cds.FieldByName('TIPO').Value := 'LETRA';
      cds.FieldByName('MUSICA_ID').Value := '-1';
      cds.FieldByName('LETRA_ID').Value := '-1';
      cds.FieldByName('URL_MUSICA').Value := '';
      cds.FieldByName('LETRA').Value := letra;
      cds.FieldByName('LETRA_UCASE').Value := AnsiUpperCase(letra);
      cds.FieldByName('ORDEM').Value := i+1;
      cds.FieldByName('IMAGEM').Value := '';
      cds.FieldByName('IMAGEM_POSICAO').Value := '5';
      cds.FieldByName('TEMPO').Value := '0';
      cds.FieldByName('FUNDO_LETRA').Value := '1';
      cds.FieldByName('TAMANHO_LETRA').Value := '0';
      cds.FieldByName('COR_LETRA').Value := '';
      cds.FieldByName('LETRA_AUX').Value := '';
      cds.FieldByName('TAMANHO_LETRA_AUX').Value := '0';
      cds.FieldByName('COR_LETRA_AUX').Value := '';
      cds.Post;
    end;
  end;
  i := i+1;
  while i <= qt_lin do
  begin
    cds.Locate('ORDEM', i, []);
    cds.Delete;
    i := i+1;
  end;
  cds.RecNo := pos;
//  cds.Refresh;

end;

function TfmIndex.CopyComponent(Component, AParent: TComponent;
  NewComponentName: String): TComponent;
var
  Stream: TMemoryStream;
  S: String;
begin
  Result := TComponentClass(Component.ClassType).Create(Component.Owner);
  S := Component.Name;
  Component.Name := NewComponentName;
  Stream := TMemoryStream.Create;
  try
    Stream.WriteComponent(Component);
    Component.Name := S;
    Stream.Seek(0, soFromBeginning);
    Stream.ReadComponent(Result);
  finally
    Stream.Free;
  end;
  TWinControl(AParent).InsertControl(TControl(Result));
end;

function TfmIndex.monitorInfo(index: integer): TMonitorInfo;
var
  MonitorsArray: TArray<TMonitorInfo>;
begin
  MonitorsArray := lista_monitores();
  result := MonitorsArray[index];
end;

procedure TfmIndex.monitores(padrao: integer);
var
  qtd_monitores: integer;
  i: Integer;
  item: TMenuItem;
  lista: TStringList;
begin
  qtd_monitores := Screen.MonitorCount;

//Randomize;
//qtd_monitores := 3 + Random(10);

  bsPopupExpand.Items.Clear;
  sbMusicaAreaExtendida.Items.Clear;
  sbMusicaRetornoAreaExtendida.Items.Clear;
  sbVideoOnAreaExtendida.Items.Clear;
  sbPlayerAreaExtendida.Items.Clear;

  lista := TStringList.Create;
  lista.Clear;

  for i := 0 to qtd_monitores-1 do
  begin
    item := TMenuItem.Create(bsPopupExpand);
    item.Caption := 'Monitor '+IntToStr(i+1)+' ('+IntToStr(monitorInfo(i).Width)+'x'+IntToStr(monitorInfo(i).Height)+')';
    item.OnClick := mmPopMonitorClick;
    item.Tag := i;
    item.Checked := (padrao = i);
    item.RadioItem := True;

    bsPopupExpand.Items.Add(item);
    lista.Add(IntToStr(i+1));
  end;

  item := TMenuItem.Create(bsPopupExpand);
  item.Caption := '-';
  item.Tag := -1;
  bsPopupExpand.Items.Add(item);

  item := TMenuItem.Create(bsPopupExpand);
  item.Caption := 'Identificar Monitores';
  item.OnClick := identifica_monitores;
  item.Tag := -1;
  bsPopupExpand.Items.Add(item);

  sbMusicaAreaExtendida.Items := lista;
  sbMusicaRetornoAreaExtendida.Items := lista;
  sbMusicaOperadorAreaExtendida.Items := lista;
  sbVideoOnAreaExtendida.Items := lista;
  sbPlayerAreaExtendida.Items := lista;

  sbMusicaAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'Monitor', '2')) - 1;
  sbMusicaRetornoAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'MonitorRetorno', '3')) - 1;
  sbMusicaOperadorAreaExtendida.ItemIndex := StrToInt(lerParam('Musicas', 'MonitorOperador', '1')) - 1;
  sbVideoOnAreaExtendida.ItemIndex := StrToInt(lerParam('Videos Online', 'Monitor', '2')) - 1;
  sbPlayerAreaExtendida.ItemIndex := StrToInt(lerParam('Player', 'Monitor', '2')) - 1;
end;

procedure TfmIndex.monitor_bt_label(botao: TbsSkinMenuSpeedButton);
var
  monitor: Integer;
  item_config: string;
begin
  item_config := monitor_tp_config(botao);
  monitor := StrToInt(lerParam(item_config, 'Monitor', '2'));
  if botao.Name = 'btExp_MenuMusicas'
    then botao.Caption := 'Projetar Menu (Monitor '+inttostr(monitor)+')'
    else botao.Caption := 'Monitor '+inttostr(monitor);
  botao.Tag := monitor-1;
end;

function TfmIndex.monitor_tp_config(botao: TbsSkinMenuSpeedButton): string;
var
  tp: string;
begin
  tp := '';
       if botao.Name = 'btExp_Biblia' then tp := 'Biblia'
  else if botao.Name = 'btExp_BibliaBusca' then tp := 'Busca Biblica'
  else if botao.Name = 'btExp_EscolaSabatina' then tp := 'Escola Sabatina'
  else if botao.Name = 'btExp_Sorteio' then tp := 'Sorteio'
  else if botao.Name = 'btExp_SorteioNM' then tp := 'Sorteio Nomes'
  else if botao.Name = 'btExp_Cronometro' then tp := 'Cronometro'
  else if botao.Name = 'btExp_PainelD' then tp := 'Painel Dinamico'
  else if botao.Name = 'btExp_TextoInterativo' then tp := 'Texto Interativo'
  else if botao.Name = 'btExp_Relogio' then tp := 'Relogio'
  else if botao.Name = 'btExp_MenuMusicas' then tp := 'Lista Musicas';

  Result := tp;
end;

procedure TfmIndex.MonthCalendar1DblClick(Sender: TObject);
var
  data: TDate;
  id: string;
//  title: string;
  info: TbsSkinEdit;
  arq,dir: string;
begin
  data := MonthCalendar1.Date;
  if (DM.cdsItensAgendados.Locate('CATEGORIA;DATA', VarArrayOf([txtCategoria.Text,data]), [])) then
  begin
    fIniciando.AppCreateForm(TfItensAgendados, fItensAgendados);
    fItensAgendados.id := DM.cdsItensAgendados.FieldByName('ID').AsString;
    fItensAgendados.tipo := 'ITEM';
    fItensAgendados.ShowModal;
    loadCol.Strings.Values['LITURGIA'] := '';
    Exit;
  end;

  arq := openDialog('arquivo', '', 'ItensAgendados', False, '', 'Escolher arquivo para o dia '+formatdatetime('dd/mm/yyyy',data));
  if (arq <> '') then
  begin
    info := TbsSkinEdit.Create(nil);
    dir := verificaURL(arq, info, false);

    id := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    DM.cdsItensAgendados.Append;
    DM.cdsItensAgendados.FieldByName('ID').Value := id;
    DM.cdsItensAgendados.FieldByName('CATEGORIA').Value := txtCategoria.Text;
    DM.cdsItensAgendados.FieldByName('DATA').Value := data;
    DM.cdsItensAgendados.FieldByName('NOME').Value := ChangeFileExt(ExtractFileName(arq),'');
    DM.cdsItensAgendados.FieldByName('ARQUIVO').Value := dir;
    DM.cdsItensAgendados.FieldByName('ARQUIVO_INFO').Value := info.Text;
    DM.cdsItensAgendados.Post;
    refreshCalendar;
  end;
  loadCol.Strings.Values['LITURGIA'] := '';
end;

procedure TfmIndex.MonthCalendar1GetMonthInfo(Sender: TObject; Month: Cardinal;
  var MonthBoldInfo: Cardinal);
var
  dia: Integer;
  dias: array of cardinal;
begin
  SetLength(dias, 0);

  DM.cdsItensAgendadosClone.Filtered := True;
  DM.cdsItensAgendadosClone.Filter := 'CATEGORIA = '''+txtCategoria.Text+''' AND MONTH(DATA) = '+inttostr(Month)+' AND YEAR(DATA) = '+IntToStr(YearOf(MonthCalendar1.Date));
//  DM.cdsItensAgendadosClone.Filter := 'CATEGORIA = '''+txtCategoria.Text+''' AND MONTH(DATA) = '+inttostr(Month)+' AND YEAR(DATA) = '+IntToStr(YearOf(now()));
  if DM.cdsItensAgendadosClone.RecordCount > 0 then
  begin
    DM.cdsItensAgendadosClone.First;
    while not DM.cdsItensAgendadosClone.Eof do
    begin
      dia := StrToInt(FormatDateTime('dd',DM.cdsItensAgendadosClone.FieldByName('DATA').AsDateTime));

      SetLength(dias, Length(dias)+1);
      dias[High(dias)] := dia;

      DM.cdsItensAgendadosClone.Next;
    end;

    MonthCalendar1.BoldDays(dias, MonthBoldInfo);
  end;
end;

procedure TfmIndex.MouseWheel(Direction: string; Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
var
  Pt: TPoint;
  Rct: TRect;
  i: integer;
  Delta: Integer;
  ScrollBox: TbsSkinScrollBox;
  DBCtrlGrid: TDBCtrlGrid;
begin
  GetCursorPos(Pt);

  with Screen.ActiveForm do
  begin
//    if not Active then
//      Exit;

    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i].ClassType = TbsSkinScrollBox then
      begin
        ScrollBox := TbsSkinScrollBox(Components[i]);
        GetWindowRect(ScrollBox.Handle, Rct);
        if (PtInRect(Rct, Pt)) and (ScrollBox.Parent.Visible) then
        begin
          if Direction = 'Up' then
            ScrollBox.VScrollBar.Position := ScrollBox.VScrollBar.Position - 10
          else
            ScrollBox.VScrollBar.Position := ScrollBox.VScrollBar.Position + 10;
        end;
      end
      else if Components[i].ClassType = TDBCtrlGrid then
      begin
        DBCtrlGrid := TDBCtrlGrid(Components[i]);
        GetWindowRect(DBCtrlGrid.Handle, Rct);
        if (PtInRect(Rct, Pt)) and (DBCtrlGrid.Parent.Visible) then
        begin
          SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0,@Delta, 0);
          if not(PtInRect(DBCtrlGrid.ClientRect, DBCtrlGrid.ScreenToClient(MousePos)))
            then Exit;
          if not Assigned(DBCtrlGrid.DataSource)
            then Exit;
          if DBCtrlGrid.DataSource.DataSet = nil
            then Exit;
          if not DBCtrlGrid.DataSource.DataSet.Active
            then Exit;
          if Direction = 'Up' then
            DBCtrlGrid.DataSource.DataSet.moveby(Delta*-1)
          else
            DBCtrlGrid.DataSource.DataSet.moveby(Delta);
        end;
      end;
           (*
      else
      if fmIndex.Components[i].ClassType = TbsRibbon then
      begin
        Ribbon := TbsRibbon(fmIndex.Components[i]);
        GetWindowRect(Ribbon.Handle,Rct);
        if (PtInRect(Rct, Pt)) and (Ribbon.Visible) then
        begin
          if Direction = 'Up' then
          begin
            if Ribbon.TabIndex <= 0 then Exit;
            Ribbon.TabIndex := Ribbon.TabIndex - 1
          end
          else
          begin
            Ribbon.TabIndex := Ribbon.TabIndex + 1;
          end;
          ShowMessage(inttostr(Ribbon.TabIndex));
        end;
      end*);
    end;
  end;
end;

procedure TfmIndex.WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo);
var
  R: TRect;
  P_TL: TPoint;
begin
  inherited;

   // Obtem o retangulo com a area livre do desktop
  SystemParametersInfo(SPI_GETWORKAREA, SizeOf(R), @R, 0);

  P_TL := R.TopLeft;
//  P_TL.Y := P_TL.Y+0;
  Msg.MinMaxInfo^.ptMaxPosition := P_TL;
  OffsetRect(R, -R.Left, -R.Top);
  Msg.MinMaxInfo^.ptMaxSize := R.BottomRight;
end;

procedure TfmIndex.WMNCHitTest(var Msg: TWMNCHitTest);
var
  ScreenPt: TPoint;
begin
  //inherited;
  ScreenPt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
  if (ScreenPt.x < 5) then
    Msg.Result := HTLEFT
    // top side
  else if (ScreenPt.y < 5) then
    Msg.Result := HTTOP
    // right side
  else if (ScreenPt.x >= Width - 5) then
    Msg.Result := HTRIGHT
    // bottom side
  else if (ScreenPt.y >= Height - 5) then
    Msg.Result := HTBOTTOM
    // top left corner
  else if (ScreenPt.x < 5) and (ScreenPt.y < 5) then
    Msg.Result := HTTOPLEFT
    // bottom left corner
  else if (ScreenPt.x < 5) and (ScreenPt.y >= Height - 5) then
    Msg.Result := HTBOTTOMLEFT
    // top right corner
  else if (ScreenPt.x >= Width - 5) and (ScreenPt.y < 5) then
    Msg.Result := HTTOPRIGHT
    // bottom right corner
  else if (ScreenPt.x >= Width - 5) and (ScreenPt.y >= Height - 5) then
    Msg.Result := HTBOTTOMRIGHT
end;

procedure TfmIndex.btOpcResetClick(Sender: TObject);
var
  tag: integer;
  pwd: string;
begin
  pwd := lerParam('Senha', 'Formatacao', '');

  if Trim(pwd) <> '' then
  begin
    application.MessageBox('O administrador do sistema bloqueou o acesso à este recurso! Para continuar, será necessário colocar a senha de acesso!', titulo, mb_ok + MB_ICONINFORMATION);

    DM.pwd.Password := '';
    DM.pwd.Execute;

    if (DM.pwd.Password = '') then
    begin
      TbsSkinSpeedButton(Sender).Down := False;
      exit;
    end;

    if (DM.pwd.Password = pwd)
      then pwd := '';
  end;

  if Trim(pwd) <> '' then
  begin
    application.MessageBox('Senha incorreta!', titulo, mb_ok + mb_iconerror);
    TbsSkinSpeedButton(Sender).Down := False;
    exit;
  end;

  if (application.MessageBox(PChar('Deseja restaurar as configurações?'), titulo, mb_yesno + mb_iconquestion) <> 6) then
    Exit;

  tag := TComponent(Sender).tag;
  if (tag = 1) then
  begin
    apagaParam('Biblia', 'Historico');
    apagaParam('Biblia', 'Fonte');
    apagaParam('Biblia', 'Tamanho');
    apagaParam('Biblia', 'Tamanho Passagem');
    apagaParam('Biblia', 'Cor');
    apagaParam('Biblia', 'Cor Passagem');
    apagaParam('Biblia', 'Cor Fundo');
    apagaParam('Biblia', 'Imagem Fundo');
    apagaParam('Biblia', 'Imagem Fundo - UrlInfo');
    apagaParam('Biblia', 'Posicao Fundo');
    carregaConfiguracoes('BIBLIA');

  end
  else if (tag = 2) then
  begin
    apagaParam('Busca Biblica', 'Fonte');
    apagaParam('Busca Biblica', 'Tamanho');
    apagaParam('Busca Biblica', 'Tamanho Passagem');
    apagaParam('Busca Biblica', 'Cor');
    apagaParam('Busca Biblica', 'Cor Passagem');
    apagaParam('Busca Biblica', 'Cor Fundo');
    apagaParam('Busca Biblica', 'Imagem Fundo');
    apagaParam('Busca Biblica', 'Imagem Fundo - UrlInfo');
    apagaParam('Busca Biblica', 'Posicao Fundo');
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    apagaParam('Escola Sabatina', 'Fonte');
    apagaParam('Escola Sabatina', 'Tamanho');
    apagaParam('Escola Sabatina', 'Cor');
    apagaParam('Escola Sabatina', 'Tamanho 2');
    apagaParam('Escola Sabatina', 'Cor 2');
    apagaParam('Escola Sabatina', 'Cor Fundo');
    apagaParam('Escola Sabatina', 'Imagem Fundo');
    apagaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo');
    apagaParam('Escola Sabatina', 'Posicao Fundo');
    apagaParam('Escola Sabatina', 'FormatoHora');
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    apagaParam('Sorteio', 'Fonte');
    apagaParam('Sorteio', 'Tamanho');
    apagaParam('Sorteio', 'Cor');
    apagaParam('Sorteio', 'Cor Fundo');
    apagaParam('Sorteio', 'Numeros Disponiveis (Extendido)');
    apagaParam('Sorteio', 'Numeros Sorteados (Extendido)');
    apagaParam('Sorteio', 'Imagem Fundo');
    apagaParam('Sorteio', 'Imagem Fundo - UrlInfo');
    apagaParam('Sorteio', 'Posicao Fundo');
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    apagaParam('Cronometro', 'Fonte');
    apagaParam('Cronometro', 'Tamanho');
    apagaParam('Cronometro', 'Cor');
    apagaParam('Cronometro', 'Cor Fundo');
    apagaParam('Cronometro', 'Tempos Gravados (Extendido)');
    apagaParam('Cronometro', 'Tempo Decrescente');
    apagaParam('Cronometro', 'Direcao');
    apagaParam('Cronometro', 'Imagem Fundo');
    apagaParam('Cronometro', 'Imagem Fundo - UrlInfo');
    apagaParam('Cronometro', 'Posicao Fundo');
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    apagaParam('Sorteio Nomes', 'Fonte');
    apagaParam('Sorteio Nomes', 'Tamanho');
    apagaParam('Sorteio Nomes', 'Cor');
    apagaParam('Sorteio Nomes', 'Cor Fundo');
    apagaParam('Sorteio Nomes', 'Numeros Disponiveis (Extendido)');
    apagaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)');
    apagaParam('Sorteio Nomes', 'Imagem Fundo');
    apagaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo');
    apagaParam('Sorteio Nomes', 'Posicao Fundo');
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    apagaParam('Painel Dinamico', 'Fonte');
    apagaParam('Painel Dinamico', 'Tamanho');
    apagaParam('Painel Dinamico', 'Cor');
    apagaParam('Painel Dinamico', 'Cor Fundo');
    apagaParam('Painel Dinamico', 'Imagem Fundo');
    apagaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo');
    apagaParam('Painel Dinamico', 'Posicao Fundo');
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    apagaParam('Relogio', 'Fonte');
    apagaParam('Relogio', 'Tamanho');
    apagaParam('Relogio', 'Cor');
    apagaParam('Relogio', 'Cor Fundo');
    apagaParam('Relogio', 'Imagem Fundo');
    apagaParam('Relogio', 'Imagem Fundo - UrlInfo');
    apagaParam('Relogio', 'Posicao Fundo');
    apagaParam('Relogio', 'FormatoHora');
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.csOpcCorChange(Sender: TObject);
var
  tag: integer;
begin
  if carrega_opc then
    Exit;

  tag := TbsSkinColorButton(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 12) then
  begin
    gravaParam('Biblia', 'Cor Passagem', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 19) then
  begin
    gravaParam('Biblia', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 22) then
  begin
    gravaParam('Busca Biblica', 'Cor Passagem', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 29) then
  begin
    gravaParam('Busca Biblica', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('ES');
  end
  else if (tag = 32) then
  begin
    gravaParam('Escola Sabatina', 'Cor 2', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('ES');
  end
  else if (tag = 33) then
  begin
    gravaParam('Escola Sabatina', 'Cor 3', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('ES');
  end
  else if (tag = 39) then
  begin
    gravaParam('Escola Sabatina', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 49) then
  begin
    gravaParam('Sorteio', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 59) then
  begin
    gravaParam('Cronometro', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 69) then
  begin
    gravaParam('Sorteio Nomes', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 79) then
  begin
    gravaParam('Painel Dinamico', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Cor', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('RELOGIO');
  end
  else if (tag = 99) then
  begin
    gravaParam('Relogio', 'Cor Fundo', ColorToString(TbsSkinColorButton(Sender).ColorValue));
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaBuscaClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] := DM.qrBIBLIA_BUSCA.FieldByName('DESC_PASSAGEM2').AsString;
  lmdBibliaBuscaTxt.Caption := DM.qrBIBLIA_BUSCA.FieldByName('PASSAGEM').AsString;
  lmdBibliaBuscaInfo.Caption := DM.qrBIBLIA_BUSCA.FieldByName('DESC_PASSAGEM2').AsString;

  ajustaTexto('BIBLIA_BUSCA');
  copiaDadosTelaExtendida;

  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaBuscaTxt.Caption);
     fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaBuscaInfo.Caption);
  end;

  DBCtrlGridBibliaBusca.Refresh;
  DBCtrlGridBibliaBuscaPaintPanel(DBCtrlGridBibliaBusca,0, nil, Rect(1, 1, DBCtrlGridBibliaBusca.PanelWidth-2, DBCtrlGridBibliaBusca.PanelHeight-2));
end;

procedure TfmIndex.DBCtrlGridBibliaBuscaPaintPanel(
  DBCtrlGrid: TbsSkinDBCtrlGrid; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.PanelWidth-2, DBCtrlGrid.PanelHeight-2);

    if (loadCol.Strings.Values['BIBLIA_BUSCA_INFO'] = DBCtrlGrid.DataSource.DataSet.FieldByName('DESC_PASSAGEM2').AsString) then
    begin
      txtBibliaBusca.Font.Color := $002E2E2E;
      txtBibliaBusca.DefaultFont.Color := $002E2E2E;
      txtBibliaBuscaPassagem.Font.Color := $002E2E2E;
      txtBibliaBuscaPassagem.DefaultFont.Color := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtBibliaBusca.Font.Color := clWhite;
      txtBibliaBusca.DefaultFont.Color := clWhite;
      txtBibliaBuscaPassagem.Font.Color := clWhite;
      txtBibliaBuscaPassagem.DefaultFont.Color := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00282828;
    end;

    DBCtrlGridBibliaBusca_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaCapituloClick(Sender: TObject);
begin
  if (loadCol.Strings.Values['BIBLIA_LIVRO'] = loadCol.Strings.Values['BIBLIA_P_LIVRO']) and
     (DBCtrlGridBibliaCapitulo.DataSource.DataSet.FieldByName('CAPITULO').AsString = loadCol.Strings.Values['BIBLIA_P_CAPITULO']) then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  end
  else if (loadCol.Strings.Values['BIBLIA_CAPITULO'] <> DBCtrlGridBibliaCapitulo.DataSource.DataSet.FieldByName('CAPITULO').AsString) then
  begin
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '1';
  end;

  loadCol.Strings.Values['BIBLIA_CAPITULO'] := DBCtrlGridBibliaCapitulo.DataSource.DataSet.FieldByName('CAPITULO').AsString;
  if (loadCol.Strings.Values['BIBLIA_CAPITULO'] <> '') then
    busBibliaCapitulo.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_CAPITULO'])-1;
  DBCtrlGridBibliaCapitulo.Refresh;
  DBCtrlGridBibliaCapituloPaintPanel(DBCtrlGridBibliaCapitulo,StrToInt('0'+loadCol.Strings.Values['BIBLIA_CAPITULO']),nil,Rect(1, 1, DBCtrlGridBibliaCapitulo.PanelWidth-2, DBCtrlGridBibliaCapitulo.PanelHeight-2));

  carregaBiblia('VSC');
end;

procedure TfmIndex.DBCtrlGridBibliaCapituloPaintPanel(
  DBCtrlGrid: TbsSkinDBCtrlGrid; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.PanelWidth-2, DBCtrlGrid.PanelHeight-2);

    if (StrToInt('0'+loadCol.Strings.Values['BIBLIA_CAPITULO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('CAPITULO').AsInteger) then
    begin
      txtdbBibliaCapitulo.Font.Color := $002E2E2E;
      txtdbBibliaCapitulo.DefaultFont.Color := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtdbBibliaCapitulo.Font.Color := clWhite;
      txtdbBibliaCapitulo.DefaultFont.Color := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00000070;
    end;

    DBCtrlGridBibliaCapitulo_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaHistoricoClick(Sender: TObject);
var
  key : Char;
  BIBLIA_VERSAO,BIBLIA_LIVRO,BIBLIA_CAPITULO,BIBLIA_VERSICULO: string;
begin
  BIBLIA_VERSAO := DBCtrlGridBibliaHistorico.DataSource.DataSet.FieldByName('VERSAO').AsString;
  BIBLIA_LIVRO := DBCtrlGridBibliaHistorico.DataSource.DataSet.FieldByName('LIVRO').AsString;
  BIBLIA_CAPITULO := DBCtrlGridBibliaHistorico.DataSource.DataSet.FieldByName('CAPITULO').AsString;
  BIBLIA_VERSICULO := DBCtrlGridBibliaHistorico.DataSource.DataSet.FieldByName('VERSICULO').AsString;

  if trim(BIBLIA_VERSAO) = '' then Exit;


  dblBibVersao.KeyValue := BIBLIA_VERSAO;
  loadCol.Strings.Values['BIBLIA_VERSAO'] := dblBibVersao.KeyValue;

  DM.qrBIBLIA_LIVROS.Locate('ID',BIBLIA_LIVRO,[]);
  DBCtrlGridBibliaLivroClick(Sender);

  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',BIBLIA_CAPITULO,[]);
  DBCtrlGridBibliaCapituloClick(Sender);

  busBibliaVersiculo.Text := BIBLIA_VERSICULO;
  key := Char(13);
  busBibliaVersiculoKeyPress(Sender,key);
  busBibliaVersiculo.Text := '';

  DBCtrlGridBibliaHistorico.Refresh;
  DBCtrlGridBibliaHistoricoPaintPanel(DBCtrlGridBibliaHistorico,0,nil,Rect(1, 1, DBCtrlGridBibliaHistorico.PanelWidth-2, DBCtrlGridBibliaHistorico.PanelHeight-2));
end;

procedure TfmIndex.DBCtrlGridBibliaHistoricoPaintPanel(
  DBCtrlGrid: TbsSkinDBCtrlGrid; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.PanelWidth-2, DBCtrlGrid.PanelHeight-2);

    if (loadCol.Strings.Values['BIBLIA_P_VERSICULO'] = DBCtrlGrid.DataSource.DataSet.FieldByName('VERSICULO').AsString) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_CAPITULO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('CAPITULO').AsInteger) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_LIVRO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('LIVRO').AsInteger) and
       (loadCol.Strings.Values['BIBLIA_P_VERSAO'] = DBCtrlGrid.DataSource.DataSet.FieldByName('VERSAO').AsString) then
    begin
      txtBibliaHistorico.Font.Color := $002E2E2E;
      txtBibliaHistorico.DefaultFont.Color := $002E2E2E;
      txtBibliaHistoricoPassagem.Font.Color := $002E2E2E;
      txtBibliaHistoricoPassagem.DefaultFont.Color := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtBibliaHistorico.Font.Color := clWhite;
      txtBibliaHistorico.DefaultFont.Color := clWhite;
      txtBibliaHistoricoPassagem.Font.Color := clWhite;
      txtBibliaHistoricoPassagem.DefaultFont.Color := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $002E2E2E;
    end;

    DBCtrlGridBibliaHistorico_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaLivroClick(Sender: TObject);
begin
  if (DBCtrlGridBibliaLivro.DataSource.DataSet.FieldByName('ID').AsString = loadCol.Strings.Values['BIBLIA_P_LIVRO']) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  end
  else if (loadCol.Strings.Values['BIBLIA_LIVRO'] <> DBCtrlGridBibliaLivro.DataSource.DataSet.FieldByName('ID').AsString) then
  begin
    loadCol.Strings.Values['BIBLIA_CAPITULO'] := '1';
    loadCol.Strings.Values['BIBLIA_VERSICULO'] := '1';
  end;

  loadCol.Strings.Values['BIBLIA_LIVRO'] := DBCtrlGridBibliaLivro.DataSource.DataSet.FieldByName('ID').AsString;
  loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'] := DBCtrlGridBibliaLivro.DataSource.DataSet.FieldByName('SIGLA').AsString;
  loadCol.Strings.Values['BIBLIA_LIVRO_NOME'] := DBCtrlGridBibliaLivro.DataSource.DataSet.FieldByName('LIVRO').AsString;
  busBibliaLivro.ItemIndex := StrToInt(loadCol.Strings.Values['BIBLIA_LIVRO'])-1;
  DBCtrlGridBibliaLivro.Refresh;
  DBCtrlGridBibliaLivroPaintPanel(DBCtrlGridBibliaLivro,StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']),nil,Rect(1, 1,DBCtrlGridBibliaLivro.PanelWidth-2, DBCtrlGridBibliaLivro.PanelHeight-2));

  carregaBiblia('CAP');
  DM.qrBIBLIA_CAPITULOS.Locate('CAPITULO',loadCol.Strings.Values['BIBLIA_CAPITULO'],[]);
  DBCtrlGridBibliaCapituloClick(Sender);
end;

procedure TfmIndex.DBCtrlGridBibliaLivroPaintPanel(
  DBCtrlGrid: TbsSkinDBCtrlGrid; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.PanelWidth-2, DBCtrlGrid.PanelHeight-2);

    txtdbBibliaLivroNm.Visible := (DBCtrlGrid.DataSource.DataSet.FieldByName('SIGLA_N').AsString <> '');
    if (StrToInt('0'+loadCol.Strings.Values['BIBLIA_LIVRO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('ID').AsInteger) then
    begin
      txtdbBibliaLivroSg.Font.Color := $002E2E2E;
      txtdbBibliaLivroSg.DefaultFont.Color := $002E2E2E;
      txtdbBibliaLivro.Font.Color := $002E2E2E;
      txtdbBibliaLivro.DefaultFont.Color := $002E2E2E;
      txtdbBibliaLivroNm.Font.Color := $002E2E2E;
      txtdbBibliaLivroNm.DefaultFont.Color := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      DBCtrlGrid.Canvas.Brush.Color := StringToColor(DBCtrlGrid.DataSource.DataSet.FieldByName('COR').AsString);

      txtdbBibliaLivroSg.Font.Color := clWhite;
      txtdbBibliaLivroSg.DefaultFont.Color := clWhite;
      txtdbBibliaLivro.Font.Color := clWhite;
      txtdbBibliaLivro.DefaultFont.Color := clWhite;
      txtdbBibliaLivroNm.Font.Color := clWhite;
      txtdbBibliaLivroNm.DefaultFont.Color := clWhite;
    end;

    DBCtrlGridBibliaLivro_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.DBCtrlGridBibliaVersiculoClick(Sender: TObject);
begin
  loadCol.Strings.Values['BIBLIA_VERSICULO'] := DBCtrlGridBibliaVersiculo.DataSource.DataSet.FieldByName('VERSICULO').AsString;

  loadCol.Strings.Values['BIBLIA_P_VERSAO'] := loadCol.Strings.Values['BIBLIA_VERSAO'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO'] := loadCol.Strings.Values['BIBLIA_LIVRO'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA'] := loadCol.Strings.Values['BIBLIA_LIVRO_SIGLA'];
  loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME'] := loadCol.Strings.Values['BIBLIA_LIVRO_NOME'];
  loadCol.Strings.Values['BIBLIA_P_CAPITULO'] := loadCol.Strings.Values['BIBLIA_CAPITULO'];
  loadCol.Strings.Values['BIBLIA_P_VERSICULO'] := loadCol.Strings.Values['BIBLIA_VERSICULO'];

  lmdBibliaTxt.Caption := '"'+removeTagsHTML(DBCtrlGridBibliaVersiculo.DataSource.DataSet.FieldByName('PASSAGEM_ORI').AsString)+'"';
  lmdBibliaInfo.Caption := loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']+' '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
  if (fTransmitir.btServidor.ImageIndex <> 8) then
  begin
     fmIndex.gravaParamServer('BIBLIA', 'texto', lmdBibliaTxt.Caption);
     fmIndex.gravaParamServer('BIBLIA', 'info', lmdBibliaInfo.Caption);
  end;
  ajustaTexto('BIBLIA');
  copiaDadosTelaExtendida;

  gravaParam('Biblia', 'Versão',loadCol.Strings.Values['BIBLIA_P_VERSAO']);
  gravaParam('Biblia', 'Livro',loadCol.Strings.Values['BIBLIA_P_LIVRO']);
  gravaParam('Biblia', 'Livro Sigla',loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']);
  gravaParam('Biblia', 'Livro Nome',loadCol.Strings.Values['BIBLIA_P_LIVRO_NOME']);
  gravaParam('Biblia', 'Capitulo',loadCol.Strings.Values['BIBLIA_P_CAPITULO']);
  gravaParam('Biblia', 'Versiculo',loadCol.Strings.Values['BIBLIA_P_VERSICULO']);

  if (DM.cdsBIBLIA_HISTORICO.Locate('VERSAO;LIVRO;CAPITULO;VERSICULO', VarArrayOf([loadCol.Strings.Values['BIBLIA_P_VERSAO'],loadCol.Strings.Values['BIBLIA_P_LIVRO'],loadCol.Strings.Values['BIBLIA_P_CAPITULO'],loadCol.Strings.Values['BIBLIA_P_VERSICULO']]), [])) then
  begin
    DM.cdsBIBLIA_HISTORICO.Edit;
  end
  else
  begin
    DM.cdsBIBLIA_HISTORICO.Append;
    DM.cdsBIBLIA_HISTORICO.FieldByName('ID').Value := FormatDateTime('ddmmyyyyhhnnsszzz', Now);
    DM.cdsBIBLIA_HISTORICO.FieldByName('DATAHORA').Value := Now;
  end;
  DM.cdsBIBLIA_HISTORICO.FieldByName('VERSAO').Value := loadCol.Strings.Values['BIBLIA_P_VERSAO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('LIVRO').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('CAPITULO').Value := loadCol.Strings.Values['BIBLIA_P_CAPITULO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('VERSICULO').Value := loadCol.Strings.Values['BIBLIA_P_VERSICULO'];
  DM.cdsBIBLIA_HISTORICO.FieldByName('PASSAGEM').Value := DBCtrlGridBibliaVersiculo.DataSource.DataSet.FieldByName('PASSAGEM_ORI').AsString;
  DM.cdsBIBLIA_HISTORICO.FieldByName('DESC_PASSAGEM').Value := loadCol.Strings.Values['BIBLIA_P_LIVRO_SIGLA']+'. '+loadCol.Strings.Values['BIBLIA_P_CAPITULO']+':'+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+' ('+loadCol.Strings.Values['BIBLIA_P_VERSAO']+')';
  DM.cdsBIBLIA_HISTORICO.Post;


  DBCtrlGridBibliaVersiculo.Refresh;
  DBCtrlGridBibliaVersiculoPaintPanel(DBCtrlGridBibliaVersiculo,StrToInt('0'+loadCol.Strings.Values['BIBLIA_VERSICULO']),nil,Rect(1, 1, DBCtrlGridBibliaVersiculo.PanelWidth-2, DBCtrlGridBibliaVersiculo.PanelHeight-2));
end;

procedure TfmIndex.DBCtrlGridBibliaVersiculoPaintPanel(
  DBCtrlGrid: TbsSkinDBCtrlGrid; Index: Integer; Cnvs: TCanvas; ClRect: TRect);
var
  R: TRect;
begin
  try
    R:= Rect(1, 1, DBCtrlGrid.PanelWidth-2, DBCtrlGrid.PanelHeight-2);

    if (Pos(','+DBCtrlGrid.DataSource.DataSet.FieldByName('VERSICULO').AsString+',',','+loadCol.Strings.Values['BIBLIA_P_VERSICULO']+',') > 0) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_CAPITULO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('CAPITULO').AsInteger) and
       (StrToInt('0'+loadCol.Strings.Values['BIBLIA_P_LIVRO']) = DBCtrlGrid.DataSource.DataSet.FieldByName('LIVRO').AsInteger) then
    begin
      txtdbBibliaVersiculo.Font.Color := $002E2E2E;
      txtdbBibliaVersiculo.DefaultFont.Color := $002E2E2E;
      txtdbBibliaVersiculoTxt.Font.Color := $002E2E2E;
      txtdbBibliaVersiculoTxt.DefaultFont.Color := $002E2E2E;
      DBCtrlGrid.Canvas.Brush.Color := clWhite;
    end
    else
    begin
      txtdbBibliaVersiculo.Font.Color := clWhite;
      txtdbBibliaVersiculo.DefaultFont.Color := clWhite;
      txtdbBibliaVersiculoTxt.Font.Color := clWhite;
      txtdbBibliaVersiculoTxt.DefaultFont.Color := clWhite;
      DBCtrlGrid.Canvas.Brush.Color := $00282828;
    end;

    DBCtrlGridBibliaVersiculo_pnl.Color := DBCtrlGrid.Canvas.Brush.Color;
//    DBCtrlGrid.Canvas.FillRect(R);
//    if DBCtrlGrid.PanelIndex = Index then
//      DBCtrlGrid.Canvas.DrawFocusRect(R);
  except
    //
  end;
end;

procedure TfmIndex.dbctrlMusicasClick(Sender: TObject);
var
  tag: integer;
  QUERY: TFDQuery;
  txt: string;
begin
  tag := TComponent(Sender).tag;

  if (tag < 10) then
  begin
    QUERY := DM.qrMUSICAS;
  end
  else if (tag < 20) then
  begin
    tag := tag-10;
    QUERY := DM.qrMUSICAS_INFANTIS;
  end
  else
    QUERY := nil;

  if (QUERY.FieldByName('ID').AsString = '') then Exit;

  if (tag = 4) then
    abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL').AsString)
  else if (tag = 5) then
  begin
    if (QUERY.FieldByName('URL_INSTRUMENTAL').AsString = '') then
    begin
//      application.MessageBox(PChar('Esta música não possui playback. Será aberto o áudio cantado!'), titulo, mb_ok + MB_ICONEXCLAMATION);
      application.MessageBox(PChar('Esta música não possui playback!'), titulo, mb_ok + MB_ICONEXCLAMATION);
//      abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL').AsString)
    end
    else abreArquivoMusica(QUERY.FieldByName('ID').AsInteger,QUERY.FieldByName('ALBUM').AsString,QUERY.FieldByName('URL_INSTRUMENTAL').AsString);
  end
  else if (tag = 6) then
    abreLetra(QUERY.FieldByName('ID').AsInteger)
  else
  begin
    if (Tag = 2)
      then txt := 'PB'
      else txt := '';
    abreLetraMusica('BD',txt,QUERY.FieldByName('ID').AsInteger,(tag < 3));
  end;
end;

procedure TfmIndex.fcOpcFonteChange(Sender: TObject);
var
  tag: integer;
begin
  if carrega_opc then
    Exit;

  tag := TbsSkinFontComboBox(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Fonte', TbsSkinFontComboBox(Sender).FontName);
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.fcTxtIChange(Sender: TObject);
var
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  tag := TbsSkinFontComboBox(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));
  RichEdit.SelAttributes.Name := TbsSkinFontComboBox(Sender).FontName;
end;

procedure TfmIndex.seOpcTamanhoChange(Sender: TObject);
var
  tag: integer;
begin
 if carrega_opc then
    Exit;

  TbsSkinComboBox(Sender).Text := Trim(TbsSkinComboBox(Sender).Text);
  if Trim(TbsSkinComboBox(Sender).Text) = '' then
    Exit;
  //if StrToInt(TbsSkinComboBox(Sender).Text) < 10 then
  //  Exit;

  tag := TbsSkinComboBox(Sender).tag;
  if (tag = 1) then
  begin
    gravaParam('Biblia', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 12) then
  begin
    gravaParam('Biblia', 'Tamanho Passagem', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    gravaParam('Busca Biblica', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 22) then
  begin
    gravaParam('Busca Biblica', 'Tamanho Passagem', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    gravaParam('Escola Sabatina', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('ES');
  end
  else if (tag = 32) then
  begin
    gravaParam('Escola Sabatina', 'Tamanho 2', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    gravaParam('Sorteio', 'Tamanho', FloatToStr(TbsSkinSpinEdit(Sender).Value));
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    gravaParam('Cronometro', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    gravaParam('Sorteio Nomes', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    gravaParam('Painel Dinamico', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    gravaParam('Relogio', 'Tamanho', TbsSkinComboBox(Sender).Text);
    carregaConfiguracoes('RELOGIO');
  end;
end;

procedure TfmIndex.seSorteioTempoChange(Sender: TObject);
begin
  gravaParam('Sorteio', 'TempoAnimacao', FloatToStr(seSorteioTempo.Value));
end;

procedure TfmIndex.seSorteioTempoNMChange(Sender: TObject);
begin
  gravaParam('Sorteio Nomes', 'TempoAnimacao', FloatToStr(seSorteioTempoNM.Value));
end;

procedure TfmIndex.seTxtITamanhoChange(Sender: TObject);
var
  tag: Integer;
  RichEdit:TbsSkinRichEdit;
begin
  tag := TbsSkinComboBox(Sender).Tag;
  RichEdit := TbsSkinRichEdit(FindComponent('RichEdit'+inttostr(tag)));

  TbsSkinComboBox(Sender).Text := Trim(TbsSkinComboBox(Sender).Text);
  if Trim(TbsSkinComboBox(Sender).Text) = '' then
    Exit;

  RichEdit.SelAttributes.Size := StrToInt(TbsSkinComboBox(Sender).Text);
end;

procedure TfmIndex.ShowTrackMenu(Sender: TObject);
var
  tag: integer;
begin
  botao_trmenu := TbsSkinMenuSpeedButton(Sender);
  tag := botao_trmenu.tag;
  monitores(tag);
end;

function TfmIndex.ColorToHtml(DColor: TColor): string;
var
  tmpRGB: TColorRef;
begin
  tmpRGB := ColorToRGB(DColor);
  Result := Format('#%.2x%.2x%.2x', [GetRValue(tmpRGB), GetGValue(tmpRGB), GetBValue(tmpRGB)]);
end;

procedure TfmIndex.cgEscSBAudioClick(Sender: TObject);
begin
  if carrega_opc then
    Exit;

  if cgEscSBAudio.ItemChecked[0] then
    gravaParam('Escola Sabatina', 'Abertura', '1')
  else
    gravaParam('Escola Sabatina', 'Abertura', '0');

  if cgEscSBAudio.ItemChecked[1] then
    gravaParam('Escola Sabatina', '5 min.', '1')
  else
    gravaParam('Escola Sabatina', '5 min.', '0');

  if cgEscSBAudio.ItemChecked[2] then
    gravaParam('Escola Sabatina', '1 min.', '1')
  else
    gravaParam('Escola Sabatina', '1 min.', '0');

end;

procedure TfmIndex.ckFadeFormClick(Sender: TObject);
begin
  if ckFadeForm.Checked then
    gravaParam('Config', 'FadeForm', '1')
  else
    gravaParam('Config', 'FadeForm', '0');
end;

procedure TfmIndex.ckFundoTransparenteClick(Sender: TObject);
begin
  if ckFundoTransparente.Checked then
    gravaParam('Musicas', 'FundoTelaTransparente', '1')
  else
    gravaParam('Musicas', 'FundoTelaTransparente', '0');
  bsFormatSlideImgPerso2.Visible := (not ckFundoTransparente.Checked);
end;

procedure TfmIndex.ckgColetaneasClick(Sender: TObject);
begin
  if carrega_opc then exit;
  txtBuscaChange(Sender);

  if ckgColetaneas.ItemChecked[0] then
    gravaParam('Busca', 'Baixadas', '1')
  else
    gravaParam('Busca', 'Baixadas', '0');

  if ckgColetaneas.ItemChecked[1] then
    gravaParam('Busca', 'Web', '1')
  else
    gravaParam('Busca', 'Web', '0');

  if ckgColetaneas.ItemChecked[2] then
    gravaParam('Busca', 'Personalizadas', '1')
  else
    gravaParam('Busca', 'Personalizadas', '0');
end;

procedure TfmIndex.ckgFiltrosClick(Sender: TObject);
begin
  if carrega_opc then exit;
  txtBuscaChange(Sender);

  if ckgFiltros.ItemChecked[0] then
    gravaParam('Busca', 'Filtro 1', '1')
  else
    gravaParam('Busca', 'Filtro 1', '0');

  if ckgFiltros.ItemChecked[1] then
    gravaParam('Busca', 'Filtro 2', '1')
  else
    gravaParam('Busca', 'Filtro 2', '0');

  if ckgFiltros.ItemChecked[2] then
    gravaParam('Busca', 'Filtro 3', '1')
  else
    gravaParam('Busca', 'Filtro 3', '0');

end;

procedure TfmIndex.ckLivros2ClickCheck(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ckLivros2.Items.Count - 1 do
    ckLivros.Checked[i] := ckLivros2.checked[i];
end;

procedure TfmIndex.ckLivrosClickCheck(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ckLivros.Items.Count - 1 do
    ckLivros2.Checked[i] := ckLivros.checked[i];
end;

procedure TfmIndex.btOpcFileNameEditEnter(Sender: TObject);
var
  btOpcFileNameEditInfo: TbsSkinFileEdit;
begin
  if carrega_opc then
    Exit;

  btOpcFileNameEditInfo := TbsSkinFileEdit(FindComponent(TbsSkinFileEdit(Sender).Name + 'Info'));
  TbsSkinFileEdit(Sender).Text := verificaURL(TbsSkinFileEdit(Sender).Text, btOpcFileNameEditInfo, true);
end;

procedure TfmIndex.btOpcFileNameEditExit(Sender: TObject);
var
  tag: integer;
  btOpcFileNameEditInfo: TbsSkinFileEdit;
begin
  if carrega_opc then
    Exit;

  btOpcFileNameEditInfo := TbsSkinFileEdit(FindComponent(TbsSkinFileEdit(Sender).Name + 'Info'));
  TbsSkinFileEdit(Sender).Text := StringReplace(TbsSkinFileEdit(Sender).Text, '|', '', [rfIgnoreCase, rfReplaceAll]);
  TbsSkinFileEdit(Sender).Text := verificaURL(TbsSkinFileEdit(Sender).Text, btOpcFileNameEditInfo, false);

  tag := TbsSkinFileEdit(Sender).tag;
  if (tag = 1) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Biblia', 'Imagem Fundo');
      apagaParam('Biblia', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Biblia', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Biblia', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('BIBLIA');
  end
  else if (tag = 2) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Busca Biblica', 'Imagem Fundo');
      apagaParam('Busca Biblica', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Busca Biblica', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Busca Biblica', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('BIBLIA_BUSCA');
  end
  else if (tag = 3) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Escola Sabatina', 'Imagem Fundo');
      apagaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Escola Sabatina', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Escola Sabatina', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('ES');
  end
  else if (tag = 4) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Sorteio', 'Imagem Fundo');
      apagaParam('Sorteio', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Sorteio', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Sorteio', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('SORTEIO');
  end
  else if (tag = 5) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Cronometro', 'Imagem Fundo');
      apagaParam('Cronometro', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Cronometro', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Cronometro', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('CRONO');
  end
  else if (tag = 6) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Sorteio Nomes', 'Imagem Fundo');
      apagaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Sorteio Nomes', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Sorteio Nomes', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('SORTEIO_NOMES');
  end
  else if (tag = 7) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Painel Dinamico', 'Imagem Fundo');
      apagaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Painel Dinamico', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Painel Dinamico', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('PAINELD');
  end
  else if (tag = 9) then
  begin
    if (TbsSkinFileEdit(Sender).Text = '') then
    begin
      apagaParam('Relogio', 'Imagem Fundo');
      apagaParam('Relogio', 'Imagem Fundo - UrlInfo');
    end
    else
    begin
      gravaParam('Relogio', 'Imagem Fundo', TbsSkinFileEdit(Sender).Text);
      gravaParam('Relogio', 'Imagem Fundo - UrlInfo', btOpcFileNameEditInfo.Text);
    end;
    carregaConfiguracoes('RELOGIO');
  end;

  copiaDadosTelaExtendida();
end;

procedure TfmIndex.txtCapaColet2Enter(Sender: TObject);
begin
  txtCapaColet2.Text := verificaURL(txtCapaColet2.Text, txtImgInfoColet2, true);
end;

procedure TfmIndex.txtCapaColet2Exit(Sender: TObject);
begin
  txtCapaColet2.Text := verificaURL(txtCapaColet2.Text, txtImgInfoColet2);
end;

procedure TfmIndex.txtCapaColetEnter(Sender: TObject);
begin
  txtCapaColet.Text := verificaURL(txtCapaColet.Text, txtImgInfoColet, true);
end;

procedure TfmIndex.txtCapaColetExit(Sender: TObject);
begin
  txtCapaColet.Text := verificaURL(txtCapaColet.Text, txtImgInfoColet);
end;

function TfmIndex.HtmlToColor(Color: string): String;
begin
  Color := StringReplace(Color,'#', '', [rfIgnoreCase, rfReplaceAll]);
  if (Color <> '')
    then Result := '$0' + Copy(Color, 5, 2) + Copy(Color, 3, 2) + Copy(Color, 1, 2)
    else Result := '';
end;

procedure TfmIndex.identifica_monitores(Sender: TObject);
var
  form: TfIdentificaMonitores;
  qtd_monitores: integer;
  i: Integer;
begin
  carrega_monitores();
  monitores();
  qtd_monitores := Screen.MonitorCount;

  for i := 0 to qtd_monitores-1 do
  begin
    if i > Screen.MonitorCount-1
      then Continue;

    form := TfIdentificaMonitores.Create(Self);
    form.Show;
    form.Top := monitorInfo(i).Top;
    form.Left := monitorInfo(i).Left;
    form.rotulo.Caption := IntToStr(i+1);
    form.detalhes.Caption := IntToStr(monitorInfo(i).Width) + ' x ' + IntToStr(monitorInfo(i).Height);
    form.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmIndex.ImpExpClick(Sender: TObject);
var
  tag: integer;
  arquivo,descricao: string;
  arquivos: array[0..6] of string;
  arq: string;
begin
  tag := TComponent(Sender).Tag;
  arquivos[0] := 'config'+fIniciando.LANG+'.ja';
  arquivos[1] := 'coletaneasUsuario.xml';
  arquivos[2] := 'videosOnUsuario.xml';
  arquivos[3] := 'liturgia.ja';
  arquivos[4] := 'favoritos.xml';
  arquivos[5] := 'itensAgendadosCategorias.xml';
  arquivos[6] := 'itensAgendados.xml';

  arquivo := '';
  descricao := '';
  case tag of
    101, 102: begin arquivo := arquivos[0];descricao := 'Arquivo de Configuração'; end;
    111, 112: begin arquivo := arquivos[1];descricao := 'Arquivo de Coletâneas Personalizadas'; end;
    121, 122: begin arquivo := arquivos[2];descricao := 'Arquivo de Vídeos Online Personalizados'; end;
    131, 132: begin arquivo := arquivos[3];descricao := 'Arquivo de Liturgia'; end;
    141, 142: begin arquivo := arquivos[4];descricao := 'Arquivo de Favoritos'; end;
    151, 152: begin arquivo := arquivos[5];descricao := 'Arquivo de Categorias de Itens Agendados'; end;
    161, 162: begin arquivo := arquivos[6];descricao := 'Arquivo de Itens Agendados'; end;
  end;

  if (tag = 101) or (tag = 111) or (tag = 121) or
     (tag = 131) or (tag = 141) or (tag = 151) or (tag = 161) then
  begin
    if (application.MessageBox('Atenção: O arquivo importado irá sobrepor os dados atuais do sistema. Deseja continuar?',fmIndex.TITULO,mb_yesno+MB_ICONQUESTION) = 6) then
    begin
      arq := openDialog('arquivo', descricao+' ('+arquivo+')|'+arquivo, '',false,'','',arquivo);
      if arq <> '' then
      begin
        CopyFile(PChar(arq),PChar(dir_dados+ExtractFileName(arq)),false);
        application.MessageBox('Arquivo importado com sucesso!'+#13#10+'O sistema será reiniciado para que as novas configurações tenham efeito!',TITULO,mb_ok+mb_iconinformation);

        ShellExecute(Handle,'open', PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
        Application.Terminate;
      end;
    end;
  end
  else
  if (tag = 102) or (tag = 112) or (tag = 122) or
     (tag = 132) or (tag = 142) or (tag = 152) or (tag = 162) then
  begin
    if not (FileExists(dir_dados+ExtractFileName(arquivo))) then
    begin
      application.MessageBox(PChar('Não há dados para serem exportados!'),TITULO,mb_ok+mb_iconexclamation);
    end
    else
    begin
      application.MessageBox(PChar('Selecione o diretório onde deverá ser salvo o arquivo '''+arquivo+'''!'),TITULO,mb_ok+mb_iconinformation);
      arq := openDialog('pasta');
      if arq <> '' then
      begin
        CopyFile(PChar(dir_dados+ExtractFileName(arquivo)),PChar(arq+'\'+arquivo),false);
        application.MessageBox(PChar('Arquivo '''+arquivo+''' exportado com sucesso!'),TITULO,mb_ok+mb_iconinformation);
      end;
    end;
  end;
end;

procedure TfmIndex.importColetaneasPerso;
var
  url: string;
begin
  DM.cdsCOLETANEAS_PERSO_IMP.Close;
  if not DM.cdsCOLETANEAS_PERSO_IMP.Active then
  begin
    DM.cdsCOLETANEAS_PERSO_IMP.CreateDataSet;
    DM.cdsCOLETANEAS_PERSO_IMP.IndexName := '';
    DM.cdsCOLETANEAS_PERSO_IMP.IndexFieldNames := 'NOME';
    DM.cdsCOLETANEAS_PERSO_IMP.LogChanges := False;
  end;

  if (FileExists(dir_dados + 'coletaneasUsuario.xml')) then
    DM.cdsCOLETANEAS_PERSO_IMP.LoadFromFile(dir_dados + 'coletaneasUsuario.xml');
  DM.cdsCOLETANEAS_PERSO_IMP.Open;

  DM.qrDEL_COLETANEAS_PERSO.ExecSQL;

  DM.cdsCOLETANEAS_PERSO_IMP.First;
  while not DM.cdsCOLETANEAS_PERSO_IMP.Eof do
  begin
    url := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('URL').AsString;
    if (DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('URL_INFO').AsString = 'I')
      then url := ExtractFilePath(Application.ExeName) + url;

    DM.qrADD_COLETANEAS_PERSO.Close;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('ID').Value := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('ID').AsString;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('NOME').Value := DM.cdsCOLETANEAS_PERSO_IMP.FieldByName('NOME').AsString;
    DM.qrADD_COLETANEAS_PERSO.ParamByName('URL').Value := url;
    DM.qrADD_COLETANEAS_PERSO.ExecSQL;


    DM.cdsCOLETANEAS_PERSO_IMP.Next;
  end;
end;

procedure TfmIndex.inputOpenDialog(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('arquivo', TbsSkinFileEdit(Sender).Filter,'',False,ExtractFileDir(TbsSkinFileEdit(Sender).Text));
  if arq <> '' then TbsSkinFileEdit(Sender).Text := arq;
end;

procedure TfmIndex.inputOpenPictureDialog(Sender: TObject);
var
  arq: string;
begin
  arq := openDialog('imagem', TbsSkinFileEdit(Sender).Filter,'',False,ExtractFileDir(TbsSkinFileEdit(Sender).Text));
  if arq <> '' then TbsSkinFileEdit(Sender).Text := arq;
end;

procedure TfmIndex.usaFontes(usar: boolean);
var
  dir: string;
begin
  dir := dir_config+'fontes/';
  if usar then
  begin
    if not FonteExiste('DIN Condensed')
      then AddFontResource(PChar(dir+'din-condensed-bold.ttf'))
  end
  else RemoveFontResource(PChar(dir+'din-condensed-bold.ttf'));
end;

end.
