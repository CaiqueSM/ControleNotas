unit untGerarRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmGerarRelatorio = class(TForm)
    btnCancelar: TButton;
    txtGerar: TButton;
    gbPeriodo: TGroupBox;
    lbDataInicio: TLabel;
    lbDataTermino: TLabel;
    rgRelatorio: TRadioGroup;
    rgOrdenar: TRadioGroup;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGerarRelatorio: TfrmGerarRelatorio;

implementation

{$R *.dfm}

procedure TfrmGerarRelatorio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
