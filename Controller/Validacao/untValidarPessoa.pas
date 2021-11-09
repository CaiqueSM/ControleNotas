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
Var
   IntI, IntJ :Integer;
   IntD1,IntD2: Integer;
   StrDigitado, StrCalculado: string;
Begin
   Result := True;

   If Length(ACPF) <> 11 Then
      Begin
         Result := False;
         Exit;
      End;

   IntD1 := 0;
   IntJ := 2;
   For IntI := Length(ACPF) - 2 DownTo 1 Do
      Begin
         If Pos(Copy(ACPF, IntI, 1), '-.') = 0 Then
            Begin
               IntD1 := IntD1 + (StrToInt(Copy(ACPF, IntI, 1)) * IntJ);
               IntJ := IntJ + 1;
            End;
      End;

   IntD1 := 11-(IntD1 Mod 11);
   If IntD1 >= 10 then IntD1:=0;

   IntD2 := IntD1 * 2;
   IntJ := 3;
   For IntI := Length(ACPF) - 2 DownTo 1 Do
      Begin
         If Pos(Copy(ACPF, IntI, 1), '-.') = 0 Then
            Begin
               IntD2 := IntD2 + (StrToInt(Copy(ACPF, IntI, 1)) * IntJ);
               IntJ := IntJ + 1;
            End;
      End;

   IntD2 := 11 -(IntD2 Mod 11);
   If IntD2 >= 10 Then IntD2:=0;

   StrCalculado := IntToStr(IntD1) + IntToStr(IntD2);
   StrDigitado  := Copy(ACPF, Length(ACPF) - 1, 2);

   If StrCalculado <> StrDigitado then
      Result := False;
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

  if regex.IsMatch(ANumero) then
  begin
    Result := ValidarCNPJ(ANumero);
    exit();
  end;

  padraoRegExCPF := '[0-9]{11}';
  regex := TRegEx.Create(padraoRegExCPF);

  if regex.IsMatch(ANumero) then
  begin
    Result := ValidarCPF(ANumero);
    exit();
  end;
end;

end.
