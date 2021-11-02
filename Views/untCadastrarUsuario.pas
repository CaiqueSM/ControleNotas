unit untCadastrarUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, UntCadastrarUsuarioController,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untValidarLogin,
  Vcl.Buttons;

type
  TfrmCadastrarUsuario = class(TForm)
    txtInfoSenha: TEdit;
    lbNomeUsuario: TLabel;
    lbSenha: TLabel;
    btnCadastar: TButton;
    btnCancelar: TButton;
    txtConfirmSenha: TEdit;
    lbConfirmSenha: TLabel;
    CmbNomesUsuarios: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: TCadastrarUsuarioController;
    procedure habilitarCampos(AHabilitar: Boolean);
    procedure listarUsuarios(ACombo: TComboBox);
  end;

var
  frmCadastrarUsuario: TfrmCadastrarUsuario;

implementation

uses
  System.Generics.Collections, UntUsuarioModel;

{$R *.dfm}

procedure TfrmCadastrarUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FController.Free;
  Action := caFree;
end;

procedure TfrmCadastrarUsuario.FormCreate(Sender: TObject);
begin
  FController := TCadastrarUsuarioController.Create();
end;

procedure TfrmCadastrarUsuario.FormShow(Sender: TObject);
begin
   habilitarCampos(False);
   listarUsuarios(CmbNomesUsuarios);
end;

procedure TfrmCadastrarUsuario.habilitarCampos(AHabilitar: Boolean);
begin
   CmbNomesUsuarios.Enabled := Not AHabilitar;

   txtInfoSenha.Enabled := AHabilitar;
   txtConfirmSenha.Enabled := AHabilitar;
   btnCadastar.Enabled := AHabilitar;
   btnCancelar.Enabled := AHabilitar;
end;

procedure TfrmCadastrarUsuario.listarUsuarios(ACombo: TComboBox);
var
  listaUsuarios: TStringList;
begin
   listaUsuarios := FController.ListarNomesUsuarios();
   try
      ACombo.Items.AddStrings(listaUsuarios);
   finally
      listaUsuarios.Free;
   end;
end;

end.
