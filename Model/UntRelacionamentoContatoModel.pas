unit UntRelacionamentoContatoModel;

interface

type

  TRelacionamentoContatoModel = class
  private
    FidContato: integer;
    FidCliente: integer;
    FidFornecedor: integer;
  public
    property idContato: integer read FidContato write FidContato;
    property idCliente: integer read FidCliente write FidCliente;
    property idFornecedor: integer read FidFornecedor write FidFornecedor;
  end;

implementation

end.
