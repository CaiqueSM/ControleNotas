object frmFornecedorNotaFiscal: TfrmFornecedorNotaFiscal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar fornecedor nota fiscal'
  ClientHeight = 291
  ClientWidth = 635
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
  object gbInfoFornecedor: TGroupBox
    Left = 5
    Top = 0
    Width = 621
    Height = 85
    Caption = ' Informa'#231#245'es do Fornecedor '
    TabOrder = 0
    object lbCNPJCPF: TLabel
      Left = 8
      Top = 26
      Width = 56
      Height = 15
      Caption = 'CNPJ/CPF:'
    end
    object lbNomeFornecedor: TLabel
      Left = 334
      Top = 26
      Width = 114
      Height = 15
      Caption = 'Nome do fornecedor:'
    end
    object txtCPFCNPJ: TEdit
      Left = 5
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 44
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Digite os n'#250'meros do CNPJ/CPF'
    end
    object txtNomeFornecedor: TEdit
      Left = 334
      Top = 40
      Width = 280
      Height = 23
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Nome completo'
    end
  end
  object gbContatoFornecedor: TGroupBox
    Left = 5
    Top = 90
    Width = 621
    Height = 169
    Caption = ' Contato fornecedor '
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
      Left = 334
      Top = 24
      Width = 34
      Height = 15
      Caption = 'Bairro:'
    end
    object lbNumero: TLabel
      Left = 334
      Top = 70
      Width = 47
      Height = 15
      Caption = 'N'#250'mero:'
    end
    object lbTelefone: TLabel
      Left = 334
      Top = 116
      Width = 47
      Height = 15
      Caption = 'Telefone:'
    end
    object lbComplemento: TLabel
      Left = 400
      Top = 70
      Width = 80
      Height = 15
      Caption = 'Complemento:'
    end
    object txtCEP: TEdit
      Left = 5
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = '__ ___ - ___'
    end
    object txtRua: TEdit
      Left = 5
      Top = 86
      Width = 280
      Height = 23
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Logradouro'
    end
    object txtEmail: TEdit
      Left = 5
      Top = 132
      Width = 280
      Height = 23
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TextHint = 'exemplo@email.com'
    end
    object txtBairro: TEdit
      Left = 334
      Top = 40
      Width = 280
      Height = 23
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TextHint = 'Nome do bairro'
    end
    object txtNumero: TEdit
      Left = 334
      Top = 86
      Width = 47
      Height = 23
      MaxLength = 9
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TextHint = '1234'
    end
    object txtTelefone: TEdit
      Left = 400
      Top = 86
      Width = 214
      Height = 23
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TextHint = 'Bloco, apto, casa'
    end
    object MaskEdit1: TMaskEdit
      Left = 334
      Top = 132
      Width = 280
      Height = 23
      EditMask = '!\(99\)0-0000-0000;1;_'
      MaxLength = 15
      TabOrder = 6
      Text = '(  ) -    -    '
    end
  end
  object btnGravar: TButton
    Left = 544
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 463
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
end
