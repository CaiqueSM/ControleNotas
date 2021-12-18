object frmRelatorioPessoas: TfrmRelatorioPessoas
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio por per'#237'odo'
  ClientHeight = 477
  ClientWidth = 778
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
  object rlrPessoas: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
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
        Left = 329
        Top = 4
        Width = 58
        Height = 17
        Align = faCenter
        Alignment = taCenter
        Caption = 'Relat'#243'rio'
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
      object lbNome: TRLLabel
        Left = 3
        Top = 3
        Width = 37
        Height = 15
        Caption = 'Nome'
        Holder = clNome
      end
      object lbCEP: TRLLabel
        Left = 139
        Top = 3
        Width = 28
        Height = 15
        Caption = 'CEP'
      end
      object lbCidade: TRLLabel
        Left = 181
        Top = 3
        Width = 43
        Height = 15
        Caption = 'Cidade'
      end
      object lbBairro: TRLLabel
        Left = 238
        Top = 3
        Width = 36
        Height = 15
        Caption = 'Bairro'
      end
      object lbRua: TRLLabel
        Left = 287
        Top = 3
        Width = 26
        Height = 15
        Caption = 'Rua'
      end
      object lbCPFCNPJ: TRLLabel
        Left = 61
        Top = 3
        Width = 62
        Height = 15
        Caption = 'CPF/CNPJ'
      end
      object lbNumero: TRLLabel
        Left = 325
        Top = 3
        Width = 48
        Height = 15
        Caption = 'N'#250'mero'
      end
      object lbComplemento: TRLLabel
        Left = 495
        Top = 3
        Width = 82
        Height = 15
        Caption = 'Complemento'
      end
      object lbEmail: TRLLabel
        Left = 384
        Top = 3
        Width = 37
        Height = 15
        Caption = 'E-Mail'
      end
      object lbTelefone: TRLLabel
        Left = 432
        Top = 3
        Width = 51
        Height = 15
        Caption = 'Telefone'
      end
    end
    object btConteudo: TRLBand
      Left = 38
      Top = 153
      Width = 718
      Height = 24
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object clNome: TRLDBText
        Left = 3
        Top = 2
        Width = 48
        Height = 16
        Holder = clNome
        Text = ''
      end
      object clTelefone: TRLDBText
        Left = 427
        Top = 2
        Width = 62
        Height = 16
        Alignment = taCenter
        Holder = lbTelefone
        Text = ''
      end
      object clBairro: TRLDBText
        Left = 232
        Top = 2
        Width = 48
        Height = 16
        Alignment = taCenter
        Holder = lbBairro
        Text = ''
      end
      object clRua: TRLDBText
        Left = 287
        Top = 2
        Width = 37
        Height = 16
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Holder = lbRua
        Text = ''
      end
      object clEmail: TRLDBText
        Left = 381
        Top = 2
        Width = 48
        Height = 16
        Alignment = taCenter
        Holder = clEmail
        Text = ''
      end
      object clNumero: TRLDBText
        Left = 319
        Top = 2
        Width = 60
        Height = 16
        Alignment = taCenter
        Holder = lbNumero
        Text = ''
      end
      object clCPFCNPJ: TRLDBText
        Left = 61
        Top = 2
        Width = 73
        Height = 16
        Holder = lbCPFCNPJ
        Text = ''
      end
      object clCEP: TRLDBText
        Left = 139
        Top = 2
        Width = 41
        Height = 16
        Holder = lbCEP
        Text = ''
      end
      object clCidade: TRLDBText
        Left = 181
        Top = 2
        Width = 54
        Height = 16
        Holder = lbCidade
        Text = ''
      end
      object clComplemento: TRLDBText
        Left = 495
        Top = 2
        Width = 94
        Height = 16
        Holder = lbComplemento
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
        Caption = 'Relat'#243'rio por per'#237'odo'
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
        Height = 32
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
  end
end
