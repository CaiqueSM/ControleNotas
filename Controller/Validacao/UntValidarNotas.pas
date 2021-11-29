unit UntValidarNotas;

interface

uses

UntValidarPessoa, SysUtils;

type

TValidarNotas = class
private
  NumeroPessoal: TValidarPessoa;
public
  function ValidarChaveAcesso(AChaveAcesso: string): boolean;
  function ValidarValor(Avalor: string): boolean;
  constructor Create;
  destructor Destroy; override;
  property ValidarNumeroPessoal: TvalidarPessoa read NumeroPessoal;
end;

implementation

{ TValidarNotas }

constructor TValidarNotas.Create;
begin
  NumeroPessoal:= TValidarPessoa.Create;
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
  regraValidacao := [4,3,2, 9,8,7,6,5,4,3,2, 9,8,7,6,5,4,3,2,
  9,8,7,6,5,4,3,2, 9,8,7,6,5,4,3,2, 9,8,7,6,5,4,3,2];
  tamanhoChave:= 43;
  soma:= 0;
  digitoVerificador:= strTOint(AChaveAcesso[length(AChaveAcesso) -1]);

  for i := 0 to tamanhoChave - 1 do
  begin
    soma:= soma + strTOint(AChaveAcesso[i]) * regraValidacao[i];
  end;

  resultado:= 11 - (soma mod 11);

  result:= (digitoVerificador = resultado);
end;

function TValidarNotas.ValidarValor(Avalor: string): boolean;
begin
  result:= not(AValor.IsNullOrEmpty(AValor));
end;

end.
