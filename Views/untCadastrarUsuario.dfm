object frmCadastrarUsuario: TfrmCadastrarUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar usu'#225'rio'
  ClientHeight = 499
  ClientWidth = 712
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
    Top = 5
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbSenha: TLabel
    Left = 5
    Top = 50
    Width = 88
    Height = 15
    Caption = 'Informe a senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 5
    Top = 95
    Width = 96
    Height = 15
    Caption = 'Confirme a senha:'
  end
  object txtInfoSenha: TEdit
    Left = 5
    Top = 65
    Width = 200
    Height = 23
    MaxLength = 16
    PasswordChar = '*'
    TabOrder = 0
  end
  object btnCadastar: TButton
    Left = 130
    Top = 140
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 49
    Top = 139
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object txtConfirmSenha: TEdit
    Left = 5
    Top = 110
    Width = 200
    Height = 23
    Hint = 'Confirmar senha'
    MaxLength = 16
    PasswordChar = '*'
    TabOrder = 1
  end
  object CmbNomesUsuarios: TComboBox
    Left = 5
    Top = 21
    Width = 200
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 4
  end
end
