unit consulta_notas;

interface

uses
   Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Vcl.Grids,
   Vcl.DBGrids;

type

   { TfrmNotas }

   TfrmNotas = class(TForm)
      txtChaveAcesso: TEdit;
      grpConsulta: TGroupBox;
      Label1: TLabel;
      btnCancelar: TButton;
      btnConsultar: TButton;
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
      procedure btnCancelarClick(Sender: TObject);
      procedure btnConsultarClick(Sender: TObject);
   private
      function validar(): Boolean;
      procedure limparCampos();
      procedure habilitar(AHabilitar: Boolean);
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

procedure TfrmNotas.btnConsultarClick(Sender: TObject);
begin
   if validar() then
   begin
      habilitar(false);
   end;
end;

procedure TfrmNotas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   CloseAction := caFree;
end;

procedure TfrmNotas.habilitar(AHabilitar: Boolean);
begin
   grpConsulta.Enabled := AHabilitar;
   btnCancelar.Enabled := AHabilitar;
   btnConsultar.Enabled := AHabilitar;
end;

procedure TfrmNotas.limparCampos;
begin
   txtChaveAcesso.Clear;
end;

function TfrmNotas.validar: Boolean;
var
   tamanhoChaveAcesso: Integer;
begin
   Result := false;

   if (Trim(txtChaveAcesso.Text) = EmptyStr) then
   begin
      ShowMessage('Favor preencher o campo de chave de acesso!');
      if txtChaveAcesso.CanFocus then txtChaveAcesso.SetFocus;
      Exit();
   end;

   tamanhoChaveAcesso := txtChaveAcesso.MaxLength;
   if (Length(Trim(txtChaveAcesso.Text)) <> tamanhoChaveAcesso) then
   begin
      ShowMessage('Chave de acesso inválida!');
      if txtChaveAcesso.CanFocus then txtChaveAcesso.SetFocus;
      Exit();
   end;

   Result := true;
end;

end.
