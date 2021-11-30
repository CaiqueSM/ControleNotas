program ControleNotas;

uses
  Vcl.Forms,
  UntBaseController in 'Controller\UntBaseController.pas',
  untlogincontroller in 'Controller\untlogincontroller.pas',
  UntMenuController in 'Controller\UntMenuController.pas',
  untvalidarlogin in 'Controller\Validacao\untvalidarlogin.pas',
  UntBaseDao in 'Dao\UntBaseDao.pas',
  UntConexao in 'Dao\UntConexao.pas',
  UntLoginDao in 'Dao\UntLoginDao.pas',
  untmenu in 'Views\untmenu.pas' {frmMenu},
  untCadastrarNota in 'Views\untCadastrarNota.pas' {frmCadastrarNota},
  UntUsuario in 'Views\UntUsuario.pas' {frmUsuario},
  UntGerarRelatorio in 'Views\UntGerarRelatorio.pas' {frmGerarRelatorio},
  untLogin in 'Views\untLogin.pas' {frmLogin},
  UntConsultarNotas in 'Views\UntConsultarNotas.pas' {frmConsultarNotas},
  UntCadastroPessoalController in 'Controller\UntCadastroPessoalController.pas',
  UntClienteModel in 'Model\UntClienteModel.pas',
  UntContatoModel in 'Model\UntContatoModel.pas',
  UntEmailModel in 'Model\UntEmailModel.pas',
  UntFornecedorModel in 'Model\UntFornecedorModel.pas',
  untNotasModel in 'Model\untNotasModel.pas',
  UntPessoaModel in 'Model\UntPessoaModel.pas',
  UntTelefoneModel in 'Model\UntTelefoneModel.pas',
  untusuariomodel in 'Model\untusuariomodel.pas',
  UntUsuarioController in 'Controller\UntUsuarioController.pas',
  UntUsuarioDao in 'Dao\UntUsuarioDao.pas',
  untenvironment in 'untenvironment.pas',
  UntCrudEnum in 'Model\Enum\UntCrudEnum.pas',
  UntFormHelper in 'Helper\UntFormHelper.pas',
  UntMensagemUtil in 'Util\UntMensagemUtil.pas',
  UntConsultaUsuarios in 'Views\Consultas\UntConsultaUsuarios.pas' {FrmConsultaUsuarios},
  UntConsulta in 'Controller\Consulta\UntConsulta.pas',
  UntConsultaUsuarioController in 'Controller\Consulta\UntConsultaUsuarioController.pas',
  UntClienteDao in 'Dao\UntClienteDao.pas',
  UntClienteController in 'Controller\UntClienteController.pas',
  UntValidarContato in 'Controller\Validacao\UntValidarContato.pas',
  untValidarPessoa in 'Controller\Validacao\untValidarPessoa.pas',
  UntEnumContatoDao in 'Dao\Enum\UntEnumContatoDao.pas',
  UntContatoDao in 'Dao\UntContatoDao.pas',
  UntEmailDao in 'Dao\UntEmailDao.pas',
  UntTelefoneDao in 'Dao\UntTelefoneDao.pas',
  UntCliente in 'Views\UntCliente.pas' {frmCliente},
  UntRelacionamentoContatoModel in 'Model\UntRelacionamentoContatoModel.pas',
  UntRelacionamentoContatoDao in 'Dao\UntRelacionamentoContatoDao.pas',
  untFornecedor in 'Views\untFornecedor.pas' {frmFornecedor},
  UntFornecedorDao in 'Dao\UntFornecedorDao.pas',
  UntFornecedorController in 'Controller\UntFornecedorController.pas',
  UntNotasController in 'Controller\UntNotasController.pas',
  UntNotasDao in 'Dao\UntNotasDao.pas',
  UntValidarNotas in 'Controller\Validacao\UntValidarNotas.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmFornecedor, frmFornecedor);
  Application.Run;

end.
