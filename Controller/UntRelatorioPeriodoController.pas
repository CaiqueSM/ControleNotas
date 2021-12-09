unit UntRelatorioPeriodoController;

interface

uses

  Classes, SysUtils, UntBaseController, UntRelatorioDao, UntRelatorioModel,
  System.Generics.Collections;

type

  TRelatorioPeriodoController = class(TBaseController)
  public
    function CriarRelatorioPeriodo(ARelatorio: TRelatorioModel): boolean;

  end;

implementation

{ TRelatorioPeriodoController }

function TRelatorioPeriodoController.CriarRelatorioPeriodo(
  ARelatorio: TRelatorioModel): boolean;
begin

end;

end.
