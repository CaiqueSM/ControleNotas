unit UntClienteController;

interface

uses

  Classes, SysUtils, UntValidarPessoa, UntClienteDao, UntClienteModel,
  UntBaseController, UntValidarContato, UntTelefoneDao, UntEmailDao,
  UntContatoDao;

type

  TClienteController = class(TBaseController)
  private
    FClienteDao: TClienteDao;
    FValidarCliente: TValidarPessoa;
    FValidarContato: TValidarContato;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(AId: integer): TClienteModel; overload;
    function Consultar(ANumeroPessoal: String): TClienteModel; overload;
    function ConsultarPorNome(ANome: String): TClienteModel;
    function Criar(ACliente: TClienteModel): Boolean;
    function Alterar(ACliente: TClienteModel): Boolean;
    function Excluir(AIdCliente: integer): Boolean;

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

{ TClienteController }

constructor TClienteController.Create;
begin
  inherited;
  FClienteDao := TClienteDao.Create(Conexao);
  FValidarCliente := TValidarPessoa.Create;
  FValidarContato := TValidarContato.Create;
End;

destructor TClienteController.Destroy;
begin
  FClienteDao.Free;
  FValidarCliente.Free;
  FValidarContato.Free;
  inherited Destroy;
end;

function TClienteController.Alterar(ACliente: TClienteModel): Boolean;
begin
  Result := FClienteDao.Alterar(ACliente);
end;

function TClienteController.Consultar(ANumeroPessoal: String): TClienteModel;
begin
  Result := FClienteDao.Consultar(ANumeroPessoal);
end;

function TClienteController.ConsultarPorNome(ANome: String): TClienteModel;
begin
  Result := FClienteDao.ConsultarPorNome(ANome);
end;

function TClienteController.Consultar(AId: integer): TClienteModel;
begin
  Result := FClienteDao.Consultar(AId);
end;

function TClienteController.Criar(ACliente: TClienteModel): Boolean;
begin
  Result := FClienteDao.Criar(ACliente);
end;

function TClienteController.Excluir(AIdCliente: integer): Boolean;
begin
  Result := FClienteDao.Excluir(AIdCliente);
end;

function TClienteController.ValidarCadastroPessoal(ANumero: string): Boolean;
begin
  Result := FValidarCliente.ValidarNumeroCadastroPessoal(ANumero);
end;

function TClienteController.ValidarCEP(ACEP: string): Boolean;
begin
  Result := FValidarContato.ValidarCEP(ACEP);
end;

function TClienteController.ValidarNome(ANome: string): Boolean;
begin
  Result := FValidarCliente.ValidarNome(ANome);
end;

function TClienteController.ValidarEmail(AEmail: string): Boolean;
begin
  Result := FValidarContato.ValidarEmail(AEmail);
end;

function TClienteController.ValidarNumero(ANumero: string): Boolean;
begin
  Result := FValidarContato.ValidarNumero(ANumero);
end;

function TClienteController.ValidarTelefone(ATelefone: string): Boolean;
begin
  Result := FValidarContato.ValidarTelefone(ATelefone);
end;

end.
