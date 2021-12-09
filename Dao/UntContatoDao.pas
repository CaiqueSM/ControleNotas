unit UntContatoDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntContatoModel, System.Classes,
  UntEnumContatoDao, UntEmailDao, UntTelefoneDao, UntConexao;

type

  TContatoDao = class(TBaseDao)
  private
    FEmailDao: TEmailDao;
    FTelefoneDao: TTelefoneDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;

    function Criar(AContato: TContatoModel): Boolean;
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
end;

destructor TContatoDao.Destroy;
begin
  FEmailDao.Free;
  FTelefoneDao.Free;
  inherited;
end;

function TContatoDao.Alterar(AContato: TContatoModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

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
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel atualizar os dados de contato.');
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

  sql := 'select c.id, cep, rua, bairro, cidade, numero, complemento, cl.id as IdCliente'
    + ' from contato as c, relacionamentocontato as r, cliente as cl' +
    ' where (c.id = :idcontato) and (r.idrelacionado = :id)';
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
        contato.IdCliente := query.FieldByName('IdCliente').AsInteger;
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
        Showmessage('N�o foi poss�vel obter o contato.');
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

  sql := 'select c.id, cep, rua, bairro, cidade, numero, complemento, f.id as IdFornecedor'
    + ' from contato as c, relacionamentocontato as r, fornecedor as f' +
    ' where (c.id = :idcontato) and (r.idrelacionado = :id)';
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
        contato.IdCliente := query.FieldByName('IdFornecedor').AsInteger;
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
        Showmessage('N�o foi poss�vel obter o contato.');
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.Criar(AContato: TContatoModel): Boolean;
var
  query: TZQuery;
  sql: String;
  nenhum: Integer;
  email: TEmailModel;
  telefone: TTelefoneModel;
begin
  Result := True;
  nenhum := 0;

  sql := 'Insert Into Contato (id, bairro, CEP, cidade, complemento, numero, rua)'
    + 'Values (:id, :bairro, :CEP, :cidade, :complemento, :numero, :rua)';

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
          If Not FEmailDao.Criar(email) Then
            raise Exception.Create('Erro ao gravar os emails');
        End;
      End;

      If (AContato.Telefones.Count > nenhum) Then
      Begin
        For telefone In AContato.Telefones Do
        Begin
          If Not FTelefoneDao.Criar(telefone) Then
            raise Exception.Create('Erro ao gravar os telefones');
        End;
      End;
    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('N�o foi poss�vel gravar os dados de contato.');
      End;
    End;
  Finally
    query.Free;
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
        Showmessage('N�o foi poss�vel excluir o contato');
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
        Showmessage('N�o foi poss�vel excluir o contato');
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
        Showmessage('N�o foi poss�vel excluir o contato');
      End;
    End;
  Finally
    query.Free;
  End;

end;

end.
