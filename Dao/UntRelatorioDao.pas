unit UntRelatorioDao;

interface

uses
  untBaseDao, System.Generics.Collections, System.Classes,
  UntClienteDao, UntFornecedorDao, UntNotasDao, UntRelatorioModel,
  UntClienteModel, UntFornecedorModel, UntNotasModel, UntRelatorioEnum;

type

  TRelatorioDao = class(TBaseDao)
  private
    FCliente: TClienteDao;
    FFornecedor: TFornecedorDao;
    FNotas: TNotasDao;
  public
    constructor Create();
    destructor Destroy();override;
    function ConsultarCliente(ASQL: string): TObjectList<TClienteModel>;
    function ConsultarFornecedor(ASQL: string): TObjectList<TFornecedorModel>;
    function ConsultarNotas(ASQL: string): TObjectList<TNotasModel>;
  end;

implementation

{ TRelatorioDao }

function TRelatorioDao.ConsultarCliente(ASQL: string)
  : TObjectList<TClienteModel>;
begin
  Result := FCliente.ListarClientes(ASQL);
end;

function TRelatorioDao.ConsultarFornecedor(ASQL: string)
  : TObjectList<TFornecedorModel>;
begin
  Result := FFornecedor.ListarFornecedores(ASQL);
end;

function TRelatorioDao.ConsultarNotas(ASQL: string): TObjectList<TNotasModel>;
begin
  Result := FNotas.ListarNotas(ASQL);
end;

constructor TRelatorioDao.Create;
begin
  FCliente := TClienteDao.Create(Conexao);
  FFornecedor := TFornecedorDao.Create(Conexao);
  FNotas := TNotasDao.Create(Conexao);
end;

destructor TRelatorioDao.Destroy;
begin
  FCliente.Free;
  FFornecedor.Free;
  FNotas.Free;
end;

end.
