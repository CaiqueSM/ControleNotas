unit UntContatoController;

interface

uses
System.Classes, System.Generics.Collections,SysUtils, UntValidarContato, UntContatoDao,
UntContatoModel, UntEnumContatoDao, UntBaseController;

type

TContatoControler = class(TBaseController)
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
    function ValidarCEP(ACEP: string): boolean;
    function ValidarEmail(AEmail:string): boolean;
    function ValidarNumero(ANumero:string): boolean;
    function ValidarTelefone(ATelefone:string): boolean;
end;

implementation

{ TContatoControler }

procedure TContatoControler.Alterar(AContato: TContatoModel);
begin
  FDao.Alterar(AContato);
end;

function TContatoControler.Consultar(ACodigo: integer;
  Enum: TEnumContatoDao): TContatoModel;
begin
  Result:= FDao.Consultar(ACodigo, Enum);
end;

constructor TContatoControler.Create;
begin
  inherited;
  FDao:= TContatoDao.Create(Conexao);
  FValidarContato:= TValidarContato.Create;
end;

procedure TContatoControler.Criar(AContato: TContatoModel);
begin
  FDao.Criar(AContato);
end;

destructor TContatoControler.Destroy;
begin
  FDao.Free;
  FValidarContato.Free;
  inherited;
end;

procedure TContatoControler.Excluir(ACodigo: integer; Enum: TEnumContatoDao);
begin
  FDao.Excluir(ACodigo, Enum);
end;

function TContatoControler.ValidarCEP(ACEP: string): boolean;
begin
  Result:= FValidarContato.ValidarCEP(ACEP);
end;

function TContatoControler.ValidarEmail(AEmail: string): boolean;
begin
  Result:= FValidarContato.ValidarEmail(AEmail);
end;

function TContatoControler.ValidarNumero(ANumero: string): boolean;
begin
  Result:= FValidarContato.ValidarNumero(ANumero);
end;

function TContatoControler.ValidarTelefone(ATelefone: string): boolean;
begin
  Result:= FValidarContato.ValidarTelefone(ATelefone);
end;

end.
