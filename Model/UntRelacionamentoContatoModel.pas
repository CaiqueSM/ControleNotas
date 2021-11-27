unit UntRelacionamentoContatoModel;

interface

type

TRelacionamentoContatoModel = class
private
  FidContato: integer;
  FidRelacionado: integer;
public
  property idContato: integer read FidContato write FidContato;
  property idRelacionado: integer read FidRelacionado write FidRelacionado;
end;

implementation

end.
