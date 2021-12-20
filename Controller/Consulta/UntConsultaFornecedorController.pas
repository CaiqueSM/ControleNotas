unit UntConsultaFornecedorController;

interface

uses UntBaseController, System.Generics.Collections, UntFornecedorModel,
  UntFornecedorDao, System.Classes, SysUtils;

type
  TConsultaFornecedorController = class(TBaseController)
  private
    FDao: TFornecedorDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ListarNomesFornecedores(): TStringList;
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
begin
  Result := TStringList.Create();
  Fornecedores := FDao.ListarFornecedores();
  if fornecedores = nil then
  begin
    result := nil;
    exit();
  end;
  Try
    For Fornecedor In Fornecedores Do
      Result.Add(Fornecedor.nome);
  Finally
    Fornecedores.Free;
  End;
end;

end.
