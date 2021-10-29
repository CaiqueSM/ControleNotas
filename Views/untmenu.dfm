object frmMenu: TfrmMenu
  Left = 230
  Top = 106
  Width = 1087
  Height = 527
  AutoScroll = True
  Caption = 'Controle de notas'
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
    Left = 0
    Top = 0
    Width = 297
    Height = 2
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
  end
  object mainMenu: TMainMenu
    Left = 40
    Top = 16
    object itemCadastro: TMenuItem
      Caption = 'Cadastrar'
      object itemUsuario: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = itemUsuarioClick
      end
      object itemNotaFiscal: TMenuItem
        Caption = 'Notas Fiscais'
        OnClick = itemNotaFiscalClick
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
      object itemGerarRelatorio: TMenuItem
        Caption = 'Gerar Relat'#243'rio'
        OnClick = itemGerarRelatorioClick
      end
    end
  end
end
