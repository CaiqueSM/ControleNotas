unit UntLoginController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, RegExpr, sha1, UntLoginDao;

type

  { TLoginController }

  TLoginController = class
  private
    FDao: TLoginDao;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function Autenticar(nomeLocal, nomeVisitante: string; senhaLocal, senhaVisitante: string): boolean;
  end;

implementation

{ TLoginController }

constructor TLoginController.Create();
begin
  FDao := TLoginDao.Create();
end;

destructor TLoginController.Destroy();
begin
  FDao.Free;
  inherited Destroy();
end;

function TLoginController.Autenticar(nomeLocal, nomeVisitante: string;
  senhaLocal, senhaVisitante: string): boolean;
var
  ANomeLocal, ANomeVisitante: TRegExpr;
  AsenhaLocal, AsenhaVisitante: TSHA1Digest;
begin
  ANomeLocal:= TRegExpr.Create;
  ANomeVisitante:= TRegExpr.Create;

  ANomeLocal.Expression:= nomeLocal;
  ANomeVisitante.Expression:= nomeVisitante;

  AsenhaLocal:= SHA1String(senhaLocal);
  AsenhaVisitante:= SHA1String(senhaVisitante);

  Result:= (ANomeLocal.Equals(ANomeVIsitante) and SHA1Match(AsenhaLocal, AsenhaVisitante));
end;

end.

