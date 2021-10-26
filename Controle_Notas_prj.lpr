program Controle_Notas_prj;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent,
  controle_notas,
  consulta_notas,
  UntMenu,
  UntMenuController, UntLoginDao;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;
end.

