unit UntConsultarCliente;

interface

uses UntConsultaClienteView;

type
  TConsultaCliente = class
  public
    class function ConsultarClientes(): TResultado;
  end;

implementation

{ TConsultaClienteView }

class function TConsultaCliente.ConsultarClientes: TResultado;
var
  formulario: TFrmConsultaClienteView;
begin
  formulario := TFrmConsultaClienteView.Create(nil);
  Try
    formulario.ShowModal();
    Result := formulario.Resultado;
  Finally
    formulario.Free;
  End;
end;

end.
