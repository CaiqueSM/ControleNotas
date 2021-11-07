unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UntClienteController, UntClienteModel, UntContatoModel, UntContatoController,
  UntEmailModel, UntTelefoneModel;

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

function TfrmCliente.ValidarCamposCliente(ACliente: TClienteController): boolean;
begin
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
end;

function TfrmCliente.ValidarCamposContato(AContato: TContatoController): boolean;
begin

  if not AContato.ValidarCEP(mskCEP.Text) then
  begin
    showmessage('CEP incorreto!');
    if mskCEP.CanFocus then
      mskCEP.SetFocus;
    exit();
  end;

  if not AContato.ValidarNumero(txtNumero.text) then
  begin
    showmessage('O número não pode estar vazio!');
    if txtNumero.CanFocus then
      txtNumero.SetFocus;
    exit();
  end;

  if not AContato.ValidarEmail(txtEmail.text) then
  begin
    showmessage('Formato de email incorreto!');
    if txtEmail.CanFocus then
      txtEmail.SetFocus;
    exit();
  end;

  if not Acontato.ValidarTelefone(mskTelefone.Text) then
  begin
    showmessage('Digite um número de telefone válido!');
    if CanFocus then
      SetFocus;
    exit();
  end;

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
  FCliente:= TClienteModel.Create;

  with FCliente do
  begin
    Id := strTOint(txtcodigo.Text);
    CNPJ := txtCNPJCPF.Text;
    CPF := txtCNPJCPF.Text;
    Nome := txtNomeCliente.Text;
  end;

  FClienteController.Criar(FCliente);
  showmessage('Cadastrado com sucesso!');
  LimparCampos();

end;

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FClienteController.Free;
  FContatoController.Free;
  CloseAction := caFree;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  FClienteController := TClienteController.Create();
  FContatoController := TContatoController.Create();
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  null
end;

end.
