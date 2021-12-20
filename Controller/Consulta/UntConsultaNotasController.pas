unit UntConsultaNotasController;

interface

uses UntBaseController, System.Generics.Collections, UntNotasModel,
  UntNotasDao, System.Classes, SysUtils;

type
  TConsultaNotasController = class(TBaseController)
  private
    FDao: TNotasDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function ListarNotas(): TStringList;
  end;

implementation

{ TConsultaNotasController }

constructor TConsultaNotasController.Create;
begin
  inherited Create();
  FDao := TNotasDao.Create(Conexao);
end;

destructor TConsultaNotasController.Destroy;
begin
  FDao.Free;
  inherited;
end;

function TConsultaNotasController.ListarNotas: TStringList;
var
  Notas: TObjectList<TNotasModel>;
  Nota: TNotasModel;
begin
  Result := TStringList.Create();
  Notas := FDao.ListarNotas();
  if Notas = nil then
  begin
    Result := nil;
    exit();
  end;
  Try
    For Nota In Notas Do
      Result.Add(Nota.Chave);
  Finally
    Notas.Free;
  End;
end;

end.
