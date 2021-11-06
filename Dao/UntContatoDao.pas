unit UntContatoDao;

interface

uses

  untBaseDao, System.Generics.Collections, UntContatoModel, System.Classes,
  UntEnumContatoDao;

type

  TContatoDao = class(TBaseDao)
  public
    function ListarContatos(): TObjectList<TContatoModel>;
    function Consultar(ACodigo: integer; Enum: TEnumContatoDao): TContatoModel;
    procedure Criar(AContato: TContatoModel);
    procedure Alterar(AContato: TContatoModel);
    procedure Excluir(ACodigo: Integer; Enum: TEnumContatoDao);
  end;



implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TContatoDao }

procedure TContatoDao.Alterar(AContato: TContatoModel);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'Update contato Set bairro = :bairro, CEP = :CEP'+
          'complemento = :complemento, numero = :numero, rua = :rua'+
          ' Where id = :id';

   query := CreateQuery(sql);
   Try
      query.ParamByName('bairro').AsString := AContato.Bairro;
      query.ParamByName('CEP').AsString := AContato.CEP;
      query.ParamByName('complemento').AsString := AContato.Complemento;
      query.ParamByName('numero').AsString := AContato.Numero;
      query.ParamByName('rua').AsString := AContato.Rua;

      Try
         query.ExecSQL();
         Conexao.Database.Commit;
      Except
         on E: Exception do
            Begin
               Conexao.Database.Rollback;
               Showmessage('Não foi possível atualizar os dados.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TContatoDao.Consultar(ACodigo: integer; Enum: TEnumContatoDao): TContatoModel;
var
  query: TZQuery;
  sql: String;
begin
   Result := TContatoModel.Create();

   case Enum of
        actContato:
        begin
          sql := 'select * from contato ' +
          'where id = :codigo' ;
        end;
        actCliente:
        begin
          sql := 'select * from contato ' +
          'where idCliente = :codigo' ;
        end;
        actFornecedor:
        begin
          sql := 'select * from contato ' +
          'where idCliente = :codigo' ;
        end;
   end;

   query := CreateQuery(sql);
   Try
      query.ParamByName('codigo').AsInteger := ACodigo;
      Try
         query.Open();

         Result.Id := query.FieldByName('id').AsInteger;
         Result.CEP := Trim(query.FieldByName('CEP').AsString);
         Result.Complemento := Trim(query.FieldByName('complemento').AsString);
         Result.Numero:= Trim(query.FieldByName('numero').AsString);
         Result.Rua:= Trim(query.FieldByName('rua').AsString);

      Except
         on E: Exception do
            Showmessage('Não foi possível obter o contato.');
      End;
   Finally
      query.Free;
   End;
end;

procedure TContatoDao.Criar(AContato: TContatoModel);
var
  query: TZQuery;
  sql: String;
begin
   sql := 'Insert Into (id, idcliente, idforneceedor, bairro, CEP'+
          'complemento, numero, rua)'+
          'Values (:id, :idcliente, :idforneceedor, :bairro, :CEP'+
          ':complemento, :numero, :rua)';

   query := CreateQuery(sql);
   Try
      query.ParamByName('id').AsInteger := AContato.Id;
      query.ParamByName('idcliente').AsInteger := AContato.IdCliente;
      query.ParamByName('idfornecedor').AsInteger := AContato.IdFornecedor;
      query.ParamByName('bairro').AsString := AContato.Bairro;
      query.ParamByName('CEP').AsString := AContato.CEP;
      query.ParamByName('complemento').AsString := AContato.Complemento;
      query.ParamByName('numero').AsString := AContato.Numero;
      query.ParamByName('rua').AsString := AContato.Rua;

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

procedure TContatoDao.Excluir(ACodigo: Integer; Enum: TEnumContatoDao);
begin

end;

function TContatoDao.ListarContatos: TObjectList<TContatoModel>;
begin

end;

end.
