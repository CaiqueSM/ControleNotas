unit UntRelatorioImpresso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
    lbControle: TRLLabel;
    lbValor: TRLLabel;
    lbFornecedor: TRLLabel;
    lbCliente: TRLLabel;
    lbEmissao: TRLLabel;
    DataSetRelatorio: TZQuery;
    colunaChave: TRLDBText;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioImpresso: TfrmRelatorioImpresso;

implementation

{$R *.dfm}

procedure TfrmRelatorioImpresso.FormCreate(Sender: TObject);
begin
  colunaChave.DataSource := DataSetRelatorio.DataSource;
  colunaChave.DataField := DataSetRelatorio.DataSetField.FieldValues[0];
end;

end.
