object frmCadUsuario: TfrmCadUsuario
  Left = 0
  Top = 0
  Caption = 'Cadastrar Usu'#225'rio'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbNomeUsuario: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Nome Usu'#225'rio:'
  end
  object lbSenha: TLabel
    Left = 8
    Top = 51
    Width = 84
    Height = 13
    Caption = 'Informe a Senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 8
    Top = 99
    Width = 89
    Height = 13
    Caption = 'Confirme a Senha:'
  end
  object txtNomeUsuario: TEdit
    Left = 8
    Top = 24
    Width = 431
    Height = 21
    TabOrder = 0
  end
  object txtInfoSenha: TEdit
    Left = 8
    Top = 72
    Width = 431
    Height = 21
    TabOrder = 1
  end
  object btnCadastar: TButton
    Left = 364
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 283
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object txtConfirmSenha: TEdit
    Left = 8
    Top = 118
    Width = 431
    Height = 21
    TabOrder = 4
  end
end
