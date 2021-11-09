unit UntContatoDao;

interface

uses
  untBaseDao, System.Generics.Collections, UntContatoModel, System.Classes,
  UntEnumContatoDao;

type

  TContatoDao = class(TBaseDao)
  public
    function ConsultarPorCliente(AIdCliente: Integer): TObjectList<TContatoModel>;





    function Consultar(ACodigo: integer; Enum: TEnumContatoDao): TContatoModel;
    function Criar(AContato: TContatoModel): Boolean;
    function Alterar(AContato: TContatoModel): Boolean;
    function Excluir(ACodigo: integer; Enum: TEnumContatoDao): Boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs, UntEmailModel, UntTelefoneModel,
  UntEmailDao, UntTelefoneDao;

{ TContatoDao }

function TContatoDao.Alterar(AContato: TContatoModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Update contato Set bairro = :bairro, CEP = :CEP, cidade = :cidade,' +
    'complemento = :complemento, numero = :numero, rua = :rua' +
    ' Where id = :id';

  query := CreateQuery(sql);
  Try
    with query do
    begin
      ParamByName('id').AsInteger := AContato.Id;
      ParamByName('bairro').AsString := AContato.Bairro;
      ParamByName('CEP').AsString := AContato.CEP;
	   ParamByName('cidade').AsString := AContato.Cidade;
      ParamByName('complemento').AsString := AContato.Complemento;
      ParamByName('numero').AsString := AContato.Numero;
      ParamByName('rua').AsString := AContato.Rua;
    end;

    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel atualizar os dados de contato.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.Consultar(ACodigo: integer; Enum: TEnumContatoDao)
  : TContatoModel;
var
  query: TZQuery;
  sql: String;
begin
  Result := TContatoModel.Create();

  case Enum of
    actContato:
      begin
        sql := 'select * from contato where id = :codigo';
      end;
    actCliente:
      begin
        sql := 'select * from contato where idcliente = :codigo';
      end;
    actFornecedor:
      begin
        sql := 'select * from contato where idfornecedor = :codigo';
      end;
  end;

  query := CreateQuery(sql);
  Try
    query.ParamByName('codigo').AsInteger := ACodigo;
    Try
      query.Open();

      with Result do
      begin
        Id := query.FieldByName('id').AsInteger;
        CEP := Trim(query.FieldByName('CEP').AsString);
		cidade:= Trim(query.FieldByName('cidade').AsString);
		bairro:= Trim(query.FieldByName('bairro').AsString);
        Complemento := Trim(query.FieldByName('complemento').AsString);
        Numero := Trim(query.FieldByName('numero').AsString);
        Rua := Trim(query.FieldByName('rua').AsString);
      end;

    Except
      on E: Exception do
        Showmessage('N�o foi poss�vel obter o contato.');
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.ConsultarPorCliente(
  AIdCliente: Integer): TObjectList<TContatoModel>;
var
  query: TZQuery;
  sql: String;
  contato: TContatoModel;
  emailDao: TEmailDao;
  telefoneDao: TTelefoneDao;
begin
  Result := TObjectList<TContatoModel>.Create();

  emailDao := TEmailDao.Create(Conexao);
  telefoneDao := TTelefoneDao.Create(Conexao);

  sql := 'select * from contato where idcliente = :codigo';
  query := CreateQuery(sql);
  Try
    query.ParamByName('codigo').AsInteger := AIdCliente;
    Try
      query.Open();
      While Not query.Eof Do
         Begin
            contato := TContatoModel.Create();
            contato.Id          := query.FieldByName('id').AsInteger;
            contato.IdCliente   := query.FieldByName('IdCliente').AsInteger;
            contato.CEP         := Trim(query.FieldByName('CEP').AsString);
            contato.Rua         := Trim(query.FieldByName('rua').AsString);
  	         contato.Cidade      := Trim(query.FieldByName('cidade').AsString);
            contato.Numero      := Trim(query.FieldByName('numero').AsString);
            contato.Bairro      := Trim(query.FieldByName('bairro').AsString);
            contato.Complemento := Trim(query.FieldByName('complemento').AsString);

            contato.Emails    := emailDao.Consultar(AIdCliente);
            contato.Telefones := telefoneDao.Consultar(AIdCliente);

            Result.Add(contato);
            query.Next;
         End;
    Except
      on E: Exception do
        Showmessage('N�o foi poss�vel obter o contato.');
    End;
  Finally
    query.Free;
    emailDao.Free;
    telefoneDao.Free;
  End;
end;

function TContatoDao.Criar(AContato: TContatoModel): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  sql := 'Insert Into Contato (idcliente, idfornecedor, bairro, CEP, cidade,' +
    'complemento, numero, rua)' +
    'Values (:idcliente, :idfornecedor, :bairro, :CEP, cidade,' +
    ':complemento, :numero, :rua)';

  query := CreateQuery(sql);
  Try
    with query do
    begin
      ParamByName('idcliente').AsInteger := AContato.IdCliente;
      ParamByName('idfornecedor').AsInteger := AContato.IdFornecedor;
      ParamByName('bairro').AsString := AContato.Bairro;
      ParamByName('CEP').AsString := AContato.CEP;
	   ParamByName('cidade').AsString := AContato.cidade;
      ParamByName('complemento').AsString := AContato.Complemento;
      ParamByName('numero').AsString := AContato.Numero;
      ParamByName('rua').AsString := AContato.Rua;
    end;

    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel gravar os dados de contato.');
      End;
    End;
  Finally
    query.Free;
  End;
end;

function TContatoDao.Excluir(ACodigo: integer; Enum: TEnumContatoDao): Boolean;
var
  query: TZQuery;
  sql: String;
begin
  Result := True;

  case Enum of
    actContato:
      begin
        sql := 'delete from cliente where id = :id';
      end;
    actCliente:
      begin
        sql := 'delete from cliente where idcliente = :id';
      end;
    actFornecedor:
      begin
        sql := 'delete from cliente where idfornecedor = :id';
      end;
  end;

  query := CreateQuery(sql);
  Try
    query.ParamByName('id').AsInteger := ACodigo;
    Try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('N�o foi poss�vel excluir o contato');
      End;
    End;
  Finally
    query.Free;
  End;
end;

end.
