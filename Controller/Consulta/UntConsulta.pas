unit UntConsulta;

interface

uses UntConsultaUsuarios;

type
  TConsulta = class
  public
    class function ConsultarUsuarios(): String;
  end;

implementation

{ TConsulta }

class function TConsulta.ConsultarUsuarios: String;
var
  formulario: TFrmConsultaUsuarios;
begin
   formulario := TFrmConsultaUsuarios.Create(nil);
   Try
      formulario.ShowModal();
      Result := formulario.Resultado;
   Finally
      formulario.Free;
   End;
end;

end.
