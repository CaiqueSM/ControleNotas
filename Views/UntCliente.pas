unit UntCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

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
    txtTelefone: TMaskEdit;
    mskCEP: TMaskEdit;
    txtcodigo: TEdit;
    lblcodigo: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

procedure TfrmCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.
