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
    lbControle: TLabel;
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
    lbcodigo: TLabel;
    txtCodigo: TEdit;
    txtCNPJCPFfornecedor: TEdit;
    txtCNPJCPFCliente: TEdit;
    lbCNPJCPFfornecedor: TLabel;
    lbCNPJCPFcliente: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FNotasExistente: Boolean;
    FController: TNotasController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure selecionarNotas(Sender: TObject);

    function serializeNotas(): TNotasModel;
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
  FNotasExistente := False;
  If txtCodigo.CanFocus Then
    txtCodigo.SetFocus;
end;

procedure TfrmCadastrarNota.btnGravarClick(Sender: TObject);
begin
  If validarCampos(todosCampos) Then
  Begin
    If FNotasExistente Then
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

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadastrarNota.FormCreate(Sender: TObject);
begin
  FController := TNotasController.Create();
end;

procedure TfrmCadastrarNota.FormShow(Sender: TObject);
begin
  HabilitarCampos(False);
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
  txtCNPJCPFNotas.Clear;
  txtCNPJCPFfornecedor.Clear;
  memoDescricao.Clear;
end;

procedure TfrmCadastrarNota.selecionarNotas(Sender: TObject);
begin

end;

function TfrmCadastrarNota.serializeNotas: TNotasModel;
begin

end;

function TfrmCadastrarNota.validarCampos(ACampo: TObject): Boolean;
begin

end;

end.
