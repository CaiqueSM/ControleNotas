object frmFornecedorNotaFiscal: TfrmFornecedorNotaFiscal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar fornecedor nota fiscal'
  ClientHeight = 305
  ClientWidth = 675
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
    Left = 0
    Top = 0
    Width = 665
    Height = 89
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
      Left = 8
      Top = 43
      Width = 320
      Height = 23
      TabOrder = 0
    end
    object txtNomeFornecedor: TEdit
      Left = 334
      Top = 43
      Width = 320
      Height = 23
      TabOrder = 1
    end
  end
  object gbContatoFornecedor: TGroupBox
    Left = 0
    Top = 95
    Width = 665
    Height = 169
    Caption = ' Contato fornecedor '
    TabOrder = 1
    object lbCEP: TLabel
      Left = 8
      Top = 24
      Width = 24
      Height = 15
      Caption = 'CEP:'
    end
    object lbRua: TLabel
      Left = 8
      Top = 70
      Width = 23
      Height = 15
      Caption = 'Rua:'
    end
    object lbEmail: TLabel
      Left = 8
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
    object txtCEP: TEdit
      Left = 8
      Top = 43
      Width = 320
      Height = 23
      TabOrder = 0
    end
    object txtRua: TEdit
      Left = 8
      Top = 89
      Width = 320
      Height = 23
      TabOrder = 1
    end
    object txtEmail: TEdit
      Left = 8
      Top = 135
      Width = 320
      Height = 23
      TabOrder = 2
    end
    object txtBairro: TEdit
      Left = 334
      Top = 43
      Width = 320
      Height = 23
      TabOrder = 3
    end
    object txtNumero: TEdit
      Left = 334
      Top = 89
      Width = 320
      Height = 23
      TabOrder = 4
    end
    object txtTelefone: TEdit
      Left = 334
      Top = 135
      Width = 320
      Height = 23
      TabOrder = 5
    end
  end
  object btnGravar: TButton
    Left = 592
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
  end
  object btnCancelar: TButton
    Left = 511
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 3
  end
end
