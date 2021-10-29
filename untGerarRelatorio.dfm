object frmGerarRelatorio: TfrmGerarRelatorio
  Left = 0
  Top = 0
  Caption = 'Gerar Relat'#243'rio'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbDataInicio: TLabel
    Left = 8
    Top = 8
    Width = 53
    Height = 13
    Caption = 'Data in'#237'cio:'
  end
  object lbDataTermino: TLabel
    Left = 318
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Data T'#233'rmino:'
  end
  object txtDataInicio: TEdit
    Left = 8
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object txtDataTermino: TEdit
    Left = 318
    Top = 27
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnCancelar: TButton
    Left = 283
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
  end
  object txtGerar: TButton
    Left = 364
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 3
  end
end
