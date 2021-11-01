unit UntUsuarioModel;

interface

uses
  Classes, SysUtils, untNotasModel;

type

  { TUsuarioModel }

  TUsuarioModel = class
  private
    FId: integer;
    FNome: string;
    FSenha: string;
    FNotas: array of TNotas;
    procedure SetNome(AValue: string);
    procedure SetSenha(AValue: string);
    procedure SetNotas(AValue: TNotas);
  public
    property Id: integer read FId write FId;
    property Nome: string read FNome write SetNome;
    property Senha: string read FSenha write SetSenha;
    //property Notas:
  end;

implementation

{ TUsuarioModel }

procedure TUsuarioModel.SetNome(AValue: string);
begin
  FNome := Trim(AValue);
end;

procedure TUsuarioModel.SetSenha(AValue: string);
begin
  FSenha := Trim(AValue);
end;

end.
