unit UntMenu;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  untmenucontroller, UntEnvironment, Vcl.ExtCtrls;

type

  { TfrmMenu }

  TfrmMenu = class(TForm)
    mainMenu: TMainMenu;
    itemConsulta: TMenuItem;
    itemConsultaNotas: TMenuItem;
    itemCadastro: TMenuItem;
    itemUsuario: TMenuItem;
    pnlTopo: TPanel;
    itemNotaFiscal: TMenuItem;
    itemRelatorio: TMenuItem;
    itemGerarRelatorio: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure itemConsultaNotasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure itemGerarRelatorioClick(Sender: TObject);
    procedure itemNotaFiscalClick(Sender: TObject);
    procedure itemUsuarioClick(Sender: TObject);
  private
    FController: TMenuController;
    procedure Logar();
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  consulta_notas, untCadastrarUsuario, untCadastrarClienteNota, untGerarRelatorio;

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
end;

procedure TfrmMenu.Logar();
begin
  if not FController.Logar() then
    Application.Terminate;
end;

procedure TfrmMenu.itemConsultaNotasClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmNotas, frmNotas);
end;

procedure TfrmMenu.itemGerarRelatorioClick(Sender: TObject);
begin
 FController.AbrirTelaFilha(Self, TfrmGerarRelatorio, frmGerarRelatorio);
end;

procedure TfrmMenu.itemNotaFiscalClick(Sender: TObject);
begin
 FController.AbrirTelaFilha(Self, TfrmClienteNotaFiscal, frmClienteNotaFiscal);
end;

procedure TfrmMenu.itemUsuarioClick(Sender: TObject);
begin
  FController.AbrirTelaFilha(Self, TfrmCadUsuario, frmCadUsuario);
end;

procedure TfrmMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

end.

