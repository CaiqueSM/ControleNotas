unit UntCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntNotasModel, UntNotasController,
  UntEnvironment,
  UntCrudEnum, UntFormHelper, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask;

type
  TfrmCadastrarNota = class(TForm)
    gbInfoNota: TGroupBox;
    lbChaveAcesso: TLabel;
    txtChaveAcesso: TEdit;
    txtControle: TEdit;
    lbCodigo: TLabel;
    lbValor: TLabel;
    gbDescricao: TGroupBox;
    memoDescricao: TMemo;
    btnGravar: TButton;
    btnCancelar: TButton;
    tobTop: TToolBar;
    tbuPesquisar: TToolButton;
    tbuExcluir: TToolButton;
    mskValor: TMaskEdit;
    gbCodigoFornecedor: TGroupBox;
    lblcodigo: TLabel;
    txtCodigo: TEdit;
    txtCNPJCPFfornecedor: TEdit;
    txtCNPJCPFcliente: TEdit;
    lbCNPJCPF: TLabel;
    lblCNPJCPFcliente: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
  private
    FClienteExistente: Boolean;
    FController: TNotasController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure selecionarCliente(Sender: TObject);

    function serializeCliente(): TNotasModel;
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmCadastrarNota: TfrmCadastrarNota;

implementation

{$R *.dfm}

function TfrmCadastrarNota.atualizarDados(AOperacao: TEnumCRUD): Boolean;
begin

end;

procedure TfrmCadastrarNota.btnCancelarClick(Sender: TObject);
begin
  LimparCampos();
  HabilitarCampos(False);
  FClienteExistente := False;
  If txtCodigo.CanFocus Then
    txtCodigo.SetFocus;
end;

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadastrarNota.HabilitarCampos(AHabilitar: Boolean);
begin

end;

procedure TfrmCadastrarNota.LimparCampos;
begin
  txtCodigo.Clear;
  txtChaveAcesso.Clear;
  txtControle.Clear;
  mskValor.Clear;
  txtCNPJCPFcliente.Clear;
  txtCNPJCPFfornecedor.Clear;
  memoDescricao.Clear;
end;

procedure TfrmCadastrarNota.selecionarCliente(Sender: TObject);
begin

end;

function TfrmCadastrarNota.serializeCliente: TNotasModel;
begin

end;

function TfrmCadastrarNota.validarCampos(ACampo: TObject): Boolean;
begin

end;

end.
