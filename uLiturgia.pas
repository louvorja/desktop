unit uLiturgia;

//Arquivo de liturgia nos dois formatos: INI e JSON.
//
//A classe descende de TMemIniFile de proposito. Com isso ela E um
//TCustomIniFile, e os pontos do programa que leem e gravam a liturgia
//continuam funcionando sem alteracao -- o formato passa a ser so um detalhe
//de como o arquivo e lido e gravado. O UpdateFile e sobrescrito para gravar
//JSON, o que mantem correto quem termina a edicao chamando ele (o apagaParam
//do fmMenu e um desses).
//
//O JSON e o FORMATO DE TROCA do uLiturgiaTroca -- o mesmo que a exportacao
//grava e a importacao le. Isso e requisito, nao coincidencia: o usuario tem
//de poder copiar um arquivo exportado para dentro de %APPDATA%\LouvorJA e o
//programa passar a usar ele, sem converter nada. Por isso esta unit NAO tem
//formato proprio: ela delega para o uLiturgiaTroca, que e quem conhece o
//envelope.
//
//A chave reservada "_secoes" e a unica coisa que esta unit acrescenta ao
//envelope, e so aparece numa janela curta. Ver secoesSoltasJson.
//
//PORTE (secao 5b do CLAUDE.md): a gravacao e escrita a mao e nao depende de
//biblioteca de JSON nenhuma. A dependencia de System.JSON esta num unico
//lugar, o metodo carregaSecoesSoltas. No Lazarus/FPC so ele muda, para
//fpjson + jsonparser. Fora disso a unit nao usa VCL nem Windows.

interface

uses
  System.Classes, System.SysUtils, System.IniFiles;

type
  TFormatoLiturgia = (flVazio, flIni, flJson);

  TLiturgiaArq = class(TMemIniFile)
  private
    procedure carregaJson(const texto: string);
    procedure carregaSecoesSoltas(const texto: string);
    function secoesSoltasJson: string;
  public
    //Documento em memoria guardando o nome do arquivo para o UpdateFile, mas
    //SEM carregar o arquivo: o TMemIniFile leria o JSON como se fosse INI.
    constructor criaPara(const caminho: string);

    procedure carregaTexto(const texto: string);
    procedure copiaDe(origem: TCustomIniFile);

    //Grava o JSON em UTF-8 sem BOM, que e o esperado de um JSON.
    procedure gravaEm(const caminho: string);
    procedure UpdateFile; override;

    function comoJson: string;
    function comoIni: string;
  end;

//Qual formato o texto tem, olhando o primeiro caractere que nao e espaco.
function formatoDeTexto(const texto: string): TFormatoLiturgia;

implementation

uses
  System.JSON, uLiturgiaTroca;

const
  //Chave reservada do envelope, para as secoes que nenhum dia referencia.
  //Ver secoesSoltasJson.
  CHAVE_SECOES_SOLTAS = '_secoes';

function formatoDeTexto(const texto: string): TFormatoLiturgia;
var
  i: Integer;
