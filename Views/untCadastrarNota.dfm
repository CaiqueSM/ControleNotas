object frmCadastrarNota: TfrmCadastrarNota
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Notas'
  ClientHeight = 285
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object gbInfoNota: TGroupBox
    Left = 6
    Top = 0
    Width = 290
    Height = 121
    Caption = ' Informa'#231#245'es da Nota '
    TabOrder = 0
    object lbChaveAcesso: TLabel
      Left = 11
      Top = 16
      Width = 92
      Height = 15
      Caption = 'Chave de Acesso:'
    end
    object lbCodigo: TLabel
      Left = 11
      Top = 62
      Width = 93
      Height = 15
      Caption = 'C'#243'digo/Controle:'
    end
    object lbValor: TLabel
      Left = 160
      Top = 62
      Width = 29
      Height = 15
      Caption = 'Valor:'
    end
    object txtChaveAcesso: TEdit
      Left = 11
      Top = 35
      Width = 270
      Height = 23
      TabOrder = 0
    end
    object txtCodigo: TEdit
      Left = 11
      Top = 83
      Width = 121
      Height = 23
      TabOrder = 1
    end
    object txtValor: TEdit
      Left = 160
      Top = 83
      Width = 121
      Height = 23
      TabOrder = 2
    end
  end
  object gbDescricao: TGroupBox
    Left = 6
    Top = 127
    Width = 290
    Height = 120
    Caption = ' Descri'#231#227'o '
    TabOrder = 1
    object menoDescricao: TMemo
      Left = 10
      Top = 14
      Width = 271
      Height = 95
      TabOrder = 0
    end
  end
  object btnGravar: TButton
    Left = 221
    Top = 253
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 140
    Top = 253
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
end
