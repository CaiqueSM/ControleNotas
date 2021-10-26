unit UntBaseDao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UntConexao, sqldb, ZDataset;

type

  { TBaseDao }

  TBaseDao = class
  private
    FConexao: TConexao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    function CreateQuery(ASQL: string): TZQuery;
  end;

implementation

{ TBaseDao }

constructor TBaseDao.Create(AConexao: TConexao);
begin
  FConexao := AConexao;
end;

function TBaseDao.CreateQuery(ASQL: string): TZQuery;
begin
  Result := TZQuery.Create(nil);
  Result.Connection := FConexao.Database;
  Result.SQL.Text := ASQL.Trim;
end;

end.

