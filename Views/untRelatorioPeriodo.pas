unit untRelatorioPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ZDataset, UntRelatorioNotas,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  UntRelatorioModel, UntRelatorioPeriodoController, UntEnvironment, Data.DB,
  Vcl.Grids, Vcl.DBGrids, UntRelatorioPessoas;

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

  if Assigned(Relatorio) then
    Relatorio.Free;
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
    if Relatorio.Tipo = 'Notas fiscais' then
    begin
      frmRelatorioNotas := TfrmRelatorioNotas.Create(self);
      frmRelatorioNotas.Query := Query;
      frmRelatorioNotas.lbPeriodo.Caption := mskInicio.Text + ' at� ' +
        mskTermino.Text;
      frmRelatorioNotas.FormShow(self);
    end
    else begin
      frmRelatorioPessoas := TfrmRelatorioPessoas.Create(self);
      frmRelatorioPessoas.Caption := 'Relat�rio de '+ Relatorio.Tipo +
      ' por per�odo.';
      frmRelatorioPessoas.lbPeriodo.Caption := mskInicio.Text + ' at� ' +
      mskTermino.Text;
      frmRelatorioPessoas.lbCabecalhoRelatorio.Caption:= 'Relat�rio ' +
      Relatorio.Tipo;
      frmRelatorioPessoas.lbTituloRelatorio.Caption := 'Relat�rio de '+
      Relatorio.Tipo + ' por per�odo.';
      frmRelatorioPessoas.Query := Query;
      frmRelatorioPessoas.FormShow(self);
    end;
  end;

  if Assigned(Relatorio) then
    Relatorio.Free;
end;

procedure TfrmRelatorioPeriodo.FormClose(Sender: TObject;
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
  if DBResultado.DataSource <> nil then
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
      if not Fcontroller.ValidarData(mskInicio.Text) then
      begin
        ShowMessage('Data inicial invalida.');
        if mskInicio.CanFocus then
          mskInicio.SetFocus;
        Exit();
      end;
    end
    else
    begin
      ShowMessage('A data inicial n�o pode estar vazia.');
      Exit();
    end;
  end;

  if (mskTermino = ACampo) or (ACampo = todosCampos) then
  begin
    if not(mskTermino.Text = padrao) then
    begin
      if not Fcontroller.ValidarData(mskTermino.Text) then
      begin
        ShowMessage('Data final invalida.');
        if mskTermino.CanFocus then
          mskTermino.SetFocus;
        Exit();
      end;
    end
    else
    begin
      ShowMessage('A data final n�o pode estar vazia.');
      Exit();
    end;
  end;

  if (mskInicio.Text <> padrao) and (mskTermino.Text <> padrao) then
    if not(strTOdate(mskInicio.Text) <= strTOdate(mskTermino.Text)) then
      ShowMessage('A data final de ser maior que a data inicial.');

  if (rgRelatorio = ACampo) or (ACampo = todosCampos) then
  begin
    if rgRelatorio.ItemIndex = -1 then
    begin
      ShowMessage('Selecione um relat�rio.');
      if rgRelatorio.CanFocus then
        rgRelatorio.SetFocus;
      Exit();
    end;
  end;

  if (rgOrdenar = ACampo) or (ACampo = todosCampos) then
  begin
    if rgOrdenar.ItemIndex = -1 then
    begin
      ShowMessage('Defina a oredem de ordena��o dos dados.');
      if rgOrdenar.CanFocus then
        rgOrdenar.SetFocus;
      Exit();
    end;
  end;

  Result := True;
end;

end.
