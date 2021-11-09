unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntEnvironment,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UntClienteController, UntClienteModel, UntContatoModel,
  UntEnumContatoDao, Vcl.ComCtrls, Vcl.ToolWin, UntCrudEnum,
  UntFormHelper;

type
  TfrmCliente = class(TForm)
    gbInfoCliente: TGroupBox;
    lbCNPJCPF: TLabel;
    txtCNPJCPF: TEdit;
    lbNomeCliente: TLabel;
    txtNomeCliente: TEdit;
    gbContatoCliente: TGroupBox;
    txtRua: TEdit;
    txtEmail: TEdit;
    txtBairro: TEdit;
    txtNumero: TEdit;
    lbCEP: TLabel;
    lbRua: TLabel;
    lbEmail: TLabel;
    lbBairro: TLabel;
    lbNumero: TLabel;
    lbTelefone: TLabel;
    btnCancelar: TButton;
    btnGravar: TButton;
    txtComplemento: TEdit;
    lbComplemento: TLabel;
    mskTelefone: TMaskEdit;
    mskCEP: TMaskEdit;
    txtCidade: TEdit;
    lblCidade: TLabel;
    gbCodigoCliente: TGroupBox;
    txtcodigo: TEdit;
    lblcodigo: TLabel;
    tobTop: TToolBar;
    tbuPesquisar: TToolButton;
    tbuExcluir: TToolButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure txtcodigoKeyPress(Sender: TObject; var Key: Char);
    procedure txtCNPJCPFKeyPress(Sender: TObject; var Key: Char);
    procedure tbuExcluirClick(Sender: TObject);
  private
    FClienteExistente: Boolean;
    FController: TClienteController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: boolean);
    procedure selecionarCliente(Sender: TObject);

    function serializeCliente():TClienteModel;
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmCliente: TfrmCliente;

implementation

uses
  UntEmailModel, UntTelefoneModel, UntMensagemUtil;

{$R *.dfm}

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  FController := TClienteController.Create();
end;

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

procedure TfrmCliente.LimparCampos();
begin
  txtBairro.Clear;
  mskCEP.Clear;
  txtCNPJCPF.Clear;
  txtcodigo.Clear;
  txtCidade.Clear;
  txtComplemento.Clear;
  txtEmail.Clear;
  txtNomeCliente.Clear;
  txtNumero.Clear;
  txtRua.Clear;
  mskTelefone.Clear;
end;

procedure TfrmCliente.selecionarCliente(Sender: TObject);
begin
   If validarCampos(Sender) Then
      If atualizarDados(actConsultar) Then
         Begin
            habilitarCampos(True);
            txtcodigo.Enabled := FClienteExistente;
            Self.TabOrderNext();
         End;
end;

function TfrmCliente.serializeCliente: TClienteModel;
var
  contato: TContatoModel;
  email: TEmailModel;
  telefone: TTelefoneModel;
begin
   Result := TClienteModel.Create();
   Result.Id := StrToInt(txtcodigo.Text);
   Result.Nome := txtNomeCliente.Text;
   Result.CNPJ := txtCNPJCPF.Text;
   Result.CPF := txtCNPJCPF.Text;

   contato := TContatoModel.Create();
   contato.CEP := mskCEP.Text;
   contato.Cidade := txtCidade.Text;
   contato.Bairro := txtBairro.Text;
   contato.Rua := txtRua.Text;
   contato.Numero := txtNumero.Text;
   contato.Complemento := txtComplemento.Text;

   email := TEmailModel.Create();
   email.Email := txtEmail.Text;

   telefone := TTelefoneModel.Create();
   telefone.Telefone := mskTelefone.Text;

   contato.Emails.Add(email);
   contato.Telefones.Add(telefone);

   Result.Contatos.Add(contato);
end;

procedure TfrmCliente.tbuExcluirClick(Sender: TObject);
begin
   If ShowConfirm('Tem certeza que deseja excluir este cliente?') Then
      If atualizarDados(actExcluir) Then
         btnCancelarClick(Sender);
end;

procedure TfrmCliente.txtCNPJCPFKeyPress(Sender: TObject; var Key: Char);
begin
   If Key = BotaoEnter Then
      If validarCampos(Sender) Then
         Self.TabOrderNext();
end;

procedure TfrmCliente.txtcodigoKeyPress(Sender: TObject; var Key: Char);
begin
   If Key = BotaoEnter Then
      selecionarCliente(Sender)
end;

