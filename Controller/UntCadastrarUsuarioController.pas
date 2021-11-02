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

    function ListarNomesUsuarios(): TStringList;
  end;

implementation

{ TCadastrarUsuarioController }

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

function TCadastrarUsuarioController.ListarNomesUsuarios(): TStringList;
begin
   Result := FDao.ListarNomesUsuarios();
end;

end.
