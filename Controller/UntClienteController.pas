unit UntClienteController;

interface

uses

  Classes, SysUtils, UntValidarPessoa, UntClienteDao, UntClienteModel,
  UntBaseController;

type

  TClienteController = class(TBaseController)
  private
    FDao: TClienteDao;
    FValidarCliente: TValidarPessoa;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TClienteModel;
    procedure Criar(ACliente: TClienteModel);
    procedure Alterar(ACliente: TClienteModel);
    procedure Excluir(AIdCliente: Integer);
    function ValidarNome(ANome: string): boolean;
    function ValidarCadastroPessoal(ANumero: string): boolean;
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
  FValidarCliente:= TValidarPessoa.Create;
end;

procedure TClienteController.Criar(ACliente: TClienteModel);
begin
  FDao.Criar(ACliente);
end;

destructor TClienteController.Destroy;
begin
  FDao.Free;
  FValidarCliente.Free;
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

function TClienteController.ValidarNome(ANome: string): boolean;
begin
  Result:= FValidarCliente.ValidarNome(ANome);
end;

end.
