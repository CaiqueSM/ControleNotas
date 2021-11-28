unit UntFornecedorController;

interface

uses

  Classes, SysUtils, UntValidarPessoa, UntFornecedorDao, UntFornecedorModel,
  UntBaseController, UntValidarContato, UntTelefoneDao, UntEmailDao,
  UntContatoDao;

type

  TFornecedorController = class(TBaseController)
  private
    FFornecedorDao: TFornecedorDao;
    FValidarFornecedor: TValidarPessoa;
    FValidarContato: TValidarContato;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(AId: String): TFornecedorModel;
    function Criar(AFornecedor: TFornecedorModel): Boolean;
    function Alterar(AFornecedor: TFornecedorModel): Boolean;
    function Excluir(AIdFornecedor: Integer): Boolean;

    function ValidarNome(ANome: string): boolean;
    function ValidarCadastroPessoal(ANumero: string): boolean;
    function ValidarCEP(ACEP: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarNumero(ANumero: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
  end;

implementation

uses
  UntContatoModel, UntEmailModel, UntTelefoneModel, UntEnumContatoDao;

{ TFornecedorController }

constructor TFornecedorController.Create;
begin
  inherited;
  FFornecedorDao := TFornecedorDao.Create(Conexao);
  FValidarFornecedor := TValidarPessoa.Create;
  FValidarContato := TValidarContato.Create;
End;

destructor TFornecedorController.Destroy;
begin
  FFornecedorDao.Free;
  FValidarFornecedor.Free;
  FValidarContato.Free;
  inherited;
end;

function TFornecedorController.Alterar(AFornecedor: TFornecedorModel): Boolean;
begin
  Result := FFornecedorDao.Alterar(AFornecedor);
end;

function TFornecedorController.Consultar(AId: String): TFornecedorModel;
begin
  Result := FFornecedorDao.Consultar(AId);
end;

function TFornecedorController.Criar(AFornecedor: TFornecedorModel): Boolean;
begin
  Result := FFornecedorDao.Criar(AFornecedor);
end;

function TFornecedorController.Excluir(AIdFornecedor: Integer): Boolean;
begin
  Result := FFornecedorDao.Excluir(AIdFornecedor);
end;

function TFornecedorController.ValidarCadastroPessoal(ANumero: string): boolean;
begin
  Result := FValidarFornecedor.ValidarNumeroCadastroPessoal(ANumero);
end;

function TFornecedorController.ValidarCEP(ACEP: string): boolean;
begin
  Result := FValidarContato.ValidarCEP(ACEP);
end;

function TFornecedorController.ValidarNome(ANome: string): boolean;
begin
  Result:= FValidarFornecedor.ValidarNome(ANome);
end;

function TFornecedorController.ValidarEmail(AEmail: string): boolean;
begin
  Result := FValidarContato.ValidarEmail(AEmail);
end;

function TFornecedorController.ValidarNumero(ANumero: string): boolean;
begin
  Result := FValidarContato.ValidarNumero(ANumero);
end;

function TFornecedorController.ValidarTelefone(ATelefone: string): boolean;
begin
  Result := FValidarContato.ValidarTelefone(ATelefone);
end;

end.
