object frmConsultaNotasView: TfrmConsultaNotasView
  Left = 0
  Top = 0
  Caption = 'Consultar notas'
  ClientHeight = 221
  ClientWidth = 320
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
  object gridNotasView: TStringGrid
    Left = 0
    Top = 0
    Width = 320
    Height = 221
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    ColCount = 1
    DefaultColWidth = 171
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDblClick = gridNotasViewDblClick
    OnKeyPress = gridNotasViewKeyPress
  end
end
