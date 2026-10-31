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
//O JSON e um objeto de objetos de texto, espelho exato das secoes e chaves
//do INI:
//
//  {
//    "Geral":  { "1": "item_a;item_b" },
//    "item_a": { "tipo": "musica", "musica": "1234" }
//  }
//
//Todo valor e gravado como texto, para o ida-e-volta ser exato: gravar "01"
//como numero devolveria "1". Na leitura, numero e booleano sao aceitos e
//convertidos, para tolerar arquivo escrito por outra ferramenta.
//
//PORTE (secao 5b do CLAUDE.md): a gravacao e escrita a mao e nao depende de
//biblioteca de JSON nenhuma. A dependencia de System.JSON esta num unico
//lugar, o metodo carregaJson. No Lazarus/FPC so ele muda, para fpjson +
//jsonparser. Fora disso a unit nao usa VCL nem Windows.

interface

uses
  System.Classes, System.SysUtils, System.IniFiles;

type
  TFormatoLiturgia = (flVazio, flIni, flJson);

  TLiturgiaArq = class(TMemIniFile)
  private
    procedure carregaJson(const texto: string);
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

//Escapa o texto para entrar entre aspas num JSON.
function escapaTextoJson(const txt: string): string;

//Par "nome": "valor", com os dois escapados. Usado tanto aqui como pelo
//uLiturgiaTroca, para o escape e o recuo existirem num lugar so.
function jsonParTexto(const recuo, nome, valor: string): string;

//Par "nome": <bruto>, para numero, booleano, objeto ou array -- o que ja
//vem pronto em JSON e nao leva aspas.
function jsonParBruto(const recuo, nome, bruto: string): string;

//Texto de um booleano em JSON.
function jsonBool(valor: Boolean): string;

implementation

uses
  System.JSON;

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

function escapaTextoJson(const txt: string): string;
var
  i: Integer;
  c: Char;
begin
  Result := '';

  for i := 1 to Length(txt) do
  begin
    c := txt[i];

    case c of
      '"': Result := Result + '\"';
      '\': Result := Result + '\\';
      #8:  Result := Result + '\b';
      #9:  Result := Result + '\t';
      #10: Result := Result + '\n';
      #12: Result := Result + '\f';
      #13: Result := Result + '\r';
    else
      if (c < ' ')
        then Result := Result + '\u' + LowerCase(IntToHex(Ord(c), 4))
        else Result := Result + c;
    end;
  end;
end;

function jsonParTexto(const recuo, nome, valor: string): string;
begin
  Result := recuo + '"' + escapaTextoJson(nome) + '": "' +
            escapaTextoJson(valor) + '"';
end;

function jsonParBruto(const recuo, nome, bruto: string): string;
begin
  Result := recuo + '"' + escapaTextoJson(nome) + '": ' + bruto;
end;

function jsonBool(valor: Boolean): string;
begin
  if valor
    then Result := 'true'
    else Result := 'false';
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

procedure TLiturgiaArq.carregaJson(const texto: string);
var
  raiz: TJSONValue;
  obj, secao: TJSONObject;
  nomeSecao: string;
  i, k: Integer;
begin
  raiz := TJSONObject.ParseJSONValue(texto);

  if (raiz = nil) then
    raise Exception.Create('Liturgia: nao foi possivel ler o JSON.');

  try
    if not (raiz is TJSONObject) then
      raise Exception.Create('Liturgia: o JSON precisa comecar com um objeto.');

    obj := TJSONObject(raiz);

    for i := 0 to obj.Count - 1 do
    begin
      //Chave do primeiro nivel que nao e objeto nao e secao: ignora, em vez
      //de recusar o arquivo inteiro.
      if not (obj.Pairs[i].JsonValue is TJSONObject) then
        Continue;

      nomeSecao := obj.Pairs[i].JsonString.Value;
      secao := TJSONObject(obj.Pairs[i].JsonValue);

      for k := 0 to secao.Count - 1 do
        WriteString(nomeSecao,
                    secao.Pairs[k].JsonString.Value,
                    valorComoTexto(secao.Pairs[k].JsonValue));
    end;
  finally
    raiz.Free;
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
  secoes, chaves: TStringList;
  i, k: Integer;
  linha: string;
begin
  Result := '{' + sLineBreak;

  secoes := TStringList.Create;
  try
    ReadSections(secoes);

    for i := 0 to secoes.Count - 1 do
    begin
      Result := Result + '  "' + escapaTextoJson(secoes[i]) + '": {' + sLineBreak;

      chaves := TStringList.Create;
      try
        ReadSection(secoes[i], chaves);

        for k := 0 to chaves.Count - 1 do
        begin
          linha := jsonParTexto('    ', chaves[k],
                               ReadString(secoes[i], chaves[k], ''));

          if (k < chaves.Count - 1) then
            linha := linha + ',';

          Result := Result + linha + sLineBreak;
        end;
      finally
        chaves.Free;
      end;

      if (i < secoes.Count - 1)
        then Result := Result + '  },' + sLineBreak
        else Result := Result + '  }' + sLineBreak;
    end;
  finally
    secoes.Free;
  end;

  Result := Result + '}' + sLineBreak;
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
