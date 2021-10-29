object frmClienteNotaFiscal: TfrmClienteNotaFiscal
  Left = 0
  Top = 0
  Caption = 'Cadastrar Cliente Notas Fiscais'
  ClientHeight = 376
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gbInfoCliente: TGroupBox
    Left = 8
    Top = 8
    Width = 738
    Height = 129
    Caption = 'Informa'#231#245'es do cliente:'
    TabOrder = 0
    object lbCNPJCPF: TLabel
      Left = 8
      Top = 24
      Width = 52
      Height = 13
      Caption = 'CNPJ/CPF:'
    end
    object lbNomeCliente: TLabel
      Left = 8
      Top = 70
      Width = 80
      Height = 13
      Caption = 'Nome do cliente:'
    end
    object txtCNPJCPF: TEdit
      Left = 8
      Top = 43
      Width = 705
      Height = 21
      TabOrder = 0
    end
    object txtNomeCliente: TEdit
      Left = 8
      Top = 89
      Width = 705
      Height = 21
      TabOrder = 1
    end
  end
  object gbContatoCliente: TGroupBox
    Left = 8
    Top = 160
    Width = 738
    Height = 169
    Caption = 'Contato do cliente:'
    TabOrder = 1
    object lbCEP: TLabel
      Left = 8
      Top = 24
      Width = 23
      Height = 13
      Caption = 'CEP:'
    end
    object lbRua: TLabel
      Left = 8
      Top = 70
      Width = 23
      Height = 13
      Caption = 'Rua:'
    end
    object lbEmail: TLabel
      Left = 8
      Top = 116
      Width = 28
      Height = 13
      Caption = 'Email:'
    end
    object lbBairro: TLabel
      Left = 393
      Top = 22
      Width = 29
      Height = 15
      Caption = 'Bairro:'
    end
    object lbNumero: TLabel
      Left = 393
      Top = 70
      Width = 41
      Height = 13
      Caption = 'N'#250'mero:'
    end
    object lbTelefone: TLabel
      Left = 393
      Top = 116
      Width = 46
      Height = 13
      Caption = 'Telefone:'
    end
    object txtCEP: TEdit
      Left = 8
      Top = 43
      Width = 320
      Height = 21
      TabOrder = 0
    end
    object txtRua: TEdit
      Left = 8
      Top = 89
      Width = 320
      Height = 21
      TabOrder = 1
    end
    object txtEmail: TEdit
      Left = 8
      Top = 135
      Width = 320
      Height = 21
      TabOrder = 2
    end
    object txtBairro: TEdit
      Left = 393
      Top = 43
      Width = 320
      Height = 21
      TabOrder = 3
    end
    object txtNumero: TEdit
      Left = 393
      Top = 89
      Width = 320
      Height = 21
      TabOrder = 4
    end
    object txtTelefone: TEdit
      Left = 393
      Top = 135
      Width = 320
      Height = 21
      TabOrder = 5
    end
  end
  object bntCancelar: TButton
    Left = 576
    Top = 335
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
  end
  object bntProximo: TButton
    Left = 671
    Top = 335
    Width = 75
    Height = 25
    Caption = 'Proximo'
    TabOrder = 3
  end
end
