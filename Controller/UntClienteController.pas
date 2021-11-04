unit UntClienteController;

interface

uses

  Classes, SysUtils, UntValidarPessoa, UntClienteDao, UntClienteModel,
  UntBaseController;

type

  TClienteController = class(TBaseController)
  private
    FDao: TClienteDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TClienteModel;
    procedure Criar(ACliente: TClienteModel);
    procedure Alterar(ACliente: TClienteModel);
    procedure Excluir(AIdCliente: Integer);
  end;

implementation

{ TClienteController }

procedure TClienteController.Alterar(ACliente: TClienteModel);
begin
  FDao.Alterar(ACliente);
end;

function TClienteController.Consultar(ANome: String): TClienteModel;
begin
  FDao.Consultar(ANome);
end;

constructor TClienteController.Create;
begin
  inherited;
  FDao := TClienteDao.Create(Conexao);
end;

procedure TClienteController.Criar(ACliente: TClienteModel);
begin
  FDao.Criar(ACliente);
end;

destructor TClienteController.Destroy;
begin
  FDao.Free;
  inherited;
end;

procedure TClienteController.Excluir(AIdCliente: Integer);
begin
  FDao.Excluir(AIdCliente);
end;

end.
