unit UntCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntNotasModel, UntNotasController,
  UntEnvironment, UntClienteController, UntFornecedorController,
  UntUsuarioController, UntMensagemUtil,
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
    mskEmissao: TMaskEdit;
    lbEmitido: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure txtChaveAcessoExit(Sender: TObject);
    procedure mskValorExit(Sender: TObject);
    procedure txtCNPJCPFfornecedorExit(Sender: TObject);
    procedure txtCNPJCPFclienteExit(Sender: TObject);
  private
    FNotasExistente: Boolean;
    FController: TNotasController;
    procedure LimparCampos();
    procedure HabilitarCampos(AHabilitar: Boolean);
    procedure selecionarNotas(Sender: TObject);
    function formatarValor(AValor: string): string;
    function serializeNotas(): TNotasModel;
    function validarCampos(ACampo: TObject): Boolean;
    function atualizarDados(AOperacao: TEnumCRUD): Boolean;
  end;

var
  frmCadastrarNota: TfrmCadastrarNota;

implementation

{$R *.dfm}

function TfrmCadastrarNota.atualizarDados(AOperacao: TEnumCRUD): Boolean;
var
  Notas: TNotasModel;
begin
  Result := True;

  Try
    Case AOperacao Of
      actConsultar:
        Begin
          Try
            Notas := FController.Consultar(strTOint(txtCodigo.Text));
            FNotasExistente := Not Notas.Chave.IsEmpty;

            if not Notas.Chave.IsEmpty then
              txtChaveAcesso.Text := Notas.Chave;

            if Notas.Controle <> 0 then
              txtControle.Text := intTOstr(Notas.Controle);

            if Notas.Valor <> 0 then
              mskValor.Text := FloatToStr(Notas.Valor);

            if Notas.Emissao <> 0 then
              mskEmissao.Text := dateTOstr(Notas.Emissao);

            If Not Notas.Cliente.CPF.IsEmpty Then
              txtCNPJCPFCliente.Text := Notas.Cliente.CPF
            Else
              txtCNPJCPFCliente.Text := Notas.Cliente.CNPJ;

            If Not Notas.Fornecedor.CNPJ.IsEmpty Then
              txtCNPJCPFfornecedor.Text := Notas.Fornecedor.CNPJ
            Else
              txtCNPJCPFfornecedor.Text := Notas.Fornecedor.CPF;

            if not Notas.Descricao.IsEmpty then
              memoDescricao.Text := Notas.Descricao;
          Except
            Result := False;
          End;
        End;

      actCriar:
        Begin
          Notas := serializeNotas();
          if Notas.Cliente.Nome.IsEmpty then
          begin
            MensagemNaoCadastrado('Cliente');
            Result := False;
            Exit();
          end;

          if Notas.Fornecedor.Nome.IsEmpty then
          begin
            MensagemNaoCadastrado('Fornecedor');
            Result := False;
            Exit();
          end;

          Result := FController.Criar(Notas);
        End;

      actAlterar:
        Begin
          Notas := serializeNotas();
          Result := FController.Alterar(Notas);
        End;

      actExcluir:
        Begin
          Result := FController.Excluir(strTOint(txtCodigo.Text));
        End;
    End;
  Finally
    If Assigned(Notas) Then
      Notas.Free;
  End;
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

function TfrmCadastrarNota.formatarValor(AValor: string): string;
var
  parteInteira, parteFracionaria: string;
begin
  parteInteira := Copy(AValor, 1, length(AValor) - 2);
  parteFracionaria := Copy(AValor, length(AValor) - 1, length(AValor));
  Result := parteInteira + ',' + parteFracionaria;
end;

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
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
  tbuPesquisar.Enabled := Not AHabilitar;
  txtCodigo.Enabled := Not AHabilitar;
  tbuExcluir.Enabled := AHabilitar;
  btnCancelar.Enabled := AHabilitar;
  btnGravar.Enabled := AHabilitar;
  txtChaveAcesso.Enabled := AHabilitar;
  txtControle.Enabled := AHabilitar;
  mskValor.Enabled := AHabilitar;
  mskEmissao.Enabled := AHabilitar;
  txtCNPJCPFCliente.Enabled := AHabilitar;
  txtCNPJCPFfornecedor.Enabled := AHabilitar;
  memoDescricao.Enabled := AHabilitar;
end;

