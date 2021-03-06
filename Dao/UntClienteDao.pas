unit UntClienteDao;

interface

uses untbasedao, System.Generics.Collections, UntClienteModel,
  ZDataset, UntRelatorioPeriodoModel, Data.DB,
  System.Classes, UntContatoDao, UntConexao,
  UntRelatorioMensalModel;

type
  TClienteDao = class(TBaseDao)
  private
    FContatoDao: TContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;
    function ListarClientes(): TObjectList<TClienteModel>; overload;
    function ListarClientes(ARelatorio: TRelatorioPeriodoModel)
      : TZQuery; overload;
    function ListarClientes(ARelatorio: TRelatorioMensalModel)
      : TZQuery; overload;
    function Consultar(AId: integer): TClienteModel; overload;
    function Consultar(AnumeroPessoal: String): TClienteModel; overload;
    function ConsultarPorNome(ANome: String): TClienteModel;
    function Criar(ACliente: TClienteModel): Boolean;
    function Alterar(ACliente: TClienteModel): Boolean;
    function Excluir(AIdCliente: integer): Boolean;
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs, UntContatoModel,
  UntEmailModel, UntTelefoneModel;

{ TClienteDao }

constructor TClienteDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FContatoDao := TContatoDao.Create(AConexao);
end;

destructor TClienteDao.Destroy;
begin
  FContatoDao.Free;
  inherited;
end;

function TClienteDao.Alterar(ACliente: TClienteModel): Boolean;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
  nenhum: integer;
begin
  Result := True;
  nenhum := 0;
  sql := 'Update Cliente Set nome = :nome, CPF = :CPF, CNPJ = :CNPJ ' +
    ' Where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := ACliente.Id;
    query.ParamByName('nome').AsString := ACliente.nome;
    query.ParamByName('CPF').AsString := ACliente.CPF;
    query.ParamByName('CNPJ').AsString := ACliente.CNPJ;

    Try
      query.ExecSQL();

      If (ACliente.Contatos.Count > nenhum) Then
      Begin
        For contato In ACliente.Contatos Do
        Begin
          contato.Id := FContatoDao.ObterIDContatoCliente(ACliente.Id);
          If Not FContatoDao.Alterar(contato) Then
            raise Exception.Create('Erro ao gravar os contatos');
        End;
      End;

      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N?o foi poss?vel gravar os dados de cliente.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.Consultar(AId: integer): TClienteModel;
var
  query: TZQuery;
  sql: String;
  idContato: integer;
begin
  Result := TClienteModel.Create();

  sql := 'select cl.id, nome, CPF, CNPJ, r.idcontato as idcontato' +
    ' from cliente as cl, relacionamentocontato as r' +
    ' where cl.id = :id and r.idCliente = :id';

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
      Result.Contatos := FContatoDao.ConsultarPorCliente(Result.Id, idContato);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o cliente.');
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.Consultar(AnumeroPessoal: string): TClienteModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;

  sql := 'select id from Cliente where CPF = :CPF';

  query := CreateQuery(sql);
  Try
    query.ParamByName('CPF').AsString := AnumeroPessoal;
    Try
      query.Open();
      if not query.IsEmpty then
        Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o cliente.');
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.ConsultarPorNome(ANome: String): TClienteModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;

  sql := 'select id from Cliente where nome = :nome';

  query := CreateQuery(sql);
  Try
    query.ParamByName('nome').AsString := ANome;
    Try
      query.Open();
      if not query.IsEmpty then
        Result := Consultar(query.FieldByName('id').AsInteger);
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel obter o cliente.');
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.Criar(ACliente: TClienteModel): Boolean;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
  nenhum: integer;
begin
  Result := True;
  nenhum := 0;

  sql := 'Insert Into cliente (id, nome, CPF, CNPJ) Values (:id, :nome, :CPF, :CNPJ)';
  query := CreateQuery(sql);

  Try
    query.ParamByName('id').AsInteger := ACliente.Id;
    query.ParamByName('nome').AsString := ACliente.nome.Trim;
    query.ParamByName('CPF').AsString := ACliente.CPF.Trim;
    query.ParamByName('CNPJ').AsString := ACliente.CNPJ.Trim;
    Try
      query.ExecSQL();

      If (ACliente.Contatos.Count > nenhum) Then
      Begin
        For contato In ACliente.Contatos Do
        Begin
          contato.IdCliente := ACliente.Id;
          contato.IdFornecedor := 0;
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
        Showmessage('N?o foi poss?vel gravar os dados de cliente.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.Excluir(AIdCliente: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from cliente where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdCliente;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N?o foi poss?vel excluir o cliente');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.ListarClientes: TObjectList<TClienteModel>;
var
  query: TZQuery;
  cliente: TClienteModel;
  sql: String;
begin
  Result := TObjectList<TClienteModel>.Create();

  sql := 'select * from cliente order by id asc ';

  query := CreateQuery(sql);
  Try
    Try
      query.Open();
      if query.IsEmpty then
      begin
        Result := nil;
        query.Close;
        query.Free;
        exit();
      end;
      while Not query.Eof do
      Begin
        cliente := TClienteModel.Create();
        cliente.Id := query.FieldByName('id').AsInteger;
        cliente.nome := Trim(query.FieldByName('nome').AsString);
        cliente.CPF := Trim(query.FieldByName('CPF').AsString);
        cliente.CNPJ := Trim(query.FieldByName('CNPJ').AsString);

        Result.Add(cliente);
        query.Next;
      End;
    Except
      on E: Exception do
        Showmessage('N?o foi poss?vel carregar a lista de clientes');
    End;
  Finally
    query.Free;
  End;
end;

function TClienteDao.ListarClientes(ARelatorio: TRelatorioPeriodoModel)
  : TZQuery;
var
  sql: string;
begin

  sql := 'select case when c.cpf = "0" then ' +
    'c.cnpj else c.cpf end as "CPF/CNPJ", Nome, CEP, Rua, Bairro,' +
    ' Cidade, Numero as "N?mero", Complemento, Email as "E-Mail", Telefone' +
    ' from cliente as c, notas as n, contato as ct, email as e, telefone as t,'
    + ' relacionamentocontato as r where c.id = r.idCliente and ct.id = r.idContato'
    + ' and c.id = n.idCliente and e.idContato = ct.id and t.idcontato = ct.id and'
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
      Showmessage('N?o foi poss?vel carregar a lista de clientes');
  end;

end;

function TClienteDao.ListarClientes(ARelatorio: TRelatorioMensalModel): TZQuery;
var
  sql: string;
begin

  sql := 'select case when c.cpf = "0" then ' +
    'c.cnpj else c.cpf end as "CPF/CNPJ", Nome, CEP, Rua, Bairro,' +
    ' Cidade, Numero as "N?mero", Complemento, Email as "E-Mail", Telefone' +
    ' from cliente as c, notas as n, contato as ct, email as e, telefone as t,'
    + ' relacionamentocontato as r where ct.id = r.idContato and c.id = r.idCliente '
    + ' and c.id = n.idCliente and e.idContato = ct.id and t.idcontato = ct.id and'
    + ' n.idUsuario = :id and Year(emissao) = Year(now()) and Month(emissao) = :Mes '
    + ':ordem';

  Result := CreateQuery(sql);
  try
    Result.ParamByName('id').AsInteger := (ARelatorio.IdUsuario);
    Result.ParamByName('Mes').AsString := (intTOstr(ARelatorio.Mes));
    Result.ParamByName('ordem').AsString := (ARelatorio.Ordem);
  except
    on E: Exception do
      Showmessage('N?o foi poss?vel carregar a lista de clientes');
  end;
end;

end.
