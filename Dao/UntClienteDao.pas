unit UntClienteDao;

interface

uses untbasedao, System.Generics.Collections, UntClienteModel, System.Classes;

type
  TClienteDao = class(TBaseDao)
  public
    function ListarClientes(): TObjectList<TClienteModel>;
    function Consultar(ANome: String): TClienteModel;
    procedure Criar(ACliente: TClienteModel);
    procedure Alterar(ACliente: TClienteModel);
    procedure Excluir(AIdCliente: Integer);
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TClienteDao }

procedure TClienteDao.Alterar(ACliente: TClienteModel);
var
  query: TZQuery;
  sql: String;
begin
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
               Conexao.Database.Rollback;
               Showmessage('Não foi possível gravar os dados.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TClienteDao.Consultar(ANome: String): TClienteModel;
var
  query: TZQuery;
  sql: String;
begin
   Result := TClienteModel.Create();

   sql := 'select * from cliente ' +
          ' where upper(trim(nome)) = upper(trim(:nome)) ' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('nome').AsString := ANome.Trim;
      Try
         query.Open();

         Result.Id := query.FieldByName('id').AsInteger;
         Result.Nome := Trim(query.FieldByName('nome').AsString);
         Result.CPF := Trim(query.FieldByName('CPF').AsString);
         Result.CNPJ:= Trim(query.FieldByName('CNPJ').AsString);

      Except
         on E: Exception do
            Showmessage('Não foi possível obter o cliente.');
      End;
   Finally
      query.Free;
   End;
end;

procedure TClienteDao.Criar(ACliente: TClienteModel);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'Insert Into cliente (id, nome, CPF, CNPJ) Values (:id, :nome, :CPF, :CNPJ)';
   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger:= ACliente.Id;
      query.ParamByName('nome').AsString := ACliente.Nome.Trim;
      query.ParamByName('CPF').AsString := ACliente.CPF.Trim;
      query.ParamByName('CNPJ').AsString := ACliente.CPF.Trim;

      Try
         query.ExecSQL();
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Conexao.Database.Rollback;
               Showmessage('Não foi possível gravar os dados.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

procedure TClienteDao.Excluir(AIdCliente: Integer);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'delete from cliente ' +
          ' where id = :id' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := AIdCliente;
      Try
         query.ExecSQL();
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
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
