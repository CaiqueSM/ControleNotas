unit UntUsuarioModel;

interface

uses
  Classes, SysUtils;

type

  { TUsuarioModel }

  TUsuarioModel = class
  private
    FId: integer;
    FNome: string;
    FSenha: string;
    procedure SetNome(AValue: string);
    procedure SetSenha(AValue: string);
  public
    property Id: integer read FId write FId;
    property Nome: string read FNome write SetNome;
    property Senha: string read FSenha write SetSenha;
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

