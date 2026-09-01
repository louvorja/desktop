unit uAgendados;

{
  Suporte a listas de itens agendados com download automatico.

  Uma categoria de itens agendados ganha download automatico quando existe um
  arquivo de lista com o mesmo nome dela dentro de <config>\agendados\:

    config\agendados\Provai e vede.txt            lista de episodios
    config\agendados\Provai e vede\               videos baixados pelo programa
    config\agendados\Provai e vede\baixados.txt   manifesto do que foi baixado

  Formato da lista: uma linha por episodio, "data,url", com a data em yyyy-mm-dd.
  Linhas vazias e iniciadas por # sao ignoradas. A data que vem no nome do
  arquivo da URL esta no padrao americano (mes-dia-ano) e nao deve ser usada.

  O manifesto e a autorizacao para apagar: a limpeza de itens passados so remove
  do disco arquivos que estejam na pasta de downloads da categoria E listados
  nele. Qualquer outro arquivo (video personalizado da igreja, por exemplo)
  nunca e tocado.
}

interface

uses
  System.SysUtils, System.Classes, System.StrUtils;

type
  TEpisodioAgendado = record
    Data: TDate;
    URL: string;
  end;

  TEpisodiosAgendados = array of TEpisodioAgendado;

const
  PASTA_AGENDADOS = 'agendados\';
  ARQUIVO_MANIFESTO = 'baixados.txt';
  TAMANHO_MINIMO_DOWNLOAD = 1024 * 1024; // 1 MB: abaixo disso e pagina de erro, nao video

var
  // Preenchido por fmIndex na inicializacao com o dir_config do programa.
  dirConfigAgendados: string = '';

function pastaListasAgendados: string;
function arquivoListaAgendados(const categoria: string): string;
function pastaDownloadsAgendados(const categoria: string): string;
function arquivoManifestoAgendados(const categoria: string): string;

function categoriaTemLista(const categoria: string): Boolean;
function leListaAgendados(const categoria: string; out episodios: TEpisodiosAgendados): Boolean;
function categoriasComLista: TStringList;

function nomeArquivoEpisodio(const episodio: TEpisodioAgendado): string;
function arquivoEhDownloadDoPrograma(const categoria, arquivo: string): Boolean;

function constaNoManifesto(const categoria, arquivo: string): Boolean;
procedure gravaNoManifesto(const categoria, arquivo: string);
procedure removeDoManifesto(const categoria, arquivo: string);

implementation

function pastaListasAgendados: string;
begin
  Result := IncludeTrailingPathDelimiter(dirConfigAgendados) + PASTA_AGENDADOS;
end;

function arquivoListaAgendados(const categoria: string): string;
begin
  if (trim(categoria) = '') or (dirConfigAgendados = '') then
    Result := ''
  else
    Result := pastaListasAgendados + trim(categoria) + '.txt';
end;

function pastaDownloadsAgendados(const categoria: string): string;
begin
  if (trim(categoria) = '') or (dirConfigAgendados = '') then
    Result := ''
  else
    Result := pastaListasAgendados + trim(categoria) + '\';
end;

function arquivoManifestoAgendados(const categoria: string): string;
begin
  if (pastaDownloadsAgendados(categoria) = '') then
    Result := ''
  else
    Result := pastaDownloadsAgendados(categoria) + ARQUIVO_MANIFESTO;
end;

function categoriaTemLista(const categoria: string): Boolean;
begin
  Result := (arquivoListaAgendados(categoria) <> '') and
            FileExists(arquivoListaAgendados(categoria));
end;

// Converte "yyyy-mm-dd" em data. Formato fixo de proposito: a data do nome do
// arquivo da URL vem em mes-dia-ano americano e nao pode ser usada.
function tentaConverterData(const texto: string; out data: TDate): Boolean;
var
  fs: TFormatSettings;
  dt: TDateTime;
