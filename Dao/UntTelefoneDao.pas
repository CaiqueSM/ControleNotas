unit UntTelefoneDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntTelefoneModel, System.Classes;

type

  TTelefoneDao = class(TBaseDao)
  public
    Destructor Destroy; override;
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
        Showmessage('Não foi possível gravar os dados de telefone.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TTelefoneDao.Consultar(AIdcontato: integer)
  : TObjectList<TTelefoneModel>;
var
  query: TZQuery;
  sql: String;
  Telefone: TTelefoneModel;
begin
  Result := TObjectList<TTelefoneModel>.Create();

  sql := 'select * from telefone ' + ' where idcontato = :idcontato ';

  query := CreateQuery(sql);
  Try
    query.ParamByName('idcontato').AsInteger := AIdcontato;
    Try
      query.Open();
      While Not query.Eof Do
      Begin
        Telefone := TTelefoneModel.Create();
        Telefone.Id := query.FieldByName('id').AsInteger;
        Telefone.IdContato := query.FieldByName('idcontato').AsInteger;
        Telefone.Telefone := Trim(query.FieldByName('telefone').AsString);

        Result.Add(Telefone);
        query.next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o telefone.');
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
    'Values (:idcontato, :telefone)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('telefone').AsString := ATelefone.Telefone;
    query.ParamByName('idcontato').AsInteger := ATelefone.Idcontato;
    Try
      query.ExecSQL();

    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('Não foi possível gravar os dados de telefone.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

destructor TTelefoneDao.Destroy;
begin
  inherited;
end;

function TTelefoneDao.Excluir(ACodigo: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from telefone ' + ' where idcontato = :id';

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
        Showmessage('Não foi possível excluir o telefone');
      End;
    End;
  Finally
    query.Free;
  End;
end;

end.
