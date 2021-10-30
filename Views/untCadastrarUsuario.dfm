object frmCadUsuario: TfrmCadUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Usu'#225'rio'
  ClientHeight = 187
  ClientWidth = 221
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object lbNomeUsuario: TLabel
    Left = 8
    Top = 8
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbSenha: TLabel
    Left = 8
    Top = 51
    Width = 89
    Height = 15
    Caption = 'Informe a Senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 8
    Top = 99
    Width = 97
    Height = 15
    Caption = 'Confirme a Senha:'
  end
  object txtNomeUsuario: TEdit
    Left = 8
    Top = 24
    Width = 200
    Height = 23
    TabOrder = 0
  end
  object txtInfoSenha: TEdit
    Left = 8
    Top = 72
    Width = 200
    Height = 23
    TabOrder = 1
  end
  object btnCadastar: TButton
    Left = 133
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 3
  end
  object btnCancelar: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
  end
  object txtConfirmSenha: TEdit
    Left = 8
    Top = 118
    Width = 200
    Height = 23
    TabOrder = 2
  end
end
