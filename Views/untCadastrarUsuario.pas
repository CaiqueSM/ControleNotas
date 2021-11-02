unit untCadastrarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntCadastrarUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin,
  Vcl.Buttons;

type
  TfrmCadastrarUsuario = class(TForm)
    txtNovaSenha: TEdit;
    lbNomeUsuario: TLabel;
    lbSenha: TLabel;
    btnCadastar: TButton;
    btnCancelar: TButton;
    txtConfirmacaoNovaSenha: TEdit;
    lbConfirmSenha: TLabel;
    Label1: TLabel;
    txtSenhaAtual: TEdit;
    TxtNomesUsuarios: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastarClick(Sender: TObject);
  private
    FController: TCadastrarUsuarioController;
    procedure habilitarCampos(AHabilitar: Boolean);
    procedure limparCampos();
  end;

var
  frmCadastrarUsuario: TfrmCadastrarUsuario;

implementation

uses
  System.Generics.Collections, UntUsuarioModel;

{$R *.dfm}

procedure TfrmCadastrarUsuario.btnCadastarClick(Sender: TObject);
begin
   btnCancelarClick(Sender);
end;

procedure TfrmCadastrarUsuario.btnCancelarClick(Sender: TObject);
begin
   limparCampos();
   If TxtNomesUsuarios.CanFocus Then TxtNomesUsuarios.SetFocus;
end;

procedure TfrmCadastrarUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TfrmCadastrarUsuario.FormCreate(Sender: TObject);
begin
  FController := TCadastrarUsuarioController.Create();
end;

procedure TfrmCadastrarUsuario.FormShow(Sender: TObject);
begin
   habilitarCampos(False);
end;

procedure TfrmCadastrarUsuario.habilitarCampos(AHabilitar: Boolean);
begin
   TxtNomesUsuarios.Enabled := Not AHabilitar;

   txtSenhaAtual.Enabled := AHabilitar;
   txtNovaSenha.Enabled := AHabilitar;
   txtConfirmacaoNovaSenha.Enabled := AHabilitar;
   btnCadastar.Enabled := AHabilitar;
   btnCancelar.Enabled := AHabilitar;
end;

procedure TfrmCadastrarUsuario.limparCampos;
begin
   TxtNomesUsuarios.Clear;
   txtSenhaAtual.Clear;
   txtNovaSenha.Clear;
   txtConfirmacaoNovaSenha.Clear;
end;

end.
