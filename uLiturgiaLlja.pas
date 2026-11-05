unit uLiturgiaLlja;

//Liturgia de UM dia em arquivo: o .llja.
//
//E um zip com o JSON de troca de uma liturgia (liturgia.json, o MESMO formato
//do arquivo interno -- ver uLiturgia) mais a subpasta arquivos\ com o que os
//itens de tipo arquivo apontam. Serve para montar a liturgia em casa e levar
//para a igreja, onde esses arquivos nao existem.
//
//Dentro do pacote o dir dos itens de arquivo e relativo a pasta do pacote e
//dir_info vale 'L'. O 'L' NAO sai daqui: na leitura ele e resolvido para
//caminho absoluto e o item volta a ser um arquivo comum, com dir_info 'E'.
//Por isso nem a reproducao nem a edicao da liturgia sabem que o .llja existe.
//
//Zip de terceiro e entrada nao confiavel, e a validacao e dupla, como pediu o
//desenho: nomeSeguroNoPacote recusa entrada que tente escapar da pasta (..\,
//caminho absoluto, unidade) na extracao, e resolveDirDoPacote confere outra
//vez o caminho JA resolvido na leitura do manifesto.
//
//PORTE (secao 5b do CLAUDE.md): a unica dependencia fora da RTL comum e
//System.Zip, usada em gravaLlja e abreLlja. No Lazarus/FPC muda para a unit
//zipper, e e o unico lugar a trocar -- aqui nao ha VCL, nem Windows, nem
//referencia a form nenhum.

interface

uses
  System.Classes, System.SysUtils;

const
  //Manifesto dentro do pacote: JSON no formato de troca, com UMA liturgia.
  //O nome do desenho original (liturgia.lja) e aceito na leitura.
  MANIFESTO_LLJA = 'liturgia.json';
  MANIFESTO_LLJA_ALT = 'liturgia.lja';

  //Subpasta do pacote onde os arquivos dos itens viajam.
  PASTA_ARQUIVOS_LLJA = 'arquivos';

  //Valor de dir_info que diz "relativo a pasta da liturgia". So existe dentro
  //do pacote, nunca no liturgia.json nem no liturgia.ja.
  DIR_INFO_LOCAL = 'L';

//Nome livre dentro de arquivos\. Na colisao entra um numero sequencial antes
//da extensao: "video.mp4", "video (2).mp4". O nome escolhido e ACRESCENTADO a
//usados, para a chamada seguinte ja considerar ele.
function nomeLivreNoPacote(usados: TStrings; const nomeArquivo: string): string;

//Grava o pacote. nomes e origens sao listas PARALELAS: nomes[i] e o nome
//dentro de arquivos\ e origens[i] o caminho absoluto de onde copiar.
procedure gravaLlja(const destino, jsonDoDia: string; nomes, origens: TStrings);

//Abre o pacote: extrai o conteudo para pastaDestino (criada se preciso) e
//devolve o texto do manifesto, que NAO vai para o disco. Levanta excecao com
//mensagem pronta quando o pacote deve ser recusado.
function abreLlja(const origem, pastaDestino: string): string;

//Resolve o dir de um item do pacote para caminho absoluto dentro de
//pastaLiturgia. Devolve vazio quando o caminho escapa dela.
function resolveDirDoPacote(const pastaLiturgia, dir: string): string;

//True quando a entrada do zip pode ser extraida com seguranca.
function nomeSeguroNoPacote(const nome: string): Boolean;

//Entrada que representa diretorio, nao arquivo: e pulada, nao recusada.
function ehPastaNoPacote(const nome: string): Boolean;

//Nome do arquivo quando ele esta DIRETAMENTE dentro de pasta; vazio quando
//esta em outro lugar. Serve para a sincronizacao saber o que ja faz parte
//do pacote e o que veio de fora e precisa ser copiado para dentro.
function nomeDentroDaPasta(const caminho, pasta: string): string;

implementation

uses
  System.Zip;

