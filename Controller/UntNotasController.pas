unit UntNotasController;

interface

uses

  Classes, SysUtils, UntBaseController, UntNotasDao, UntValidarNotas,
  UntNotasModel, System.Generics.Collections;

type

  TNotasController = class(TBaseController)
  private
    FNotasDao: TNotasDao;
    FValidar: TValidarNotas;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
    function Consultar(AChaveAcesso: string): TObjectList<TNotasModel>;
      overload;
    function Consultar(AIdNotas: integer): TObjectList<TNotasModel>; overload;
    function Criar(ANota: TNotasModel): Boolean;
    function Alterar(ANota: TNotasModel): Boolean;
    function Excluir(AIdNota: integer): Boolean; overload;
    function Excluir(AChaveAcesso: string): Boolean; overload;
    function ValidarChaveAcesso(AChaveAcesso: string): Boolean;
    function ValidarValor(AValor: string): Boolean;
    function ValidarNumeroPessoal(ANumero: string): boolean;
  end;

implementation

{ TNotasController }

function TNotasController.Alterar(ANota: TNotasModel): Boolean;
begin
  Result := FNotasDao.Alterar(ANota);
end;

function TNotasController.Consultar(AChaveAcesso: string)
  : TObjectList<TNotasModel>;
begin
  Result := FNotasDao.Consultar(AChaveAcesso);
end;

function TNotasController.Consultar(AIdNotas: integer)
  : TObjectList<TNotasModel>;
begin
  Result := FNotasDao.Consultar(AIdNotas);
end;

constructor TNotasController.Create;
begin
  FNotasDao := TNotasDao.Create;
  FValidar := TValidarNotas.Create;
end;

function TNotasController.Criar(ANota: TNotasModel): Boolean;
begin
  Result:= FNotasDao.Criar(ANota);
end;

destructor TNotasController.Destroy;
begin
  FNotasDao.Free;
  FValidar.Free;
  inherited;
end;

function TNotasController.Excluir(AChaveAcesso: string): Boolean;
begin
  Result:= FNotasDao.Excluir(AChaveAcesso);
end;

function TNotasController.Excluir(AIdNota: integer): Boolean;
begin
  Result:= FNotasDao.Excluir(AIdNota);
end;

function TNotasController.ValidarChaveAcesso(AChaveAcesso: string): Boolean;
begin
  Result := FValidar.ValidarChaveAcesso(AChaveAcesso);
end;

function TNotasController.ValidarNumeroPessoal(ANumero: string): boolean;
begin
  Result:= ValidarNumeroPessoal(ANumero);
end;

function TNotasController.ValidarValor(AValor: string): Boolean;
begin
  Result := FValidar.ValidarValor(AValor);
end;

end.
