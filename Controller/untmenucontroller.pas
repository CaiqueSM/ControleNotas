unit UntMenuController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Windows, UntEnvironment,
  controle_notas;

type

  { TMenuController }

  TMenuController = class
  private
    function IsChildFormExist(InstanceClass: TFormClass): boolean;
  public
    procedure AbrirTelaFilha(MainForm: TForm; InstanceClass: TFormClass; var Reference);
    function Logar(): boolean;
  end;

implementation

{ TMenuController }

function TMenuController.IsChildFormExist(InstanceClass: TFormClass): boolean;
var
  I: integer;
begin
  with (Application.MainForm) do
    for I := 0 to MDIChildCount - 1 do
      if (MDIChildren[i] is InstanceClass) then
      begin
        Result := True;
        Exit;
      end;
  Result := False;
end;

procedure TMenuController.AbrirTelaFilha(MainForm: TForm;
  InstanceClass: TFormClass; var Reference);
var
  Instance: TForm;
begin
  Screen.Cursor := crHourglass;
  LockWindowUpdate(MainForm.Handle);
  if not IsChildFormExist(InstanceClass) then
    try
      Instance := TForm(InstanceClass.NewInstance);
      TForm(Reference) := Instance;
      try
        Instance.Create(MainForm);
        if (Instance as TForm).FormStyle = fsNormal then
        begin
          (Instance as TForm).FormStyle := fsMdiChild;
          (Instance as TForm).Visible := True;
        end;
      except
        TForm(Reference) := nil;
        Instance.Free;
        raise;
      end;
    finally
      Screen.Cursor := crDefault;
    end
  else
    with TForm(Reference) do
    begin
      if WindowState = wsMinimized then
        WindowState := wsNormal;
      BringToFront;
      Screen.Cursor := crDefault;
      SetFocus;
    end;

  LockWindowUpdate(0);
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
