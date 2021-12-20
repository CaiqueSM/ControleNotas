object frmRelatorioMensal: TfrmRelatorioMensal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rio mensal'
  ClientHeight = 261
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
    Top = 230
    Width = 75
    Height = 26
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnGerar: TButton
    Left = 270
    Top = 230
    Width = 75
    Height = 25
    Caption = 'Gerar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnGerarClick
  end
  object btnImprimir: TButton
    Left = 351
    Top = 230
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnImprimirClick
  end
  object rgOrdenar: TRadioGroup
    Left = 136
    Top = 0
    Width = 128
    Height = 92
    Caption = ' Ordenar por '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Items.Strings = (
      'Alfab'#233'tica'
      'Frequ'#234'ncia'
      'Valores')
    ParentFont = False
    TabOrder = 1
  end
  object rgRelatorio: TRadioGroup
    Left = 5
    Top = 0
    Width = 128
    Height = 92
    Caption = ' Relat'#243'rio de '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Items.Strings = (
      'Clientes'
      'Fornecedores'
      'Notas fiscais')
    ParentFont = False
    TabOrder = 0
  end
  object gbResultado: TGroupBox
    Left = 5
    Top = 96
    Width = 421
    Height = 128
    Caption = ' Pr'#233'-visualiza'#231#227'o '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
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
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object gbPeriodo: TGroupBox
    Left = 265
    Top = 0
    Width = 161
    Height = 92
    Caption = ' Periodo '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lbMes: TLabel
      Left = 7
      Top = 31
      Width = 78
      Height = 15
      Caption = 'Escolha o m'#234's:'
    end
    object cbMeses: TComboBox
      Left = 7
      Top = 47
      Width = 145
      Height = 23
      Hint = 'Meses'
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        'Janeiro'
        'Fevereiro'
        'Mar'#231'o'
        'Abril'
        'Maio'
        'Junho'
        'Julho'
        'Agosto'
        'Setembro'
        'Outubro'
        'Novembro'
        'Dezembro')
    end
  end
end
