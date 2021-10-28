object frmLogin: TfrmLogin
  Left = 436
  Top = 203
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 167
  ClientWidth = 227
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbusuario: TLabel
    Left = 16
    Top = 17
    Width = 43
    Height = 15
    Caption = 'Usu'#225'rio:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object lbsenha: TLabel
    Left = 16
    Top = 70
    Width = 35
    Height = 15
    Caption = 'Senha:'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object txtUsuario: TEdit
    Left = 16
    Top = 33
    Width = 195
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxLength = 80
    ParentFont = False
    TabOrder = 0
  end
  object txtSenha: TEdit
    Left = 16
    Top = 89
    Width = 195
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI Black'
    Font.Style = []
    MaxLength = 256
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnAcessar: TButton
    Left = 114
    Top = 124
    Width = 97
    Height = 25
    Caption = 'Acessar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnAcessarClick
  end
  object btnSair: TButton
    Left = 16
    Top = 124
    Width = 97
    Height = 25
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnSairClick
  end
end
