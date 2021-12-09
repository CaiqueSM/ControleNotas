unit UntFornecedorDao;

interface

uses untbasedao, System.Generics.Collections, UntFornecedorModel,
  UntRelacionamentoContatoModel,
  System.Classes, UntContatoDao, UntRelacionamentoContatoDao, UntConexao;

type
  TFornecedorDao = class(TBaseDao)
  private
    FContatoDao: TContatoDao;
    FRelacionamentoDao: TRelacionamentoContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;

    function ListarFornecedores(): TObjectList<TFornecedorModel>;overload;
    function ListarFornecedores(ASQL: string): TObjectList<TFornecedorModel>;
    overload;
    function Consultar(AId: integer): TFornecedorModel; overload;
    function Consultar(ANumeroPessoal: String): TFornecedorModel; overload;
    function ConsultarPorNome(ANome: String): TFornecedorModel;
    function Criar(AFornecedor: TFornecedorModel): Boolean;
    function Alterar(AFornecedor: TFornecedorModel): Boolean;
    function Excluir(AIdFornecedor: integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs, UntContatoModel,
  UntEmailModel, UntTelefoneModel;

{ TFornecedorDao }

constructor TFornecedorDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FContatoDao := TContatoDao.Create(AConexao);
  FRelacionamentoDao := TRelacionamentoContatoDao.Create(AConexao);
end;

destructor TFornecedorDao.Destroy;
begin
  FRelacionamentoDao.Free;
  FContatoDao.Free;
  inherited;
end;

function TFornecedorDao.Alterar(AFornecedor: TFornecedorModel): Boolean;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
  nenhum: integer;
begin
  Result := True;
  nenhum := 0;

  sql := 'Update Fornecedor Set nome = :nome, CPF = :CPF, CNPJ = :CNPJ ' +
    ' Where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AFornecedor.Id;
    query.ParamByName('nome').AsString := AFornecedor.nome;
    query.ParamByName('CPF').AsString := AFornecedor.CPF;
    query.ParamByName('CNPJ').AsString := AFornecedor.CNPJ;

    Try
      query.ExecSQL();

      If (AFornecedor.Contatos.Count > nenhum) Then
      Begin
        For contato In AFornecedor.Contatos Do
        Begin
          If Not FContatoDao.Alterar(contato) Then
            raise Exception.Create('Erro ao gravar os contatos');
        End;
      end;

      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados de Fornecedor.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.Consultar(AId: integer): TFornecedorModel;
var
  query: TZQuery;
  sql: String;
  idContato: integer;
begin
  Result := TFornecedorModel.Create();

  sql := 'select f.id, nome, CPF, CNPJ, r.idcontato as idcontato' +
    ' from Fornecedor as f, relacionamentocontato as r' +
    ' where f.id = :id and r.idrelacionado = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AId;
    Try
      query.Open();

      Result.Id := query.FieldByName('id').AsInteger;
      Result.nome := Trim(query.FieldByName('nome').AsString);
      Result.CPF := Trim(query.FieldByName('CPF').AsString);
      Result.CNPJ := Trim(query.FieldByName('CNPJ').AsString);
      idContato := query.FieldByName('idcontato').AsInteger;
      Result.Contatos := FContatoDao.ConsultarPorFornecedor(Result.Id,
        idContato);
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o Fornecedor.');
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.Consultar(ANumeroPessoal: String): TFornecedorModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;
  sql := 'select id from fornecedor where CNPJ = :CNPJ';
  query := CreateQuery(sql);
  Try
    query.ParamByName('CNPJ').AsString := ANumeroPessoal;
    Try
      query.Open();
      Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o Fornecedor.');
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.ConsultarPorNome(ANome: String): TFornecedorModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;
  sql := 'select id from fornecedor where nome = :nome';
  query := CreateQuery(sql);
  Try
    query.ParamByName('nome').AsString := ANome;
    Try
      query.Open();
      Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('Não foi possível obter o Fornecedor.');
    End;
  Finally
    query.Free;
  End;

end;

function TFornecedorDao.Criar(AFornecedor: TFornecedorModel): Boolean;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
  relacionamento: TRelacionamentoContatoModel;
  nenhum: integer;
begin
  Result := True;
  nenhum := 0;

  sql := 'Insert Into Fornecedor (id, nome, CPF, CNPJ) Values (:id, :nome, :CPF, :CNPJ)';
  query := CreateQuery(sql);

  Try
    query.ParamByName('id').AsInteger := AFornecedor.Id;
    query.ParamByName('nome').AsString := AFornecedor.nome.Trim;
    query.ParamByName('CPF').AsString := AFornecedor.CPF.Trim;
    query.ParamByName('CNPJ').AsString := AFornecedor.CNPJ.Trim;
    Try
      query.ExecSQL();

      If (AFornecedor.Contatos.Count > nenhum) Then
      Begin
        For contato In AFornecedor.Contatos Do
        Begin
          If Not FContatoDao.Criar(contato) Then
            raise Exception.Create('Erro ao gravar os contatos');
          relacionamento := TRelacionamentoContatoModel.Create;
          relacionamento.idContato := contato.Id;
          relacionamento.idRelacionado := AFornecedor.Id;
          FRelacionamentoDao.Criar(relacionamento);
          relacionamento.Free;
        End;
      End;
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados de Fornecedor.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.Excluir(AIdFornecedor: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from Fornecedor ' + ' where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdFornecedor;
    Try
      query.ExecSQL();

      If Not FContatoDao.ExcluirPorFornecedor(AIdFornecedor) Then
        raise Exception.Create('Erro ao excluir os contatos');

      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível excluir o Fornecedor');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.ListarFornecedores: TObjectList<TFornecedorModel>;
var
  query: TZQuery;
  Fornecedor: TFornecedorModel;
  sql: String;
begin
  Result := TObjectList<TFornecedorModel>.Create();

  sql := 'select * from Fornecedor ' + ' order by id asc ';

  query := CreateQuery(sql);
  Try
    Try
      query.Open();
      while Not query.Eof do
      Begin
        Fornecedor := TFornecedorModel.Create();
        Fornecedor.Id := query.FieldByName('id').AsInteger;
        Fornecedor.nome := Trim(query.FieldByName('nome').AsString);
        Fornecedor.CPF := Trim(query.FieldByName('CPF').AsString);
        Fornecedor.CNPJ := Trim(query.FieldByName('CNPJ').AsString);

        Result.Add(Fornecedor);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível carregar a lista de Fornecedores');
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.ListarFornecedores(ASQL: string): TObjectList<TFornecedorModel>;
var
  query: TZQuery;
  Fornecedor: TFornecedorModel;
begin
  Result := TObjectList<TFornecedorModel>.Create();

  query := CreateQuery(trim(ASQL));
  Try
    Try
      query.Open();
      while Not query.Eof do
      Begin
        Fornecedor := TFornecedorModel.Create();
        Fornecedor.Id := query.FieldByName('id').AsInteger;
        Fornecedor.nome := Trim(query.FieldByName('nome').AsString);
        Fornecedor.CPF := Trim(query.FieldByName('CPF').AsString);
        Fornecedor.CNPJ := Trim(query.FieldByName('CNPJ').AsString);

        Result.Add(Fornecedor);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('Não foi possível carregar a lista de Fornecedores');
    End;
  Finally
    query.Free;
  End;
end;

end.
