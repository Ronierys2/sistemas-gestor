unit uGrupo;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Mask,
  DBCtrlsEh, ACBrBase, ACBrEnterTab, frxClass, frxDBSet, frxExportPDF,
  frxExportBaseDialog, frxExportXLS;

type
  TfrmGrupo = class(TForm)
    dsGrupo: TDataSource;
    PageControl1: TPageControl;
    Lista: TTabSheet;
    Cadastro: TTabSheet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBCheckBox1: TDBCheckBox;
    btnGravar: TSpeedButton;
    btnCancelar: TSpeedButton;
    bbNovo: TSpeedButton;
    bbAlterar: TSpeedButton;
    btnImp: TSpeedButton;
    frxReport: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxDBEmpresa: TfrxDBDataset;
    frxDBGrupo: TfrxDBDataset;
    ACBrEnterTab1: TACBrEnterTab;
    frxXLSExport1: TfrxXLSExport;
    GroupBox1: TGroupBox;
    edtLoc: TEdit;
    procedure FormShow(Sender: TObject);
    procedure edtLocChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtLocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbNovoClick(Sender: TObject);
    procedure bbAlterarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnImpClick(Sender: TObject);
    procedure edtLocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure localiza;
    procedure Botoes;
    { Private declarations }
  public
    idx: Integer;
    vOrdem: string;
    { Public declarations }
  end;

var
  frmGrupo: TfrmGrupo;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse c�digo fonte.

{$R *.dfm}

uses Udados;

procedure TfrmGrupo.bbAlterarClick(Sender: TObject);
begin
  if not bbAlterar.Visible then
    exit;

  if Dados.qryGrupo.IsEmpty then
    exit;

  PageControl1.ActivePage := Cadastro;
  Dados.qryGrupo.edit;
  Panel1.Enabled := true;
  DBEdit2.SetFocus;

end;

procedure TfrmGrupo.bbNovoClick(Sender: TObject);
begin
  if not bbNovo.Visible then
    exit;

  PageControl1.ActivePage := Cadastro;

  Dados.qryGrupo.Insert;
  Dados.qryGrupoCODIGO.Value := Dados.Numerador('GRUPO', 'CODIGO', 'N', '', '');
  Dados.qryGrupoATIVO.Value := 'S';
  Dados.qryGrupoEMPRESA.Value := Dados.qryEmpresaCODIGO.Value;
  Panel1.Enabled := true;
  DBEdit2.SetFocus;

end;

procedure TfrmGrupo.DBGrid1DblClick(Sender: TObject);
begin
  bbAlterarClick(self);
end;

