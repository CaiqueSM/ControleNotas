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
  public

  end;

var
  frmLogin: TfrmLogin;
  mySQLSock: pmysql;
  mysqlq:tmysql;
  Padrao: TRegExpr;

const
  email = '/^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i';
  nome = '\s?[a-zA-Z_]{1,80}[\w]{0,79}';
implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.btacessarClick(Sender: TObject);
var
  criptoTexto: TSHA1Digest;
  resultado: integer;
  shaTexto, query: string;
  buffer:pmysql_res;
begin

 //verifica se nome e senha são validos.
 Padrao:= TRegExpr.Create;
 Padrao.Expression:= nome;
 if not Padrao.Exec(txtusuario.Text) then
  begin
  showmessage('Nome usuário inválido. Use apenas números e letras!');
  exit();
  end;

 if length(txtsenha.Text) < 4 then
  begin
   showmessage('A senha deve ter no mínimo 4 digitos!');
   exit();
  end
 else
 begin
   criptoTexto:= SHA1String(txtsenha.Text);
   shaTexto:= SHA1print(criptoTexto);
 end;

 if mysqlsock <> nil then mysql_close(mysqlsock);

 mySQLsock:= mysql_real_connect(mysql_init(pmysql(@mysqlq)), pchar('localhost'),
 pchar('root'),'',pchar('nota_fiscal'),0,nil,0);

 if mysqlsock = nil then
  begin
   showmessage('Conexão ao servidor falhou.');
   showmessage('O erro foi:'+ strPas(mysql_error(@mysqlq)));
  end;// else showmessage('Conetado ao servidor.');

 if cbcadastrar.Checked then
 begin
  query:= 'insert into usuario(nome_usuario, senha) values(' +'"'+txtusuario.Text + '"'+
  ',' + '"' + shaTexto + '"' + ')';
  resultado:= mysql_query(mySQlsock, pchar(query));
  if resultado = 0 then
    showmessage('Usuário cadastrado com sucesso!')
  else
   showmessage('Não é possível cadastrar usuário, este nome já está em uso!');
 end;

query:= 'select nome_usuario, senha from usuario where nome_usuario = '
+'"'+txtusuario.Text +'"';
 resultado:= mysql_query(mySQLsock, pchar(query));
 if resultado <> 0 then
  begin
   showmessage('Query Falhou'+strpas(mysql_error(mySQLsock)));
   raise(Exception.create('Query falhou.'));
  end
 else
  begin
    buffer:= mysql_Store_result(mysqlsock);
    if buffer <> nil then
     begin
      //querybuffer:= mysql_fetch_fields(buffer)[0];
      //if Autenticar(txtusuario.text,mysql_fetch_field(buffer),
      //shaTexto, ''{mysql_fetch_field(buffer)[]})then
      frmNotas:= TfrmNotas.Create(nil);
      frmNotas.Show;
      frmLogin.visible:= false;
     end;
  end;
end;

procedure TfrmLogin.btsairClick(Sender: TObject);
begin
  mysql_close(mysqlsock);
  close();
end;

procedure TfrmLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FController.Free;
  CloseAction := caFree;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  FController := TLoginController.Create();
end;

end.

