unit UntEmailDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntEmailModel, System.Classes;

type

  TEmailDao = class(TBaseDao)
  public
    function ListarEmails(): TObjectList<TEmailModel>;
    function Consultar(ACodigo: integer): TEmailModel;
    procedure Criar(AEmail: TEmailModel);
    procedure Alterar(AEmail: TEmailModel);
    procedure Excluir(ACodigo: integer);
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TEmailDao }

procedure TEmailDao.Alterar(AEmail: TEmailModel);
var
  query: TZQuery;
  sql: String;
begin
  sql := 'Update email Set email = :email where id = :id';
  query := CreateQuery(sql);

  Try
    query.ParamByName('id').AsInteger := AEmail.Id;
    query.ParamByName('email').AsString := AEmail.Email;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TEmailDao.Consultar(ACodigo: integer): TEmailModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := TEmailModel.Create();

  sql := 'select * from email ' + ' where idcontato = :codigo ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('contato').AsInteger := ACodigo;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.IdContato := query.FieldByName('idcontato').AsInteger;
      Result.Email := Trim(query.FieldByName('email').AsString);

    Except
      on E: Exception do
        Showmessage('Não foi possível obter o email.');
    End;
  Finally
    query.Free;
  End;
end;

procedure TEmailDao.Criar(AEmail: TEmailModel);
var
  query: TZQuery;
  sql: String;
begin
  sql := 'Insert Into email (id, idcontato, email)' +
         'Values (:id, :idcontato, :email)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AEmail.Id;
    query.ParamByName('idcontato').AsInteger := AEmail.Id;
    query.ParamByName('email').AsString := AEmail.Email;

    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

procedure TEmailDao.Excluir(ACodigo: integer);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'delete from email ' +
          ' where idcontato = :id' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := ACodigo;
      Try
         query.ExecSQL();
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Conexao.Database.Rollback;
               Showmessage('Não foi possível excluir o cliente');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TEmailDao.ListarEmails: TObjectList<TEmailModel>;
var
  query: TZQuery;
  Email: TEmailModel;
  sql: String;
begin
   Result := TObjectList<TEmailModel>.Create();

   sql := 'select * from email ' +
          ' order by id asc ' ;

   query := CreateQuery(sql);
   Try
      Try
         query.Open();
         while Not query.Eof do
            Begin
               Email := TEmailModel.Create();
               Email.Id := query.FieldByName('id').AsInteger;
               Email.Idcontato := query.FieldByName('idcliente').AsInteger;
               Email.Email := Trim(query.FieldByName('email').AsString);
               Result.Add(Email);
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('Não foi possível carregar a lista de emails');
      End;
   Finally
      query.Free;
   End;
end;

end.
