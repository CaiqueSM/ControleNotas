object frmRelatorioPeriodo: TfrmRelatorioPeriodo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar relat'#243'rio'
  ClientHeight = 313
  ClientWidth = 434
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
  object btnCancelar: TButton
    Left = 189
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
    OnClick = btnCancelarClick
  end
  object btnGerar: TButton
    Left = 270
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 4
    OnClick = btnGerarClick
  end
  object gbPeriodo: TGroupBox
    Left = 5
    Top = 96
    Width = 421
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
      Left = 211
      Top = 28
      Width = 73
      Height = 15
      Caption = 'Data T'#233'rmino:'
    end
    object mskInicio: TMaskEdit
      Left = 73
      Top = 23
      Width = 118
      Height = 23
      Hint = 'DD/MM/AAAA'
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'dd/mm/aaaa'
      OnExit = mskInicioExit
    end
    object mskTermino: TMaskEdit
      Left = 290
      Top = 23
      Width = 119
      Height = 23
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'dd/mm/aaaa'
      OnExit = mskTerminoExit
    end
  end
  object rgRelatorio: TRadioGroup
    Left = 5
    Top = 0
    Width = 210
    Height = 92
    Caption = ' Relat'#243'rio de '
    Items.Strings = (
      'Clientes'
      'Fornecedores'
      'Notas fiscais')
    TabOrder = 0
  end
  object rgOrdenar: TRadioGroup
    Left = 216
    Top = 0
    Width = 210
    Height = 92
    Caption = ' Ordenar por '
    Items.Strings = (
      'Alfab'#233'tica'
      'Frequ'#234'ncia'
      'Valores')
    TabOrder = 1
  end
  object btnImprimir: TButton
    Left = 351
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 3
    OnClick = btnImprimirClick
  end
  object gbResultado: TGroupBox
    Left = 5
    Top = 152
    Width = 421
    Height = 128
    Caption = ' Pr'#233'-visualiza'#231#227'o '
    TabOrder = 6
    object DBResultado: TDBGrid
      Left = 5
      Top = 16
      Width = 410
      Height = 103
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
end
