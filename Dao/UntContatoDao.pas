unit UntContatoDao;

interface

uses

  untbasedao, System.Generics.Collections, UntContatoModel, System.Classes;

type

  TContatoDao = class(TBaseDao)
  public
    function ListarContatos(): TObjectList<TContatoModel>;
    function Consultar(ACodigo: integer): TContatoModel;
    procedure Criar(ACliente: TContatoModel);
    procedure Alterar(AContato: TContatoModel);
    procedure Excluir(AId: Integer);
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
               Showmessage('Não foi possível gravar os dados.');
            End;
      End;
   Finally
      query.Free;
   End;
end;

function TContatoDao.Consultar(ACodigo: integer): TContatoModel;
begin

end;

procedure TContatoDao.Criar(ACliente: TContatoModel);
begin

end;

procedure TContatoDao.Excluir(AId: Integer);
begin

end;

function TContatoDao.ListarContatos: TObjectList<TContatoModel>;
begin

end;

end.
