object frmFornecedor: TfrmFornecedor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar fornecedor nota fiscal'
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
  object btnCancelar: TButton
    Left = 447
    Top = 339
    Width = 75
    Height = 25
    Hint = 'Cancelar'
    Caption = 'Cancelar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnGravar: TButton
    Left = 528
    Top = 339
    Width = 75
    Height = 25
    Hint = 'Gravar'
    Caption = 'Gravar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnGravarClick
  end
  object gbCodigoFornecedor: TGroupBox
    Left = 5
    Top = 27
    Width = 598
    Height = 50
    TabOrder = 4
    object lblcodigo: TLabel
      Left = 5
      Top = 18
      Width = 42
      Height = 15
      Caption = 'C'#243'digo:'
    end
    object txtcodigo: TEdit
      Left = 53
      Top = 15
      Width = 55
      Height = 23
      Hint = 'Valor para ordenar os fornecedores'
      MaxLength = 7
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = txtcodigoKeyPress
    end
  end
  object gbContatoFornecedor: TGroupBox
    Left = 5
    Top = 164
    Width = 598
    Height = 169
    Caption = ' Contato do fornecedor'
    TabOrder = 1
    object lbCEP: TLabel
      Left = 5
      Top = 24
      Width = 24
      Height = 15
      Caption = 'CEP:'
    end
    object lbRua: TLabel
      Left = 5
      Top = 70
      Width = 23
      Height = 15
      Caption = 'Rua:'
    end
    object lbEmail: TLabel
      Left = 5
      Top = 116
      Width = 32
      Height = 15
      Caption = 'Email:'
    end
    object lbBairro: TLabel
      Left = 310
      Top = 24
      Width = 34
      Height = 15
      Caption = 'Bairro:'
    end
    object lbNumero: TLabel
      Left = 310
      Top = 69
      Width = 47
      Height = 15
      Caption = 'N'#250'mero:'
    end
    object lbTelefone: TLabel
      Left = 310
      Top = 115
      Width = 47
      Height = 15
      Caption = 'Telefone:'
    end
    object lbComplemento: TLabel
      Left = 376
      Top = 69
      Width = 80
      Height = 15
      Caption = 'Complemento:'
    end
    object lblCidade: TLabel
      Left = 77
      Top = 24
      Width = 40
      Height = 15
      Caption = 'Cidade:'
    end
    object txtRua: TEdit
      Left = 5
      Top = 86
      Width = 280
      Height = 23
      Hint = 'Logradouro'
      MaxLength = 32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtEmail: TEdit
      Left = 5
      Top = 132
      Width = 280
      Height = 23
      Hint = 'Email'
      MaxLength = 64
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtBairro: TEdit
      Left = 310
      Top = 40
      Width = 280
      Height = 23
      Hint = 'Bairro'
      MaxLength = 32
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtNumero: TEdit
      Left = 310
      Top = 86
      Width = 55
      Height = 23
      Hint = 'N'#250'mero'
      MaxLength = 9
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtComplemento: TEdit
      Left = 376
      Top = 86
      Width = 214
      Height = 23
      Hint = 'Complemento'
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object mskTelefone: TMaskEdit
      Left = 310
      Top = 132
      Width = 268
      Height = 23
      Hint = 'Telefone'
      EditMask = '\(00\)000000009;0;'
      MaxLength = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Text = ''
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object mskCEP: TMaskEdit
      Left = 5
      Top = 40
      Width = 66
      Height = 23
      Hint = 'CEP'
      EditMask = '00999-999;1;_'
      MaxLength = 9
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '     -   '
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtCidade: TEdit
      Left = 77
      Top = 40
      Width = 208
      Height = 23
      Hint = 'Cidade'
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = txtCNPJCPFKeyPress
    end
  end
  object gbInfoFornecedor: TGroupBox
    Left = 5
    Top = 80
    Width = 598
    Height = 85
    Caption = ' Informa'#231#245'es do fornecedor'
    TabOrder = 0
    object lbCNPJCPF: TLabel
      Left = 5
      Top = 25
      Width = 56
      Height = 15
      Caption = 'CNPJ/CPF:'
    end
    object lbNomeFornecedor: TLabel
      Left = 310
      Top = 25
      Width = 116
      Height = 15
      Caption = 'Nome do Fornecedor:'
    end
    object txtCNPJCPF: TEdit
      Left = 5
      Top = 40
      Width = 280
      Height = 23
      Hint = 'Digite os n'#250'meros do CNPJ/CPF'
      MaxLength = 14
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = txtCNPJCPFKeyPress
    end
    object txtNomeFornecedor: TEdit
      Left = 310
      Top = 40
      Width = 280
      Height = 23
      Hint = 'Nome completo'
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyPress = txtCNPJCPFKeyPress
    end
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
      OnClick = tbuPesquisarClick
    end
    object tbuExcluir: TToolButton
      Left = 23
      Top = 0
      Hint = 'Excluir'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = tbuExcluirClick
    end
  end
end
