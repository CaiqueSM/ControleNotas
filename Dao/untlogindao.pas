unit UntLoginDao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UntBaseDao, UntUsuarioModel, sqldb, Dialogs,
  ZDataset;

type

  { TLoginDao }

  TLoginDao = class(TBaseDao)
  public
    function GetUsuario(AUsuario, ASenha: string): TUsuarioModel;
  end;

implementation

{ TLoginDao }

function TLoginDao.GetUsuario(AUsuario, ASenha: string): TUsuarioModel;
var
  query: TZQuery;
  sql: string;
begin
  sql := 'select * from usuario where nome = :usuario and senha = :senha';

  query := CreateQuery(sql);
  try
    query.ParamByName('usuario').AsString := AUsuario;
    query.ParamByName('senha').AsString := ASenha;

    Result := TUsuarioModel.Create();
    try
      query.Open;

      Result.Id := query.FieldByName('id').AsInteger;
      Result.Nome := query.FieldByName('nome').AsString;
      Result.Senha := query.FieldByName('senha').AsString;
    except
      on e: Exception do
        ShowMessage(Format('Erro ao pegar usuário!' + #13#10 + #13#10 +
          'Mensagem: %s', [e.Message]));
    end;
  finally
    query.Free;
  end;
end;

end.





