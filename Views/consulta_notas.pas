unit consulta_notas;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmNotas }

  TfrmNotas = class(TForm)
    btnConsultar: TButton;
    btnCancelar: TButton;
    txtChaveAcesso: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure limparCampos();
  end;

var
  frmNotas: TfrmNotas;

implementation

{$R *.dfm}

{ TfrmNotas }

procedure TfrmNotas.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
end;

procedure TfrmNotas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

procedure TfrmNotas.limparCampos;
begin
  txtChaveAcesso.Clear;
end;

end.

