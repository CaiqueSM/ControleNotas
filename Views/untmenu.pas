unit UntMenu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, untmenucontroller;

type

  { TFrmMenu }

  TFrmMenu = class(TForm)
    mainMenu: TMainMenu;
    itemConsulta: TMenuItem;
    itemConsultaNotas: TMenuItem;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FController: TMenuController;
  public

  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.lfm}

{ TFrmMenu }

procedure TFrmMenu.FormCreate(Sender: TObject);
begin
  FController := TMenuController.Create();
end;

procedure TFrmMenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

end.

