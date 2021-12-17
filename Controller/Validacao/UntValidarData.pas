unit UntValidarData;

interface

uses
  SysUtils, StrUtils, System.Types;

type

  TValidarData = class
  public
    function validarData(AData: string): boolean;
  end;

implementation

{ TValidarData }

function TValidarData.validarData(AData: string): boolean;
var
  MenorData, MaiorData, DataAtual: TDate;
  regraverificacao: TstringDynArray;
begin
  regraVerificacao := SplitString(AData, '/');
  if (strTOint(regraVerificacao[0]) > 31) or
  (strTOint(regraVerificacao[1]) > 12) then
  begin
    Result:= False;
    exit();
  end;

  DataAtual := strTOdate(AData);
  MenorData := strTODate('01/01/1901');
  MaiorData := Date();
  Result := (MenorData <= DataAtual) and (DataAtual <= MaiorData);
end;

end.
