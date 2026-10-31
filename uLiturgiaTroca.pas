unit uLiturgiaTroca;

//Liturgia no formato JSON de troca, que e o padrao de intercambio do projeto
//-- usado tanto no .json solto (exportar e importar a semana ou um dia) como
//dentro do .llja.
//
//NAO e o formato interno. O interno continua sendo o liturgia.ja (INI), com o
//liturgia.json do uLiturgia como alternativa espelhada. Esta unit so traduz:
//na leitura entrega os itens no MESMO modelo de secoes que o programa ja le
//com lerParam, e na gravacao le desse mesmo modelo. Por isso nada da
//reproducao, da edicao ou do FindIndexForTipo precisa saber que ela existe, e
//o .llja e o .json solto usam o mesmo codigo: um recebe o texto de dentro do
//zip, o outro de um arquivo.
//
//O dia da semana difere nos dois lados: 1..7 no INI (1 = domingo, conforme
//NOMES_DIAS de fmCopiaLiturgiaDia.pas) e 0..6 no JSON. A conversao esta em
//diaParaJson / diaDoJson e em lugar nenhum mais.
//
//PORTE (secao 5b do CLAUDE.md): as unicas dependencias de fora da RTL sao
//StringToColor, ColorToString e ColorToRGB, usadas pelas duas funcoes de cor;
//os tres nomes existem iguais no Graphics do LCL, entao o porte troca so a
//clausula uses. System.JSON aparece apenas na leitura, como no uLiturgia.

interface

uses
  System.Classes, System.SysUtils, System.IniFiles, System.UITypes,
  uLiturgia;

const
  //Versao do formato. Valor diferente deste recusa o arquivo; ausente e lido
  //como 1, por causa dos arquivos exportados antes do versionamento.
  SCHEMA_TROCA = 1;

  //Azul padrao do LouvorJA classico, nas duas notacoes. Vale como padrao dos
  //dois lados: valor ausente ou invalido cai nele.
  COR_HEX_PADRAO = '#00004F';
  COR_INI_PADRAO = '$004F0000';

type
  //Um item da liturgia: as chaves do INI, na ordem em que vieram.
  //
  //Campo que o Delphi nao conhece viaja aqui como chave comum, porque a secao
  //do INI aceita qualquer chave. E o que da round-trip fiel sem a estrutura
  //paralela de "objeto JSON bruto" -- so os campos que nao sao texto precisam
  //da lista de brutos, para voltarem sem aspas.
  TItemTroca = class
  private
    FCampos: TStringList;
    FBrutos: TStringList;
  public
    //Identificador do item, que no INI e o nome da secao.
    ident: string;

    constructor Create;
    destructor Destroy; override;

    property campos: TStringList read FCampos;

    function valor(const chave: string): string;
    procedure poe(const chave, v: string);

    //Marca a chave para ser gravada sem aspas (numero, booleano, objeto ou
    //array que chegou pronto de uma versao mais nova).
    procedure poeBruto(const chave, jsonPronto: string);
    function ehBruto(const chave: string): Boolean;

    function comoJson(const recuo: string): string;
  end;

  TVinculoTroca = record
    presente: Boolean;
    tipo: string;   //day_of_week | date | thirteenth_sabbath | outro
    valor: string;
    bruto: string;  //o objeto como veio, para tipo desconhecido
  end;

  TLiturgiaTroca = class
  private
    FItens: TStringList;  //Strings = ident, Objects = TItemTroca
  public
    nome: string;
    corHex: string;
    vinculo: TVinculoTroca;

    constructor Create;
    destructor Destroy; override;

    property itens: TStringList read FItens;

    function adicionaItem(const ident: string): TItemTroca;
    function item(i: Integer): TItemTroca;

    //Dia do INI (1..7) que o vinculo indica, ou 0 quando nao ha vinculo de
    //dia da semana.
    function diaDoVinculo: Integer;

    //Grava os itens e a ordem no arquivo interno, substituindo o que havia
    //naquele dia. O dia e o do INI (1..7).
    procedure aplicaEm(doc: TCustomIniFile; dia: Integer);

    //Envelope simples: { schema, name, color, binding?, exportedAt, items }.
    function comoJson(comVinculo: Boolean = False): string;

    //Miolo sem schema nem exportedAt, para entrar na colecao.
    function corpoJson(const recuo: string; comVinculo: Boolean): string;
  end;

  TColecaoTroca = class
  private
    FLiturgias: TStringList;
  public
    constructor Create;
    destructor Destroy; override;

    property liturgias: TStringList read FLiturgias;

    procedure adiciona(lit: TLiturgiaTroca);
    function liturgia(i: Integer): TLiturgiaTroca;

    //Envelope de colecao: { schema, exportedAt, liturgies: [...] }.
    function comoJson: string;
  end;

