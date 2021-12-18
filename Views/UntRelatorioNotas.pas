unit UntRelatorioNotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Datasnap.Provider,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmRelatorioNotas = class(TForm)
    rlrNotas: TRLReport;
    btCabecalho: TRLBand;
    btTitulo: TRLBand;
    btColuna: TRLBand;
    btConteudo: TRLBand;
    btRodape: TRLBand;
    lbData: TRLSystemInfo;
    lbHora: TRLSystemInfo;
    lbCabecalhoRelatorio: TRLLabel;
    lbTituloRelatorio: TRLLabel;
    lbPeriodo: TRLLabel;
    lbChaveAcesso: TRLLabel;
    lbValor: TRLLabel;
    lbFornecedor: TRLLabel;
    lbCliente: TRLLabel;
    lbEmissao: TRLLabel;
    colunaChave: TRLDBText;
    colunaEmissao: TRLDBText;
    colunaCliente: TRLDBText;
    colunaControle: TRLDBText;
    lbControle: TRLLabel;
    colunaFornecedor: TRLDBText;
    colunaValor: TRLDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rlrNotasBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    dpsControleNotas: TDataSetProvider;
    dsControleNotas: TDataSource;
    dsQuery: TZQuery;
    procedure CheckDataSet(ADataSet: TZQuery);
  public
    property Query: TZQuery read dsQuery write CheckDataSet;
  end;

var
  frmRelatorioNotas: TfrmRelatorioNotas;

implementation

{$R *.dfm}

procedure TfrmRelatorioNotas.CheckDataSet(ADataSet: TZQuery);
begin
  if ADataSet <> nil then
    dsQuery := ADataSet
  else
    Close();
end;

procedure TfrmRelatorioNotas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  rlrNotas.ClosePreview;
  btCabecalho.Free;
  btTitulo.Free;
  btColuna.Free;
  btConteudo.Free;
  btRodape.Free;
  lbData.Free;
  lbHora.Free;
  lbCabecalhoRelatorio.Free;
  lbTituloRelatorio.Free;
  lbPeriodo.Free;
  lbChaveAcesso.Free;
  lbValor.Free;
  lbFornecedor.Free;
  lbCliente.Free;
  lbEmissao.Free;
  colunaChave.Free;
  colunaEmissao.Free;
  colunaCliente.Free;
  colunaControle.Free;
  lbControle.Free;
  colunaFornecedor.Free;
  colunaValor.Free;
  dpsControleNotas.Free;
  dsControleNotas.Free;
  dsQuery.Free;
  rlrNotas.Free;
  Action := caFree;
end;

procedure TfrmRelatorioNotas.FormCreate(Sender: TObject);
begin
  dpsControleNotas := TDataSetProvider.Create(self);
  dsControleNotas := TDataSource.Create(self);
  dsQuery := TZQuery.Create(self);
end;

procedure TfrmRelatorioNotas.FormShow(Sender: TObject);
begin
  dpsControleNotas.DataSet := dsQuery;
  dsControleNotas.DataSet := dsQuery;
  rlrNotas.DataSource := dsControleNotas;

  colunaChave.DataSource := dsControleNotas;
  colunaChave.DataField := 'Chave acesso';

  colunaControle.DataSource := dsControleNotas;
  colunaControle.DataField := 'Controle';

  colunaValor.DataSource := dsControleNotas;
  colunaValor.DataField := 'Valor(R$)';

  colunaFornecedor.DataSource := dsControleNotas;
  colunaFornecedor.DataField := 'CPF/CNPJ Fornecedor';

  colunaCliente.DataSource := dsControleNotas;
  colunaCliente.DataField := 'CPF/CNPJ Cliente';

  colunaEmissao.DataSource := dsControleNotas;
  colunaEmissao.DataField := 'Emissão';

  dpsControleNotas.DataSet.Open;
  rlrNotas.Preview();
end;

procedure TfrmRelatorioNotas.rlrNotasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  dpsControleNotas.DataSet.Open;
end;

end.
