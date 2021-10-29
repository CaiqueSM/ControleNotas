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
  consulta_notas in 'Views\consulta_notas.pas' {frmNotas},
  controle_notas in 'Views\controle_notas.pas' {frmLogin},
  untmenu in 'Views\untmenu.pas' {frmMenu},
  untCadastrarUsuario in 'untCadastrarUsuario.pas' {frmCadUsuario},
  untCadastrarClienteNota in 'untCadastrarClienteNota.pas' {frmClienteNotaFiscal},
  untGerarRelatorio in 'untGerarRelatorio.pas' {frmGerarRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmCadUsuario, frmCadUsuario);
  Application.CreateForm(TfrmClienteNotaFiscal, frmClienteNotaFiscal);
  Application.CreateForm(TfrmGerarRelatorio, frmGerarRelatorio);
  Application.Run;
end.
