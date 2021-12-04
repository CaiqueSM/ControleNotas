unit UntFormHelper;

interface

uses
  Forms;

type
  TFormHelper = class helper for TForm
    procedure TabOrderNext();
  end;

implementation

uses
  Winapi.Messages;

{ TFormHelper }

procedure TFormHelper.TabOrderNext;
begin
  Perform(wm_NextDlgCtl, 0, 0);
end;

end.
