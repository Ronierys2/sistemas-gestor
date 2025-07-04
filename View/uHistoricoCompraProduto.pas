unit uHistoricoCompraProduto;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEh, Vcl.Buttons, Vcl.ExtCtrls,
  dateutils,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, DBCtrlsEh, DBLookupEh, frxClass,
  frxDBSet, frxExportPDF, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxExportBaseDialog;

type
  TfrmHistoricoVendaProduto = class(TForm)
    Label1: TLabel;
    chkPeriodo: TCheckBox;
    MaskInicio: TDateTimePicker;
    MaskFim: TDateTimePicker;
    Panel3: TPanel;
    btnImp: TSpeedButton;
    bbSair: TSpeedButton;
    frxPDFExport1: TfrxPDFExport;
    frxReport: TfrxReport;
    frxDBEmpresa: TfrxDBDataset;
    qryproduto: TFDQuery;
    qryprodutoCODIGO: TIntegerField;
    qryprodutoDESCRICAO: TStringField;
    dsProduto: TDataSource;
    qryHistorico: TFDQuery;
    frxDBHistorico: TfrxDBDataset;
    qryHistoricoDATA: TDateField;
    qryHistoricoNUMERO: TIntegerField;
    qryHistoricoCODIGO: TIntegerField;
    qryHistoricoDESCRICAO: TStringField;
    qryHistoricoREFERENCIA: TStringField;
    cbRef: TDBLookupComboboxEh;
    Label2: TLabel;
    Label3: TLabel;
    cbCodigo: TDBLookupComboboxEh;
    qryCodigo: TFDQuery;
    StringField1: TStringField;
    dsCodigo: TDataSource;
    qryReferencia: TFDQuery;
    qryReferenciaCODIGO: TStringField;
    qryReferenciaREFERENCIA: TStringField;
    dsRef: TDataSource;
    qryHistoricoQTD: TFMTBCDField;
    qryHistoricoTOTAL: TFMTBCDField;
    Label5: TLabel;
    Label4: TLabel;
    cbTipo: TComboBox;
    Label6: TLabel;
    qryHistoricoR: TFDQuery;
    qryHistoricoRCODIGO: TIntegerField;
    qryHistoricoRREFERENCIA: TStringField;
    qryHistoricoRDESCRICAO: TStringField;
    qryHistoricoRQTD: TFMTBCDField;
    qryHistoricoRTOTAL: TFMTBCDField;
    cbProduto: TDBLookupComboboxEh;
    cbFornecedor: TDBLookupComboboxEh;
    cbGrupo: TDBLookupComboboxEh;
    qryCliente: TFDQuery;
    qryClienteCODIGO: TIntegerField;
    qryClienteRAZAO: TStringField;
    dsCliente: TDataSource;
    qryVendedor: TFDQuery;
    dsVendedor: TDataSource;
    qryVendedorCODIGO: TIntegerField;
    qryVendedorNOME: TStringField;
    dsGrupos: TDataSource;
    qryGrupos: TFDQuery;
    qryGruposCODIGO: TIntegerField;
    qryGruposDESCRICAO: TStringField;
    frxDBHistoricoR: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    procedure btnImpClick(Sender: TObject);
    procedure bbSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbRefExit(Sender: TObject);
    procedure cbCodigoExit(Sender: TObject);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    vSql: string;
    procedure Resumido;
    procedure Detalhado;
  public
    { Public declarations }
  end;

var
  frmHistoricoVendaProduto: TfrmHistoricoVendaProduto;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse código fonte.

{$R *.dfm}

uses Udados;

procedure TfrmHistoricoVendaProduto.bbSairClick(Sender: TObject);
begin
  close;
end;

Procedure TfrmHistoricoVendaProduto.Resumido;
var
  Cod1, Cod2: Integer;
  Data1, Data2: TDate;

begin
  Cod1 := 0;
  Cod2 := 1000000;
  Data1 := strtodate('01/01/1000');
  Data2 := strtodate('31/12/9999');

  if cbProduto.KeyValue <> null then
    if cbProduto.KeyValue <> 0 then
    begin
      Cod1 := cbProduto.KeyValue;
      Cod2 := cbProduto.KeyValue;
    end;

  if chkPeriodo.Checked then
  begin
    Data1 := MaskInicio.date;
    Data2 := MaskFim.date;
  end;

  qryHistoricoR.close;
  qryHistoricoR.Params[0].Value := Data1;
  qryHistoricoR.Params[1].Value := Data2;
  qryHistoricoR.Params[2].Value := Cod1;
  qryHistoricoR.Params[3].Value := Cod2;
  qryHistoricoR.Params[4].Value := '%';
  qryHistoricoR.Params[5].Value := '%';
  qryHistoricoR.Params[6].Value := '%';
  if cbFornecedor.KeyValue <> 0 then
    qryHistoricoR.Params[4].Value := cbFornecedor.KeyValue;
  if cbGrupo.KeyValue <> 0 then
    qryHistoricoR.Params[6].Value := cbGrupo.KeyValue;
  qryHistoricoR.Open;

  frxReport.LoadFromFile(ExtractFilePath(Application.ExeName) +
    '\Relatorio\RelProdutoCompraR.fr3');
  frxReport.ShowReport;