begin
  Result := flVazio;

  i := 1;
  while (i <= Length(texto)) and
        ((texto[i] = ' ') or (texto[i] = #9) or (texto[i] = #10) or
         (texto[i] = #13) or (texto[i] = #$FEFF)) do
    Inc(i);

  if (i > Length(texto)) then
    Exit;

  if (texto[i] = '{')
    then Result := flJson
    else Result := flIni;
end;

//Valor do JSON como texto. Numero descende de TJSONString, entao cai no
//primeiro caso e devolve os digitos. Os tipos true/false/null sao tratados
//pelo texto do ToString para nao depender de classes que mudam de nome entre
//versoes do Delphi.
function valorComoTexto(valor: TJSONValue): string;
begin
  if (valor = nil) then
    Exit('');

  if (valor is TJSONString) then
    Exit(TJSONString(valor).Value);

  Result := valor.ToString;

  if SameText(Result, 'true') then
    Result := '1'
  else if SameText(Result, 'false') then
    Result := '0'
  else if SameText(Result, 'null') then
    Result := '';
end;

constructor TLiturgiaArq.criaPara(const caminho: string);
begin
  inherited Create('');

  //AutoSave gravaria no destrutor, pelas costas de quem usa.
  AutoSave := False;

  if (caminho <> '') then
    Rename(caminho, False);
end;

//Le o envelope de troca e distribui os itens pelos dias. E o mesmo codigo da
//importacao, de proposito: o arquivo interno e o arquivo trocado sao um so.
procedure TLiturgiaArq.carregaJson(const texto: string);
var
  col: TColecaoTroca;
begin
  col := leJsonTroca(texto);
  try
    aplicaColecaoEm(col, Self);
  finally
    col.Free;
  end;

  carregaSecoesSoltas(texto);
end;

//Secao que nenhum dia referencia volta da chave reservada.
//
//Existe uma janela curta e real em que isso acontece: o TfLiturgia.btAddClick
//grava as chaves do item novo ANTES de o id entrar na lista do [Geral], e o
//btCopiaLitSelClick faz igual. Nesse instante a secao nao pertence a nenhum
//dia, e o envelope de troca -- que e uma lista de dias -- nao tem onde poe-la.
//Sem guardar essas secoes, a gravacao desse instante descartaria o item
//recem-criado e ele voltaria vazio na tela.
//
//Depois da gravacao seguinte o id ja esta no [Geral] e a chave desaparece
//sozinha, entao um arquivo exportado normalmente nao tem nenhuma.
procedure TLiturgiaArq.carregaSecoesSoltas(const texto: string);
var
  raiz, v: TJSONValue;
  obj, soltas, secao: TJSONObject;
  i, k: Integer;
begin
  raiz := TJSONObject.ParseJSONValue(texto);

  if (raiz = nil) then
    Exit;

  try
    if not (raiz is TJSONObject) then
      Exit;

    obj := TJSONObject(raiz);
    v := obj.GetValue(CHAVE_SECOES_SOLTAS);

    if (v = nil) or not (v is TJSONObject) then
      Exit;

    soltas := TJSONObject(v);

    for i := 0 to soltas.Count - 1 do
    begin
      if not (soltas.Pairs[i].JsonValue is TJSONObject) then
        Continue;

      secao := TJSONObject(soltas.Pairs[i].JsonValue);

      for k := 0 to secao.Count - 1 do
        WriteString(soltas.Pairs[i].JsonString.Value,
                    secao.Pairs[k].JsonString.Value,
                    valorComoTexto(secao.Pairs[k].JsonValue));
    end;
  finally
    raiz.Free;
  end;
end;

//As secoes que nenhum dia referencia, como '  "_secoes": { ... }', prontas
//para entrar no envelope. Vazio quando nao ha nenhuma, que e o normal.
function TLiturgiaArq.secoesSoltasJson: string;
var
  usadas, secoes, chaves, ids: TStringList;
  i, k, dia: Integer;
  corpo, bloco: string;
begin
  Result := '';

  usadas := TStringList.Create;
  secoes := TStringList.Create;
  try
    usadas.CaseSensitive := False;

    for dia := PRIMEIRO_DIA to ULTIMO_DIA do
    begin
      ids := TStringList.Create;
      try
        ids.Delimiter := ';';
        ids.StrictDelimiter := True;
        ids.DelimitedText := ReadString('Geral', IntToStr(dia), '');

        for k := 0 to ids.Count - 1 do
          if (Trim(ids[k]) <> '') then
            usadas.Add(Trim(ids[k]));
      finally
        ids.Free;
      end;
    end;

    ReadSections(secoes);
    corpo := '';

    for i := 0 to secoes.Count - 1 do
    begin
      //O [Geral] nunca viaja: a ordem dos dias e o AlteraOrdem sao
      //reconstruidos pelo aplicaEm a partir da estrutura do envelope.
      if SameText(secoes[i], 'Geral') or (usadas.IndexOf(secoes[i]) >= 0) then
        Continue;

      bloco := '    "' + escapaTextoJson(secoes[i]) + '": {' + sLineBreak;

      chaves := TStringList.Create;
      try
        ReadSection(secoes[i], chaves);

        for k := 0 to chaves.Count - 1 do
        begin
          bloco := bloco + jsonParTexto('      ', chaves[k],
                                        ReadString(secoes[i], chaves[k], ''));

          if (k < chaves.Count - 1) then
            bloco := bloco + ',';

          bloco := bloco + sLineBreak;
        end;
      finally
        chaves.Free;
      end;

      bloco := bloco + '    }';

      if (corpo <> '') then
        corpo := corpo + ',' + sLineBreak;

      corpo := corpo + bloco;
    end;

    if (corpo <> '') then
      Result := '  "' + CHAVE_SECOES_SOLTAS + '": {' + sLineBreak
              + corpo + sLineBreak + '  }';
  finally
    secoes.Free;
    usadas.Free;
  end;
end;

procedure TLiturgiaArq.carregaTexto(const texto: string);
var
  linhas: TStringList;
begin
  Clear;

  if (formatoDeTexto(texto) = flJson) then
  begin
    carregaJson(texto);
    Exit;
  end;

  linhas := TStringList.Create;
  try
    linhas.Text := texto;
    SetStrings(linhas);
  finally
    linhas.Free;
  end;
end;

procedure TLiturgiaArq.copiaDe(origem: TCustomIniFile);
var
  secoes, chaves: TStringList;
  i, k: Integer;
begin
  Clear;

  if (origem = nil) then
    Exit;

  secoes := TStringList.Create;
  try
    origem.ReadSections(secoes);

    for i := 0 to secoes.Count - 1 do
    begin
      chaves := TStringList.Create;
      try
        origem.ReadSection(secoes[i], chaves);

        for k := 0 to chaves.Count - 1 do
          WriteString(secoes[i], chaves[k],
                      origem.ReadString(secoes[i], chaves[k], ''));
      finally
        chaves.Free;
      end;
    end;
  finally
    secoes.Free;
  end;
end;

procedure TLiturgiaArq.gravaEm(const caminho: string);
var
  bytes: TBytes;
  fs: TFileStream;
begin
  bytes := TEncoding.UTF8.GetBytes(comoJson);

  fs := TFileStream.Create(caminho, fmCreate);
  try
    if (Length(bytes) > 0) then
      fs.WriteBuffer(bytes[0], Length(bytes));
  finally
    fs.Free;
  end;
end;

//Grava JSON, nao o INI que o TMemIniFile gravaria. E o que mantem correto
//quem edita e termina chamando UpdateFile, sem precisar saber do formato.
procedure TLiturgiaArq.UpdateFile;
begin
  if (FileName = '') then
    Exit;

  gravaEm(FileName);
  Modified := False;
end;

function TLiturgiaArq.comoJson: string;
var
  col: TColecaoTroca;
begin
  col := colecaoDoArquivo(Self);
  try
    Result := col.comoJson(secoesSoltasJson);
  finally
    col.Free;
  end;
end;

function TLiturgiaArq.comoIni: string;
var
  linhas: TStringList;
begin
  linhas := TStringList.Create;
  try
    GetStrings(linhas);
    Result := linhas.Text;
  finally
    linhas.Free;
  end;
end;

end.
