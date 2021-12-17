unit untRelatorioPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ZDataset, UntRelatorioImpresso,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  UntRelatorioModel, UntRelatorioPeriodoController, UntEnvironment, Data.DB,
  Vcl.Grids, Vcl.DBGrids{, UntControleNotasDataModule};

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
    DBResultado: TDBGrid;
    btnImprimir: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure mskInicioExit(Sender: TObject);
    procedure mskTerminoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    Fcontroller: TRelatorioPeriodoController;
    function serializarRelatorio: TRelatorioModel;
    function validarCampos(ACampo: TObject): boolean;
    function gerarRelatorio(ARelatorio: TRelatorioModel): TZQuery;
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
var
  Relatorio: TRelatorioModel;
  Query: TZQuery;
begin
  if validarCampos(todosCampos) then
  begin
    Relatorio := serializarRelatorio();
    Query := gerarRelatorio(Relatorio);
    DBResultado.DataSource := TDataSource.Create(self);
    DBResultado.DataSource.DataSet := Query;
    Query.Open;
  end;
end;

procedure TfrmRelatorioPeriodo.btnImprimirClick(Sender: TObject);
var
  Relatorio: TRelatorioModel;
  Query: TZQuery;
begin
  if validarCampos(todosCampos) then
  begin
    Relatorio := serializarRelatorio();
    Query := gerarRelatorio(Relatorio);
    frmRelatorioImpresso := TfrmRelatorioImpresso.Create(self);
    frmRelatorioImpresso.Query := Query;
    frmRelatorioImpresso.lbPeriodo.Caption := mskInicio.Text + ' até ' +
      mskTermino.Text;
    frmRelatorioImpresso.FormShow(self);
  end;
end;

procedure TfrmRelatorioPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmRelatorioImpresso.free;
  Fcontroller.Free;
  Action := caFree;
end;

procedure TfrmRelatorioPeriodo.FormCreate(Sender: TObject);
begin
  Fcontroller := TRelatorioPeriodoController.Create;
end;

procedure TfrmRelatorioPeriodo.FormShow(Sender: TObject);
begin
  if rgRelatorio.CanFocus then
    rgRelatorio.SetFocus;
end;

function TfrmRelatorioPeriodo.gerarRelatorio(ARelatorio
  : TRelatorioModel): TZQuery;
begin
  if ARelatorio.Tipo = 'Clientes' then
    Result := Fcontroller.CriarRelatorioCliente(ARelatorio)
  else if ARelatorio.Tipo = 'Fornecedores' then
    Result := Fcontroller.CriarRelatorioFornecedor(ARelatorio)
  else
    Result := Fcontroller.CriarRelatorioNotas(ARelatorio);
end;

procedure TfrmRelatorioPeriodo.limparCampos;
begin
  rgRelatorio.ItemIndex := -1;
  rgOrdenar.ItemIndex := -1;
  mskInicio.Text := 'dd/mm/aaaa';
  mskTermino.Text := 'dd/mm/aaaa';
  DBResultado.DataSource.DataSet.Close;
end;

procedure TfrmRelatorioPeriodo.mskInicioExit(Sender: TObject);
var
  padrao: string;
begin
  padrao := 'dd/mm/aaaa';
  if not(mskInicio.Text = padrao) then
    validarCampos(Sender);
end;

procedure TfrmRelatorioPeriodo.mskTerminoExit(Sender: TObject);
var
  padrao: string;
begin
  padrao := 'dd/mm/aaaa';
  if not(mskTermino.Text = padrao) then
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
var
  padrao: string;
begin
  padrao := 'dd/mm/aaaa';
  Result := False;

  if (mskInicio = ACampo) or (ACampo = todosCampos) then
  begin
    if not(mskInicio.Text = padrao) then
    begin
      if not Fcontroller.ValidarData(strTOdate(mskInicio.Text)) then
      begin
        ShowMessage('Data inicial invalida.');
        if mskInicio.CanFocus then
          mskInicio.SetFocus;
        Exit();
      end;
    end
    else
      ShowMessage('A data inicial não pode estar vazia.');
  end;

  if (mskTermino = ACampo) or (ACampo = todosCampos) then
  begin
    if not(mskTermino.Text = padrao) then
    begin
      if not Fcontroller.ValidarData(strTOdate(mskTermino.Text)) then
      begin
        ShowMessage('Data final invalida.');
        if mskTermino.CanFocus then
          mskTermino.SetFocus;
        Exit();
      end;
    end
    else
      ShowMessage('A data final não pode estar vazia.');
  end;

  if (mskInicio.Text <> padrao) and (mskTermino.Text <> padrao) then
    if not(strTOdate(mskInicio.Text) <= strTOdate(mskTermino.Text)) then
      ShowMessage('A data final de ser maior que a data inicial.');

  if (rgRelatorio = ACampo) or (ACampo = todosCampos) then
  begin
    if rgRelatorio.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um relatório.');
      if rgRelatorio.CanFocus then
        rgRelatorio.SetFocus;
      Exit();
    end;
  end;

  if (rgOrdenar = ACampo) or (ACampo = todosCampos) then
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
