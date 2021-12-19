unit UntConsultarCliente;

interface

uses UntConsultaClienteView;

type
  TConsultaCliente = class
  public
    class function ConsultarClientes(): String;
  end;

implementation

{ TConsultaClienteView }

class function TConsultaCliente.ConsultarClientes: String;
var
  formulario: TFrmConsultaClienteView;
begin
  formulario := TFrmConsultaClienteView.Create(nil);
  Try
    formulario.ShowModal();
    Result := formulario.Resultado;
  Finally
    formulario.Close;
    formulario.Free;
  End;
end;

end.
