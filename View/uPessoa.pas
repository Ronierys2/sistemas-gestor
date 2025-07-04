unit uPessoa;
interface //Suporte e Vendas direto no Whatsapp (48)998463846
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Mask, System.UITypes,
  Vcl.Tabs, Vcl.ExtDlgs, JPeg, frxClass, frxExportPDF, frxDBSet,
  frxExportBaseDialog, frxExportXLS, dxSkinDevExpressDarkStyle, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxSkinsCore,
  dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray, dxSkinBasic, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom,
  dxSkinDarkSide, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinOffice2019Black,
  dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue;
type
  TfrmPessoas = class(TForm)
    dsClientes: TDataSource;
    TabSet2: TTabSet;
    frxDBClientes: TfrxDBDataset;
    frxReport: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxDBEmpresa: TfrxDBDataset;
    Panel4: TPanel;
    dsEmpresa: TDataSource;
    frxXLSExport1: TfrxXLSExport;
    TabSet1: TTabControl;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    edtLoc: TEdit;
    Panel1: TPanel;
    cxAlterar: TcxButton;
    cxAtualizar: TcxButton;
    cxImprimir: TcxButton;
    cxNovo: TcxButton;
    cxSair: TcxButton;
    Label3: TLabel;
    qryTemp: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocChange(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabSet2Click(Sender: TObject);
    procedure TabSet1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtLocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure frxReportGetValue(const VarName: string; var Value: Variant);
    procedure edtLocKeyPress(Sender: TObject; var Key: Char);
    procedure TabSet1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxNovoClick(Sender: TObject);
    procedure cxAlterarClick(Sender: TObject);
    procedure cxImprimirClick(Sender: TObject);
    procedure cxAtualizarClick(Sender: TObject);
    procedure cxSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure localiza;
    procedure tamanho;
    procedure ConsumidorFinal;
    procedure Botoes;
    { Private declarations }
  public
    idx: Integer;
    vOrdem: String;
    vSql: String;
    { Public declarations }
  end;
var
  frmPessoas: TfrmPessoas;
implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse c�digo fonte.
{$R *.dfm}
uses Udados, uCadPessoa, unit_msg_confirma, uSupervisor, uProdutos;
procedure TfrmPessoas.DBGrid1DblClick(Sender: TObject);
begin
  if cxAlterar.Visible then
    cxAlterarClick(self);
end;
procedure TfrmPessoas.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color := $00F1ECE7
  else
    (Sender as TDBGrid).Canvas.Brush.Color := $00FAF8F5;
  if (gdSelected in State) then
  begin
    (Sender as TDBGrid).Canvas.Font.Color := clBlack;
    (Sender as TDBGrid).Canvas.Brush.Color := clSilver;
    DBGrid1.Canvas.Font.Style := [fsbold];
  end
  else
    DBGrid1.Canvas.Font.Style := [];
  (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
procedure TfrmPessoas.DBGrid1TitleClick(Column: TColumn);
var
  i: Integer;
begin
  edtLoc.Clear;
  if idx = Column.Index then
  begin
    if vOrdem = ' ASC' then
      vOrdem := ' DESC'
    else
      vOrdem := ' ASC';
  end
  else
    vOrdem := ' ASC';
  idx := Column.Index;
  DBGrid1.Columns[0].Title.Caption := 'C�digo';
  DBGrid1.Columns[1].Title.Caption := 'Nome/Raz�o';
  DBGrid1.Columns[2].Title.Caption := 'Apelido/Fantasia';
  DBGrid1.Columns[3].Title.Caption := 'CPF/CNPJ';
  DBGrid1.Columns[4].Title.Caption := 'RG/IE';
  DBGrid1.Columns[5].Title.Caption := 'Endere�o';
  DBGrid1.Columns[6].Title.Caption := 'Cidade';
  DBGrid1.Columns[7].Title.Caption := 'UF';
  DBGrid1.Columns[8].Title.Caption := 'Recebimento';
  for i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[i].Title.Font.Style := [];
  GroupBox1.Caption := 'F6 | Localizar <<' + DBGrid1.Columns[idx]
    .Title.Caption + '>>';
  DBGrid1.Columns[idx].Title.Font.Style := [fsbold];
  GroupBox1.Caption := 'F6 | Localizar <<' + DBGrid1.Columns[idx]
    .Title.Caption + '>>';
  DBGrid1.Columns[idx].Title.Caption := '>>' + DBGrid1.Columns[idx]
    .Title.Caption;
  localiza;
  edtLoc.SetFocus;
end;
procedure TfrmPessoas.edtLocChange(Sender: TObject);
begin
  localiza;
end;
procedure TfrmPessoas.edtLocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_up then
    dados.qryPessoas.Prior;
  if Key = VK_DOWN then
    dados.qryPessoas.Next;
end;
procedure TfrmPessoas.edtLocKeyPress(Sender: TObject; var Key: Char);
begin
  if idx = 0 then
  begin
    if not(Key in ['0' .. '9', #8, #9, #13, #27]) then
      Key := #0;
  end;
end;
procedure TfrmPessoas.Botoes;
begin
  cxNovo.Visible := dados.qryPermissoesBotaoINCLUIR.Value = 'S';
  cxAlterar.Visible := dados.qryPermissoesBotaoEDITAR.Value = 'S';
end;
procedure TfrmPessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //frmPrincipal.dxStatusBar1.Panels[0].Text := '';
end;

procedure TfrmPessoas.FormCreate(Sender: TObject);
begin
  dados.aMenu := 'MnPessoas';
  dados.Habilitacoes(dados.aMenu, TForm(self).Name);
  Botoes;
end;
procedure TfrmPessoas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f2 then
  begin
    cxNovoClick(self);
    abort;
  end;
  if Key = vk_f3 then
  begin
    cxAlterarClick(self);
    abort;
  end;
  if Key = vk_f4 then
  begin
    cxImprimirClick(self);
    abort;
  end;
  if Key = vk_f5 then
  begin
    cxAtualizarClick(self);
    abort;
  end;
  if Key = vk_f6 then
  begin
    edtLoc.SetFocus;
    abort;
  end;

      // deleta pessoa                                                                   //upd6 - Wagner Elias
      if Key = VK_DELETE then
        begin
          // Exibir mensagem de confirma��o personalizada
          form_msg_confirmacao := Tform_msg_confirmacao.Create(frmPessoas);
          try
            form_msg_confirmacao.lbl_pergunta.Caption := 'Exclus�o de Registro?';
            form_msg_confirmacao.lbl_texto.Caption := 'Tem certeza que deseja excluir esse registro?';
            form_msg_confirmacao.ShowModal;

            if form_msg_confirmacao.bResposta = true then
            begin
              dados.vAutorizar := true;
              try
                frmSupervisor := TFrmSupervisor.Create(Application);
                dados.vAutorizar := false;
                frmSupervisor.ShowModal;
              finally
                frmSupervisor.Release;
              end;

              if not dados.vAutorizar then
              begin
                abort;
              end;

              // Verifica��o se o cliente � o "Consumidor Final"
              if dados.qryPessoas.FieldByName('CODIGO').AsInteger = 1 then
              begin
                    MessageDlgPos('Para o sistema funcionar de forma correta,' + sLineBreak +
                  'o cliente "Consumidor Final" n�o pode ser exclu�do!',
                  mtWarning, [mbOK], 0, -1, -1);
                abort;
              end;

              // Verifica��o na tabela VENDAS_MASTER
              with qryTemp do
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT COUNT(*) AS Total FROM VENDAS_MASTER WHERE ID_CLIENTE = :ID_CLIENTE');
                ParamByName('ID_CLIENTE').AsInteger := dados.qryPessoas.FieldByName('CODIGO').AsInteger;
                Open;

                if FieldByName('Total').AsInteger > 0 then
                begin
                  MessageDlgPos('Esse cliente possui movimenta��es e n�o pode ser exclu�do!',
                                mtWarning, [mbOK], 0, -1, -1);
                  abort;
                end;
              end;

              // Excluindo o registro
              try
                dados.qryPessoas.Delete;
              except
                on e: Exception do
                  MessageDlgPos('Erro ao tentar excluir o cliente: ' + e.Message,
                                mtError, [mbOK], 0, -1, -1);
              end;
            end;
          finally

          end;
          abort;
        end;

      //fim deleta pessoa

end;
procedure TfrmPessoas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  begin
    Key := #0;
    Perform(CM_DialogKey, Vk_Tab, 0);
  end;
end;
procedure TfrmPessoas.ConsumidorFinal;
begin
  if dados.qryPessoas.IsEmpty then
  begin
    dados.qryPessoas.Insert;
    dados.qryPessoasCODIGO.Value := dados.Numerador('PESSOA', 'CODIGO',
      'N', '', '');
    dados.qryPessoasATIVO.Value := 'S';
    dados.qryPessoasCLI.Value := 'S';
    dados.qryPessoasTIPO.Value := 'F�SICA';
    dados.qryPessoasRAZAO.Value := 'CONSUMIDOR FINAL';
    dados.qryPessoasFANTASIA.Value := 'CONSUMIDOR FINAL';
    dados.qryPessoasEMPRESA.Value := dados.qryEmpresaCODIGO.Value;
    dados.qryPessoasENDERECO.Value := '';
    dados.qryPessoasBAIRRO.Value := '';
    dados.qryPessoasNUMERO.Value := '';
    dados.qryPessoasCEP.Value := '';
    dados.qryPessoasFORN.Value := 'N';
    dados.qryPessoasFAB.Value := 'N';
    dados.qryPessoasCNPJ.Value := ' ';
    dados.qryPessoasIE.Value := ' ';
    dados.qryPessoasFUN.Value := 'N';
    dados.qryPessoasADM.Value := 'N';
    dados.qryPessoasLIMITE.Value := 0;
    dados.qryPessoasISENTO.Value := '2';
    dados.qryPessoasSALARIO.Value := 0;
    dados.qryPessoasCCF.Value := 'N';
    dados.qryPessoasSPC.Value := 'N';
    dados.qryPessoasTRAN.Value := 'N';
    dados.qryPessoasFATURA.Value := 'N';
    dados.qryPessoasCHEQUE.Value := 'N';
    dados.qryPessoasUF.Value := dados.qryEmpresaUF.Value;
    dados.qryPessoasCODMUN.Value := dados.qryEmpresaID_CIDADE.Value;
    dados.qryPessoasMUNICIPIO.Value := dados.qryEmpresaCIDADE.Value;
    dados.qryPessoas.Post;
  end;
end;
procedure TfrmPessoas.cxAlterarClick(Sender: TObject);
begin
  if cxAlterar.Visible = false then
    exit;
  if dados.qryPessoas.IsEmpty then
    exit;
  try
    cxAlterar.Enabled := false;
    frmCadPessoa := TfrmCadPessoa.Create(Application);
    dados.qryPessoas.edit;
    frmCadPessoa.ShowModal;
  finally
    cxAlterar.Enabled := true;
    frmCadPessoa.Release;
    edtLoc.SetFocus;
  end;
end;
procedure TfrmPessoas.cxAtualizarClick(Sender: TObject);
var
  codigo: Integer;
begin
  try
    cxAtualizar.Enabled := false;
    codigo := dados.qryPessoasCODIGO.Value;
    localiza;
    dados.qryPessoas.Locate('codigo', codigo, []);
  finally
    cxAtualizar.Enabled := true;
  end;
end;
procedure TfrmPessoas.cxImprimirClick(Sender: TObject);
begin
 try
    cxImprimir.Enabled := false;
    if dados.qryPessoas.IsEmpty then
    begin
      ShowMessage('Informa��es n�o encontradas!');
      exit;
    end;
    frxReport.LoadFromFile(ExtractFilePath(Application.ExeName) +
      '\Relatorio\RelPessoas.fr3');
    frxReport.ShowReport;
  finally
    cxImprimir.Enabled := true;
    edtLoc.SetFocus;
  end;
end;
procedure TfrmPessoas.cxNovoClick(Sender: TObject);
begin
if cxNovo.Visible = false then
    exit;
  try
    cxNovo.Enabled := false;
    frmCadPessoa := TfrmCadPessoa.Create(Application);
    dados.qryPessoas.Insert;
    dados.qryPessoasCODIGO.Value := dados.Numerador('PESSOA', 'CODIGO',
      'N', '', '');
    dados.qryPessoasATIVO.Value := 'S';
    dados.qryPessoasTIPO.Value := 'F�SICA';
    dados.qryPessoasCLI.Value := 'S';
    dados.qryPessoasEMPRESA.Value := dados.qryEmpresaCODIGO.Value;
    dados.qryPessoasFORN.Value := 'N';
    dados.qryPessoasFAB.Value := 'N';
    dados.qryPessoasIE.Value := '';
    dados.qryPessoasFUN.Value := 'N';
    dados.qryPessoasADM.Value := 'N';
    dados.qryPessoasLIMITE.Value := 0;
    dados.qryPessoasISENTO.Value := '2';
    dados.qryPessoasREGIME_TRIBUTARIO.Value := 'SIMPLES';
    dados.qryPessoasSALARIO.Value := 0;
    dados.qryPessoasCCF.Value := 'N';
    dados.qryPessoasSPC.Value := 'N';
    dados.qryPessoasTRAN.Value := 'N';
    dados.qryPessoasFATURA.Value := 'N';
    dados.qryPessoasCHEQUE.Value := 'N';
    dados.qryPessoasTECNICO.Value := 'N';
    dados.qryPessoasATENDENTE.Value := 'N';
    dados.qryPessoasUF.Value := dados.qryEmpresaUF.Value;
    dados.qryPessoasCODMUN.Value := dados.qryEmpresaID_CIDADE.Value;
    dados.qryPessoasMUNICIPIO.Value := dados.qryEmpresaCIDADE.Value;
    dados.qryPessoasDT_CADASTRO.Value := date;
    frmCadPessoa.ShowModal;
  finally
    cxNovo.Enabled := true;
    frmCadPessoa.Release;
    edtLoc.SetFocus;
  end;
end;
procedure TfrmPessoas.cxSairClick(Sender: TObject);
begin
close;
end;

procedure TfrmPessoas.FormShow(Sender: TObject);
begin
  idx := 0;
  vOrdem := ' ASC';
  edtLoc.SetFocus;
  tamanho;
  DBGrid1TitleClick(DBGrid1.Columns[idx]);
  if dados.qryPessoas.Active then
    ConsumidorFinal;
end;
procedure TfrmPessoas.frxReportGetValue(const VarName: string;
  var Value: Variant);
var
  filtro: string;
begin
  filtro := '';
  if edtLoc.Text <> '' then
    filtro := ' | FILTRO:' + edtLoc.Text;
  if VarName = 'PARAMETRO' then
  begin
    Value := 'TIPO:' + TabSet1.Tabs.Strings[TabSet1.TabIndex] + ' | SITUA��O:' +
      TabSet2.Tabs.Strings[TabSet2.TabIndex] + filtro + ' | ORDENADO: ' +
      copy(DBGrid1.Columns[idx].Title.Caption, 3, 100000);
  end;
end;
procedure TfrmPessoas.localiza;
var
  parte, filtro, filtro1, filtro2, ordem: string;
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      filtro := '';
      filtro1 := '';
      filtro2 := '';
      ordem := '';
      parte := '';
      if dados.qryEmpresaPESQUISA_POR_PARTE.Value = 'S' then
        parte := '%';
      vSql := 'select * from PESSOA where CODIGO>0 /*where*/  ';
      if (trim(edtLoc.Text) <> '') then
        case idx of
          0:
            filtro := filtro + ' and CODIGO=' + edtLoc.Text;
          1:
            filtro := filtro + ' and RAZAO LIKE ' +
              QuotedStr(parte + edtLoc.Text + '%');
          2:
            filtro := filtro + ' and FANTASIA LIKE ' +
              QuotedStr(parte + edtLoc.Text + '%');
          3:
            filtro := filtro + ' and CNPJ LIKE ' + QuotedStr(edtLoc.Text + '%');
          4:
            filtro := filtro + ' and IE LIKE ' + QuotedStr(edtLoc.Text + '%');
          5:
            filtro := filtro + ' and ENDERECO LIKE ' +
              QuotedStr(parte + edtLoc.Text + '%');
          6:
            filtro := filtro + ' and MUNICIPIO LIKE ' +
              QuotedStr(parte + edtLoc.Text + '%');
          7:
            filtro := filtro + ' and UF LIKE ' + QuotedStr(edtLoc.Text + '%');
          8:
            filtro := filtro + ' and TIPO_RECEBIMENTO LIKE ' +
              QuotedStr(edtLoc.Text + '%');
        end;
      case TabSet1.TabIndex of
        0:
          filtro1 := ' and cli=''S''';
        1:
          filtro1 := ' and fun=''S''';
        2:
          filtro1 := ' and forn=''S''';
        3:
          filtro1 := ' and adm=''S''';
        4:
          filtro1 := ' and parc=''S''';
      end;
      case TabSet2.TabIndex of
        0:
          filtro2 := ' and ATIVO=''S''';
        1:
          filtro2 := ' and ATIVO=''N''';
      end;
      case idx of
        0:
          ordem := ' order by CODIGO' + vOrdem;
        1:
          ordem := ' order by RAZAO' + vOrdem;
        2:
          ordem := ' order by FANTASIA' + vOrdem;
        3:
          ordem := ' order by CNPJ' + vOrdem;
        4:
          ordem := ' order by IE' + vOrdem;
        5:
          ordem := ' order by ENDERECO' + vOrdem;
        6:
          ordem := ' order by MUNICIPIO' + vOrdem;
        7:
          ordem := ' order by UF' + vOrdem;
        8:
          ordem := ' order by TIPO_RECEBIMENTO' + vOrdem;
      end;
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          dados.qryPessoas.Close;
          dados.qryPessoas.SQL.Text := vSql;
          dados.qryPessoas.SQL.Text := StringReplace(dados.qryPessoas.SQL.Text,
            '/*where*/', filtro + filtro1 + filtro2 + ordem, [rfReplaceAll]);
          dados.qryPessoas.Open;
        end);
    end).Start;
end;
procedure TfrmPessoas.TabSet1Change(Sender: TObject);
begin
  localiza;
end;
procedure TfrmPessoas.TabSet1Click(Sender: TObject);
begin
  localiza;
end;
procedure TfrmPessoas.tamanho;
begin
  DBGrid1.Columns[0].Width := round(Screen.Width * 0.05);
  DBGrid1.Columns[1].Width := round(Screen.Width * 0.25);
  DBGrid1.Columns[2].Width := round(Screen.Width * 0.21);
  DBGrid1.Columns[3].Width := round(Screen.Width * 0.10);
  DBGrid1.Columns[4].Width := round(Screen.Width * 0.10);
  DBGrid1.Columns[5].Width := round(Screen.Width * 0.25);
  DBGrid1.Columns[6].Width := round(Screen.Width * 0.19);
  DBGrid1.Columns[7].Width := round(Screen.Width * 0.02);
end;
procedure TfrmPessoas.TabSet2Click(Sender: TObject);
begin
  localiza;
end;
end.
