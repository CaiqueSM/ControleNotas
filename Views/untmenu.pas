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
    itemArquivo: TMenuItem;
    itemUsuario: TMenuItem;
    pnlTopo: TPanel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure itemConsultaNotasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: TMenuController;
    procedure Logar();
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  consulta_notas;

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

procedure TfrmMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

end.

