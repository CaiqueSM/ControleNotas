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

    property Conexao: TConexao read FConexao;
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
end;

end.

