unit UntClienteModel;

interface

uses
  UntPessoaModel;

type

  TClienteModel = class(TPessoaModel)
  public
    constructor Create();
    destructor Destroy(); override;
  end;

implementation

{ TClienteModel }

constructor TClienteModel.Create;
begin
  inherited Create();
end;

destructor TClienteModel.Destroy;
begin
   inherited;
end;

end.
