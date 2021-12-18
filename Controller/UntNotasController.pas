unit UntNotasController;

interface

uses

  Classes, SysUtils, UntBaseController, UntNotasDao, UntValidarNotas,
  UntNotasModel, UntValidarData, System.Generics.Collections;

type

  TNotasController = class(TBaseController)
  private
    FNotasDao: TNotasDao;
    FValidar: TValidarNotas;
    FValidarData: TValidarData;
  public
    constructor Create();
    destructor Destroy(); override;
    function Consultar(AChaveAcesso: string): TNotasModel; overload;
    function Consultar(AIdNotas: integer): TNotasModel; overload;
    function Criar(ANota: TNotasModel): Boolean;
    function Alterar(ANota: TNotasModel): Boolean;
    function Excluir(AIdNota: integer): Boolean; overload;
    function Excluir(AChaveAcesso: string): Boolean; overload;
    function ListarNotas(): TObjectList<TNotasModel>;
    function ValidarChaveAcesso(AChaveAcesso: string): Boolean;
    function ValidarValor(AValor: string): Boolean;
    function ValidarNumeroPessoal(ANumero: string): Boolean;
    function ValidarData(AData: string):boolean;
    function ChaveExiste(AChaveAcesso: String): Boolean;
  end;

implementation

{ TNotasController }

function TNotasController.Alterar(ANota: TNotasModel): Boolean;
begin
  Result := FNotasDao.Alterar(ANota);
end;

function TNotasController.Consultar(AChaveAcesso: string): TNotasModel;
begin
  Result := FNotasDao.Consultar(AChaveAcesso);
end;

function TNotasController.ChaveExiste(AChaveAcesso: String): Boolean;
begin
  Result := FNotasDao.Consultar(AChaveAcesso) <> nil;
end;

function TNotasController.Consultar(AIdNotas: integer): TNotasModel;
begin
  Result := FNotasDao.Consultar(AIdNotas);
end;

constructor TNotasController.Create;
begin
  inherited;
  FNotasDao := TNotasDao.Create(Conexao);
  FValidar := TValidarNotas.Create;
  FValidarData := TValidarData.Create;
end;

function TNotasController.Criar(ANota: TNotasModel): Boolean;
begin
  Result := FNotasDao.Criar(ANota);
end;

destructor TNotasController.Destroy;
begin
  FNotasDao.Free;
  FValidar.Free;
  FValidarData.Free;
  inherited;
end;

function TNotasController.Excluir(AChaveAcesso: string): Boolean;
begin
  Result := FNotasDao.Excluir(AChaveAcesso);
end;

function TNotasController.ListarNotas: TObjectList<TNotasModel>;
begin
  Result := FNotasDao.ListarNotas;
end;

function TNotasController.Excluir(AIdNota: integer): Boolean;
begin
  Result := FNotasDao.Excluir(AIdNota);
end;

function TNotasController.ValidarData(AData: string): boolean;
begin
  Result := FValidarData.validarData(AData);
end;

function TNotasController.ValidarChaveAcesso(AChaveAcesso: string): Boolean;
begin
  Result := FValidar.ValidarChaveAcesso(AChaveAcesso);
end;

function TNotasController.ValidarNumeroPessoal(ANumero: string): Boolean;
begin
  Result := FValidar.ValidarNumeroPessoal(ANumero);
end;

function TNotasController.ValidarValor(AValor: string): Boolean;
begin
  Result := FValidar.ValidarValor(AValor);
end;

end.
