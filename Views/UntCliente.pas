unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntEnvironment,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UntClienteController, UntClienteModel, UntContatoModel, UntContatoController,
  UntEmailModel, UntTelefoneModel, UntEmailController, UntTelefoneController,
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
    bntCancelar: TButton;
    bntGravar: TButton;
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
    procedure bntCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bntGravarClick(Sender: TObject);
    procedure txtcodigoKeyPress(Sender: TObject; var Key: Char);
  private
    FClienteExistente: Boolean;
    FController: TClienteController;
    FContatoController: TContatoController;
    FEmailController: TEmailController;
    FTelefoneController: TTelefoneController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: boolean);
    procedure selecionarCliente(Sender: TObject);

    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

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
begin

end;

procedure TfrmCliente.bntCancelarClick(Sender: TObject);
begin
  limparCampos();
  habilitarCampos(False);
  FClienteExistente := False;
  If txtcodigo.CanFocus Then txtcodigo.SetFocus;
end;

procedure TfrmCliente.bntGravarClick(Sender: TObject);
var
  FCliente: TClienteModel;
  FContato: TContatoModel;
  FEmail: TEmailModel;
  FTelefone: TTelefoneModel;

begin

  

  FCliente := TClienteModel.Create;
  FContato := TContatoModel.Create;
  FEmail := TEmailModel.Create;
  FTelefone := TTelefoneModel.Create;
  try
    with FCliente do
    begin
      Id := strTOint(txtcodigo.Text);
      CNPJ := txtCNPJCPF.Text;
      CPF := txtCNPJCPF.Text;
      Nome := txtNomeCliente.Text;
    end;

    FController.Criar(FCliente);

    with FContato do
    begin
      IdCliente := strTOint(txtcodigo.Text);
      IdFornecedor := 0;
      CEP := mskCEP.Text;
      Cidade := txtCidade.Text;
      Rua := txtRua.Text;
      Bairro := txtBairro.Text;
      Numero := txtNumero.Text;
      Complemento := txtComplemento.Text;
    end;

    FContatoController.Criar(FContato);
    FContato := FContatoController.Consultar(strTOint(txtcodigo.Text),
      actCliente);

    with FEmail do
    begin
      IdContato := FContato.Id;
      Email := txtEmail.Text;
    end;

    FEmailController.Criar(FEmail);

    with FTelefone do
    begin
      IdContato := FContato.Id;
      Telefone := mskTelefone.Text;
    end;

    FTelefoneController.Criar(FTelefone);

    FContato.Emails.add(FEmail);
    FContato.Telefones.add(FTelefone);
    FCliente.Contatos.add(FContato);

    showmessage('Cadastrado com sucesso!');
  Except
    on E: Exception do
    Begin
      raise E.Create('Não foi possível gravar os dados.');
    End;
  end;
  LimparCampos();
end;

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  FContatoController.Free;
  FEmailController.Free;
  FTelefoneController.Free;
  CloseAction := caFree;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  FController := TClienteController.Create();
  FContatoController := TContatoController.Create();
  FEmailController := TEmailController.Create;
  FTelefoneController := TTelefoneController.Create;
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
