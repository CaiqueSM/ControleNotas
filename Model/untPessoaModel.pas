unit UntPessoaModel;

interface

uses
  Classes, SysUtils, untContatoModel;

type

  TPessoaModel = class
  private
    FId: integer;
    FCNPJ: string;
    FCPF: string;
    FNome: string;
    FContato: TContatoModel;
    procedure SetNome(AValue: string);
    procedure SetCNPJ(AValue: string);
    procedure SetCPF(AValue: string);
    procedure SetContato(AValue: TContatoModel);
  public
    property Id: integer read FId write FId;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property CPF: string read FCPF write SetCPF;
    property Nome: String read FNome write SetNome;
    property Contato: TContatoModel read FContato write SetContato;
  end;

implementation

{ TPessoaModel }

procedure TPessoaModel.SetCNPJ(AValue: string);
begin
  FCNPJ := Trim(AValue);
end;

procedure TPessoaModel.SetContato(AValue: TContatoModel);
begin
  FContato := AValue;
end;

procedure TPessoaModel.SetCPF(AValue: string);
begin
  FCPF := Trim(AValue);
end;

procedure TPessoaModel.SetNome(AValue: string);
begin
  FNome := Trim(AValue);
end;

end.
