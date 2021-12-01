unit UntCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntNotasModel, UntNotasController,
  UntEnvironment, UntClienteController, UntFornecedorController,
  UntUsuarioController,
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
    lbCNPJfornecedor: TLabel;
    lbCNPJCPFcliente: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskValorChange(Sender: TObject);
    procedure txtChaveAcessoExit(Sender: TObject);
    procedure txtCNPJCPFclienteExit(Sender: TObject);
    procedure txtCNPJCPFfornecedorExit(Sender: TObject);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
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
  txtCNPJCPFCliente.Clear;
  txtCNPJCPFfornecedor.Clear;
  memoDescricao.Clear;
end;

procedure TfrmCadastrarNota.selecionarNotas(Sender: TObject);
begin

end;

function TfrmCadastrarNota.serializeNotas: TNotasModel;
var
  Usuario: TUsuarioController;
  Cliente: TClienteController;
  Fornecedor: TFornecedorController;
begin
  Usuario := TUsuarioController.Create;
  Cliente := TClienteController.Create;
  Fornecedor := TFornecedorController.Create;

  Result := TNotasModel.Create;
  Result.Chave := txtChaveAcesso.Text;
  Result.Controle := strTOint(txtControle.Text);
  Result.Valor := strTOFloat(mskValor.Text);
  Result.Descricao := memoDescricao.Text;
  Result.Usuario := Usuario.Consultar(Global.Usuario);
  Result.Cliente := Cliente.Consultar(txtCNPJCPFCliente.Text);
  Result.Fornecedor := Fornecedor.Consultar(txtCNPJCPFfornecedor.Text);
end;

procedure TfrmCadastrarNota.mskValorChange(Sender: TObject);
begin
  if not FController.ValidarValor(mskValor.Text) then
  begin
    ShowMessage('O campo valor não pode ser nulo.');
    if mskValor.CanFocus then
      mskValor.SetFocus;
  end;
end;

procedure TfrmCadastrarNota.txtChaveAcessoExit(Sender: TObject);
begin
  if not FController.ValidarChaveAcesso(txtChaveAcesso.Text) then
  begin
    ShowMessage('Chave inválida.');
    if txtChaveAcesso.CanFocus then
      txtChaveAcesso.SetFocus;
  end;
end;

procedure TfrmCadastrarNota.txtCNPJCPFclienteExit(Sender: TObject);
begin
  if not FController.ValidarNumeroPessoal(txtCNPJCPFCliente.Text) then
  begin
    ShowMessage('CNPJ ou CPF inválido.');
    if txtCNPJCPFCliente.CanFocus then
      txtCNPJCPFCliente.SetFocus;
  end;
end;

procedure TfrmCadastrarNota.txtCNPJCPFfornecedorExit(Sender: TObject);
begin
  if not FController.ValidarNumeroPessoal(txtCNPJCPFfornecedor.Text) then
  begin
    ShowMessage('CNPJ inválido.');
    if txtCNPJCPFfornecedor.CanFocus then
      txtCNPJCPFfornecedor.SetFocus;
  end;
end;

procedure TfrmCadastrarNota.txtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = BotaoEnter Then
    selecionarNotas(Sender)
end;

function TfrmCadastrarNota.validarCampos(ACampo: TObject): Boolean;
begin

end;

end.
