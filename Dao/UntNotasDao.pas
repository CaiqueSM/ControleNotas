unit UntNotasDao;

interface

uses

  untBaseDao, UntUsuarioController, UntClienteController,
  UntFornecedorController, ZDataset, UntRelatorioPeriodoModel,
  UntRelatorioMensalModel, System.Generics.Collections, UntNotasModel,
  System.Classes, UntConexao, UntEnvironment, Data.DB;

type

  TNotasDao = class(TBaseDao)
  private
    FUsuarioDao: TUsuarioController;
    FClienteDao: TClienteController;
    FFornecedorDao: TFornecedorController;
  public
    constructor Create(AConexao: TConexao);
    destructor Destroy; override;
    function Consultar(AIdNotas: integer): TNotasModel; overload;
    function Consultar(AChaveAcesso: string): TNotasModel; overload;
    function Criar(ANotas: TNotasModel): Boolean;
    function Alterar(ANotas: TNotasModel): Boolean;
    function Excluir(AIdNotas: integer): Boolean; overload;
    function Excluir(AChaveAcesso: string): Boolean; overload;
    function ListarNotas(): TObjectList<TNotasModel>; overload;
    function ListarNotas(ARelatorio: TRelatorioPeriodoModel): TZQuery; overload;
    function ListarNotas(ARelatorio: TRelatorioMensalModel): TZQuery; overload;
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TNotasDao }

