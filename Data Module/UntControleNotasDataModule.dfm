object DMControleNotas: TDMControleNotas
  OldCreateOrder = False
  Height = 150
  Width = 395
  object dsControleNotas: TDataSource
    DataSet = dsQuery
    Left = 56
    Top = 16
  end
  object dspControleNotas: TDataSetProvider
    DataSet = dsQuery
    Left = 272
    Top = 16
  end
  object dsQuery: TZQuery
    Connection = zConexao
    SQL.Strings = (
      
        'select id, idCliente, idFornecedor, idUsuario, chaveacesso, cont' +
        'role, descricao, emissao, valor from notas'
      
        'where idUsuario = 1 and emissao between '#39'2021-12-01'#39' and '#39'2021-1' +
        '2-14'#39)
    Params = <>
    Left = 160
    Top = 16
    object dsQueryid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object dsQueryidCliente: TIntegerField
      FieldName = 'idCliente'
    end
    object dsQueryidFornecedor: TIntegerField
      FieldName = 'idFornecedor'
    end
    object dsQueryidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object dsQuerychaveacesso: TWideStringField
      FieldName = 'chaveacesso'
      Required = True
      Size = 44
    end
    object dsQuerycontrole: TIntegerField
      FieldName = 'controle'
    end
    object dsQuerydescricao: TWideStringField
      FieldName = 'descricao'
      Required = True
      Size = 500
    end
    object dsQueryemissao: TDateField
      FieldName = 'emissao'
      Required = True
    end
    object dsQueryvalor: TFloatField
      FieldName = 'valor'
    end
  end
  object zConexao: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16')
    AutoCommit = False
    Connected = True
    SQLHourGlass = True
    HostName = 'localhost'
    Port = 3306
    Database = 'notafiscal'
    User = 'root'
    Password = 'root'
    Protocol = 'mysql'
    LibraryLocation = 'C:\Users\Ca'#237'que\Documents\GitHub\ControleNotas\bin\libmysql.dll'
    Left = 160
    Top = 88
  end
end
