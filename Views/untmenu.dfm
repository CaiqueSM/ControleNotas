object frmMenu: TfrmMenu
  Left = 230
  Top = 106
  BorderStyle = bsSingle
  Caption = 'Controle de notas'
  ClientHeight = 478
  ClientWidth = 1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTopo: TPanel
    Left = 5
    Top = -1
    Width = 729
    Height = 7
    Caption = #39#39
    TabOrder = 0
    Visible = False
  end
  object stbControleNotas: TStatusBar
    Left = 0
    Top = 459
    Width = 1081
    Height = 19
    AutoHint = True
    Panels = <>
    SimpleText = 'Bem vindo!'
    ExplicitLeft = 160
    ExplicitTop = 392
    ExplicitWidth = 0
  end
  object mainMenu: TMainMenu
    Left = 40
    Top = 16
    object itemCadastro: TMenuItem
      Caption = 'Cadastros'
      object itemUsuario: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = itemUsuarioClick
      end
      object itemNota: TMenuItem
        Caption = 'Notas'
        OnClick = itemNotaClick
      end
      object itemCliente: TMenuItem
        Caption = 'Cliente'
        OnClick = itemClienteClick
      end
      object itemFornecedor: TMenuItem
        Caption = 'Fornecedor'
        OnClick = itemFornercedorClick
      end
    end
    object itemConsulta: TMenuItem
      Caption = 'Consultas'
      object itemConsultaNotas: TMenuItem
        Caption = 'Notas'
        OnClick = itemConsultaNotasClick
      end
    end
    object itemRelatorio: TMenuItem
      Caption = 'Relat'#243'rios'
      object itemRelatorioMensal: TMenuItem
        Caption = 'Mensal'
        OnClick = itemRelatorioMensalClick
      end
      object itemRelatorioPeriodo: TMenuItem
        Caption = 'Escolher per'#237'odo'
      end
    end
  end
end
