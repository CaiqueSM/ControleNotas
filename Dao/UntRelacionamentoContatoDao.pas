unit UntRelacionamentoContatoDao;

interface

uses
  untBaseDao, UntRelacionamentoContatoModel, System.Classes, UntConexao;

type

  TRelacionamentoContatoDao = class(TBaseDao)
  public
    destructor Destroy; override;
    function Criar(ARelacionamento: TRelacionamentoContatoModel): boolean;
  end;

implementation

uses
  ZDataset, System.SysUtils, Vcl.Dialogs;
{ TRelacionamentoContatoDao }

function TRelacionamentoContatoDao.Criar(ARelacionamento
  : TRelacionamentoContatoModel): boolean;
var
  query: TZQuery;
  sql: String;
begin

  try
    Result := True;
    sql := 'Insert Into relacionamentocontato(idContato, idCliente, idFornecedor)' +
      ' Values(:idContato, :idCliente, :idFornecedor)';
    query := CreateQuery(sql);

    with query do
    begin
      ParamByName('idContato').AsInteger := ARelacionamento.idContato;
      ParamByName('idCliente').AsInteger := ARelacionamento.idCliente;
      ParamByName('idFornecedor').AsInteger := ARelacionamento.idFornecedor;
    end;
    try
      query.ExecSQL();

    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados do relacionamento.');
      End;
    end;
  finally
    if Assigned(query) then
      query.Free;
  end;

end;

destructor TRelacionamentoContatoDao.Destroy;
begin
  inherited;
end;

end.
