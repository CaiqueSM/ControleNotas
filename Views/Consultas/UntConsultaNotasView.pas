unit UntConsultaNotasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, untenvironment,
  UntConsultaNotasController;

type
  TFrmConsultaNotasView = class(TForm)
    gridNotasView: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridNotasViewKeyPress(Sender: TObject; var Key: Char);
    procedure gridNotasViewDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FResultado: String;
    FController: TConsultaNotasController;
    procedure carregarDados();
  public
    property Resultado: String Read FResultado;
  end;

var
  FrmConsultaNotasView: TFrmConsultaNotasView;

implementation

{$R *.dfm}

procedure TFrmConsultaNotasView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TFrmConsultaNotasView.FormCreate(Sender: TObject);
begin
  FController := TConsultaNotasController.Create();
end;

procedure TFrmConsultaNotasView.FormShow(Sender: TObject);
begin
  carregarDados();
end;

procedure TFrmConsultaNotasView.gridNotasViewDblClick(Sender: TObject);
var
  linha: Integer;
begin
  linha := gridNotasView.Row;
  FResultado := gridNotasView.Rows[linha].Text;
  Close();
end;

procedure TFrmConsultaNotasView.gridNotasViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Key = BotaoEnter) Then
    gridNotasViewDblClick(Sender);
end;

procedure TFrmConsultaNotasView.carregarDados;
var
  chavesNotasView: TStringList;
  chave: String;
  coluna, linha: Integer;
  tamanhoCaracter: Integer;
begin
  tamanhoCaracter := 8;
  coluna := 0;
  chavesNotasView := FController.ListarNotas();
  if chavesNotasView = nil then
  begin
    ShowMessage('Não há notas cadastradas.');
    exit();
  end;
  gridNotasView.DefaultColWidth := length(chavesNotasView[0]) * tamanhoCaracter;
  Try
    linha := 0;
    for chave in chavesNotasView do
    begin
      gridNotasView.Cells[coluna, linha] := chave;
      linha := linha + 1;
      gridNotasView.RowCount := linha;
    end;
  Finally
    chavesNotasView.Free;
  End;
end;

end.
