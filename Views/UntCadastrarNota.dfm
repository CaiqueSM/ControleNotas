object frmCadastrarNota: TfrmCadastrarNota
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar as notas fiscais'
  ClientHeight = 291
  ClientWidth = 304
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
    Left = 5
    Top = 0
    Width = 290
    Height = 121
    Caption = ' Informa'#231#245'es da Nota '
    TabOrder = 0
    object lbChaveAcesso: TLabel
      Left = 5
      Top = 20
      Width = 92
      Height = 15
      Caption = 'Chave de Acesso:'
    end
    object lbCodigo: TLabel
      Left = 5
      Top = 70
      Width = 93
      Height = 15
      Caption = 'C'#243'digo/Controle:'
    end
    object lbValor: TLabel
      Left = 164
      Top = 70
      Width = 29
      Height = 15
      Caption = 'Valor:'
    end
    object txtChaveAcesso: TEdit
      Left = 5
      Top = 35
      Width = 280
      Height = 23
      MaxLength = 44
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object txtCodigo: TEdit
      Left = 5
      Top = 85
      Width = 121
      Height = 23
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object txtValor: TEdit
      Left = 164
      Top = 85
      Width = 121
      Height = 23
      Hint = 'R$'
      MaxLength = 12
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object gbDescricao: TGroupBox
    Left = 5
    Top = 127
    Width = 290
    Height = 127
    Caption = ' Descri'#231#227'o '
    TabOrder = 1
    object menoDescricao: TMemo
      Left = 5
      Top = 20
      Width = 280
      Height = 95
      Hint = 'Descreva ou liste os produtos e servi'#231'os.'
      MaxLength = 140
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
  end
  object btnGravar: TButton
    Left = 215
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 134
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
end
