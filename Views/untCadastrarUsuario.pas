unit untCadastrarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntCadastrarUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin,
  Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, UntEnvironment, UntCrudEnum,
  UntFormHelper;

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
    txtNomeUsuario: TEdit;
    tobTop: TToolBar;
    tbuPesquisar: TToolButton;
    tbuExcluir: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCadastarClick(Sender: TObject);
    procedure txtNomeUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    FController: TCadastrarUsuarioController;
    FUsuarioExistente: Boolean;
    procedure habilitarCampos(AHabilitar: Boolean);
    procedure limparCampos();
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmCadastrarUsuario: TfrmCadastrarUsuario;

implementation

uses
  System.Generics.Collections, UntUsuarioModel;

{$R *.dfm}

function TfrmCadastrarUsuario.atualizarDados(AOperacao: TEnumCRUD): Boolean;
begin
   Result := False;


   Result := True;
end;

procedure TfrmCadastrarUsuario.btnCadastarClick(Sender: TObject);
begin
   btnCancelarClick(Sender);
end;

procedure TfrmCadastrarUsuario.btnCancelarClick(Sender: TObject);
begin
   limparCampos();
   habilitarCampos(False);
   FUsuarioExistente := False;
   If txtNomeUsuario.CanFocus Then txtNomeUsuario.SetFocus;
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
  FUsuarioExistente := False;
end;

procedure TfrmCadastrarUsuario.FormShow(Sender: TObject);
begin
   habilitarCampos(False);
end;

procedure TfrmCadastrarUsuario.habilitarCampos(AHabilitar: Boolean);
begin
   txtNomeUsuario.Enabled := Not AHabilitar;
   tbuPesquisar.Enabled := Not AHabilitar;
   tbuExcluir.Enabled := AHabilitar;

   txtSenhaAtual.Enabled := AHabilitar;
   txtNovaSenha.Enabled := AHabilitar;
   txtConfirmacaoNovaSenha.Enabled := AHabilitar;
   btnCadastar.Enabled := AHabilitar;
   btnCancelar.Enabled := AHabilitar;
end;

procedure TfrmCadastrarUsuario.limparCampos;
begin
   txtNomeUsuario.Clear;
   txtSenhaAtual.Clear;
   txtNovaSenha.Clear;
   txtConfirmacaoNovaSenha.Clear;
end;

procedure TfrmCadastrarUsuario.txtNomeUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
   If Key = BotaoEnter Then
      If validarCampos(Sender) Then
         If atualizarDados(actConsultar) Then
            Begin
               habilitarCampos(True);
               Self.TabOrderNext();
            End;
end;

function TfrmCadastrarUsuario.validarCampos(ACampo: TObject): Boolean;
var
  quantidadeMinimaCaracterParaNomeUsuario: Integer;
begin
   Result := False;
   quantidadeMinimaCaracterParaNomeUsuario := 4;

   If (ACampo = txtNomeUsuario) Then
      Begin
         If (Trim(txtNomeUsuario.Text) = EmptyStr) Then
            Begin
               ShowMessage('O campo nome de usuário deve ser preenchido!');
               If txtNomeUsuario.CanFocus Then txtNomeUsuario.SetFocus;
               Exit;
            End;

         If (Length(Trim(txtNomeUsuario.Text)) < quantidadeMinimaCaracterParaNomeUsuario) Then
            Begin
               ShowMessage('O campo nome de usuário deve ter pelo menos 4 dígitos!');
               If txtNomeUsuario.CanFocus Then txtNomeUsuario.SetFocus;
               Exit;
            End;
      End;

   Result := True;
end;

end.
