unit uArquivosWeb;

interface

uses
  System.SysUtils, System.Classes;

function urlDoArquivo(const base, caminhoRemoto: string): string;
function codificaCaminhoURL(const caminho: string): string;
function codificaSegmentoURL(const texto: string): string;

implementation

function codificaSegmentoURL(const texto: string): string;
var
  bytes: TBytes;
  i: Integer;
  b: Byte;
begin
  Result := '';
  if (texto = '') then
    Exit;

  bytes := TEncoding.UTF8.GetBytes(texto);
  for i := 0 to High(bytes) do
  begin
    b := bytes[i];
    if ((b >= Ord('A')) and (b <= Ord('Z'))) or
       ((b >= Ord('a')) and (b <= Ord('z'))) or
       ((b >= Ord('0')) and (b <= Ord('9'))) or
       (b = Ord('-')) or (b = Ord('_')) or (b = Ord('.')) or (b = Ord('~')) then
      Result := Result + Chr(b)
    else
      Result := Result + '%' + IntToHex(b, 2);
  end;
end;

function codificaCaminhoURL(const caminho: string): string;
var
  partes: TStringList;
  i: Integer;
begin
  Result := '';

  partes := TStringList.Create;
  try
    partes.StrictDelimiter := True;
    partes.Delimiter := '/';
    partes.DelimitedText := StringReplace(caminho, '\', '/', [rfReplaceAll]);

    for i := 0 to partes.Count - 1 do
    begin
      if (Result <> '') then
        Result := Result + '/';
      Result := Result + codificaSegmentoURL(partes[i]);
    end;
  finally
    partes.Free;
  end;
end;

function urlDoArquivo(const base, caminhoRemoto: string): string;
var
  raiz, caminho: string;
begin
  Result := '';

  raiz := trim(base);
  caminho := trim(caminhoRemoto);
  if (raiz = '') or (caminho = '') then
    Exit;

  while (Copy(raiz, Length(raiz), 1) = '/') do
    raiz := Copy(raiz, 1, Length(raiz) - 1);
  while (Copy(caminho, 1, 1) = '/') do
    caminho := Copy(caminho, 2, Length(caminho));

  if (raiz = '') or (caminho = '') then
    Exit;

  Result := raiz + '/' + codificaCaminhoURL(caminho);
end;

end.
