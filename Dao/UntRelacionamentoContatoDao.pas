unit UntRelacionamentoContatoDao;

interface

uses
  untBaseDao, UntRelacionamentoContatoModel, System.Classes, UntConexao;

type

  TRelacionamentoContatoDao = class(TBaseDao)
  public
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
    sql := 'Insert Into relacionamentocontato(idContato, idRelacionado)' +
      ' Values(:idContato, :idRelacionado)';
    query := CreateQuery(sql);

    with query do
    begin
      ParamByName('idContato').AsInteger := ARelacionamento.idContato;
      ParamByName('idRelacionado').AsInteger := ARelacionamento.idRelacionado;
    end;
    try
      query.ExecSQL();
      Conexao.Database.Commit;
    Except
      on E: Exception do
      Begin
        Result := False;
        Conexao.Database.Rollback;
        Showmessage('Não foi possível gravar os dados do relacionamento.');
      End;
    end;
  finally
    query.Free;
  end;

end;

end.
