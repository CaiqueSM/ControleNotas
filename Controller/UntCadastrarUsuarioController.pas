unit UntCadastrarUsuarioController;

interface

uses untbasecontroller, UntCadastrarUsuarioDao;

type
  TCadastrarUsuarioController = class(TBaseController)
  private
    FDao: TCadastrarUsuarioDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
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

end.
