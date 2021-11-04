unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  UntClienteController, UntValidarPessoa, UntClienteModel;

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
    FController: TClienteController;
    FCliente: TClienteModel;
    FValidarCliente: TValidarPessoa;
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

procedure TfrmCliente.bntCancelarClick(Sender: TObject);
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

procedure TfrmCliente.bntGravarClick(Sender: TObject);
begin
  if not FValidarCliente.ValidarNome(txtNomeCliente.Text) then
  begin
    showmessage('Nome invalido. Não é permitido o uso de caracteres especiais.');
    if txtNomeCliente.CanFocus then txtNomeCliente.SetFocus;
    exit();
  end;

  if not FValidarCliente.ValidarNumeroCadastroPessoal(txtCNPJCPF.Text) then
  begin

  end;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  FController := TClienteController.Create();
  FCliente := TClienteModel.Create();
  FValidarCliente := TValidarPessoa.Create();
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
null
end;

end.
