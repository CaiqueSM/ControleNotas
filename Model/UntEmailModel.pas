unit UntEmailModel;

interface

uses
  Classes, SysUtils;

type

  TEmail = class
  private
    FId: integer;
    FEnderecoEmail: string;
    procedure SetEmail(AValue: string);
  public
    property Id: integer read FId write FId;
    property Email: string read FEnderecoEmail write SetEmail;
  end;

implementation

{ TEmail }

procedure TEmail.SetEmail(AValue: string);
begin
  FEnderecoEmail := Trim(AValue);
end;

end.
