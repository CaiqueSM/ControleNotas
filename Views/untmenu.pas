unit UntMenu;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  untmenucontroller, UntEnvironment, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls;

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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure itemConsultaNotasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure itemRelatorioMensalClick(Sender: TObject);
    procedure itemUsuarioClick(Sender: TObject);
    procedure itemNotaClick(Sender: TObject);
    procedure itemClienteClick(Sender: TObject);
    procedure itemFornercedorClick(Sender: TObject);
  private
    FController: TMenuController;
    procedure Logar();
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  untConsultarNotas, untCadastrarUsuario, untCadastrarClienteNota,
  untGerarRelatorio,
  untCadastrarFornecedorNota, untCadastrarNota;

{$R *.dfm}
{ TfrmMenu }

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FController := TMenuController.Create();
  Logar();
  stbControleNotas.SimpleText:= 'Bem vindo!'+FormatDateTime('hh:mm:ss',now);
  stbControleNotas.Width:= Screen.Width;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  pnlTopo.Width := Screen.Width;
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
  FController.AbrirTelaFilha(Self, TfrmClienteNotaFiscal, frmClienteNotaFiscal);
end;

procedure TfrmMenu.itemFornercedorClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmFornecedorNotaFiscal,
    frmFornecedorNotaFiscal);
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
  FController.AbrirTelaFilha(Self, TfrmGerarRelatorio, frmGerarRelatorio);
end;

procedure TfrmMenu.itemUsuarioClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmCadastrarUsuario, frmCadastrarUsuario);
end;

procedure TfrmMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

end.
