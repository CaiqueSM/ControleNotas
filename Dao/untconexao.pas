unit UntConexao;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, sqldb;

type

  { TConexao }

  TConexao = class
  private
    FDatabase: TMySQL57Connection;
    FTransaction: TSQLTransaction;

    function CreateDatabase(): TMySQL57Connection;
    function CreateTransaction(ADatabase: TMySQL57Connection): TSQLTransaction;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Database: TMySQL57Connection read FDatabase;
    property Transaction: TSQLTransaction read FTransaction;
  end;

implementation

{ TConexao }

function TConexao.CreateDatabase(): TMySQL57Connection;
begin
  Result := TMySQL57Connection.Create(nil);

  Result.HostName := 'localhost';
  Result.UserName := 'root';
  Result.Password := '';
  Result.DatabaseName := 'nota_fiscal';

  Result.CharSet := 'WIN1252';
  Result.LoginPrompt := False;
end;

function TConexao.CreateTransaction(ADatabase: TMySQL57Connection): TSQLTransaction;
begin
  Result := TSQLTransaction.Create(nil);

  Result.Params.Add('read_committed');
  Result.Params.Add('rec_version');
  Result.Params.Add('wait');

  Result.DataBase := ADatabase;
end;

constructor TConexao.Create();
begin
  FDatabase := CreateDatabase();
  FTransaction := CreateTransaction(FDatabase);

  FDatabase.Transaction := FTransaction;
end;

destructor TConexao.Destroy();
begin
  FDatabase.Free;
  FTransaction.Free;
  inherited Destroy();
end;

end.


