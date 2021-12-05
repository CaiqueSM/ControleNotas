unit UntConsultaNotas;

interface

uses UntConsultaNotasView;

type
  TConsultaNotas = class
  public
    class function ConsultarNotas(): String;
  end;

implementation

{ TConsultaNotasView }

class function TConsultaNotas.ConsultarNotas: String;
var
  formulario: TFrmConsultaNotasView;
begin
  formulario := TFrmConsultaNotasView.Create(nil);
  Try
    formulario.ShowModal();
    Result := formulario.Resultado;
  Finally
    formulario.Free;
  End;
end;

end.
