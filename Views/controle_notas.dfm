object frmLogin: TfrmLogin
  Left = 436
  Top = 203
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 182
  ClientWidth = 324
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
  object gbautenticacao: TGroupBox
    Left = 8
    Top = 8
    Width = 304
    Height = 168
    Caption = 'Autentica'#195#167#195#163'o'
    TabOrder = 0
    object lbusuario: TLabel
      Left = 8
      Top = 8
      Width = 75
      Height = 13
      Caption = 'Nome Usu'#195#161'rio:'
      Color = clBtnFace
      ParentColor = False
    end
    object lbsenha: TLabel
      Left = 8
      Top = 64
      Width = 34
      Height = 13
      Caption = 'Senha:'
      Color = clBtnFace
      ParentColor = False
    end
    object txtusuario: TEdit
      Left = 8
      Top = 24
      Width = 278
      Height = 21
      TabOrder = 0
    end
    object txtsenha: TEdit
      Left = 8
      Top = 80
      Width = 278
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object btsair: TButton
      Left = 128
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btsairClick
    end
    object btacessar: TButton
      Left = 211
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Acessar'
      TabOrder = 3
      OnClick = btacessarClick
    end
  end
end
