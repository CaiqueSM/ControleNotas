unit UntTelefoneModel;

interface

uses
  Classes, SysUtils;

type

  TTelefoneModel = class
  private
    FId: integer;
    FTelefone: string;
    procedure SetTelefone(AValue: string);
  public
    property Id: integer read FId write FId;
    property Telefone: string read FTelefone write SetTelefone;
  end;

implementation

{ TTelefone }

procedure TTelefoneModel.SetTelefone(AValue: string);
begin
  FTelefone := Trim(AValue);
end;

end.