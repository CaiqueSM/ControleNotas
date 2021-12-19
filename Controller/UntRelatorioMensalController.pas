unit UntRelatorioMensalController;

interface

uses
  Classes, SysUtils, UntBaseController, UntRelatorioDao,
  UntRelatorioMensalModel, UntNotasModel, UntClienteModel,
  UntFornecedorModel, ZDataset;

type

  TRelatorioMensalController = class(TBaseController)
  private
    FRelatorioDao: TRelatorioDao;
  public
    function CriarRelatorioNotas(ARelatorio: TRelatorioMensalModel): TZQuery;
    function CriarRelatorioCliente(ARelatorio: TRelatorioMensalModel): TZQuery;
    function CriarRelatorioFornecedor(ARelatorio
      : TRelatorioMensalModel): TZQuery;
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

constructor TRelatorioMensalController.Create;
begin
  inherited;
  FRelatorioDao := TRelatorioDao.Create(Conexao);
end;

function TRelatorioMensalController.CriarRelatorioCliente
  (ARelatorio: TRelatorioMensalModel): TZQuery;
begin

  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := ' order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ARelatorio.ordem := ' group by nome'
  else
    ARelatorio.ordem := ' order by valor desc';

  Result := FRelatorioDao.ConsultarCliente(ARelatorio);
end;

function TRelatorioMensalController.CriarRelatorioFornecedor
  (ARelatorio: TRelatorioMensalModel): TZQuery;
begin

  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := 'order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ARelatorio.ordem := 'group by nome'
  else
    ARelatorio.ordem := 'order by valor desc';

  Result := FRelatorioDao.ConsultarFornecedor(ARelatorio);
end;

function TRelatorioMensalController.CriarRelatorioNotas
  (ARelatorio: TRelatorioMensalModel): TZQuery;
begin
  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := 'order by id asc'
  else if ARelatorio.ordem = 'Frequêcia' then
    ARelatorio.ordem := 'group by valor'
  else
    ARelatorio.ordem := 'order by valor desc';

  Result := FRelatorioDao.ConsultarNotas(ARelatorio);
end;

destructor TRelatorioMensalController.Destroy;
begin
  FRelatorioDao.Free;
  inherited;
end;

end.
