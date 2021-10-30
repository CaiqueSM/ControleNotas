object frmGerarRelatorio: TfrmGerarRelatorio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar Relat'#243'rio'
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
    TabOrder = 4
  end
  object txtGerar: TButton
    Left = 364
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 3
  end
  object gbPeriodo: TGroupBox
    Left = 8
    Top = 106
    Width = 431
    Height = 56
    Caption = ' Periodo '
    TabOrder = 2
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
    object txtDataTermino: TEdit
      Left = 307
      Top = 23
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object txtDataInicio: TEdit
      Left = 73
      Top = 23
      Width = 121
      Height = 23
      TabOrder = 0
    end
  end
  object gbOrdenar: TGroupBox
    Left = 229
    Top = 8
    Width = 210
    Height = 92
    Caption = ' Ordenar por '
    TabOrder = 1
    object cboFrequencia: TCheckBox
      Left = 3
      Top = 17
      Width = 97
      Height = 17
      Caption = 'Frequ'#234'ncia'
      TabOrder = 0
    end
    object cboValores: TCheckBox
      Left = 3
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Valores'
      TabOrder = 1
    end
    object cboAlfabetica: TCheckBox
      Left = 3
      Top = 63
      Width = 97
      Height = 17
      Caption = 'Alfab'#233'tica'
      TabOrder = 2
    end
  end
  object rgRelatorio: TRadioGroup
    Left = 8
    Top = 8
    Width = 210
    Height = 92
    Caption = ' Relat'#243'rio de '
    TabOrder = 0
  end
  object rboAmbos: TRadioButton
    Left = 15
    Top = 25
    Width = 130
    Height = 17
    Caption = 'Ambos'
    Checked = True
    TabOrder = 5
    TabStop = True
  end
  object rboCliente: TRadioButton
    Left = 15
    Top = 48
    Width = 130
    Height = 17
    Caption = 'Cliente'
    TabOrder = 6
  end
  object rboFornecedor: TRadioButton
    Left = 15
    Top = 71
    Width = 146
    Height = 17
    Caption = 'Fornecedores'
    TabOrder = 7
  end
end
