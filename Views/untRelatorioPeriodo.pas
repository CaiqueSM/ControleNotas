unit untRelatorioPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ZDataset, UntRelatorioImpresso,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  UntRelatorioModel, UntRelatorioPeriodoController, UntEnvironment;

type
  TfrmRelatorioPeriodo = class(TForm)
    btnCancelar: TButton;
    btnGerar: TButton;
    gbPeriodo: TGroupBox;
    lbDataInicio: TLabel;
    lbDataTermino: TLabel;
    rgRelatorio: TRadioGroup;
    rgOrdenar: TRadioGroup;
    mskInicio: TMaskEdit;
    mskTermino: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure mskInicioExit(Sender: TObject);
    procedure mskTerminoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    Fcontroller: TRelatorioPeriodoController;
    function serializarRelatorio: TRelatorioModel;
    function validarCampos(ACampo: TObject): boolean;
    function gerarRelatorio(): TZQuery;
    procedure limparCampos();
  end;

var
  frmRelatorioPeriodo: TfrmRelatorioPeriodo;

implementation

{$R *.dfm}

procedure TfrmRelatorioPeriodo.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
end;

procedure TfrmRelatorioPeriodo.btnGerarClick(Sender: TObject);
begin
  frmRelatorioImpresso.DataSetRelatorio:= gerarRelatorio;
  frmRelatorioImpresso.rlrNotas.Preview();
end;

procedure TfrmRelatorioPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmRelatorioImpresso.Close;
  frmRelatorioImpresso.Free;
  Action := caFree;
end;

procedure TfrmRelatorioPeriodo.FormCreate(Sender: TObject);
begin
  frmRelatorioImpresso := TfrmRelatorioImpresso.Create(self);
end;

function TfrmRelatorioPeriodo.gerarRelatorio: TZQuery;
var
  Relatorio: TRelatorioModel;
begin
  if validarCampos(todosCampos) then
  begin
    Relatorio := serializarRelatorio();
    if Relatorio.Tipo = 'Clientes' then
      Result := Fcontroller.CriarRelatorioCliente(Relatorio)
    else if Relatorio.Tipo = 'Fornecedores' then
      Result := Fcontroller.CriarRelatorioFornecedor(Relatorio)
    else
      Result := Fcontroller.CriarRelatorioNotas(Relatorio);
  end;
end;

procedure TfrmRelatorioPeriodo.limparCampos;
begin
  rgRelatorio.ItemIndex := -1;
  rgOrdenar.ItemIndex := -1;
  mskInicio.Clear;
  mskTermino.Clear;
end;

procedure TfrmRelatorioPeriodo.mskInicioExit(Sender: TObject);
begin
  if not(mskInicio.Text = EmptyStr) then
    validarCampos(Sender);
end;

procedure TfrmRelatorioPeriodo.mskTerminoExit(Sender: TObject);
begin
  if not(mskTermino.Text = EmptyStr) then
    validarCampos(Sender);
end;

function TfrmRelatorioPeriodo.serializarRelatorio: TRelatorioModel;
begin
  Result := TRelatorioModel.Create;
  Result.IdUsuario := Global.IdUsuario;
  Result.Tipo := rgRelatorio.Items[rgRelatorio.ItemIndex];
  Result.Ordem := rgOrdenar.Items[rgOrdenar.ItemIndex];
  Result.DataInicio := strTOdate(mskInicio.Text);
  Result.DataTermino := strTOdate(mskTermino.Text);
end;

function TfrmRelatorioPeriodo.validarCampos(ACampo: TObject): boolean;
begin
  Result := False;

  if (mskInicio = ACampo) or (mskInicio = todosCampos) then
  begin
    if not(mskInicio.Text = EmptyStr) then
      if not Fcontroller.ValidarData(strTOdate(mskInicio.Text)) then
      begin
        ShowMessage('Data inicial invalida.');
        if mskInicio.CanFocus then
          mskInicio.SetFocus;
        Exit();
      end
      else
        ShowMessage('A data inicial não pode estar vazia.');
  end;

  if (mskTermino = ACampo) or (mskTermino = todosCampos) then
  begin
    if not(mskTermino.Text = EmptyStr) then
      if not Fcontroller.ValidarData(strTOdate(mskTermino.Text)) then
      begin
        ShowMessage('Data final invalida.');
        if mskTermino.CanFocus then
          mskTermino.SetFocus;
        Exit();
      end
      else
        ShowMessage('A data final não pode estar vazia.');
  end;

  if (rgRelatorio = ACampo) or (rgRelatorio = todosCampos) then
  begin
    if rgRelatorio.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um relatório.');
      if rgRelatorio.CanFocus then
        rgRelatorio.SetFocus;
      Exit();
    end;
  end;

  if (rgOrdenar = ACampo) or (rgOrdenar = todosCampos) then
  begin
    if rgOrdenar.ItemIndex = -1 then
    begin
      ShowMessage('Defina a oredem de ordenação dos dados.');
      if rgOrdenar.CanFocus then
        rgOrdenar.SetFocus;
      Exit();
    end;
  end;

  Result := True;
end;

end.
