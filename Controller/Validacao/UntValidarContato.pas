unit UntValidarContato;

interface

uses

  Classes, SysUtils, System.RegularExpressions;

type

  TValidarContato = class
  public
    function ValidarCEP(ACEP: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarNumero(ANumero: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
  end;

implementation

function TValidarContato.ValidarCEP(ACEP: string): boolean;
var
  regex: TRegEx;
  padraoRegExCEP: string;
begin
  padraoRegExCEP := '^\d{5}-\d{3}$';
  regex := TRegEx.Create(padraoRegExCEP);
  Result := regex.IsMatch(ACEP);
end;

function TValidarContato.ValidarEmail(AEmail: string): boolean;
var
  regex: TRegEx;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '\w*@[a-zA-Z]{1,15}\.[a-zA-Z]{3}(\.[a-zA-Z]{2,3})?';
  regex := TRegEx.Create(padraoRegexEmail);
  Result := regex.IsMatch(AEmail);
end;

function TValidarContato.ValidarNumero(ANumero: string): boolean;
begin
  Result := not(ANumero.IsNullOrEmpty(ANumero));
end;

function TValidarContato.ValidarTelefone(ATelefone: string): boolean;
var
  regex: TRegEx;
  padraoRegExTelefone: string;
begin
  padraoRegExTelefone := '^\([0-9]{2}\)([0-9]{5}[0-9]{4})|([0-9]{4}[0-9]{4})$';
  regex := TRegEx.Create(padraoRegExTelefone);
  Result := regex.IsMatch(ATelefone);
end;

end.
