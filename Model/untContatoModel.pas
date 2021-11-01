unit untContatoModel;

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

  TTelefone = class
  private
    FId: integer;
    FNumeroTelefone: string;
    procedure SetTelefone(AValue: string);
  public
    property Id: integer read FId write FId;
    property Telefone: string read FNumeroTelefone write SetTelefone;
  end;

  TContato = class
  public
    FId: integer;
    FCEP: string;
    FNomeRua: string;
    FBairro: string;
    FNumero: string;
    FComplemento: string;
    FEmail: TEmail;
    FTelefone: TTelefone;
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
    property Email: TEmail read FEmail write FEmail;
    property Telefone: TTelefone read FTelefone write FTelefone;
  end;

implementation

{ TContato }

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

{ TEmail }

procedure TEmail.SetEmail(AValue: string);
begin
  FEnderecoEmail := Trim(AValue);
end;

{ TTelefone }

procedure TTelefone.SetTelefone(AValue: string);
begin
  FNumeroTelefone := Trim(AValue);
end;

end.
