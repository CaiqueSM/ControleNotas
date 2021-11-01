object frmGerarRelatorio: TfrmGerarRelatorio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar relat'#243'rio'
  ClientHeight = 198
  ClientWidth = 446
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
  object btnCancelar: TButton
    Left = 283
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object txtGerar: TButton
    Left = 364
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 2
  end
  object gbPeriodo: TGroupBox
    Left = 8
    Top = 106
    Width = 431
    Height = 56
    Caption = ' Periodo '
    TabOrder = 1
    object lbDataInicio: TLabel
      Left = 8
      Top = 28
      Width = 59
      Height = 15
      Caption = 'Data in'#237'cio:'
    end
    object lbDataTermino: TLabel
      Left = 228
      Top = 28
      Width = 73
      Height = 15
      Caption = 'Data T'#233'rmino:'
    end
    object MaskEdit1: TMaskEdit
      Left = 73
      Top = 23
      Width = 120
      Height = 23
      Hint = 'DD/MM/AAAA'
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '  /  /    '
    end
    object MaskEdit2: TMaskEdit
      Left = 307
      Top = 23
      Width = 120
      Height = 23
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '  /  /    '
    end
  end
  object rgRelatorio: TRadioGroup
    Left = 5
    Top = 0
    Width = 210
    Height = 92
    Caption = ' Relat'#243'rio de '
    Items.Strings = (
      'Ambos'
      'Cliente'
      'Fornecedores')
    TabOrder = 0
  end
  object rgOrdenar: TRadioGroup
    Left = 224
    Top = 0
    Width = 210
    Height = 92
    Caption = ' Ordenar por '
    Items.Strings = (
      'Alfab'#233'tica'
      'Frequ'#234'ncia'
      'Valores')
    TabOrder = 4
  end
end
