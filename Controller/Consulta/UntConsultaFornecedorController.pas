unit UntConsultaFornecedorController;

interface

uses UntBaseController, System.Generics.Collections, UntFornecedorModel,
  UntFornecedorDao, System.Classes, SysUtils;

type

  ArrayInteger = array of integer;

  TConsultaFornecedorController = class(TBaseController)
  private
    FDao: TFornecedorDao;
    ListaIDFornecedores: ArrayInteger;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
    function ListarNomesFornecedores(): TStringList;
    property ListaID: ArrayInteger read ListaIDFornecedores;
  end;

implementation

{ TConsultaFornecedorController }

constructor TConsultaFornecedorController.Create;
begin
  inherited Create();
  FDao := TFornecedorDao.Create(Conexao);
end;

destructor TConsultaFornecedorController.Destroy;
begin
  FDao.Free;
  inherited;
end;

function TConsultaFornecedorController.ListarNomesFornecedores: TStringList;
var
  Fornecedores: TObjectList<TFornecedorModel>;
  Fornecedor: TFornecedorModel;
  indice: integer;
begin
  Result := TStringList.Create();
  Fornecedores := FDao.ListarFornecedores();
  if fornecedores = nil then
  begin
    result := nil;
    exit();
  end;
  SetLength(ListaIDFornecedores, Fornecedores.Count);
  indice := 0;
  Try
    For Fornecedor In Fornecedores Do
    begin
      Result.Add(Fornecedor.nome);
      ListaIDFornecedores[indice] := Fornecedor.Id;
      inc(indice);
    end;
  Finally
    Fornecedores.Free;
  End;
end;

end.
