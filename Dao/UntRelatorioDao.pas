unit UntRelatorioDao;

interface

uses
  untBaseDao, System.Generics.Collections, System.Classes, UntConexao,
  UntClienteDao, UntFornecedorDao, UntNotasDao, UntRelatorioPeriodoModel,
  UntRelatorioMensalModel, UntClienteModel, UntFornecedorModel,
  UntNotasModel, ZDataset;

type

  TRelatorioDao = class(TBaseDao)
  private
    FCliente: TClienteDao;
    FFornecedor: TFornecedorDao;
    FNotas: TNotasDao;
  public
    constructor Create(AConexao: TConexao);
    destructor Destroy(); override;
    function ConsultarCliente(ARelatorio: TRelatorioPeriodoModel)
      : TZQuery; overload;
    function ConsultarCliente(ARelatorio: TRelatorioMensalModel)
      : TZQuery; overload;
    function ConsultarFornecedor(ARelatorio: TRelatorioPeriodoModel)
      : TZQuery; overload;
    function ConsultarFornecedor(ARelatorio: TRelatorioMensalModel)
      : TZQuery; overload;
    function ConsultarNotas(ARelatorio: TRelatorioPeriodoModel)
      : TZQuery; overload;
    function ConsultarNotas(ARelatorio: TRelatorioMensalModel)
      : TZQuery; overload;
  end;

implementation

{ TRelatorioDao }

function TRelatorioDao.ConsultarCliente(ARelatorio
  : TRelatorioPeriodoModel): TZQuery;
begin
  Result := FCliente.ListarClientes(ARelatorio);
end;

function TRelatorioDao.ConsultarFornecedor(ARelatorio
  : TRelatorioPeriodoModel): TZQuery;
begin
  Result := FFornecedor.ListarFornecedores(ARelatorio);
end;

function TRelatorioDao.ConsultarNotas(ARelatorio
  : TRelatorioPeriodoModel): TZQuery;
begin
  Result := FNotas.ListarNotas(ARelatorio);
end;

function TRelatorioDao.ConsultarCliente(ARelatorio
  : TRelatorioMensalModel): TZQuery;
begin
  Result := FCliente.ListarClientes(ARelatorio);
end;

function TRelatorioDao.ConsultarFornecedor(ARelatorio
  : TRelatorioMensalModel): TZQuery;
begin
  Result := FFornecedor.ListarFornecedores(ARelatorio);
end;

function TRelatorioDao.ConsultarNotas(ARelatorio
  : TRelatorioMensalModel): TZQuery;
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
