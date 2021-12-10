unit UntRelatorioModel;

interface

uses
  Classes, SysUtils, System.Generics.Collections, UntRelatorioEnum;

type

TRelatorioModel = class
private
  Fid: integer;
  FIdUsuario: integer;
  FTipo: TTipoRelatorio;
  FOrdem: TOrdemRelatorio;
  FDataInicio: Tdate;
  FDataTermino: TDate;
public
  property Id: integer read Fid write Fid;
  property IdUsuario: integer read FidUsuario write FidUsuario;
  property Tipo: TTipoRelatorio read FTipo write FTipo;
  property Ordem: TOrdemRelatorio read FOrdem write Fordem;
  property DataInicio: TDate read FDataInicio write FDataInicio;
  property DataTermino: TDate read FDataTermino write FDataTermino;
  constructor Create();
  destructor Destroy();override;
  function Exibir(): boolean;
  function Exportar(): boolean;
end;

implementation

{ TRelatorioModel }

constructor TRelatorioModel.Create;
begin

end;

destructor TRelatorioModel.Destroy;
begin

end;

function TRelatorioModel.Exibir: boolean;
begin

end;

function TRelatorioModel.Exportar: boolean;
begin

end;

end.