end;

procedure TfrmHistoricoVendaProduto.Detalhado;
var
  Cod1, Cod2: Integer;
  Data1, Data2: TDate;

begin
  Cod1 := 0;
  Cod2 := 1000000;
  Data1 := strtodate('01/01/1000');
  Data2 := strtodate('31/12/9999');

  if cbProduto.KeyValue <> null then
    if cbProduto.KeyValue <> 0 then
    begin
      Cod1 := cbProduto.KeyValue;
      Cod2 := cbProduto.KeyValue;
    end;

  if chkPeriodo.Checked then
  begin
    Data1 := MaskInicio.date;
    Data2 := MaskFim.date;
  end;

  qryHistorico.close;
  qryHistorico.Params[0].Value := Data1;
  qryHistorico.Params[1].Value := Data2;
  qryHistorico.Params[2].Value := Cod1;
  qryHistorico.Params[3].Value := Cod2;
  qryHistoricoR.Params[4].Value := '%';
  qryHistoricoR.Params[5].Value := '%';
  qryHistoricoR.Params[6].Value := '%';
  if cbCliente.KeyValue <> 0 then
    qryHistorico.Params[4].Value := cbCliente.KeyValue;
  if cbVendedor.KeyValue <> 0 then
    qryHistorico.Params[5].Value := cbVendedor.KeyValue;
  if cbGrupo.KeyValue <> 0 then
    qryHistorico.Params[6].Value := cbGrupo.KeyValue;
  qryHistorico.Open;

  frxReport.LoadFromFile(ExtractFilePath(Application.ExeName) +
    '\Relatorio\RelHistoricoVendaProduto.fr3');
  frxReport.ShowReport;

end;

procedure TfrmHistoricoVendaProduto.btnImpClick(Sender: TObject);
begin
  if cbTipo.ItemIndex = 0 then
    Resumido
  else
    Detalhado;
end;

procedure TfrmHistoricoVendaProduto.cbCodigoExit(Sender: TObject);
begin
  cbProduto.KeyValue := cbCodigo.KeyValue;
  cbRef.KeyValue := cbCodigo.KeyValue;
end;

procedure TfrmHistoricoVendaProduto.cbRefExit(Sender: TObject);
begin
  cbCodigo.KeyValue := cbRef.KeyValue;
  cbProduto.KeyValue := cbCodigo.KeyValue;
end;

procedure TfrmHistoricoVendaProduto.FormCreate(Sender: TObject);
begin
  MaskInicio.date := StartOfTheMonth(date);
  MaskFim.date := date;
  qryproduto.close;
  qryproduto.Open;

  qryReferencia.close;
  qryReferencia.Open;

  qryCodigo.close;
  qryCodigo.Open;

  qryCliente.close;
  qryCliente.Open;

  qryVendedor.close;
  qryVendedor.Open;

  qryGrupos.close;
  qryGrupos.Open;

  cbProduto.KeyValue := 0;
  cbRef.KeyValue := 0;
  cbCodigo.KeyValue := 0;
  cbVendedor.KeyValue := 0;
  cbCliente.KeyValue := 0;
  cbGrupo.KeyValue := 0;
  cbTipo.ItemIndex := 0;
end;

procedure TfrmHistoricoVendaProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_escape then
    close;
end;

procedure TfrmHistoricoVendaProduto.frxReportGetValue(const VarName: string;
  var Value: Variant);
var
  Filtro: String;
begin
  Filtro := '';

  if VarName = 'PARAMETRO' then
  begin
    if cbCliente.KeyValue <> 0 then
      Value := 'CLIENTE:' + cbCliente.KeyValue
    else
    if cbVendedor.KeyValue <> 0 then
      Value := '  VENDEDOR:' + cbVendedor.KeyValue
    else
    if cbGrupo.KeyValue <> 0 then
      Value := '  GRUPO:' + cbGrupo.KeyValue
    else
      value :='<Todos>';
  end;
end;

end.
