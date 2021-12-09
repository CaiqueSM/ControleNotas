unit UntNotasModel;

interface

uses
  Classes, SysUtils, UntClienteModel, UntFornecedorModel, UntUsuarioModel;

type

  TNotasModel = class
  private
    FId: integer;
    FChaveAcesso: string;
    FControle: integer;
    FDescricao: string;
    FValor: real;
    FEmissao: TDate;
    FCliente: TClienteModel;
    FFornecedor: TFornecedorModel;
    FUsuario: TUsuarioModel;
    procedure SetChaveAcesso(AValue: string);
    procedure SetDescricao(AValue: string);
    procedure SetControle(AValue: integer);
    procedure SetValor(AValue: real);
    procedure SetCliente(AValue: TClienteModel);
    procedure SetFornecedor(AValue: TFornecedorModel);
  public
    destructor Destroy(); override;

    property Id: integer read FId write FId;
    property Chave: string read FChaveAcesso write SetChaveAcesso;
    property Descricao: string read FDescricao write SetDescricao;
    property Controle: integer read FControle write SetControle;
    property Valor: real read FValor write SetValor;
    property Emissao: TDate read FEmissao write FEmissao;
    property Usuario: TUsuarioModel read FUsuario write FUsuario;
    property Cliente: TClienteModel read FCliente write SetCliente;
    property Fornecedor: TFornecedorModel read FFornecedor write SetFornecedor;
  end;

implementation

{ TNotas }

destructor TNotasModel.Destroy;
begin
  If (FUsuario <> nil) Then
    FUsuario.Free;

  If (FCliente <> nil) Then
    FCliente.Free;

  If (FFornecedor <> nil) Then
    FFornecedor.Free;

  inherited;
end;

procedure TNotasModel.SetChaveAcesso(AValue: string);
begin
  FChaveAcesso := Trim(AValue);
end;

procedure TNotasModel.SetCliente(AValue: TClienteModel);
begin
  FCliente := AValue;
end;

procedure TNotasModel.SetControle(AValue: integer);
begin
  FControle := AValue;
end;

procedure TNotasModel.SetDescricao(AValue: string);
begin
  FDescricao := AValue;
end;

procedure TNotasModel.SetFornecedor(AValue: TFornecedorModel);
begin
  FFornecedor := AValue;
end;

procedure TNotasModel.SetValor(AValue: real);
begin
  FValor := AValue;
end;

end.
