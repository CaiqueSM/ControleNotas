object frmNotas: TfrmNotas
  Left = 270
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consultar notas ficais'
  ClientHeight = 117
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 8
    Width = 434
    Height = 105
    Caption = ' Consultar '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 23
      Width = 76
      Height = 15
      Caption = 'Chave Acesso:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object txtChaveAcesso: TEdit
      Left = 11
      Top = 41
      Width = 414
      Height = 23
      MaxLength = 44
      NumbersOnly = True
      TabOrder = 0
    end
    object btnConsultar: TButton
      Left = 350
      Top = 70
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 1
    end
    object btnCancelar: TButton
      Left = 270
      Top = 70
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
end
