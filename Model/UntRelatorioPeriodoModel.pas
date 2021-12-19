unit UntRelatorioPeriodoModel;

interface

uses
  UntRelatorioModel;

type

  TRelatorioPeriodoModel = class(TRelatorioModel)
  private
    FDataInicio: Tdate;
    FDataTermino: Tdate;
  public
    destructor Destroy;override;
    property DataInicio: Tdate read FDataInicio write FDataInicio;
    property DataTermino: Tdate read FDataTermino write FDataTermino;
  end;

implementation

{ TRelatorioPeriodoModel }

destructor TRelatorioPeriodoModel.Destroy;
begin
  inherited;
end;

end.
