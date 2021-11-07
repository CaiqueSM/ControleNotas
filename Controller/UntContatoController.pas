unit UntContatoController;

interface

uses
System.Classes, System.Generics.Collections,SysUtils, UntValidarContato, UntContatoDao,
UntContatoModel, UntEnumContatoDao, UntBaseController;

type

TContatoControler = class(TBaseController)
private
    FDao: TContatoDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ListarContatos(): TObjectList<TContatoModel>;
    function Consultar(ACodigo: integer; Enum: TEnumContatoDao): TContatoModel;
    procedure Alterar(AContato: TContatoModel);
    procedure Excluir(ACodigo: integer; Enum: TEnumContatoDao);
end;

implementation

end.
