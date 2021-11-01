unit UntUsuarioModel;

interface

uses
  Classes, SysUtils, untNotasModel, System.Generics.Collections;

type

  { TUsuarioModel }

  TUsuarioModel = class
  private
    FId: integer;
    FNome: string;
    FSenha: string;
    FNotas: TObjectList<TNotasModel>;
    procedure SetNome(AValue: string);
    procedure SetSenha(AValue: string);
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    property Id: integer read FId write FId;
    property Nome: string read FNome write SetNome;
    property Senha: string read FSenha write SetSenha;
    property Notas: TObjectList<TNotasModel> read FNotas write FNotas;
  end;

implementation

{ TUsuarioModel }

constructor TUsuarioModel.Create;
begin
   FNotas := TObjectList<TNotasModel>.Create();
end;

destructor TUsuarioModel.Destroy;
begin
  FNotas.Free;
  inherited;
end;

procedure TUsuarioModel.SetNome(AValue: string);
begin
  FNome := Trim(AValue);
end;

procedure TUsuarioModel.SetSenha(AValue: string);
begin
  FSenha := Trim(AValue);
end;

end.
