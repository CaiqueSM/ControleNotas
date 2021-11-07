unit UntTelefoneController;

interface

uses
  Classes, SysUtils, UntTelefoneDao, UntTelefoneModel,
  UntBaseController;

type

  TTelefoneController = class(TBaseController)
  private
    FDao: TTelefoneDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    procedure Alterar(ATelefone: TTelefoneModel);
    procedure Criar(ATelefone: TTelefoneModel);
    function Consultar(ACodigo: integer): TTelefoneModel;
    procedure Excluir(ACodigo: integer);
  end;

implementation

{ TEmailController }

procedure TTelefoneController.Alterar(ATelefone: TTelefoneModel);
begin
  FDao.Alterar(ATelefone);
end;

function TTelefoneController.Consultar(ACodigo: integer): TTelefoneModel;
begin
  Result:= FDao.Consultar(ACodigo);
end;

constructor TTelefoneController.Create;
begin
  inherited;
  FDao := TTelefoneDao.Create(Conexao);
end;

procedure TTelefoneController.Criar(ATelefone: TTelefoneModel);
begin
  FDao.Criar(ATelefone);
end;

destructor TTelefoneController.Destroy;
begin
   FDao.Free;
  inherited;
end;

procedure TTelefoneController.Excluir(ACodigo: integer);
begin
  FDao.Excluir(ACodigo);
end;

end.
