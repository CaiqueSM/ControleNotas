unit UntConsultaFornecedor;

interface
uses UntConsultaFornecedorView;

type
  TConsultaFornecedor = class
  public
    class function ConsultarFornecedores(): String;
  end;

implementation

{ TConsultaFornecedorView }

class function TConsultaFornecedor.ConsultarFornecedores: String;
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
