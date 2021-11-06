unit UntEmailModel;

interface

uses
  Classes, SysUtils;

type

  TEmailModel = class
  private
    FId: integer;
    FidContato: integer;
    FEmail: string;
    procedure SetEmail(AValue: string);
  public
    property Id: integer read FId write FId;
    property IdContato: integer read FidContato write FidContato;
    property Email: string read FEmail write SetEmail;
  end;

implementation

{ TEmail }

procedure TEmailModel.SetEmail(AValue: string);
begin
  FEmail := Trim(AValue);
end;

end.