//Le o JSON de troca nas duas formas de envelope. Liturgia unica devolve uma
//colecao de um, para quem chama ter um caminho so. Levanta excecao com
//mensagem pronta para o usuario quando o arquivo deve ser recusado.
function leJsonTroca(const texto: string): TColecaoTroca;

//Monta a liturgia de um dia a partir do arquivo interno.
function liturgiaDoDia(doc: TCustomIniFile; dia: Integer;
  const nome: string): TLiturgiaTroca;

//Conversao de cor. CorParaHex resolve as duas formas que o ColorToString
//produz: o identificador (clNavy) e o $00BBGGRR.
function CorParaHex(const valorIni: string): string;
function HexParaCor(const hex: string): TColor;
function HexParaCorIni(const hex: string): string;

//Tipos de item, nos dois sentidos.
function tipoParaJson(const tipoIni: string): string;
function tipoDoJson(const tipoJson: string): string;

//Dia da semana: 1..7 no INI, 0..6 no JSON.
function diaParaJson(dia: Integer): Integer;
function diaDoJson(dia: Integer): Integer;

implementation

uses
  System.JSON, System.DateUtils, Vcl.Graphics;

const
  //Campos do item que no JSON nao sao texto. O resto e string.
  CAMPOS_NUMERO: array[0..2] of string = ('duration', 'musica', 'id_music');
  CAMPOS_BOOL: array[0..1] of string = ('escolha', 'has_instrumental_music');

  //Chave do INI que guarda o tipo original quando ele e um dos cinco que o
  //Delphi nao implementa. Sem ela, reexportar perderia o tipo.
  CHAVE_TIPO_ORIGINAL = 'tipo_origem';

  //O id= da secao do INI e a categoria do item agendado, nao o identificador
  //do item -- esse e o nome da secao. Sao coisas diferentes com o mesmo nome,
  //entao no JSON a categoria viaja com nome proprio.
  CHAVE_CATEGORIA_INI = 'id';
  CHAVE_CATEGORIA_JSON = 'id_categoria';

function estaEm(const s: string; const lista: array of string): Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := Low(lista) to High(lista) do
    if SameText(s, lista[i]) then
      Exit(True);
end;

//Valor do JSON como texto. Numero descende de TJSONString, por isso o teste
//de numero vem antes. Os tipos true/false/null sao tratados pelo texto do
//ToString para nao depender de classes que mudam de nome entre versoes do
//Delphi.
function textoDoValor(valor: TJSONValue): string;
begin
  if (valor = nil) then
    Exit('');

  if (valor is TJSONNumber) then
    Exit(TJSONNumber(valor).ToString);

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

function agoraIso: string;
begin
  //Local para UTC concentrado aqui: e a unica chamada da unit que muda no
  //porte (o FPC nao tem TTimeZone em toda versao).
  Result := FormatDateTime('yyyy-mm-dd''T''hh:nn:ss.zzz''Z''',
                           TTimeZone.Local.ToUniversalTime(Now));
end;

