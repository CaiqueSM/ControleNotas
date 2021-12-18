unit UntRelatorioPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  RLReport, ZDataSet, Data.DB, Datasnap.Provider;

type
  TfrmRelatorioPessoas = class(TForm)
    rlrPessoas: TRLReport;
    btCabecalho: TRLBand;
    lbData: TRLSystemInfo;
    lbHora: TRLSystemInfo;
    lbCabecalhoRelatorio: TRLLabel;
    btColuna: TRLBand;
    lbNome: TRLLabel;
    lbCEP: TRLLabel;
    lbCidade: TRLLabel;
    lbBairro: TRLLabel;
    lbRua: TRLLabel;
    lbCPFCNPJ: TRLLabel;
    btConteudo: TRLBand;
    clNome: TRLDBText;
    clTelefone: TRLDBText;
    clBairro: TRLDBText;
    clRua: TRLDBText;
    clEmail: TRLDBText;
    clNumero: TRLDBText;
    btRodape: TRLBand;
    btTitulo: TRLBand;
    lbTituloRelatorio: TRLLabel;
    lbPeriodo: TRLLabel;
    lbNumero: TRLLabel;
    lbComplemento: TRLLabel;
    lbEmail: TRLLabel;
    lbTelefone: TRLLabel;
    clCPFCNPJ: TRLDBText;
    clCEP: TRLDBText;
    clCidade: TRLDBText;
    clComplemento: TRLDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    dpsControleNotas: TDataSetProvider;
    dsControleNotas: TDataSource;
    dsQuery: TZQuery;
    procedure CheckDataSet(ADataSet: TZQuery);
  public
    property Query: TZQuery read dsQuery write CheckDataSet;
  end;

var
  frmRelatorioPessoas: TfrmRelatorioPessoas;

implementation

{$R *.dfm}
{ TfrmRelatorioPessoas }

procedure TfrmRelatorioPessoas.CheckDataSet(ADataSet: TZQuery);
begin
  if ADataSet <> nil then
    dsQuery := ADataSet
  else
    Close();
end;

procedure TfrmRelatorioPessoas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  rlrPessoas.ClosePreview;
  btCabecalho.Free;
  lbData.Free;
  lbHora.Free;
  lbCabecalhoRelatorio.Free;
  btColuna.Free;
  lbNome.Free;
  lbCEP.Free;
  lbCidade.Free;
  lbBairro.Free;
  lbRua.Free;
  lbCPFCNPJ.Free;
  btConteudo.Free;
  clNome.Free;
  clTelefone.Free;
  clBairro.Free;
  clRua.Free;
  clEmail.Free;
  clNumero.Free;
  btRodape.Free;
  btTitulo.Free;
  lbTituloRelatorio.Free;
  lbPeriodo.Free;
  lbNumero.Free;
  lbComplemento.Free;
  lbEmail.Free;
  lbTelefone.Free;
  clCPFCNPJ.Free;
  clCEP.Free;
  clCidade.Free;
  clComplemento.Free;
  rlrPessoas.Free;
  dpsControleNotas.Free;
  dsControleNotas.Free;
  dsQuery.Free;
  Action := caFree;
end;

procedure TfrmRelatorioPessoas.FormCreate(Sender: TObject);
begin
  dpsControleNotas := TDataSetProvider.Create(self);
  dsControleNotas := TDataSource.Create(self);
  dsQuery := TZQuery.Create(self);
end;

procedure TfrmRelatorioPessoas.FormShow(Sender: TObject);
begin
  dpsControleNotas.DataSet := dsQuery;
  dsControleNotas.DataSet := dsQuery;
  rlrPessoas.DataSource := dsControleNotas;

  clNome.DataSource := dsControleNotas;
  clNome.DataField := 'Nome';

  clCPFCNPJ.DataSource := dsControleNotas;
  clCPFCNPJ.DataField := 'CPF/CNPJ';

  clBairro.DataSource := dsControleNotas;
  clBairro.DataField := 'Bairro';

  clCEP.DataSource := dsControleNotas;
  clCEP.DataField := 'CEP';

  clRua.DataSource := dsControleNotas;
  clRua.DataField := 'Rua';

  clCidade.DataSource := dsControleNotas;
  clCidade.DataField := 'Cidade';

  clNumero.DataSource := dsControleNotas;
  clNumero.DataField := 'Número';

  clEmail.DataSource := dsControleNotas;
  clEmail.DataField := 'E-Mail';

  clTelefone.DataSource := dsControleNotas;
  clTelefone.DataField := 'Telefone';

  clComplemento.DataSource := dsControleNotas;
  clComplemento.DataField := 'Complemento';

  dpsControleNotas.DataSet.Open;
  rlrPessoas.Preview();
end;

end.
