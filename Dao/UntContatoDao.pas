unit UntContatoDao;

interface

uses

  untbasedao, System.Generics.Collections, UntContatoModel, System.Classes;

type

  TContatoDao = class(TBaseDao)
  public
    function ListarContatos(): TObjectList<TContatoModel>;
    function Consultar(ACodigo: integer): TContatoModel;
    procedure Criar(ACliente: TContatoModel);
    procedure Alterar(ACliente: TContatoModel);
    procedure Excluir(AId: Integer);
  end;

implementation

end.
