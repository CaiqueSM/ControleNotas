unit UntBaseDao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UntConexao;

type

  { TBaseDao }

  TBaseDao = class
  private
    FConexao: TConexao;
  public
    constructor Create(AConexao: TConexao); reintroduce;
    property Conexao: TConexao read FConexao;
  end;

implementation

{ TBaseDao }

constructor TBaseDao.Create(AConexao: TConexao);
begin
  FConexao := AConexao;
end;

end.

