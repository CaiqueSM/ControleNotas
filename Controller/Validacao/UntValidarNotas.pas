unit UntValidarNotas;

interface

uses

  UntValidarPessoa, SysUtils;

type

  TValidarNotas = class
  private
    NumeroPessoal: TValidarPessoa;
  public
    constructor Create;
    destructor Destroy; override;
    function ValidarChaveAcesso(AChaveAcesso: string): boolean;
    function ValidarValor(Avalor: string): boolean;
    function ValidarNumeroPessoal(Anumero: string): boolean;
  end;

implementation

{ TValidarNotas }

constructor TValidarNotas.Create;
begin
  NumeroPessoal := TValidarPessoa.Create;
end;

destructor TValidarNotas.Destroy;
begin
  NumeroPessoal.Free;
  inherited;
end;

function TValidarNotas.ValidarChaveAcesso(AChaveAcesso: string): boolean;
var
  regraValidacao: array of integer;
  i: integer;
  tamanhoChave, soma, resultado, digitoVerificador: integer;
begin
  regraValidacao := [4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9,
    8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  tamanhoChave := 43;
  soma := 0;
  digitoVerificador := strTOint(AChaveAcesso[length(AChaveAcesso)]);

  for i := 1 to tamanhoChave do
  begin
    soma := soma + strTOint(AChaveAcesso[i]) * regraValidacao[i - 1];
  end;

  resultado := 11 - (soma mod 11);

  result := (digitoVerificador = resultado);
end;

function TValidarNotas.ValidarNumeroPessoal(Anumero: string): boolean;
begin
  result := NumeroPessoal.ValidarNumeroCadastroPessoal(Anumero);
end;

function TValidarNotas.ValidarValor(Avalor: string): boolean;
begin
  result := not(Avalor.IsNullOrEmpty(Avalor));
end;

end.
