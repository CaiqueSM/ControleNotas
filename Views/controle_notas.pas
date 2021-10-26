unit controle_notas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, MaskEdit,
  MySQL4, RegExpr, sha1, UntLoginController;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    btacessar: TButton;
    btsair: TButton;
    cbcadastrar: TCheckBox;
    gbautenticacao: TGroupBox;
    lbsenha: TLabel;
    lbusuario: TLabel;
    txtsenha: TEdit;
    txtusuario: TEdit;
    procedure btacessarClick(Sender: TObject);
    procedure btsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FController: TLoginController;
    function ValidarLogin(AUsuario, ASenha: String): boolean;
  end;

var
  frmLogin: TfrmLogin;
  mySQLSock: pmysql;
  mysqlq: tmysql;

implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FController := TLoginController.Create();
end;

procedure TfrmLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

function TfrmLogin.ValidarLogin(AUsuario, ASenha: String): boolean;
begin
  Result := False;

  if not FController.ValidarUsuario(AUsuario) then
    begin
      ShowMessage('Nome usuário inválido. Use apenas números e letras!');
      if txtusuario.CanFocus Then txtusuario.SetFocus;
      exit();
    end;

  if not FController.ValidarSenha(ASenha) then
  begin
    ShowMessage('A senha deve ter no mínimo 4 digitos!');
    if txtsenha.CanFocus Then txtsenha.SetFocus;
    exit();
  end;

  Result := True;
end;

procedure TfrmLogin.btacessarClick(Sender: TObject);
var
  criptoTexto: TSHA1Digest;
  resultado: integer;
  shaTexto, query: string;
  buffer: pmysql_res;
begin
  if not ValidarLogin(txtusuario.Text, txtsenha.Text) then Exit();

  begin
    criptoTexto := SHA1String(txtsenha.Text);
    shaTexto := SHA1print(criptoTexto);
  end;

  if mysqlsock <> nil then
    mysql_close(mysqlsock);

  mySQLsock := mysql_real_connect(mysql_init(pmysql(@mysqlq)),
    PChar('localhost'), PChar('root'), '', PChar('nota_fiscal'), 0, nil, 0);

  if mysqlsock = nil then
  begin
    ShowMessage('Conexão ao servidor falhou.');
    ShowMessage('O erro foi:' + strPas(mysql_error(@mysqlq)));
  end;// else showmessage('Conetado ao servidor.');

  if cbcadastrar.Checked then
  begin
    query := 'insert into usuario(nome_usuario, senha) values(' +
      '"' + txtusuario.Text + '"' + ',' + '"' + shaTexto + '"' + ')';
    resultado := mysql_query(mySQlsock, PChar(query));
    if resultado = 0 then
      ShowMessage('Usuário cadastrado com sucesso!')
    else
      ShowMessage('Não é possível cadastrar usuário, este nome já está em uso!');
  end;

  query := 'select nome_usuario, senha from usuario where nome_usuario = ' +
    '"' + txtusuario.Text + '"';
  resultado := mysql_query(mySQLsock, PChar(query));
  if resultado <> 0 then
  begin
    ShowMessage('Query Falhou' + strpas(mysql_error(mySQLsock)));
    raise(Exception.Create('Query falhou.'));
  end
  else
  begin
    buffer := mysql_Store_result(mysqlsock);
    if buffer <> nil then
    begin
      //querybuffer:= mysql_fetch_fields(buffer)[0];
      //if Autenticar(txtusuario.text,mysql_fetch_field(buffer),
      //shaTexto, ''{mysql_fetch_field(buffer)[]})then
      //frmNotas := TfrmNotas.Create(nil);
      //frmNotas.Show;
      //frmLogin.Visible := False;
    end;
  end;
end;

procedure TfrmLogin.btsairClick(Sender: TObject);
begin
  mysql_close(mysqlsock);
  Close();
end;

end.