procedure TfrmGrupo.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if odd((Sender as TDBGrid).DataSource.DataSet.RecNo) then
    (Sender as TDBGrid).Canvas.Brush.Color := $00F1ECE7
  else
    (Sender as TDBGrid).Canvas.Brush.Color := $00FAF8F5;

  if (gdSelected in State) then
  begin
    (Sender as TDBGrid).Canvas.Font.Color := clWhite;
    (Sender as TDBGrid).Canvas.Brush.Color := clGray;
  end;
  (Sender as TDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmGrupo.DBGrid1TitleClick(Column: TColumn);
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
  DBGrid1.Columns[1].Title.Caption := 'Descri��o';
  GroupBox1.Caption := 'F6 | Localizar <<' + DBGrid1.Columns[idx]
    .Title.Caption + '>>';

  DBGrid1.Columns[idx].Title.Caption := '>>' + DBGrid1.Columns[idx]
    .Title.Caption;

  edtLoc.Clear;

  edtLoc.SetFocus;

  for i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns[i].Title.Font.Style := [];

  DBGrid1.Columns[idx].Title.Font.Style := [fsbold];

  localiza;

end;

procedure TfrmGrupo.edtLocChange(Sender: TObject);
begin
  localiza;
end;

procedure TfrmGrupo.edtLocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_up then
    Dados.qryGrupo.Prior;
  if Key = VK_DOWN then
    Dados.qryGrupo.Next;
end;

procedure TfrmGrupo.edtLocKeyPress(Sender: TObject; var Key: Char);
begin
  if idx = 0 then
  begin
    if not(Key in ['0' .. '9', #8, #9, #13, #27]) then
      Key := #0;
  end;
end;

procedure TfrmGrupo.FormActivate(Sender: TObject);
begin
  Dados.vForm := nil;
  Dados.vForm := self;
  Dados.GetComponentes;
end;

procedure TfrmGrupo.FormCreate(Sender: TObject);
begin
  Dados.aMenu := 'MnGrupo';
  vOrdem := 'asc';
  Dados.Habilitacoes(Dados.aMenu, self.Name);
  Botoes;
end;

procedure TfrmGrupo.Botoes;
begin
  bbNovo.Visible := Dados.qryPermissoesBotaoINCLUIR.Value = 'S';
  bbAlterar.Visible := Dados.qryPermissoesBotaoEDITAR.Value = 'S';
end;

PRocedure TfrmGrupo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;

  if PageControl1.ActivePageIndex = 0 then
  begin
    if Key = vk_f2 then
    begin
      bbNovoClick(self);
      abort;
    end;
    if Key = vk_f3 then
    begin
      bbAlterarClick(self);
      abort;
    end;
    if Key = vk_f4 then
    begin
      btnImpClick(self);
      abort;
    end;
    if Key = vk_f6 then
    begin
      edtLoc.SetFocus;
      abort;
    end;
  end
  else
  begin
    if Key = VK_F5 then
      btnGravarClick(self);
    if Key = VK_ESCAPE then
      btnCancelarClick(self);
  end;

end;

procedure TfrmGrupo.FormShow(Sender: TObject);
begin
  idx := 0;
  PageControl1.ActivePage := Lista;
  DBGrid1TitleClick(DBGrid1.Columns[0]);
end;

procedure TfrmGrupo.localiza;
var
  parte, filtro, ordem: string;
begin
  filtro := '';
  ordem := '';
  parte := '';

  if Dados.qryEmpresaPESQUISA_POR_PARTE.AsString = 'S' then
    parte := '%';

  Dados.qryGrupo.SQL.Text := 'select * from grupo /*where*/';

  if trim(edtLoc.Text) <> '' then
    case idx of
      0:
        filtro := ' where codigo=' + edtLoc.Text;
      1:
        filtro := ' where descricao like ' +
          QuotedStr(parte + edtLoc.Text + '%');
    end;

  case idx of
    0:
      ordem := ' order by codigo ' + vOrdem;
    1:
      ordem := ' order by descricao ' + vOrdem;
  end;
  Dados.qryGrupo.Close;
  Dados.qryGrupo.SQL.Text := StringReplace(Dados.qryGrupo.SQL.Text, '/*where*/',
    filtro + ordem, [rfReplaceAll]);
  Dados.qryGrupo.Open;
end;

procedure TfrmGrupo.btnCancelarClick(Sender: TObject);
begin
  if Dados.qryGrupo.State in [dsInsert, dsEdit] then
    Dados.qryGrupo.Cancel;
  PageControl1.ActivePage := Lista;
  edtLoc.SetFocus;
end;

procedure TfrmGrupo.btnGravarClick(Sender: TObject);
begin
  if Dados.qryGrupo.State in [dsInsert, dsEdit] then
  begin

    DBEdit1.SetFocus;
    if trim(Dados.qryGrupoDESCRICAO.Value) = '' then
    begin
      ShowMessage('Digite o Descri��o!');
      DBEdit2.SetFocus;
      exit;
    end;

    Dados.qryGrupo.Post;
    Dados.Conexao.Commit;
  end;

  PageControl1.ActivePage := Lista;
  edtLoc.SetFocus;

end;

procedure TfrmGrupo.btnImpClick(Sender: TObject);
begin
  try
    btnImp.Enabled := false;
    if Dados.qryGrupo.IsEmpty then
    begin
      ShowMessage('Informa��es n�o encontradas!');
      exit;
    end;

    frxReport.LoadFromFile(ExtractFilePath(Application.ExeName) +
      '\Relatorio\RelGrupo.fr3');
    frxReport.ShowReport;
  finally
    btnImp.Enabled := true;
  end;
end;

end.
