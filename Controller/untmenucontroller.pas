unit UntMenuController;

interface

uses
  Classes, SysUtils, Forms, Controls, Windows, UntEnvironment,
  untLogin;

type

  { TMenuController }

  TMenuController = class
  private
    function FormExiste(InstanceClass: TFormClass): boolean;
  public
    procedure AbrirTelaFilha(MainForm: TForm; ClassRef: TFormClass; var Form);
    function Logar(): boolean;
  end;

implementation

{ TMenuController }

function TMenuController.FormExiste(InstanceClass: TFormClass): boolean;
var
  I: integer;
begin
  with (Application.MainForm) do
    for I := 0 to MDIChildCount - 1 do
      if (MDIChildren[I] is InstanceClass) then
      begin
        Result := True;
        Exit;
      end;
  Result := False;
end;

procedure TMenuController.AbrirTelaFilha(MainForm: TForm; ClassRef: TFormClass;
  var Form);
begin
  If FormExiste(ClassRef) Then
  Begin
    TForm(Form).Show;
    TForm(Form).WindowState := wsNormal;
  End
  Else
  Begin
    TForm(Form) := TFormClass(ClassRef).Create(MainForm);
    With TForm(Form) Do
    Begin
      FormStyle := fsMDIChild;
      Left := 0;
      Top := 0;
    End;
  End;
end;

function TMenuController.Logar(): boolean;
var
  telaLogin: TfrmLogin;
begin
  telaLogin := TfrmLogin.Create(nil);
  try
    telaLogin.ShowModal();
    Result := not Global.Usuario.IsEmpty;
  finally
    telaLogin.Free;
  end;
end;

end.
