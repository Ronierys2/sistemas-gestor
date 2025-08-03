unit uRotinasComuns;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  System.SysUtils, System.Classes, REST.Types, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, System.RegularExpressions, Vcl.Dialogs;

type
  TPessoa = Record
    razao: String;
    fantasia: String;
    logradouro: String;
    numero: String;
    bairro: string;
    municipio: string;
    uf: string;
    cep: string;
    email: string;
    complemento: string;
    situacao: string;
    tipo: string;
    porte: string;
    cnae: string;
    ibge: string;
    telefone: string;
    socioAdministrador: string;
  public
    procedure Clear;
  End;

type
  TDMRotinas = class(TDataModule)
    RESTResponseCNPJ: TRESTResponse;
    RESTRequestCNPJ: TRESTRequest;
    RESTClientCNPJ: TRESTClient;
    RESTResponseDataCNPJ: TRESTResponseDataSetAdapter;
  private
    { Private declarations }
  public
    Pessoa: TPessoa;
    { Public declarations }
    procedure BuscaCNPJ(CNPJ: String);
  end;

var
  DMRotinas: TDMRotinas;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse código fonte.

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}


procedure TDMRotinas.BuscaCNPJ(CNPJ: String);
var
  jsonObject: TJsonObject;
  jsonArray: TJsonArray;
  rawCNAE, socios: string;
  i: Integer;
  jsonValueQSA: TJSONValue; // Variável temporária para verificar o tipo de 'qsa'
begin
  RESTRequestCNPJ.Resource := CNPJ;
  RESTRequestCNPJ.Execute;

  // É bom sempre verificar se a resposta é um JSON válido antes de tentar parsear
  if not RESTResponseCNPJ.Content.IsEmpty then
  begin
    jsonObject := TJsonObject.ParseJSONValue(RESTResponseCNPJ.Content) as TJsonObject;
  end
  else
  begin
    // Lida com a situação onde a resposta está vazia
    ShowMessage('A resposta da API está vazia.');
    Exit;
  end;

  if Assigned(jsonObject) then
  try
    Pessoa.razao := jsonObject.GetValue<string>('razao_social');
    Pessoa.fantasia := jsonObject.GetValue<string>('nome_fantasia');
    Pessoa.logradouro := jsonObject.GetValue<string>('descricao_tipo_de_logradouro') + ' ' + jsonObject.GetValue<string>('logradouro');
    Pessoa.numero := jsonObject.GetValue<string>('numero');
    Pessoa.bairro := jsonObject.GetValue<string>('bairro');
    Pessoa.municipio := jsonObject.GetValue<string>('municipio');
    Pessoa.uf := jsonObject.GetValue<string>('uf');
    Pessoa.cep := jsonObject.GetValue<string>('cep');
    Pessoa.email := jsonObject.GetValue<string>('email');
    Pessoa.complemento := jsonObject.GetValue<string>('complemento');
    Pessoa.situacao := jsonObject.GetValue<string>('descricao_situacao_cadastral');
    Pessoa.tipo := jsonObject.GetValue<string>('descricao_identificador_matriz_filial');
    Pessoa.porte := jsonObject.GetValue<string>('porte');
    Pessoa.telefone := jsonObject.GetValue<string>('ddd_telefone_1');
    Pessoa.cnae := jsonObject.GetValue<string>('cnae_fiscal');
    Pessoa.ibge := jsonObject.GetValue<string>('codigo_municipio_ibge');

    // Capturando sócios (QSA)
    socios := '';
    // **Ajuste principal aqui:** Verifique se a chave 'qsa' existe e não é nula antes de tentar acessá-la como um array.
    jsonValueQSA := jsonObject.GetValue('qsa'); // Pega o valor sem typecast direto

    if Assigned(jsonValueQSA) and (jsonValueQSA is TJsonArray) then
    begin
      jsonArray := jsonValueQSA as TJsonArray; // Agora o typecast é seguro
      if (jsonArray.Count > 0) then
      begin
        for i := 0 to jsonArray.Count - 1 do
        begin
          // Verifique se o item do array é um TJSONObject antes de tentar acessar suas propriedades
          if jsonArray.Items[i] is TJSONObject then
          begin
            if i > 0 then
              socios := socios + ', ';
            socios := socios + (jsonArray.Items[i] as TJSONObject).GetValue<string>('nome_socio');
          end;
        end;
      end;
    end
    else
    begin
      // O 'qsa' é nulo ou não é um TJsonArray, então não há sócios a serem processados.
      // 'socios' permanece vazio, o que é o comportamento esperado.
    end;
    Pessoa.socioAdministrador := socios; // Armazena os sócios na variável

  finally
    jsonObject.Free; // Garante que o objeto JSON seja liberado
  end
  else
  begin
    ShowMessage('Não foi possível parsear o JSON de resposta ou o objeto raiz é nulo.');
  end;
end;


procedure TPessoa.Clear;
begin
  razao := '';
  fantasia := '';
  logradouro := '';
  numero := '';
  bairro := '';
  municipio := '';
  uf := '';
  cep := '';
  email := '';
  complemento := '';
  situacao := '';
  tipo := '';
  porte := '';
  cnae := '';
  ibge := '';
  socioAdministrador := '';
end;

end.
