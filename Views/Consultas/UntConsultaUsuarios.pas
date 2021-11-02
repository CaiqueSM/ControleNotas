unit UntConsultaUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, untenvironment,
  UntConsultaUsuarioController;

type
  TFrmConsultaUsuarios = class(TForm)
    gridUsuarios: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridUsuariosKeyPress(Sender: TObject; var Key: Char);
    procedure gridUsuariosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FResultado: String;
    FController: TConsultaUsuarioController;
    procedure carregarDados();
  public
    property Resultado: String Read FResultado;
  end;

var
  FrmConsultaUsuarios: TFrmConsultaUsuarios;

implementation

{$R *.dfm}

procedure TFrmConsultaUsuarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   FController.Free;
   Action := caFree;
end;

procedure TFrmConsultaUsuarios.FormCreate(Sender: TObject);
begin
  FController := TConsultaUsuarioController.Create();
end;

procedure TFrmConsultaUsuarios.FormShow(Sender: TObject);
begin
   carregarDados();
end;

procedure TFrmConsultaUsuarios.gridUsuariosDblClick(Sender: TObject);
var
  linha: Integer;
begin
   linha := gridUsuarios.Row;
   FResultado := gridUsuarios.Rows[linha].Text;
   Close();
end;

procedure TFrmConsultaUsuarios.gridUsuariosKeyPress(Sender: TObject;
  var Key: Char);
begin
   If (Key = BotaoEnter) Then
      gridUsuariosDblClick(Sender);
end;

procedure TFrmConsultaUsuarios.carregarDados;
var
  nomesUsuarios: TStringList;
  nome: String;
  coluna,
  linha: Integer;
begin
   coluna := 0;
   nomesUsuarios := FController.ListarNomesUsuarios();
   Try
      linha := 0;
      for nome in nomesUsuarios do
         begin
            gridUsuarios.Cells[coluna, linha] := nome;
            linha := linha + 1;
            gridUsuarios.RowCount := linha;
         end;
   Finally
      nomesUsuarios.Free;
   End;
end;

end.
