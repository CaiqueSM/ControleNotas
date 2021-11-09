unit UntContatoController;

interface

uses
  System.Classes, System.Generics.Collections, SysUtils, UntValidarContato,
  UntContatoDao,
  UntContatoModel, UntEnumContatoDao, UntBaseController;

type

  TContatoController = class(TBaseController)
  private
    FDao: TContatoDao;
    FValidarContato: TValidarContato;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    procedure Alterar(AContato: TContatoModel);
    procedure Criar(AContato: TContatoModel);
    function Consultar(ACodigo: integer; Enum: TEnumContatoDao): TContatoModel;
    procedure Excluir(ACodigo: integer; Enum: TEnumContatoDao);

    
  end;

implementation

{ TContatoControler }

procedure TContatoController.Alterar(AContato: TContatoModel);
begin
  FDao.Alterar(AContato);
end;

function TContatoController.Consultar(ACodigo: integer; Enum: TEnumContatoDao)
  : TContatoModel;
begin
  Result := FDao.Consultar(ACodigo, Enum);
end;

constructor TContatoController.Create;
begin
  inherited;
  FDao := TContatoDao.Create(Conexao);
  FValidarContato := TValidarContato.Create;
end;

procedure TContatoController.Criar(AContato: TContatoModel);
begin
  FDao.Criar(AContato);
end;

destructor TContatoController.Destroy;
begin
  FDao.Free;
  FValidarContato.Free;
  inherited;
end;

procedure TContatoController.Excluir(ACodigo: integer; Enum: TEnumContatoDao);
begin
  FDao.Excluir(ACodigo, Enum);
end;



end.
