unit UntPessoaModel;

interface

uses
  Classes, SysUtils, untContatoModel, System.Generics.Collections;

type

  TPessoaModel = class
  private
    FId: integer;
    FCNPJ: string;
    FCPF: string;
    FNome: string;
    FContatos: TObjectList<TContato>;
    procedure SetNome(AValue: string);
    procedure SetCNPJ(AValue: string);
    procedure SetCPF(AValue: string);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Id: integer read FId write FId;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property CPF: string read FCPF write SetCPF;
    property Nome: String read FNome write SetNome;
    property Contatos: TObjectList<TContato> read FContatos write FContatos;
  end;

implementation

{ TPessoaModel }

constructor TPessoaModel.Create;
begin
  FContatos := TObjectList<TContato>.Create();
end;

destructor TPessoaModel.Destroy;
begin
  FContatos.Free;
  inherited;
end;

procedure TPessoaModel.SetCNPJ(AValue: string);
begin
  FCNPJ := Trim(AValue);
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
