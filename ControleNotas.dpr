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
  untmenu in 'Views\untmenu.pas' {frmMenu},
  untCadastrarNota in 'Views\untCadastrarNota.pas' {frmCadastrarNota},
  UntUsuario in 'Views\UntUsuario.pas' {frmUsuario},
  untLogin in 'Views\untLogin.pas' {frmLogin},
  untConsultarNotas in 'Views\untConsultarNotas.pas' {frmConsultarNotas},
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
  UntValidarNotas in 'Controller\Validacao\UntValidarNotas.pas',
  UntConsultarClienteController in 'Controller\Consulta\UntConsultarClienteController.pas',
  UntConsultarCliente in 'Controller\Consulta\UntConsultarCliente.pas',
  UntConsultaClienteView in 'Views\Consultas\UntConsultaClienteView.pas' {FrmConsultaClienteView},
  UntConsultaFornecedorController in 'Controller\Consulta\UntConsultaFornecedorController.pas',
  UntConsultaFornecedorView in 'Views\Consultas\UntConsultaFornecedorView.pas' {frmConsultaFornecedorView},
  UntConsultaFornecedor in 'Controller\Consulta\UntConsultaFornecedor.pas',
  UntConsultaNotasController in 'Controller\Consulta\UntConsultaNotasController.pas',
  UntConsultaNotasView in 'Views\Consultas\UntConsultaNotasView.pas' {frmConsultaNotasView},
  UntConsultaNotas in 'Controller\Consulta\UntConsultaNotas.pas',
  untRelatorioPeriodo in 'Views\untRelatorioPeriodo.pas' {frmRelatorioPeriodo},
  UntRelatorioDao in 'Dao\UntRelatorioDao.pas',
  UntRelatorioModel in 'Model\UntRelatorioModel.pas',
  UntRelatorioPeriodoController in 'Controller\UntRelatorioPeriodoController.pas',
  UntRelatorioImpresso in 'Views\UntRelatorioImpresso.pas' {frmRelatorioImpresso},
  UntValidarData in 'Controller\Validacao\UntValidarData.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.Run;

end.
