unit UntMensagemUtil;

interface

uses
  Vcl.Dialogs, Vcl.Controls;

function ShowConfirm(AMensagem: String): Boolean;
procedure MensagemNaoCadastrado(ANome: string);

implementation

function ShowConfirm(AMensagem: String): Boolean;
begin
  Result := MessageDlg(AMensagem, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure MensagemNaoCadastrado(ANome: string);
begin
  ShowMessage(ANome + ' não cadastrado! Por favor realize o cadastro de ' +
    ANome + ' depois volte a esta tela.');
end;

end.