//Separador do zip e a barra normal, mas pacote feito no Windows pode trazer a
//invertida. Tudo e comparado na forma normalizada.
function comBarraNormal(const nome: string): string;
begin
  Result := StringReplace(Trim(nome), '\', '/', [rfReplaceAll]);
end;

function caminhoLocal(const nome: string): string;
begin
  Result := StringReplace(comBarraNormal(nome), '/', PathDelim, [rfReplaceAll]);
end;

function ehPastaNoPacote(const nome: string): Boolean;
var
  s: string;
begin
  s := comBarraNormal(nome);
  Result := (s = '') or (Copy(s, Length(s), 1) = '/');
end;

function nomeSeguroNoPacote(const nome: string): Boolean;
var
  s: string;
begin
  Result := False;
  s := comBarraNormal(nome);

  if (s = '') then
    Exit;

  //Unidade (c:\...) ou caminho de rede.
  if (Pos(':', s) > 0) then
    Exit;

  //Raiz.
  if (Copy(s, 1, 1) = '/') then
    Exit;

  //Sobe de pasta, em qualquer posicao.
  if (s = '..') or (Copy(s, 1, 3) = '../') or (Pos('/../', s) > 0) or
     (Copy(s, Length(s) - 2, 3) = '/..') then
    Exit;

  Result := True;
end;

function nomeLivreNoPacote(usados: TStrings; const nomeArquivo: string): string;
var
  base, ext, tentativa: string;
  n: Integer;
begin
  base := ExtractFileName(Trim(nomeArquivo));

  if (base = '') then
    base := 'arquivo';

  ext := ExtractFileExt(base);
  base := Copy(base, 1, Length(base) - Length(ext));

  tentativa := base + ext;
  n := 1;

  while (usados <> nil) and (usados.IndexOf(tentativa) >= 0) do
  begin
    Inc(n);
    tentativa := base + ' (' + IntToStr(n) + ')' + ext;
  end;

  if (usados <> nil) then
    usados.Add(tentativa);

  Result := tentativa;
end;

function nomeDentroDaPasta(const caminho, pasta: string): string;
var
  base: string;
begin
  Result := '';

  if (Trim(caminho) = '') or (Trim(pasta) = '') then
    Exit;

  base := IncludeTrailingPathDelimiter(ExpandFileName(pasta));

  if not SameText(ExtractFilePath(ExpandFileName(caminho)), base) then
    Exit;

  Result := ExtractFileName(caminho);
end;

procedure gravaBytes(const caminho: string; const dados: TBytes);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(caminho, fmCreate);
  try
    if (Length(dados) > 0) then
      fs.WriteBuffer(dados[0], Length(dados));
  finally
    fs.Free;
  end;
end;

//Texto UTF-8, pulando o BOM se o manifesto vier com um.
function textoUtf8(const dados: TBytes): string;
begin
  if (Length(dados) >= 3) and (dados[0] = $EF) and (dados[1] = $BB) and
     (dados[2] = $BF) then
    Result := TEncoding.UTF8.GetString(dados, 3, Length(dados) - 3)
  else
    Result := TEncoding.UTF8.GetString(dados);
end;

procedure gravaLlja(const destino, jsonDoDia: string; nomes, origens: TStrings);
var
  zip: TZipFile;
  i: Integer;
  nome, origem: string;
begin
  if (nomes = nil) <> (origens = nil) then
    raise Exception.Create('Liturgia: listas de arquivos do pacote inconsistentes.');

  if (nomes <> nil) and (nomes.Count <> origens.Count) then
    raise Exception.Create('Liturgia: listas de arquivos do pacote com tamanhos diferentes.');

  zip := TZipFile.Create;
  try
    zip.Open(destino, zmWrite);
    try
      zip.Add(TEncoding.UTF8.GetBytes(jsonDoDia), MANIFESTO_LLJA);

      if (nomes <> nil) then
        for i := 0 to nomes.Count - 1 do
        begin
          nome := Trim(nomes[i]);
          origem := Trim(origens[i]);

          if (nome = '') or (origem = '') or not FileExists(origem) then
            Continue;

          //zcStored: mp3, opus e jpg ja sao comprimidos, e o pacote e
          //regravado a cada mexida na guia Avulsa. Recomprimir custaria
          //tempo sem tirar um byte.
          zip.Add(origem, PASTA_ARQUIVOS_LLJA + '/' + nome, zcStored);
        end;
    finally
      zip.Close;
    end;
  finally
    zip.Free;
  end;
end;

function abreLlja(const origem, pastaDestino: string): string;
var
  zip: TZipFile;
  entradas: TArray<string>;
  i: Integer;
  nome, alvo, base, manifesto: string;
  dados: TBytes;
begin
  manifesto := '';
  base := IncludeTrailingPathDelimiter(pastaDestino);

  zip := TZipFile.Create;
  try
    zip.Open(origem, zmRead);
    try
      entradas := zip.FileNames;

      if not ForceDirectories(base) then
        raise Exception.Create('Liturgia: não foi possível criar a pasta ' + base);

      for i := 0 to High(entradas) do
      begin
        nome := entradas[i];

        if ehPastaNoPacote(nome) then
          Continue;

        if not nomeSeguroNoPacote(nome) then
          raise Exception.Create(
            'Este arquivo de liturgia tem uma entrada com caminho inválido (' +
            nome + ') e não pode ser aberto.');

        zip.Read(nome, dados);

        //O manifesto fica so em memoria: no disco ele nao serve para nada e
        //poderia ser confundido com o liturgia.json do programa.
        if SameText(comBarraNormal(nome), MANIFESTO_LLJA) or
           SameText(comBarraNormal(nome), MANIFESTO_LLJA_ALT) then
        begin
          manifesto := textoUtf8(dados);
          Continue;
        end;

        alvo := base + caminhoLocal(nome);
        ForceDirectories(ExtractFilePath(alvo));
        gravaBytes(alvo, dados);
      end;
    finally
      zip.Close;
    end;
  finally
    zip.Free;
  end;

  if (Trim(manifesto) = '') then
    raise Exception.Create(
      'Este arquivo não parece ser uma liturgia: falta o ' + MANIFESTO_LLJA +
      ' dentro dele.');

  Result := manifesto;
end;

function resolveDirDoPacote(const pastaLiturgia, dir: string): string;
var
  base, alvo: string;
begin
  Result := '';

  if (Trim(dir) = '') or (Trim(pastaLiturgia) = '') then
    Exit;

  //Primeira trava: o nome em si.
  if not nomeSeguroNoPacote(dir) then
    Exit;

  base := IncludeTrailingPathDelimiter(ExpandFileName(pastaLiturgia));
  alvo := ExpandFileName(base + caminhoLocal(dir));

  //Segunda trava: o caminho JA resolvido tem de continuar dentro da pasta.
  //ExpandFileName desfaz o que sobrou de .. e de separador repetido.
  if (Length(alvo) <= Length(base)) or
     not SameText(Copy(alvo, 1, Length(base)), base) then
    Exit;

  Result := alvo;
end;

end.