function TNotasDao.Alterar(ANotas: TNotasModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Update Notas' +
    ' Set idCliente = :idCliente, idFornecedor = :idFornecedor,' +
    ' chaveacesso = :chaveacesso, controle = :controle,' +
    ' descricao = :descricao, valor = :valor, emissao = :emissao' +
    ' where id = :id and idUsuario = :idUsuario';
  query := CreateQuery(sql);

  Try
    query.ParamByName('id').AsInteger := ANotas.Id;
    query.ParamByName('idCliente').AsInteger := ANotas.Cliente.Id;
    query.ParamByName('idUsuario').AsInteger := Global.idUsuario;
    query.ParamByName('idFornecedor').AsInteger := ANotas.Fornecedor.Id;
    query.ParamByName('chaveacesso').AsString := ANotas.Chave;
    query.ParamByName('controle').AsInteger := ANotas.Controle;
    query.ParamByName('descricao').AsString := ANotas.Descricao;
    query.ParamByName('valor').AsFloat := ANotas.valor;
    query.ParamByName('emissao').AsDate := ANotas.emissao;

    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados de Notas.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TNotasDao.Consultar(AIdNotas: integer): TNotasModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;
  sql := 'select * from Notas where id = :id and idUsuario = :idUsuario';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdNotas;
    query.ParamByName('idUsuario').AsInteger := Global.idUsuario;
    query.Open();
    if query.IsEmpty then
    begin
      query.Free;
      exit();
    end;
    Try
      Result := TNotasModel.Create;
      with Result do
      begin
        Id := query.FieldByName('id').AsInteger;
        Chave := query.FieldByName('chaveacesso').AsString;
        Controle := query.FieldByName('controle').AsInteger;
        Descricao := query.FieldByName('descricao').AsString;
        valor := query.FieldByName('valor').AsInteger;
        emissao := query.FieldByName('emissao').AsDateTime;
        Cliente := FClienteDao.Consultar(query.FieldByName('idcliente')
          .AsInteger);
        Fornecedor := FFornecedorDao.Consultar(query.FieldByName('idfornecedor')
          .AsInteger);
        Usuario := FUsuarioDao.Consultar(query.FieldByName('idusuario')
          .AsInteger);
      end;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter as Notas.');
    End;
  Finally
    query.Free;
  End;
end;

function TNotasDao.Consultar(AChaveAcesso: string): TNotasModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := nil;
  sql := 'select * from Notas where chaveacesso = :chaveacesso and idUsuario = :idUsuario';
  query := CreateQuery(sql);
  Try
    query.ParamByName('chaveacesso').AsString := AChaveAcesso;
    query.ParamByName('idUsuario').AsInteger := Global.IdUsuario;
    query.Open();
    if query.IsEmpty then
    begin
      query.Free;
      exit();
    end;
    Try
      Result := TNotasModel.Create;
      with Result do
      begin
        Id := query.FieldByName('id').AsInteger;
        Chave := query.FieldByName('chaveacesso').AsString;
        Controle := query.FieldByName('controle').AsInteger;
        Descricao := query.FieldByName('descricao').AsString;
        valor := query.FieldByName('valor').AsInteger;
        emissao := query.FieldByName('emissao').AsDateTime;
        Cliente := FClienteDao.Consultar(query.FieldByName('idcliente')
          .AsInteger);
        Fornecedor := FFornecedorDao.Consultar(query.FieldByName('idfornecedor')
          .AsInteger);
        Usuario := FUsuarioDao.Consultar(query.FieldByName('idusuario')
          .AsInteger);
      end;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter as Notas.');
    End;
  Finally
    query.Free;
  End;
end;

constructor TNotasDao.Create(AConexao: TConexao);
begin
  inherited Create(AConexao);
  FUsuarioDao := TUsuarioController.Create();
  FClienteDao := TClienteController.Create();
  FFornecedorDao := TFornecedorController.Create();
end;

function TNotasDao.Criar(ANotas: TNotasModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Insert Into' +
    ' Notas(id, idUsuario, idCliente, idFornecedor, chaveacesso, controle, descricao, valor, emissao)'
    + ' values(:id, :idUsuario, :idCliente, :idFornecedor, :chaveacesso, :controle, :descricao, :valor, :emissao)';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := ANotas.Id;
    query.ParamByName('idUsuario').AsInteger := ANotas.Usuario.Id;
    query.ParamByName('idCliente').AsInteger := ANotas.Cliente.Id;
    query.ParamByName('idFornecedor').AsInteger := ANotas.Fornecedor.Id;
    query.ParamByName('chaveacesso').AsString := ANotas.Chave;
    query.ParamByName('controle').AsInteger := ANotas.Controle;
    query.ParamByName('descricao').AsString := ANotas.Descricao;
    query.ParamByName('valor').AsFloat := ANotas.valor;
    query.ParamByName('emissao').AsDate := ANotas.emissao;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Showmessage('Não foi possível gravar os dados de Notas.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

destructor TNotasDao.Destroy;
begin
  FUsuarioDao.Free;
  FClienteDao.Free;
  FFornecedorDao.Free;
end;

function TNotasDao.ListarNotas(ARelatorio: TRelatorioPeriodoModel): TZQuery;
var
  sql: string;
begin

  sql := 'select case when c.cpf = "0" then ' +
		'c.cnpj else c.cpf end as "CPF/CNPJ Cliente",' +
    'case when f.cnpj = "0" then f.cpf else f.cnpj end' +
    ' as "CPF/CNPJ Fornecedor", chaveacesso as "Chave acesso",'+
    'controle as "Controle", descricao as "Descrição", emissao as "Emissão",' +
    'valor as "Valor(R$)" ' +
    'from notas as n, fornecedor as f, cliente as c ' +
    'where n.idUsuario = :id and n.idCliente = c.id and n.idFornecedor = f.id ' +
    'and emissao between :DataInicio and :DataTermino :ordem';

  Result := CreateQuery(sql);

  try
    Result.ParamByName('id').AsInteger := (ARelatorio.IdUsuario);
    Result.ParamByName('DataInicio').AsDate := (ARelatorio.DataInicio);
    Result.ParamByName('DataTermino').AsDate := (ARelatorio.DataTermino);
    Result.ParamByName('ordem').AsString := (ARelatorio.Ordem);
  except
    on E: Exception do
      Showmessage('Não foi possível carregar a lista de notas');
  end;

end;

function TNotasDao.ListarNotas(ARelatorio: TRelatorioMensalModel): TZQuery;
var
  sql: string;
begin

  sql := 'select case when c.cpf = "0" then ' +
		'c.cnpj else c.cpf end as "CPF/CNPJ Cliente",' +
    'case when f.cnpj = "0" then f.cpf else f.cnpj end' +
    ' as "CPF/CNPJ Fornecedor", chaveacesso as "Chave acesso",'+
    'controle as "Controle", descricao as "Descrição", emissao as "Emissão",' +
    'valor as "Valor(R$)" ' +
    'from notas as n, fornecedor as f, cliente as c ' +
    'where n.idUsuario = :id and n.idCliente = c.id and n.idFornecedor = f.id ' +
    'and month(emissao) = :Mes :ordem';

  Result := CreateQuery(sql);

  try
    Result.ParamByName('id').AsInteger := (ARelatorio.IdUsuario);
    Result.ParamByName('Mes').AsString := (intTOstr(ARelatorio.Mes));
    Result.ParamByName('ordem').AsString := (ARelatorio.Ordem);
  except
    on E: Exception do
      Showmessage('Não foi possível carregar a lista de notas');
  end;

end;

function TNotasDao.ListarNotas: TObjectList<TNotasModel>;
var
  query: TZQuery;
  sql: String;
  Nota: TNotasModel;
begin
  Result := TObjectList<TNotasModel>.Create;

  sql := 'select * from notas where idUsuario = :idUsuario order by id asc';
  query := CreateQuery(sql);
  query.ParamByName('idUsuario').AsInteger := Global.IdUsuario;
  Try
    Try
      query.Open();
      if Query.IsEmpty then
      begin
        Result := nil;
        query.Close;
        query.Free;
        exit();
      end;
      while not query.Eof do
      begin
        with Nota do
        begin
          Nota := TNotasModel.Create;
          Id := query.FieldByName('id').AsInteger;
          Chave := query.FieldByName('chaveacesso').AsString;
          Controle := query.FieldByName('controle').AsInteger;
          Descricao := query.FieldByName('descricao').AsString;
          valor := query.FieldByName('valor').AsInteger;
          emissao := query.FieldByName('emissao').AsDateTime;
          Cliente := FClienteDao.Consultar(query.FieldByName('idcliente')
            .AsInteger);
          Fornecedor := FFornecedorDao.Consultar
            (query.FieldByName('idfornecedor').AsInteger);
          Usuario := FUsuarioDao.Consultar(query.FieldByName('idusuario')
            .AsInteger);
        end;
        Result.Add(Nota);
        query.Next;
      end;
    Except
      on E: Exception do
        Showmessage('Não foi possível obter as Notas.');
    End;
  Finally
    query.Free;
  End;
end;

function TNotasDao.Excluir(AIdNotas: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from Notas where id = :id and idUsuario = :idUsuario';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdNotas;
    query.ParamByName('idUsuario').AsInteger := Global.IdUsuario;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível excluir o Notas');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TNotasDao.Excluir(AChaveAcesso: string): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from Notas where chaveacesso = :chave and idUsuario = :idUsuario';

  query := CreateQuery(sql);
  Try
    query.ParamByName('chave').AsString := AChaveAcesso;
    query.ParamByName('idUsuario').AsInteger := Global.IdUsuario;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível excluir o Notas');
      End;
    End;
  Finally
    query.Free;
  End;
end;


end.
