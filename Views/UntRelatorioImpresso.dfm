object frmRelatorioImpresso: TfrmRelatorioImpresso
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio por per'#237'odo'
  ClientHeight = 437
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object rlrNotas: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = rlrNotasBeforePrint
    object btCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 27
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object lbData: TRLSystemInfo
        Left = 0
        Top = 0
        Width = 39
        Height = 26
        Align = faLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object lbHora: TRLSystemInfo
        Left = 677
        Top = 0
        Width = 41
        Height = 26
        Align = faRight
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Info = itHour
        ParentFont = False
        Text = ''
      end
      object lbCabecalhoRelatorio: TRLLabel
        Left = 292
        Top = 4
        Width = 132
        Height = 17
        Align = faCenter
        Alignment = taCenter
        Caption = 'Relat'#243'rio notas fiscais'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object btTitulo: TRLBand
      Left = 38
      Top = 65
      Width = 718
      Height = 64
      BandType = btTitle
      object lbTituloRelatorio: TRLLabel
        Left = 0
        Top = 0
        Width = 718
        Height = 30
        Align = faTop
        Alignment = taCenter
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Caption = 'Relat'#243'rio de notas ficais por per'#237'odo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbPeriodo: TRLLabel
        Left = 0
        Top = 30
        Width = 718
        Height = 28
        Align = faTop
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object btColuna: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 24
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segue ui'
      Font.Style = []
      ParentFont = False
      object lbChaveAcesso: TRLLabel
        Left = 3
        Top = 0
        Width = 99
        Height = 23
        Align = faLeft
        Caption = 'Chave de acesso'
        Holder = colunaChave
      end
      object lbValor: TRLLabel
        Left = 347
        Top = 3
        Width = 55
        Height = 15
        Caption = 'Valor(R$)'
      end
      object lbFornecedor: TRLLabel
        Left = 422
        Top = 3
        Width = 97
        Height = 15
        Caption = 'CNPJ fornecedor'
      end
      object lbCliente: TRLLabel
        Left = 547
        Top = 3
        Width = 101
        Height = 15
        Caption = 'CPF/CNPJ cliente'
      end
      object lbEmissao: TRLLabel
        Left = 665
        Top = 0
        Width = 53
        Height = 23
        Align = faRight
        AutoSize = False
        Caption = 'Emiss'#227'o'
      end
      object lbControle: TRLLabel
        Left = 280
        Top = 3
        Width = 50
        Height = 15
        Caption = 'Controle'
      end
    end
    object btConteudo: TRLBand
      Left = 38
      Top = 153
      Width = 718
      Height = 24
      object colunaChave: TRLDBText
        Left = 3
        Top = 0
        Width = 79
        Height = 24
        Align = faLeft
        DataField = 'chaveacesso'
        Holder = colunaChave
        Text = ''
      end
      object colunaEmissao: TRLDBText
        Left = 665
        Top = 6
        Width = 53
        Height = 16
        DataField = 'emissao'
        Holder = lbEmissao
        Text = ''
      end
      object colunaCliente: TRLDBText
        Left = 547
        Top = 5
        Width = 54
        Height = 16
        DataField = 'idCliente'
        Holder = lbCliente
        Text = ''
      end
      object colunaControle: TRLDBText
        Left = 272
        Top = 2
        Width = 50
        Height = 16
        DataField = 'controle'
        Holder = colunaControle
        Text = ''
      end
    end
    object btRodape: TRLBand
      Left = 38
      Top = 177
      Width = 718
      Height = 16
      BandType = btFooter
    end
  end
end
