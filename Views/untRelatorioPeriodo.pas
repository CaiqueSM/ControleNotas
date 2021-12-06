unit untRelatorioPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmRelatorioPeriodo = class(TForm)
    btnCancelar: TButton;
    btnGerar: TButton;
    gbPeriodo: TGroupBox;
    lbDataInicio: TLabel;
    lbDataTermino: TLabel;
    rgRelatorio: TRadioGroup;
    rgOrdenar: TRadioGroup;
    mskInicio: TMaskEdit;
    mskTermino: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioPeriodo: TfrmRelatorioPeriodo;

implementation

{$R *.dfm}

procedure TfrmRelatorioPeriodo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
