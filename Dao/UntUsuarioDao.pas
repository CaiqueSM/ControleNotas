unit UntUsuarioDao;

interface

uses untbasedao, System.Generics.Collections, UntUsuarioModel, System.Classes;

type
  TUsuarioDao = class(TBaseDao)
  public
    function ListarUsuarios(): TObjectList<TUsuarioModel>;
    function Consultar(ANome: String): TUsuarioModel;
    procedure Criar(AUsuario: TUsuarioModel);
    procedure Alterar(AUsuario: TUsuarioModel);
    procedure Excluir(AIdUsuario: Integer);
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

   sql := 'select * from usuario ' +
          ' where upper(trim(nome)) = upper(:nome) ' ;

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
            Showmessage('N�o foi poss�vel carregar o usu�rio');
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

   sql := 'select * from usuario ' +
          ' order by id asc ' ;

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
            Showmessage('N�o foi poss�vel carregar a lista de usu�rios');
      End;
   Finally
      query.Free;
   End;
end;

procedure TUsuarioDao.Criar(AUsuario: TUsuarioModel);
var
  query: TZQuery;
  sql: String;
begin
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
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel salvar o usu�rios');
            End;
      End;
   Finally
      query.Free;
   End;
end;

procedure TUsuarioDao.Alterar(AUsuario: TUsuarioModel);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'Update usuario Set senha = :senha ' +
          ' Where id = :id';

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
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel salvar o usu�rios');
            End;
      End;
   Finally
      query.Free;
   End;
end;

procedure TUsuarioDao.Excluir(AIdUsuario: Integer);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'delete from usuario ' +
          ' where id = :id' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := AIdUsuario;
      Try
         query.ExecSQL();
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel excluir o usu�rios');
            End;
      End;
   Finally
      query.Free;
   End;
end;

end.
