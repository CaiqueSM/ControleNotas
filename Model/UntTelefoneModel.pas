unit UntTelefoneModel;

interface

uses
  Classes, SysUtils;

type

  TTelefone = class
  private
    FId: integer;
    FNumeroTelefone: string;
    procedure SetTelefone(AValue: string);
  public
    property Id: integer read FId write FId;
    property Telefone: string read FNumeroTelefone write SetTelefone;
  end;

implementation

{ TTelefone }

procedure TTelefone.SetTelefone(AValue: string);
begin
  FNumeroTelefone := Trim(AValue);
end;

end.
