unit UntCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Mask;

type
  TfrmCadastrarNota = class(TForm)
    gbInfoNota: TGroupBox;
    lbChaveAcesso: TLabel;
    txtChaveAcesso: TEdit;
    txtCodigo: TEdit;
    lbCodigo: TLabel;
    lbValor: TLabel;
    gbDescricao: TGroupBox;
    menoDescricao: TMemo;
    btnGravar: TButton;
    btnCancelar: TButton;
    tobTop: TToolBar;
    tbuPesquisar: TToolButton;
    tbuExcluir: TToolButton;
    mskValor: TMaskEdit;
    gbCodigoFornecedor: TGroupBox;
    lblcodigo: TLabel;
    Edit1: TEdit;
    txtCNPJCPFfornecedor: TEdit;
    txtCNPJCPFcliente: TEdit;
    lbCNPJCPF: TLabel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frmCadastrarNota: TfrmCadastrarNota;

implementation

{$R *.dfm}

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
