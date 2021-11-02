unit UntMensagemUtil;

interface

uses
  Vcl.Dialogs, Vcl.Controls;

  function ShowConfirm(AMensagem: String): Boolean;

implementation

function ShowConfirm(AMensagem: String): Boolean;
begin
   Result := MessageDlg(AMensagem, mtConfirmation, [mbYes, mbNo],0) = mrYes;
end;

end.
