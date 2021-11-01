unit untNotasModel;

interface

uses
  Classes, SysUtils, untPessoaModel;

type

  TNotas = class
  private
    FId: integer;
    FChaveAcesso: string;
    FCodigo: integer;
    FDescricao: string;
    FValor: real;
    FCliente: TPessoaModel;
    FFornecedor: TPessoaModel;
    procedure SetChaveAcesso(AValue: string);
    procedure SetDescricao(AValue: string);
    procedure SetCodigo(AValue: integer);
    procedure SetValor(AValue: real);
    procedure SetCliente(AValue: TPessoaModel);
    procedure SetFornecedor(AValue: TPessoaModel);
  public
    property Id: integer read FId write FId;
    property Chave: string read FChaveAcesso write FChaveAcesso;
    property Descicao: string read FDescricao write FDescricao;
    property Valor: real read FValor write FValor;
    property Cliente: TPessoaModel read FCliente write FCliente;
    property Fornecedor: TPessoaModel read FFornecedor write FFornecedor;
  end;

implementation

{ TNotas }

procedure TNotas.SetChaveAcesso(AValue: string);
begin
  FChaveAcesso := Trim(AValue);
end;

procedure TNotas.SetCliente(AValue: TPessoaModel);
begin
  FCliente := AValue;
end;

procedure TNotas.SetCodigo(AValue: integer);
begin
  FCodigo:= AValue;
end;

procedure TNotas.SetDescricao(AValue: string);
begin
  FDescricao := AValue;
end;

procedure TNotas.SetFornecedor(AValue: TPessoaModel);
begin

end;

procedure TNotas.SetValor(AValue: real);
begin

end;

end.
