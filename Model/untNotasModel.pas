unit UntNotasModel;

interface

uses
  Classes, SysUtils, UntClienteModel, UntFornecedorModel;

type

  TNotasModel = class
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
    destructor Destroy(); override;

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

procedure TNotasModel.SetChaveAcesso(AValue: string);
destructor TNotas.Destroy;
begin
  If (FCliente <> nil) Then
    FCliente.Free;

  If (FFornecedor <> nil) Then
    FFornecedor.Free;

  inherited;
end;

procedure TNotas.SetChaveAcesso(AValue: string);
begin
  FChaveAcesso := Trim(AValue);
end;

procedure TNotasModel.SetCliente(AValue: TClienteModel);
begin
  FCliente := AValue;
end;

procedure TNotasModel.SetCodigo(AValue: integer);
begin
  FCodigo:= AValue;
end;

procedure TNotasModel.SetDescricao(AValue: string);
begin
  FDescricao := AValue;
end;

procedure TNotasModel.SetFornecedor(AValue: TFornecedorModel);
begin
  FFornecedor:= AValue;
end;

procedure TNotasModel.SetValor(AValue: real);
begin
  FValor:= AValue;
end;

end.
