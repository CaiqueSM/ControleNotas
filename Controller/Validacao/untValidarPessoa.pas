unit untValidarPessoa;

interface

uses
  Classes, SysUtils, System.RegularExpressions;

type

  { TValidarCadastro }

  TValidarPessoa = class
  public
    function ValidarNumeroCadastroPessoal(ANumero: string): boolean;
    function ValidarNome(ANome: string): boolean;
  private
    function ValidarCNPJ(ACNPJ: string): boolean;
    function ValidarCPF(ACPF: string): boolean;
  end;

implementation

{ TValidarCadastro }


function TValidarPessoa.ValidarCPF(ACPF: string): boolean;
var
  tamanhoCPF, numeroSoma, resto, indiceCPF: integer;
  digitoVerificador: array [0 .. 1] of integer;
  regraDigitoVerificador: integer;
begin
  tamanhoCPF := 11;
  Trim(ACPF);
  numeroSoma:= 0;
  regraDigitoVerificador:= 9;

  for indiceCPF := 1 to tamanhoCPF-2 do
  begin
    numeroSoma := numeroSoma + strTOint(ACPF[indiceCPF]) * (tamanhoCPF - indiceCPF);
  end;

  resto := tamanhoCPF - (numeroSoma mod tamanhoCPF);

  if (tamanhoCPF - resto) > regraDigitoVerificador then
    digitoVerificador[0] := 0
  else
    digitoVerificador[0] := resto;

  numeroSoma := 0;

  for indiceCPF := 1 to tamanhoCPF - 1 do
  begin
    numeroSoma := numeroSoma + strTOint(ACPF[indiceCPF]) * ((tamanhoCPF+1) -indiceCPF);
  end;

  resto := tamanhoCPF - (numeroSoma mod tamanhoCPF);

  if (tamanhoCPF - resto) > regraDigitoVerificador then
    digitoVerificador[1] := 0
  else
    digitoVerificador[1] := resto;

  Result := (digitoVerificador[0] = strTOint(ACPF[10])) and
    (digitoVerificador[1] = strTOint(ACPF[11]));
end;

function TValidarPessoa.ValidarCNPJ(ACNPJ: string): boolean;
var
  pesoCNPJ: array of integer;
  digitoVerificador: array [0 .. 1] of integer;
  tamanhoCNPJ, numeroSoma, resto, indiceCNPJ: integer;
  regraDigitoVerificador: integer;

begin
  pesoCNPJ := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  tamanhoCNPJ := 12;
  numeroSoma := 0;
  regraDigitoVerificador:= 2;

  for indiceCNPJ := 1 to tamanhoCNPJ do
  begin
    numeroSoma := numeroSoma + strTOint(ACNPJ[indiceCNPJ]) *
      pesoCNPJ[indiceCNPJ-1];
  end;

  resto := (numeroSoma mod (tamanhoCNPJ - 1));

  if resto < regraDigitoVerificador then
    digitoVerificador[0] := 0
  else
    digitoVerificador[0] := (tamanhoCNPJ - 1) - resto;

  pesoCNPJ := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  numeroSoma := 0;

  for indiceCNPJ := 1 to tamanhoCNPJ + 1 do
  begin
    numeroSoma := numeroSoma + strTOint(ACNPJ[indiceCNPJ]) *
      pesoCNPJ[indiceCNPJ-1];
  end;

  resto := (numeroSoma mod (tamanhoCNPJ - 1));

  if resto < regraDigitoVerificador then
    digitoVerificador[1] := 0
  else
    digitoVerificador[1] := (tamanhoCNPJ - 1) - resto;

  Result := (digitoVerificador[0] = strTOint(ACNPJ[13])) and
    (digitoVerificador[1] = strTOint(ACNPJ[14]));
end;

function TValidarPessoa.ValidarNome(ANome: string): boolean;
var
  regex: TRegEx;
  padraoRegexNome: string;
begin
  padraoRegexNome := '\s?[a-zA-Z_]{1,80}[\w]{0,79}';
  regex := TRegEx.Create(padraoRegexNome);
  Result := regex.IsMatch(ANome);
end;

function TValidarPessoa.ValidarNumeroCadastroPessoal(ANumero: string): boolean;
var
  regex: TRegEx;
  padraoRegexCNPJ: string;
  padraoRegExCPF: string;
begin
  Result := false;
  padraoRegexCNPJ := '^\d{3}.?\d{3}.?\d{3}/?\d{3}-?\d{2}$';
  regex := TRegEx.Create(padraoRegexCNPJ);

  if regex.IsMatch(Trim(ANumero)) then
  begin
    Result := ValidarCNPJ(Trim(ANumero));
    exit();
  end;

  padraoRegExCPF := '^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$';
  regex := TRegEx.Create(padraoRegExCPF);

  if regex.IsMatch(Trim(ANumero)) then
  begin
    Result := ValidarCPF(Trim(ANumero));
    exit();
  end;
end;

end.
