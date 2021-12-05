object frmConsultarNotas: TfrmConsultarNotas
  Left = 270
  Top = 197
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consultar as notas ficais'
  ClientHeight = 91
  ClientWidth = 299
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grpConsulta: TGroupBox
    Left = 5
    Top = 5
    Width = 290
    Height = 50
    Caption = ' Chave de acesso  '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object txtChaveAcesso: TEdit
      Left = 5
      Top = 17
      Width = 280
      Height = 23
      Hint = 'Digite a chave de acesso'
      MaxLength = 44
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object btnCancelar: TButton
    Left = 140
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnConsultar: TButton
    Left = 221
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 1
    OnClick = btnConsultarClick
  end
end
