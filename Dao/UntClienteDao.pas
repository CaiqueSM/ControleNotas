unit UntClienteDao;

interface

uses untbasedao, System.Generics.Collections, UntClienteModel, UntRelacionamentoContatoModel,
System.Classes, UntContatoDao, UntRelacionamentoContatoDao,UntConexao;

type
  TClienteDao = class(TBaseDao)
  private
    FContatoDao: TContatoDao;
    FRelacionamentoDao: TRelacionamentoContatoDao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    destructor Destroy(); override;

    function ListarClientes(): TObjectList<TClienteModel>;
    function Consultar(AId: integer): TClienteModel;overload;
    function Consultar(AnumeroPessoal: String): TClienteModel;overload;
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
  FRelacionamentoDao := TRelacionamentoContatoDao.Create(AConexao);
end;

destructor TClienteDao.Destroy;
begin
  FRelacionamentoDao.Free;
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
               Showmessage('Não foi possível gravar os dados de cliente.');
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

   sql := 'select cl.id, nome, CPF, CNPJ, r.idcontato as idcontato'
        + ' from cliente as cl, relacionamentocontato as r' +
          ' where cl.id = :id and r.idrelacionado = :id' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := AId;
      Try
         query.Open();

         Result.Id := query.FieldByName('id').AsInteger;
         Result.Nome := Trim(query.FieldByName('nome').AsString);
         Result.CPF := Trim(query.FieldByName('CPF').AsString);
         Result.CNPJ:= Trim(query.FieldByName('CNPJ').AsString);
         idcontato:= query.FieldByName('idcontato').AsInteger;
         Result.Contatos := FContatoDao.ConsultarPorCliente(Result.Id, idcontato);
      Except
         on E: Exception do
            Showmessage('Não foi possível obter o cliente.');
      End;
   Finally
      query.Free;
   End;
end;

function TClienteDao.Consultar(ANumeroPessoal: string): TClienteModel;
var
  query: TZQuery;
  sql: String;
begin
   Result:= nil;
   sql := 'select id from Cliente where CPF = :CPF';

   query := CreateQuery(sql);
   Try
      query.ParamByName('CPF').AsString := ANumeroPessoal;
      Try
         query.Open();
         Result:= Consultar(query.FieldByName('id').AsInteger);
      Except
         on E: Exception do
            Showmessage('Não foi possível obter o cliente.');
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
  relacionamento: TRelacionamentoContatoModel;
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
                     If Not FContatoDao.Criar(contato) Then
                        raise Exception.Create('Erro ao gravar os contatos');
                     Relacionamento := TRelacionamentoContatoModel.Create;
                     Relacionamento.idContato:= contato.Id;
                     Relacionamento.idRelacionado:= ACliente.id;
                     FRelacionamentoDao.Criar(Relacionamento);
                     Relacionamento.Free;
                  End;
            End;
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Result := False;
               Conexao.Database.Rollback;
               Showmessage('Não foi possível gravar os dados de cliente.');
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
               Showmessage('Não foi possível excluir o cliente');
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
            Showmessage('Não foi possível carregar a lista de clientes');
      End;
   Finally
      query.Free;
   End;
end;

end.