function TfrmCliente.validarCampos(ACampo: TObject): Boolean;
begin
   Result := False;

   If (ACampo = txtcodigo) Or (ACampo = todosCampos) Then
      Begin
         If (txtcodigo.Text = EmptyStr) Then
            Begin
               ShowMessage('O campo código deve ser preenchido!');
               If txtcodigo.CanFocus Then txtcodigo.SetFocus;
               Exit();
            End;
      End;

   If (ACampo = txtCNPJCPF) Or (ACampo = todosCampos) Then
      Begin
         If Not FController.ValidarCadastroPessoal(txtCNPJCPF.Text) Then
            begin
               ShowMessage('CPF ou CNPJ incorreto!');
               If txtCNPJCPF.CanFocus Then txtCNPJCPF.SetFocus;
               Exit();
            end;
      End;

   If (ACampo = txtNomeCliente) Or (ACampo = todosCampos) Then
      Begin
         If Not FController.ValidarNome(txtNomeCliente.Text) then
            begin
               ShowMessage('Nome invalido, não é permitido o uso de caracteres especiais!');
               If txtNomeCliente.CanFocus Then txtNomeCliente.SetFocus;
               Exit();
           end;
      End;

   If (ACampo = mskCEP) Or (ACampo = todosCampos) Then
      Begin
         If Not FController.ValidarCEP(mskCEP.Text) Then
            begin
               ShowMessage('CEP inválido!');
               If mskCEP.CanFocus Then mskCEP.SetFocus;
               Exit();
            end;
      End;

   If (ACampo = txtNumero) Or (ACampo = todosCampos) Then
      Begin
         If Not FController.ValidarNumero(txtNumero.Text) Then
            begin
               ShowMessage('O número é obrigatório!');
               If txtNumero.CanFocus Then txtNumero.SetFocus;
               Exit();
            end;
      End;

   If (ACampo = txtEmail) Or (ACampo = todosCampos) Then
      Begin
         If not FController.ValidarEmail(txtEmail.Text) Then
            begin
               ShowMessage('Email inválido!');
               if txtEmail.CanFocus then txtEmail.SetFocus;
               Exit();
            End;
      End;

   If (ACampo = mskTelefone) Or (ACampo = todosCampos) Then
      Begin
         If Not FController.ValidarTelefone(mskTelefone.Text) Then
            begin
               ShowMessage('Número de telefone válido!');
               if mskTelefone.CanFocus Then mskTelefone.SetFocus;
               Exit();
            end;
      End;

   Result := True;
end;

function TfrmCliente.atualizarDados(AOperacao: TEnumCRUD): Boolean;
var
  cliente: TClienteModel;
  contato: TContatoModel;
  email: TEmailModel;
  telefone: TTelefoneModel;
  nenhum: Integer;
begin
   Result := True;
   nenhum := 0;

   Try
      Case AOperacao Of
         actConsultar:
            Begin
               Try
                  cliente := FController.Consultar(txtcodigo.Text);
                  FClienteExistente := Not cliente.Nome.IsEmpty;

                  If Not cliente.CNPJ.IsEmpty Then
                     txtCNPJCPF.Text := cliente.CNPJ
                  Else
                     txtCNPJCPF.Text := cliente.CPF;

                  txtNomeCliente.Text := cliente.Nome;

                  If (cliente.Contatos.Count > nenhum) Then
                     Begin
                        mskCEP.Text := cliente.Contatos.First.CEP;
                        txtCidade.Text := cliente.Contatos.First.Cidade;
                        txtBairro.Text := cliente.Contatos.First.Bairro;
                        txtRua.Text := cliente.Contatos.First.Rua;
                        txtNumero.Text := cliente.Contatos.First.Numero;
                        txtComplemento.Text := cliente.Contatos.First.Complemento;

                        If (cliente.Contatos.First.Emails.Count > nenhum) Then
                           txtEmail.Text := cliente.Contatos.First.Emails.First.Email;

                        If (cliente.Contatos.First.Telefones.Count > nenhum) Then
                           mskTelefone.Text := cliente.Contatos.First.Telefones.First.Telefone;
                     End;
               Except
                  Result := False;
               End;
            End;

         actCriar:
            Begin
               cliente := serializeCliente();
               Result := FController.Criar(cliente);
            End;

         actAlterar:
            Begin
               cliente := serializeCliente();
               Result := FController.Alterar(cliente);
            End;

         actExcluir:
            Begin
               Result := FController.Excluir(StrToInt(txtcodigo.Text));
            End;
       End;
   Finally
      If Assigned(cliente) Then cliente.Free;
   End;
end;

procedure TfrmCliente.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
  habilitarCampos(False);
  FClienteExistente := False;
  If txtcodigo.CanFocus Then txtcodigo.SetFocus;
end;

procedure TfrmCliente.btnGravarClick(Sender: TObject);
begin
   If validarCampos(todosCampos) Then
      Begin
         If FClienteExistente Then
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

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  HabilitarCampos(false);
end;

procedure TfrmCliente.HabilitarCampos(AHabilitar: boolean);
begin
  tbuPesquisar.Enabled := Not AHabilitar;
  txtcodigo.Enabled := Not AHabilitar;
  tbuExcluir.Enabled := AHabilitar;
  btnCancelar.Enabled := AHabilitar;
  btnGravar.Enabled := AHabilitar;

  txtBairro.Enabled := AHabilitar;
  mskCEP.Enabled := AHabilitar;
  txtCNPJCPF.Enabled := AHabilitar;
  txtCidade.Enabled := AHabilitar;
  txtComplemento.Enabled := AHabilitar;
  txtEmail.Enabled := AHabilitar;
  txtNomeCliente.Enabled := AHabilitar;
  txtNumero.Enabled := AHabilitar;
  txtRua.Enabled := AHabilitar;
  mskTelefone.Enabled := AHabilitar;
end;

end.
