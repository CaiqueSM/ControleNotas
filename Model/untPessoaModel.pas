unit untPessoaModel;

interface

uses
  Classes, SysUtils, untContatoModel;

type

  TPessoaModel = class
  private
    FId: integer;
    FCNPJCPF: string;
    FNome: string;
    FContato: TContato;
    procedure SetNome(AValue: string);
    procedure SetCNPJCPF(AValue: string);
  public
    property Id: integer read FId write FId;
    property CNPJCPF: string read FCNPJCPF write SetCNPJCPF;
    property Nome: String read FNome write SetNome;
  end;

implementation

{ TPessoaModel }

procedure TPessoaModel.SetCNPJCPF(AValue: string);
begin
  FCNPJCPF := Trim(AValue);
end;

procedure TPessoaModel.SetNome(AValue: string);
begin
  FNome := Trim(AValue);
end;

end.
