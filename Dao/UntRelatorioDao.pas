unit UntRelatorioDao;

interface

uses
  untBaseDao, System.Generics.Collections, System.Classes, UntConexao,
  UntClienteDao, UntFornecedorDao, UntNotasDao, UntRelatorioModel,
  UntClienteModel, UntFornecedorModel, UntNotasModel, ZDataset;

type

  TRelatorioDao = class(TBaseDao)
  private
    FCliente: TClienteDao;
    FFornecedor: TFornecedorDao;
    FNotas: TNotasDao;
  public
    constructor Create(AConexao: TConexao);
    destructor Destroy();override;
    function ConsultarCliente(ARelatorio: TRelatorioModel): TZQuery;
    function ConsultarFornecedor(ARelatorio: TRelatorioModel): TZQuery;
    function ConsultarNotas(ARelatorio: TRelatorioModel): TZQuery;
  end;

implementation

{ TRelatorioDao }

function TRelatorioDao.ConsultarCliente(ARelatorio: TRelatorioModel): TZQuery;
begin
  Result := FCliente.ListarClientes(ARelatorio);
end;

function TRelatorioDao.ConsultarFornecedor(ARelatorio: TRelatorioModel): TZQuery;
begin
  Result := FFornecedor.ListarFornecedores(ARelatorio);
end;

function TRelatorioDao.ConsultarNotas(ARelatorio: TRelatorioModel): TZQuery;
begin
  Result := FNotas.ListarNotas(ARelatorio);
end;

constructor TRelatorioDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FCliente := TClienteDao.Create(AConexao);
  FFornecedor := TFornecedorDao.Create(AConexao);
  FNotas := TNotasDao.Create(AConexao);
end;

destructor TRelatorioDao.Destroy;
begin
  FCliente.Free;
  FFornecedor.Free;
  FNotas.Free;
  inherited;
end;

end.
