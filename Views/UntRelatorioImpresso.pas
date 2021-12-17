unit UntRelatorioImpresso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Datasnap.Provider,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmRelatorioImpresso = class(TForm)
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rlrNotasBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    dpsControleNotas: TDataSetProvider;
    dsControleNotas: TDataSource;
    dsQuery: TZQuery;
  public
    property Query: TZQuery read dsQuery write dsQuery;
  end;

var
  frmRelatorioImpresso: TfrmRelatorioImpresso;

implementation

{$R *.dfm}

procedure TfrmRelatorioImpresso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  rlrNotas.ClosePreview;
  dsControleNotas.Free;
  dsControleNotas.Free;
  dsQuery.Free;
  rlrNotas.Free;
  Action := caFree;
end;

procedure TfrmRelatorioImpresso.FormCreate(Sender: TObject);
begin
  dpsControleNotas:= TDataSetProvider.Create(self);
  dsControleNotas := TDataSource.Create(self);
  dsQuery := TZQuery.Create(self);
end;

procedure TfrmRelatorioImpresso.FormShow(Sender: TObject);
begin
  dpsControleNotas.DataSet:= dsQuery;
  dsControleNotas.DataSet:= dsQuery;
  rlrNotas.DataSource := dsControleNotas;
  colunaChave.DataSource := dsControleNotas;
  colunaChave.DataField := 'chaveacesso';
  colunaCliente.DataSource := dsControleNotas;
  colunaCliente.DataField := 'idCliente';
  dpsControleNotas.DataSet.Open;
  rlrNotas.Preview();
end;

procedure TfrmRelatorioImpresso.rlrNotasBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  dpsControleNotas.DataSet.Open;
end;

end.
