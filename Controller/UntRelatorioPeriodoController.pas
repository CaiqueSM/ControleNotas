unit UntRelatorioPeriodoController;

interface

uses

  Classes, SysUtils, UntBaseController, UntRelatorioDao, UntRelatorioPeriodoModel,
  UntNotasModel, UntClienteModel, UntFornecedorModel, UntValidarData,
  ZDataset;

type

  TRelatorioPeriodoController = class(TBaseController)
  private
    FRelatorioDao: TRelatorioDao;
    FValidarData: TValidarData;
  public
    function CriarRelatorioNotas(ARelatorio: TRelatorioPeriodoModel): TZQuery;
    function CriarRelatorioCliente(ARelatorio: TRelatorioPeriodoModel): TZQuery;
    function CriarRelatorioFornecedor(ARelatorio: TRelatorioPeriodoModel): TZQuery;
    function ValidarData(AData: string): boolean;
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

{ TRelatorioPeriodoController }

constructor TRelatorioPeriodoController.Create;
begin
  inherited;
  FRelatorioDao := TRelatorioDao.Create(Conexao);
  FValidarData := TValidarData.Create();
end;

function TRelatorioPeriodoController.CriarRelatorioCliente
  (ARelatorio: TRelatorioPeriodoModel): TZQuery;
begin

  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := ' order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ARelatorio.ordem := ' group by nome'
  else
    ARelatorio.ordem := ' order by valor desc';

  Result := FRelatorioDao.ConsultarCliente(ARelatorio);
end;

function TRelatorioPeriodoController.CriarRelatorioFornecedor
  (ARelatorio: TRelatorioPeriodoModel): TZQuery;
begin

  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := 'order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ARelatorio.ordem := 'group by nome'
  else
    ARelatorio.ordem := 'order by valor desc';

  Result := FRelatorioDao.ConsultarFornecedor(ARelatorio);
end;

function TRelatorioPeriodoController.CriarRelatorioNotas
  (ARelatorio: TRelatorioPeriodoModel): TZQuery;
begin
  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := 'order by id asc'
  else if ARelatorio.ordem = 'Frequêcia' then
    ARelatorio.ordem := 'group by valor'
  else
    ARelatorio.ordem := 'order by valor desc';

  Result := FRelatorioDao.ConsultarNotas(ARelatorio);
end;

destructor TRelatorioPeriodoController.Destroy;
begin
  FRelatorioDao.Free;
  FValidarData.Free;
  inherited;
end;

function TRelatorioPeriodoController.ValidarData(AData: string): boolean;
begin
  Result := FValidarData.ValidarData(AData);
end;

end.
