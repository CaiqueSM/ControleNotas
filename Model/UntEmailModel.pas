unit UntEmailModel;

interface

uses
  Classes, SysUtils;

type

  TEmailModel = class
  private
    FId: integer;
    FEmail: string;
    procedure SetEmail(AValue: string);
  public
    property Id: integer read FId write FId;
    property Email: string read FEmail write SetEmail;
  end;

implementation

{ TEmail }

procedure TEmailModel.SetEmail(AValue: string);
begin
  FEmail := Trim(AValue);
end;

end.
