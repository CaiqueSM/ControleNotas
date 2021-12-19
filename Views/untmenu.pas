unit UntMenu;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  untmenucontroller, UntEnvironment, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.ImgList, System.ImageList;

type

  { TfrmMenu }

  TfrmMenu = class(TForm)
    mainMenu: TMainMenu;
    itemConsulta: TMenuItem;
    itemConsultaNotas: TMenuItem;
    itemCadastro: TMenuItem;
    itemUsuario: TMenuItem;
    itemRelatorio: TMenuItem;
    itemRelatorioMensal: TMenuItem;
    itemNota: TMenuItem;
    itemRelatorioPeriodo: TMenuItem;
    itemCliente: TMenuItem;
    itemFornecedor: TMenuItem;
    pnlTopo: TPanel;
    stbControleNotas: TStatusBar;
    ListaImagens: TImageList;
    itemSair: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure itemConsultaNotasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure itemRelatorioMensalClick(Sender: TObject);
    procedure itemUsuarioClick(Sender: TObject);
    procedure itemNotaClick(Sender: TObject);
    procedure itemClienteClick(Sender: TObject);
    procedure itemFornercedorClick(Sender: TObject);
    procedure itemSairClick(Sender: TObject);
    procedure itemRelatorioPeriodoClick(Sender: TObject);
  private
    FController: TMenuController;
    procedure Logar();
    procedure configurarStatusBar();
    function GetTamanhoPanel(AIndexPanel: Integer): Integer;
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  untConsultarNotas, UntUsuario, UntCliente,
  untRelatorioPeriodo, untRelatorioMensal,
  untFornecedor, untCadastrarNota;

{$R *.dfm}
{ TfrmMenu }

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FController := TMenuController.Create();
  Logar();
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  pnlTopo.Width := Screen.Width;
  configurarStatusBar();
end;

procedure TfrmMenu.Logar();
begin
  if not FController.Logar() then
  Begin
    Close();
    Application.Terminate;
  End;
end;

procedure TfrmMenu.itemClienteClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmCliente, frmCliente);
end;

procedure TfrmMenu.itemFornercedorClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmFornecedor, frmFornecedor);
end;

procedure TfrmMenu.itemNotaClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmCadastrarNota, frmCadastrarNota);
end;

procedure TfrmMenu.itemConsultaNotasClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmConsultarNotas, frmConsultarNotas);
end;

procedure TfrmMenu.itemRelatorioMensalClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmRelatorioMensal, frmRelatorioMensal);
end;

procedure TfrmMenu.itemRelatorioPeriodoClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmRelatorioPeriodo, frmRelatorioPeriodo);
end;

procedure TfrmMenu.itemSairClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmMenu.itemUsuarioClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmUsuario, frmUsuario);
end;

procedure TfrmMenu.configurarStatusBar;
var
  usuario: Integer;
begin
  usuario := 0;
  stbControleNotas.Panels[usuario].Text :=
    Format(' Usuário: %s ', [Global.usuario]);
  stbControleNotas.Panels[usuario].Width := GetTamanhoPanel(usuario);
end;

function TfrmMenu.GetTamanhoPanel(AIndexPanel: Integer): Integer;
var
  texto: String;
  offset: Integer;
begin
  stbControleNotas.Canvas.Font := stbControleNotas.Font;
  texto := stbControleNotas.Panels[AIndexPanel].Text;
  offset := 10;

  Result := stbControleNotas.Canvas.TextWidth(texto) + offset;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

end.
