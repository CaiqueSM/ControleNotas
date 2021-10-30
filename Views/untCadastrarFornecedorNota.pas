unit untCadastrarFornecedorNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmFornecedorNotaFiscal = class(TForm)
    gbInfoFornecedor: TGroupBox;
    txtCPFCNPJ: TEdit;
    txtNomeFornecedor: TEdit;
    lbCNPJCPF: TLabel;
    lbNomeFornecedor: TLabel;
    gbContatoFornecedor: TGroupBox;
    txtCEP: TEdit;
    txtRua: TEdit;
    txtEmail: TEdit;
    txtBairro: TEdit;
    txtNumero: TEdit;
    txtTelefone: TEdit;
    lbCEP: TLabel;
    lbRua: TLabel;
    lbEmail: TLabel;
    lbBairro: TLabel;
    lbNumero: TLabel;
    lbTelefone: TLabel;
    btnGravar: TButton;
    btnCancelar: TButton;
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
 Action:= caFree;
end;

end.
