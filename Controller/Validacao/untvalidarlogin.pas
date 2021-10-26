unit UntValidarLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, RegExpr;

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
  regex: TRegExpr;
  padraoRegexNome: string;
begin
  padraoRegexNome := '\s?[a-zA-Z_]{1,80}[\w]{0,79}';
  regex := TRegExpr.Create();
  try
    regex.Expression := padraoRegexNome;
    Result := regex.Exec(AUsuario);
  finally
    regex.Free;
  end;
end;

function TValidarLogin.ValidarEmail(AEmail: string): boolean;
var
  regex: TRegExpr;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  regex := TRegExpr.Create();
  try
    regex.Expression := padraoRegexEmail;
    Result := regex.Exec(AEmail);
  finally
    regex.Free;
  end;
end;

function TValidarLogin.ValidarSenhaUsuario(ASenha: string): boolean;
var
  tamanhoSenha: integer;
begin
  tamanhoSenha := 4;
  Result := (length(ASenha) >= tamanhoSenha);
end;

end.