begin
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-mm-dd';
  Result := TryStrToDate(trim(texto), dt, fs);
  if Result then
    data := Trunc(dt);
end;

procedure ordenaPorData(var episodios: TEpisodiosAgendados);
var
  i, j: Integer;
  troca: TEpisodioAgendado;
begin
  for i := 1 to High(episodios) do
  begin
    troca := episodios[i];
    j := i - 1;
    while (j >= 0) and (episodios[j].Data > troca.Data) do
    begin
      episodios[j + 1] := episodios[j];
      Dec(j);
    end;
    episodios[j + 1] := troca;
  end;
end;

function leListaAgendados(const categoria: string; out episodios: TEpisodiosAgendados): Boolean;
var
  linhas: TStringList;
  i, p: Integer;
  linha, txtData, url: string;
  data: TDate;
begin
  SetLength(episodios, 0);
  Result := False;
  if not categoriaTemLista(categoria) then
    Exit;

  linhas := TStringList.Create;
  try
    try
      linhas.LoadFromFile(arquivoListaAgendados(categoria), TEncoding.UTF8);
    except
      // lista gravada em ANSI tambem deve funcionar
      linhas.LoadFromFile(arquivoListaAgendados(categoria));
    end;

    for i := 0 to linhas.Count - 1 do
    begin
      linha := trim(linhas[i]);
      if (linha = '') or (Copy(linha, 1, 1) = '#') then
        Continue;

      p := Pos(',', linha);
      if (p <= 0) then
        Continue;

      txtData := trim(Copy(linha, 1, p - 1));
      url := trim(Copy(linha, p + 1, Length(linha)));

      if not tentaConverterData(txtData, data) then
        Continue;
      if (Copy(LowerCase(url), 1, 4) <> 'http') then
        Continue;

      SetLength(episodios, Length(episodios) + 1);
      episodios[High(episodios)].Data := data;
      episodios[High(episodios)].URL := url;
    end;
  finally
    linhas.Free;
  end;

  ordenaPorData(episodios);
  Result := Length(episodios) > 0;
end;

// Nomes das categorias que tem lista, um por arquivo .txt da pasta.
function categoriasComLista: TStringList;
var
  busca: TSearchRec;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;

  if (dirConfigAgendados = '') or (not DirectoryExists(pastaListasAgendados)) then
    Exit;

  if FindFirst(pastaListasAgendados + '*.txt', faAnyFile - faDirectory, busca) = 0 then
  try
    repeat
      if (busca.Name <> '.') and (busca.Name <> '..') then
        Result.Add(ChangeFileExt(busca.Name, ''));
    until FindNext(busca) <> 0;
  finally
    FindClose(busca);
  end;
end;

// Ultimo trecho da URL, sem querystring.
function nomeArquivoDaURL(const url: string): string;
var
  p: Integer;
  nome: string;
