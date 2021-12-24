unit UntContatoModel;

interface

uses
  Classes, SysUtils, UntTelefoneModel, UntEmailModel,
  System.Generics.Collections;

type

  TContatoModel = class
  private
    FId: integer;
    FIdCliente: integer;
    FIdFornecedor: integer;
    FCEP: string;
    FRua: string;
    FBairro: string;
    FNumero: string;
    FCidade: string;
    FComplemento: string;
    FEmails: TObjectList<TEmailModel>;
    FTelefones: TObjectList<TTelefoneModel>;
    procedure SetCEP(AValue: string);
    procedure SetRua(AValue: string);
    procedure SetBairro(AValue: string);
    procedure SetNumero(AValue: string);
    procedure SetCidade(AValue: string);
    procedure SetComplemento(AValue: string);
  private
    procedure SetEmails(const Value: TObjectList<TEmailModel>);
    procedure SetTelefones(const Value: TObjectList<TTelefoneModel>);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Id: integer read FId write FId;
    property IdCliente: integer read FIdCliente write FIdCliente;
    property IdFornecedor: integer read FIdFornecedor write FIdFornecedor;
    property CEP: string read FCEP write SetCEP;
    property Rua: string read FRua write SetRua;
    property Cidade: string read FCidade write SetCidade;
    property Numero: string read FNumero write SetNumero;
    property Bairro: string read FBairro write SetBairro;
    property Complemento: string read FComplemento write SetComplemento;
    property Emails: TObjectList<TEmailModel> read FEmails write SetEmails;
    property Telefones: TObjectList<TTelefoneModel> read FTelefones
      write SetTelefones;
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
  If Assigned(FTelefones) Then
    FreeAndNil(FTelefones);
  If Assigned(FEmails) Then
    FreeAndNil(FEmails);
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

procedure TContatoModel.SetCidade(AValue: string);
begin
  FCidade := Trim(AValue);
end;

procedure TContatoModel.SetComplemento(AValue: string);
begin
  FComplemento := Trim(AValue);
end;

procedure TContatoModel.SetEmails(const Value: TObjectList<TEmailModel>);
begin
  If (FEmails <> Value) and (Value <> Nil) then
  Begin
    FEmails.Free;
    FEmails := Value;
  End;
end;

procedure TContatoModel.SetNumero(AValue: string);
begin
  FNumero := Trim(AValue);
end;

procedure TContatoModel.SetRua(AValue: string);
begin
  FRua := Trim(AValue);
end;

procedure TContatoModel.SetTelefones(const Value: TObjectList<TTelefoneModel>);
begin
  If (FTelefones <> Value) and (Value <> Nil) then
  Begin
    FTelefones.Free;
    FTelefones := Value;
  End;
end;

end.
