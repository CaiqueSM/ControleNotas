unit untNotasModel;

interface

uses
  Classes, SysUtils, UntClienteModel, UntFornecedorModel;

type

  TNotas = class
  private
    FId: integer;
    FChaveAcesso: string;
    FCodigo: integer;
    FDescricao: string;
    FValor: real;
    FCliente: TClienteModel;
    FFornecedor: TFornecedorModel;
    procedure SetChaveAcesso(AValue: string);
    procedure SetDescricao(AValue: string);
    procedure SetCodigo(AValue: integer);
    procedure SetValor(AValue: real);
    procedure SetCliente(AValue: TClienteModel);
    procedure SetFornecedor(AValue: TFornecedorModel);
  public
    property Id: integer read FId write FId;
    property Chave: string read FChaveAcesso write SetChaveAcesso;
    property Descicao: string read FDescricao write SetDescricao;
    property Codigo: integer read FCodigo write SetCodigo;
    property Valor: real read FValor write SetValor;
    property Cliente: TClienteModel read FCliente write SetCliente;
    property Fornecedor: TFornecedorModel read FFornecedor write SetFornecedor;
  end;

implementation

{ TNotas }

procedure TNotas.SetChaveAcesso(AValue: string);
begin
  FChaveAcesso := Trim(AValue);
end;

procedure TNotas.SetCliente(AValue: TClienteModel);
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

procedure TNotas.SetFornecedor(AValue: TFornecedorModel);
begin
  FFornecedor:= AValue;
end;

procedure TNotas.SetValor(AValue: real);
begin
  FValor:= AValue;
end;

end.
