unit UntUsuarioController;

interface

uses untbasecontroller, UntUsuarioDao, System.Generics.Collections,
  UntUsuarioModel, System.Classes;

type
  TUsuarioController = class(TBaseController)
  private
    FDao: TUsuarioDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Consultar(ANome: String): TUsuarioModel;
    procedure Criar(AUsuario: TUsuarioModel);
    procedure Alterar(AUsuario: TUsuarioModel);
    procedure Excluir(AIdUsuario: Integer);

    function VerificarSenhaUsuarioEstaCorreta(AUsuario, ASenhaAtual: String): Boolean;
  end;

implementation

{ TUsuarioController }

constructor TUsuarioController.Create;
begin
  inherited;
  FDao := TUsuarioDao.Create(Conexao);
end;

destructor TUsuarioController.Destroy;
begin
  FDao.Free;
  inherited;
end;

procedure TUsuarioController.Excluir(AIdUsuario: Integer);
begin
   FDao.Excluir(AIdUsuario);
end;

procedure TUsuarioController.Criar(AUsuario: TUsuarioModel);
begin
   FDao.Criar(AUsuario);
end;

procedure TUsuarioController.Alterar(AUsuario: TUsuarioModel);
begin
   FDao.Alterar(AUsuario);
end;

function TUsuarioController.Consultar(ANome: String): TUsuarioModel;
begin
   Result := FDao.Consultar(ANome);
end;

function TUsuarioController.VerificarSenhaUsuarioEstaCorreta(AUsuario,
  ASenhaAtual: String): Boolean;
var
  usuario: TUsuarioModel;
begin
   usuario := Consultar(AUsuario);
   Try
      Result := (usuario.Senha = ASenhaAtual);
   Finally
      usuario.Free;
   End;
end;

end.
