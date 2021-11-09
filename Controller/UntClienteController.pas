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
    FTelefoneDao: TTelefoneDao;
    FEmailDao: TEmailDao;
    FContatoDao: TContatoDao;

    FValidarCliente: TValidarPessoa;
    FValidarContato: TValidarContato;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TClienteModel;
    function Criar(ACliente: TClienteModel): Boolean;
    function Alterar(ACliente: TClienteModel): Boolean;
    function Excluir(AIdCliente: Integer): Boolean;

    function ValidarNome(ANome: string): boolean;
    function ValidarCadastroPessoal(ANumero: string): boolean;
    function ValidarCEP(ACEP: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarNumero(ANumero: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
  end;

implementation

{ TClienteController }

constructor TClienteController.Create;
begin
  inherited;
  FClienteDao := TClienteDao.Create(Conexao);
  FTelefoneDao := TTelefoneDao.Create(Conexao);
  FEmailDao := TEmailDao.Create(Conexao);
  FContatoDao := TContatoDao.Create(Conexao);

  FValidarCliente := TValidarPessoa.Create;
  FValidarContato := TValidarContato.Create;
End;

destructor TClienteController.Destroy;
begin
  FClienteDao.Free;
  FContatoDao.Free;
  FTelefoneDao.Free;
  FEmailDao.Free;

  FValidarCliente.Free;
  FValidarContato.Free;
  inherited;
end;

function TClienteController.Alterar(ACliente: TClienteModel): Boolean;
begin
  Result := FClienteDao.Alterar(ACliente);
end;

function TClienteController.Consultar(ANome: String): TClienteModel;
begin
  Result := FClienteDao.Consultar(ANome);
end;

function TClienteController.Criar(ACliente: TClienteModel): Boolean;
begin
  Result := FClienteDao.Criar(ACliente);
end;

function TClienteController.Excluir(AIdCliente: Integer): Boolean;
begin
  Result := FClienteDao.Excluir(AIdCliente);
end;

function TClienteController.ValidarCadastroPessoal(ANumero: string): boolean;
begin
  Result := FValidarCliente.ValidarNumeroCadastroPessoal(ANumero);
end;

function TClienteController.ValidarCEP(ACEP: string): boolean;
begin
  Result := FValidarContato.ValidarCEP(ACEP);
end;

function TClienteController.ValidarNome(ANome: string): boolean;
begin
  Result:= FValidarCliente.ValidarNome(ANome);
end;

function TClienteController.ValidarEmail(AEmail: string): boolean;
begin
  Result := FValidarContato.ValidarEmail(AEmail);
end;

function TClienteController.ValidarNumero(ANumero: string): boolean;
begin
  Result := FValidarContato.ValidarNumero(ANumero);
end;

function TClienteController.ValidarTelefone(ATelefone: string): boolean;
begin
  Result := FValidarContato.ValidarTelefone(ATelefone);
end;

end.
