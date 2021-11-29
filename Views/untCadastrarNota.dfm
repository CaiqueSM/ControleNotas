object frmCadastrarNota: TfrmCadastrarNota
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar as notas fiscais'
  ClientHeight = 372
  ClientWidth = 609
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
    Top = 79
    Width = 598
    Height = 121
    Caption = ' Informa'#231#245'es da Nota '
    TabOrder = 0
    object lbChaveAcesso: TLabel
      Left = 5
      Top = 20
      Width = 90
      Height = 15
      Caption = 'Chave de acesso:'
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
    object lbCNPJCPF: TLabel
      Left = 312
      Top = 20
      Width = 134
      Height = 15
      Caption = 'CNPJ/CPF do fornecedor:'
    end
    object Label1: TLabel
      Left = 312
      Top = 70
      Width = 111
      Height = 15
      Caption = 'CNPJ/CPF do cliente:'
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
      MaxLength = 10
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object mskValor: TMaskEdit
      Left = 164
      Top = 85
      Width = 121
      Height = 23
      Hint = 'R$'
      MaxLength = 12
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = ''
    end
    object txtCNPJCPFfornecedor: TEdit
      Left = 312
      Top = 35
      Width = 280
      Height = 23
      Hint = 'Digite os n'#250'meros do CNPJ'
      MaxLength = 14
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object txtCNPJCPFcliente: TEdit
      Left = 312
      Top = 85
      Width = 280
      Height = 23
      Hint = 'Digite os n'#250'meros do CPF'
      MaxLength = 14
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
  end
  object gbDescricao: TGroupBox
    Left = 5
    Top = 199
    Width = 598
    Height = 127
    Caption = ' Descri'#231#227'o '
    TabOrder = 1
    object menoDescricao: TMemo
      Left = 5
      Top = 20
      Width = 587
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
    Left = 526
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 445
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object tobTop: TToolBar
    Left = 0
    Top = 0
    Width = 609
    Height = 22
    Images = frmMenu.ListaImagens
    TabOrder = 4
    object tbuPesquisar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Pesquisar'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
    end
    object tbuExcluir: TToolButton
      Left = 23
      Top = 0
      Hint = 'Excluir'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
    end
  end
  object gbCodigoFornecedor: TGroupBox
    Left = 5
    Top = 25
    Width = 598
    Height = 50
    TabOrder = 5
    object lblcodigo: TLabel
      Left = 5
      Top = 18
      Width = 42
      Height = 15
      Caption = 'C'#243'digo:'
    end
    object Edit1: TEdit
      Left = 53
      Top = 15
      Width = 55
      Height = 23
      Hint = 'Valor para ordenar as notas'
      MaxLength = 7
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
end
