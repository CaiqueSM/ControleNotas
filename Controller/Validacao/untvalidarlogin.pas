unit UntValidarLogin;

interface

uses
  Classes, SysUtils, System.RegularExpressions;

type

  { TValidarLogin }

  TValidarLogin = class
  public
    function ValidarUsuario(AUsuario: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarSenhaUsuario(ASenha: string): boolean;
  end;

implementation

{ TValidarLogin }

function TValidarLogin.ValidarUsuario(AUsuario: string): boolean;
var
  regex: TRegEx;
  padraoRegexNome: string;
begin
  padraoRegexNome := '\s?[a-zA-Z_]{1,80}[\w]{0,79}';
  regex := TRegEx.Create(padraoRegexNome);
  Result := regex.IsMatch(AUsuario);
end;

function TValidarLogin.ValidarEmail(AEmail: string): boolean;
var
  regex: TRegEx;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  regex := TRegEx.Create(padraoRegexEmail);
  Result := regex.IsMatch(AEmail);
end;

function TValidarLogin.ValidarSenhaUsuario(ASenha: string): boolean;
var
  tamanhoSenha: integer;
begin
  tamanhoSenha := 4;
  Result := (length(ASenha) >= tamanhoSenha);
end;

end.

