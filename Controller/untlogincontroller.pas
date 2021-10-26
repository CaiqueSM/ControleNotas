unit UntLoginController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, RegExpr, sha1, UntLoginDao, UntValidarLogin,
  UntBaseController;

type

  { TLoginController }

  TLoginController = class(TBaseController)
  private
    FDao: TLoginDao;
    FValidar: TValidarLogin;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ValidarUsuario(AUsuario: String): boolean;
    function ValidarSenha(ASenha: String): boolean;

    function Autenticar(nomeLocal, nomeVisitante: string;
      senhaLocal, senhaVisitante: string): boolean;
  end;

implementation

{ TLoginController }

constructor TLoginController.Create();
begin
  inherited Create();
  FDao := TLoginDao.Create(Conexao);
  FValidar := TValidarLogin.Create();
end;

destructor TLoginController.Destroy();
begin
  FDao.Free;
  FValidar.Free;
  inherited Destroy();
end;

function TLoginController.ValidarUsuario(AUsuario: String): boolean;
begin
  result := FValidar.ValidarUsuario(AUsuario);
end;

function TLoginController.ValidarSenha(ASenha: String): boolean;
begin
  result := FValidar.ValidarSenhaUsuario(ASenha);
end;

function TLoginController.Autenticar(nomeLocal, nomeVisitante: string;
  senhaLocal, senhaVisitante: string): boolean;
var
  ANomeLocal, ANomeVisitante: TRegExpr;
  AsenhaLocal, AsenhaVisitante: TSHA1Digest;
begin
  ANomeLocal := TRegExpr.Create;
  ANomeVisitante := TRegExpr.Create;

  ANomeLocal.Expression := nomeLocal;
  ANomeVisitante.Expression := nomeVisitante;

  AsenhaLocal := SHA1String(senhaLocal);
  AsenhaVisitante := SHA1String(senhaVisitante);

  Result := (ANomeLocal.Equals(ANomeVIsitante) and
    SHA1Match(AsenhaLocal, AsenhaVisitante));
end;

end.
