unit UntValidarData;

interface

uses
  SysUtils;

type

TValidarData = class
public
  function validarData(AData: TDate):boolean;
end;

implementation

{ TValidarData }

function TValidarData.validarData(AData: TDate): boolean;
var
  MenorData, MaiorData: TDate;
begin
  MenorData:= strTODate('01/01/1970');
  MaiorData:= Date();
  Result:= (MenorData <= AData) and (AData <= MaiorData);
end;

end.
