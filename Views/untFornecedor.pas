unit UntFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntFornecedorModel, UntFornecedorController,
  UntContatoModel, UntCrudEnum, UntEnvironment,
  UntConsultaFornecedor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls,
  Vcl.ToolWin, UntFormHelper;

type
  TfrmFornecedor = class(TForm)
    btnCancelar: TButton;
    btnGravar: TButton;
    gbCodigoFornecedor: TGroupBox;
    lblcodigo: TLabel;
    txtcodigo: TEdit;
    gbContatoFornecedor: TGroupBox;
    lbCEP: TLabel;
    lbRua: TLabel;
    lbEmail: TLabel;
    lbBairro: TLabel;
    lbNumero: TLabel;
    lbNomeFornecedor: TLabel;
    lbTelefone: TLabel;
    lbComplemento: TLabel;
    lblCidade: TLabel;
    txtRua: TEdit;
    txtEmail: TEdit;
    txtBairro: TEdit;
    txtNumero: TEdit;
    txtNomeFornecedor: TEdit;
    txtComplemento: TEdit;
    mskTelefone: TMaskEdit;
    mskCEP: TMaskEdit;
    txtCidade: TEdit;
    gbInfoFornecedor: TGroupBox;
    lbCNPJCPF: TLabel;
    txtCNPJCPF: TEdit;
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
    procedure tbuPesquisarClick(Sender: TObject);
  private
    FFornecedorExistente: Boolean;
    FController: TFornecedorController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure selecionarFornecedor(Sender: TObject);

    function serializeFornecedor(): TFornecedorModel;
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses
  UntEmailModel, UntTelefoneModel, UntMensagemUtil;

{$R *.dfm}

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
  FController := TFornecedorController.Create();
end;

procedure TfrmFornecedor.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

procedure TfrmFornecedor.LimparCampos();
begin
  txtBairro.Clear;
  mskCEP.Clear;
  txtCNPJCPF.Clear;
  txtcodigo.Clear;
  txtCidade.Clear;
  txtComplemento.Clear;
  txtEmail.Clear;
  txtNomeFornecedor.Clear;
  txtNumero.Clear;
  txtRua.Clear;
  mskTelefone.Clear;
end;

procedure TfrmFornecedor.selecionarFornecedor(Sender: TObject);
begin
  If validarCampos(Sender) Then
    If atualizarDados(actConsultar) Then
    Begin
      HabilitarCampos(True);
      txtcodigo.Enabled := FFornecedorExistente;
      Self.TabOrderNext();
    End;
end;

function TfrmFornecedor.serializeFornecedor: TFornecedorModel;
var
  contato: TContatoModel;
  email: TEmailModel;
  telefone: TTelefoneModel;
  tamanhoCPF: integer;
begin
  tamanhoCPF := 11;
  Result := TFornecedorModel.Create();
  Result.Id := StrToInt(txtcodigo.Text);
  Result.Nome := txtNomeFornecedor.Text;

  if tamanhoCPF = length(txtCNPJCPF.Text) then
  begin
    Result.CPF := txtCNPJCPF.Text;
    Result.CNPJ := '0';
  end
  else
  begin
    Result.CPF := '0';
    Result.CNPJ := txtCNPJCPF.Text;;
  end;

  contato := TContatoModel.Create();
  contato.Id := Result.Id;
  contato.CEP := mskCEP.Text;
  contato.Cidade := txtCidade.Text;
  contato.Bairro := txtBairro.Text;
  contato.Rua := txtRua.Text;
  contato.Numero := txtNumero.Text;
  contato.Complemento := txtComplemento.Text;

  email := TEmailModel.Create();
  email.IdContato := contato.Id;
  email.email := txtEmail.Text;

  telefone := TTelefoneModel.Create();
  telefone.IdContato := contato.Id;
  telefone.telefone := mskTelefone.Text;

  contato.Emails.Add(email);
  contato.Telefones.Add(telefone);

  Result.Contatos.Add(contato);
end;

procedure TfrmFornecedor.tbuExcluirClick(Sender: TObject);
begin
  If ShowConfirm('Tem certeza que deseja excluir este Fornecedor?') Then
    If atualizarDados(actExcluir) Then
      btnCancelarClick(Sender);
end;

procedure TfrmFornecedor.tbuPesquisarClick(Sender: TObject);
var
  Fornecedor: String;
begin
  Fornecedor := TConsultaFornecedor.ConsultarFornecedores();
  If (Not Fornecedor.IsEmpty) Then
  Begin
    txtNomeFornecedor.Text := trim(Fornecedor);
    selecionarFornecedor(txtNomeFornecedor);
    txtcodigo.Enabled := False;
  End
  Else If txtNomeFornecedor.CanFocus Then
    txtNomeFornecedor.SetFocus;
end;

procedure TfrmFornecedor.txtCNPJCPFKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = BotaoEnter Then
    If validarCampos(Sender) Then
      Self.TabOrderNext();
end;

procedure TfrmFornecedor.txtcodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = BotaoEnter Then
    selecionarFornecedor(Sender)
end;

