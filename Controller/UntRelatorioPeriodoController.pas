unit UntRelatorioPeriodoController;

interface

uses

  Classes, SysUtils, UntBaseController, UntRelatorioDao, UntRelatorioModel,
  UntNotasModel, UntClienteModel, UntFornecedorModel, UntValidarData,
  ZDataset;

type

  TRelatorioPeriodoController = class(TBaseController)
  private
    FRelatorioDao: TRelatorioDao;
    FValidarData: TValidarData;
  public
    function CriarRelatorioNotas(ARelatorio: TRelatorioModel)
      : TZQuery;
    function CriarRelatorioCliente(ARelatorio: TRelatorioModel)
      : TZQuery;
    function CriarRelatorioFornecedor(ARelatorio: TRelatorioModel)
      : TZQuery;
    function ValidarData(AData: TDate): boolean;
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
  (ARelatorio: TRelatorioModel): TZQuery;
begin

  ARelatorio.Tipo := 'cliente as c';

  if ARelatorio.ordem = 'Alfabética' then
    ARelatorio.ordem := ' order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ARelatorio.ordem := ' order by count(nome) desc'
  else
    ARelatorio.ordem := ' order by valor desc';

  Result := FRelatorioDao.ConsultarCliente(ARelatorio);
end;

function TRelatorioPeriodoController.CriarRelatorioFornecedor
  (ARelatorio: TRelatorioModel): TZQuery;
var
  sql, tabela, ordem: string;
begin

  tabela := 'fornecedor as f';

  if ARelatorio.ordem = 'Alfabética' then
    ordem := ' order by nome asc'
  else if ARelatorio.ordem = 'Frequência' then
    ordem := ' order by count(nome) desc'
  else
    ordem := ' order by valor desc';

  sql := 'select id, cpf, cnpj, nome, count(nome) from ' + tabela +
    ', notas as n where f.id = n.idFornecedor and n.idUsuario = ' +
    intTOstr(ARelatorio.IdUsuario) + ' and emissao between ' +
    dateTOstr(ARelatorio.DataInicio) + ' and ' +
    dateTOstr(ARelatorio.DataTermino) + ordem;

  Result := FRelatorioDao.ConsultarFornecedor(ARelatorio);
end;

function TRelatorioPeriodoController.CriarRelatorioNotas
  (ARelatorio: TRelatorioModel): TZQuery;
var
  sql, tabela, ordem: string;
begin
  tabela := 'notas';

  if ARelatorio.ordem = 'Alfabética' then
    ordem := ' order by id asc'
  else if ARelatorio.ordem = 'Frequêcia' then
    ordem := ' order by count(emissao) desc'
  else
    ordem := ' order by valor desc';

  Result := FRelatorioDao.ConsultarNotas(ARelatorio);
end;

destructor TRelatorioPeriodoController.Destroy;
begin
  FRelatorioDao.Free;
  FValidarData.Free;
  inherited;
end;

function TRelatorioPeriodoController.ValidarData(AData: TDate): boolean;
begin
  Result := FValidarData.ValidarData(AData);
end;

end.
