unit UntTelefoneDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntTelefoneModel, System.Classes;

type

  TTelefoneDao = class(TBaseDao)
  public
    function Consultar(AIdcontato: integer): TObjectList<TTelefoneModel>;
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

function TTelefoneDao.Consultar(AIdcontato: integer): TObjectList<TTelefoneModel>;
var
  query: TZQuery;
  sql: String;
  telefone: TTelefoneModel;
begin
  Result := TObjectList<TTelefoneModel>.Create();

  sql := 'select * from telefone ' +
         ' where idcontato = :idcontato ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('idcontato').AsInteger := AIdcontato;
    Try
      query.Open();
      While Not query.Eof Do
         Begin
            telefone := TTelefoneModel.Create();
            telefone.Id := query.FieldByName('id').AsInteger;
            telefone.IdContato := query.FieldByName('idcontato').AsInteger;
            telefone.Telefone := Trim(query.FieldByName('telefone').AsString);

            Result.Add(telefone);
            query.next;
         End;
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

  sql := 'Insert Into telefone (idcontato, telefone)' +
         'Values (LAST_INSERT_ID(), :telefone)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('telefone').AsString := ATelefone.Telefone;
    Try
      query.ExecSQL();
    Except
      on E: Exception do
      Begin
        Result := False;
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

end.
