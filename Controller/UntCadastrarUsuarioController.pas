unit UntCadastrarUsuarioController;

interface

uses untbasecontroller, UntCadastrarUsuarioDao, System.Generics.Collections,
  UntUsuarioModel, System.Classes;

type
  TCadastrarUsuarioController = class(TBaseController)
  private
    FDao: TCadastrarUsuarioDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TUsuarioModel;
  end;

implementation

{ TCadastrarUsuarioController }

function TCadastrarUsuarioController.Consultar(ANome: String): TUsuarioModel;
begin
   Result := FDao.Consultar(ANome);
end;

constructor TCadastrarUsuarioController.Create;
begin
  inherited;
  FDao := TCadastrarUsuarioDao.Create(Conexao);
end;

destructor TCadastrarUsuarioController.Destroy;
begin
  FDao.Free;
  inherited;
end;

end.
