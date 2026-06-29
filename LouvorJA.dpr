program LouvorJA;

uses
  ShareMem,
  XPMan,
  Forms,
  fmMenu in 'fmMenu.pas' {fmIndex},
  fmLetra in 'fmLetra.pas' {fLetra},
  fmNovaVersao in 'fmNovaVersao.pas' {fNovaVersao},
  fmAtualiza in 'fmAtualiza.pas' {fAtualiza},
  fmHelp in 'fmHelp.pas' {fHelp},
  fmVideoOn in 'fmVideoOn.pas' {fVideoOn},
  Vcl.Themes,
  Vcl.Styles,
  fmFavoritos in 'fmFavoritos.pas' {fFavoritos},
  fmMusica in 'fmMusica.pas' {fMusica},
  bass in 'components\bass24\delphi\bass.pas',
  fmListaMusica in 'fmListaMusica.pas' {fListaMusica},
  fmMusicaOperador in 'fmMusicaOperador.pas' {fMusicaOperador},
  fmLiturgia in 'fmLiturgia.pas' {fLiturgia},
  fmArquivosFalta in 'fmArquivosFalta.pas' {fArquivosFalta},
  fmBuscaMusica in 'fmBuscaMusica.pas' {fBuscaMusica},
  fmArquivosExcesso in 'fmArquivosExcesso.pas' {fArquivosExcesso},
  fmItensAgendados in 'fmItensAgendados.pas' {fItensAgendados},
  dmComponentes in 'dmComponentes.pas' {DM: TDataModule},
  fmFormatacao in 'fmFormatacao.pas' {fFormatacao},
  fmEditorSlides in 'fmEditorSlides.pas' {fEditorSlides},
  fmIniciando in 'fmIniciando.pas' {fIniciando},
  fmPlayer in 'fmPlayer.pas' {fPlayer},
  fmTransmitir in 'fmTransmitir.pas' {fTransmitir},
  fmMusicaRetorno in 'fmMusicaRetorno.pas' {fMusicaRetorno},
  fmMonitorRelogio in 'fmMonitorRelogio.pas' {fMonitorRelogio},
  fmMonitorTextoInterativo in 'fmMonitorTextoInterativo.pas' {fMonitorTextoInterativo},
  fmMonitorPainelDinamico in 'fmMonitorPainelDinamico.pas' {fMonitorPainelDinamico},
  fmMonitorCronometro in 'fmMonitorCronometro.pas' {fMonitorCronometro},
  fmMonitorSorteio in 'fmMonitorSorteio.pas' {fMonitorSorteio},
  fmMonitorCronometroCulto in 'fmMonitorCronometroCulto.pas' {fMonitorCronometroCulto},
  fmMonitorBibliaBusca in 'fmMonitorBibliaBusca.pas' {fMonitorBibliaBusca},
  fmMonitorBiblia in 'fmMonitorBiblia.pas' {fMonitorBiblia},
  fmMonitorMenuMusicas in 'fmMonitorMenuMusicas.pas' {fMonitorMenuMusicas},
  fmIdentificaMonitores in 'fmIdentificaMonitores.pas' {fIdentificaMonitores},
  fmCopiaLiturgiaDia in 'fmCopiaLiturgiaDia.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfIniciando, fIniciando);
  Application.CreateForm(TfPlayer, fPlayer);
  Application.CreateForm(TfTransmitir, fTransmitir);
  Application.Run;
end.
