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

  TValidarCliente = class
    function ValidarCNPJCPF(ACNPJCPF: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarCEP(ACEP: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
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

{ TValidarCliente }

function TValidarCliente.ValidarCEP(ACEP: string): boolean;
var
 regex: TRegEx;
 padraoRegExCEP: string;
begin
  padraoRegExCEP:= '^\d{5}-\d{3}$';
  regex:= TRegEx.Create(padraoRegExCEP);
  Result:= regex.IsMatch(ACEP);
end;

function TValidarCliente.ValidarCNPJCPF(ACNPJCPF: string): boolean;
var
  regex: TRegEx;
  padraoRegexCNPJCPF: string;
begin
  padraoRegexCNPJCPF := '/^(\d{2}\.?\d{3}\.?\d{3}\/?\d{4}-?\d{2})$/';
  regex := TRegEx.Create(padraoRegExCNPJCPF);
  Result := regex.IsMatch(ACNPJCPF);
end;

function TValidarCliente.ValidarEmail(AEmail: string): boolean;
var
  regex: TRegEx;
  padraoRegexEmail: string;
begin
  padraoRegexEmail := '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  regex := TRegEx.Create(padraoRegexEmail);
  Result := regex.IsMatch(AEmail);
end;

function TValidarCliente.ValidarTelefone(ATelefone: string): boolean;
var
regex: TRegEx;
  padraoRegExTelefone: string;
begin
  padraoRegExTelefone:='^[0-9]{2}-[0-9]{5}-[0-9]{4}$';
  regex:= TRegEx.Create(padraoRegExTelefone);
  Result:= regex.IsMatch(ATelefone);
end;

end.
