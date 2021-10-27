program ControleNotas;

uses
  Vcl.Forms,
  untbasecontroller in 'Controller\untbasecontroller.pas',
  untlogincontroller in 'Controller\untlogincontroller.pas',
  untmenucontroller in 'Controller\untmenucontroller.pas',
  untvalidarlogin in 'Controller\Validacao\untvalidarlogin.pas',
  untbasedao in 'Dao\untbasedao.pas',
  untconexao in 'Dao\untconexao.pas',
  untlogindao in 'Dao\untlogindao.pas',
  untusuariomodel in 'Model\untusuariomodel.pas',
  consulta_notas in 'Views\consulta_notas.pas',
  controle_notas in 'Views\controle_notas.pas',
  untmenu in 'Views\untmenu.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
