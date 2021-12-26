unit UntConsultaFornecedor;

interface
uses UntConsultaFornecedorView;

type
  TConsultaFornecedor = class
  public
    class function ConsultarFornecedores(): TResultado;
  end;

implementation

{ TConsultaFornecedorView }

class function TConsultaFornecedor.ConsultarFornecedores: TResultado;
var
  formulario: TFrmConsultaFornecedorView;
begin
  formulario := TFrmConsultaFornecedorView.Create(nil);
  Try
    formulario.ShowModal();
    Result := formulario.Resultado;
  Finally
    formulario.Free;
  End;
end;

end.
