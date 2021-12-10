unit UntRelatorioPeriodoController;

interface

uses

  Classes, SysUtils, UntBaseController, UntRelatorioDao, UntRelatorioModel,
  UntRelatorioEnum, System.Generics.Collections;

type

  TRelatorioPeriodoController = class(TBaseController)
  private
     FRelatorioDao: TRelatorioDao;
  public
    function CriarRelatorioPeriodo(ARelatorio: TRelatorioModel): boolean;
    constructor Create();
    destructor Destroy();override;
  end;

implementation

{ TRelatorioPeriodoController }

constructor TRelatorioPeriodoController.Create;
begin
   inherited;
   FRelatorioDao:= TRelatorioDao.Create(Conexao);
end;

function TRelatorioPeriodoController.CriarRelatorioPeriodo(
  ARelatorio: TRelatorioModel): boolean;
 var
   sql, tabela: string;
   id: integer;
   dataInicio, dataTermino: TDate;
begin

case ARelatorio.Tipo of

actNotas:
begin
  tabela:= 'notas';
  case ARelatorio.Ordem of
    actAlfabetica:
    begin

    end;
    actFrequencia:
    begin

    end;
    actValores:
    begin

    end;
  end;
end;

end;
sql := 'select * from notas(tabela) where idUsuario = 1(id)' +
'and emissao between' + '2021-12-01(DI) and 2021-12-07(DF)';


end;

destructor TRelatorioPeriodoController.Destroy;
begin

  inherited;
end;

end.
