unit UntConsultaClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, untenvironment,
  UntConsultarClienteController;

type
  TFrmConsultaClienteView = class(TForm)
    gridClienteView: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridClienteViewKeyPress(Sender: TObject; var Key: Char);
    procedure gridClienteViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FResultado: String;
    FController: TConsultaClienteController;
    procedure carregarDados();
  public
    property Resultado: String Read FResultado;
  end;

var
  FrmConsultaClienteView: TFrmConsultaClienteView;

implementation

{$R *.dfm}

procedure TFrmConsultaClienteView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TFrmConsultaClienteView.FormCreate(Sender: TObject);
begin
  FController := TConsultaClienteController.Create();
end;

procedure TFrmConsultaClienteView.FormShow(Sender: TObject);
begin
  carregarDados();
end;

procedure TFrmConsultaClienteView.gridClienteViewDblClick(Sender: TObject);
var
  linha: Integer;
begin
  linha := gridClienteView.Row;
  FResultado := gridClienteView.Rows[linha].Text;
  Close();
end;

procedure TFrmConsultaClienteView.gridClienteViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Key = BotaoEnter) Then
    gridClienteViewDblClick(Sender);
end;

procedure TFrmConsultaClienteView.carregarDados;
var
  nomesClienteView: TStringList;
  nome: String;
  coluna, linha: Integer;
begin
  coluna := 0;
  nomesClienteView := FController.ListarNomesClientes();
  if nomesClienteView = nil then
  begin
    ShowMessage('Não há clientes cadastrados.');
    exit();
  end;
  Try
    linha := 0;
    for nome in nomesClienteView do
    begin
      gridClienteView.Cells[coluna, linha] := nome;
      linha := linha + 1;
      gridClienteView.RowCount := linha;
    end;
  Finally
    nomesClienteView.Free;
  End;
end;

end.
