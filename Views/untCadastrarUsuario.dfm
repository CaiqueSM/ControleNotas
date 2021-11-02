object frmCadastrarUsuario: TfrmCadastrarUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar usu'#225'rio'
  ClientHeight = 220
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
    Top = 5
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbSenha: TLabel
    Left = 5
    Top = 101
    Width = 117
    Height = 15
    Caption = 'Informe a nova senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 5
    Top = 146
    Width = 125
    Height = 15
    Caption = 'Confirme a nova senha:'
  end
  object Label1: TLabel
    Left = 5
    Top = 56
    Width = 117
    Height = 15
    Caption = 'Informe a senha atual:'
  end
  object txtNovaSenha: TEdit
    Left = 5
    Top = 116
    Width = 200
    Height = 23
    MaxLength = 16
    PasswordChar = '*'
    TabOrder = 2
  end
  object btnCadastar: TButton
    Left = 130
    Top = 191
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 4
    OnClick = btnCadastarClick
  end
  object btnCancelar: TButton
    Left = 49
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
  object txtConfirmacaoNovaSenha: TEdit
    Left = 5
    Top = 161
    Width = 200
    Height = 23
    Hint = 'Confirmar senha'
    MaxLength = 16
    PasswordChar = '*'
    TabOrder = 3
  end
  object CmbNomesUsuarios: TComboBox
    Left = 5
    Top = 21
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object txtSenhaAtual: TEdit
    Left = 5
    Top = 72
    Width = 200
    Height = 23
    MaxLength = 16
    PasswordChar = '*'
    TabOrder = 1
  end
end
