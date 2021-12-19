unit UntRelatorioModel;

interface

uses
  Classes, SysUtils, System.Generics.Collections;

type

TRelatorioModel = class
private
  FIdUsuario: integer;
  FTipo: string;
  FOrdem: string;
public
  property IdUsuario: integer read FidUsuario write FidUsuario;
  property Tipo: string read FTipo write FTipo;
  property Ordem: string read FOrdem write Fordem;
end;

implementation



end.
