unit UntUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin,
  Vcl.Buttons, Vcl.ToolWin, Vcl.ComCtrls, UntEnvironment, UntCrudEnum,
  UntFormHelper, UntMensagemUtil, UntMenu, UntConsulta, Vcl.ExtCtrls;

type
  TfrmUsuario = class(TForm)
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
    Shape1: TShape;
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
    FController: TUsuarioController;
    FUsuarioExistente: Boolean;
    FIdUsuarioExistente: Integer;
    procedure habilitarCampos(AHabilitar: Boolean);
    procedure limparCampos();
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
    procedure selecionarUsuario(Sender: TObject);
  end;

var
  frmUsuario: TfrmUsuario;

implementation

uses
  System.Generics.Collections, UntUsuarioModel;

{$R *.dfm}

function TfrmUsuario.atualizarDados(AOperacao: TEnumCRUD): Boolean;
var
  usuario: TUsuarioModel;
begin
  Result := True;

  Try
    Case AOperacao Of
      actConsultar:
        Begin
          Try
            usuario := FController.Consultar(txtNomeUsuario.Text);
            FUsuarioExistente := Not usuario.Nome.IsEmpty;
            FIdUsuarioExistente := usuario.Id;
          Except
            Result := False;
          End;
        End;

      actCriar:
        Begin
          usuario := TUsuarioModel.Create();
          usuario.Nome := txtNomeUsuario.Text;
          usuario.Senha := Trim(txtConfirmacaoNovaSenha.Text);

          Result := FController.Criar(usuario);
        End;

      actAlterar:
        Begin
          usuario := TUsuarioModel.Create();
          usuario.Id := FIdUsuarioExistente;
          usuario.Nome := txtNomeUsuario.Text;
          usuario.Senha := Trim(txtConfirmacaoNovaSenha.Text);

          Result := FController.Alterar(usuario);
        End;

      actExcluir:
        Begin
          Result := FController.Excluir(FIdUsuarioExistente);
        End;
    End;
  Finally
    If Assigned(usuario) Then
      usuario.Free;
  End;
end;

procedure TfrmUsuario.btnCadastarClick(Sender: TObject);
begin
  If validarCampos(todosCampos) Then
  Begin
    If FUsuarioExistente Then
    Begin
      If atualizarDados(actAlterar) Then
        btnCancelarClick(Sender)
    End
    Else
    Begin
      If atualizarDados(actCriar) Then
        btnCancelarClick(Sender)
    End;
  End;
end;

procedure TfrmUsuario.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
  habilitarCampos(False);
  FUsuarioExistente := False;
  FIdUsuarioExistente := 0;
  If txtNomeUsuario.CanFocus Then
    txtNomeUsuario.SetFocus;
end;

procedure TfrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  FController := TUsuarioController.Create();
  FUsuarioExistente := False;
end;

procedure TfrmUsuario.FormShow(Sender: TObject);
begin
  habilitarCampos(False);
end;

procedure TfrmUsuario.habilitarCampos(AHabilitar: Boolean);
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

procedure TfrmUsuario.limparCampos;
begin
  txtNomeUsuario.Clear;
  txtSenhaAtual.Clear;
  txtNovaSenha.Clear;
  txtConfirmacaoNovaSenha.Clear;
end;

procedure TfrmUsuario.selecionarUsuario(Sender: TObject);
begin
  If validarCampos(Sender) Then
    If atualizarDados(actConsultar) Then
    Begin
      habilitarCampos(True);
      txtSenhaAtual.Enabled := FUsuarioExistente;
      Self.TabOrderNext();
    End;
end;

procedure TfrmUsuario.tbuExcluirClick(Sender: TObject);
begin
  If Global.IdUsuario = FIdUsuarioExistente Then
  Begin
    ShowMessage('N?o ? poss?vel excluir o usu?rio que est? logado no sistema!');
    Exit;
  End;

  If ShowConfirm('Tem certeza que deseja excluir este usu?rio?') Then
    If atualizarDados(actExcluir) Then
      btnCancelarClick(Sender);
end;

procedure TfrmUsuario.tbuPesquisarClick(Sender: TObject);
var
  usuario: String;
