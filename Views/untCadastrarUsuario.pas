unit untCadastrarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntCadastrarUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin;

type
  TfrmCadastrarUsuario = class(TForm)
    txtNomeUsuario: TEdit;
    txtInfoSenha: TEdit;
    lbNomeUsuario: TLabel;
    lbSenha: TLabel;
    btnCadastar: TButton;
    btnCancelar: TButton;
    txtConfirmSenha: TEdit;
    lbConfirmSenha: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FController: TCadastrarUsuarioController;
  end;

var
  frmCadastrarUsuario: TfrmCadastrarUsuario;

implementation

{$R *.dfm}

procedure TfrmCadastrarUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TfrmCadastrarUsuario.FormCreate(Sender: TObject);
begin
  FController := TCadastrarUsuarioController.Create(Nil);
end;

end.