procedure TfrmCadastrarNota.LimparCampos;
begin
  txtCodigo.Clear;
  txtChaveAcesso.Clear;
  txtControle.Clear;
  mskValor.Clear;
  mskEmissao.Clear;
  txtCNPJCPFCliente.Clear;
  txtCNPJCPFfornecedor.Clear;
  memoDescricao.Clear;
end;

procedure TfrmCadastrarNota.selecionarNotas(Sender: TObject);
begin
  If validarCampos(Sender) Then
    If atualizarDados(actConsultar) Then
    Begin
      HabilitarCampos(True);
      txtCodigo.Enabled := FNotasExistente;
      Self.TabOrderNext();
    End;
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
  Result.Id := strTOint(txtCodigo.Text);
  Result.Chave := txtChaveAcesso.Text;
  Result.Controle := strTOint(txtControle.Text);
  Result.Valor := strTOFloat(mskValor.Text);
  Result.Emissao := strTOdate(mskEmissao.Text);
  Result.Descricao := memoDescricao.Text;
  Result.Usuario := Usuario.Consultar(Global.Usuario);
  Result.Cliente := Cliente.Consultar(txtCNPJCPFCliente.Text);
  Result.Fornecedor := Fornecedor.Consultar(txtCNPJCPFfornecedor.Text);
end;

procedure TfrmCadastrarNota.mskValorExit(Sender: TObject);
begin
  if not(mskValor.Text = EmptyStr) then
  begin
    validarCampos(Sender);
    mskValor.Text := formatarValor(mskValor.Text);
  end;
end;

procedure TfrmCadastrarNota.txtChaveAcessoExit(Sender: TObject);
begin
  if not(txtChaveAcesso.Text = EmptyStr) then
    validarCampos(Sender);
end;

procedure TfrmCadastrarNota.txtCNPJCPFclienteExit(Sender: TObject);
begin
  if not(txtCNPJCPFCliente.Text = EmptyStr) then
    validarCampos(Sender);
end;

procedure TfrmCadastrarNota.txtCNPJCPFfornecedorExit(Sender: TObject);
begin
  if not(txtCNPJCPFfornecedor.Text = EmptyStr) then
    validarCampos(Sender);
end;

procedure TfrmCadastrarNota.txtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = BotaoEnter Then
    selecionarNotas(Sender);
end;

function TfrmCadastrarNota.validarCampos(ACampo: TObject): Boolean;
var
PadraoData: string;
begin
  PadraoData:= 'dd/mm/aaaa';
  Result := False;

  if txtCodigo.Text = EmptyStr then
  begin
    ShowMessage('O campo código deve ser preenchido!');
    txtCodigo.Enabled := True;
    If txtCodigo.CanFocus Then
      txtCodigo.SetFocus;
    Exit();
  end;

  if (mskValor = ACampo) or (mskValor = todosCampos) then
    if not FController.ValidarValor(mskValor.Text) then
    begin
      ShowMessage('O campo valor não pode ser nulo.');
      if mskValor.CanFocus then
        mskValor.SetFocus;
      Exit();
    end;

  if (mskEmissao.Text = PadraoData) and (not txtCodigo.Enabled) then
  begin
    ShowMessage('Informe a data de emissão!');
    If mskEmissao.CanFocus Then
      mskEmissao.SetFocus;
    Exit();
  end;

  if (txtChaveAcesso = ACampo) or (txtChaveAcesso = todosCampos) then
    if not FController.ValidarChaveAcesso(txtChaveAcesso.Text) then
    begin
      ShowMessage('Chave inválida.');
      if txtChaveAcesso.CanFocus then
        txtChaveAcesso.SetFocus;
      Exit();
    end;

  if (txtCNPJCPFCliente = ACampo) or (txtCNPJCPFCliente = todosCampos) then
    if not FController.ValidarNumeroPessoal(txtCNPJCPFCliente.Text) then
    begin
      ShowMessage('CNPJ ou CPF inválido.');
      if txtCNPJCPFCliente.CanFocus then
        txtCNPJCPFCliente.SetFocus;
      Exit();
    end;
  if (txtCNPJCPFfornecedor = ACampo) or (txtCNPJCPFfornecedor = todosCampos)
  then
    if not FController.ValidarNumeroPessoal(txtCNPJCPFfornecedor.Text) then
    begin
      ShowMessage('CNPJ inválido.');
      if txtCNPJCPFfornecedor.CanFocus then
        txtCNPJCPFfornecedor.SetFocus;
      Exit();
    end;

  Result := True;
end;

end.
