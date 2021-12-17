unit UntControleNotasDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Datasnap.Provider,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TDMControleNotas = class(TDataModule)
    dsControleNotas: TDataSource;
    dspControleNotas: TDataSetProvider;
    dsQuery: TZQuery;
    zConexao: TZConnection;
    dsQueryid: TIntegerField;
    dsQueryidCliente: TIntegerField;
    dsQueryidFornecedor: TIntegerField;
    dsQueryidUsuario: TIntegerField;
    dsQuerychaveacesso: TWideStringField;
    dsQuerycontrole: TIntegerField;
    dsQuerydescricao: TWideStringField;
    dsQueryemissao: TDateField;
    dsQueryvalor: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMControleNotas: TDMControleNotas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}


end.
