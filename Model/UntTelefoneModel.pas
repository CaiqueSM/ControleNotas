unit UntTelefoneModel;

interface

uses
  Classes, SysUtils, System.Generics.Collections;

type

  TTelefoneModel = class
  private
    FId: integer;
    FIdContato: integer;
    FTelefone: string;
    procedure SetTelefone(AValue: string);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;
    property Id: integer read FId write FId;
    property IdContato: integer read FidContato write FidContato;
    property Telefone: string read FTelefone write SetTelefone;
  end;

implementation

{ TTelefone }

constructor TTelefoneModel.Create;
begin
   inherited Create;
end;

destructor TTelefoneModel.Destroy;
begin
  inherited Destroy;
end;

procedure TTelefoneModel.SetTelefone(AValue: string);
begin
  FTelefone := Trim(AValue);
end;

end.
