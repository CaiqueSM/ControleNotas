unit untCadastrarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntCadastrarUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin,
  Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, UntEnvironment, UntCrudEnum,
  UntFormHelper, UntMensagemUtil, UntMenu, UntConsulta;

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
    procedure txtSenhaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure tbuExcluirClick(Sender: TObject);
    procedure tbuPesquisarClick(Sender: TObject);
  private
    FController: TCadastrarUsuarioController;
    FUsuarioExistente: Boolean;
    FIdUsuarioExistente: Integer;
    procedure habilitarCampos(AHabilitar: Boolean);
    procedure limparCampos();
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
    procedure selecionarUsuario(Sender: TObject);
  end;

var
  frmCadastrarUsuario: TfrmCadastrarUsuario;

implementation

uses
  System.Generics.Collections, UntUsuarioModel;

{$R *.dfm}

function TfrmCadastrarUsuario.atualizarDados(AOperacao: TEnumCRUD): Boolean;
var
  usuario: TUsuarioModel;
begin
   Result := False;
   Try
       Case AOperacao Of
          actConsultar:
             Begin
                usuario := FController.Consultar(txtNomeUsuario.Text);
                FUsuarioExistente := Not usuario.Nome.IsEmpty;
                FIdUsuarioExistente := usuario.Id;
             End;

          actCriar:
             Begin
                usuario := TUsuarioModel.Create();
                usuario.Nome := txtNomeUsuario.Text;
                usuario.Senha := Trim(txtConfirmacaoNovaSenha.Text);

                FController.Criar(usuario);
             End;

          actAlterar:
             Begin
                usuario := TUsuarioModel.Create();
                usuario.Id := FIdUsuarioExistente;
                usuario.Nome := txtNomeUsuario.Text;
                usuario.Senha := Trim(txtConfirmacaoNovaSenha.Text);

                FController.Alterar(usuario);
             End;

          actExcluir:
             Begin
                FController.Excluir(FIdUsuarioExistente);
             End;
       End;
   Finally
      If Assigned(usuario) Then usuario.Free;
   End;
   Result := True;
end;

procedure TfrmCadastrarUsuario.btnCadastarClick(Sender: TObject);
begin
   If validarCampos(todosCampos) Then
      Begin
         If FUsuarioExistente Then
            atualizarDados(actAlterar)
         Else
            atualizarDados(actCriar);

         btnCancelarClick(Sender);
      End;
end;

procedure TfrmCadastrarUsuario.btnCancelarClick(Sender: TObject);
begin
   limparCampos();
   habilitarCampos(False);
   FUsuarioExistente := False;
   FIdUsuarioExistente := 0;
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

procedure TfrmCadastrarUsuario.selecionarUsuario(Sender: TObject);
begin
   If validarCampos(Sender) Then
      If atualizarDados(actConsultar) Then
         Begin
            habilitarCampos(True);
            txtSenhaAtual.Enabled := FUsuarioExistente;
            Self.TabOrderNext();
         End;
end;

procedure TfrmCadastrarUsuario.tbuExcluirClick(Sender: TObject);
begin
   If Global.IdUsuario = FIdUsuarioExistente Then
      Begin
         ShowMessage('Não é possível excluir o usuário que está logado no sistema!');
         Exit;
      End;

   If ShowConfirm('Tem certeza que deseja excluir este usuário?') Then
      If atualizarDados(actExcluir) Then
         btnCancelarClick(Sender);
end;

procedure TfrmCadastrarUsuario.tbuPesquisarClick(Sender: TObject);
var
  usuario: String;
begin
   usuario := TConsulta.ConsultarUsuarios();
   If (Not usuario.IsEmpty) Then
      Begin
         txtNomeUsuario.Text := usuario;
         selecionarUsuario(txtNomeUsuario);
      End
   Else
      If txtNomeUsuario.CanFocus Then txtNomeUsuario.SetFocus;
end;

procedure TfrmCadastrarUsuario.txtNomeUsuarioKeyPress(Sender: TObject;
  var Key: Char);
begin
   If Key = BotaoEnter Then
      selecionarUsuario(Sender);
end;

procedure TfrmCadastrarUsuario.txtSenhaAtualKeyPress(Sender: TObject;
  var Key: Char);
begin
   If Key = BotaoEnter Then
      If validarCampos(Sender) Then
         Self.TabOrderNext();
end;

function TfrmCadastrarUsuario.validarCampos(ACampo: TObject): Boolean;
var
  quantidadeMinimaCaracterParaNomeUsuario,
  quantidadeMinimaCaracterParaSenhaUsuario: Integer;
begin
   Result := False;
   quantidadeMinimaCaracterParaNomeUsuario := 4;
   quantidadeMinimaCaracterParaSenhaUsuario := 4;

   If (ACampo = txtNomeUsuario) Or (ACampo = todosCampos) Then
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

   If (ACampo = txtSenhaAtual) Or (ACampo = todosCampos) Then
      Begin
         If FUsuarioExistente Then
            Begin
               If (Trim(txtSenhaAtual.Text) = EmptyStr) Then
                  Begin
                     ShowMessage('O campo da senha atual deve ser preenchido!');
                     If txtSenhaAtual.CanFocus Then txtSenhaAtual.SetFocus;
                     Exit;
                  End;

               If (Not FController.VerificarSenhaUsuarioEstaCorreta(
                  txtNomeUsuario.Text,
                  txtSenhaAtual.Text)) Then
                  Begin
                     ShowMessage('A senha atual está incorreta!');
                     If txtSenhaAtual.CanFocus Then txtSenhaAtual.SetFocus;
                     Exit;
                  End;
            End;
      End;

   If (ACampo = txtNovaSenha) Or (ACampo = todosCampos) Then
      Begin
         If (Trim(txtNovaSenha.Text) = EmptyStr) Then
            Begin
               ShowMessage('O campo nova senha deve ser preenchido!');
               If txtNovaSenha.CanFocus Then txtNovaSenha.SetFocus;
               Exit;
            End;

         If (Length(Trim(txtNovaSenha.Text)) < quantidadeMinimaCaracterParaSenhaUsuario) Then
            Begin
               ShowMessage('O campo nova senha deve ter pelo menos 4 dígitos!');
               If txtNovaSenha.CanFocus Then txtNovaSenha.SetFocus;
               Exit;
            End;
      End;

   If (ACampo = txtConfirmacaoNovaSenha) Or (ACampo = todosCampos) Then
      Begin
         If (Trim(txtConfirmacaoNovaSenha.Text) = EmptyStr) Then
            Begin
               ShowMessage('O campo confirmação da nova senha deve ser preenchido!');
               If txtConfirmacaoNovaSenha.CanFocus Then txtConfirmacaoNovaSenha.SetFocus;
               Exit;
            End;

         If (Length(Trim(txtConfirmacaoNovaSenha.Text)) < quantidadeMinimaCaracterParaSenhaUsuario) Then
            Begin
               ShowMessage('O campo confirmação da nova senha deve ter pelo menos 4 dígitos!');
               If txtConfirmacaoNovaSenha.CanFocus Then txtConfirmacaoNovaSenha.SetFocus;
               Exit;
            End;

         If (Trim(txtNovaSenha.Text) <> Trim(txtConfirmacaoNovaSenha.Text)) Then
            Begin
               ShowMessage('O campo nova senha e confirmação da nova senha devem ser iguais!');
               If txtConfirmacaoNovaSenha.CanFocus Then txtConfirmacaoNovaSenha.SetFocus;
               Exit;
            End;
      End;

   Result := True;
end;

end.
