unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UntClienteController, UntClienteModel, UntContatoModel, UntContatoController,
  UntEmailModel, UntTelefoneModel, UntEmailController, UntTelefoneController;

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
    txtcodigo: TEdit;
    lblcodigo: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure bntCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bntGravarClick(Sender: TObject);
  private
    FClienteController: TClienteController;
    FContatoController: TContatoController;
    FEmailController: TEmailController;
    FTelefoneController: TTelefoneController;
    procedure LimparCampos();
    function ValidarCamposCliente(ACliente: TClienteController): boolean;
    function ValidarCamposContato(AContato: TContatoController): boolean;
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
  txtComplemento.Clear;
  txtEmail.Clear;
  txtNomeCliente.Clear;
  txtNumero.Clear;
  txtRua.Clear;
  mskTelefone.Clear;
end;

function TfrmCliente.ValidarCamposCliente(ACliente: TClienteController)
  : boolean;
begin
  Result:= False;

  if not ACliente.ValidarCadastroPessoal(txtCNPJCPF.Text) then
  begin
    showmessage('CPF ou CNPJ incorreto.');
    if txtCNPJCPF.CanFocus then
      txtCNPJCPF.SetFocus;
    exit();
  end;

  if not ACliente.ValidarNome(txtNomeCliente.Text) then
  begin
    showmessage
      ('Nome invalido. Não é permitido o uso de caracteres especiais.');
    if txtNomeCliente.CanFocus then
      txtNomeCliente.SetFocus;
    exit();
  end;
  Result:= True;
end;

function TfrmCliente.ValidarCamposContato(AContato: TContatoController)
  : boolean;
begin
  Result:= False;

  if not AContato.ValidarCEP(mskCEP.Text) then
  begin
    showmessage('CEP incorreto!');
    if mskCEP.CanFocus then
      mskCEP.SetFocus;
    exit();
  end;

  if not AContato.ValidarNumero(txtNumero.Text) then
  begin
    showmessage('O número não pode estar vazio!');
    if txtNumero.CanFocus then
      txtNumero.SetFocus;
    exit();
  end;

  if not AContato.ValidarEmail(txtEmail.Text) then
  begin
    showmessage('Formato de email incorreto!');
    if txtEmail.CanFocus then
      txtEmail.SetFocus;
    exit();
  end;

  if not AContato.ValidarTelefone(mskTelefone.Text) then
  begin
    showmessage('Digite um número de telefone válido!');
    if CanFocus then
      SetFocus;
    exit();
  end;
  Result:= True;
end;

procedure TfrmCliente.bntCancelarClick(Sender: TObject);
begin
  LimparCampos();
end;

procedure TfrmCliente.bntGravarClick(Sender: TObject);
var
  FCliente: TClienteModel;
  FContato: TContatoModel;
  FEmail: TEmailModel;
  FTelefone: TTelefoneModel;

begin
  ValidarCamposCliente(FClienteController);
  ValidarCamposContato(FContatoController);
  FCliente := TClienteModel.Create;
  FContato:= TContatoModel.Create;
  FEmail:= TEmailModel.Create;
  FTelefone:= TTelefoneModel.Create;

  with FEmail do
  begin
    IdContato := FContato.Id;
    Email := txtEmail.Text;
  end;

  with FTelefone do
  begin
    IdContato := FContato.Id;
    Telefone := mskTelefone.Text;
  end;

  with FContato do
  begin
    IdCliente := strTOint(txtcodigo.Text);
    CEP := mskCEP.Text;
    Rua := txtRua.Text;
    Bairro := txtBairro.Text;
    Numero := txtNumero.Text;
    Complemento := txtComplemento.Text;
    Emails.add(FEmail);
    Telefones.add(FTelefone);
  end;

  with FCliente do
  begin
    Id := strTOint(txtcodigo.Text);
    CNPJ := txtCNPJCPF.Text;
    CPF := txtCNPJCPF.Text;
    Nome := txtNomeCliente.Text;
    Contatos.Add(FContato);
  end;

  FEmailController.Criar(FEmail);
  FTelefoneController.Criar(FTelefone);
  FContatoController.Criar(FContato);
  FClienteController.Criar(FCliente);
  showmessage('Cadastrado com sucesso!');
  LimparCampos();

end;

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FClienteController.Free;
  FContatoController.Free;
  FEmailController.Free;
  FTelefoneController.Free;
  CloseAction := caFree;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  FClienteController := TClienteController.Create();
  FContatoController := TContatoController.Create();
  FEmailController:= TEmailController.Create;
  FTelefoneController:= TTelefoneController.Create;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  null
end;

end.
