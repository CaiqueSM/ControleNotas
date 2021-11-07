unit UntEmailController;

interface

uses
  Classes, SysUtils, UntEmailDao, UntEmailModel,
  UntBaseController;

type

  TEmailController = class(TBaseController)
  private
    FDao: TEmailDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    procedure Alterar(AEmail: TEmailModel);
    procedure Criar(AEmail: TEmailModel);
    function Consultar(ACodigo: integer): TEmailModel;
    procedure Excluir(ACodigo: integer);
  end;

implementation

{ TEmailController }

procedure TEmailController.Alterar(AEmail: TEmailModel);
begin
  FDao.Alterar(AEmail);
end;

function TEmailController.Consultar(ACodigo: integer): TEmailModel;
begin
  Result:= FDao.Consultar(ACodigo);
end;

constructor TEmailController.Create;
begin

end;

procedure TEmailController.Criar(AEmail: TEmailModel);
begin

end;

destructor TEmailController.Destroy;
begin

  inherited;
end;

procedure TEmailController.Excluir(ACodigo: integer);
begin

end;

end.
