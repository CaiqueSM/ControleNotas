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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object gbInfoNota: TGroupBox
    Left = 5
    Top = 80
    Width = 598
    Height = 127
    Caption = ' Informa'#231#245'es da Nota '
    TabOrder = 1
    object lbChaveAcesso: TLabel
      Left = 5
      Top = 20
      Width = 90
      Height = 15
      Caption = 'Chave de acesso:'
    end
    object lbControle: TLabel
      Left = 5
      Top = 70
      Width = 49
      Height = 15
      Caption = 'Controle:'
    end
    object lbValor: TLabel
      Left = 104
      Top = 70
      Width = 29
      Height = 15
      Caption = 'Valor:'
    end
    object lbCNPJfornecedor: TLabel
      Left = 312
      Top = 20
      Width = 108
      Height = 15
      Caption = 'CNPJ do fornecedor:'
    end
    object lbCNPJCPFcliente: TLabel
      Left = 312
      Top = 70
      Width = 111
      Height = 15
      Caption = 'CNPJ/CPF do cliente:'
    end
    object lbEmitido: TLabel
      Left = 205
      Top = 70
      Width = 64
      Height = 15
      Caption = 'Emitido em:'
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
      OnExit = txtChaveAcessoExit
    end
    object txtControle: TEdit
      Left = 5
      Top = 85
      Width = 80
      Height = 23
      MaxLength = 10
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
      OnExit = txtCNPJCPFfornecedorExit
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
      OnExit = txtCNPJCPFclienteExit
    end
    object mskEmissao: TMaskEdit
      Left = 205
      Top = 85
      Width = 80
      Height = 23
      Hint = 'Data de emiss'#227'o'
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = 'dd/mm/aaaa'
    end
    object txtValor: TEdit
      Left = 104
      Top = 85
      Width = 85
      Height = 23
      MaxLength = 12
      NumbersOnly = True
      TabOrder = 5
      OnExit = txtValorExit
    end
  end
  object gbDescricao: TGroupBox
    Left = 5
    Top = 206
    Width = 598
    Height = 127
    Caption = ' Descri'#231#227'o '
    TabOrder = 2
    object memoDescricao: TMemo
      Left = 5
      Top = 20
      Width = 587
      Height = 95
      Hint = 'Descreva ou liste os produtos e servi'#231'os.'
      MaxLength = 500
      ParentShowHint = False
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
  end
  object btnGravar: TButton
    Left = 528
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = btnGravarClick
  end
  object btnCancelar: TButton
    Left = 445
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object tobTop: TToolBar
    Left = 0
    Top = 0
    Width = 609
    Height = 22
    Images = frmMenu.ListaImagens
    TabOrder = 5
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
    TabOrder = 0
    object lbcodigo: TLabel
      Left = 5
      Top = 18
      Width = 42
      Height = 15
      Caption = 'C'#243'digo:'
    end
    object txtCodigo: TEdit
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
      OnKeyPress = txtCodigoKeyPress
    end
  end
end
