unit UntNotasDao;

interface

uses

  untBaseDao, UntUsuarioController, UntClienteController,
  UntFornecedorController,
  System.Generics.Collections, UntNotasModel, System.Classes,
  UntConexao;

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
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TNotasDao }

function TNotasDao.Alterar(ANotas: TNotasModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Update Notas' +
    ' Set idCliente = :idCliente, idFornecedor = :idFornecedor,'+
    ' chaveacesso = :chaveacesso, controle = :controle,'+
    ' descricao = :descricao, valor = :valor, emissao = :emissao)'+
    ' where id = :id';
  query := CreateQuery(sql);

  Try
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

  sql := 'select * from Notas where id = :id ';
  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdNotas;
    Try
      query.Open();
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
  sql := 'select id from Notas where chaveacesso = :chave ';
  query := CreateQuery(sql);
  Try
    query.ParamByName('chave').AsString := AChaveAcesso;
    Try
      query.Open();
      Result := Consultar(query.FieldByName('id').AsInteger);
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
    with query do
    begin
      ParamByName('id').AsInteger := ANotas.Id;
      ParamByName('idUsuario').AsInteger := ANotas.Usuario.Id;
      ParamByName('idCliente').AsInteger := ANotas.Cliente.Id;
      ParamByName('idFornecedor').AsInteger := ANotas.Fornecedor.Id;
      ParamByName('chaveacesso').AsString := ANotas.Chave;
      ParamByName('controle').AsInteger := ANotas.Controle;
      ParamByName('descricao').AsString := ANotas.Descricao;
      ParamByName('valor').AsFloat := ANotas.valor;
      ParamByName('emissao').AsDate := ANotas.emissao;
    end;
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

function TNotasDao.Excluir(AChaveAcesso: string): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from Notas where chaveacesso = :chave';

  query := CreateQuery(sql);
  Try
    query.ParamByName('chave').AsString := AChaveAcesso;
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

function TNotasDao.Excluir(AIdNotas: integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'delete from Notas where id = :id';

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := AIdNotas;
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
