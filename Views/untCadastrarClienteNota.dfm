object frmClienteNotaFiscal: TfrmClienteNotaFiscal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar cliente da nota fiscal'
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
  object gbInfoCliente: TGroupBox
    Left = 5
    Top = 0
    Width = 621
    Height = 85
    Caption = ' Informa'#231#245'es do cliente '
    TabOrder = 0
    object lbCNPJCPF: TLabel
      Left = 8
      Top = 26
      Width = 56
      Height = 15
      Caption = 'CNPJ/CPF:'
    end
    object lbNomeCliente: TLabel
      Left = 334
      Top = 26
      Width = 91
      Height = 15
      Caption = 'Nome do cliente:'
    end
    object txtCNPJCPF: TEdit
      Left = 5
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 14
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'Digite os n'#250'meros do CNPJ/CPF'
    end
    object txtNomeCliente: TEdit
      Left = 334
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 80
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TextHint = 'Nome completo'
    end
  end
  object gbContatoCliente: TGroupBox
    Left = 5
    Top = 90
    Width = 621
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
      NumbersOnly = True
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
      MaxLength = 32
      TabOrder = 2
      TextHint = 'Logradouro'
    end
    object txtEmail: TEdit
      Left = 5
      Top = 132
      Width = 280
      Height = 23
      MaxLength = 64
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TextHint = 'exemplo@email.com'
    end
    object txtBairro: TEdit
      Left = 334
      Top = 40
      Width = 280
      Height = 23
      MaxLength = 32
      TabOrder = 1
      TextHint = 'Nome do bairro'
    end
    object txtNumero: TEdit
      Left = 334
      Top = 86
      Width = 47
      Height = 23
      MaxLength = 9
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TextHint = '1234'
    end
    object txtComplemento: TEdit
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
    object txtTelefone: TMaskEdit
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
  object bntCancelar: TButton
    Left = 463
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object bntGravar: TButton
    Left = 544
    Top = 260
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
end
