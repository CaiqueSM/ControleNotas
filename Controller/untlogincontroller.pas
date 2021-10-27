unit UntLoginController;

interface

uses
  Classes, SysUtils, RegExpr, sha1, UntLoginDao, UntValidarLogin,
  UntBaseController, UntUsuarioModel, UntEnvironment;

type

  { TLoginController }

  TLoginController = class(TBaseController)
  private
    FDao: TLoginDao;
    FValidar: TValidarLogin;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ValidarUsuario(AUsuario: string): boolean;
    function ValidarSenha(ASenha: string): boolean;

    function Logar(AUsuario, ASenha: string): boolean;

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

function TLoginController.ValidarUsuario(AUsuario: string): boolean;
begin
  Result := FValidar.ValidarUsuario(AUsuario);
end;

function TLoginController.ValidarSenha(ASenha: string): boolean;
begin
  Result := FValidar.ValidarSenhaUsuario(ASenha);
end;

function TLoginController.Logar(AUsuario, ASenha: string): boolean;
var
  usuario: TUsuarioModel;
begin
  usuario := FDao.GetUsuario(AUsuario, ASenha);
  try
    Global.Usuario := usuario.Nome;
    Result := not usuario.Nome.Trim.IsEmpty;
  finally
    usuario.Free;
  end;
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
