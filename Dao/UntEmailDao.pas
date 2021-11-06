unit UntEmailDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntEmailModel, System.Classes;

type

  TEmailDao = class(TBaseDao)
  public
    function ListarEmails(): TObjectList<TEmailModel>;
    function Consultar(ACodigo: integer): TEmailModel;
    procedure Criar(AContato: TEmailModel);
    procedure Alterar(AContato: TEmailModel);
    procedure Excluir(ACodigo: integer);
  end;

implementation

end.
