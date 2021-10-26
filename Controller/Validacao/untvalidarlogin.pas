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
    function ValidarEmail(AEmail: String): boolean;
    function ValidarSenhaUsuario(ASenha: String): boolean;
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
    result := regex.Exec(AUsuario);
  finally
    regex.Free;
  end;
end;

function TValidarLogin.ValidarEmail(AEmail: String): boolean;
var
  regex: TRegExpr;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  regex := TRegExpr.Create();
  try
    regex.Expression := padraoRegexEmail;
    result := regex.Exec(AEmail);
  finally
    regex.Free;
  end;
end;

function TValidarLogin.ValidarSenhaUsuario(ASenha: String): boolean;
var
  tamanhoSenha: Integer;
begin
  result := (length(ASenha) >= tamanhoSenha)
end;

end.

