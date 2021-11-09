unit UntTelefoneDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntTelefoneModel, System.Classes;

type

  TTelefoneDao = class(TBaseDao)
  public
    function ListarTelefone(): TObjectList<TTelefoneModel>;
    function Consultar(ACodigo: integer): TTelefoneModel;
    function Criar(ATelefone: TTelefoneModel): Boolean;
    function Alterar(ATelefone: TTelefoneModel): Boolean;
    function Excluir(ACodigo: integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TTelefoneDao }

function TTelefoneDao.Alterar(ATelefone: TTelefoneModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;
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
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel gravar os dados de telefone.');
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
        Showmessage('N�o foi poss�vel obter o telefone.');
    End;
  Finally
    query.Free;
  End;
end;

function TTelefoneDao.Criar(ATelefone: TTelefoneModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

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
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel gravar os dados de telefone.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TTelefoneDao.Excluir(ACodigo: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
   Result := True;

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
               Result := False;
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel excluir o telefone');
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
            Showmessage('N�o foi poss�vel carregar a lista de telefone');
      End;
   Finally
      query.Free;
   End;
end;

end.
