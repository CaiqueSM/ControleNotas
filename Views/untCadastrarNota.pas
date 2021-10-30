unit untCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCadastrarNota = class(TForm)
    gbInfoNota: TGroupBox;
    lbChaveAcesso: TLabel;
    txtChaveAcesso: TEdit;
    txtCodigo: TEdit;
    lbCodigo: TLabel;
    txtValor: TEdit;
    lbValor: TLabel;
    gbDescricao: TGroupBox;
    menoDescricao: TMemo;
    btnGravar: TButton;
    btnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastrarNota: TfrmCadastrarNota;

implementation

{$R *.dfm}

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:= caFree;
end;

end.
