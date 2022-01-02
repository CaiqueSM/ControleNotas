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
    procedure DimensionarGrid(dbg: TDBGrid);
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
    Query.Open;
    if Query.IsEmpty then
    begin
      ShowMessage('Nenhum resultado encontrado.');
      Query.Close;
      Query.Free;
      exit();
    end;
    DBResultado.DataSource := TDataSource.Create(self);
    DBResultado.DataSource.DataSet := Query;
    DBResultado.DataSource.DataSet.Open;
    DimensionarGrid(DBResultado);
  end
  else
    exit();

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
    Query.Open;
    if Query.IsEmpty then
    begin
      ShowMessage('Nenhum resultado encontrado.');
      Query.Close;
      Query.Free;
      exit();
    end;
    if Relatorio.Tipo = 'Notas fiscais' then
    begin
      frmRelatorioNotas := TfrmRelatorioNotas.Create(self);
      frmRelatorioNotas.Query := Query;
      frmRelatorioNotas.lbPeriodo.Caption := 'Mês de ' + cbMeses.items
        [cbMeses.ItemIndex];
      frmRelatorioNotas.FormShow(self);
    end
    else
    begin
      frmRelatorioPessoas := TfrmRelatorioPessoas.Create(self);
      frmRelatorioPessoas.Caption := 'Relatório de ' + Relatorio.Tipo +
        ' por mês.';
      frmRelatorioPessoas.lbPeriodo.Caption := 'Mês de ' + cbMeses.items
        [cbMeses.ItemIndex];
      frmRelatorioPessoas.lbCabecalhoRelatorio.Caption := 'Relatório ' +
        Relatorio.Tipo;
      frmRelatorioPessoas.lbTituloRelatorio.Caption := 'Relatório de ' +
        Relatorio.Tipo + ' por mês.';
      frmRelatorioPessoas.Query := Query;
      frmRelatorioPessoas.FormShow(self);
    end;
  end
  else
    exit();

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
  Result.Tipo := rgRelatorio.items[rgRelatorio.ItemIndex];
  Result.Ordem := rgOrdenar.items[rgOrdenar.ItemIndex];
  Result.Mes := cbMeses.ItemIndex + 1;
end;

function TfrmRelatorioMensal.validarCampos(ACampo: TObject): boolean;
begin
  Result := False;

  if (rgRelatorio = ACampo) or (ACampo = todosCampos) then
  begin
    if rgRelatorio.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um relatório.');
      if rgRelatorio.CanFocus then
        rgRelatorio.SetFocus;
      exit();
    end;
  end;

  if (rgOrdenar = ACampo) or (ACampo = todosCampos) then
  begin
    if rgOrdenar.ItemIndex = -1 then
    begin
      ShowMessage('Defina a ordenação dos dados.');
      if rgOrdenar.CanFocus then
        rgOrdenar.SetFocus;
      exit();
    end;
  end;

  if (cbMeses = ACampo) or (ACampo = todosCampos) then
  begin
    if cbMeses.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um mês.');
      if cbMeses.CanFocus then
        cbMeses.SetFocus;
      exit();
    end;
  end;

  Result := True;
end;

procedure TfrmRelatorioMensal.DimensionarGrid(dbg: TDBGrid);
var
  j: integer;
  s: string;
begin
  for j := 1 to dbg.Columns.Count - 1 do
  begin
    s := dbg.DataSource.DataSet.Fields[j].AsString;
    dbg.Columns[j].width := dbg.Canvas.TextWidth(s) * 2;
  end;
end;

end.
