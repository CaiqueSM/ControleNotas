unit UntMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  untmenucontroller;

type

  { TfrmMenu }

  TfrmMenu = class(TForm)
    mainMenu: TMainMenu;
    itemConsulta: TMenuItem;
    itemConsultaNotas: TMenuItem;
    itemArquivo: TMenuItem;
    itemUsuario: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure itemConsultaNotasClick(Sender: TObject);
  private
    FController: TMenuController;
  public

  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  consulta_notas;

{$R *.lfm}

{ TfrmMenu }

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  FController := TMenuController.Create();
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

