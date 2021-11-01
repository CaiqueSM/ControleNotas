unit untNotasModel;

interface

uses
<<<<<<< Updated upstream
Classes, SysUtils, UntUsuarioModel;
=======
  Classes, SysUtils, untPessoaModel;
>>>>>>> Stashed changes

type

  TNotas = class
  private
    FId: integer;
    FChaveAcesso: string;
    FCodigo: integer;
    FDescricao: string;
    FValor: real;
<<<<<<< Updated upstream
    FUsuario: TUsuarioModel;
    procedure SetChaveAcesso(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetUsuario(const Value: TUsuarioModel);
  public
    property Id: Integer read FId write FId;
    property ChaveAcesso: String read FChaveAcesso write SetChaveAcesso;
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write SetDescricao;
    property Valor: real read FValor write FValor;
    property Usuario: TUsuarioModel read FUsuario write SetUsuario;
=======
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
>>>>>>> Stashed changes
  end;

implementation

{ TNotas }

<<<<<<< Updated upstream
procedure TNotas.SetChaveAcesso(const Value: String);
begin
  FChaveAcesso := Trim(Value);
end;

procedure TNotas.SetDescricao(const Value: String);
begin
  FDescricao := Trim(Value);
end;

procedure TNotas.SetUsuario(const Value: TUsuarioModel);
begin
   If (Usuario <> Value) and (Value <> Nil) then
      Begin
         Usuario.Free;
         Usuario := Value;
      End;
=======
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
  FCodigo := AValue;
end;

procedure TNotas.SetDescricao(AValue: string);
begin
  FDescricao := AValue;
end;

procedure TNotas.SetFornecedor(AValue: TPessoaModel);
begin
  FFornecedor := AValue;
end;

procedure TNotas.SetValor(AValue: real);
begin
  FValor := AValue;
>>>>>>> Stashed changes
end;

end.
