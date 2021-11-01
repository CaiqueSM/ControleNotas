unit UntContatoModel;

interface

uses
  Classes, SysUtils, UntTelefoneModel, UntEmailModel;

type

  TContatoModel = class
  public
    FId: integer;
    FCEP: string;
    FNomeRua: string;
    FBairro: string;
    FNumero: string;
    FComplemento: string;
    FEmail: TEmailModel;
    FTelefone: TTelefoneModel;
    procedure SetCEP(AValue: string);
    procedure SetRua(AValue: string);
    procedure SetBairro(AValue: string);
    procedure SetNumero(AValue: string);
    procedure SetComplemento(AValue: string);
  public
    property Id: integer read FId write FId;
    property CEP: string read FCEP write FCEP;
    property Rua: string read FNomeRua write FNomeRua;
    property Bairro: string read FBairro write FBairro;
    property Complemento: string read FComplemento write FComplemento;
    property Email: TEmailModel read FEmail write FEmail;
    property Telefone: TTelefoneModel read FTelefone write FTelefone;
  end;

implementation

{ TContato }

procedure TContatoModel.SetBairro(AValue: string);
begin
  FBairro := Trim(AValue);
end;

procedure TContatoModel.SetCEP(AValue: string);
begin
  FCEP := Trim(AValue);
end;

procedure TContatoModel.SetComplemento(AValue: string);
begin
  FComplemento := Trim(AValue);
end;

procedure TContatoModel.SetNumero(AValue: string);
begin
  FNumero := Trim(AValue);
end;

procedure TContatoModel.SetRua(AValue: string);
begin
  FNomeRua := Trim(AValue);
end;

end.
