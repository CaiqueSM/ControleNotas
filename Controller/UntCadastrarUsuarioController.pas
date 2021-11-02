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
