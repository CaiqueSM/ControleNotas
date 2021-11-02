unit UntCadastrarUsuarioDao;

interface

uses untbasedao, System.Generics.Collections, UntUsuarioModel, System.Classes;

type
  TCadastrarUsuarioDao = class(TBaseDao)
  public
    function ListarUsuarios(): TObjectList<TUsuarioModel>;
    function Consultar(ANome: String): TUsuarioModel;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;

{ TCadastrarUsuarioDao }

function TCadastrarUsuarioDao.Consultar(ANome: String): TUsuarioModel;
var
  query: TZQuery;
  sql: String;
begin
   Result := TUsuarioModel.Create();

   sql := 'select * from usuario ' +
          ' where upper((nome)) = upper(trim(:nome)) ' ;

   query := CreateQuery(sql);
   Try
      query.ParamByName('nome').AsString := ANome;
      Try
         query.Open();

         Result.Id := query.FieldByName('id').AsInteger;
         Result.Nome := Trim(query.FieldByName('nome').AsString);
      Except
         on E: Exception do
            Showmessage('N�o foi poss�vel carregar o usu�rio');
      End;
   Finally
      query.Free;
   End;
end;

function TCadastrarUsuarioDao.ListarUsuarios(): TObjectList<TUsuarioModel>;
var
  query: TZQuery;
  usuario: TUsuarioModel;
  sql: String;
begin
   Result := TObjectList<TUsuarioModel>.Create();

   sql := 'select * from usuario ' +
          ' order by id asc ' ;

   query := CreateQuery(sql);
   Try
      Try
         query.Open();
         while Not query.Eof do
            Begin
               usuario := TUsuarioModel.Create();
               usuario.Id := query.FieldByName('id').AsInteger;
               usuario.Nome := Trim(query.FieldByName('nome').AsString);

               Result.Add(usuario);
               query.Next;
            End;
      Except
         on E: Exception do
            Showmessage('N�o foi poss�vel carregar a lista de usu�rios');
      End;
   Finally
      query.Free;
   End;
end;

end.
