unit uCadPessoa;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, acbrUtil,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, JPeg, Vcl.ExtDlgs,
  DBCtrlsEh, ACBrBase, ACBrEnterTab, DBGridEh, DBLookupEh, ACBrSocket, ACBrCEP,
  ACBrValidador, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, dxSkinDevExpressDarkStyle, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxSkinsCore,
  dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray;

type
  TfrmCadPessoa = class(TForm)
    dsClientes: TDataSource;
    OpenPicture: TOpenPictureDialog;
    ACBrEnterTab1: TACBrEnterTab;
    dsCidade: TDataSource;
    ACBrCEP1: TACBrCEP;
    ACBrValidador1: TACBrValidador;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet6: TTabSheet;
    Label28: TLabel;
    Label29: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    DBEdit14: TDBEdit;
    DBEdit23: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit10: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit20: TDBEdit;
    TabSheet5: TTabSheet;
    DBGrid1: TDBGrid;
    Label31: TLabel;
    DBMemo1: TDBMemo;
    dsContatos: TDataSource;
    qryContatos: TFDQuery;
    qryContatosCODIGO: TIntegerField;
    qryContatosFK_PESSOA: TIntegerField;
    qryContatosDATA_HORA: TSQLTimeStampField;
    qryContatosDATA_RETORNO: TDateField;
    qryContatosMOTIVO: TMemoField;
    qryContatosFK_USUARIO: TIntegerField;
    qryContatosFK_EMPRESA: TIntegerField;
    qryPessoa: TFDQuery;
    qryPessoaCODIGO: TIntegerField;
    qryPessoaRAZAO: TStringField;
    qryPessoaFANTASIA: TStringField;
    qryPessoaCNPJ: TStringField;
    qryContatosVIRTUAL_PESSOA: TStringField;
    qryContatosTITULO: TStringField;
    Label10: TLabel;
    DBComboBox3: TDBComboBox;
    Panel3: TPanel;
    Label32: TLabel;
    Label14: TLabel;
    Label36: TLabel;
    DBEdit25: TDBEdit;
    DBEdit27: TDBEdit;
    DBMemo2: TDBMemo;
    DBNavigator1: TDBNavigator;
    tabFoto: TTabSheet;
    DBImage1: TDBImage;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit19: TDBEdit;
    GroupBox2: TGroupBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBEdit9: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit22: TDBEdit;
    DBComboBoxEh1: TDBComboBoxEh;
    DBEdit7: TDBEdit;
    DBLookupComboboxEh1: TDBLookupComboboxEh;
    btnCEP: TBitBtn;
    BitBtn2: TBitBtn;
    Label16: TLabel;
    DBEdit21: TDBEdit;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    Label34: TLabel;
    DBComboBox4: TDBComboBox;
    Label27: TLabel;
    DBComboBoxEh2: TDBComboBoxEh;
    Label33: TLabel;
    DBComboBoxEh3: TDBComboBoxEh;
    DBEdit26: TDBEdit;
    Label35: TLabel;
    Label30: TLabel;
    Panel4: TPanel;
    cxSair: TcxButton;
    cxGravar: TcxButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBImage1Click(Sender: TObject);
    procedure dsClientesDataChange(Sender: TObject; Field: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCEPClick(Sender: TObject);
    procedure ACBrCEP1BuscaEfetuada(Sender: TObject);
    procedure DBLookupComboboxEh1Exit(Sender: TObject);
    procedure DBEdit22Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbEmpresaEnter(Sender: TObject);
    procedure cbEmpresaExit(Sender: TObject);
    procedure cbEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure DBLookupComboboxEh1Enter(Sender: TObject);
    procedure DBLookupComboboxEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBoxEh2Exit(Sender: TObject);
    procedure DBEdit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBEdit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure qryContatosNewRecord(DataSet: TDataSet);
    procedure qryContatosBeforeInsert(DataSet: TDataSet);
    procedure qryContatosBeforePost(DataSet: TDataSet);
    procedure qryContatosAfterPost(DataSet: TDataSet);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure qryContatosAfterEdit(DataSet: TDataSet);
    procedure cxGravarClick(Sender: TObject);
    procedure cxSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure VerificaPessoa;
    procedure MascaraCNPJCPF;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse c�digo fonte.

{$R *.dfm}

uses uPessoa, Udados, uRotinasComuns, uDmNFe;

procedure TfrmCadPessoa.ACBrCEP1BuscaEfetuada(Sender: TObject);
begin
  if ACBrCEP1.Enderecos.Count < 1 then
    ShowMessage('Nenhum Endere�o encontrado')
  else
  begin
    with ACBrCEP1.Enderecos[0] do
    begin
      Dados.qryPessoasENDERECO.Value :=
        UpperCase(Tipo_Logradouro + ' ' + Logradouro);
      Dados.qryPessoasBAIRRO.Value := UpperCase(Bairro);
      Dados.qryPessoasCOMPLEMENTO.Value := UpperCase(Complemento);
      Dados.qryPessoasMUNICIPIO.Value := UpperCase(Municipio);
      Dados.qryPessoasCODMUN.Value := StrToIntDef(IBGE_Municipio, 0);
      Dados.qryPessoasUF.AsString := UpperCase(uf);
    end;
  end;
end;

procedure TfrmCadPessoa.BitBtn1Click(Sender: TObject);
begin
  Dados.qryPessoasFOTO.Clear;
  DBImage1.Picture := nil;
end;

procedure TfrmCadPessoa.BitBtn2Click(Sender: TObject);
begin

  if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
  begin
    ACBrValidador1.TipoDocto := docCNPJ;
    ACBrValidador1.Documento := Dados.qryPessoasCNPJ.Value;
    if not ACBrValidador1.Validar then
      raise Exception.Create(ACBrValidador1.MsgErro);
  end;

  if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
  begin

    try
      dmrotinas.Pessoa.Clear;
      dmrotinas.BuscaCNPJ(tirapontos(DBEdit8.text));
      Dados.qryPessoasRAZAO.Value := UpperCase(dmrotinas.Pessoa.razao);
      Dados.qryPessoasFANTASIA.Value := UpperCase(dmrotinas.Pessoa.fantasia);
      if trim(Dados.qryPessoasFANTASIA.Value) = '' then
        Dados.qryPessoasFANTASIA.Value := UpperCase(dmrotinas.Pessoa.razao);
      Dados.qryPessoasENDERECO.Value := UpperCase(dmrotinas.Pessoa.Logradouro);
      Dados.qryPessoasNUMERO.Value := UpperCase(dmrotinas.Pessoa.numero);
      Dados.qryPessoasBAIRRO.Value := UpperCase(dmrotinas.Pessoa.Bairro);
      Dados.qryPessoasMUNICIPIO.Value := UpperCase(dmrotinas.Pessoa.Municipio);
      Dados.qryPessoasCOMPLEMENTO.Value := UpperCase(DMRotinas.Pessoa.complemento);
      Dados.qryPessoasUF.Value := UpperCase(dmrotinas.Pessoa.uf);
      Dados.qryPessoasCEP.Value := UpperCase(tirapontos(dmrotinas.Pessoa.cep));
      Dados.qryPessoasEMAIL1.Value := UpperCase(dmrotinas.Pessoa.email);
      Dados.qryPessoasFONE1.Value := UpperCase(dmrotinas.Pessoa.telefone);

 
      Dados.qryPessoasCODMUN.Value := dmrotinas.Pessoa.ibge.ToInteger;
       //Dados.BuscaCodigoIbge(Dados.qryPessoasMUNICIPIO.Value,
       //Dados.qryPessoasUF.Value);
      //Dados.BuscaCodigoIbge(dmrotinas.Pessoa.Municipio, Dados.qryPessoasUF.Value);

      dmNFe.ConsultaIE(tirapontos(DBEdit8.text), Dados.qryPessoasUF.Value);

    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  end
  else
    ShowMessage('N�o � possivel buscar informa��es de pessoas f�sicas!');
end;

procedure TfrmCadPessoa.btnCEPClick(Sender: TObject);
begin
  try
    ACBrCEP1.BuscarPorCEP(DBEdit5.EditText);
    DBEdit3.SetFocus;
  except
    On E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmCadPessoa.cbEmpresaEnter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := false;
end;

procedure TfrmCadPessoa.cbEmpresaExit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := true;
end;

procedure TfrmCadPessoa.cbEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SendMessage(Self.Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmCadPessoa.cxSairClick(Sender: TObject);
begin
if Dados.qryPessoas.State in [dsInsert, dsEdit] then
    Dados.qryPessoas.Cancel;
  close;
end;

procedure TfrmCadPessoa.cxGravarClick(Sender: TObject);
begin
if Dados.qryPessoas.State in [dsInsert, dsEdit] then
  begin

    PageControl1.ActivePageIndex := 0;

    DBEdit9.SetFocus;

    Dados.qryConsulta.close;
    Dados.qryConsulta.SQL.text :=
      'select codigo, razao from pessoa where razao=:razao and codigo<>:cod';
    Dados.qryConsulta.Params[0].Value := DBEdit2.text;
    Dados.qryConsulta.Params[1].Value := DBEdit1.text;
    Dados.qryConsulta.Open;
    if not Dados.qryConsulta.IsEmpty then
    begin
      if Application.messageBox('J� existe pessoa cadastrada com este NOME!' +
        sLineBreak + 'Deseja Continuar?', 'Confirma��o', mb_YesNo) = mrNo then
        exit;
    end;

    if (DBEdit8.text <> '') and (DBEdit8.text <> '000.000.000-00') and
      (DBEdit8.text <> '00.000.000/0000-00') then
    begin
      Dados.qryConsulta.close;
      Dados.qryConsulta.SQL.text :=
        'select codigo, cnpj, razao from pessoa where cnpj=:cnpj and codigo<>:cod';
      Dados.qryConsulta.Params[0].Value := DBEdit8.text;
      Dados.qryConsulta.Params[1].Value := DBEdit1.text;
      Dados.qryConsulta.Open;
      if not Dados.qryConsulta.IsEmpty then
      begin
        if Dados.qryEmpresaBLOQUEAR_CPF.Value = 'S' then
        begin
          raise Exception.Create
            ('J� existe pessoa cadastrada com este CPF/CNPJ!' + sLineBreak +
            Dados.qryPessoas.FieldByName('razao').AsString);
        end
        else
        begin
          if Application.messageBox
            ('J� existe pessoa cadastrada com este CPF/CNPJ!' + sLineBreak +
            'Deseja Continuar?', 'Confirma��o', mb_YesNo) = mrNo then
            exit;
        end;
      end;
    end;

    if Dados.qryPessoasTIPO.IsNull then
    begin
      ShowMessage('Selecione o Tipo de Pessoa!');
      DBComboBox1.SetFocus;
      exit;
    end;

    if Dados.qryPessoasTIPO.Value = 'F�SICA' then
    begin
      if Dados.qryPessoasCNPJ.AsString <> '000.000.000-00' then
      begin
        ACBrValidador1.TipoDocto := docCPF;
        ACBrValidador1.Documento := Dados.qryPessoasCNPJ.Value;
        if not ACBrValidador1.Validar then
          raise Exception.Create(ACBrValidador1.MsgErro);
      end;
    end;

    if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
    begin
      if Dados.qryPessoasCNPJ.AsString <> '00.000.000/0000-00' then
      begin
        ACBrValidador1.TipoDocto := docCNPJ;
        ACBrValidador1.Documento := Dados.qryPessoasCNPJ.Value;
        if not ACBrValidador1.Validar then
          raise Exception.Create(ACBrValidador1.MsgErro);
      end;
    end;

    if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
    begin
      if Dados.qryPessoasIE.AsString <> '0' then
      begin
        ACBrValidador1.TipoDocto := docInscEst;
        ACBrValidador1.Complemento := Dados.qryPessoasUF.Value;
        ACBrValidador1.Documento := Dados.qryPessoasIE.Value;
        if not ACBrValidador1.Validar then
          raise Exception.Create(ACBrValidador1.MsgErro);
      end;
    end;

    if trim(Dados.qryPessoasRAZAO.Value) = '' then
    begin
      ShowMessage('Digite o NOME! ou RAZ�O SOCIAL');
      DBEdit2.SetFocus;
      exit;
    end;

    if Trim(Dados.qryPessoasFANTASIA.Value) = '' then
    begin
      if Application.messageBox
            ('O campo APELIO/FANTASIA n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit22.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasCNPJ.Value) = '' then
    begin
      if Application.messageBox
            ('O campo CPF/CNPJ n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit8.SetFocus;
        Exit;
      end;
    end;


    if Trim(Dados.qryPessoasENDERECO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo ENDERE�O n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit3.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasNUMERO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo N�MERO n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit2.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasBAIRRO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo BAIRRO n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit4.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasMUNICIPIO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo MUNIC�PIO n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit6.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasCEP.Value) = '' then
    begin
      if Application.messageBox
            ('O campo CEP n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBEdit5.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasUF.Value) = '' then
    begin
      if Application.messageBox
            ('O campo UF n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBComboBoxEh1.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasISENTO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo TIPO DE CONTRIBUINTE n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBComboBoxEh2.SetFocus;
        Exit;
      end;
    end;

    if Trim(Dados.qryPessoasREGIME_TRIBUTARIO.Value) = '' then
    begin
      if Application.messageBox
            ('O campo REGIME TRIBUT�RIO n�o foi preenchido!' + sLineBreak +
            'Deseja prosseguir com o cadastro mesmo assim?', 'Confirma��o', mb_YesNo) = mrNo then
            //exit;
      begin
        DBComboBox4.SetFocus;
        Exit;
      end;
    end;


    if (qryContatos.State in dsEditModes) then
      qryContatos.Post;

    Dados.qryPessoas.Post;
    Dados.Conexao.Commit;
  end;
  frmCadPessoa.close;
end;

procedure TfrmCadPessoa.DBComboBox1Exit(Sender: TObject);
begin
  MascaraCNPJCPF;
end;

procedure TfrmCadPessoa.DBComboBoxEh2Exit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := true;
end;

procedure TfrmCadPessoa.DBEdit22Exit(Sender: TObject);
begin
  if (Dados.qryPessoas.State in dsEditModes) then
    if trim(DBEdit22.EditText) = '' then
    begin
      Dados.qryPessoasFANTASIA.Value := Dados.qryPessoasRAZAO.Value;
    end;
end;

procedure TfrmCadPessoa.DBEdit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f2 then
    btnCEP.Click;
end;

procedure TfrmCadPessoa.DBEdit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f2 then
    BitBtn2Click(Self);
end;

procedure TfrmCadPessoa.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    DBGrid1.Perform(WM_KEYDOWN, VK_TAB, 0);
end;

procedure TfrmCadPessoa.DBImage1Click(Sender: TObject);
var
  JPG: TJPegImage;
  Bmp: TBitmap;
begin
  if (Dados.qryPessoas.State in dsEditModes) then
  begin
    OpenPicture.Execute;
    if OpenPicture.FileName <> '' then
    begin
      JPG := TJPegImage.Create;
      JPG.LoadFromFile(OpenPicture.FileName);
      Bmp := TBitmap.Create;
      Bmp.Assign(JPG);
      JPG.Free;
      DBImage1.Picture.Bitmap.Assign(Bmp);
      Bmp.Free;
    end;
  end;

end;

procedure TfrmCadPessoa.DBLookupComboboxEh1Enter(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := false;
end;

procedure TfrmCadPessoa.DBLookupComboboxEh1Exit(Sender: TObject);
begin
  ACBrEnterTab1.EnterAsTab := true;
  Dados.qryPessoasMUNICIPIO.Value := Dados.qryCidadeDESCRICAO.Value;
end;

procedure TfrmCadPessoa.DBLookupComboboxEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    SendMessage(Self.Handle, WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmCadPessoa.dsClientesDataChange(Sender: TObject; Field: TField);
begin
  VerificaPessoa;

end;

procedure TfrmCadPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    cxSairClick(sender);
end;

procedure TfrmCadPessoa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_f5 then
    cxGravarClick(Self);
  if Key = VK_ESCAPE then
  begin
    if Application.messageBox('Tem Certeza de que deseja sair da tela?',
      'Confirma��o', mb_YesNo) = mrYes then
    begin
      cxsairClick(Self);
    end;
  end;
end;

procedure TfrmCadPessoa.FormShow(Sender: TObject);
begin

  MascaraCNPJCPF;

  Dados.qryPesqEmp.close;
  Dados.qryPesqEmp.Open;

  Dados.qryCidade.close;
  Dados.qryCidade.Open;

  qryContatos.close;
  qryContatos.Open;

  PageControl1.ActivePageIndex := 0;

end;

procedure TfrmCadPessoa.qryContatosAfterEdit(DataSet: TDataSet);
begin
  DBEdit25.SetFocus;
end;

procedure TfrmCadPessoa.qryContatosAfterPost(DataSet: TDataSet);
begin
  Dados.Conexao.Commit;
end;

procedure TfrmCadPessoa.qryContatosBeforeInsert(DataSet: TDataSet);
begin
  try
    if (Dados.qryPessoas.State in dsEditModes) then
      Dados.qryPessoas.Post;
    Dados.Conexao.Commit;
  except
    On E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TfrmCadPessoa.qryContatosBeforePost(DataSet: TDataSet);
begin
  if qryContatos.State = dsInsert then
    qryContatosCODIGO.Value := Dados.Numerador('PESSOA_CONTATO', 'CODIGO',
      'N', '', '');

end;

procedure TfrmCadPessoa.qryContatosNewRecord(DataSet: TDataSet);
begin
  qryContatosFK_PESSOA.Value := Dados.qryPessoasCODIGO.Value;
  qryContatosDATA_HORA.AsDateTime := now;
  qryContatosFK_USUARIO.Value := Dados.idUsuario;
  qryContatosFK_EMPRESA.Value := Dados.idEmpresa;
  DBEdit25.SetFocus;
end;

Procedure TfrmCadPessoa.VerificaPessoa;
begin

  DBEdit13.Visible := true;
  DBEdit18.Visible := true;
  DBEdit20.Visible := true;
  Label21.Visible := true;
  Label22.Visible := true;
  Label24.Visible := true;
  Label7.Visible := true;
  Label10.Visible := true;
  Label11.Caption := 'DT.Nascimento';
  DBCheckBox3.Enabled := true;
  DBEdit14.Enabled := true;
  DBEdit23.Enabled := true;

  if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
  begin
    DBCheckBox3.Enabled := false;
    Label11.Caption := 'DT.Abertura';
  end;
end;

procedure TfrmCadPessoa.MascaraCNPJCPF;
begin
  if Dados.qryPessoasTIPO.Value = 'JUR�DICA' then
    Dados.qryPessoasCNPJ.EditMask := '##.###.###/####-##;1;'
  else
    Dados.qryPessoasCNPJ.EditMask := '###.###.###-##;1;';
end;

end.
