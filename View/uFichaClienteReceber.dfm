object frmCadFichaClieR: TfrmCadFichaClieR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Receber Ficha de Clientes'
  ClientHeight = 362
  ClientWidth = 670
  Color = 5723991
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 7
    Width = 656
    Height = 276
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 625
    ExplicitHeight = 280
    object Label1: TLabel
      Left = 44
      Top = 2
      Width = 46
      Height = 17
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
      FocusControl = DBEdit1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 116
      Top = 2
      Width = 51
      Height = 17
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 74
      Top = 94
      Width = 92
      Height = 17
      Alignment = taRightJustify
      Caption = 'Tipo de Contas:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 62
      Top = 125
      Width = 104
      Height = 17
      Alignment = taRightJustify
      Caption = 'Conta de Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 37
      Top = 154
      Width = 129
      Height = 17
      Alignment = taRightJustify
      Caption = 'Forma de Pagamento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 45
      Top = 209
      Width = 92
      Height = 17
      Caption = 'Valor Recebido:'
      FocusControl = DBEdit6
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 53
      Top = 237
      Width = 99
      Height = 17
      Caption = 'N'#250'mero Cheque:'
      FocusControl = DBEdit8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 86
      Top = 180
      Width = 55
      Height = 17
      Caption = 'Hist'#243'rico:'
      FocusControl = DBEdit7
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 6
      Top = 50
      Width = 614
      Height = 1
      Pen.Color = clGray
    end
    object Label9: TLabel
      Left = 126
      Top = 67
      Width = 39
      Height = 17
      Alignment = taRightJustify
      Caption = 'Cliente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 42
      Top = 19
      Width = 63
      Height = 23
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkFlat
      CharCase = ecUpperCase
      Ctl3D = False
      DataField = 'CODIGO'
      DataSource = dsFicha
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = True
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit5: TDBEdit
      Left = 111
      Top = 19
      Width = 150
      Height = 23
      TabStop = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkFlat
      CharCase = ecUpperCase
      Ctl3D = False
      DataField = 'DATA_EMISSAO'
      DataSource = dsFicha
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = True
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object DBLookupCombobox1: TDBLookupComboboxEh
      Left = 172
      Top = 94
      Width = 397
      Height = 23
      Ctl3D = False
      ParentCtl3D = False
      DynProps = <>
      DataField = 'FKPLANO'
      DataSource = dsFicha
      DropDownBox.AutoDrop = True
      EditButtons = <>
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      ListSource = dsPlano
      ParentFont = False
      TabOrder = 3
      Visible = True
    end
    object DBLookupComboboxEh1: TDBLookupComboboxEh
      Left = 172
      Top = 122
      Width = 397
      Height = 23
      Ctl3D = False
      ParentCtl3D = False
      DynProps = <>
      DataField = 'FK_CONTA'
      DataSource = dsFicha
      DropDownBox.AutoDrop = True
      EditButtons = <>
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      ListSource = dsConta
      ParentFont = False
      TabOrder = 4
      Visible = True
    end
    object DBLookupComboboxEh2: TDBLookupComboboxEh
      Left = 172
      Top = 151
      Width = 397
      Height = 23
      Ctl3D = False
      ParentCtl3D = False
      DynProps = <>
      DataField = 'FK_FPG'
      DataSource = dsFicha
      DropDownBox.AutoDrop = True
      EditButtons = <>
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      KeyField = 'CODIGO'
      ListField = 'DESCRICAO'
      ListSource = dsFPG
      ParentFont = False
      TabOrder = 5
      Visible = True
    end
    object DBEdit6: TDBEdit
      Left = 172
      Top = 207
      Width = 183
      Height = 23
      CharCase = ecUpperCase
      Color = clWhite
      Ctl3D = False
      DataField = 'ENTRADA'
      DataSource = dsFicha
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 7
    end
    object DBEdit8: TDBEdit
      Left = 172
      Top = 235
      Width = 183
      Height = 23
      CharCase = ecUpperCase
      Color = clWhite
      Ctl3D = False
      DataField = 'DOCUMENTO'
      DataSource = dsFicha
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 8
    end
    object DBEdit7: TDBEdit
      Left = 172
      Top = 179
      Width = 397
      Height = 23
      CharCase = ecUpperCase
      Color = clWhite
      Ctl3D = False
      DataField = 'HISTORICO'
      DataSource = dsFicha
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 6
    end
    object DBLookupComboboxEh4: TDBLookupComboboxEh
      Left = 172
      Top = 65
      Width = 397
      Height = 23
      Ctl3D = False
      ParentCtl3D = False
      DynProps = <>
      DataField = 'VIRTUAL_CLIENTE'
      DataSource = dsFicha
      DropDownBox.AutoDrop = True
      EditButtons = <>
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Visible = True
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 7
    Top = 290
    Width = 656
    Height = 65
    Margins.Left = 7
    Margins.Top = 0
    Margins.Right = 7
    Margins.Bottom = 7
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 222
    ExplicitWidth = 678
    object cxSair: TcxButton
      AlignWithMargins = True
      Left = 164
      Top = 7
      Width = 150
      Height = 51
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 0
      Margins.Bottom = 7
      Align = alLeft
      Caption = 'ESC | Sair'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'DevExpressDarkStyle'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D4948445200000024000000240806000000E10098
        9800000006624B474400FF00FF00FFA0BDA793000001B8494441545809ED9731
        4BC3401886EFB4E2225A070767712D1D4404057152D05FE0A28B8320A27F405A
        70757071101DDC0427C5A2E81270D0A5D05110574510A9ED52979ECF958B2458
        C8196D53F08EF7C977977CBDEFEB9B845221DC700E38075AEB80F4B7574A6599
        A7210995A594A550611AF2202979C28C2E133B26346B282FDB3470210F21356B
        2894D0EE856B28CAF15454827F9DD7AF9FF92804F5C0E356099EF8EDDCBA210A
        8DC3350435CBE20AFE4C719EA103AA8F19EE880DE1E00084F6632D6110BA1B49
        1687D00616F93AE589DB5434542836AD947AE44219AACC47A017F658EB736FC4
        0258294E435B14F33544956D18860CCC816E6283B80A97B0004760A594555638
        A9C0F20CB4AA1C4A3005E7B00BB7A09BF8202EE1648D68AD380DE9DBB5EF57C0
        AA75E637A0E30EB10C7ADF1E621FB4BCA1159A98A790967624C3E419EE61126A
        700813A07FB02F88299CDA24464A7F93C82493F0423C81A0DECD6291F80A6B70
        4CF13A4DD7992F0B2166E0147E2636D0DF86A072A24D836239D0F2841971DE32
        F3D1D604D75094AF1DE7D057C33C591E24254F98D1710E49D398C09A2CF33424
        A1EF7F8392E8C2D5740EFC0B073E019BA489A7F76494CD0000000049454E44AE
        426082}
      TabOrder = 1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = cxSairClick
    end
    object cxGravar: TcxButton
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 150
      Height = 51
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 0
      Margins.Bottom = 7
      Align = alLeft
      Caption = 'F5 | Salvar'
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'DevExpressDarkStyle'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D4948445200000024000000240806000000E10098
        9800000006624B474400FF00FF00FFA0BDA7930000015A494441545809ED97C1
        4A03311086274510C422052F82C8FA1E457C08117AF3A57AF1057C0E4F5E7B15
        948A072FA222F5E4C1F5FBB1420FDD24932A4AC9307F329B994CFE4CD25D6A56
        A55660CD2A1072F7D3B6ED88D83E58552F4208B3AE241E42539234B6BA1C8610
        EEAC43363AC663C38F383B77886F996A9D83658EE2318E6CDA7EC9993985690D
        F8D6C622D28BF8FEC4554C88ED8EC033988839BD6C61883D06B2C7F279A0B3F5
        C42FC66EF23000AF403A500394738B5ECFEA31F3B5B842F94BF822FF1D219537
        B905EEC3B199ED8145BDE6E11C3C01A96CF50F3497E01D5C819F55C81C813720
        BDA1D9F7AEC09CEC9F7D34378976C10C486F698A5E6ECCCB2694BA43DB3016E8
        EC8457FEBD8CDF44CF91FCC5115B1CEA2154BC8867622594AA56AD50AD50AA02
        297FBD43A90A657DEDE749267C933EE6B6B7CB3E090FA11D2F8B92F81421FDE5
        392D491C99A39C117775D50AAC59053E01A4C49B7FA08942B80000000049454E
        44AE426082}
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = cxGravarClick
    end
  end
  object qryFicha: TFDQuery
    BeforeOpen = qryFichaBeforeOpen
    AfterPost = qryFichaAfterPost
    AggregatesActive = True
    Connection = Dados.Conexao
    Transaction = Dados.Transacao
    UpdateTransaction = Dados.Transacao
    SQL.Strings = (
      'SELECT  * FROM PESSOA_CONTA'
      'WHERE'
      'CODIGO=:COD')
    Left = 432
    Top = 176
    ParamData = <
      item
        Name = 'COD'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryFichaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryFichaFKPESSOA: TIntegerField
      FieldName = 'FKPESSOA'
      Origin = 'FKPESSOA'
    end
    object qryFichaDATA_EMISSAO: TDateField
      FieldName = 'DATA_EMISSAO'
      Origin = 'DATA_EMISSAO'
      EditMask = '!99/99/0000;1;_'
    end
    object qryFichaDATA_VENCIMENTO: TDateField
      FieldName = 'DATA_VENCIMENTO'
      Origin = 'DATA_VENCIMENTO'
    end
    object qryFichaHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      Size = 50
    end
    object qryFichaFKVENDA: TIntegerField
      FieldName = 'FKVENDA'
      Origin = 'FKVENDA'
    end
    object qryFichaFKEMPRESA: TIntegerField
      FieldName = 'FKEMPRESA'
      Origin = 'FKEMPRESA'
    end
    object qryFichaFKPLANO: TIntegerField
      FieldName = 'FKPLANO'
      Origin = 'FKPLANO'
    end
    object qryFichaBLOQUEADO: TStringField
      FieldName = 'BLOQUEADO'
      Origin = 'BLOQUEADO'
      Size = 1
    end
    object qryFichaVIRTUAL_CLIENTE: TStringField
      FieldKind = fkLookup
      FieldName = 'VIRTUAL_CLIENTE'
      LookupDataSet = Dados.qryClientes
      LookupKeyFields = 'CODIGO'
      LookupResultField = 'RAZAO'
      KeyFields = 'FKPESSOA'
      Size = 50
      Lookup = True
    end
    object qryFichaENTRADA: TFMTBCDField
      FieldName = 'ENTRADA'
      Origin = 'ENTRADA'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryFichaSAIDA: TFMTBCDField
      FieldName = 'SAIDA'
      Origin = 'SAIDA'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryFichaDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
      Origin = 'DOCUMENTO'
      Size = 10
    end
    object qryFichaFKPEDIDO: TIntegerField
      FieldName = 'FKPEDIDO'
      Origin = 'FKPEDIDO'
      DisplayFormat = ',0.00'
    end
    object qryFichaFK_FPG: TIntegerField
      FieldName = 'FK_FPG'
      Origin = 'FK_FPG'
      DisplayFormat = ',0.00'
    end
    object qryFichaFK_CONTA: TIntegerField
      FieldName = 'FK_CONTA'
      Origin = 'FK_CONTA'
      DisplayFormat = ',0.00'
    end
    object qryFichaTTOTAL: TAggregateField
      FieldName = 'TTOTAL'
      Visible = True
      Active = True
      DisplayName = ''
      DisplayFormat = ',0.00'
      Expression = 'SUM(ENTRADA-SAIDA)'
    end
  end
  object dsFicha: TDataSource
    DataSet = qryFicha
    Left = 384
    Top = 176
  end
  object ACBrEnterTab1: TACBrEnterTab
    EnterAsTab = True
    Left = 304
    Top = 176
  end
  object qryCaixa: TFDQuery
    Connection = Dados.Conexao
    SQL.Strings = (
      'select * from caixa'
      'where'
      'FK_FICHA_CLI=:id')
    Left = 488
    Top = 176
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryCaixaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCaixaEMISSAO: TDateField
      FieldName = 'EMISSAO'
      Origin = 'EMISSAO'
    end
    object qryCaixaDOC: TStringField
      FieldName = 'DOC'
      Origin = 'DOC'
    end
    object qryCaixaFKPLANO: TIntegerField
      FieldName = 'FKPLANO'
      Origin = 'FKPLANO'
    end
    object qryCaixaFKCONTA: TIntegerField
      FieldName = 'FKCONTA'
      Origin = 'FKCONTA'
    end
    object qryCaixaHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Origin = 'HISTORICO'
      Size = 50
    end
    object qryCaixaFKVENDA: TIntegerField
      FieldName = 'FKVENDA'
      Origin = 'FKVENDA'
    end
    object qryCaixaFKCOMPRA: TIntegerField
      FieldName = 'FKCOMPRA'
      Origin = 'FKCOMPRA'
    end
    object qryCaixaFKPAGAR: TIntegerField
      FieldName = 'FKPAGAR'
      Origin = 'FKPAGAR'
    end
    object qryCaixaFKRECEBER: TIntegerField
      FieldName = 'FKRECEBER'
      Origin = 'FKRECEBER'
    end
    object qryCaixaTRANSFERENCIA: TIntegerField
      FieldName = 'TRANSFERENCIA'
      Origin = 'TRANSFERENCIA'
    end
    object qryCaixaBLOQUEADO: TStringField
      FieldName = 'BLOQUEADO'
      Origin = 'BLOQUEADO'
      Size = 1
    end
    object qryCaixaFK_CONTA1: TIntegerField
      FieldName = 'FK_CONTA1'
      Origin = 'FK_CONTA1'
    end
    object qryCaixaFK_PAI: TIntegerField
      FieldName = 'FK_PAI'
      Origin = 'FK_PAI'
    end
    object qryCaixaHORA_EMISSAO: TTimeField
      FieldName = 'HORA_EMISSAO'
      Origin = 'HORA_EMISSAO'
    end
    object qryCaixaECARTAO: TStringField
      FieldName = 'ECARTAO'
      Origin = 'ECARTAO'
      Size = 1
    end
    object qryCaixaID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
    end
    object qryCaixaEMPRESA: TIntegerField
      FieldName = 'EMPRESA'
      Origin = 'EMPRESA'
      Required = True
    end
    object qryCaixaFK_FICHA_CLI: TIntegerField
      FieldName = 'FK_FICHA_CLI'
      Origin = 'FK_FICHA_CLI'
    end
    object qryCaixaVISIVEL: TStringField
      FieldName = 'VISIVEL'
      Origin = 'VISIVEL'
      Size = 1
    end
    object qryCaixaDT_CADASTRO: TDateField
      FieldName = 'DT_CADASTRO'
      Origin = 'DT_CADASTRO'
    end
    object qryCaixaFK_DEVOLUCAO: TIntegerField
      FieldName = 'FK_DEVOLUCAO'
      Origin = 'FK_DEVOLUCAO'
    end
    object qryCaixaFK_CARTAO: TIntegerField
      FieldName = 'FK_CARTAO'
      Origin = 'FK_CARTAO'
    end
    object qryCaixaENTRADA: TFMTBCDField
      FieldName = 'ENTRADA'
      Origin = 'ENTRADA'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryCaixaSAIDA: TFMTBCDField
      FieldName = 'SAIDA'
      Origin = 'SAIDA'
      DisplayFormat = ',0.00'
      Precision = 18
      Size = 2
    end
    object qryCaixaSALDO: TFMTBCDField
      FieldName = 'SALDO'
      Origin = 'SALDO'
      Precision = 18
      Size = 2
    end
    object qryCaixaID_SUBCAIXA: TIntegerField
      FieldName = 'ID_SUBCAIXA'
      Origin = 'ID_SUBCAIXA'
      DisplayFormat = ',0.00'
    end
    object qryCaixaTIPO_MOVIMENTO: TStringField
      FieldName = 'TIPO_MOVIMENTO'
      Origin = 'TIPO_MOVIMENTO'
      Size = 2
    end
    object qryCaixaFPG: TIntegerField
      FieldName = 'FPG'
      Origin = 'FPG'
      DisplayFormat = ',0.00'
    end
  end
  object qryFPG: TFDQuery
    Connection = Dados.Conexao
    SQL.Strings = (
      'Select codigo, descricao from forma_pagamento'
      'where'
      'tipo not in ('#39'F'#39','#39'N'#39')'
      'ORDER BY DESCRICAO')
    Left = 389
    Top = 248
    object qryFPGCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      DisplayFormat = ',0.00'
    end
    object qryFPGDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 30
    end
  end
  object dsFPG: TDataSource
    DataSet = qryFPG
    Left = 437
    Top = 251
  end
  object dsConta: TDataSource
    DataSet = qryConta
    Left = 552
    Top = 246
  end
  object qryConta: TFDQuery
    Connection = Dados.Conexao
    SQL.Strings = (
      'Select * from contas'
      'where'
      'tipo<>'#39'S'#39
      'ORDER BY DESCRICAO')
    Left = 536
    Top = 176
    object qryContaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryContaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 40
    end
    object qryContaTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Size = 1
    end
    object qryContaID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
    end
    object qryContaEMPRESA: TIntegerField
      FieldName = 'EMPRESA'
      Origin = 'EMPRESA'
    end
    object qryContaDATA_ABERTURA: TDateField
      FieldName = 'DATA_ABERTURA'
      Origin = 'DATA_ABERTURA'
    end
    object qryContaLOTE: TIntegerField
      FieldName = 'LOTE'
      Origin = 'LOTE'
    end
    object qryContaSITUACAO: TStringField
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Size = 1
    end
  end
  object dsPlano: TDataSource
    DataSet = qryPlano
    Left = 528
    Top = 296
  end
  object qryPlano: TFDQuery
    Connection = Dados.Conexao
    SQL.Strings = (
      'Select * from plano'
      'where'
      'DC='#39'C'#39
      'ORDER BY DESCRICAO')
    Left = 472
    Top = 296
    object qryPlanoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPlanoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Required = True
      Size = 30
    end
    object qryPlanoDC: TStringField
      FieldName = 'DC'
      Origin = 'DC'
      Required = True
      Size = 1
    end
  end
end
