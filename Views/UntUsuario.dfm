object frmUsuario: TfrmUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar usu'#225'rio'
  ClientHeight = 251
  ClientWidth = 210
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
  object lbNomeUsuario: TLabel
    Left = 5
    Top = 27
    Width = 36
    Height = 15
    Caption = 'Nome:'
  end
  object lbSenha: TLabel
    Left = 5
    Top = 131
    Width = 65
    Height = 15
    Caption = 'Nova senha:'
  end
  object lbConfirmSenha: TLabel
    Left = 5
    Top = 176
    Width = 125
    Height = 15
    Caption = 'Confirme a nova senha:'
  end
  object Label1: TLabel
    Left = 5
    Top = 86
    Width = 64
    Height = 15
    Caption = 'Senha atual:'
  end
  object Shape1: TShape
    Left = 5
    Top = 73
    Width = 200
    Height = 1
    Pen.Color = clSilver
  end
  object txtNovaSenha: TEdit
    Left = 5
    Top = 146
    Width = 200
    Height = 23
    Hint = 'Informe a nova senha'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 1
    OnKeyPress = txtSenhaAtualKeyPress
  end
  object btnCadastar: TButton
    Left = 130
    Top = 220
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 3
    OnClick = btnCadastarClick
  end
  object btnCancelar: TButton
    Left = 49
    Top = 220
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object txtConfirmacaoNovaSenha: TEdit
    Left = 5
    Top = 191
    Width = 200
    Height = 23
    Hint = 'Confirme a nova senha'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 2
    OnKeyPress = txtSenhaAtualKeyPress
  end
  object txtSenhaAtual: TEdit
    Left = 5
    Top = 102
    Width = 200
    Height = 23
    Hint = 'Informe a senha atual'
    MaxLength = 16
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 0
    OnKeyPress = txtSenhaAtualKeyPress
  end
  object tobTop: TToolBar
    Left = 0
    Top = 0
    Width = 210
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
  object mskNomeUsuario: TMaskEdit
    Left = 5
    Top = 42
    Width = 200
    Height = 23
    Hint = 'Usu'#225'rio'
    EditMask = 'llllllllllllllllllll;1;_'
    MaxLength = 20
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = '                    '
  end
end
