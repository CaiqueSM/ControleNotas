unit UntCadastrarUsuarioController;

interface

uses untbasecontroller, UntCadastrarUsuarioDao, System.Generics.Collections,
  UntUsuarioModel, System.Classes;

type
  TCadastrarUsuarioController = class(TBaseController)
  private
    FDao: TCadastrarUsuarioDao;
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

{ TCadastrarUsuarioController }

constructor TCadastrarUsuarioController.Create;
begin
  inherited;
  FDao := TCadastrarUsuarioDao.Create(Conexao);
end;

destructor TCadastrarUsuarioController.Destroy;
begin
  FDao.Free;
  inherited;
end;

procedure TCadastrarUsuarioController.Excluir(AIdUsuario: Integer);
begin
   FDao.Excluir(AIdUsuario);
end;

procedure TCadastrarUsuarioController.Criar(AUsuario: TUsuarioModel);
begin
   FDao.Criar(AUsuario);
end;

procedure TCadastrarUsuarioController.Alterar(AUsuario: TUsuarioModel);
begin
   FDao.Alterar(AUsuario);
end;

function TCadastrarUsuarioController.Consultar(ANome: String): TUsuarioModel;
begin
   Result := FDao.Consultar(ANome);
end;

function TCadastrarUsuarioController.VerificarSenhaUsuarioEstaCorreta(AUsuario,
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
