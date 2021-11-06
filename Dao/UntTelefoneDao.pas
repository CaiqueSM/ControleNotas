unit UntTelefoneDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntTelefoneModel, System.Classes;

type

  TTelefoneDao = class(TBaseDao)
  public
    function ListarTelefone(): TObjectList<TTelefoneModel>;
    function Consultar(ACodigo: integer): TTelefoneModel;
    procedure Criar(ATelefone: TTelefoneModel);
    procedure Alterar(ATelefone: TTelefoneModel);
    procedure Excluir(ACodigo: integer);
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TTelefoneDao }

procedure TTelefoneDao.Alterar(ATelefone: TTelefoneModel);
var
  query: TZQuery;
  sql: String;
begin
  sql := 'Update telefone Set telefone = :telefone' + ' where idcontato = :id';

  query := CreateQuery(sql);

  Try
    query.ParamByName('id').AsInteger := ATelefone.Id;
    query.ParamByName('telefone').AsString := ATelefone.Telefone;
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

function TTelefoneDao.Consultar(ACodigo: integer): TTelefoneModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := TTelefoneModel.Create();

  sql := 'select * from telefone ' +
         ' where idcontato = :codigo ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('codigo').AsInteger := ACodigo;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.IdContato := query.FieldByName('idcontato').AsInteger;
      Result.Telefone := Trim(query.FieldByName('telefone').AsString);

    Except
      on E: Exception do
        Showmessage('Não foi possível obter o telefone.');
    End;
  Finally
    query.Free;
  End;
end;

procedure TTelefoneDao.Criar(ATelefone: TTelefoneModel);
var
  query: TZQuery;
  sql: String;
begin
  sql := 'Insert Into telefone (id, idcontato, telefone)' +
         'Values (:id, :idcontato, :telefone)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := ATelefone.Id;
    query.ParamByName('idcontato').AsInteger := ATelefone.Idcontato;
    query.ParamByName('telefone').AsString := ATelefone.Telefone;

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

procedure TTelefoneDao.Excluir(ACodigo: integer);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'delete from telefone ' +
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
               Showmessage('Não foi possível excluir o telefone');
            End;
      End;
   Finally
      query.Free;
   End;
end;
function TTelefoneDao.ListarTelefone: TObjectList<TTelefoneModel>;
var
  query: TZQuery;
  Telefone: TTelefoneModel;
  sql: String;
begin
   Result := TObjectList<TTelefoneModel>.Create();

   sql := 'select * from telefone ' +
          ' order by id asc ' ;

   query := CreateQuery(sql);
   Try
      Try
         query.Open();
         while Not query.Eof do
            Begin
               Telefone := TTelefoneModel.Create();
               Telefone.Id := query.FieldByName('id').AsInteger;
               Telefone.Idcontato := query.FieldByName('idcontato').AsInteger;
               Telefone.Telefone := Trim(query.FieldByName('telefone').AsString);
               Result.Add(Telefone);
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('Não foi possível carregar a lista de telefone');
      End;
   Finally
      query.Free;
   End;
end;

end.
