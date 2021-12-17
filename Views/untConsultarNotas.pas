unit untConsultarNotas;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Vcl.Grids,
  Vcl.DBGrids, UntNotasController, UntMensagemUtil;

type

  { TfrmNotas }

  TfrmConsultarNotas = class(TForm)
    txtChaveAcesso: TEdit;
    grpConsulta: TGroupBox;
    btnCancelar: TButton;
    btnConsultar: TButton;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FController: TNotasController;
    function validar(): Boolean;
    procedure limparCampos();
    procedure habilitarCampos(AHabilitar: Boolean);
  end;

var
  frmConsultarNotas: TfrmConsultarNotas;

implementation

{$R *.dfm}
{ TfrmNotas }

procedure TfrmConsultarNotas.btnCancelarClick(Sender: TObject);
begin
  limparCampos();
end;

procedure TfrmConsultarNotas.btnConsultarClick(Sender: TObject);
begin
  if validar() then
  begin
    habilitarCampos(True);
  end;
end;

procedure TfrmConsultarNotas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

procedure TfrmConsultarNotas.FormCreate(Sender: TObject);
begin
  FController := TNotasController.Create;
end;

procedure TfrmConsultarNotas.habilitarCampos(AHabilitar: Boolean);
begin
  grpConsulta.Enabled := AHabilitar;
  btnCancelar.Enabled := AHabilitar;
  btnConsultar.Enabled := AHabilitar;
end;

procedure TfrmConsultarNotas.limparCampos;
begin
  txtChaveAcesso.Clear;
end;

function TfrmConsultarNotas.validar: Boolean;
var
  tamanhoChaveAcesso: Integer;
begin
  Result := false;

  if (Trim(txtChaveAcesso.Text) = EmptyStr) then
  begin
    ShowMessage('Favor preencher o campo de chave de acesso!');
    if txtChaveAcesso.CanFocus then
      txtChaveAcesso.SetFocus;
    Exit();
  end;

  tamanhoChaveAcesso := txtChaveAcesso.MaxLength;
  if (Length(Trim(txtChaveAcesso.Text)) <> tamanhoChaveAcesso) then
  begin
    ShowMessage('Chave de acesso inválida!');
    if txtChaveAcesso.CanFocus then
      txtChaveAcesso.SetFocus;
    Exit();
  end;

  if FController.ValidarChaveAcesso(txtChaveAcesso.Text) then
  begin
    if FController.ChaveExiste(txtChaveAcesso.Text) then
    begin
      MensagemNotaExiste(txtChaveAcesso.Text);
      Exit();
    end
    else
      MensagemNotaNaoExiste(txtChaveAcesso.Text);
  end
  else
  begin
    MensagemChaveInvalida(txtChaveAcesso.Text);
    Exit();
  end;

  Result := true;
end;

end.
