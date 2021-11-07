unit UntEmailModel;

interface

uses
  Classes, SysUtils, System.Generics.Collections;

type

  TEmailModel = class
  private
    FId: integer;
    FidContato: integer;
    FEmail: string;
    procedure SetEmail(AValue: string);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
    property Id: integer read FId write FId;
    property IdContato: integer read FidContato write FidContato;
    property Email: string read FEmail write SetEmail;
  end;

implementation

{ TEmail }

constructor TEmailModel.Create;
begin
  inherited Create;
end;

destructor TEmailModel.Destroy;
begin
  inherited Destroy;
end;

procedure TEmailModel.SetEmail(AValue: string);
begin
  FEmail := Trim(AValue);
end;

end.