//Valor de uma linha de INI: nao pode conter quebra de linha, senao o arquivo
//sai invalido. O JSON permite, entao a troca acontece na entrada.
function umaLinha(const txt: string): string;
begin
  Result := StringReplace(txt, #13#10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
end;

//Identificador que pode virar nome de secao do INI e entrar na lista do
//[Geral]. O formato aceita qualquer string no id, mas a lista do [Geral] e
//separada por ';' lida com TStringList sem StrictDelimiter, entao espaco ou
//';' no id quebraria a ordem dos itens -- e ']' quebraria a secao.
//
//A mesma limpeza vale para o blocoId, senao a referencia de um item ao seu
//bloco deixa de casar com o id limpo do bloco.
function identSeguro(const txt: string): string;
var
  i: Integer;
  c: Char;
begin
  Result := '';

  for i := 1 to Length(txt) do
  begin
    c := txt[i];

    if CharInSet(c, ['a'..'z', 'A'..'Z', '0'..'9', '_', '-', '.'])
      then Result := Result + c
      else Result := Result + '_';
  end;

  Result := Trim(Result);
end;

{ ------------------------------------------------------------------- cores }

function CorParaHex(const valorIni: string): string;
var
  c: TColor;
begin
  if (Trim(valorIni) = '') then
    Exit(COR_HEX_PADRAO);

  try
    //Resolve o identificador (clNavy), o $00BBGGRR e as cores de sistema,
    //que variam com o tema.
    c := ColorToRGB(StringToColor(valorIni));
  except
    Exit(COR_HEX_PADRAO);
  end;

  //Bytes invertidos em relacao ao HTML, e a conta no lugar de GetRValue e
  //companhia, que vem do Windows. IntToHex ja devolve maiusculo.
  Result := '#' + IntToHex(c and $FF, 2)
                + IntToHex((c shr 8) and $FF, 2)
                + IntToHex((c shr 16) and $FF, 2);
end;

function HexParaCor(const hex: string): TColor;
var
  s: string;
  r, g, b: Integer;
begin
  s := Trim(hex);

  if (Length(s) <> 7) or (s[1] <> '#') then
    Exit(TColor($004F0000));

  r := StrToIntDef('$' + Copy(s, 2, 2), -1);
  g := StrToIntDef('$' + Copy(s, 4, 2), -1);
  b := StrToIntDef('$' + Copy(s, 6, 2), -1);

  if (r < 0) or (g < 0) or (b < 0) then
    Exit(TColor($004F0000));

  Result := TColor(r or (g shl 8) or (b shl 16));
end;

function HexParaCorIni(const hex: string): string;
begin
  //ColorToString devolve o identificador quando a cor tem nome, que e
  //exatamente o que o fmLiturgia grava hoje.
  Result := ColorToString(HexParaCor(hex));
end;

{ ------------------------------------------------------------------- tipos }

function tipoParaJson(const tipoIni: string): string;
begin
  if SameText(tipoIni, 'categoria') then
    Result := 'bloco'
  else if SameText(tipoIni, 'itensagendados') then
    Result := 'itens-agendados'
  else
    Result := LowerCase(Trim(tipoIni));

  if (Result = '') then
    Result := 'anotacao';
end;

function tipoDoJson(const tipoJson: string): string;
var
  t: string;
begin
  t := LowerCase(Trim(tipoJson));

  //bloco e itens-agendados sao a grafia nova; categoria e itensagendados sao
  //os dois apelidos legados, que precisam continuar sendo lidos.
  if (t = 'bloco') or (t = 'categoria') then
    Result := 'categoria'
  else if (t = 'itens-agendados') or (t = 'itensagendados') then
    Result := 'itensagendados'
  else if (t = 'anotacao') or (t = 'arquivo') or (t = 'musica') or (t = 'site') then
    Result := t
  else
    //Os cinco tipos de fora que o desktop nao implementa caem aqui. Viram
    //anotacao para poderem ser exibidos, e o tipo original fica guardado.
    Result := '';
end;

{ -------------------------------------------------------------------- dias }

function diaParaJson(dia: Integer): Integer;
begin
  Result := dia - 1;
end;

function diaDoJson(dia: Integer): Integer;
begin
  Result := dia + 1;
end;

{ ------------------------------------------------------------- TItemTroca }

constructor TItemTroca.Create;
begin
  inherited Create;
  FCampos := TStringList.Create;
  FBrutos := TStringList.Create;
end;

destructor TItemTroca.Destroy;
begin
  FBrutos.Free;
  FCampos.Free;
  inherited;
end;

function TItemTroca.valor(const chave: string): string;
begin
  Result := FCampos.Values[chave];
end;

procedure TItemTroca.poe(const chave, v: string);
var
  i: Integer;
begin
  //Values[x] := '' apaga a entrada, o que para o INI da no mesmo: quem le
  //passa um padrao. Mas a chave nao pode ficar marcada como bruta.
  i := FBrutos.IndexOf(chave);
  if (i >= 0) then
    FBrutos.Delete(i);

  FCampos.Values[chave] := umaLinha(v);
end;

procedure TItemTroca.poeBruto(const chave, jsonPronto: string);
begin
  FCampos.Values[chave] := umaLinha(jsonPronto);

  if (FBrutos.IndexOf(chave) < 0) then
    FBrutos.Add(chave);
end;

function TItemTroca.ehBruto(const chave: string): Boolean;
begin
  Result := FBrutos.IndexOf(chave) >= 0;
end;

function TItemTroca.comoJson(const recuo: string): string;
var
  linhas: TStringList;
  i: Integer;
  chave, v, nomeJson, tipoIni: string;
begin
  linhas := TStringList.Create;
  try
    linhas.Add(jsonParTexto(recuo, 'id', ident));

    //O tipo vai na grafia nova; quando o item veio de um dos tipos que o
    //desktop nao implementa, o original e que vale.
    tipoIni := valor('tipo');
    if (valor(CHAVE_TIPO_ORIGINAL) <> '')
      then linhas.Add(jsonParTexto(recuo, 'tipo', valor(CHAVE_TIPO_ORIGINAL)))
      else linhas.Add(jsonParTexto(recuo, 'tipo', tipoParaJson(tipoIni)));

    for i := 0 to FCampos.Count - 1 do
    begin
      chave := FCampos.Names[i];
      v := FCampos.ValueFromIndex[i];

      //Ja gravados acima, ou traduzidos.
      if SameText(chave, 'tipo') or SameText(chave, CHAVE_TIPO_ORIGINAL) then
        Continue;

      if SameText(chave, 'cor') then
      begin
        linhas.Add(jsonParTexto(recuo, 'cor', CorParaHex(v)));
        Continue;
      end;

      if SameText(chave, CHAVE_CATEGORIA_INI) then
      begin
        linhas.Add(jsonParTexto(recuo, CHAVE_CATEGORIA_JSON, v));
        Continue;
      end;

      nomeJson := chave;

      if ehBruto(chave) then
        linhas.Add(jsonParBruto(recuo, nomeJson, v))
      else if estaEm(chave, CAMPOS_BOOL) then
        linhas.Add(jsonParBruto(recuo, nomeJson, jsonBool(v = '1')))
      else if estaEm(chave, CAMPOS_NUMERO) then
      begin
        if SameText(chave, 'musica')
          then linhas.Add(jsonParBruto(recuo, nomeJson, IntToStr(StrToIntDef(v, -1))))
          else linhas.Add(jsonParBruto(recuo, nomeJson, IntToStr(StrToIntDef(v, 0))));
      end
      else
        linhas.Add(jsonParTexto(recuo, nomeJson, v));
    end;

    Result := '';
    for i := 0 to linhas.Count - 1 do
    begin
      Result := Result + linhas[i];

      if (i < linhas.Count - 1) then
        Result := Result + ',';

      Result := Result + sLineBreak;
    end;
  finally
    linhas.Free;
  end;
end;

{ ---------------------------------------------------------- TLiturgiaTroca }

constructor TLiturgiaTroca.Create;
begin
  inherited Create;

  FItens := TStringList.Create;
  FItens.OwnsObjects := True;

  corHex := COR_HEX_PADRAO;
  vinculo.presente := False;
end;

destructor TLiturgiaTroca.Destroy;
begin
  FItens.Free;
  inherited;
end;

function TLiturgiaTroca.adicionaItem(const ident: string): TItemTroca;
begin
  Result := TItemTroca.Create;
  Result.ident := ident;
  FItens.AddObject(ident, Result);
end;

function TLiturgiaTroca.item(i: Integer): TItemTroca;
begin
  Result := TItemTroca(FItens.Objects[i]);
end;

function TLiturgiaTroca.diaDoVinculo: Integer;
var
  d: Integer;
begin
  Result := 0;

  if (not vinculo.presente) or (not SameText(vinculo.tipo, 'day_of_week')) then
    Exit;

  d := StrToIntDef(Trim(vinculo.valor), -1);

  if (d >= 0) and (d <= 6) then
    Result := diaDoJson(d);
end;

procedure TLiturgiaTroca.aplicaEm(doc: TCustomIniFile; dia: Integer);
var
  antigos: TStringList;
  i, k: Integer;
  it: TItemTroca;
  ordem: string;
begin
  //Apaga as secoes do que havia neste dia, senao item removido continuaria
  //no arquivo depois de a ordem deixar de citar ele.
  antigos := TStringList.Create;
  try
    antigos.Delimiter := ';';
    antigos.StrictDelimiter := True;
    antigos.DelimitedText := doc.ReadString('Geral', IntToStr(dia), '');

    for i := 0 to antigos.Count - 1 do
      if (Trim(antigos[i]) <> '') then
        doc.EraseSection(Trim(antigos[i]));
  finally
    antigos.Free;
  end;

  ordem := '';

  for i := 0 to FItens.Count - 1 do
  begin
    it := item(i);

    for k := 0 to it.campos.Count - 1 do
      doc.WriteString(it.ident, it.campos.Names[k], it.campos.ValueFromIndex[k]);

    if (ordem <> '') then
      ordem := ordem + ';';

    ordem := ordem + it.ident;
  end;

  doc.WriteString('Geral', IntToStr(dia), ordem);
  doc.WriteString('Geral', 'AlteraOrdem-' + IntToStr(dia),
                  FormatDateTime('dd/mm/yyyy hh:nn:ss', Now));
end;

function TLiturgiaTroca.corpoJson(const recuo: string;
  comVinculo: Boolean): string;
var
  i: Integer;
  recuoItem, recuoCampo: string;
begin
  recuoItem := recuo + '  ';
  recuoCampo := recuoItem + '  ';

  Result := jsonParTexto(recuo, 'name', nome) + ',' + sLineBreak
          + jsonParTexto(recuo, 'color', corHex) + ',' + sLineBreak;

  if (comVinculo and vinculo.presente) then
  begin
    if (vinculo.bruto <> '')
      then Result := Result + jsonParBruto(recuo, 'binding', vinculo.bruto)
      else Result := Result + jsonParBruto(recuo, 'binding',
             '{ ' + jsonParTexto('', 'type', vinculo.tipo) + ', '
                  + jsonParTexto('', 'value', vinculo.valor) + ' }');

    Result := Result + ',' + sLineBreak;
  end;

  Result := Result + recuo + '"items": [';

  if (FItens.Count = 0) then
  begin
    Result := Result + ']' + sLineBreak;
    Exit;
  end;

  Result := Result + sLineBreak;

  for i := 0 to FItens.Count - 1 do
  begin
    Result := Result + recuoItem + '{' + sLineBreak
                     + item(i).comoJson(recuoCampo)
                     + recuoItem + '}';

    if (i < FItens.Count - 1) then
      Result := Result + ',';

    Result := Result + sLineBreak;
  end;

  Result := Result + recuo + ']' + sLineBreak;
end;

function TLiturgiaTroca.comoJson(comVinculo: Boolean): string;
begin
  Result := '{' + sLineBreak
          + jsonParBruto('  ', 'schema', IntToStr(SCHEMA_TROCA)) + ',' + sLineBreak
          + jsonParTexto('  ', 'exportedAt', agoraIso) + ',' + sLineBreak
          + corpoJson('  ', comVinculo)
          + '}' + sLineBreak;
end;

{ ----------------------------------------------------------- TColecaoTroca }

constructor TColecaoTroca.Create;
begin
  inherited Create;

  FLiturgias := TStringList.Create;
  FLiturgias.OwnsObjects := True;
end;

destructor TColecaoTroca.Destroy;
begin
  FLiturgias.Free;
  inherited;
end;

procedure TColecaoTroca.adiciona(lit: TLiturgiaTroca);
begin
  FLiturgias.AddObject(lit.nome, lit);
end;

function TColecaoTroca.liturgia(i: Integer): TLiturgiaTroca;
begin
  Result := TLiturgiaTroca(FLiturgias.Objects[i]);
end;

function TColecaoTroca.comoJson: string;
var
  i: Integer;
begin
  Result := '{' + sLineBreak
          + jsonParBruto('  ', 'schema', IntToStr(SCHEMA_TROCA)) + ',' + sLineBreak
          + jsonParTexto('  ', 'exportedAt', agoraIso) + ',' + sLineBreak
          + '  "liturgies": [';

  if (FLiturgias.Count = 0) then
    Exit(Result + ']' + sLineBreak + '}' + sLineBreak);

  Result := Result + sLineBreak;

  for i := 0 to FLiturgias.Count - 1 do
  begin
    //Cada entrada leva o seu proprio binding: e assim que o dia da semana
    //viaja no backup, porque o envelope nao tem campo de dia.
    Result := Result + '    {' + sLineBreak
                     + liturgia(i).corpoJson('      ', True)
                     + '    }';

    if (i < FLiturgias.Count - 1) then
      Result := Result + ',';

    Result := Result + sLineBreak;
  end;

  Result := Result + '  ]' + sLineBreak + '}' + sLineBreak;
end;

{ ----------------------------------------------------------------- leitura }

procedure confereSchema(obj: TJSONObject);
var
  v: TJSONValue;
  txt: string;
begin
  v := obj.GetValue('schema');

  //Ausente e lido como 1: ja existem arquivos exportados antes do
  //versionamento, e recusar eles quebraria o que o operador tem salvo.
  if (v = nil) then
    Exit;

  txt := Trim(textoDoValor(v));

  if (StrToIntDef(txt, -1) <> SCHEMA_TROCA) then
    raise Exception.Create(
      'Esta liturgia esta no formato ' + txt + ', que este LouvorJA nao conhece.' +
      sLineBreak + 'Atualize o programa para abri-la.');
end;

procedure leVinculo(obj: TJSONObject; var vinc: TVinculoTroca);
var
  v: TJSONValue;
  o: TJSONObject;
begin
  vinc.presente := False;
  vinc.tipo := '';
  vinc.valor := '';
  vinc.bruto := '';

  v := obj.GetValue('binding');

  if (v = nil) or not (v is TJSONObject) then
    Exit;

  o := TJSONObject(v);
  vinc.presente := True;
  vinc.tipo := textoDoValor(o.GetValue('type'));
  vinc.valor := textoDoValor(o.GetValue('value'));

  //Tipo que nao conhecemos e preservado como veio e tratado como sem regra.
  //Nunca recusa o arquivo -- a recusa e so do schema.
  if not (SameText(vinc.tipo, 'day_of_week') or SameText(vinc.tipo, 'date') or
          SameText(vinc.tipo, 'thirteenth_sabbath')) then
    vinc.bruto := o.ToString;
end;

//Deixa o item executavel pelo Delphi. A combinacao musica = -1 com
//escolha = false, que sao os DOIS padroes do formato, levanta excecao na
//reproducao (o fmMenu faz StrToInt('0' + '-1')). A unica leitura que o
//programa sabe executar nesse caso e "a escolher", que e o que o btAddClick
//grava junto com o -1.
procedure normalizaMusica(it: TItemTroca);
var
  m: Integer;
begin
  if not SameText(it.valor('tipo'), 'musica') then
    Exit;

  m := StrToIntDef(it.valor('musica'), -1);

  if (m > 0) then
  begin
    it.poe('musica', IntToStr(m));
    it.poe('escolha', '0');
    Exit;
  end;

  it.poe('musica', '-1');
  it.poe('escolha', '1');

  if (it.valor('subtipo') = '') then
    it.poe('subtipo', 'escolha');
end;

function leItem(obj: TJSONObject; lit: TLiturgiaTroca): TItemTroca;
var
  i: Integer;
  chave, v, ident, tipoIni, tipoJson: string;
  par: TJSONPair;
begin
  //Preserva o id que veio em vez de gerar outro: regerar trocaria todos os
  //ids a cada round-trip e quebraria as referencias de blocoId.
  ident := identSeguro(textoDoValor(obj.GetValue('id')));

  if (ident = '') then
    ident := 'item_' + FormatDateTime('yyyymmddhhnnsszzz', Now);

  Result := lit.adicionaItem(ident);

  tipoJson := textoDoValor(obj.GetValue('tipo'));
  tipoIni := tipoDoJson(tipoJson);

  if (tipoIni = '') then
  begin
    //Tipo que o desktop nao implementa: exibe como anotacao e guarda o
    //original, para reexportar sem perder conteudo.
    Result.poe('tipo', 'anotacao');

    if (Trim(tipoJson) <> '') then
      Result.poe(CHAVE_TIPO_ORIGINAL, Trim(tipoJson));
  end
  else
    Result.poe('tipo', tipoIni);

  for i := 0 to obj.Count - 1 do
  begin
    par := obj.Pairs[i];
    chave := par.JsonString.Value;

    //id e o nome da secao; tipo ja foi tratado.
    if SameText(chave, 'id') or SameText(chave, 'tipo') then
      Continue;

    v := textoDoValor(par.JsonValue);

    if SameText(chave, 'cor') then
    begin
      Result.poe('cor', HexParaCorIni(v));
      Continue;
    end;

    //A categoria do item agendado volta para o id= da secao.
    if SameText(chave, CHAVE_CATEGORIA_JSON) then
    begin
      Result.poe(CHAVE_CATEGORIA_INI, v);
      Continue;
    end;

    if estaEm(chave, CAMPOS_BOOL) then
    begin
      if (v = '1') or SameText(v, 'true')
        then Result.poe(chave, '1')
        else Result.poe(chave, '0');

      Continue;
    end;

    //Referencia ao bloco: limpa igual ao id, senao deixa de casar com ele.
    if SameText(chave, 'blocoId') then
    begin
      Result.poe(chave, identSeguro(v));
      Continue;
    end;

    //Objeto ou array de uma versao mais nova volta como veio.
    if (par.JsonValue is TJSONObject) or (par.JsonValue is TJSONArray) then
    begin
      Result.poeBruto(chave, par.JsonValue.ToString);
      Continue;
    end;

    Result.poe(chave, v);
  end;

  if (Result.valor('cor') = '') then
    Result.poe('cor', COR_INI_PADRAO);

  if (Result.valor('dir_info') = '') then
    Result.poe('dir_info', 'E');

  normalizaMusica(Result);
end;

function leLiturgia(obj: TJSONObject): TLiturgiaTroca;
var
  v: TJSONValue;
  arr: TJSONArray;
  i: Integer;
begin
  Result := TLiturgiaTroca.Create;
  try
    Result.nome := textoDoValor(obj.GetValue('name'));

    v := obj.GetValue('color');
    if (v <> nil) then
      Result.corHex := textoDoValor(v);

    if (Trim(Result.corHex) = '') then
      Result.corHex := COR_HEX_PADRAO;

    leVinculo(obj, Result.vinculo);

    v := obj.GetValue('items');

    if (v = nil) or not (v is TJSONArray) then
      raise Exception.Create('Liturgia: falta a lista de itens ("items").');

    arr := TJSONArray(v);

    //Leitura tolerante: descarta so o elemento que nao e objeto, para um
    //arquivo de versao mais nova nao quebrar uma versao mais antiga.
    for i := 0 to arr.Count - 1 do
      if (arr.Items[i] is TJSONObject) then
        leItem(TJSONObject(arr.Items[i]), Result);

    if (arr.Count > 0) and (Result.itens.Count = 0) then
      raise Exception.Create('Liturgia: nenhum item do arquivo pode ser lido.');
  except
    Result.Free;
    raise;
  end;
end;

function leJsonTroca(const texto: string): TColecaoTroca;
var
  raiz: TJSONValue;
  obj: TJSONObject;
  v: TJSONValue;
  arr: TJSONArray;
  i: Integer;
begin
  raiz := TJSONObject.ParseJSONValue(texto);

  if (raiz = nil) then
    raise Exception.Create('Liturgia: nao foi possivel ler o JSON.');

  try
    if not (raiz is TJSONObject) then
      raise Exception.Create('Liturgia: o JSON precisa comecar com um objeto.');

    obj := TJSONObject(raiz);

    confereSchema(obj);

    Result := TColecaoTroca.Create;
    try
      //Qual forma do envelope: liturgies e colecao, senao items e liturgia
      //unica. Vindo os dois, vale liturgies.
      v := obj.GetValue('liturgies');

      if (v <> nil) and (v is TJSONArray) then
      begin
        arr := TJSONArray(v);

        for i := 0 to arr.Count - 1 do
          if (arr.Items[i] is TJSONObject) then
            Result.adiciona(leLiturgia(TJSONObject(arr.Items[i])));
      end
      else if (obj.GetValue('items') is TJSONArray) then
        Result.adiciona(leLiturgia(obj))
      else
        raise Exception.Create(
          'Este arquivo nao parece ser uma liturgia: falta "items" ou "liturgies".');

      if (Result.liturgias.Count = 0) then
        raise Exception.Create('Liturgia: o arquivo nao tem nenhuma liturgia.');
    except
      Result.Free;
      raise;
    end;
  finally
    raiz.Free;
  end;
end;

{ ---------------------------------------------------------------- gravacao }

function liturgiaDoDia(doc: TCustomIniFile; dia: Integer;
  const nome: string): TLiturgiaTroca;
var
  ordem, chaves: TStringList;
  i, k: Integer;
  ident: string;
  it: TItemTroca;
begin
  Result := TLiturgiaTroca.Create;
  try
    Result.nome := nome;

    ordem := TStringList.Create;
    try
      ordem.Delimiter := ';';
      ordem.StrictDelimiter := True;
      ordem.DelimitedText := doc.ReadString('Geral', IntToStr(dia), '');

      for i := 0 to ordem.Count - 1 do
      begin
        ident := Trim(ordem[i]);

        if (ident = '') then
          Continue;

        it := Result.adicionaItem(ident);

        chaves := TStringList.Create;
        try
          doc.ReadSection(ident, chaves);

          for k := 0 to chaves.Count - 1 do
            it.poe(chaves[k], doc.ReadString(ident, chaves[k], ''));
        finally
          chaves.Free;
        end;

        if (it.valor('cor') = '') then
          it.poe('cor', COR_INI_PADRAO);
      end;
    finally
      ordem.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.
