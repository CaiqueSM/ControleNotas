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
  Fornecedors: TObjectList<TFornecedorModel>;
  Fornecedor: TFornecedorModel;
begin
  Result := TStringList.Create();
  Fornecedors := FDao.ListarFornecedores();
  Try
    For Fornecedor In Fornecedors Do
      Result.Add(Fornecedor.nome);
  Finally
    Fornecedors.Free;
  End;
end;

end.
