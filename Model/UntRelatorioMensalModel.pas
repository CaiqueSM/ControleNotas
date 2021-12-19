unit UntRelatorioMensalModel;

interface

uses
  UntRelatorioModel;

type

  TRelatorioMensalModel = class(TRelatorioModel)
  private
    FMes: integer;
  public
    destructor Destroy; override;
    property Mes: integer read FMes write FMes;
  end;

implementation

{ TRelatorioMensalModel }

destructor TRelatorioMensalModel.Destroy;
begin
  inherited;
end;

end.
