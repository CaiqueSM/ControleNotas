program ControleNotas;

uses
  Vcl.Forms,
  untbasecontroller in 'Controller\untbasecontroller.pas',
  untLoginController in 'Controller\untLoginController.pas',
  untmenucontroller in 'Controller\untmenucontroller.pas',
  untvalidarlogin in 'Controller\Validacao\untvalidarlogin.pas',
  untbasedao in 'Dao\untbasedao.pas',
  untconexao in 'Dao\untconexao.pas',
  untlogindao in 'Dao\untlogindao.pas',
  untusuariomodel in 'Model\untusuariomodel.pas',
  untmenu in 'Views\untmenu.pas' {frmMenu},
  untCadastrarNota in 'Views\untCadastrarNota.pas' {frmCadastrarNota},
  untCadastrarClienteNota in 'Views\untCadastrarClienteNota.pas' {frmClienteNotaFiscal},
  untCadastrarFornecedorNota in 'Views\untCadastrarFornecedorNota.pas' {frmFornecedorNotaFiscal},
  untCadastrarUsuario in 'Views\untCadastrarUsuario.pas' {frmCadastrarUsuario},
  untGerarRelatorio in 'Views\untGerarRelatorio.pas' {frmGerarRelatorio},
  untLogin in 'Views\untLogin.pas' {frmLogin},
  untConsultarNotas in 'Views\untConsultarNotas.pas' {frmConsultarNotas},
  untPessoaModel in 'Model\untPessoaModel.pas',
  untValidarCadastroPessoal in 'Controller\Validacao\untValidarCadastroPessoal.pas',
  untCadastroPessoalController in 'Controller\untCadastroPessoalController.pas',
  untContatoModel in 'Model\untContatoModel.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;

end.
