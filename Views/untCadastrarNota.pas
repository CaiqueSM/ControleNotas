unit UntCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntNotasModel, UntNotasController,
  UntEnvironment, UntClienteController, UntFornecedorController,
  UntUsuarioController, UntMensagemUtil, UntConsultaNotas,
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
    gbCodigoFornecedor: TGroupBox;
    lbcodigo: TLabel;
    txtCodigo: TEdit;
    txtCNPJCPFfornecedor: TEdit;
    txtCNPJCPFCliente: TEdit;
    lbCNPJfornecedor: TLabel;
    lbCNPJCPFcliente: TLabel;
    mskEmissao: TMaskEdit;
    lbEmitido: TLabel;
    txtValor: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure txtChaveAcessoExit(Sender: TObject);
    procedure txtValorExit(Sender: TObject);
    procedure txtCNPJCPFfornecedorExit(Sender: TObject);
    procedure txtCNPJCPFclienteExit(Sender: TObject);
    procedure tbuPesquisarClick(Sender: TObject);
    procedure tbuExcluirClick(Sender: TObject);
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
            if txtCodigo.Text = EmptyStr then
              Notas := FController.Consultar(txtChaveAcesso.Text)
            else
              Notas := FController.Consultar(StrToInt(txtCodigo.Text));
            FNotasExistente := Not Notas.Chave.IsEmpty;

            txtCodigo.Text := intTOstr(Notas.Id);

            if not Notas.Chave.IsEmpty then
              txtChaveAcesso.Text := Notas.Chave;

            if Notas.Controle <> 0 then
              txtControle.Text := intTOstr(Notas.Controle);

            if Notas.Valor <> 0 then
              txtValor.Text := FloatToStr(Notas.Valor);

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

          if FController.ChaveExiste(Notas.Chave) then
          begin
            MensagemNotaExiste(Notas.Chave);
            txtChaveAcesso.Clear;
            Exit();
          end;

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
          Result := FController.Excluir(StrToInt(txtCodigo.Text));
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
  i, j: integer;
begin
  Trim(AValor);
  for i := 1 to length(AValor) - 2 do
    if CharInSet(AValor[i], ['0' .. '9']) then
      parteInteira := parteInteira + AValor[i];
  for j := length(AValor) - 1 to length(AValor) do
    if CharInSet(AValor[j], ['0' .. '9']) then
      parteFracionaria := parteFracionaria + AValor[j];
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
  txtValor.Enabled := AHabilitar;
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
  txtValor.Clear;
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
  Result.Id := StrToInt(txtCodigo.Text);
  Result.Chave := txtChaveAcesso.Text;
  Result.Controle := StrToInt(txtControle.Text);
  Result.Valor := strTOFloat(txtValor.Text);
  Result.Emissao := strTOdate(mskEmissao.Text);
  Result.Descricao := memoDescricao.Text;
  Result.Usuario := Usuario.Consultar(Global.Usuario);
  Result.Cliente := Cliente.Consultar(txtCNPJCPFCliente.Text);
  Result.Fornecedor := Fornecedor.Consultar(txtCNPJCPFfornecedor.Text);
end;

procedure TfrmCadastrarNota.txtValorExit(Sender: TObject);
begin
  if not(txtValor.Text = EmptyStr) then
  begin
    validarCampos(Sender);
    txtValor.Text := formatarValor(txtValor.Text);
  end;
end;

procedure TfrmCadastrarNota.tbuExcluirClick(Sender: TObject);
begin
  If ShowConfirm('Tem certeza que deseja excluir esta nota?') Then
    If atualizarDados(actExcluir) Then
      btnCancelarClick(Sender);
end;

procedure TfrmCadastrarNota.tbuPesquisarClick(Sender: TObject);
var
  nota: String;
begin
  nota := TConsultaNotas.ConsultarNotas();
  If (Not nota.IsEmpty) Then
  Begin
    txtChaveAcesso.Text := Trim(nota);
    selecionarNotas(txtChaveAcesso);
    txtCodigo.Enabled := False;
  End
  Else If txtChaveAcesso.CanFocus Then
    txtChaveAcesso.SetFocus;
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
  PadraoData := 'dd/mm/aaaa';
  Result := False;

  if (txtCodigo = ACampo) or (txtCodigo = todosCampos) then
    if txtCodigo.Text = EmptyStr then
    begin
      ShowMessage('O campo código deve ser preenchido!');
      txtCodigo.Enabled := True;
      If txtCodigo.CanFocus Then
        txtCodigo.SetFocus;
      Exit();
    end;

  if (txtValor = ACampo) or (txtValor = todosCampos) then
    if not FController.ValidarValor(txtValor.Text) then
    begin
      ShowMessage('O campo valor não pode ser nulo.');
      if txtValor.CanFocus then
        txtValor.SetFocus;
      Exit();
    end;

  if (mskEmissao = ACampo) or (mskEmissao = todosCampos) then
    if (mskEmissao.Text = PadraoData) or (mskEmissao.Text = EmptyStr) then
    begin
      ShowMessage('Informe a data de emissão!');
      If mskEmissao.CanFocus Then
        mskEmissao.SetFocus;
      Exit();
    end;

  if (txtChaveAcesso = ACampo) or (txtChaveAcesso = todosCampos) then
  begin
    if not FController.ValidarChaveAcesso(txtChaveAcesso.Text) then
    begin
      ShowMessage('Chave inválida.');
      if txtChaveAcesso.CanFocus then
        txtChaveAcesso.SetFocus;
      Exit();
    end;
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
