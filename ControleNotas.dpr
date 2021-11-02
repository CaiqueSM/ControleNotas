program ControleNotas;

uses
  Vcl.Forms,
  UntBaseController in 'Controller\UntBaseController.pas',
  UntLoginController in 'Controller\UntLoginController.pas',
  UntMenuController in 'Controller\UntMenuController.pas',
  UntValidarLogin in 'Controller\Validacao\UntValidarLogin.pas',
  UntBaseDao in 'Dao\UntBaseDao.pas',
  UntConexao in 'Dao\UntConexao.pas',
  UntLoginDao in 'Dao\UntLoginDao.pas',
  untmenu in 'Views\untmenu.pas' {frmMenu},
  UntCadastrarNota in 'Views\UntCadastrarNota.pas' {frmCadastrarNota},
  UntCadastrarClienteNota in 'Views\UntCadastrarClienteNota.pas' {frmClienteNotaFiscal},
  UntCadastrarFornecedorNota in 'Views\UntCadastrarFornecedorNota.pas' {frmFornecedorNotaFiscal},
  UntCadastrarUsuario in 'Views\UntCadastrarUsuario.pas' {frmCadastrarUsuario},
  UntGerarRelatorio in 'Views\UntGerarRelatorio.pas' {frmGerarRelatorio},
  UntLogin in 'Views\UntLogin.pas' {frmLogin},
  UntConsultarNotas in 'Views\UntConsultarNotas.pas' {frmConsultarNotas},
  UntValidarCadastroPessoal in 'Controller\Validacao\UntValidarCadastroPessoal.pas',
  UntCadastroPessoalController in 'Controller\UntCadastroPessoalController.pas',
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
  UntEnvironment in 'UntEnvironment.pas',
  UntCrudEnum in 'Model\Enum\UntCrudEnum.pas',
  UntFormHelper in 'Helper\UntFormHelper.pas',
  UntMensagemUtil in 'Util\UntMensagemUtil.pas',
  UntConsultaUsuarios in 'Views\Consultas\UntConsultaUsuarios.pas' {FrmConsultaUsuarios},
  UntConsulta in 'Controller\Consulta\UntConsulta.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TFrmConsultaUsuarios, FrmConsultaUsuarios);
  Application.Run;

end.
