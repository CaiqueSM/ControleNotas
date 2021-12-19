unit UntRelatorioMensal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, UntRelatorioMensalModel, UntRelatorioNotas,
  UntRelatorioPessoas, ZDataSet, UntEnvironment, UntRelatorioMensalController;

type
  TfrmRelatorioMensal = class(TForm)
    btnCancelar: TButton;
    btnGerar: TButton;
    btnImprimir: TButton;
    rgOrdenar: TRadioGroup;
    rgRelatorio: TRadioGroup;
    gbResultado: TGroupBox;
    DBResultado: TDBGrid;
    gbPeriodo: TGroupBox;
    cbMeses: TComboBox;
    lbMes: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    Fcontroller: TRelatorioMensalController;
    function serializarRelatorio: TRelatorioMensalModel;
    function validarCampos(ACampo: TObject): boolean;
    function gerarRelatorio(ARelatorio: TRelatorioMensalModel): TZQuery;
    procedure limparCampos();
  end;

var
  frmRelatorioMensal: TfrmRelatorioMensal;

implementation

{$R *.dfm}

procedure TfrmRelatorioMensal.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
end;

procedure TfrmRelatorioMensal.btnGerarClick(Sender: TObject);
var
  Relatorio: TRelatorioMensalModel;
  Query: TZQuery;
begin
  if validarCampos(todosCampos) then
  begin
    Relatorio := serializarRelatorio();
    Query := gerarRelatorio(Relatorio);
    DBResultado.DataSource := TDataSource.Create(self);
    DBResultado.DataSource.DataSet := Query;
    DBResultado.DataSource.DataSet.Open;
  end;

  if Assigned(Relatorio) then
    Relatorio.Free;
end;

procedure TfrmRelatorioMensal.btnImprimirClick(Sender: TObject);
var
  Relatorio: TRelatorioMensalModel;
  Query: TZQuery;
begin
  if validarCampos(todosCampos) then
  begin
    Relatorio := serializarRelatorio();
    Query := gerarRelatorio(Relatorio);
    if Relatorio.Tipo = 'Notas fiscais' then
    begin
      frmRelatorioNotas := TfrmRelatorioNotas.Create(self);
      frmRelatorioNotas.Query := Query;
      frmRelatorioNotas.lbPeriodo.Caption := 'Mês de ' +
      cbMeses.items[cbMeses.ItemIndex];
      frmRelatorioNotas.FormShow(self);
    end
    else
    begin
      frmRelatorioPessoas := TfrmRelatorioPessoas.Create(self);
      frmRelatorioPessoas.Caption := 'Relatório de ' + Relatorio.Tipo +
        ' por mês.';
      frmRelatorioPessoas.lbPeriodo.Caption := 'Mês de ' +
      cbMeses.items[cbMeses.ItemIndex];
      frmRelatorioPessoas.lbCabecalhoRelatorio.Caption := 'Relatório ' +
        Relatorio.Tipo;
      frmRelatorioPessoas.lbTituloRelatorio.Caption := 'Relatório de ' +
        Relatorio.Tipo + ' por mês.';
      frmRelatorioPessoas.Query := Query;
      frmRelatorioPessoas.FormShow(self);
    end;
  end;

  if Assigned(Relatorio) then
    Relatorio.Free;
end;

procedure TfrmRelatorioMensal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  limparCampos();
  DBResultado.Free;

  if Assigned(frmRelatorioNotas) then
  begin
    frmRelatorioNotas.Close();
    frmRelatorioNotas.Free;
  end;

  if Assigned(frmRelatorioPessoas) then
  begin
    frmRelatorioPessoas.Close();
    frmRelatorioPessoas.Free;
  end;

  Fcontroller.Free;
  Action := caFree;
end;

procedure TfrmRelatorioMensal.FormCreate(Sender: TObject);
begin
  Fcontroller := TRelatorioMensalController.Create;
end;

procedure TfrmRelatorioMensal.FormShow(Sender: TObject);
begin
  if rgRelatorio.CanFocus then
    rgRelatorio.SetFocus;
end;

function TfrmRelatorioMensal.gerarRelatorio(ARelatorio
  : TRelatorioMensalModel): TZQuery;
begin
  if ARelatorio.Tipo = 'Clientes' then
    Result := Fcontroller.CriarRelatorioCliente(ARelatorio)
  else if ARelatorio.Tipo = 'Fornecedores' then
    Result := Fcontroller.CriarRelatorioFornecedor(ARelatorio)
  else
    Result := Fcontroller.CriarRelatorioNotas(ARelatorio);
end;

procedure TfrmRelatorioMensal.limparCampos;
begin
  rgRelatorio.ItemIndex := -1;
  rgOrdenar.ItemIndex := -1;
  cbMeses.ItemIndex := -1;
  if DBResultado.DataSource <> nil then
    DBResultado.DataSource.DataSet.Close;
end;

function TfrmRelatorioMensal.serializarRelatorio: TRelatorioMensalModel;
begin
  Result := TRelatorioMensalModel.Create;
  Result.IdUsuario := Global.IdUsuario;
  Result.Tipo := rgRelatorio.Items[rgRelatorio.ItemIndex];
  Result.Ordem := rgOrdenar.Items[rgOrdenar.ItemIndex];
  Result.Mes := cbMeses.itemIndex + 1;
end;

function TfrmRelatorioMensal.validarCampos(ACampo: TObject): boolean;
begin
  Result := False;

  if (cbMeses = ACampo) or (ACampo = todosCampos) then
  begin
    if cbMeses.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um mês.');
      if cbMeses.CanFocus then
        cbMeses.SetFocus;
      Exit();
    end;
  end;

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
