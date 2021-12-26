unit UntConsultarClienteController;

interface

uses UntBaseController, System.Generics.Collections, UntClienteModel,
  UntClienteDao, System.Classes, SysUtils;

type

  ArrayInteger = array of integer;

  TConsultaClienteController = class(TBaseController)
  private
    FDao: TClienteDao;
    ListaIDClientes: ArrayInteger;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
    function ListarNomesClientes(): TStringList;
    property ListaID: ArrayInteger read ListaIDClientes;
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
  indice: integer;
begin
  Result := TStringList.Create();
  Clientes := FDao.ListarClientes();
  if Clientes = nil then
  begin
    Result := nil;
    exit();
  end;
  SetLength(ListaIDClientes, Clientes.Count);
  indice := 0;
  Try
    For Cliente In Clientes Do
    begin
      Result.Add(Cliente.nome);
      ListaIDClientes[indice] := Cliente.Id;
      inc(indice);
    end;
  Finally
    Clientes.Free;
  End;
end;

end.
