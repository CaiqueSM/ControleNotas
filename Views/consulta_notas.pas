unit consulta_notas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmNotas }

  TfrmNotas = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmNotas: TfrmNotas;

implementation

{$R *.lfm}

{ TfrmNotas }

procedure TfrmNotas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

