unit UntMensagemUtil;

interface

uses
  Vcl.Dialogs, Vcl.Controls;

function ShowConfirm(AMensagem: String): Boolean;
procedure MensagemNaoCadastrado(ANome: string);
procedure MensagemNotaExiste(AChave: String);
procedure MensagemNotaNaoExiste(AChave: String);
procedure MensagemChaveInvalida(AChave: string);

implementation

function ShowConfirm(AMensagem: String): Boolean;
begin
  Result := MessageDlg(AMensagem, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure MensagemNaoCadastrado(ANome: string);
begin
  ShowMessage(ANome + ' n�o cadastrado! Por favor realize o cadastro de ' +
    ANome + ' depois volte a esta tela.');
end;

procedure MensagemNotaExiste(AChave: String);
begin
  ShowMessage('Nota fiscal com chave de acesso: '+ AChave + ' j� existe no sistema.');
end;

procedure MensagemNotaNaoExiste(AChave: String);
begin
  ShowMessage('Nota fiscal com chave de acesso: '+ AChave + ' habilitada para uso.');
end;

procedure MensagemChaveInvalida(AChave: string);
begin
  ShowMessage('A Chave ' + AChave + ' � inv�lida.');
end;

end.
