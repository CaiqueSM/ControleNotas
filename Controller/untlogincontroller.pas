unit UntLoginController;

interface

uses
  Classes, SysUtils, UntLoginDao, UntValidarLogin,
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
    Global.usuario := usuario.Nome;
    Result := not usuario.Nome.Trim.IsEmpty;
  finally
    usuario.Free;
  end;
end;

end.
