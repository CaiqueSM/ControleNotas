unit controle_notas;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  UntLoginController;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    lbusuario: TLabel;
    txtUsuario: TEdit;
    txtSenha: TEdit;
    lbsenha: TLabel;
    btnAcessar: TButton;
    btnSair: TButton;
    procedure btnAcessarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FController: TLoginController;
    procedure limparCampos();
    function ValidarLogin(AUsuario, ASenha: string): boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

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

procedure TfrmLogin.limparCampos;
begin
  txtUsuario.Clear;
  txtSenha.Clear;
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

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
begin
  if not ValidarLogin(txtusuario.Text, txtsenha.Text) then
    Exit();

  if not FController.Logar(txtusuario.Text, txtsenha.Text) then
  begin
    ShowMessage('Usuário ou senha incorreta!');
    Exit();
  end;

  Close();
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  limparCampos();
end;

end.
