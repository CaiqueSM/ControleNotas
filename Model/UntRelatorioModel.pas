unit UntRelatorioModel;

interface

uses
  Classes, SysUtils, System.Generics.Collections, UntRelatorioEnum;

type

TRelatorioModel = class
private
  Fid: integer;
  FTipo: TTipoRelatorio;
  FOrdem: TOrdemRelatorio;
  FDataInicio: Tdate;
  FDataTermino: TDate;
public
  property ID: integer read Fid write Fid;
  property Tipo: TTipoRelatorio read FTipo write FTipo;
  property Ordem: TOrdemRelatorio read FOrdem write Fordem;
  property DataInicio: TDate read FDataInicio write FDataInicio;
  property DataTermino: TDate read FDataTermino write FDataTermino;
end;

implementation

end.
