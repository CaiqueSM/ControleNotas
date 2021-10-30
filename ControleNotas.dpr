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
  untCadastrarNota in 'Views\untCadastrarNota.pas' {frmCadastrarNota},
  untCadastrarClienteNota in 'Views\untCadastrarClienteNota.pas' {frmClienteNotaFiscal},
  untCadastrarFornecedorNota in 'Views\untCadastrarFornecedorNota.pas' {frmFornecedorNotaFiscal},
  untCadastrarUsuario in 'Views\untCadastrarUsuario.pas' {frmCadUsuario},
  untGerarRelatorio in 'Views\untGerarRelatorio.pas' {frmGerarRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmCadastrarNota, frmCadastrarNota);
  Application.CreateForm(TfrmClienteNotaFiscal, frmClienteNotaFiscal);
  Application.CreateForm(TfrmFornecedorNotaFiscal, frmFornecedorNotaFiscal);
  Application.CreateForm(TfrmCadUsuario, frmCadUsuario);
  Application.CreateForm(TfrmGerarRelatorio, frmGerarRelatorio);
  Application.Run;
end.
