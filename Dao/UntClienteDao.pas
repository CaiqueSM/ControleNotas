unit UntClienteDao;

interface

uses untbasedao, System.Generics.Collections, UntClienteModel, System.Classes,
  UntContatoDao, UntConexao;

type
  TClienteDao = class(TBaseDao)
  private
    FContatoDao: TContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;

    function ListarClientes(): TObjectList<TClienteModel>;
    function Consultar(AId: String): TClienteModel;
    function Criar(ACliente: TClienteModel): Boolean;
    function Alterar(ACliente: TClienteModel): Boolean;
    function Excluir(AIdCliente: Integer): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs, UntContatoModel,
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
begin
   Result := True;

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
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Result := False;
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel gravar os dados de cliente.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TClienteDao.Consultar(AId: String): TClienteModel;
var
  query: TZQuery;
  sql: String;
begin
   Result := TClienteModel.Create();

   sql := 'select * from cliente ' +
          ' where id = :id ' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsString := AId;
      Try
         query.Open();

         Result.Id := query.FieldByName('id').AsInteger;
         Result.Nome := Trim(query.FieldByName('nome').AsString);
         Result.CPF := Trim(query.FieldByName('CPF').AsString);
         Result.CNPJ:= Trim(query.FieldByName('CNPJ').AsString);

         Result.Contatos := FContatoDao.ConsultarPorCliente(Result.Id);
      Except
         on E: Exception do
            Showmessage('N�o foi poss�vel obter o cliente.');
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
  nenhum: Integer;
begin
   Result := True;
   nenhum := 0;

   sql := 'Insert Into cliente (id, nome, CPF, CNPJ) Values (:id, :nome, :CPF, :CNPJ)';
   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger:= ACliente.Id;
      query.ParamByName('nome').AsString := ACliente.Nome.Trim;
      query.ParamByName('CPF').AsString := ACliente.CPF.Trim;
      query.ParamByName('CNPJ').AsString := ACliente.CNPJ.Trim;
      Try
         query.ExecSQL();

         If (ACliente.Contatos.Count > nenhum) Then
            Begin
               For contato In ACliente.Contatos Do
                  Begin
                     contato.IdCliente := ACliente.Id;
                     contato.IdFornecedor:= 0;
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
               Showmessage('N�o foi poss�vel gravar os dados de cliente.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TClienteDao.Excluir(AIdCliente: Integer): Boolean;
var
  query: TZQuery;
  sql: String;
begin
   Result := True;

   sql := 'delete from cliente ' +
          ' where id = :id' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := AIdCliente;
      Try
         query.ExecSQL();

         If Not FContatoDao.ExcluirPorCliente(AIdCliente) Then
            raise Exception.Create('Erro ao excluir os contatos');

         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Result := False;
               Conexao.Database.Rollback;
               Showmessage('N�o foi poss�vel excluir o cliente');
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

   sql := 'select * from cliente ' +
          ' order by id asc ' ;

   query := CreateQuery(sql);
   Try
      Try
         query.Open();
         while Not query.Eof do
            Begin
               cliente := TClienteModel.Create();
               cliente.Id := query.FieldByName('id').AsInteger;
               cliente.Nome := Trim(query.FieldByName('nome').AsString);
               cliente.CPF := Trim(query.FieldByName('CPF').AsString);
               cliente.CNPJ := Trim(query.FieldByName('CNPJ').AsString);

               Result.Add(cliente);
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('N�o foi poss�vel carregar a lista de clientes');
      End;
   Finally
      query.Free;
   End;
end;

end.
