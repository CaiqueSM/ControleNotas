unit controle_notas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, MaskEdit,
  UntLoginController;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    btacessar: TButton;
    btsair: TButton;
    gbautenticacao: TGroupBox;
    lbsenha: TLabel;
    lbusuario: TLabel;
    txtsenha: TEdit;
    txtusuario: TEdit;
    procedure btacessarClick(Sender: TObject);
    procedure btsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FController: TLoginController;
    function ValidarLogin(AUsuario, ASenha: string): boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FController := TLoginController.Create();
end;

procedure TfrmLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

function TfrmLogin.ValidarLogin(AUsuario, ASenha: string): boolean;
begin
  Result := False;

  if not FController.ValidarUsuario(AUsuario) then
  begin
    ShowMessage('Nome usuário inválido!');

    if txtusuario.CanFocus then
      txtusuario.SetFocus;
    exit();
  end;

  if not FController.ValidarSenha(ASenha) then
  begin
    ShowMessage('Senha inválida!');

    if txtsenha.CanFocus then
      txtsenha.SetFocus;
    exit();
  end;

  Result := True;
end;

procedure TfrmLogin.btacessarClick(Sender: TObject);
begin
  if not ValidarLogin(txtusuario.Text, txtsenha.Text) then
    Exit();
end;

procedure TfrmLogin.btsairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
