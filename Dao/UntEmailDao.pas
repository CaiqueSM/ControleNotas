unit UntEmailDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntEmailModel, System.Classes;

type

  TEmailDao = class(TBaseDao)
  public
    destructor Destroy; override;
    function Consultar(AIdContato: integer): TObjectList<TEmailModel>;
    function Criar(AEmail: TEmailModel): Boolean;
    function Alterar(AEmail: TEmailModel): Boolean;
    function Excluir(AIdContato: integer): Boolean;
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
        Showmessage('Não foi possível gravar os dados de email.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TEmailDao.Consultar(AIdContato: integer): TObjectList<TEmailModel>;
var
  query: TZQuery;
  sql: String;
  Email: TEmailModel;
begin
  Result := TObjectList<TEmailModel>.Create();

  sql := 'select * from email where idcontato = :idcontato ';
  query := CreateQuery(sql);
  Try
    query.ParamByName('idcontato').AsInteger := AIdContato;
    Try
      query.Open();
      While Not query.Eof Do
      Begin
        Email := TEmailModel.Create();
        Email.Id := query.FieldByName('id').AsInteger;
        Email.IdContato := query.FieldByName('idcontato').AsInteger;
        Email.Email := Trim(query.FieldByName('email').AsString);

        Result.Add(Email);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter os emails.');
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

  sql := 'Insert Into email (idcontato, email)' + 'Values (:idcontato, :email)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('idcontato').AsInteger := AEmail.IdContato;
    query.ParamByName('email').AsString := AEmail.Email;
    Try
      query.ExecSQL();
    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('Não foi possível gravar os dados de email.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

destructor TEmailDao.Destroy;
begin
  inherited;
end;

function TEmailDao.Excluir(AIdContato: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from email ' + ' where idcontato = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdContato;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível excluir o email');
      End;
    End;
  Finally
    query.Free;
  End;
end;

end.
