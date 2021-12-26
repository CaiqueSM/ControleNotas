unit UntConsultaClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, untenvironment,
  UntConsultarClienteController;

type

  TResultado = record
    Text: string;
    Index: integer;
  end;

  TFrmConsultaClienteView = class(TForm)
    gridClienteView: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridClienteViewKeyPress(Sender: TObject; var Key: Char);
    procedure gridClienteViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FResultado: TResultado;
    FController: TConsultaClienteController;
    procedure carregarDados();
  public
    property Resultado: TResultado Read FResultado;
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
  linha: integer;
begin
  linha := gridClienteView.Row;
  FResultado.Text := gridClienteView.Rows[linha].Text;
  FResultado.Index := FController.ListaID[linha];
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
  coluna, linha: integer;
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
