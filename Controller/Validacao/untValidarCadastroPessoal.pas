unit untValidarCadastroPessoal;

interface

uses
  Classes, SysUtils, System.RegularExpressions;

type

  { TValidarCadastro }

  TValidarCadastro = class
  public
    function ValidarCadastroPessoal(ACNPJCPF: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarCEP(ACEP: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
  private
    function ValidarCNPJ(ACNPJ: string): boolean;
    function ValidarCPF(ACPF: string): boolean;
  end;

implementation

{ TValidarCadastro }

function TValidarCadastro.ValidarCEP(ACEP: string): boolean;
var
  regex: TRegEx;
  padraoRegExCEP: string;
begin
  padraoRegExCEP := '^\d{5}-\d{3}$';
  regex := TRegEx.Create(padraoRegExCEP);
  Result := regex.IsMatch(ACEP);
end;

function TValidarCadastro.ValidarCPF(ACPF: string): boolean;
var
  tamanhoCPF, numeroSoma, resto, indiceCPF: integer;
  digitoVerificador: array [0 .. 1] of integer;
begin
  tamanhoCPF := 11;
  Trim(ACPF);
  numeroSoma:= 0;

  for indiceCPF := 1 to tamanhoCPF do
  begin
    numeroSoma := numeroSoma + strTOint(ACPF[indiceCPF]) * tamanhoCPF - 1;
  end;

  resto := tamanhoCPF - (numeroSoma mod tamanhoCPF);

  if (tamanhoCPF - resto) > 9 then
    digitoVerificador[0] := 0
  else
    digitoVerificador[0] := resto;

  numeroSoma := 0;

  for indiceCPF := 1 to tamanhoCPF - 1 do
  begin
    numeroSoma := numeroSoma + strTOint(ACPF[indiceCPF]) * tamanhoCPF;
  end;

  resto := tamanhoCPF - (numeroSoma mod tamanhoCPF);

  if (tamanhoCPF - resto) > 9 then
    digitoVerificador[1] := 0
  else
    digitoVerificador[1] := resto;

  Result := (digitoVerificador[0] = strTOint(ACPF[9])) and
    (digitoVerificador[1] = strTOint(ACPF[10]));
end;

function TValidarCadastro.ValidarCNPJ(ACNPJ: string): boolean;
var
  pesoCNPJ: array of integer;
  digitoVerificador: array [0 .. 1] of integer;
  tamanhoCNPJ, numeroSoma, resto, indiceCNPJ: integer;

begin
  pesoCNPJ := [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  tamanhoCNPJ := 12;
  numeroSoma := 0;

  for indiceCNPJ := 1 to tamanhoCNPJ do
  begin
    numeroSoma := numeroSoma + strTOint(ACNPJ[indiceCNPJ]) *
      pesoCNPJ[indiceCNPJ];
  end;

  resto := tamanhoCNPJ - (numeroSoma mod tamanhoCNPJ - 1);

  if resto < 2 then
    digitoVerificador[0] := 0
  else
    digitoVerificador[0] := (tamanhoCNPJ - 1) - resto;

  pesoCNPJ := [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  numeroSoma := 0;

  for indiceCNPJ := 1 to tamanhoCNPJ + 1 do
  begin
    numeroSoma := numeroSoma + strTOint(ACNPJ[indiceCNPJ]) *
      pesoCNPJ[indiceCNPJ];
  end;

  resto := tamanhoCNPJ - (numeroSoma mod tamanhoCNPJ - 1);

  if resto < 2 then
    digitoVerificador[1] := 0
  else
    digitoVerificador[1] := (tamanhoCNPJ - 1) - resto;

  Result := (digitoVerificador[0] = strTOint(ACNPJ[9])) and
    (digitoVerificador[1] = strTOint(ACNPJ[10]));
end;

function TValidarCadastro.ValidarCadastroPessoal(ACNPJCPF: string): boolean;
var
  regex: TRegEx;
  padraoRegexCNPJ: string;
  padraoRegExCPF: string;
begin
  Result := false;
  padraoRegexCNPJ := '^\d{3}.?\d{3}.?\d{3}/?\d{3}-?\d{2}$';
  regex := TRegEx.Create(padraoRegexCNPJ);

  if regex.IsMatch(Trim(ACNPJCPF)) then
  begin
    Result := ValidarCNPJ(Trim(ACNPJCPF));
    exit();
  end;

  padraoRegExCPF := '^\d{3}\x2E\d{3}\x2E\d{3}\x2D\d{2}$';
  regex := TRegEx.Create(padraoRegExCPF);

  if regex.IsMatch(Trim(ACNPJCPF)) then
  begin
    Result := ValidarCPF(Trim(ACNPJCPF));
    exit();
  end;
end;

function TValidarCadastro.ValidarEmail(AEmail: string): boolean;
var
  regex: TRegEx;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  regex := TRegEx.Create(padraoRegexEmail);
  Result := regex.IsMatch(AEmail);
end;

function TValidarCadastro.ValidarTelefone(ATelefone: string): boolean;
var
  regex: TRegEx;
  padraoRegExTelefone: string;
begin
  padraoRegExTelefone := '^[0-9]{2}-[0-9]{5}-[0-9]{4}$';
  regex := TRegEx.Create(padraoRegExTelefone);
  Result := regex.IsMatch(ATelefone);
end;


end.
