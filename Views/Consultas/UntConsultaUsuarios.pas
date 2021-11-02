unit UntConsultaUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids;

type
  TFrmConsultaUsuarios = class(TForm)
    DbgUsuarios: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FResultado: String;
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
   FResultado := EmptyStr;
   Action := caFree;
end;

end.
