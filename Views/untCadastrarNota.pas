unit untCadastrarNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
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
    // procedure formatField(Sender: TObject);
  private

  public

  end;

var
  frmCadastrarNota: TfrmCadastrarNota;

implementation

{$R *.dfm}
{ procedure TfrmCadastrarNota.formatField(Sender: TObject);
  var
  parteInteira, parteDecimal, valor: string;

  begin
  valor:= Trim(txtValor.text);
  parteDecimal:= valor[length(valor)-2]+valor[length(valor)-1];

  end; }

procedure TfrmCadastrarNota.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
