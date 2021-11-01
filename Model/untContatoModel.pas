unit UntContatoModel;

interface

uses
  Classes, SysUtils, UntTelefoneModel, UntEmailModel,
  System.Generics.Collections;

type

  TContatoModel = class
  public
    FId: integer;
    FCEP: string;
    FNomeRua: string;
    FBairro: string;
    FNumero: string;
    FComplemento: string;
    FEmails: TObjectList<TEmailModel>;
    FTelefones: TObjectList<TTelefoneModel>;
    procedure SetCEP(AValue: string);
    procedure SetRua(AValue: string);
    procedure SetBairro(AValue: string);
    procedure SetNumero(AValue: string);
    procedure SetComplemento(AValue: string);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Id: integer read FId write FId;
    property CEP: string read FCEP write FCEP;
    property Rua: string read FNomeRua write FNomeRua;
    property Bairro: string read FBairro write FBairro;
    property Complemento: string read FComplemento write FComplemento;
    property Emails: TObjectList<TEmailModel> read FEmails write FEmails;
    property Telefones: TObjectList<TTelefoneModel> read FTelefones write FTelefones;
  end;

implementation

{ TContato }

constructor TContatoModel.Create;
begin
  FEmails := TObjectList<TEmailModel>.Create();
  FTelefones := TObjectList<TTelefoneModel>.Create();
end;

destructor TContatoModel.Destroy;
begin
  FEmails.Free;
  FTelefones.Free;
  inherited;
end;

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