begin
  nome := trim(url);

  p := Pos('?', nome);
  if (p > 0) then
    nome := Copy(nome, 1, p - 1);
  p := Pos('#', nome);
  if (p > 0) then
    nome := Copy(nome, 1, p - 1);

  p := LastDelimiter('/\', nome);
  if (p > 0) then
    nome := Copy(nome, p + 1, Length(nome));

  Result := nome;
end;

function ehDigito(c: Char): Boolean;
begin
  Result := CharInSet(c, ['0'..'9']);
end;

// Remove o prefixo "mm-dd-aa_" do nome original, que esta em formato americano.
function removePrefixoDataAmericana(const nome: string): string;
begin
  Result := nome;
  if (Length(nome) > 9) and
     ehDigito(nome[1]) and ehDigito(nome[2]) and (nome[3] = '-') and
     ehDigito(nome[4]) and ehDigito(nome[5]) and (nome[6] = '-') and
     ehDigito(nome[7]) and ehDigito(nome[8]) and (nome[9] = '_') then
    Result := Copy(nome, 10, Length(nome));
end;

function limpaNomeArquivo(const nome: string): string;
var
  i: Integer;
begin
  Result := nome;
  for i := 1 to Length(Result) do
    if CharInSet(Result[i], ['\', '/', ':', '*', '?', '"', '<', '>', '|']) then
      Result[i] := '_';
end;

// Nome final do arquivo baixado: a data real na frente resolve o problema de o
// nome de origem estar em mes-dia-ano.
function nomeArquivoEpisodio(const episodio: TEpisodioAgendado): string;
var
  nome: string;
begin
  nome := removePrefixoDataAmericana(nomeArquivoDaURL(episodio.URL));
  if (trim(nome) = '') then
    nome := 'video.mp4';
  Result := FormatDateTime('yyyy-mm-dd', episodio.Data) + '_' + limpaNomeArquivo(nome);
end;

// True somente se o arquivo esta diretamente dentro da pasta de downloads da
// categoria. Primeira trava antes de apagar qualquer coisa do disco.
function arquivoEhDownloadDoPrograma(const categoria, arquivo: string): Boolean;
var
  pasta, caminho: string;
begin
  Result := False;
  if (trim(categoria) = '') or (trim(arquivo) = '') then
    Exit;
  if (Pos('..', arquivo) > 0) then
    Exit;

  pasta := pastaDownloadsAgendados(categoria);
  if (pasta = '') then
    Exit;

  pasta := IncludeTrailingPathDelimiter(ExpandFileName(pasta));
  caminho := ExpandFileName(arquivo);

  Result := SameText(IncludeTrailingPathDelimiter(ExtractFilePath(caminho)), pasta) and
            (trim(ExtractFileName(caminho)) <> '');
end;

function carregaManifesto(const categoria: string): TStringList;
begin
  Result := TStringList.Create;
  if (arquivoManifestoAgendados(categoria) <> '') and
     FileExists(arquivoManifestoAgendados(categoria)) then
    try
      Result.LoadFromFile(arquivoManifestoAgendados(categoria), TEncoding.UTF8);
    except
      Result.Clear;
    end;
end;

function constaNoManifesto(const categoria, arquivo: string): Boolean;
var
  manifesto: TStringList;
  i: Integer;
  nome: string;
begin
  Result := False;
  nome := ExtractFileName(arquivo);
  if (nome = '') then
    Exit;

  manifesto := carregaManifesto(categoria);
  try
    for i := 0 to manifesto.Count - 1 do
      if SameText(trim(manifesto[i]), nome) then
      begin
        Result := True;
        Break;
      end;
  finally
    manifesto.Free;
  end;
end;

procedure gravaNoManifesto(const categoria, arquivo: string);
var
  manifesto: TStringList;
  nome: string;
begin
  nome := ExtractFileName(arquivo);
  if (nome = '') or (arquivoManifestoAgendados(categoria) = '') then
    Exit;
  if constaNoManifesto(categoria, nome) then
    Exit;

  manifesto := carregaManifesto(categoria);
  try
    manifesto.Add(nome);
    try
      manifesto.SaveToFile(arquivoManifestoAgendados(categoria), TEncoding.UTF8);
    except
      // sem manifesto, o arquivo simplesmente nunca sera apagado automaticamente
    end;
  finally
    manifesto.Free;
  end;
end;

procedure removeDoManifesto(const categoria, arquivo: string);
var
  manifesto: TStringList;
  i: Integer;
  nome: string;
begin
  nome := ExtractFileName(arquivo);
  if (nome = '') or (arquivoManifestoAgendados(categoria) = '') then
    Exit;

  manifesto := carregaManifesto(categoria);
  try
    for i := manifesto.Count - 1 downto 0 do
      if SameText(trim(manifesto[i]), nome) then
        manifesto.Delete(i);
    try
      manifesto.SaveToFile(arquivoManifestoAgendados(categoria), TEncoding.UTF8);
    except
    end;
  finally
    manifesto.Free;
  end;
end;

end.
