unit UntValidarLogin;

interface

uses
  Classes, SysUtils, System.RegularExpressions;

type

  { TValidarLogin }

  TValidarLogin = class
  public
    function ValidarUsuario(AUsuario: string): boolean;
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

function TValidarLogin.ValidarSenhaUsuario(ASenha: string): boolean;
var
  tamanhoSenha: integer;
begin
  tamanhoSenha := 4;
  Result := (length(ASenha) >= tamanhoSenha);
end;

end.
