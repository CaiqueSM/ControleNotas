unit UntConexao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, sqldb;

type

  { TConexao }

  TConexao = class
  private
    FConnection: TMySQL57Connection;
    FTransaction: TSQLTransaction;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Connection: TMySQL57Connection read FConnection;
    property Transaction: TSQLTransaction read FTransaction;
  end;

implementation

{ TConexao }

constructor TConexao.Create();
begin

end;

destructor TConexao.Destroy();
begin
  FConnection.Free;
  FTransaction.Free;
  inherited Destroy();
end;

end.

