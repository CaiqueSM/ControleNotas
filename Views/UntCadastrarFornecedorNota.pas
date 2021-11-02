unit untCadastrarFornecedorNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmFornecedorNotaFiscal = class(TForm)
    gbInfoFornecedor: TGroupBox;
    txtCPFCNPJ: TEdit;
    txtNomeFornecedor: TEdit;
    lbCNPJCPF: TLabel;
    lbNomeFornecedor: TLabel;
    gbContatoFornecedor: TGroupBox;
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
    btnGravar: TButton;
    btnCancelar: TButton;
    txtComplemento: TEdit;
    lbComplemento: TLabel;
    mskTelefone: TMaskEdit;
    mskCEP: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFornecedorNotaFiscal: TfrmFornecedorNotaFiscal;

implementation

{$R *.dfm}

procedure TfrmFornecedorNotaFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
