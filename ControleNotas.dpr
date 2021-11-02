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
  untmenu in 'Views\untmenu.pas' {frmMenu},
  untCadastrarNota in 'Views\untCadastrarNota.pas' {frmCadastrarNota},
  untCadastrarClienteNota in 'Views\untCadastrarClienteNota.pas' {frmClienteNotaFiscal},
  untCadastrarFornecedorNota in 'Views\untCadastrarFornecedorNota.pas' {frmFornecedorNotaFiscal},
  untCadastrarUsuario in 'Views\untCadastrarUsuario.pas' {frmCadastrarUsuario},
  untGerarRelatorio in 'Views\untGerarRelatorio.pas' {frmGerarRelatorio},
  untLogin in 'Views\untLogin.pas' {frmLogin},
  untConsultarNotas in 'Views\untConsultarNotas.pas' {frmConsultarNotas},
  untValidarCadastroPessoal in 'Controller\Validacao\untValidarCadastroPessoal.pas',
  untCadastroPessoalController in 'Controller\untCadastroPessoalController.pas',
  UntClienteModel in 'Model\UntClienteModel.pas',
  UntContatoModel in 'Model\UntContatoModel.pas',
  UntEmailModel in 'Model\UntEmailModel.pas',
  UntFornecedorModel in 'Model\UntFornecedorModel.pas',
  UntNotasModel in 'Model\UntNotasModel.pas',
  UntPessoaModel in 'Model\UntPessoaModel.pas',
  UntTelefoneModel in 'Model\UntTelefoneModel.pas',
  UntUsuarioModel in 'Model\UntUsuarioModel.pas',
  UntCadastrarUsuarioController in 'Controller\UntCadastrarUsuarioController.pas',
  UntCadastrarUsuarioDao in 'Dao\UntCadastrarUsuarioDao.pas',
  untenvironment in 'untenvironment.pas',
  UntCrudEnum in 'Model\Enum\UntCrudEnum.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;

end.
