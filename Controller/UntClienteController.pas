unit UntClienteController;

interface

uses

  Classes, SysUtils, UntValidarPessoa, UntClienteDao, UntClienteModel,
  UntBaseController, UntValidarContato;

type

  TClienteController = class(TBaseController)
  private
    FDao: TClienteDao;
    FValidarCliente: TValidarPessoa;
    FValidarContato: TValidarContato;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TClienteModel;
    procedure Criar(ACliente: TClienteModel);
    procedure Alterar(ACliente: TClienteModel);
    procedure Excluir(AIdCliente: Integer);

    function ValidarNome(ANome: string): boolean;
    function ValidarCadastroPessoal(ANumero: string): boolean;
    function ValidarCEP(ACEP: string): boolean;
    function ValidarEmail(AEmail: string): boolean;
    function ValidarNumero(ANumero: string): boolean;
    function ValidarTelefone(ATelefone: string): boolean;
  end;

implementation

{ TClienteController }

procedure TClienteController.Alterar(ACliente: TClienteModel);
begin
  FDao.Alterar(ACliente);
end;

function TClienteController.Consultar(ANome: String): TClienteModel;
begin
  Result := FDao.Consultar(ANome);
end;

constructor TClienteController.Create;
begin
  inherited;
  FDao := TClienteDao.Create(Conexao);
  FValidarCliente := TValidarPessoa.Create;
  FValidarContato := TValidarContato.Create;
end;

procedure TClienteController.Criar(ACliente: TClienteModel);
begin
  FDao.Criar(ACliente);
end;

destructor TClienteController.Destroy;
begin
  FDao.Free;
  FValidarCliente.Free;
  FValidarContato.Free;
  inherited;
end;

procedure TClienteController.Excluir(AIdCliente: Integer);
begin
  FDao.Excluir(AIdCliente);
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
