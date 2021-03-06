unit UntFornecedorDao;

interface

uses untbasedao, System.Generics.Collections, UntFornecedorModel,
  UntRelatorioPeriodoModel, ZDataset, Data.DB,
  System.Classes, UntContatoDao, UntConexao,
  UntRelatorioMensalModel;

type
  TFornecedorDao = class(TBaseDao)
  private
    FContatoDao: TContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;

    function ListarFornecedores(): TObjectList<TFornecedorModel>; overload;
    function ListarFornecedores(ARelatorio: TRelatorioPeriodoModel)
      : TZQuery; overload;
    function ListarFornecedores(ARelatorio: TRelatorioMensalModel)
      : TZQuery; overload;
    function Consultar(AId: integer): TFornecedorModel; overload;
    function Consultar(ANumeroPessoal: String): TFornecedorModel; overload;
    function ConsultarPorNome(ANome: String): TFornecedorModel;
    function Criar(AFornecedor: TFornecedorModel): Boolean;
    function Alterar(AFornecedor: TFornecedorModel): Boolean;
    function Excluir(AIdFornecedor: integer): Boolean;
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs, UntContatoModel,
  UntEmailModel, UntTelefoneModel;

{ TFornecedorDao }

constructor TFornecedorDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FContatoDao := TContatoDao.Create(AConexao);
end;

destructor TFornecedorDao.Destroy;
begin
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
          contato.Id := FcontatoDao.ObterIDContatoFornecedor(AFornecedor.Id);
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
        Showmessage('N?o foi poss?vel gravar os dados de Fornecedor.');
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
    ' where f.id = :id and r.idFornecedor = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AId;
    Try
      query.Open();

      if query.IsEmpty then
      begin
        Result := nil;
        query.Close;
        query.Free;
        exit();
      end;

      Result.Id := query.FieldByName('id').AsInteger;
      Result.nome := Trim(query.FieldByName('nome').AsString);
      Result.CPF := Trim(query.FieldByName('CPF').AsString);
      Result.CNPJ := Trim(query.FieldByName('CNPJ').AsString);
      idContato := query.FieldByName('idcontato').AsInteger;
      Result.Contatos := FContatoDao.ConsultarPorFornecedor(Result.Id,
        idContato);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o Fornecedor.');
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
      if not query.IsEmpty then
        Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o Fornecedor.');
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
      if not query.IsEmpty then
        Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o Fornecedor.');
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
          contato.IdFornecedor := AFornecedor.Id;
          contato.IdCliente := 0;
          If Not FContatoDao.Criar(contato) Then
            raise Exception.Create('Erro ao gravar os contatos');
        End;
      End;
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N?o foi poss?vel gravar os dados de Fornecedor.');
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

  sql := 'delete from Fornecedor where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdFornecedor;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N?o foi poss?vel excluir o Fornecedor');
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

  sql := 'select * from Fornecedor';

  query := CreateQuery(sql);
  Try
    Try
      query.Open();
      if query.IsEmpty then
      begin
        Result := nil;
        exit();
      end;
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
        Showmessage('N?o foi poss?vel carregar a lista de Fornecedores');
    End;
  Finally
    query.Free;
  End;
end;

function TFornecedorDao.ListarFornecedores(ARelatorio: TRelatorioPeriodoModel)
  : TZQuery;
var
  sql: string;
begin

  sql := 'select case when f.cpf = "0" then ' +
    'f.cnpj else f.cpf end as "CPF/CNPJ", Nome, CEP, Rua, Bairro,' +
    ' Cidade, Numero as "N?mero", Complemento, Email as "E-Mail", Telefone' +
    ' from fornecedor as f, notas as n, contato as ct, email as e, telefone as t,'
    + ' relacionamentocontato as r where ct.id = r.idContato and f.id = r.idFornecedor '
    + ' and f.id = n.idFornecedor and e.idContato = ct.id and t.idcontato = ct.id and'
    + ' n.idUsuario = :id ' +
    ' and emissao between :DataInicio and :DataTermino :ordem';

  Result := CreateQuery(sql);
  try
    Result.ParamByName('id').AsInteger := (ARelatorio.IdUsuario);
    Result.ParamByName('DataInicio').AsDate := (ARelatorio.DataInicio);
    Result.ParamByName('DataTermino').AsDate := (ARelatorio.DataTermino);
    Result.ParamByName('ordem').AsString := (ARelatorio.Ordem);
  except
    on E: Exception do
      Showmessage('N?o foi poss?vel carregar a lista de fornecedores');
  end;

end;

function TFornecedorDao.ListarFornecedores(ARelatorio: TRelatorioMensalModel)
  : TZQuery;
var
  sql: string;
begin

  sql := 'select case when f.cpf = "0" then ' +
    'f.cnpj else f.cpf end as "CPF/CNPJ", Nome, CEP, Rua, Bairro,' +
    ' Cidade, Numero as "N?mero", Complemento, Email as "E-Mail", Telefone' +
    ' from fornecedor as f, notas as n, contato as ct, email as e, telefone as t,'
    + ' relacionamentocontato as r where ct.id = r.idContato and f.id = r.idFornecedor '
    + ' and f.id = n.idFornecedor and e.idContato = ct.id and t.idcontato = ct.id and'
    + ' n.idUsuario = :id and Year(emissao) = year(now()) and month(emissao) = :Mes '
    + ' :ordem';

  Result := CreateQuery(sql);
  try
    Result.ParamByName('id').AsInteger := (ARelatorio.IdUsuario);
    Result.ParamByName('Mes').AsString := (intTOstr(ARelatorio.Mes));
    Result.ParamByName('ordem').AsString := (ARelatorio.Ordem);
  except
    on E: Exception do
      Showmessage('N?o foi poss?vel carregar a lista de fornecedores');
  end;

end;

end.
