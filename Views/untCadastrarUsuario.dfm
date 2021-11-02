object frmCadastrarUsuario: TfrmCadastrarUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar usu'#225'rio'
  ClientHeight = 247
  ClientWidth = 210
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object lbNomeUsuario: TLabel
    Left = 5
    Top = 29
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbSenha: TLabel
    Left = 5
    Top = 125
    Width = 117
    Height = 15
    Caption = 'Informe a nova senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 5
    Top = 170
    Width = 125
    Height = 15
    Caption = 'Confirme a nova senha:'
  end
  object Label1: TLabel
    Left = 5
    Top = 80
    Width = 117
    Height = 15
    Caption = 'Informe a senha atual:'
  end
  object txtNovaSenha: TEdit
    Left = 5
    Top = 140
    Width = 200
    Height = 23
    Hint = 'Informe a nova senha'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 1
  end
  object btnCadastar: TButton
    Left = 130
    Top = 215
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 3
    OnClick = btnCadastarClick
  end
  object btnCancelar: TButton
    Left = 49
    Top = 214
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object txtConfirmacaoNovaSenha: TEdit
    Left = 5
    Top = 185
    Width = 200
    Height = 23
    Hint = 'Confirme a nova senha'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 2
  end
  object txtSenhaAtual: TEdit
    Left = 5
    Top = 96
    Width = 200
    Height = 23
    Hint = 'Informe a senha atual'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 0
  end
  object TxtNomesUsuarios: TEdit
    Left = 5
    Top = 44
    Width = 200
    Height = 23
    Hint = 'Nome do usu'#225'rio'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object tobTop: TToolBar
    Left = 0
    Top = 0
    Width = 210
    Height = 22
    TabOrder = 6
    object tbuPesquisar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Pesquisar'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
    end
    object tbuExcluir: TToolButton
      Left = 23
      Top = 0
      Hint = 'Excluir'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
    end
  end
end
