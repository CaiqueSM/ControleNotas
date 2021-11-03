unit untLogin;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  UntLoginController, Vcl.Mask;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    lbusuario: TLabel;
    txtSenha: TEdit;
    lbsenha: TLabel;
    btnAcessar: TButton;
    btnSair: TButton;
    mskUsuario: TMaskEdit;
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
  mskUsuario.Clear;
  txtSenha.Clear;
end;

function TfrmLogin.ValidarLogin(AUsuario, ASenha: string): boolean;
begin
  Result := False;

  if not FController.ValidarUsuario(AUsuario) then
  begin
    ShowMessage('Nome usuário inválido!');
    if mskUsuario.CanFocus then mskUsuario.SetFocus;
    exit();
  end;

  if not FController.ValidarSenha(ASenha) then
  begin
    ShowMessage('Senha inválida!');
    if txtSenha.CanFocus then txtSenha.SetFocus;
    exit();
  end;

  Result := True;
end;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
begin
  if not ValidarLogin(mskUsuario.Text, txtSenha.Text) then
    exit();

  if not FController.Logar(mskUsuario.Text, txtSenha.Text) then
  begin
    ShowMessage('Usuário ou senha incorreta!');
    if mskUsuario.CanFocus then mskUsuario.SetFocus;
    exit();
  end;

  Close();
end;

procedure TfrmLogin.btnSairClick(Sender: TObject);
begin
  limparCampos();
  if mskUsuario.CanFocus then mskUsuario.SetFocus;
end;

end.