begin
  usuario := TConsulta.ConsultarUsuarios();
  If (Not usuario.IsEmpty) Then
  Begin
    txtNomeUsuario.Text := usuario;
    selecionarUsuario(txtNomeUsuario);
  End
  Else If txtNomeUsuario.CanFocus Then
    txtNomeUsuario.SetFocus;
end;

procedure TfrmUsuario.txtNomeUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  If Not CharInSet(Key, ['A' .. 'Z', 'a' .. 'z']) Then
  Begin
    If Key = BotaoEnter Then
      selecionarUsuario(Sender)
    Else
      Key := #0;
  End;
end;

procedure TfrmUsuario.txtSenhaAtualKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = BotaoEnter Then
    If validarCampos(Sender) Then
      Self.TabOrderNext();
end;

function TfrmUsuario.validarCampos(ACampo: TObject): Boolean;
var
  tamanhoMinimoNome,
    tamanhoMinimoSenha: Integer;
begin
  Result := False;
  tamanhoMinimoNome := 4;
  tamanhoMinimoSenha := 4;

  If (ACampo = txtNomeUsuario) Or (ACampo = todosCampos) Then
  Begin
    If (Trim(txtNomeUsuario.Text) = EmptyStr) Then
    Begin
      ShowMessage('O campo nome de usu?rio deve ser preenchido!');
      If txtNomeUsuario.CanFocus Then
        txtNomeUsuario.SetFocus;
      Exit;
    End;

    If (Length(Trim(txtNomeUsuario.Text)) <
      tamanhoMinimoNome) Then
    Begin
      ShowMessage('O campo nome de usu?rio deve ter pelo menos 4 d?gitos!');
      If txtNomeUsuario.CanFocus Then
        txtNomeUsuario.SetFocus;
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
        If txtSenhaAtual.CanFocus Then
          txtSenhaAtual.SetFocus;
        Exit;
      End;

      If (Not FController.AutenticarSenha(txtNomeUsuario.Text,
        txtSenhaAtual.Text)) Then
      Begin
        ShowMessage('A senha atual est? incorreta!');
        If txtSenhaAtual.CanFocus Then
          txtSenhaAtual.SetFocus;
        Exit;
      End;
    End;
  End;

  If (ACampo = txtNovaSenha) Or (ACampo = todosCampos) Then
  Begin
    If (Trim(txtNovaSenha.Text) = EmptyStr) Then
    Begin
      ShowMessage('O campo nova senha deve ser preenchido!');
      If txtNovaSenha.CanFocus Then
        txtNovaSenha.SetFocus;
      Exit;
    End;

    If (Length(Trim(txtNovaSenha.Text)) <
      tamanhoMinimoSenha) Then
    Begin
      ShowMessage('O campo nova senha deve ter pelo menos 4 d?gitos!');
      If txtNovaSenha.CanFocus Then
        txtNovaSenha.SetFocus;
      Exit;
    End;
  End;

  If (ACampo = txtConfirmacaoNovaSenha) Or (ACampo = todosCampos) Then
  Begin
    If (Trim(txtConfirmacaoNovaSenha.Text) = EmptyStr) Then
    Begin
      ShowMessage('O campo confirma??o da nova senha deve ser preenchido!');
      If txtConfirmacaoNovaSenha.CanFocus Then
        txtConfirmacaoNovaSenha.SetFocus;
      Exit;
    End;

    If (Length(Trim(txtConfirmacaoNovaSenha.Text)) <
      tamanhoMinimoSenha) Then
    Begin
      ShowMessage
        ('O campo confirma??o da nova senha deve ter pelo menos 4 d?gitos!');
      If txtConfirmacaoNovaSenha.CanFocus Then
        txtConfirmacaoNovaSenha.SetFocus;
      Exit;
    End;

    If (Trim(txtNovaSenha.Text) <> Trim(txtConfirmacaoNovaSenha.Text)) Then
    Begin
      ShowMessage
        ('O campo nova senha e confirma??o da nova senha devem ser iguais!');
      If txtConfirmacaoNovaSenha.CanFocus Then
        txtConfirmacaoNovaSenha.SetFocus;
      Exit;
    End;
  End;

  Result := True;
end;

end.
