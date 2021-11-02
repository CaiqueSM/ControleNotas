unit UntCadastrarUsuarioDao;

interface

uses untbasedao, System.Generics.Collections, UntUsuarioModel, System.Classes;

type
  TCadastrarUsuarioDao = class(TBaseDao)
  public
    function ListarNomesUsuarios(): TStringList;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TCadastrarUsuarioDao }

function TCadastrarUsuarioDao.ListarNomesUsuarios(): TStringList;
var
  query: TZQuery;
  sql: String;
begin
   Result := TStringList.Create();

   sql := 'select nome from usuario ' +
          ' order by nome asc ' ;

   query := CreateQuery(sql);
   Try
      Try
         query.Open();
         while Not query.Eof do
            Begin
               Result.Add(Trim(query.FieldByName('nome').AsString));
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('Não foi possível carregar a lista de usuários');
      End;
   Finally
      query.Free;
   End;
end;

end.
