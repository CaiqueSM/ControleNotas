unit UntConsultaUsuarioController;

interface

uses UntBaseController, System.Generics.Collections, UntUsuarioModel,
  UntCadastrarUsuarioDao, System.Classes;

type
  TConsultaUsuarioController = class(TBaseController)
  private
    FDao: TCadastrarUsuarioDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ListarNomesUsuarios(): TStringList;
  end;

implementation

{ TConsultaUsuarioController }

constructor TConsultaUsuarioController.Create;
begin
  inherited Create();
  FDao := TCadastrarUsuarioDao.Create(Conexao);
end;

destructor TConsultaUsuarioController.Destroy;
begin
  FDao.Free;
  inherited;
end;

function TConsultaUsuarioController.ListarNomesUsuarios: TStringList;
var
  usuarios: TObjectList<TUsuarioModel>;
  usuario: TUsuarioModel;
begin
   Result := TStringList.Create();
   usuarios := FDao.ListarUsuarios();
   Try
      For usuario In usuarios Do
         Result.Add(usuario.Nome);
   Finally
      usuarios.Free;
   End;
end;

end.
