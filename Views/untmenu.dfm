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
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mainMenu
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mainMenu: TMainMenu
    Left = 40
    Top = 16
    object itemArquivo: TMenuItem
      Caption = 'Arquivo'
      object itemUsuario: TMenuItem
        Caption = 'Usu'#195#161'rios'
      end
    end
    object itemConsulta: TMenuItem
      Caption = 'Consultas'
      object itemConsultaNotas: TMenuItem
        Caption = 'Notas'
        OnClick = itemConsultaNotasClick
      end
    end
  end
end
