unit UntUsuarioDao;

interface

uses untbasedao, System.Generics.Collections, UntUsuarioModel, System.Classes;

type
  TUsuarioDao = class(TBaseDao)
  public
    function ListarUsuarios(): TObjectList<TUsuarioModel>;
    function Consultar(ANome: String): TUsuarioModel; overload;
    function Consultar(AIdUsuario: integer): TUsuarioModel; overload;
    function Criar(AUsuario: TUsuarioModel): Boolean;
    function Alterar(AUsuario: TUsuarioModel): Boolean;
    function Excluir(AIdUsuario: integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TUsuarioDao }

function TUsuarioDao.Consultar(ANome: String): TUsuarioModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := TUsuarioModel.Create();

  sql := 'select * from usuario where upper(trim(nome)) = upper(:nome) ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('nome').AsString := ANome.Trim;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.Nome := Trim(query.FieldByName('nome').AsString);
      Result.Senha := Trim(query.FieldByName('senha').AsString);
    Except
      on E: Exception do
        Showmessage('Não foi possível carregar o usuário');
    End;
  Finally
    query.Free;
  End;
end;

function TUsuarioDao.ListarUsuarios(): TObjectList<TUsuarioModel>;
var
  query: TZQuery;
  usuario: TUsuarioModel;
  sql: String;
begin
  Result := TObjectList<TUsuarioModel>.Create();

  sql := 'select * from usuario order by id asc ';

  query := CreateQuery(sql);
  Try
    Try
      query.Open();
      while Not query.Eof do
      Begin
        usuario := TUsuarioModel.Create();
        usuario.Id := query.FieldByName('id').AsInteger;
        usuario.Nome := Trim(query.FieldByName('nome').AsString);

        Result.Add(usuario);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível carregar a lista de usuários');
    End;
  Finally
    query.Free;
  End;
end;

function TUsuarioDao.Consultar(AIdUsuario: integer): TUsuarioModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := TUsuarioModel.Create();

  sql := 'select * from usuario where id = :id ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdUsuario;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.Nome := Trim(query.FieldByName('nome').AsString);
      Result.Senha := Trim(query.FieldByName('senha').AsString);
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o usuário');
    End;
  Finally
    query.Free;
  End;
end;

function TUsuarioDao.Criar(AUsuario: TUsuarioModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Insert Into usuario (nome, senha) Values (:nome, :senha)';
  query := CreateQuery(sql);
  Try
    query.ParamByName('nome').AsString := AUsuario.Nome.Trim;
    query.ParamByName('senha').AsString := AUsuario.Senha.Trim;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível salvar o usuários');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TUsuarioDao.Alterar(AUsuario: TUsuarioModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Update usuario Set senha = :senha ' + ' Where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AUsuario.Id;
    query.ParamByName('senha').AsString := AUsuario.Senha;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível salvar o usuários');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TUsuarioDao.Excluir(AIdUsuario: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from usuario ' + ' where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdUsuario;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível excluir o usuários');
      End;
    End;
  Finally
    query.Free;
  End;
end;

end.
