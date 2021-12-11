unit UntRelatorioPeriodoController;

interface

uses

  Classes, SysUtils, UntBaseController, UntRelatorioDao, UntRelatorioModel,
  UntNotasModel, UntClienteModel, UntFornecedorModel,
  UntRelatorioEnum, System.Generics.Collections;

type

  TRelatorioPeriodoController = class(TBaseController)
  private
    FRelatorioDao: TRelatorioDao;
  public
    function CriarRelatorioNotas(ARelatorio: TRelatorioModel):
    TObjectList<TNotasModel>;
    function CriarRelatorioCliente(ARelatorio: TRelatorioModel):
    TObjectList<TClienteModel>;
    function CriarRelatorioFornecedor(ARelatorio: TRelatorioModel):
    TObjectList<TFornecedorModel>;
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

{ TRelatorioPeriodoController }

constructor TRelatorioPeriodoController.Create;
begin
  inherited;
  FRelatorioDao := TRelatorioDao.Create(Conexao);
end;

function TRelatorioPeriodoController.CriarRelatorioNotas
(ARelatorio: TRelatorioModel): TObjectList<TNotasModel>;
var
  sql, tabela, ordem: string;
begin

  case ARelatorio.Tipo of

    actNotas:
      begin
        tabela := 'notas';
        case ARelatorio.ordem of
          actAlfabetica:
            ordem := ' order by id asc';
          actFrequencia:
            ordem := ' order by count(emissao) desc';
          actValores:
            ordem := ' order by valor desc';
        end;
      end;

    actCliente:
      begin
        tabela := 'cliente';
        case ARelatorio.ordem of
          actAlfabetica:
            ordem := ' order by nome asc';
          actFrequencia:
            ordem := ' order by count(nome) desc';
          actValores:
            ordem := ' order by valor desc';
        end;
      end;

    actFornecedor:
      begin
        tabela := 'fornecedor';
        case ARelatorio.ordem of
          actAlfabetica:
            ordem := ' order by nome asc';
          actFrequencia:
            ordem := ' order by count(nome) desc';
          actValores:
            ordem := ' order by valor desc';
        end;
      end;

  end;
  sql := 'select * from ' + tabela +
    ' where idUsuario = ' + intTOstr(ARelatorio.idUsuario) +
    ' and emissao between ' + dateTOstr(ARelatorio.DataInicio) +
    ' and ' + dateTOstr(ARelatorio.DataTermino) + ordem;

  case ARelatorio.Tipo of
    actCliente:
      FRelatorioDao.ConsultarCliente(sql);
    actFornecedor:
      FRelatorioDao.ConsultarFornecedor(sql);
    actNotas:
      FRelatorioDao.ConsultarNotas(sql);
  end;

end;

destructor TRelatorioPeriodoController.Destroy;
begin
  FRelatorioDao.Free;
  inherited;
end;

end.
