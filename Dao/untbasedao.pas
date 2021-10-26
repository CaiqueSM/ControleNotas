unit UntBaseDao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UntConexao, sqldb;

type

  { TBaseDao }

  TBaseDao = class
  private
    FConexao: TConexao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    function CreateQuery(ASQL: string): TSQLQuery;
  end;

implementation

{ TBaseDao }

constructor TBaseDao.Create(AConexao: TConexao);
begin
  FConexao := AConexao;
end;

function TBaseDao.CreateQuery(ASQL: string): TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  Result.DataBase := FConexao.Database;
  Result.SQL.Text := ASQL.Trim;
end;

end.

