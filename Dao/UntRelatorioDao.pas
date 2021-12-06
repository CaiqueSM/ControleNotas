unit UntRelatorioDao;

interface

uses
  untBaseDao, System.Generics.Collections, System.Classes,
  UntClienteModel, UntFornecedorModel, UntNotasModel;

type

  TEmailDao = class(TBaseDao)
  public
    function Consultar(AIdContato: integer): TObjectList<TEmailModel>;
    function Criar(AEmail: TEmailModel): Boolean;
    function Alterar(AEmail: TEmailModel): Boolean;
    function Excluir(AIdContato: integer): Boolean;
  end;


implementation

end.
