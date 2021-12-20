unit UntConsultaFornecedorView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, untenvironment,
  UntConsultaFornecedorController;

type
  TfrmConsultaFornecedorView = class(TForm)
    gridFornecedorView: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridFornecedorViewKeyPress(Sender: TObject; var Key: Char);
    procedure gridFornecedorViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FResultado: String;
    FController: TConsultaFornecedorController;
    procedure carregarDados();
  public
    property Resultado: String Read FResultado;
  end;

var
  frmConsultaFornecedorView: TfrmConsultaFornecedorView;

implementation

{$R *.dfm}
procedure TFrmConsultaFornecedorView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TFrmConsultaFornecedorView.FormCreate(Sender: TObject);
begin
  FController := TConsultaFornecedorController.Create();
end;

procedure TFrmConsultaFornecedorView.FormShow(Sender: TObject);
begin
  carregarDados();
end;

procedure TFrmConsultaFornecedorView.gridFornecedorViewDblClick(Sender: TObject);
var
  linha: Integer;
begin
  linha := gridFornecedorView.Row;
  FResultado := gridFornecedorView.Rows[linha].Text;
  Close();
end;

procedure TFrmConsultaFornecedorView.gridFornecedorViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Key = BotaoEnter) Then
    gridFornecedorViewDblClick(Sender);
end;

procedure TFrmConsultaFornecedorView.carregarDados;
var
  nomesFornecedorView: TStringList;
  nome: String;
  coluna, linha: Integer;
begin
  coluna := 0;
  nomesFornecedorView := FController.ListarNomesFornecedores();
  if nomesFornecedorView = nil then
  begin
    ShowMessage('Não há fornecedores cadastradas.');
    exit();
  end;
  Try
    linha := 0;
    for nome in nomesFornecedorView do
    begin
      gridFornecedorView.Cells[coluna, linha] := nome;
      linha := linha + 1;
      gridFornecedorView.RowCount := linha;
    end;
  Finally
    nomesFornecedorView.Free;
  End;
end;


end.
