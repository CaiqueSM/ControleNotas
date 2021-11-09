unit UntEmailDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntEmailModel, System.Classes;

type

  TEmailDao = class(TBaseDao)
  public
    function ListarEmails(): TObjectList<TEmailModel>;
    function Consultar(ACodigo: integer): TEmailModel;
    function Criar(AEmail: TEmailModel): Boolean;
    function Alterar(AEmail: TEmailModel): Boolean;
    function Excluir(ACodigo: integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TEmailDao }

function TEmailDao.Alterar(AEmail: TEmailModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Update email Set email = :email where idcontato = :id';
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
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel gravar os dados de email.');
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
    query.ParamByName('codigo').AsInteger := ACodigo;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.IdContato := query.FieldByName('idcontato').AsInteger;
      Result.Email := Trim(query.FieldByName('email').AsString);

    Except
      on E: Exception do
        Showmessage('N�o foi poss�vel obter o email.');
    End;
  Finally
    query.Free;
  End;
end;

function TEmailDao.Criar(AEmail: TEmailModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Insert Into email (id, idcontato, email)' +
         'Values (:id, :idcontato, :email)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AEmail.Id;
    query.ParamByName('idcontato').AsInteger := AEmail.IdContato;
    query.ParamByName('email').AsString := AEmail.Email;

    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel gravar os dados de email.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TEmailDao.Excluir(ACodigo: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
   Result := True;

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
               Result := False;
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel excluir o email');
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
               Email.Idcontato := query.FieldByName('idcontato').AsInteger;
               Email.Email := Trim(query.FieldByName('email').AsString);
               Result.Add(Email);
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('N�o foi poss�vel carregar a lista de emails');
      End;
   Finally
      query.Free;
   End;
end;

end.
