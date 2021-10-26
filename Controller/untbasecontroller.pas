unit UntBaseController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UntConexao;

type

  { TBaseController }

  TBaseController = class
  private
    FConexao: TConexao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Conexao: FConexao read FConexao;
  end;

implementation

{ TBaseController }

constructor TBaseController.Create();
begin
  FConexao := TConexao.Create();
end;

destructor TBaseController.Destroy();
begin
  FConexao.Free;
  inherited Destroy();
end;

end.

