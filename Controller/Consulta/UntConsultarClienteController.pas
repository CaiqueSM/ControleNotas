unit UntConsultarClienteController;

interface

uses UntBaseController, System.Generics.Collections, UntClienteModel,
  UntClienteDao, System.Classes, SysUtils;

type
  TConsultaClienteController = class(TBaseController)
  private
    FDao: TClienteDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ListarNomesClientes(): TStringList;
  end;

implementation

{ TConsultaClienteController }

constructor TConsultaClienteController.Create;
begin
  inherited Create();
  FDao := TClienteDao.Create(Conexao);
end;

destructor TConsultaClienteController.Destroy;
begin
  FDao.Free;
  inherited;
end;

function TConsultaClienteController.ListarNomesClientes: TStringList;
var
  Clientes: TObjectList<TClienteModel>;
  Cliente: TClienteModel;
begin
  Result := TStringList.Create();
  Clientes := FDao.ListarClientes();
  Try
    For Cliente In Clientes Do
      Result.Add(Cliente.nome);
  Finally
    Clientes.Free;
  End;
end;

end.
