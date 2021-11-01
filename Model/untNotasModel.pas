unit untNotasModel;

interface
uses
Classes, SysUtils, UntUsuarioModel;

type

  TNotas = class
  private
    FId: integer;
    FChaveAcesso: string;
    FCodigo: integer;
    FDescricao: string;
    FValor: real;
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
  end;

implementation

{ TNotas }

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
end;

end.
