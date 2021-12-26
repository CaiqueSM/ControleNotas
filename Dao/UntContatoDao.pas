unit UntContatoDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntContatoModel, System.Classes,
  UntEnumContatoDao, UntEmailDao, UntTelefoneDao, UntRelacionamentoContatoDao,
  UntRelacionamentoContatoModel, UntConexao;

type

  TContatoDao = class(TBaseDao)
  private
    FEmailDao: TEmailDao;
    FTelefoneDao: TTelefoneDao;
    FRelacionamentoDao: TRelacionamentoContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;
    function Criar(AContato: TContatoModel): Boolean;
    function ObterIDContatoFornecedor(AidFornecedor: integer): integer;
    function ObterIDContatoCliente(AidCliente: integer): integer;
    function ConsultarPorCliente(AIdCliente, AIdContato: Integer)
      : TObjectList<TContatoModel>;
    function ConsultarPorFornecedor(AIdFornecedor, AIdContato: Integer)
      : TObjectList<TContatoModel>;
    function ExcluirPorCliente(AIdCliente: Integer): Boolean;
    function ExcluirPorFornecedor(AIdFornecedor: Integer): Boolean;
    function Alterar(AContato: TContatoModel): Boolean;
    function Excluir(ACodigo: Integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs, UntEmailModel, UntTelefoneModel;

{ TContatoDao }

constructor TContatoDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FEmailDao := TEmailDao.Create(AConexao);
  FTelefoneDao := TTelefoneDao.Create(AConexao);
  FRelacionamentoDao := TRelacionamentoContatoDao.Create(AConexao);
end;

destructor TContatoDao.Destroy;
begin
  FRelacionamentoDao.Free;
  FEmailDao.Free;
  FTelefoneDao.Free;
  inherited;
end;

function TContatoDao.Alterar(AContato: TContatoModel): Boolean;
var
  query: TZQuery;
  sql: String;
  nenhum: integer;
  email: TEmailModel;
  telefone: TTelefoneModel;
begin
  Result := True;
  nenhum := 0;
  sql := 'Update contato Set bairro = :bairro, CEP = :CEP, cidade = :cidade,' +
    'complemento = :complemento, numero = :numero, rua = :rua' +
    ' Where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AContato.Id;
    query.ParamByName('bairro').AsString := AContato.Bairro;
    query.ParamByName('CEP').AsString := AContato.CEP;
    query.ParamByName('cidade').AsString := AContato.Cidade;
    query.ParamByName('complemento').AsString := AContato.Complemento;
    query.ParamByName('numero').AsString := AContato.Numero;
    query.ParamByName('rua').AsString := AContato.Rua;
    Try
      query.ExecSQL();

      If (AContato.Emails.Count > nenhum) Then
      Begin
        For email In AContato.Emails Do
        Begin
          email.IdContato := AContato.Id;
          If Not FEmailDao.Alterar(email) Then
            raise Exception.Create('Erro ao gravar os emails');
        End;
      End;

      If (AContato.Telefones.Count > nenhum) Then
      Begin
        For telefone In AContato.Telefones Do
        Begin
          telefone.IdContato := AContato.Id;
          If Not FTelefoneDao.Alterar(telefone) Then
            raise Exception.Create('Erro ao gravar os telefones');
        End;
      End;

    Conexao.Database.Commit;

    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível atualizar os dados de contato.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ObterIDContatoCliente(AidCliente: integer): integer;
var
  query: TZQuery;
  sql: String;
begin
  Result := 0;
  sql := 'select r.idContato from relacionamentocontato as r where idCliente = :id';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdCliente;
    Try
      query.Open();
      if not query.IsEmpty then
        result := query.FieldByName('idContato').AsInteger;
    Except
      on E: Exception do
      Begin
        Showmessage('Não foi possível obter o contato.');
      End;
    End;
  Finally
    query.Free;
  End;


end;

function TContatoDao.ObterIDContatoFornecedor(AidFornecedor: integer): integer;
var
  query: TZQuery;
  sql: String;
begin
  Result := 0;
  sql := 'select r.idContato from relacionamentocontato as r where idFornecedor = :id';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdFornecedor;
    Try
      query.Open();
      if not query.IsEmpty then
        result := query.FieldByName('idContato').AsInteger;
    Except
      on E: Exception do
      Begin
        Showmessage('Não foi possível obter o contato.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ConsultarPorCliente(AIdCliente, AIdContato: Integer)
  : TObjectList<TContatoModel>;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
begin
  Result := TObjectList<TContatoModel>.Create();

  sql := 'select c.id, cep, rua, bairro, cidade, numero, complemento' +
    ' from contato as c, relacionamentocontato as r' +
    ' where r.idContato = :idcontato and r.idCliente = :id and r.idContato = c.id';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdCliente;
    query.ParamByName('idcontato').AsInteger := AIdContato;
    Try
      query.Open();
      While Not query.Eof Do
      Begin
        contato := TContatoModel.Create();
        contato.Id := query.FieldByName('id').AsInteger;
        contato.CEP := Trim(query.FieldByName('CEP').AsString);
        contato.Rua := Trim(query.FieldByName('rua').AsString);
        contato.Cidade := Trim(query.FieldByName('cidade').AsString);
        contato.Numero := Trim(query.FieldByName('numero').AsString);
        contato.Bairro := Trim(query.FieldByName('bairro').AsString);
        contato.Complemento := Trim(query.FieldByName('complemento').AsString);

        contato.Emails := FEmailDao.Consultar(contato.Id);
        contato.Telefones := FTelefoneDao.Consultar(contato.Id);

        Result.Add(contato);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o contato.');
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ConsultarPorFornecedor(AIdFornecedor, AIdContato: Integer)
  : TObjectList<TContatoModel>;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
begin
  Result := TObjectList<TContatoModel>.Create();

  sql := 'select c.id, cep, rua, bairro, cidade, numero, complemento' +
    ' from contato as c, relacionamentocontato as r' +
    ' where r.idFornecedor = :id and r.idContato = :idContato and r.idContato = c.id';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdFornecedor;
    query.ParamByName('idcontato').AsInteger := AIdContato;
    Try
      query.Open();
      While Not query.Eof Do
      Begin
        contato := TContatoModel.Create();
        contato.Id := query.FieldByName('id').AsInteger;
        contato.CEP := Trim(query.FieldByName('CEP').AsString);
        contato.Rua := Trim(query.FieldByName('rua').AsString);
        contato.Cidade := Trim(query.FieldByName('cidade').AsString);
        contato.Numero := Trim(query.FieldByName('numero').AsString);
        contato.Bairro := Trim(query.FieldByName('bairro').AsString);
        contato.Complemento := Trim(query.FieldByName('complemento').AsString);

        contato.Emails := FEmailDao.Consultar(contato.Id);
        contato.Telefones := FTelefoneDao.Consultar(contato.Id);

        Result.Add(contato);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o contato.');
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.Criar(AContato: TContatoModel): Boolean;
var
  queryInsert, querySelect: TZQuery;
  sqlInsert, sqlSelect: String;
  nenhum: Integer;
  email: TEmailModel;
  telefone: TTelefoneModel;
  relacionamento: TRelacionamentoContatoModel;
begin
  Result := True;
  nenhum := 0;

  sqlInsert :=
    'Insert Into Contato (bairro, CEP, cidade, complemento, numero, rua)' +
    'Values (:bairro, :CEP, :cidade, :complemento, :numero, :rua)';

  sqlSelect := 'select last_insert_id() as idContato';

  queryInsert := CreateQuery(sqlInsert);
  querySelect := CreateQuery(sqlSelect);

  Try
    queryInsert.ParamByName('bairro').AsString := AContato.Bairro;
    queryInsert.ParamByName('CEP').AsString := AContato.CEP;
    queryInsert.ParamByName('cidade').AsString := AContato.Cidade;
    queryInsert.ParamByName('complemento').AsString := AContato.Complemento;
    queryInsert.ParamByName('numero').AsString := AContato.Numero;
    queryInsert.ParamByName('rua').AsString := AContato.Rua;
    Try
      queryInsert.ExecSQL();
      querySelect.Open();

      If (AContato.Emails.Count > nenhum) Then
      Begin
        For email In AContato.Emails Do
        Begin
          email.IdContato := querySelect.FieldByName('idContato').AsInteger;
          If Not FEmailDao.Criar(email) Then
            raise Exception.Create('Erro ao gravar os emails');
        End;
      End;

      If (AContato.Telefones.Count > nenhum) Then
      Begin
        For telefone In AContato.Telefones Do
        Begin
          telefone.IdContato := querySelect.FieldByName('idContato').AsInteger;
          If Not FTelefoneDao.Criar(telefone) Then
            raise Exception.Create('Erro ao gravar os telefones');
        End;
      End;

      relacionamento := TRelacionamentoContatoModel.Create;
      relacionamento.idContato := querySelect.FieldByName('idContato').AsInteger;
      relacionamento.idCliente := AContato.idCliente;
      relacionamento.idFornecedor := AContato.IdFornecedor;
      FRelacionamentoDao.Criar(relacionamento);
      relacionamento.Free;

    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados de contato.');
      End;
    End;
  Finally
    queryInsert.Free;
    querySelect.Free;
  End;
end;

function TContatoDao.Excluir(ACodigo: Integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;
  sql := 'delete from contato where id = :id';
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
        Showmessage('Não foi possível excluir o contato');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ExcluirPorCliente(AIdCliente: Integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from contato' +
    ' where id = (select idcontato from relacionamentocontato as r' +
    ' where r.idrelacionado = :idcliente)';
  query := CreateQuery(sql);
  Try
    query.ParamByName('idcliente').AsInteger := AIdCliente;
    Try
      query.ExecSQL();
    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('Não foi possível excluir o contato');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ExcluirPorFornecedor(AIdFornecedor: Integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from contato' +
    ' where id = (select idcontato from relacionamentocontato as r' +
    ' where r.idrelacionado = :idfornecedor)';
  query := CreateQuery(sql);
  Try
    query.ParamByName('idfornecedor').AsInteger := AIdFornecedor;
    Try
      query.ExecSQL();
    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('Não foi possível excluir o contato');
      End;
    End;
  Finally
    query.Free;
  End;

end;

end.
