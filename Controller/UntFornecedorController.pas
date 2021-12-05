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

    function Consultar(AId: integer): TFornecedorModel; overload;
    function Consultar(ANumeroPessoal: String): TFornecedorModel; overload;
    function ConsultarPorNome(ANome: String): TFornecedorModel;
    function Criar(AFornecedor: TFornecedorModel): Boolean;
    function Alterar(AFornecedor: TFornecedorModel): Boolean;
    function Excluir(AIdFornecedor: integer): Boolean;

    function ValidarNome(ANome: string): Boolean;
    function ValidarCadastroPessoal(ANumero: string): Boolean;
    function ValidarCEP(ACEP: string): Boolean;
    function ValidarEmail(AEmail: string): Boolean;
    function ValidarNumero(ANumero: string): Boolean;
    function ValidarTelefone(ATelefone: string): Boolean;
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
  inherited Destroy;
end;

function TFornecedorController.Alterar(AFornecedor: TFornecedorModel): Boolean;
begin
  Result := FFornecedorDao.Alterar(AFornecedor);
end;

function TFornecedorController.Consultar(AId: integer): TFornecedorModel;
begin
  Result := FFornecedorDao.Consultar(AId);
end;

function TFornecedorController.Consultar(ANumeroPessoal: String)
  : TFornecedorModel;
begin
  Result := FFornecedorDao.Consultar(ANumeroPessoal);
end;

function TFornecedorController.ConsultarPorNome(
  ANome: String): TFornecedorModel;
begin
  Result := FFornecedorDao.ConsultarPorNome(ANome);
end;

function TFornecedorController.Criar(AFornecedor: TFornecedorModel): Boolean;
begin
  Result := FFornecedorDao.Criar(AFornecedor);
end;

function TFornecedorController.Excluir(AIdFornecedor: integer): Boolean;
begin
  Result := FFornecedorDao.Excluir(AIdFornecedor);
end;

function TFornecedorController.ValidarCadastroPessoal(ANumero: string): Boolean;
begin
  Result := FValidarFornecedor.ValidarNumeroCadastroPessoal(ANumero);
end;

function TFornecedorController.ValidarCEP(ACEP: string): Boolean;
begin
  Result := FValidarContato.ValidarCEP(ACEP);
end;

function TFornecedorController.ValidarNome(ANome: string): Boolean;
begin
  Result := FValidarFornecedor.ValidarNome(ANome);
end;

function TFornecedorController.ValidarEmail(AEmail: string): Boolean;
begin
  Result := FValidarContato.ValidarEmail(AEmail);
end;

function TFornecedorController.ValidarNumero(ANumero: string): Boolean;
begin
  Result := FValidarContato.ValidarNumero(ANumero);
end;

function TFornecedorController.ValidarTelefone(ATelefone: string): Boolean;
begin
  Result := FValidarContato.ValidarTelefone(ATelefone);
end;

end.
