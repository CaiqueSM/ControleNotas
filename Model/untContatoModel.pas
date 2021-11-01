unit UntContatoModel;

interface

uses
  Classes, SysUtils, UntTelefoneModel, UntEmailModel,
  System.Generics.Collections;

type

  TContato = class
  public
    FId: integer;
    FCEP: string;
    FNomeRua: string;
    FBairro: string;
    FNumero: string;
    FComplemento: string;
    FEmails: TObjectList<TEmail>;
    FTelefones: TObjectList<TTelefone>;
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
    property Emails: TObjectList<TEmail> read FEmails write FEmails;
    property Telefones: TObjectList<TTelefone> read FTelefones write FTelefones;
  end;

implementation

{ TContato }

constructor TContato.Create;
begin
  FEmails := TObjectList<TEmail>.Create();
  FTelefones := TObjectList<TTelefone>.Create();
end;

destructor TContato.Destroy;
begin
  FEmails.Free;
  FTelefones.Free;
  inherited;
end;

procedure TContato.SetBairro(AValue: string);
begin
  FBairro := Trim(AValue);
end;

procedure TContato.SetCEP(AValue: string);
begin
  FCEP := Trim(AValue);
end;

procedure TContato.SetComplemento(AValue: string);
begin
  FComplemento := Trim(AValue);
end;

procedure TContato.SetNumero(AValue: string);
begin
  FNumero := Trim(AValue);
end;

procedure TContato.SetRua(AValue: string);
begin
  FNomeRua := Trim(AValue);
end;

end.
