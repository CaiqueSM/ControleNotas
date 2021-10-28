object frmNotas: TfrmNotas
  Left = 270
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consultar notas ficais'
  ClientHeight = 162
  ClientWidth = 675
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
    Left = 16
    Top = 16
    Width = 649
    Height = 136
    Caption = 'Consultar Nota Fiscal'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 72
      Height = 13
      Caption = 'Chave Acesso:'
      Color = clBtnFace
      ParentColor = False
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 624
      Height = 21
      TabOrder = 0
    end
    object Button1: TButton
      Left = 552
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Consultar'
      TabOrder = 2
    end
    object Button2: TButton
      Left = 472
      Top = 80
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
    end
  end
end
