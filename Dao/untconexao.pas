unit UntConexao;

interface

uses
  Classes, SysUtils, ZAbstractConnection, ZConnection;

type

  { TConexao }

  TConexao = class
  private
    FDatabase: TZConnection;
    function CreateDatabase(): TZConnection;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Database: TZConnection read FDatabase;
  end;

implementation

{ TConexao }

function TConexao.CreateDatabase(): TZConnection;
begin
  Result := TZConnection.Create(nil);

  Result.HostName := 'localhost';
  Result.User := 'root';
  Result.Password := 'root';
  Result.Database := 'notafiscal';

  Result.Protocol := 'mysql';
  Result.LoginPrompt := False;
  Result.AutoCommit := False;
  Result.SQLHourGlass := True;
end;

constructor TConexao.Create();
begin
  FDatabase := CreateDatabase();
end;

destructor TConexao.Destroy();
begin
  FDatabase.Free;
  inherited Destroy();
end;

end.