function TfrmFornecedor.validarCampos(ACampo: TObject): Boolean;
begin
  Result := False;

  If (ACampo = txtcodigo) Or (ACampo = todosCampos) Then
  Begin
    If (txtcodigo.Text = EmptyStr) Then
    Begin
      ShowMessage('O campo código deve ser preenchido!');
      If txtcodigo.CanFocus Then
        txtcodigo.SetFocus;
      Exit();
    End;
  End;

  If (ACampo = txtCNPJCPF) Or (ACampo = todosCampos) Then
  Begin
    If Not FController.ValidarCadastroPessoal(txtCNPJCPF.Text) Then
    begin
      ShowMessage('CPF ou CNPJ incorreto!');
      If txtCNPJCPF.CanFocus Then
        txtCNPJCPF.SetFocus;
      Exit();
    end;
  End;

  If (ACampo = txtNomeFornecedor) Or (ACampo = todosCampos) Then
  Begin
    If Not FController.ValidarNome(txtNomeFornecedor.Text) then
    begin
      ShowMessage
        ('Nome invalido, não é permitido o uso de caracteres especiais!');
      If txtNomeFornecedor.CanFocus Then
        txtNomeFornecedor.SetFocus;
      Exit();
    end;
  End;

  If (ACampo = mskCEP) Or (ACampo = todosCampos) Then
  Begin
    If Not FController.ValidarCEP(mskCEP.Text) Then
    begin
      ShowMessage('CEP inválido!');
      If mskCEP.CanFocus Then
        mskCEP.SetFocus;
      Exit();
    end;
  End;

  If (ACampo = txtNumero) Or (ACampo = todosCampos) Then
  Begin
    If Not FController.ValidarNumero(txtNumero.Text) Then
    begin
      ShowMessage('O número é obrigatório!');
      If txtNumero.CanFocus Then
        txtNumero.SetFocus;
      Exit();
    end;
  End;

  If (ACampo = txtEmail) Or (ACampo = todosCampos) Then
  Begin
    If not FController.ValidarEmail(txtEmail.Text) Then
    begin
      ShowMessage('Email inválido!');
      if txtEmail.CanFocus then
        txtEmail.SetFocus;
      Exit();
    End;
  End;

  If (ACampo = mskTelefone) Or (ACampo = todosCampos) Then
  Begin
    If Not FController.ValidarTelefone(mskTelefone.Text) Then
    begin
      ShowMessage('Número de telefone válido!');
      if mskTelefone.CanFocus Then
        mskTelefone.SetFocus;
      Exit();
    end;
  End;

  Result := True;
end;

function TfrmFornecedor.atualizarDados(AOperacao: TEnumCRUD): Boolean;
var
  Fornecedor: TFornecedorModel;
  nenhum: integer;
begin
  Result := True;
  nenhum := 0;

  Try
    Case AOperacao Of
      actConsultar:
        Begin
          Try
            if txtcodigo.Text = EmptyStr then
              Fornecedor := FController.ConsultarPorNome(txtNomeFornecedor.Text)
            else
              Fornecedor := FController.Consultar(StrToInt(txtcodigo.Text));
            if Fornecedor <> nil then
            begin
              FFornecedorExistente := Not Fornecedor.Nome.IsEmpty;

              txtcodigo.Text := intTOstr(Fornecedor.Id);

              FFornecedorExistente := Not Fornecedor.Nome.IsEmpty;

              If Not Fornecedor.CNPJ.IsEmpty Then
                txtCNPJCPF.Text := Fornecedor.CNPJ
              Else
                txtCNPJCPF.Text := Fornecedor.CPF;

              txtNomeFornecedor.Text := Fornecedor.Nome;

              If (Fornecedor.Contatos.Count > nenhum) Then
              Begin
                mskCEP.Text := Fornecedor.Contatos.First.CEP;
                txtCidade.Text := Fornecedor.Contatos.First.Cidade;
                txtBairro.Text := Fornecedor.Contatos.First.Bairro;
                txtRua.Text := Fornecedor.Contatos.First.Rua;
                txtNumero.Text := Fornecedor.Contatos.First.Numero;
                txtComplemento.Text := Fornecedor.Contatos.First.Complemento;

                If (Fornecedor.Contatos.First.Emails.Count > nenhum) Then
                  txtEmail.Text := Fornecedor.Contatos.First.Emails.First.email;

                If (Fornecedor.Contatos.First.Telefones.Count > nenhum) Then
                  mskTelefone.Text := Fornecedor.Contatos.First.Telefones.
                    First.telefone;
              End;
            End;
          Except
            Result := False;
          End;
        End;

      actCriar:
        Begin
          Fornecedor := serializeFornecedor();
          Result := FController.Criar(Fornecedor);
        End;

      actAlterar:
        Begin
          Fornecedor := serializeFornecedor();
          Result := FController.Alterar(Fornecedor);
        End;

      actExcluir:
        Begin
          Result := FController.Excluir(StrToInt(txtcodigo.Text));
        End;
    End;
  Finally
    If Assigned(Fornecedor) Then
      Fornecedor.Free;
  End;
end;

procedure TfrmFornecedor.btnCancelarClick(Sender: TObject);
begin
  LimparCampos();
  HabilitarCampos(False);
  FFornecedorExistente := False;
  If txtcodigo.CanFocus Then
    txtcodigo.SetFocus;
end;

procedure TfrmFornecedor.btnGravarClick(Sender: TObject);
begin
  If validarCampos(todosCampos) Then
  Begin
    If FFornecedorExistente Then
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

procedure TfrmFornecedor.FormShow(Sender: TObject);
begin
  HabilitarCampos(False);
end;

procedure TfrmFornecedor.HabilitarCampos(AHabilitar: Boolean);
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
  txtNomeFornecedor.Enabled := AHabilitar;
  txtNumero.Enabled := AHabilitar;
  txtRua.Enabled := AHabilitar;
  mskTelefone.Enabled := AHabilitar;
end;

end.
