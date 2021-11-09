object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar cliente da nota fiscal'
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
  object gbInfoCliente: TGroupBox
    Left = 5
    Top = 80
    Width = 598
    Height = 85
    Caption = ' Informa'#231#245'es do cliente '
    TabOrder = 0
    object lbCNPJCPF: TLabel
      Left = 5
      Top = 25
      Width = 56
      Height = 15
      Caption = 'CNPJ/CPF:'
    end
    object lbNomeCliente: TLabel
      Left = 310
      Top = 25
      Width = 91
      Height = 15
      Caption = 'Nome do cliente:'
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
    end
    object txtNomeCliente: TEdit
      Left = 310
      Top = 40
      Width = 280
      Height = 23
      Hint = 'Nome completo'
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object gbContatoCliente: TGroupBox
    Left = 5
    Top = 164
    Width = 598
    Height = 169
    Caption = ' Contato do cliente '
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
      Left = 71
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
      TabOrder = 2
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
      TabOrder = 5
    end
    object txtBairro: TEdit
      Left = 310
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 32
      TabOrder = 1
    end
    object txtNumero: TEdit
      Left = 310
      Top = 86
      Width = 55
      Height = 23
      MaxLength = 9
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object txtComplemento: TEdit
      Left = 376
      Top = 86
      Width = 214
      Height = 23
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object mskTelefone: TMaskEdit
      Left = 310
      Top = 132
      Width = 280
      Height = 23
      EditMask = '!\(99\)00000-0000;1;_'
      MaxLength = 14
      TabOrder = 6
      Text = '(  )     -    '
    end
    object mskCEP: TMaskEdit
      Left = 5
      Top = 40
      Width = 55
      Height = 23
      Hint = 'CEP'
      EditMask = '00999-999;1;_'
      MaxLength = 9
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '     -   '
    end
    object txtCidade: TEdit
      Left = 70
      Top = 40
      Width = 215
      Height = 23
      Hint = 'Cidade'
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
  end
  object btnCancelar: TButton
    Left = 447
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object btnGravar: TButton
    Left = 528
    Top = 339
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
    OnClick = btnGravarClick
  end
  object gbCodigoCliente: TGroupBox
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
      Hint = 'C'#243'digo'
      MaxLength = 7
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyPress = txtCodigoKeyPress
    end
  end
  object tobTop: TToolBar
    Left = 0
    Top = 0
    Width = 609
    Height = 22
    Images = frmMenu.ListaImagens
    TabOrder = 5
    ExplicitWidth = 610
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
end
