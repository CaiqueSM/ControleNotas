unit UntUsuarioController;

interface

uses untbasecontroller, UntUsuarioDao, System.Generics.Collections,
  UntUsuarioModel, System.Classes;

type
  TUsuarioController = class(TBaseController)
  private
    FDao: TUsuarioDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TUsuarioModel; overload;
    function Consultar(AIdUsuario: Integer): TUsuarioModel; overload;
    function Criar(AUsuario: TUsuarioModel): Boolean;
    function Alterar(AUsuario: TUsuarioModel): Boolean;
    function Excluir(AIdUsuario: Integer): Boolean;

    function AutenticarSenha(AUsuario,
      ASenhaAtual: String): Boolean;
  end;

implementation

{ TUsuarioController }

constructor TUsuarioController.Create;
begin
  inherited;
  FDao := TUsuarioDao.Create(Conexao);
end;

destructor TUsuarioController.Destroy;
begin
  FDao.Free;
  inherited Destroy;
end;

function TUsuarioController.Excluir(AIdUsuario: Integer): Boolean;
begin
  Result := FDao.Excluir(AIdUsuario);
end;

function TUsuarioController.Criar(AUsuario: TUsuarioModel): Boolean;
begin
  Result := FDao.Criar(AUsuario);
end;

function TUsuarioController.Alterar(AUsuario: TUsuarioModel): Boolean;
begin
  Result := FDao.Alterar(AUsuario);
end;

function TUsuarioController.Consultar(ANome: String): TUsuarioModel;
begin
  Result := FDao.Consultar(ANome);
end;

function TUsuarioController.Consultar(AIdUsuario: Integer): TUsuarioModel;
begin
  Result := FDao.Consultar(AIdUsuario);
end;

function TUsuarioController.AutenticarSenha(AUsuario,
  ASenhaAtual: String): Boolean;
var
  usuario: TUsuarioModel;
begin
  usuario := Consultar(AUsuario);
  Try
    Result := (usuario.Senha = ASenhaAtual);
  Finally
    usuario.Free;
  End;
end;

end.
