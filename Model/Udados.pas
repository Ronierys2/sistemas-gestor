﻿unit Udados;

interface

uses
  System.SysUtils, Forms, dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus, Vcl.Dbgrids, Vcl.ComCtrls, Vcl.Tabs,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, Math,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, FireDAC.Comp.UI,
  FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param, FireDAC.DatS, acbrutil,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, IniFiles, WiniNet,
  System.Threading, System.Types, Winapi.Windows, Tlhelp32, DateUtils,
  Vcl.Themes, ACBrSATClass, Winsock, uDMForte, System.TypInfo,
  ACBrBase, ACBrBoleto, ACBrBoletoConversao, ACBrBoletoRetorno,
  System.Classes, IdBaseComponent, IdComponent, IdIPWatch, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, Vcl.AppEvnts, acbrutil.FilesIO;

const
  AF_UNSPEC = 0; // Suporta tanto IPv4 quanto IPv6
  GAA_FLAG_INCLUDE_PREFIX = $10;

type
  TIP_ADAPTER_ADDRESSES = record
    Alignment: ULONGLONG;
    Next: Pointer;
    AdapterName: PAnsiChar;
    FirstUnicastAddress: Pointer;
    FirstAnycastAddress: Pointer;
    FirstMulticastAddress: Pointer;
    FirstDnsServerAddress: Pointer;
    DnsSuffix: PWideChar;
    Description: PWideChar;
    FriendlyName: PWideChar;
    PhysicalAddress: array [0 .. 7] of Byte;
    PhysicalAddressLength: DWORD;
    Flags: DWORD;
    Mtu: DWORD;
    IfType: DWORD;
    OperStatus: DWORD;
    Ipv6IfIndex: DWORD;
    ZoneIndices: array [0 .. 15] of DWORD;
    FirstPrefix: Pointer;
    TransmitLinkSpeed: UInt64;
    ReceiveLinkSpeed: UInt64;
    FirstWinsServerAddress: Pointer;
    FirstGatewayAddress: Pointer;
    Ipv4Metric: DWORD;
    Ipv6Metric: DWORD;
    Luid: UInt64;
    Dhcpv4Server: Pointer;
    CompartmentId: DWORD;
    NetworkGuid: TGUID;
    ConnectionType: DWORD;
    TunnelType: DWORD;
    Dhcpv6Server: Pointer;
    Dhcpv6ClientDuid: array [0 .. 129] of Byte;
    Dhcpv6ClientDuidLength: DWORD;
    Dhcpv6Iaid: DWORD;
  end;

  PIP_ADAPTER_ADDRESSES = ^TIP_ADAPTER_ADDRESSES;

function GetAdaptersAddresses(Family: ULONG; Flags: ULONG; Reserved: Pointer;
  AdapterAddresses: PIP_ADAPTER_ADDRESSES; var SizePointer: ULONG): DWORD;
  stdcall; external 'iphlpapi.dll';

type
  TEmail = record
    usuario: String;
    Senha: String;
    servidor: string;
    porta: string;
    SSL: boolean;
    TLS: boolean;
  public
    procedure GetEmail;
  end;

  TDados = class(TDataModule)
    Conexao: TFDConnection;
    Transacao: TFDTransaction;
    WaitCursor: TFDGUIxWaitCursor;
    qryPessoas: TFDQuery;
    qryGrupo: TFDQuery;
    qryUnidade: TFDQuery;
    qryNumerador: TFDQuery;
    qryExecute: TFDQuery;
    qryFornecedor: TFDQuery;
    qryContas: TFDQuery;
    qryPlano: TFDQuery;
    qryPlanoCODIGO: TIntegerField;
    qryPlanoDC: TStringField;
    qryCaixa: TFDQuery;
    qryCaixaTSALDO: TExtendedField;
    qryCaixaTENTRADA: TAggregateField;
    qryCaixaTSAIDA: TAggregateField;
    qryCaixaCODIGO: TIntegerField;
    qryCaixaEMISSAO: TDateField;
    qryCaixaDOC: TStringField;
    qryCaixaFKPLANO: TIntegerField;
    qryCaixaFKCONTA: TIntegerField;
    qryCaixaHISTORICO: TStringField;
    qryCaixaFKVENDA: TIntegerField;
    qryCaixaFKCOMPRA: TIntegerField;
    qryCaixaFKPAGAR: TIntegerField;
    qryCaixaFKRECEBER: TIntegerField;
    qryCaixaTRANSFERENCIA: TIntegerField;
    qryCR: TFDQuery;
    qryCRTTOTAL: TAggregateField;
    qryCRTJUROS: TAggregateField;
    qryCRTDESCONTO: TAggregateField;
    qryCRTRECEBIDO: TAggregateField;
    qryCRTSALDO: TAggregateField;
    qryCRCODIGO: TIntegerField;
    qryCRDATA: TDateField;
    qryCRFKCLIENTE: TIntegerField;
    qryCRDOC: TStringField;
    qryCRDTVENCIMENTO: TDateField;
    qryCRHISTORICO: TStringField;
    qryCRDATA_RECEBIMENTO: TDateField;
    qryCRSITUACAO: TStringField;
    qryCRRAZAO: TStringField;
    qrySomaRec: TFDQuery;
    qryCP: TFDQuery;
    AggregateField1: TAggregateField;
    AggregateField2: TAggregateField;
    AggregateField3: TAggregateField;
    AggregateField4: TAggregateField;
    AggregateField5: TAggregateField;
    qryCPCODIGO: TIntegerField;
    qryCPDATA: TDateField;
    qryCPFKFORNECE: TIntegerField;
    qryCPDOC: TStringField;
    qryCPDTVENCIMENTO: TDateField;
    qryCPHISTORICO: TStringField;
    qryCPDATA_PAGAMENTO: TDateField;
    qryCPSITUACAO: TStringField;
    qryCPFKEMPRESA: TIntegerField;
    qryCPRAZAO: TStringField;
    qrySomaPaga: TFDQuery;
    qryProd: TFDQuery;
    qryEmpresa: TFDQuery;
    qryConsulta: TFDQuery;
    qryUsuarios: TFDQuery;
    qryVendedor: TFDQuery;
    qryItensO: TFDQuery;
    qryFPG: TFDQuery;
    qryFPGCODIGO: TIntegerField;
    qryFPGDESCRICAO: TStringField;
    qryFPGGERACR: TStringField;
    qryFPGGERACH: TStringField;
    qryFPGECARTAO: TStringField;
    qryFPGUSAVD: TStringField;
    qryFPGUSACR: TStringField;
    qryFPGATIVO: TStringField;
    qryTerminal: TFDQuery;
    qryConfig: TFDQuery;
    qryConfigEMPRESA: TSmallintField;
    qryConfigTIPO_EMISSAO: TSmallintField;
    qryConfigSENHACERTIFICADO: TStringField;
    qryConfigATUALIZARXML: TStringField;
    qryConfigVISUALIZAERROSCHEMA: TStringField;
    qryConfigFORMATOALERTA: TStringField;
    qryConfigFORMAEMISSAO: TSmallintField;
    qryConfigMODELODF: TSmallintField;
    qryConfigVERSAODF: TSmallintField;
    qryConfigIDTOKEN: TStringField;
    qryConfigTOKEN: TStringField;
    qryConfigRETIRARACENTOS: TStringField;
    qryConfigSALVARGERAL: TStringField;
    qryConfigPATHSALVAR: TStringField;
    qryConfigPATHSCHEMAS: TStringField;
    qryConfigUF: TStringField;
    qryConfigAMBIENTE: TSmallintField;
    qryConfigVISUALIZAR: TStringField;
    qryConfigSALVARSOAP: TStringField;
    qryConfigAJUSTARAUTO: TStringField;
    qryConfigAGUARDAR: TSmallintField;
    qryConfigTENTATIVAS: TSmallintField;
    qryConfigINTERVALO: TSmallintField;
    qryConfigSALVARARQUIVO: TStringField;
    qryConfigPASTAMENSAL: TStringField;
    qryConfigLITERAL: TStringField;
    qryConfigEMISSAOPATHNFE: TStringField;
    qryConfigSALVARPATHEVENTO: TStringField;
    qryConfigSEPARARPORCNPJ: TStringField;
    qryConfigSEPARARPORMODELO: TStringField;
    qryConfigPATHNFE: TStringField;
    qryConfigPATHCAN: TStringField;
    qryConfigPATHINUTI: TStringField;
    qryConfigPATHDPEC: TStringField;
    qryConfigPATHCCE: TStringField;
    qryConfigPATHEVENTO: TStringField;
    qryConfigPATHPDF: TStringField;
    qryConfigEMAILHOST: TStringField;
    qryConfigEMAILPORTA: TStringField;
    qryConfigEMAILSENHA: TStringField;
    qryConfigEMAILASSUNTO: TStringField;
    qryConfigEMAILSSL: TStringField;
    qryConfigEMAILMSG: TMemoField;
    qryConfigDANFETIPO: TSmallintField;
    qryConfigATIVO: TStringField;
    qryConfigLOGOMARCA: TStringField;
    qryConfigNUMERO: TIntegerField;
    qryConfigSERIE: TStringField;
    qryConfigFAZENTREGA: TStringField;
    qryConfigNCOPIAS: TSmallintField;
    qryConfigGERA_FI_ES: TStringField;
    qryConfigPESQUISA: TStringField;
    qryConfigCLIENTE_PADRAO: TIntegerField;
    qryConfigPRODUTO_LIBERADO: TIntegerField;
    qryConfigPRODUTO_LIBERADO2: TIntegerField;
    qryConfigSENHA_CONSULTA: TStringField;
    qryConfigPRODUTO_SERVICO: TIntegerField;
    qryCaixaBLOQUEADO: TStringField;
    qryCaixaFK_CONTA1: TIntegerField;
    qryCaixaFK_PAI: TIntegerField;
    qryTransf: TFDQuery;
    qryConfigCRYPTLIB: TStringField;
    qryConfigHTTPLIB: TStringField;
    qryConfigXMLSIGN: TStringField;
    qryCidade: TFDQuery;
    qryCFOP: TFDQuery;
    qryCFOPCODIGO: TIntegerField;
    qryCFOPDESCRICAO: TStringField;
    qryCFOPTIPO: TStringField;
    qryChave: TFDQuery;
    qryCaixaECARTAO: TStringField;
    qryResumoCaixa: TFDQuery;
    qryResumoCaixaID_FORMA: TIntegerField;
    qryResumoCaixaDESCRICAO: TStringField;
    qryResumoCaixaTIPO: TStringField;
    qryResumoCaixaTOTAL: TBCDField;
    qryTransp: TFDQuery;
    qryTranspCODIGO: TIntegerField;
    qryTranspPESSOA: TStringField;
    qryTranspCNPJ: TStringField;
    qryTranspIE: TStringField;
    qryTranspNOME: TStringField;
    qryTranspAPELIDO: TStringField;
    qryTranspENDERECO: TStringField;
    qryTranspNUMERO: TStringField;
    qryTranspBAIRRO: TStringField;
    qryTranspCOD_CIDADE: TIntegerField;
    qryTranspCIDADE: TStringField;
    qryTranspUF: TStringField;
    qryTranspCEP: TStringField;
    qryTranspPLACA: TStringField;
    qryTranspUFPLACA: TStringField;
    qryTranspRNTC: TStringField;
    qryTranspATIVO: TStringField;
    qryTranspEMPRESA: TIntegerField;
    qryConfigPATHINUTI_NFE: TStringField;
    qryConfigPATHDPEC_NFE: TStringField;
    qryConfigPATHCCE_NFE: TStringField;
    qryConfigPATHEVENTO_NFE: TStringField;
    qryConfigPATHPDF_NFE: TStringField;
    qryConfigSERIE_NFE: TIntegerField;
    qryConfigPATHSALVARNFE: TStringField;
    qryConfigPATHSCHEMAS_NFE: TStringField;
    qryConfigPATHENVIADA_NFE: TStringField;
    qryConfigPATHCAN_NFE: TStringField;
    qryConfigVERSAONFE: TSmallintField;
    qryCaixaHORA_EMISSAO: TTimeField;
    qryCaixaID_USUARIO: TIntegerField;
    qryVdd: TFDQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    StringField2: TStringField;
    qryConfigVENDEDOR_PADRAO: TIntegerField;
    qryTelas: TFDQuery;
    qryTelasCODIGO: TIntegerField;
    qryPermissoes: TFDQuery;
    qryPermissoesFKUSUARIO: TIntegerField;
    qryTelasNIVEL: TSmallintField;
    qryTelasPAI: TSmallintField;
    qryCPFK_COMPRA: TIntegerField;
    qryCaixaEMPRESA: TIntegerField;
    qryCRFKEMPRESA: TIntegerField;
    qryCRFK_VENDA: TIntegerField;
    qryCRFKCONTA: TIntegerField;
    qryFPGTIPO: TStringField;
    qryFPGFKCONTADESTINO: TIntegerField;
    qryCartao: TFDQuery;
    qryCartaoCODIGO: TIntegerField;
    qryCartaoPARCELA: TIntegerField;
    qryCartaoDOC: TStringField;
    qryCartaoID_FPG: TIntegerField;
    qryCartaoID_CLIENTE: TIntegerField;
    qryCartaoVALOR: TBCDField;
    qryCartaoDATA_EMISSAO: TDateField;
    qryCartaoDATA_BAIXA: TDateField;
    qryCartaoFK_VENDA: TIntegerField;
    qryCartaoFK_CONTASRECEBER: TIntegerField;
    qryCartaoSITUACAO: TStringField;
    qryCartaoFKEMPRESA: TIntegerField;
    qryCartaoHISTORICO: TStringField;
    qryCartaoTVALOR: TAggregateField;
    qryNFCE_M: TFDQuery;
    QRYNFCE_D: TFDQuery;
    qryNFCE_MCODIGO: TIntegerField;
    qryNFCE_MNUMERO: TIntegerField;
    qryNFCE_MCHAVE: TStringField;
    qryNFCE_MMODELO: TStringField;
    qryNFCE_MSERIE: TStringField;
    qryNFCE_MDATA_EMISSAO: TDateField;
    qryNFCE_MDATA_SAIDA: TDateField;
    qryNFCE_MHORA_EMISSAO: TTimeField;
    qryNFCE_MHORA_SAIDA: TTimeField;
    qryNFCE_MID_EMITENTE: TIntegerField;
    qryNFCE_MID_CLIENTE: TIntegerField;
    qryNFCE_MFK_USUARIO: TIntegerField;
    qryNFCE_MFK_CAIXA: TIntegerField;
    qryNFCE_MFK_VENDEDOR: TIntegerField;
    qryNFCE_MCPF_NOTA: TStringField;
    qryNFCE_MTIPO_DESCONTO: TStringField;
    qryNFCE_MOBSERVACOES: TMemoField;
    qryNFCE_MSITUACAO: TStringField;
    qryNFCE_MEMAIL: TStringField;
    qryNFCE_MXML: TMemoField;
    qryNFCE_MPROTOCOLO: TStringField;
    qryNFCE_MMOTIVOCANCELAMENTO: TStringField;
    qryNFCE_MFLAG: TStringField;
    qryNFCE_MABERTO: TStringField;
    qryNFCE_MFKEMPRESA: TIntegerField;
    qryNFCE_MFK_VENDA: TIntegerField;
    QRYNFCE_DCODIGO: TIntegerField;
    QRYNFCE_DFKVENDA: TIntegerField;
    QRYNFCE_DID_PRODUTO: TIntegerField;
    QRYNFCE_DITEM: TSmallintField;
    QRYNFCE_DCOD_BARRA: TStringField;
    QRYNFCE_DNCM: TStringField;
    QRYNFCE_DCFOP: TStringField;
    QRYNFCE_DCST: TStringField;
    QRYNFCE_DCSOSN: TStringField;
    QRYNFCE_DTIPO: TStringField;
    QRYNFCE_DCST_PIS: TStringField;
    QRYNFCE_DCMUNFG: TIntegerField;
    QRYNFCE_DCLISTASERV: TIntegerField;
    QRYNFCE_DSITUACAO: TStringField;
    QRYNFCE_DFLAG: TStringField;
    QRYNFCE_DUNIDADE: TStringField;
    QRYNFCE_DDESCRICAO: TStringField;
    qryCC: TFDQuery;
    qryCCCODIGO: TIntegerField;
    qryCCFKPESSOA: TIntegerField;
    qryCCDATA_EMISSAO: TDateField;
    qryCCDATA_VENCIMENTO: TDateField;
    qryCCHISTORICO: TStringField;
    qryCCFKVENDA: TIntegerField;
    qryCCFKEMPRESA: TIntegerField;
    qryCPPagamento: TFDQuery;
    qryCPPagamentoCODIGO: TIntegerField;
    qryCPPagamentoFKPAGAR: TIntegerField;
    qryCPPagamentoDATA: TDateField;
    qryCPPagamentoFKPLANO: TIntegerField;
    qryCPPagamentoFKUSUARIO: TIntegerField;
    qryCPPagamentoFKKEMPRESA: TIntegerField;
    qryCPPagamentoFKCONTA: TIntegerField;
    qryCPPagamentoFK_FORMA_PGTO: TIntegerField;
    NUMERO_CHEQUE: TIntegerField;
    qryCPPagamentoFKFORNECEDOR: TIntegerField;
    dsCP: TDataSource;
    qryCRRecebimento: TFDQuery;
    dsCR: TDataSource;
    qryCRRecebimentoCODIGO: TIntegerField;
    qryCRRecebimentoFKCLIENTE: TIntegerField;
    qryCRRecebimentoFKRECEBER: TIntegerField;
    qryCRRecebimentoDATA: TDateField;
    qryCRRecebimentoFKPLANO: TIntegerField;
    qryCRRecebimentoFKUSUARIO: TIntegerField;
    qryCRRecebimentoFKKEMPRESA: TIntegerField;
    qryCRRecebimentoFKCONTA: TIntegerField;
    qryCRRecebimentoFK_FORMA_PGTO: TIntegerField;
    qryCRRecebimentoNUMERO_CHEQUE: TIntegerField;
    qryCaixaVIRTUAL_PLANO: TStringField;
    qryCaixaVIRTUAL_CONTA: TStringField;
    qryCaixaVIRTUAL_CONTA2: TStringField;
    qryFichaCliente: TFDQuery;
    qryFichaClienteTENTRADA: TAggregateField;
    qryFichaClienteTSAIDA: TAggregateField;
    qryCCDOCUMENTO: TStringField;
    qryCCFKPLANO: TIntegerField;
    qryCCBLOQUEADO: TStringField;
    qryPV: TFDQuery;
    qryPV_Itens: TFDQuery;
    qryPVTTOTAL: TAggregateField;
    qryPVCODIGO: TIntegerField;
    qryPVDATA_EMISSAO: TDateField;
    qryPVDATA_SAIDA: TDateField;
    qryPVID_CLIENTE: TIntegerField;
    qryPVFK_USUARIO: TIntegerField;
    qryPVFK_CAIXA: TIntegerField;
    qryPVFK_VENDEDOR: TIntegerField;
    qryPVTIPO_DESCONTO: TStringField;
    qryPVTIPO: TStringField;
    qryPVNECF: TIntegerField;
    qryPVFKORCAMENTO: TIntegerField;
    qryPVFKEMPRESA: TIntegerField;
    qryPVOBSERVACOES: TMemoField;
    qryPVCPF_NOTA: TStringField;
    qryPVSITUACAO: TStringField;
    qryPVRAZAO: TStringField;
    qryPVNOME: TStringField;
    qryContasCODIGO: TIntegerField;
    qryContasDESCRICAO: TStringField;
    qryContasTIPO: TStringField;
    qryContasID_USUARIO: TIntegerField;
    qryContasEMPRESA: TIntegerField;
    qryContasDATA_ABERTURA: TDateField;
    qryContasLOTE: TIntegerField;
    qryContasSITUACAO: TStringField;
    qryCRTIPO: TStringField;
    qryCRNBOLETO: TIntegerField;
    qryCRID_VENDEDOR: TIntegerField;
    qryCRVENDEDOR: TStringField;
    qryPesqEmp: TFDQuery;
    qryPesqEmpCODIGO: TIntegerField;
    qryPesqEmpFANTASIA: TStringField;
    qryCaixaFK_FICHA_CLI: TIntegerField;
    qryCaixaVISIVEL: TStringField;
    qryCaixaDT_CADASTRO: TDateField;
    qryCSOSN: TFDQuery;
    qryCSOSNCODIGO: TStringField;
    qryCSOSNDESCRICAO: TStringField;
    qryCaixaFK_DEVOLUCAO: TIntegerField;
    qryPesqProd: TFDQuery;
    qryParametro: TFDQuery;
    qryTelasFLAG: TStringField;
    qryParametroVERSAO: TIntegerField;
    qryParametroDATA_SCRIPT: TDateField;
    qryPVVIRTUAL_SITUACAO: TStringField;
    qryPesqProduto: TFDQuery;
    qryAcerta: TFDQuery;
    qryAcertaCODIGO: TIntegerField;
    qryAcertaFKPRODUTO: TIntegerField;
    qryAcertaDATA: TDateField;
    qryAcertaE_S: TStringField;
    qryConfigTRANSPORTADOR_PADRAO: TIntegerField;
    qryConfigCTE_SERIE: TStringField;
    qryTranspRENAVAM: TStringField;
    qryConfigPATH_INU_CTE: TStringField;
    qryConfigPATH_PDF_CTE: TStringField;
    qryConfigPATH_EVENTO_CTE: TStringField;
    qryConfigPATH_SCHEMA_CTE: TStringField;
    qryConfigPATH_ENVIADAS_CTE: TStringField;
    qryConfigVERSAO_CTE: TIntegerField;
    qryConfigMODELO_CTE: TStringField;
    qryConfigPATH_CCE_CTE: TStringField;
    qryConfigPROCESSO_EMISSAO_CTE: TIntegerField;
    qryConfigTIPO_CONTRIBUINTE_CTE: TIntegerField;
    qryVersao: TFDQuery;
    IdIPWatch1: TIdIPWatch;
    qryVersaoIP: TStringField;
    qryVersaoNOME: TStringField;
    qryVersaoIMPRIME: TStringField;
    qryVersaoUSAGAVETA: TStringField;
    qryVersaoFABIMPRESSORA: TStringField;
    qryVersaoMODELO: TStringField;
    qryVersaoPORTA: TStringField;
    qryVersaoCONTINGENCIA: TStringField;
    qryVersaoNVIAS: TSmallintField;
    qryVersaoTIPOIMPRESSORA: TStringField;
    qryVersaoSERIE: TStringField;
    qryVersaoNUMERACAO_INICIAL: TIntegerField;
    qryVersaoEMPRESA: TIntegerField;
    qryVersaoVELOCIDADE: TIntegerField;
    qryVersaoIMPRIME_FECHAMENTO: TStringField;
    qryVersaoLOGADO: TStringField;
    qryVersaoEH_CAIXA: TStringField;
    qryVersaoVERSAO: TSmallintField;
    qryTabPreco: TFDQuery;
    qryTabPrecoCODIGO: TIntegerField;
    qryTabPrecoDESCRICAO: TStringField;
    qryTabPrecoFKEMPRESA: TIntegerField;
    qryTabPrecoATIVO: TStringField;
    qryPedidoM: TFDQuery;
    qryPedidoMCODIGO: TIntegerField;
    qryPedidoMFKEMPRESA: TIntegerField;
    qryPedidoMFKCLIENTE: TIntegerField;
    qryPedidoMENDERECO_COBRANCA: TStringField;
    qryPedidoMCOMPLEMENTO_COBRANCA: TStringField;
    qryPedidoMBAIRRO_COBRANCA: TStringField;
    qryPedidoMCIDADE_COBRANCA: TStringField;
    qryPedidoMUF_COBRANCA: TStringField;
    qryPedidoMCEP_COBRANCA: TStringField;
    qryPedidoMFONE_COBRANCA: TStringField;
    qryPedidoMENDERECO_ENTREGA: TStringField;
    qryPedidoMCOMPLEMENTO_ENTREGA: TStringField;
    qryPedidoMBAIRRO_ENTREGA: TStringField;
    qryPedidoMCIDADE_ENTREGA: TStringField;
    qryPedidoMUF_ENTREGA: TStringField;
    qryPedidoMCEP_ENTREGA: TStringField;
    qryPedidoMTIPO_FRETE: TStringField;
    qryPedidoMCONDICOES_PAGAMENTO: TMemoField;
    qryPedidoMOBS: TMemoField;
    qryPedidoMPROPRIEDADE: TStringField;
    qryPedidoMBANCO: TStringField;
    qryPedidoMAGENCIA: TStringField;
    qryPedidoMGERENTE: TStringField;
    qryPedidoMFONE_BANCO: TStringField;
    qryPedidoMSITUACAO: TStringField;
    qryPedidoD: TFDQuery;
    qryPedidoDCODIGO: TIntegerField;
    qryPedidoDFKPEDIDO: TIntegerField;
    qryPedidoDFKPRODUTO: TIntegerField;
    qryCobranca: TFDQuery;
    qryCobrancaFKCLIENTE: TIntegerField;
    qryCobrancaENDERECO: TStringField;
    qryCobrancaBAIRRO: TStringField;
    qryCobrancaCIDADE: TStringField;
    qryCobrancaCOMPLEMENTO: TStringField;
    qryCobrancaUF: TStringField;
    qryCobrancaCEP: TStringField;
    qryCobrancaFONE: TStringField;
    qryEntrega: TFDQuery;
    qryEntregaFKCLIENTE: TIntegerField;
    qryEntregaENDERECO: TStringField;
    qryEntregaCOMPLEMENTO: TStringField;
    qryEntregaBAIRRO: TStringField;
    qryEntregaCIDADE: TStringField;
    qryEntregaUF: TStringField;
    qryEntregaCEP: TStringField;
    qryEntregaFONE: TStringField;
    qryPedidoMREPRESENTANTE: TStringField;
    qryPedidoMDATA: TDateField;
    qryPedidoMTTOTAL: TAggregateField;
    qryConfigTIPO_DACTE: TStringField;
    qryConfigVERSAOQRCODE: TSmallintField;
    qryConfigPREFIXO_BALANCA: TStringField;
    qryConfigTIPO_BALANCA: TSmallintField;
    qryConfigMODELO_BALANCA: TIntegerField;
    qryBuscaIcms: TFDQuery;
    qryBuscaIcmsORIGEM: TStringField;
    qryVeiculos_cavalo: TFDQuery;
    qryVeiculos_Reboque: TFDQuery;
    qryVeiculos_ReboqueCODIGO: TIntegerField;
    qryVeiculos_ReboquePLACA_CAVALO: TStringField;
    qryVeiculos_ReboquePLACA: TStringField;
    qryVeiculos_ReboqueMUNICIPIO: TStringField;
    qryVeiculos_ReboqueUF: TStringField;
    qryVeiculos_ReboqueRNTC: TStringField;
    qryVeiculos_ReboqueRENAVAM: TStringField;
    qryVeiculos_cavaloPLACA: TStringField;
    qryVeiculos_cavaloDESCRICAO: TStringField;
    qryVeiculos_cavaloMUNICIPIO: TStringField;
    qryVeiculos_cavaloUF: TStringField;
    qryVeiculos_cavaloRENAVAM: TStringField;
    qryVeiculos_cavaloRNTC: TStringField;
    qryVeiculos_cavaloTIPO: TIntegerField;
    qryVeiculos_cavaloATIVO: TStringField;
    qryRegistro: TFDQuery;
    qryPedidoMTIPO: TStringField;
    qryPedidoMPRAZO_ENTREGA: TStringField;
    qryPedidoMFORMA_ENTREGA: TStringField;
    qryPedidoMNUMERO: TIntegerField;
    qryPedidoMCONDICAO_PAGAMENTO: TStringField;
    qryPedidoMFORMA_PAGAMENTO: TStringField;
    qryConfigPATH_SALVAR_CTE: TStringField;
    qryPedidoDPRODUTO: TStringField;
    qryPedidoMCLIENTE_CIDADE: TStringField;
    qryPedidoMCLIENTE_FONE: TStringField;
    qryPedidoMCLIENTE_UF: TStringField;
    qryPedidoMCLIENTE_CNPJ: TStringField;
    qryPedidoMCLIENTE_IE: TStringField;
    qryPedidoMCLIENTE_NOME: TStringField;
    qrySped: TFDQuery;
    qrySpedCODIGO: TIntegerField;
    qrySpedDATA_INI: TDateField;
    qrySpedDATA_FIM: TDateField;
    qrySpedDTEMISSAO: TDateField;
    qrySpedREMESSA: TStringField;
    qrySpedSEMMOVIMENTO: TStringField;
    qrySpedRECIBO: TStringField;
    qrySpedFK_CONTADOR: TIntegerField;
    qrySpedFK_EMPRESA: TIntegerField;
    qrySpedFK_USUARIO: TIntegerField;
    qrySped_Config: TFDQuery;
    qrySped_contador: TFDQuery;
    qrySped_Produto: TFDQuery;
    qrySped_Participante: TFDQuery;
    qrySped_ConfigFK_EMPRESA: TIntegerField;
    qrySped_ConfigIND_PERFIL: TStringField;
    qrySped_ConfigIND_ATIV: TStringField;
    qrySped_ConfigIND_EXP: TStringField;
    qrySped_ConfigIND_CCRF: TStringField;
    qrySped_ConfigIND_COMB: TStringField;
    qrySped_ConfigIND_USINA: TStringField;
    qrySped_ConfigIND_VA: TStringField;
    qrySped_ConfigIND_EE: TStringField;
    qrySped_ConfigIND_CART: TStringField;
    qrySped_ConfigIND_FORM: TStringField;
    qrySped_ConfigIND_AER: TStringField;
    qrySped_ConfigCOD_INC_TRIB: TStringField;
    qrySped_ConfigIND_APRO_CRED: TStringField;
    qrySped_ConfigCOD_TIPO_CONT: TStringField;
    qrySped_ConfigIND_REG_CUM: TStringField;
    qrySped_ConfigFK_USUARIO: TIntegerField;
    qrySped_contadorCODIGO: TSmallintField;
    qrySped_contadorNOME: TStringField;
    qrySped_contadorCNPJ: TStringField;
    qrySped_contadorCPF: TStringField;
    qrySped_contadorCRC: TStringField;
    qrySped_contadorENDERECO: TStringField;
    qrySped_contadorNUMERO: TStringField;
    qrySped_contadorCOMPLEMENTO: TStringField;
    qrySped_contadorCEP: TStringField;
    qrySped_contadorBAIRRO: TStringField;
    qrySped_contadorCOD_MUN: TIntegerField;
    qrySped_contadorFONE: TStringField;
    qrySped_contadorFAX: TStringField;
    qrySped_contadorEMAIL: TStringField;
    qrySped_contadorUF: TStringField;
    qrySped_contadorFK_USUARIO: TIntegerField;
    qrySped_contadorFK_EMPRESA: TIntegerField;
    qrySped_ParticipanteCODIGO: TIntegerField;
    qrySped_ParticipanteCOD_PART: TIntegerField;
    qrySped_ParticipanteNOME: TStringField;
    qrySped_ParticipanteCOD_PAIS: TStringField;
    qrySped_ParticipanteCNPJ: TStringField;
    qrySped_ParticipanteCPF: TStringField;
    qrySped_ParticipanteIE: TStringField;
    qrySped_ParticipanteCOD_MUN: TIntegerField;
    qrySped_ParticipanteENDERECO: TStringField;
    qrySped_ParticipanteNUMERO: TStringField;
    qrySped_ParticipanteCOMPLEMENTO: TStringField;
    qrySped_ParticipanteBAIRRO: TStringField;
    qrySped_ParticipanteFK_SPED: TIntegerField;
    qrySped_ParticipanteFK_EMPRESA: TIntegerField;
    qrySped_ParticipanteFK_USUARIO: TIntegerField;
    qrySped_Unidade: TFDQuery;
    qrySped_UnidadeCODIGO: TIntegerField;
    qrySped_UnidadeUNIDADE: TStringField;
    qrySped_UnidadeDESCRICAO: TStringField;
    qrySped_UnidadeFK_SPED: TIntegerField;
    qrySped_UnidadeFK_EMPRESA: TIntegerField;
    qrySped_UnidadeFK_USUARIO: TIntegerField;
    qrySped_H005: TFDQuery;
    qrySped_H005CODIGO: TIntegerField;
    qrySped_H010: TFDQuery;
    qrySped_C100: TFDQuery;
    qrySped_C170: TFDQuery;
    qrySped_C190: TFDQuery;
    qryVeiculos_cavaloCARROCERIA: TIntegerField;
    qryVeiculo_tipo: TFDQuery;
    qryVeiculo_Carroceria: TFDQuery;
    qryVeiculo_CarroceriaCODIGO: TIntegerField;
    qryVeiculo_CarroceriaDESCRICAO: TStringField;
    qryVeiculo_tipoCODIGO: TIntegerField;
    qryVeiculo_tipoDESCRICAO: TStringField;
    qryVeiculos_cavaloVIRTUAL_CARROCERICA: TStringField;
    qryVeiculos_cavaloVIRTUAL_TIPO: TStringField;
    qryVeiculos_ReboqueTIPO: TIntegerField;
    qryVeiculos_ReboqueCARROCERIA: TIntegerField;
    qryVeiculos_ReboqueVIRTUAL_CARROCERIA: TStringField;
    qryConfigMDFE_PATH_SCHEMA: TStringField;
    qryConfigMDFE_PATH_SALVAR: TStringField;
    qryConfigMDFE_PATH_EVENTO: TStringField;
    qryConfigMDFE_PATH_MDFE: TStringField;
    qryConfigMDFE_VERSAO: TSmallintField;
    qryConfigMDFE_PATH_PDF: TStringField;
    qryConfigMDFE_SERIE: TSmallintField;
    qryTranspMOTORISTA: TStringField;
    qryTranspCPF_MOTORISTA: TStringField;
    qryNFCe_OFF: TFDQuery;
    qrySped_ConfigCOD_REGIME_TRIBUTARIO: TStringField;
    qryCaixaFK_CARTAO: TIntegerField;
    qryCaixaVIRTUAL_EMPRESA: TStringField;
    qryAjustaPreco: TFDQuery;
    qryConfigCTE_PIS: TFMTBCDField;
    qryConfigCTE_COFINS: TFMTBCDField;
    qryConfigCTE_ALIQ_PIS: TFMTBCDField;
    qryConfigCTE_ALIQ_COF: TFMTBCDField;
    qryCaixaENTRADA: TFMTBCDField;
    qryCaixaSAIDA: TFMTBCDField;
    qryCaixaSALDO: TFMTBCDField;
    qryCPVALOR: TCurrencyField;
    qryCPDESCONTO: TCurrencyField;
    qryCPJUROS: TFMTBCDField;
    qryCPVLPAGO: TCurrencyField;
    qryCPVL_RESTANTE: TFMTBCDField;
    qryCPPagamentoVALOR_PARCELA: TFMTBCDField;
    qryCPPagamentoPERC_JUROS: TFMTBCDField;
    qryCPPagamentoJUROS: TFMTBCDField;
    qryCPPagamentoPERC_DESCONTO: TFMTBCDField;
    qryCPPagamentoDESCONTO: TFMTBCDField;
    qryCPPagamentoVALOR_RECEBIDO: TFMTBCDField;
    qrySomaPagaJUROS: TFMTBCDField;
    qrySomaPagaDESCONTO: TFMTBCDField;
    qrySomaPagaVALOR: TFMTBCDField;
    qrySomaPagaRECEBIDO: TFMTBCDField;
    qryCRVALOR: TCurrencyField;
    qryCRDESCONTO: TCurrencyField;
    qryCRJUROS: TFMTBCDField;
    qryCRVRECEBIDO: TCurrencyField;
    qryCRVL_RESTANTE: TFMTBCDField;
    qryCRRecebimentoVALOR_PARCELA: TFMTBCDField;
    qryCRRecebimentoPERC_JUROS: TFMTBCDField;
    qryCRRecebimentoJUROS: TFMTBCDField;
    qryCRRecebimentoPERC_DESCONTO: TFMTBCDField;
    qryCRRecebimentoDESCONTO: TFMTBCDField;
    qryCRRecebimentoVALOR_RECEBIDO: TFMTBCDField;
    qrySomaRecJUROS: TFMTBCDField;
    qrySomaRecDESCONTO: TFMTBCDField;
    qrySomaRecVALOR: TFMTBCDField;
    qrySomaRecRECEBIDO: TFMTBCDField;
    qryVddCMA: TFMTBCDField;
    qryVddCMP: TFMTBCDField;
    qryTabPrecoACRESCIMO: TFMTBCDField;
    qryPVSUBTOTAL: TFMTBCDField;
    qryPVDESCONTO: TFMTBCDField;
    qryPVTROCO: TFMTBCDField;
    qryPVDINHEIRO: TFMTBCDField;
    qryPVTOTAL: TFMTBCDField;
    qryPVPERCENTUAL: TFMTBCDField;
    qryPVLOTE: TIntegerField;
    qryPVGERA_FINANCEIRO: TStringField;
    qryPVPERCENTUAL_ACRESCIMO: TFMTBCDField;
    qryPVACRESCIMO: TFMTBCDField;
    qryPVFK_TABELA: TIntegerField;
    qryPVPEDIDO: TStringField;
    qryFPGPARCELAS: TIntegerField;
    qryFPGINTERVALO: TIntegerField;
    qryFPGTAXA: TFMTBCDField;
    qryFPGENTRADA: TFMTBCDField;
    qryFPGDIAS: TSmallintField;
    qrySped_ProdutoCODIGO: TIntegerField;
    qrySped_ProdutoFK_PRODUTO: TIntegerField;
    qrySped_ProdutoDESCRICAO: TStringField;
    qrySped_ProdutoCOD_BARRA: TStringField;
    qrySped_ProdutoTIPO_ITEM: TStringField;
    qrySped_ProdutoCOD_NCM: TStringField;
    qrySped_ProdutoALIQ_ICMS: TFMTBCDField;
    qrySped_ProdutoFK_UNIDADE: TSmallintField;
    qrySped_ProdutoFK_SPED: TIntegerField;
    qrySped_ProdutoFK_EMPRESA: TIntegerField;
    qrySped_ProdutoFK_USUARIO: TIntegerField;
    qrySped_H005DT_INV: TFMTBCDField;
    qrySped_H005FK_SPED: TIntegerField;
    qrySped_H005FK_EMPRESA: TIntegerField;
    qrySped_H005FK_USUARIO: TIntegerField;
    qryVeiculos_cavaloTARA: TFMTBCDField;
    qryVeiculos_cavaloPESO: TFMTBCDField;
    qryVeiculos_ReboquePESO: TFMTBCDField;
    qryVeiculos_ReboqueTARA: TFMTBCDField;
    qryAcertaQTD_F: TFMTBCDField;
    qryAcertaQTD_A: TFMTBCDField;
    qryNFCE_MSUBTOTAL: TFMTBCDField;
    qryNFCE_MDESCONTO: TFMTBCDField;
    qryNFCE_MTROCO: TFMTBCDField;
    qryNFCE_MDINHEIRO: TFMTBCDField;
    qryNFCE_MTOTAL: TFMTBCDField;
    qryNFCE_MBASEICMS: TFMTBCDField;
    qryNFCE_MTOTALICMS: TFMTBCDField;
    qryNFCE_MBASEICMSPIS: TFMTBCDField;
    qryNFCE_MTOTALICMSPIS: TFMTBCDField;
    qryNFCE_MBASEICMSCOF: TFMTBCDField;
    qryNFCE_MTOTALICMSCOFINS: TFMTBCDField;
    qryNFCE_MBASEISS: TFMTBCDField;
    qryNFCE_MTOTALISS: TFMTBCDField;
    qryNFCE_MTRIB_MUN: TFMTBCDField;
    qryNFCE_MTRIB_EST: TFMTBCDField;
    qryNFCE_MTRIB_FED: TFMTBCDField;
    qryNFCE_MTRIB_IMP: TFMTBCDField;
    qryNFCE_MOUTROS: TFMTBCDField;
    QRYNFCE_DQTD: TFMTBCDField;
    QRYNFCE_DE_MEDIO: TFMTBCDField;
    QRYNFCE_DPRECO: TFMTBCDField;
    QRYNFCE_DVALOR_ITEM: TFMTBCDField;
    QRYNFCE_DVDESCONTO: TFMTBCDField;
    QRYNFCE_DBASE_ICMS: TFMTBCDField;
    QRYNFCE_DALIQ_ICMS: TFMTBCDField;
    QRYNFCE_DVALOR_ICMS: TFMTBCDField;
    QRYNFCE_DP_REDUCAO_ICMS: TFMTBCDField;
    QRYNFCE_DBASE_COFINS_ICMS: TFMTBCDField;
    QRYNFCE_DALIQ_COFINS_ICMS: TFMTBCDField;
    QRYNFCE_DVALOR_COFINS_ICMS: TFMTBCDField;
    QRYNFCE_DBASE_PIS_ICMS: TFMTBCDField;
    QRYNFCE_DALIQ_PIS_ICMS: TFMTBCDField;
    QRYNFCE_DVALOR_PIS_ICMS: TFMTBCDField;
    QRYNFCE_DBASE_ISS: TFMTBCDField;
    QRYNFCE_DALIQ_ISS: TFMTBCDField;
    QRYNFCE_DVALOR_ISS: TFMTBCDField;
    QRYNFCE_DTRIB_MUN: TFMTBCDField;
    QRYNFCE_DTRIB_EST: TFMTBCDField;
    QRYNFCE_DTRIB_FED: TFMTBCDField;
    QRYNFCE_DTRIB_IMP: TFMTBCDField;
    QRYNFCE_DTOTAL: TFMTBCDField;
    QRYNFCE_DOUTROS: TFMTBCDField;
    QRYNFCE_DCST_COFINS: TStringField;
    qryPesqProdCODIGO: TIntegerField;
    qryPesqProdTIPO: TStringField;
    qryPesqProdCODBARRA: TStringField;
    qryPesqProdREFERENCIA: TStringField;
    qryPesqProdGRUPO: TIntegerField;
    qryPesqProdUNIDADE: TStringField;
    qryPesqProdULTFORN: TIntegerField;
    qryPesqProdLOCALIZACAO: TStringField;
    qryPesqProdALIQ_ICM: TCurrencyField;
    qryPesqProdALIQ_PIS: TCurrencyField;
    qryPesqProdALIQ_COF: TCurrencyField;
    qryPesqProdPR_CUSTO: TFMTBCDField;
    qryPesqProdMARGEM: TCurrencyField;
    qryPesqProdPR_VENDA: TFMTBCDField;
    qryPesqProdQTD_ATUAL: TFMTBCDField;
    qryPesqProdQTD_MIN: TFMTBCDField;
    qryPesqProdE_MEDIO: TFMTBCDField;
    qryPesqProdCSTICMS: TStringField;
    qryPesqProdCSTE: TStringField;
    qryPesqProdCSTS: TStringField;
    qryPesqProdCSTIPI: TStringField;
    qryPesqProdCSOSN: TStringField;
    qryPesqProdNCM: TStringField;
    qryPesqProdCOMISSAO: TCurrencyField;
    qryPesqProdDESCONTO: TCurrencyField;
    qryPesqProdFOTO: TBlobField;
    qryPesqProdATIVO: TStringField;
    qryPesqProdCFOP: TStringField;
    qryPesqProdPR_CUSTO_ANTERIOR: TFMTBCDField;
    qryPesqProdPR_VENDA_ANTERIOR: TFMTBCDField;
    qryPesqProdULT_COMPRA: TIntegerField;
    qryPesqProdULT_COMPRA_ANTERIOR: TIntegerField;
    qryPesqProdPRECO_ATACADO: TFMTBCDField;
    qryPesqProdQTD_ATACADO: TFMTBCDField;
    qryPesqProdCOD_BARRA_ATACADO: TStringField;
    qryPesqProdALIQ_IPI: TFMTBCDField;
    qryPesqProdEMPRESA: TSmallintField;
    qryPesqProdCEST: TStringField;
    qryPesqProdGRADE: TStringField;
    qryPesqProdEFISCAL: TStringField;
    qryPesqProdPAGA_COMISSAO: TStringField;
    qryPesqProdPESO: TFMTBCDField;
    qryPesqProdCOMPOSICAO: TStringField;
    qryPesqProdPRECO_PROMO_ATACADO: TFMTBCDField;
    qryPesqProdPRECO_PROMO_VAREJO: TFMTBCDField;
    qryPesqProdINICIO_PROMOCAO: TDateField;
    qryPesqProdFIM_PROMOCAO: TDateField;
    qryPesqProdESTOQUE_INICIAL: TFMTBCDField;
    qryPesqProdPR_VENDA_PRAZO: TFMTBCDField;
    qryPesqProdPRECO_VARIAVEL: TStringField;
    qryPesqProdAPLICACAO: TStringField;
    qryPesqProdREDUCAO_BASE: TFMTBCDField;
    qryPesqProdMVA: TFMTBCDField;
    qryPesqProdFCP: TFMTBCDField;
    qryPesqProdPRODUTO_PESADO: TStringField;
    qryPesqProdSERVICO: TStringField;
    qryPesqProdDESCRICAO: TStringField;
    qryPesqProdDT_CADASTRO: TDateField;
    qryPesqProdPR_CUSTO2: TFMTBCDField;
    qryPesqProdPERC_CUSTO: TFMTBCDField;
    qryPesqProdTOTAL_COMPRA: TFMTBCDField;
    qryPesqProdTOTAL_VENDA: TFMTBCDField;
    qryPesqProdGRUPO_SL: TStringField;
    qryPesqProdFORNECEDOR_SL: TStringField;
    qryItensOCODIGO: TIntegerField;
    qryItensOFK_ORCAMENTO: TIntegerField;
    qryItensOFK_PRODUTO: TIntegerField;
    qryItensOQTD: TFMTBCDField;
    qryItensOPRECO: TFMTBCDField;
    qryItensOTOTAL: TFMTBCDField;
    qryItensOITEM: TSmallintField;
    qryItensOVIRTUAL_PRODUTO: TStringField;
    qryItensOVIRTUAL_PRECO: TFMTBCDField;
    qryItensOVIRTUAL_UNIDADE: TStringField;
    qryItensOVIRTUAL_LOCAL: TStringField;
    qryItensOVIRTUAL_REFERENCIA: TStringField;
    qryPedidoMTOTAL: TFMTBCDField;
    qryPedidoDPRECO: TFMTBCDField;
    qryPedidoDTOTAL: TFMTBCDField;
    qryPedidoDVC: TFMTBCDField;
    qryPedidoDPESO: TFMTBCDField;
    qryPedidoDFRETE: TFMTBCDField;
    qryPedidoDQUANTIDADE: TFMTBCDField;
    qryPedidoDCAPACIDADE: TFMTBCDField;
    qryConfigEMAILUSER: TStringField;
    qryConfigSSL_TIPO: TSmallintField;
    qryBuscaIcmsAC: TFMTBCDField;
    qryBuscaIcmsAL: TFMTBCDField;
    qryBuscaIcmsAM: TFMTBCDField;
    qryBuscaIcmsAP: TFMTBCDField;
    qryBuscaIcmsBA: TFMTBCDField;
    qryBuscaIcmsCE: TFMTBCDField;
    qryBuscaIcmsDF: TFMTBCDField;
    qryBuscaIcmsES: TFMTBCDField;
    qryBuscaIcmsGO: TFMTBCDField;
    qryBuscaIcmsMA: TFMTBCDField;
    qryBuscaIcmsMG: TFMTBCDField;
    qryBuscaIcmsMS: TFMTBCDField;
    qryBuscaIcmsMT: TFMTBCDField;
    qryBuscaIcmsPA: TFMTBCDField;
    qryBuscaIcmsPB: TFMTBCDField;
    qryBuscaIcmsPE: TFMTBCDField;
    qryBuscaIcmsP_I: TFMTBCDField;
    qryBuscaIcmsPR: TFMTBCDField;
    qryBuscaIcmsRJ: TFMTBCDField;
    qryBuscaIcmsRO: TFMTBCDField;
    qryBuscaIcmsRN: TFMTBCDField;
    qryBuscaIcmsRR: TFMTBCDField;
    qryBuscaIcmsRS: TFMTBCDField;
    qryBuscaIcmsSC: TFMTBCDField;
    qryBuscaIcmsSE: TFMTBCDField;
    qryBuscaIcmsSP: TFMTBCDField;
    qryBuscaIcmsT_O: TFMTBCDField;
    qryTerminalIP: TStringField;
    qryTerminalNOME: TStringField;
    qryTerminalIMPRIME: TStringField;
    qryTerminalUSAGAVETA: TStringField;
    qryTerminalFABIMPRESSORA: TStringField;
    qryTerminalMODELO: TStringField;
    qryTerminalPORTA: TStringField;
    qryTerminalCONTINGENCIA: TStringField;
    qryTerminalNVIAS: TSmallintField;
    qryTerminalSERIE: TStringField;
    qryTerminalNUMERACAO_INICIAL: TIntegerField;
    qryTerminalEMPRESA: TIntegerField;
    qryTerminalVELOCIDADE: TIntegerField;
    qryTerminalIMPRIME_FECHAMENTO: TStringField;
    qryTerminalLOGADO: TStringField;
    qryTerminalEH_CAIXA: TStringField;
    qryTerminalVERSAO: TSmallintField;
    FBDriver: TFDPhysFBDriverLink;
    qryCCENTRADA: TFMTBCDField;
    qryCCSAIDA: TFMTBCDField;
    qryClientes: TFDQuery;
    qrySped_C100CODIGO: TIntegerField;
    qrySped_C100IND_OPER: TStringField;
    qrySped_C100IND_EMIT: TStringField;
    qrySped_C100COD_MOD: TStringField;
    qrySped_C100COD_SIT: TStringField;
    qrySped_C100SER: TStringField;
    qrySped_C100NUM_DOC: TIntegerField;
    qrySped_C100CHV_NFE: TStringField;
    qrySped_C100DT_DOC: TDateField;
    qrySped_C100DT_E_S: TDateField;
    qrySped_C100VL_DOC: TFMTBCDField;
    qrySped_C100IND_PGTO: TStringField;
    qrySped_C100VL_DESC: TFMTBCDField;
    qrySped_C100VL_ABAT_NT: TFMTBCDField;
    qrySped_C100VL_MERC: TFMTBCDField;
    qrySped_C100IND_FRT: TFMTBCDField;
    qrySped_C100VL_SEGURO: TFMTBCDField;
    qrySped_C100VL_OUT_DA: TFMTBCDField;
    qrySped_C100VL_BC_ICMS: TFMTBCDField;
    qrySped_C100VL_ICMS: TFMTBCDField;
    qrySped_C100VL_BC_ICMS_ST: TFMTBCDField;
    qrySped_C100VL_ICMS_ST: TFMTBCDField;
    qrySped_C100VL_IPI: TFMTBCDField;
    qrySped_C100VL_PIS: TFMTBCDField;
    qrySped_C100VL_COFINS: TFMTBCDField;
    qrySped_C100VL_PIS_ST: TFMTBCDField;
    qrySped_C100VL_COFINS_ST: TFMTBCDField;
    qrySped_C100VL_FRETE: TFMTBCDField;
    qrySped_C100FK_PARTICIPANTES: TIntegerField;
    qrySped_C100FK_SPED: TIntegerField;
    qrySped_C100FK_EMPRESA: TIntegerField;
    qrySped_C100FK_USUARIO: TIntegerField;
    qrySped_C100TABELA: TStringField;
    qrySped_C100TABELA_CODIGO: TIntegerField;
    qrySped_C170CODIGO: TIntegerField;
    qrySped_C170DESCRICAO: TStringField;
    qrySped_C170FK_C100: TIntegerField;
    qrySped_C170FK_EMPRESA: TIntegerField;
    qrySped_C170FK_USUARIO: TIntegerField;
    qrySped_C190CODIGO: TIntegerField;
    qrySped_C190CST_ICMS: TStringField;
    qrySped_C190ALIQ_ICMS: TFMTBCDField;
    qrySped_C190VL_OPR: TFMTBCDField;
    qrySped_C190VL_BC_ICMS: TFMTBCDField;
    qrySped_C190VL_ICMS: TFMTBCDField;
    qrySped_C190VL_BC_ICMS_ST: TFMTBCDField;
    qrySped_C190VL_ICMS_ST: TFMTBCDField;
    qrySped_C190VL_RED_BC: TFMTBCDField;
    qrySped_C190VL_IPI: TFMTBCDField;
    qrySped_C190COD_OBS: TStringField;
    qrySped_C190CFOP: TStringField;
    qrySped_C190FK_C100: TIntegerField;
    qrySped_C190FK_EMPRESA: TIntegerField;
    qrySped_C190FK_USUARIO: TIntegerField;
    qrySped_H005VL_INV: TFMTBCDField;
    qryCaixaTIPO_MOVIMENTO: TStringField;
    qryContasVIRTUAL_SITUACAO: TStringField;
    qryPesqUsuario: TFDQuery;
    qryPesqUsuarioCODIGO: TSmallintField;
    qryPesqUsuarioLOGIN: TStringField;
    qryContasVIRTUAl_USUARIO: TStringField;
    qryPVCONTA: TStringField;
    qryPrincipio: TFDQuery;
    qryMarca: TFDQuery;
    qryRespTecnico: TFDQuery;
    qryRespTecnicoCODIGO: TIntegerField;
    qryRespTecnicoCNPJ: TStringField;
    qryRespTecnicoNOME: TStringField;
    qryRespTecnicoEMAIL: TStringField;
    qryRespTecnicoTELEFONE: TStringField;
    qryRespTecnicoIDCSRT: TStringField;
    qryRespTecnicoCSRT: TStringField;
    qryParametroEMAIL_SUPORTE: TStringField;
    qryParametroTITULO_SISTEMA: TStringField;
    qryParametroSUB_TITULO_SISTEMA: TStringField;
    qryParametroSITE: TStringField;
    qryParametroFONE1: TStringField;
    qryParametroFONE2: TStringField;
    qryParametroCONTATO: TStringField;
    qryParametroESTILO: TStringField;
    qryParametroLINK_TREINAMENTO: TStringField;
    qryAjustaPrecoCODIGO: TIntegerField;
    qryAjustaPrecoTIPO: TStringField;
    qryAjustaPrecoCODBARRA: TStringField;
    qryAjustaPrecoREFERENCIA: TStringField;
    qryAjustaPrecoGRUPO: TIntegerField;
    qryAjustaPrecoUNIDADE: TStringField;
    qryAjustaPrecoULTFORN: TIntegerField;
    qryAjustaPrecoLOCALIZACAO: TStringField;
    qryAjustaPrecoALIQ_ICM: TCurrencyField;
    qryAjustaPrecoALIQ_PIS: TCurrencyField;
    qryAjustaPrecoALIQ_COF: TCurrencyField;
    qryAjustaPrecoPR_CUSTO: TFMTBCDField;
    qryAjustaPrecoMARGEM: TCurrencyField;
    qryAjustaPrecoPR_VENDA: TFMTBCDField;
    qryAjustaPrecoQTD_ATUAL: TFMTBCDField;
    qryAjustaPrecoQTD_MIN: TFMTBCDField;
    qryAjustaPrecoE_MEDIO: TFMTBCDField;
    qryAjustaPrecoCSTICMS: TStringField;
    qryAjustaPrecoCSTE: TStringField;
    qryAjustaPrecoCSTS: TStringField;
    qryAjustaPrecoCSTIPI: TStringField;
    qryAjustaPrecoCSOSN: TStringField;
    qryAjustaPrecoNCM: TStringField;
    qryAjustaPrecoCOMISSAO: TCurrencyField;
    qryAjustaPrecoDESCONTO: TCurrencyField;
    qryAjustaPrecoFOTO: TBlobField;
    qryAjustaPrecoATIVO: TStringField;
    qryAjustaPrecoCFOP: TStringField;
    qryAjustaPrecoPR_CUSTO_ANTERIOR: TFMTBCDField;
    qryAjustaPrecoPR_VENDA_ANTERIOR: TFMTBCDField;
    qryAjustaPrecoULT_COMPRA: TIntegerField;
    qryAjustaPrecoULT_COMPRA_ANTERIOR: TIntegerField;
    qryAjustaPrecoPRECO_ATACADO: TFMTBCDField;
    qryAjustaPrecoQTD_ATACADO: TFMTBCDField;
    qryAjustaPrecoCOD_BARRA_ATACADO: TStringField;
    qryAjustaPrecoALIQ_IPI: TFMTBCDField;
    qryAjustaPrecoEMPRESA: TSmallintField;
    qryAjustaPrecoCEST: TStringField;
    qryAjustaPrecoGRADE: TStringField;
    qryAjustaPrecoEFISCAL: TStringField;
    qryAjustaPrecoPAGA_COMISSAO: TStringField;
    qryAjustaPrecoPESO: TFMTBCDField;
    qryAjustaPrecoCOMPOSICAO: TStringField;
    qryAjustaPrecoPRECO_PROMO_ATACADO: TFMTBCDField;
    qryAjustaPrecoPRECO_PROMO_VAREJO: TFMTBCDField;
    qryAjustaPrecoINICIO_PROMOCAO: TDateField;
    qryAjustaPrecoFIM_PROMOCAO: TDateField;
    qryAjustaPrecoESTOQUE_INICIAL: TFMTBCDField;
    qryAjustaPrecoPR_VENDA_PRAZO: TFMTBCDField;
    qryAjustaPrecoPRECO_VARIAVEL: TStringField;
    qryAjustaPrecoAPLICACAO: TStringField;
    qryAjustaPrecoREDUCAO_BASE: TFMTBCDField;
    qryAjustaPrecoMVA: TFMTBCDField;
    qryAjustaPrecoFCP: TFMTBCDField;
    qryAjustaPrecoPRODUTO_PESADO: TStringField;
    qryAjustaPrecoSERVICO: TStringField;
    qryAjustaPrecoDT_CADASTRO: TDateField;
    qryAjustaPrecoDESCRICAO: TStringField;
    qryAjustaPrecoPR_CUSTO2: TFMTBCDField;
    qryAjustaPrecoPERC_CUSTO: TFMTBCDField;
    qryAjustaPrecoTEMPO_ESPERA: TIntegerField;
    qryAjustaPrecoCOMPLEMENTO: TStringField;
    qryAjustaPrecoRESTAUTANTE: TStringField;
    qryAjustaPrecoTIPO_RESTAURANTE: TStringField;
    qryAjustaPrecoFK_MARCA: TIntegerField;
    qryAjustaPrecoPREFIXO_BALANCA: TStringField;
    qryAjustaPrecoFK_PRINCIPIO_ATIVO: TIntegerField;
    qryAjustaPrecoREMEDIO: TStringField;
    qryCRRecebimentoID_SUBCAIXA: TIntegerField;
    qryConfigCAMINHO_CERTIFICADO: TStringField;
    qryCaixaID_SUBCAIXA: TIntegerField;
    qryCaixaFPG: TIntegerField;
    qryTipoTecido: TFDQuery;
    qryTipoTecidoCODIGO: TIntegerField;
    qryTipoTecidoDESCRICAO: TStringField;
    qryTerminalTIPO_BROWSER: TStringField;
    qryTerminalBALANCA_PORTA: TStringField;
    qryTerminalBALANCA_VELOCIDADE: TStringField;
    qryTerminalBALANCA_MARCA: TStringField;
    qryTerminalBALANCA_PARIDADE: TStringField;
    qryTerminalBALANCA_DATABITS: TStringField;
    qryTerminalBALANCA_STOPBITS: TStringField;
    qryTerminalBALANCA_HANDSHAKING: TStringField;
    qryCaixaFK_OS: TIntegerField;
    qryCRFK_OS: TIntegerField;
    qryEtiqueta: TFDQuery;
    qryEtiquetaCODIGO: TIntegerField;
    qryEtiquetaDESCRICAO: TStringField;
    qryEtiquetaLARGURA: TFMTBCDField;
    qryEtiquetaALTURA: TFMTBCDField;
    qryEtiquetaESQUERDA: TFMTBCDField;
    qryEtiquetaTOPO: TFMTBCDField;
    qryEtiquetaCOLUNAS: TIntegerField;
    qryEtiquetaESPACAMENTO: TFMTBCDField;
    qryEtiquetaBARRA_ALTURA: TFMTBCDField;
    qryEtiquetaBARRA_LARGURA: TFMTBCDField;
    qryEtiquetaBARRA_FINA: TFMTBCDField;
    qryEtiquetaPORTA: TStringField;
    qryEtiquetaMODELO: TStringField;
    qryEtq_Campos: TFDQuery;
    qryItensOFK_GRADE: TIntegerField;
    qryItensOGRADE: TStringField;
    qryParametroICONE: TBlobField;
    qryParametroSPLASH: TBlobField;
    qryParametroSERVIDOR_APP: TStringField;
    qryParametroUSUARIO_APP: TStringField;
    qryParametroSENHA_APP: TStringField;
    qryParametroDATABASE_APP: TStringField;
    qryParametroDATABASE_LI: TStringField;
    qryEtq_CamposCODIGO: TIntegerField;
    qryEtq_CamposCAMPO: TStringField;
    qryEtq_CamposCOLUNA: TIntegerField;
    qryEtq_CamposLINHA: TIntegerField;
    qryEtq_CamposFONTES: TIntegerField;
    qryEtq_CamposVISIVEL: TStringField;
    qryEtq_CamposFK_ETIQUETAS: TIntegerField;
    qryParametroTELA_FUNDO: TStringField;
    qryParametroMENU_MAXIMIZADO: TStringField;
    qryParametroSENHA_LI: TStringField;
    qryParametroTELA_ABERTURA: TStringField;
    qryTerminalDATA_VERSAO: TSQLTimeStampField;
    qryDesoneracao: TFDQuery;
    qryDesoneracaoCODIGO: TIntegerField;
    qryDesoneracaoDESCRICAO: TStringField;
    qryParametroTELA_FUNDO_ECF: TStringField;
    qryParametroUSUARIO_LI: TStringField;
    qryParametroFTP_PASTA: TStringField;
    qryParametroFTP_SERVIDOR: TStringField;
    qryParametroFTP_USUARIO: TStringField;
    qryParametroFTP_SENHA: TStringField;
    qryParametroFTP_ARQUIVO: TStringField;
    QRYNFCE_DCEST: TStringField;
    qryCRBLOQUEADO: TStringField;
    qryCRFK_USUARIO: TIntegerField;
    qryCPFK_USUARIO: TIntegerField;
    qryConfigNUMEROSERIECERTFICADO: TStringField;
    qryTerminalDESTINO_IMPRESSAO: TStringField;
    qryEtiquetaDPI: TStringField;
    qryEtiquetaBACKFEED: TStringField;
    qryEtq_impressao: TFDQuery;
    qryEtq_impressaoCODIGO: TIntegerField;
    qryEtq_impressaoFK_PRODUTO: TIntegerField;
    qryEtq_impressaoFK_EMPRESA: TIntegerField;
    qryEtq_impressaoQTD: TIntegerField;
    qryEtq_CamposDESCRICAO: TStringField;
    qryEtq_CamposCARACTERES: TIntegerField;
    qryTerminalDT_VERSAO: TStringField;
    qryPVFORMA_PAGAMENTO: TStringField;
    qryConfigPASTA_CFE_CANCELAMENTO: TStringField;
    qryConfigTIPO_APLICATIVO: TStringField;
    qryTerminalESC_POS_DIRETO: TStringField;
    qryTerminalPAGINA_CODIGO: TStringField;
    qryConfigPROXY_HOST: TStringField;
    qryConfigPROXY_PORTA: TStringField;
    qryConfigPROXY_SENHA: TStringField;
    qryConfigPROXY_USUARIO: TStringField;
    qryConfigMODELO_DLL: TStringField;
    qryConfigCODIGO_ATIVACAO: TStringField;
    qryConfigCODIGO_VINCULACAO: TStringField;
    qryConfigCHAVE_ACESSO_MFE: TStringField;
    qryConfigPASTA_CFE_VENDA: TStringField;
    qryConfigPASTA_CFE_ENVIO: TStringField;
    qryConfigPASTA_CFE_PDF: TStringField;
    qryConfigCFE_VERSAO: TStringField;
    qryConfigCFE_IDENTAR: TStringField;
    qryConfigCFE_TAMANHOIDENTACA: TIntegerField;
    qryEntregador: TFDQuery;
    qryUpdate: TFDQuery;
    qryNFCE_MSAT_NUMERO_CFE: TIntegerField;
    qryNFCE_MSAT_NUMERO_SERIE: TStringField;
    qryParametroEMPRESA: TStringField;
    qryConfigMFE_INPUT: TStringField;
    qryConfigMFE_OUTPUT: TStringField;
    qryConfigPASTA_CFE_SCHEMA: TStringField;
    qryConfigSAT_CNPJ: TStringField;
    qryConfigSAFT_HASH: TStringField;
    qryConfigSAFT_REGISTRO: TIntegerField;
    qryPaises: TFDQuery;
    qryPaisesCODIGO: TIntegerField;
    qryPaisesNOME: TStringField;
    qryPaisesFK_EMPRESA: TIntegerField;
    qryTradutor: TFDQuery;
    qryTradutorCODIGO: TIntegerField;
    qryTradutorCODIGO_IDIOMA: TIntegerField;
    qryTradutorTELA: TStringField;
    qryTradutorOBJETO: TStringField;
    qryTradutorTEXTO_PT_BR: TStringField;
    qryTradutorTEXTO_TRADUZIDO: TStringField;
    qryConfigCAMINHO_DLL_SAT: TStringField;
    qryConfigSTRESH_IMG_MENU: TStringField;
    qryLCP: TFDQuery;
    qryLCPCODIGO: TStringField;
    qryLCPDESCRICAO: TStringField;
    qryLCPATIVO: TStringField;
    qryConfigFK_IDIOMA: TIntegerField;
    qryConfigPATH_SCHEMA_NFSE: TStringField;
    qryIdiomas: TFDQuery;
    qryIdiomasCODIGO: TIntegerField;
    qryIdiomasDESCRICAO: TStringField;
    qryNFCE_MCNF: TStringField;
    qryTerminalDATA_SISTEMA: TDateField;
    qryTerminalIMPRIME_DUAS_LINHAS: TStringField;
    qryTerminalMARGEM_DIREITA: TFMTBCDField;
    qryTerminalMARGEM_ESQUERDA: TFMTBCDField;
    qryTerminalMARGEM_INFERIOR: TFMTBCDField;
    qryTerminalMARGEM_SUPERIOR: TFMTBCDField;
    qryTerminalLARGURA_BOBINA: TIntegerField;
    qryTerminalESPACO_ENTRE_LINHAS: TStringField;
    qryTerminalLINHAS_ENTRE_CUPOM: TStringField;
    qryTerminalDT_ULTIMA_ATUALIZACAO: TSQLTimeStampField;
    qryTerminalTAMANHO_FONTE: TIntegerField;
    qryConfigVERSAO_BROWSER: TStringField;
    qryParametroLINK_VENDA: TStringField;
    qryParametroCAMINHO_LOGO_FPG: TStringField;
    qryContasATIVO: TStringField;
    qryFPGFK_PESSOA: TIntegerField;
    qryParametroCNPJ: TStringField;
    qryTerminalFLAG: TStringField;
    qryTerminalEXIBE_F3: TStringField;
    qryTerminalEXIBE_F4: TStringField;
    qryTerminalEXIBE_F5: TStringField;
    qryTerminalEXIBE_F6: TStringField;
    qryTerminalFRENTE: TStringField;
    qryTerminalRETAGUARDA: TStringField;
    qryTerminalCAMINHO_SAT_DLL: TStringField;
    qryTerminalMODELO_SAT_DLL: TStringField;
    qryTerminalTIPO_SAT_DLL: TStringField;
    qryTelasTELA: TStringField;
    qryTelasNOME: TStringField;
    qryCRID_CBR_REMESSA_UUID: TStringField;
    qryCRREMESSA_ARQUIVO: TStringField;
    qryAjustaPrecoDATA_PRECO: TDateField;
    qryCaixaRESUMO_CAIXA: TStringField;
    qryCRFK_NFE: TIntegerField;
    qryParametroTELA_FUNDO_LOGIN: TStringField;
    qryNumeroBoleto: TFDQuery;
    qryConfigEMAILTLS: TStringField;
    qryMotorista: TFDQuery;
    qryMotoristaCODIGO: TIntegerField;
    qryMotoristaFK_TRANSPORTADORA: TIntegerField;
    qryMotoristaNOME: TStringField;
    qryMotoristaCNH: TStringField;
    qryMotoristaVALIDADE: TDateField;
    qryMotoristaCPF: TStringField;
    qryFPGUSA_TEF: TStringField;
    qryAtualiza: TFDQuery;
    qryTerminalPARAMETROS_ADICIONAIS: TStringField;
    qryTerminalQRCODE_LATERAL: TStringField;
    qryTerminalCOLUNAS: TIntegerField;
    qryTerminalL1: TIntegerField;
    qryTerminalL2: TIntegerField;
    qryTerminalL3: TIntegerField;
    qryTerminalL4: TIntegerField;
    qryConfigZERO_BALANCA: TStringField;
    qryTerminalTIPOIMPRESSORA: TStringField;
    qryCaixaFK_NFE: TIntegerField;
    qryCRFLAG: TStringField;
    qryCPFLAG: TStringField;
    qryFPGFK_BANDEIRA: TIntegerField;
    qryTerminalDATA_SCRIPT: TSQLTimeStampField;
    qryTerminalEMPRESA_ATIVA: TIntegerField;
    qryTerminalTEF_LOG: TStringField;
    qryTerminalTEF_GERENCIADOR: TIntegerField;
    qryTerminalTEF_MAX_CARTOES: TIntegerField;
    qryTerminalTEF_TROCO_MAXIMO: TSingleField;
    qryTerminalTEF_SOFT_HOUSE: TStringField;
    qryTerminalTEF_REGISTRO: TStringField;
    qryTerminalTEF_APLICACAO: TStringField;
    qryTerminalTEF_VERSAO: TStringField;
    qryTerminalTEF_VIA_REDUZIDA: TStringField;
    qryTerminalTEF_SUPORTA_DESCONTO: TStringField;
    qryTerminalTEF_SUPORTA_SAQUE: TStringField;
    qryTerminalTEF_REAJUSTA_VALOR: TStringField;
    qryTerminalTEF_MULTIPLO_CARTOES: TStringField;
    qryTerminalRESTAURANTE: TStringField;
    qryTerminalDELIVERY: TStringField;
    qryTerminalPDV: TStringField;
    qryTerminalCAMINHO_BAR: TStringField;
    qryTerminalCAMINHO_COZINHA: TStringField;
    qryConfigCTE_NUMERO: TIntegerField;
    qryConfigMDFE_NUMERO: TIntegerField;
    qryPlanoCONTA_COMPLETA: TStringField;
    qryPlanoDESCRICAO: TStringField;
    qryMensagemZap: TFDQuery;
    qryMensagemZapCODIGO: TIntegerField;
    qryMensagemZapDATA: TDateField;
    qryMensagemZapORIGEM: TStringField;
    qryMensagemZapMENSAGEM: TStringField;
    qryMensagemZapANEXO: TStringField;
    qryMensagemZapFONE: TStringField;
    qryMensagemZapSTATUS: TStringField;
    qryMensagemZapHORA: TTimeField;
    qryMensagemZapNOME: TStringField;
    qryMensagemZapEMPRESA: TStringField;
    qryMensagemZapMENSAGEM_PADRAO: TMemoField;
    qryMensagemZapCAMINHO_ANEXO: TStringField;
    qrySabores: TFDQuery;
    qryConfigCAMINHO_CARDAPIO: TStringField;
    qryConfigCAMINHO_ENDERECO: TStringField;
    qryConfigAUTORIZAR_ZAP: TStringField;
    qryConfigTIPO_CHATBOOT: TStringField;
    qryPermissoesBotao: TFDQuery;
    qryPermissoesBotaoVISUALIZAR: TStringField;
    qryPermissoesBotaoEDITAR: TStringField;
    qryPermissoesBotaoINCLUIR: TStringField;
    qryPermissoesBotaoEXCLUIR: TStringField;
    qryParametroBLOQUEAR_PERSONALIZACAO: TStringField;
    qryPVVENDEDOR: TStringField;
    qryPV_ItensCODIGO: TIntegerField;
    qryPV_ItensFKVENDA: TIntegerField;
    qryPV_ItensID_PRODUTO: TIntegerField;
    qryPV_ItensITEM: TSmallintField;
    qryPV_ItensCOD_BARRA: TStringField;
    qryPV_ItensQTD: TFMTBCDField;
    qryPV_ItensE_MEDIO: TFMTBCDField;
    qryPV_ItensPRECO: TFMTBCDField;
    qryPV_ItensVALOR_ITEM: TFMTBCDField;
    qryPV_ItensVDESCONTO: TFMTBCDField;
    qryPV_ItensTOTAL: TFMTBCDField;
    qryPV_ItensSITUACAO: TStringField;
    qryPV_ItensUNIDADE: TStringField;
    qryPV_ItensQTD_DEVOLVIDA: TFMTBCDField;
    qryPV_ItensACRESCIMO: TFMTBCDField;
    qryPV_ItensOS: TStringField;
    qryPV_ItensFK_GRADE: TIntegerField;
    qryPV_ItensID_PRODUTO_SIMILAR: TIntegerField;
    qryPV_ItensID_SERIAL: TIntegerField;
    qryPV_ItensFK_MESA: TIntegerField;
    qryPV_ItensQTD_RESTANTE: TFMTBCDField;
    qryPV_ItensOBSERVACAO: TStringField;
    qryPV_ItensPRODUTO: TStringField;
    qryPV_ItensDESCRICAO_SL: TStringField;
    qryPV_ItensUNIDADE_1: TStringField;
    qryConfigMFE_CHAVE_ACESSO: TMemoField;
    qryConfigMFE_CHAVE_REQUISICAO: TMemoField;
    qryTerminalUSA_POS: TStringField;
    qryTerminalUSA_TEF: TStringField;
    qryTerminalNUMERO_LOJA: TIntegerField;
    qryProdImpPadrao: TFDQuery;
    qryProdImpPadraoCODIGO: TIntegerField;
    qryProdImpPadraoSIGLA: TStringField;
    qryProdImpPadraoDESCRICAO: TStringField;
    qryProdImpPadraoCFOP_DENTRO: TStringField;
    qryProdImpPadraoCFOP_FORA: TStringField;
    qryProdImpPadraoCST_DENTRO: TStringField;
    qryProdImpPadraoCST_FORA: TStringField;
    qryProdImpPadraoCSOSN_DENTRO: TStringField;
    qryProdImpPadraoCSOSN_FORA: TStringField;
    qryProdImpPadraoALIQ_ICMS_P_DENTRO: TFMTBCDField;
    qryProdImpPadraoALIQ_ICMS_P_FORA: TFMTBCDField;
    qryProdImpPadraoCSTIPI: TStringField;
    qryProdImpPadraoEMPRESA: TIntegerField;
    qryTerminalUSAR_NUMERO_INICIAL: TStringField;
    qryContar: TFDQuery;
    qryContarCONTAR: TIntegerField;
    qryCFOPMOV_ES: TStringField;
    qryCFOPOPERACAO: TStringField;
    qryCFOPATIVO: TStringField;
    qryClientesDash: TFDQuery;
    qryClientesDashCODIGO: TIntegerField;
    qryClientesDashRAZAO: TStringField;
    qryCompraDash: TFDQuery;
    AggregateField6: TAggregateField;
    qryCompraDashTOTAL: TFMTBCDField;
    qryCompraDashRAZAO: TStringField;
    qryCompraDash2: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    StringField3: TStringField;
    AggregateField7: TAggregateField;
    qryVendaDash: TFDQuery;
    IntegerField3: TIntegerField;
    DateField1: TDateField;
    DateField2: TDateField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    MemoField1: TMemoField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    FMTBCDField2: TFMTBCDField;
    FMTBCDField3: TFMTBCDField;
    FMTBCDField4: TFMTBCDField;
    FMTBCDField5: TFMTBCDField;
    FMTBCDField6: TFMTBCDField;
    FMTBCDField7: TFMTBCDField;
    IntegerField11: TIntegerField;
    StringField11: TStringField;
    FMTBCDField8: TFMTBCDField;
    FMTBCDField9: TFMTBCDField;
    IntegerField12: TIntegerField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    AggregateField8: TAggregateField;
    qryVendaDash2: TFDQuery;
    IntegerField13: TIntegerField;
    DateField3: TDateField;
    DateField4: TDateField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    IntegerField16: TIntegerField;
    IntegerField17: TIntegerField;
    StringField16: TStringField;
    StringField17: TStringField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    MemoField2: TMemoField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    FMTBCDField10: TFMTBCDField;
    FMTBCDField11: TFMTBCDField;
    FMTBCDField12: TFMTBCDField;
    FMTBCDField13: TFMTBCDField;
    FMTBCDField14: TFMTBCDField;
    FMTBCDField15: TFMTBCDField;
    IntegerField21: TIntegerField;
    StringField23: TStringField;
    FMTBCDField16: TFMTBCDField;
    FMTBCDField17: TFMTBCDField;
    IntegerField22: TIntegerField;
    StringField24: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    AggregateField9: TAggregateField;
    qryItensCad: TFDQuery;
    qryItensNegativo: TFDQuery;
    qryVendaDashLineAtual: TFDQuery;
    qryVendaDashLineAnterior: TFDQuery;
    qryVendaDashLineAtualVALOR: TFMTBCDField;
    qryVendaDashLineAtualDATA: TSmallintField;
    qryContasReceberDash: TFDQuery;
    qryContasReceberDashVALOR: TFMTBCDField;
    qryContasReceberDashCASE: TStringField;
    qryContasPagarDash: TFDQuery;
    qryContasPagarDashVALOR2: TFMTBCDField;
    qryContasPagarDashSTATUS: TStringField;
    qryVendaDashLineAnteriorVALOR2: TFMTBCDField;
    qryVendaDashLineAnteriorDATA2: TSmallintField;
    qrySaldoCaixaDash: TFDQuery;
    qrySaldoCaixaDash2: TFDQuery;
    qrySaldoCaixaDash2MOVIMENTO: TStringField;
    qrySaldoCaixaDash2SAIDA: TFMTBCDField;
    qrySaldoCaixaDashMOVIMENTO: TStringField;
    qrySaldoCaixaDashENTRADA: TFMTBCDField;
    qryTerminalMODELO_TEF: TIntegerField;
    qryTerminalIP_SERVIDOR_TEF: TStringField;
    qryTerminalNUMERO_LOGICO_TERMINAL: TIntegerField;
    qryTerminalPORTA_PIN_PAD: TIntegerField;
    qryTerminalMENSAGEM_PIN_PAD: TStringField;
    qryItensCadCOUNT: TLargeintField;
    qryPessoasEMPRESA: TSmallintField;
    qryPessoasCODIGO: TIntegerField;
    qryPessoasTIPO: TStringField;
    qryPessoasCNPJ: TStringField;
    qryPessoasIE: TStringField;
    qryPessoasFANTASIA: TStringField;
    qryPessoasENDERECO: TStringField;
    qryPessoasNUMERO: TStringField;
    qryPessoasCOMPLEMENTO: TStringField;
    qryPessoasCODMUN: TIntegerField;
    qryPessoasMUNICIPIO: TStringField;
    qryPessoasBAIRRO: TStringField;
    qryPessoasUF: TStringField;
    qryPessoasCEP: TStringField;
    qryPessoasFONE1: TStringField;
    qryPessoasFONE2: TStringField;
    qryPessoasCELULAR1: TStringField;
    qryPessoasCELULAR2: TStringField;
    qryPessoasEMAIL1: TStringField;
    qryPessoasEMAIL2: TStringField;
    qryPessoasFOTO: TBlobField;
    qryPessoasSEXO: TStringField;
    qryPessoasDT_NASC: TDateField;
    qryPessoasECIVIL: TStringField;
    qryPessoasLIMITE: TFMTBCDField;
    qryPessoasDIA_PGTO: TSmallintField;
    qryPessoasOBS: TMemoField;
    qryPessoasNUM_USU: TSmallintField;
    qryPessoasFATURA: TStringField;
    qryPessoasCHEQUE: TStringField;
    qryPessoasCCF: TStringField;
    qryPessoasSPC: TStringField;
    qryPessoasISENTO: TStringField;
    qryPessoasFORN: TStringField;
    qryPessoasFUN: TStringField;
    qryPessoasCLI: TStringField;
    qryPessoasFAB: TStringField;
    qryPessoasTRAN: TStringField;
    qryPessoasADM: TStringField;
    qryPessoasATIVO: TStringField;
    qryPessoasDT_ADMISSAO: TDateField;
    qryPessoasDT_DEMISSAO: TDateField;
    qryPessoasSALARIO: TFMTBCDField;
    qryPessoasPAI: TStringField;
    qryPessoasMAE: TStringField;
    qryPessoasBANCO: TStringField;
    qryPessoasAGENCIA: TStringField;
    qryPessoasGERENTE: TStringField;
    qryPessoasFONE_GERENTE: TStringField;
    qryPessoasPROPRIEDADE: TStringField;
    qryPessoasDT_CADASTRO: TDateField;
    qryPessoasTECNICO: TStringField;
    qryPessoasATENDENTE: TStringField;
    qryPessoasCODIGO_WEB: TIntegerField;
    qryPessoasREFERENCIA: TIntegerField;
    qryPessoasFLAG: TStringField;
    qryPessoasTIPO_RECEBIMENTO: TStringField;
    qryPessoasPARC: TStringField;
    qryPessoasREGIME_TRIBUTARIO: TStringField;
    qryPessoasWHATSAPP: TStringField;
    qryPessoasRAZAO: TStringField;
    qryFornecedorCODIGO: TIntegerField;
    qryFornecedorRAZAO: TStringField;
    qryFornecedorUF: TStringField;
    qryFornecedorCNPJ: TStringField;
    qryClientesCODIGO: TIntegerField;
    qryClientesRAZAO: TStringField;
    qryClientesCNPJ: TStringField;
    qryClientesENDERECO: TStringField;
    qryClientesNUMERO: TStringField;
    qryClientesBAIRRO: TStringField;
    qryClientesMUNICIPIO: TStringField;
    qryClientesUF: TStringField;
    qryClientesCEP: TStringField;
    qryClientesFONE1: TStringField;
    qryClientesCELULAR1: TStringField;
    qryUsuariosCODIGO: TSmallintField;
    qryUsuariosSENHA: TStringField;
    qryUsuariosHIERARQUIA: TSmallintField;
    qryUsuariosECAIXA: TStringField;
    qryUsuariosSUPERVISOR: TStringField;
    qryUsuariosATIVO: TStringField;
    qryUsuariosULTIMO_PEDIDO: TIntegerField;
    qryUsuariosULTIMA_VENDA: TIntegerField;
    qryUsuariosSENHA_APP: TStringField;
    qryUsuariosAPP_SENHA: TStringField;
    qryUsuariosFK_VENDEDOR: TIntegerField;
    qryUsuariosFLAG: TStringField;
    qryUsuariosLOGIN: TStringField;
    qryVendedorCODIGO: TIntegerField;
    qryVendedorCMA: TFMTBCDField;
    qryVendedorCMP: TFMTBCDField;
    qryVendedorATIVO: TStringField;
    qryVendedorEMPRESA: TIntegerField;
    qryVendedorFLAG: TStringField;
    qryVendedorNOME: TStringField;
    qryEntregadorCODIGO: TIntegerField;
    qryEntregadorNOME: TStringField;
    qryFichaClienteCODIGO: TIntegerField;
    qryFichaClienteFKPESSOA: TIntegerField;
    qryFichaClienteDATA_EMISSAO: TDateField;
    qryFichaClienteDATA_VENCIMENTO: TDateField;
    qryFichaClienteHISTORICO: TStringField;
    qryFichaClienteENTRADA: TFMTBCDField;
    qryFichaClienteSAIDA: TFMTBCDField;
    qryFichaClienteFKVENDA: TIntegerField;
    qryFichaClienteFKEMPRESA: TIntegerField;
    qryFichaClienteDOCUMENTO: TStringField;
    qryFichaClienteFKPLANO: TIntegerField;
    qryFichaClienteBLOQUEADO: TStringField;
    qryFichaClienteFKPEDIDO: TIntegerField;
    qryFichaClienteFK_FPG: TIntegerField;
    qryFichaClienteFK_CONTA: TIntegerField;
    qryFichaClienteRAZAO: TStringField;
    qryGrupoEMPRESA: TIntegerField;
    qryGrupoCODIGO: TIntegerField;
    qryGrupoDESCRICAO: TStringField;
    qryGrupoATIVO: TStringField;
    qryUnidadeCODIGO: TStringField;
    qryUnidadeDESCRICAO: TStringField;
    qryUnidadeFK_USUARIO: TIntegerField;
    qryProdCODIGO: TIntegerField;
    qryProdTIPO: TStringField;
    qryProdCODBARRA: TStringField;
    qryProdREFERENCIA: TStringField;
    qryProdGRUPO: TIntegerField;
    qryProdUNIDADE: TStringField;
    qryProdULTFORN: TIntegerField;
    qryProdLOCALIZACAO: TStringField;
    qryProdALIQ_ICM: TCurrencyField;
    qryProdALIQ_PIS: TCurrencyField;
    qryProdALIQ_COF: TCurrencyField;
    qryProdPR_CUSTO: TFMTBCDField;
    qryProdMARGEM: TCurrencyField;
    qryProdPR_VENDA: TFMTBCDField;
    qryProdQTD_ATUAL: TFMTBCDField;
    qryProdQTD_MIN: TFMTBCDField;
    qryProdE_MEDIO: TFMTBCDField;
    qryProdCSTICMS: TStringField;
    qryProdCSTE: TStringField;
    qryProdCSTS: TStringField;
    qryProdCSTIPI: TStringField;
    qryProdCSOSN: TStringField;
    qryProdNCM: TStringField;
    qryProdCOMISSAO: TCurrencyField;
    qryProdDESCONTO: TCurrencyField;
    qryProdFOTO: TBlobField;
    qryProdATIVO: TStringField;
    qryProdCFOP: TStringField;
    qryProdPR_CUSTO_ANTERIOR: TFMTBCDField;
    qryProdPR_VENDA_ANTERIOR: TFMTBCDField;
    qryProdULT_COMPRA: TIntegerField;
    qryProdULT_COMPRA_ANTERIOR: TIntegerField;
    qryProdPRECO_ATACADO: TFMTBCDField;
    qryProdQTD_ATACADO: TFMTBCDField;
    qryProdCOD_BARRA_ATACADO: TStringField;
    qryProdALIQ_IPI: TFMTBCDField;
    qryProdEMPRESA: TSmallintField;
    qryProdCEST: TStringField;
    qryProdGRADE: TStringField;
    qryProdEFISCAL: TStringField;
    qryProdPAGA_COMISSAO: TStringField;
    qryProdPESO: TFMTBCDField;
    qryProdCOMPOSICAO: TStringField;
    qryProdPRECO_PROMO_ATACADO: TFMTBCDField;
    qryProdPRECO_PROMO_VAREJO: TFMTBCDField;
    qryProdINICIO_PROMOCAO: TDateField;
    qryProdFIM_PROMOCAO: TDateField;
    qryProdESTOQUE_INICIAL: TFMTBCDField;
    qryProdPR_VENDA_PRAZO: TFMTBCDField;
    qryProdPRECO_VARIAVEL: TStringField;
    qryProdAPLICACAO: TStringField;
    qryProdREDUCAO_BASE: TFMTBCDField;
    qryProdMVA: TFMTBCDField;
    qryProdFCP: TFMTBCDField;
    qryProdPRODUTO_PESADO: TStringField;
    qryProdSERVICO: TStringField;
    qryProdDT_CADASTRO: TDateField;
    qryProdDESCRICAO: TStringField;
    qryProdPR_CUSTO2: TFMTBCDField;
    qryProdPERC_CUSTO: TFMTBCDField;
    qryProdRESTAUTANTE: TStringField;
    qryProdTEMPO_ESPERA: TIntegerField;
    qryProdCOMPLEMENTO: TStringField;
    qryProdFK_MARCA: TIntegerField;
    qryProdPREFIXO_BALANCA: TStringField;
    qryProdFK_PRINCIPIO_ATIVO: TIntegerField;
    qryProdREMEDIO: TStringField;
    qryProdTIPO_RESTAURANTE: TStringField;
    qryProdFK_TECIDO: TDateField;
    qryProdCFOP_EXTERNO: TIntegerField;
    qryProdETQ: TStringField;
    qryProdCSOSN_EXTERNO: TStringField;
    qryProdCST_EXTERNO: TStringField;
    qryProdALIQ_ICMS_EXTERNO: TFMTBCDField;
    qryProdORIGEM: TIntegerField;
    qryProdGLP: TBCDField;
    qryProdGNN: TBCDField;
    qryProdGNI: TBCDField;
    qryProdPESO_LIQ: TBCDField;
    qryProdANP: TStringField;
    qryProdCOMBUSTIVEL: TStringField;
    qryProdFK_LCP: TStringField;
    qryProdISSQN: TBCDField;
    qryProdTIPO_TRIBUTACAO: TStringField;
    qryProdID_PRODUTO_SIMILAR: TIntegerField;
    qryProdDATA_PRECO: TDateField;
    qryProdTRIBUTACAO_MONOFASICA: TStringField;
    qryProdID_MENU: TIntegerField;
    qryProdVALOR_PEQUENA: TBCDField;
    qryProdVALOR_MEDIA: TBCDField;
    qryProdVALOR_GRANDE: TBCDField;
    qryProdTIPO_ALIMENTO: TStringField;
    qryProdSERIAL: TStringField;
    qryProdMVA_NORMAL: TBCDField;
    qryProdIMPRIME_TICKET: TStringField;
    qryProdICMS_DIFERIDO: TBCDField;
    qryProdQTD_SABORES: TIntegerField;
    qryProdCOD_ENQ_IPI: TStringField;
    qryProdALIQ_DESON: TBCDField;
    qryProdMOTIVO_DESONERACAO: TIntegerField;
    qryProdCOD_BENEFICIO: TStringField;
    qryProdFABRICADO: TStringField;
    qryProdPESO_L: TBCDField;
    qryProdPESO_B: TBCDField;
    qryProdCHATBOOT: TStringField;
    qryProdSITUACAO_TRIBUTARIA: TStringField;
    qryProdTOTAL_COMPRA: TFMTBCDField;
    qryProdTOTAL_VENDA: TFMTBCDField;
    qryProdGRUPO_SL: TStringField;
    qryProdFORNECEDOR_SL: TStringField;
    qryEmpresaCODIGO: TIntegerField;
    qryEmpresaFANTASIA: TStringField;
    qryEmpresaRAZAO: TStringField;
    qryEmpresaTIPO: TStringField;
    qryEmpresaCNPJ: TStringField;
    qryEmpresaIE: TStringField;
    qryEmpresaIM: TStringField;
    qryEmpresaENDERECO: TStringField;
    qryEmpresaNUMERO: TStringField;
    qryEmpresaCOMPLEMENTO: TStringField;
    qryEmpresaBAIRRO: TStringField;
    qryEmpresaCIDADE: TStringField;
    qryEmpresaUF: TStringField;
    qryEmpresaCEP: TStringField;
    qryEmpresaFONE: TStringField;
    qryEmpresaFAX: TStringField;
    qryEmpresaSITE: TStringField;
    qryEmpresaLOGOMARCA: TBlobField;
    qryEmpresaFUNDACAO: TDateField;
    qryEmpresaUSU_CAD: TSmallintField;
    qryEmpresaUSU_ATU: TSmallintField;
    qryEmpresaNSERIE: TStringField;
    qryEmpresaCSENHA: TStringField;
    qryEmpresaNTERM: TStringField;
    qryEmpresaID_PLANO_TRANSFERENCIA_C: TIntegerField;
    qryEmpresaID_PLANO_TRANSFERENCIA_D: TIntegerField;
    qryEmpresaID_CAIXA_GERAL: TIntegerField;
    qryEmpresaBLOQUEAR_ESTOQUE_NEGATIVO: TStringField;
    qryEmpresaID_CIDADE: TIntegerField;
    qryEmpresaCRT: TSmallintField;
    qryEmpresaID_UF: TSmallintField;
    qryEmpresaID_PLANO_VENDA: TIntegerField;
    qryEmpresaOBSFISCO: TMemoField;
    qryEmpresaCFOP: TStringField;
    qryEmpresaCSOSN: TStringField;
    qryEmpresaCST_ICMS: TStringField;
    qryEmpresaALIQ_ICMS: TFMTBCDField;
    qryEmpresaCST_ENTRADA: TStringField;
    qryEmpresaCST_SAIDA: TStringField;
    qryEmpresaALIQ_PIS: TFMTBCDField;
    qryEmpresaALIQ_COF: TFMTBCDField;
    qryEmpresaCST_IPI: TStringField;
    qryEmpresaALIQ_IPI: TFMTBCDField;
    qryEmpresaIMP_F5: TStringField;
    qryEmpresaIMP_F6: TStringField;
    qryEmpresaMOSTRA_RESUMO_CAIXA: TStringField;
    qryEmpresaLIMITE_DIARIO: TFMTBCDField;
    qryEmpresaPRAZO_MAXIMO: TSmallintField;
    qryEmpresaID_PLA_CONTA_FICHA_CLI: TIntegerField;
    qryEmpresaID_PLANO_CONTA_RETIRADA: TIntegerField;
    qryEmpresaUSA_PDV: TStringField;
    qryEmpresaRECIBO_VIAS: TStringField;
    qryEmpresaID_PLANO_TAXA_CARTAO: TIntegerField;
    qryEmpresaOBS_CARNE: TMemoField;
    qryEmpresaCAIXA_UNICO: TStringField;
    qryEmpresaCAIXA_RAPIDO: TStringField;
    qryEmpresaEMPRESA_PADRAO: TSmallintField;
    qryEmpresaID_PLANO_CONTA_DEVOLUCAO: TIntegerField;
    qryEmpresaN_INICIAL_NFCE: TIntegerField;
    qryEmpresaN_INICIAL_NFE: TIntegerField;
    qryEmpresaCHECA_ESTOQUE_FISCAL: TStringField;
    qryEmpresaDESCONTO_PROD_PROMO: TStringField;
    qryEmpresaDATA_CADASTRO: TStringField;
    qryEmpresaDATA_VALIDADE: TStringField;
    qryEmpresaFLAG: TStringField;
    qryEmpresaLANCAR_CARTAO_CREDITO: TStringField;
    qryEmpresaFILTRAR_EMPRESA_LOGIN: TStringField;
    qryEmpresaENVIAR_EMAIL_NFE: TStringField;
    qryEmpresaTRANSPORTADORA: TStringField;
    qryEmpresaTABELA_PRECO: TStringField;
    qryEmpresaTAXA_VENDA_PRAZO: TFMTBCDField;
    qryEmpresaEMAIL_CONTADOR: TStringField;
    qryEmpresaAUTOPECAS: TStringField;
    qryEmpresaATUALIZA_PR_VENDA: TStringField;
    qryEmpresaINFORMAR_GTIN: TStringField;
    qryEmpresaRECOLHE_FCP: TStringField;
    qryEmpresaDIFAL_ORIGEM: TFMTBCDField;
    qryEmpresaDIFAL_DESTINO: TFMTBCDField;
    qryEmpresaEXCLUI_PDV: TStringField;
    qryEmpresaVENDA_SEMENTE: TStringField;
    qryEmpresaCHECA: TStringField;
    qryEmpresaEMAIL: TStringField;
    qryEmpresaULTIMONSU: TStringField;
    qryEmpresaULTIMO_PEDIDO: TIntegerField;
    qryEmpresaTIPO_CONTRATO: TIntegerField;
    qryEmpresaTIPO_EMPRESA: TIntegerField;
    qryEmpresaQTD_MESAS: TSmallintField;
    qryEmpresaBLOQUEAR_PRECO: TStringField;
    qryEmpresaEXIBE_RESUMO_CAIXA: TStringField;
    qryEmpresaID_PLANO_COMPRA: TIntegerField;
    qryEmpresaRESPONSAVEL_TECNICO: TStringField;
    qryEmpresaCARENCIA_JUROS: TIntegerField;
    qryEmpresaPESQUISA_REFERENCIA: TStringField;
    qryEmpresaRESTAURANTE: TStringField;
    qryEmpresaEXIBE_F3: TStringField;
    qryEmpresaEXIBE_F4: TStringField;
    qryEmpresaLER_PESO: TStringField;
    qryEmpresaDESCONTO_MAXIMO: TFMTBCDField;
    qryEmpresaCHECA_LIMITE: TStringField;
    qryEmpresaEMITE_ECF: TStringField;
    qryEmpresaLOJA_ROUPA: TStringField;
    qryEmpresaTIPO_JUROS: TStringField;
    qryEmpresaJUROS_DIA: TFMTBCDField;
    qryEmpresaJUROS_MES: TFMTBCDField;
    qryEmpresaFARMACIA: TStringField;
    qryEmpresaPAGAMENTO_DINHEIRO: TStringField;
    qryEmpresaRESPONSAVEL_EMPRESA: TStringField;
    qryEmpresaHABILITA_DESCONTO_PDV: TStringField;
    qryEmpresaPUXA_CFOP_PRODUTO: TStringField;
    qryEmpresaLANCAR_CARTAO_CR: TStringField;
    qryEmpresaUSA_BLUETOOTH_RESTA: TStringField;
    qryEmpresaCFOP_EXTERNO: TStringField;
    qryEmpresaCNAE: TStringField;
    qryEmpresaCODIGO_PAIS: TIntegerField;
    qryEmpresaOBSNFCE: TMemoField;
    qryEmpresaCSOSN_EXTERNO: TStringField;
    qryEmpresaCST_EXTERNO: TStringField;
    qryEmpresaALIQ_ICMS_EXTERNO: TFMTBCDField;
    qryEmpresaCOD_FPG_DINHEIRO: TIntegerField;
    qryEmpresaHABILITA_ACRESCIMO: TStringField;
    qryEmpresaMULTI_IDIOMA: TStringField;
    qryEmpresaREPLICAR_DADOS: TStringField;
    qryEmpresaID_PLANO_BOLETO: TIntegerField;
    qryEmpresaSEGUNDA_VIA_NFCE: TStringField;
    qryEmpresaEXIBE_ESTOQUE_FISCAL: TStringField;
    qryEmpresaNFCE_PRODUTO_SUBSTITUTO: TStringField;
    qryEmpresaAUTO_CADASTRO_PRODUTO: TStringField;
    qryEmpresaCFOP_ENTRADA_PADRAO: TStringField;
    qryEmpresaCFOP_ENTRADA_PADRO_E: TStringField;
    qryEmpresaPUXAR_CFOP_ENTRADA: TStringField;
    qryEmpresaLUCRO_PADRAO: TBCDField;
    qryEmpresaNFE_SERIE: TIntegerField;
    qryEmpresaOCULTAR_SALDO_ANTERIOR: TStringField;
    qryEmpresaBAIXAR_ESTOQUE_NFE: TStringField;
    qryEmpresaTRANSMITIR_CARTAO_AUTO: TStringField;
    qryEmpresaALIQUOTA_SIMPLES: TBCDField;
    qryEmpresaSERVIDOR_SMTP_PROPRIO: TStringField;
    qryEmpresaMENSAGEM_COBRANCA: TMemoField;
    qryEmpresaPRE_VISUALIZAR_IMPRESSAO: TStringField;
    qryEmpresaID_PLANO_ABERTURA: TIntegerField;
    qryEmpresaPESQUISA_POR_PARTE: TStringField;
    qryEmpresaBAIXAR_ESTOQUE_COMPOSICAO: TStringField;
    qryEmpresaAUTO_ATUALIZA: TStringField;
    qryEmpresaUSA_TEF: TStringField;
    qryEmpresaRATEAR_FRETE: TStringField;
    qryEmpresaUSA_CREDITO_SIMPLES: TStringField;
    qryEmpresaDESCONTO_ITEM_PDV: TStringField;
    qryEmpresaBLOQUEAR_CPF: TStringField;
    qryEmpresaBLOQUEAR_PERSONALIZACAO: TStringField;
    qryEmpresaUSAR_NUMERO_INICIAL: TStringField;
    qryEmpresaCNPJ_REPRESENTANTE: TStringField;
    qryEmpresaMOSTRA_RATEIO: TStringField;
    qryEmpresaUSAR_TRIB_TODAS_EMP: TStringField;
    qryEmpresaUSAR_TRIB_XML: TStringField;
    qryEmpresaVIRTUAL_ID_UF: TIntegerField;
    qryEmpresaVIRTUAL_UF: TStringField;
    qryMarcaCODIGO: TIntegerField;
    qryMarcaDESCRICAO: TStringField;
    qryMarcaATIVO: TStringField;
    qryCidadeCODIGO: TIntegerField;
    qryCidadeDESCRICAO: TStringField;
    qryCidadeCODUF: TIntegerField;
    qryCidadeUF: TStringField;
    qrySaboresCODIGO: TIntegerField;
    qrySaboresDESCRICAO: TStringField;
    qrySaboresATIVO: TStringField;
    qryTransfCODIGO: TIntegerField;
    qryTransfEMISSAO: TDateField;
    qryTransfDOC: TStringField;
    qryTransfFKPLANO: TIntegerField;
    qryTransfFKCONTA: TIntegerField;
    qryTransfHISTORICO: TStringField;
    qryTransfENTRADA: TFMTBCDField;
    qryTransfSAIDA: TFMTBCDField;
    qryTransfSALDO: TFMTBCDField;
    qryTransfFKVENDA: TIntegerField;
    qryTransfFKCOMPRA: TIntegerField;
    qryTransfFKPAGAR: TIntegerField;
    qryTransfFKRECEBER: TIntegerField;
    qryTransfTRANSFERENCIA: TIntegerField;
    qryTransfBLOQUEADO: TStringField;
    qryTransfFK_CONTA1: TIntegerField;
    qryTransfFK_PAI: TIntegerField;
    qryTransfHORA_EMISSAO: TTimeField;
    qryTransfECARTAO: TStringField;
    qryTransfID_USUARIO: TIntegerField;
    qryTransfEMPRESA: TIntegerField;
    qryTransfFK_FICHA_CLI: TIntegerField;
    qryTransfVISIVEL: TStringField;
    qryTransfDT_CADASTRO: TDateField;
    qryTransfFK_DEVOLUCAO: TIntegerField;
    qryTransfFK_CARTAO: TIntegerField;
    qryTransfTIPO_MOVIMENTO: TStringField;
    qryTransfID_SUBCAIXA: TIntegerField;
    qryTransfFK_OS: TIntegerField;
    qryTransfFPG: TIntegerField;
    qryTransfRESUMO_CAIXA: TStringField;
    qryTransfFK_NFE: TIntegerField;
    qryPesqProdutoCODIGO: TIntegerField;
    qryPesqProdutoCODBARRA: TStringField;
    qryPesqProdutoDESCRICAO: TStringField;
    qryPesqProdutoPR_VENDA: TFMTBCDField;
    qryPrincipioCODIGO: TIntegerField;
    qryPrincipioDESCRICAO: TStringField;
    qryMesas: TFDQuery;
    qryMesasCODIGO: TIntegerField;
    qryMesasSITUACAO: TStringField;
    qryMesasTOTAL: TSingleField;
    qryMesasFK_EMPRESA: TIntegerField;
    qryMesasVIRTUAL_SITUACAO: TStringField;
    qryMesasVIRTUAL_MESA: TStringField;
    qryMesasFK_VENDA: TIntegerField;
    qryMesasDESCRICAO: TStringField;
    qryOrcamento: TFDQuery;
    qryOrcamentoCODIGO: TIntegerField;
    qryOrcamentoDATA: TDateField;
    qryOrcamentoFKVENDEDOR: TIntegerField;
    qryOrcamentoFK_CLIENTE: TIntegerField;
    qryOrcamentoCLIENTE: TStringField;
    qryOrcamentoTELEFONE: TStringField;
    qryOrcamentoCELULAR: TStringField;
    qryOrcamentoENDERECO: TStringField;
    qryOrcamentoNUMERO: TStringField;
    qryOrcamentoBAIRRO: TStringField;
    qryOrcamentoCIDADE: TStringField;
    qryOrcamentoUF: TStringField;
    qryOrcamentoCNPJ: TStringField;
    qryOrcamentoFORMA_PAGAMENTO: TStringField;
    qryOrcamentoVALIDADE: TSmallintField;
    qryOrcamentoOBS: TMemoField;
    qryOrcamentoSITUACAO: TStringField;
    qryOrcamentoTOTAL: TFMTBCDField;
    qryOrcamentoCEP: TStringField;
    qryOrcamentoFKEMPRESA: TIntegerField;
    qryOrcamentoSUBTOTAL: TFMTBCDField;
    qryOrcamentoPERCENTUAL: TFMTBCDField;
    qryOrcamentoDESCONTO: TFMTBCDField;
    qryOrcamentoVENDEDOR: TStringField;
    qryOrcamentoVIRTUAL_SITUACAO: TStringField;
    qryOrcamentoCODIGO_WEB: TIntegerField;
    qryOrcamentoNCONTROLE: TIntegerField;
    qryOrcamentoFK_TRANSP: TIntegerField;
    qryOrcamentoTRANSPORTADOR: TStringField;
    qryOrcamentoTTOTAL: TAggregateField;
    qryItensNegativoCOUNT: TLargeintField;
    qryPermissoesFKTELA: TIntegerField;
    qryPermissoesVISUALIZAR: TStringField;
    qryPermissoesEXCLUIR: TStringField;
    qryPermissoesEDITAR: TStringField;
    qryPermissoesINCLUIR: TStringField;
    qryPermissoesVISIVEL: TStringField;
    qryPermissoesNOME: TStringField;
    qryPermissoesPAI: TSmallintField;
    qryEmpresaID_CAD_CLI: TIntegerField;
    qryEmpresaDT_INST: TDateField;
    qryEmpresaDT_HJ: TDateField;
    qryEmpresaDT_PR: TDateField;
    qryEmpresaUSAR_TEF: TStringField;
    qryEmpresaTEF_GERAR_NFCE_AUTO: TStringField;
    qryEmpresaHABILITA_FUNC_SOFTHOUSE: TStringField;
    qryEmpresaNT_COMPRA_IMP_CUSTO: TStringField;
    qryEmpresaNAO_ATUALIZA_GRADE: TStringField;
    qryEmpresaUSAAPIPIX_MERCADOPAGO: TStringField;
    qryEmpresaACCESSTOKEN_MERCADOPAGO: TStringField;
    qryEmpresaUSAR_VLR_FECHAMENTO_ABERTURA: TStringField;
    qryEmpresaPERMITIR_BAIXA_ESTOQUE_F5: TStringField;
    qryEmpresaACRESCIMO_MAXIMO: TFMTBCDField;
    qryEmpresaUSAR_SISTEMA_WEB: TStringField;
    qryEmpresaCADASTRO_WEB: TStringField;
    qryEmpresaUSAAPIPIX_BB: TStringField;
    qryEmpresaBASICTOKEN_BB: TMemoField;
    qryEmpresaAPPKEY_BB: TStringField;
    qryEmpresaCLIENTID_BB: TStringField;
    qryEmpresaCLIENTSECRET_BB: TStringField;
    qryEmpresaAPI_PIX_BANCO: TIntegerField;
    qryEmpresaAPI_PIX_AMBIENTE: TIntegerField;
    qryEmpresaCHAVE_PIX_BB: TStringField;
    qryEmpresaAPI_PIX_TIPO_CHAVE_PIX: TIntegerField;
    qryFPGCOD_BEMA: TStringField;
    qryFPGCOD_DARU: TStringField;
    qryFPGCOD_ELGI: TStringField;
    qryFPGCOD_EPSO: TStringField;
    qryFPGGERACC: TStringField;
    qryFPGGERACX: TStringField;
    qryFPGATALHO: TStringField;
    qryTerminalIMPRESSORA_FASTREPORT: TStringField;
    qryTerminalMOSTRA_PREVIEW: TStringField;
    qryTerminalMOSTRAR_TELA_CAIXA_LIVRE: TStringField;
    qryTerminalTIME_TELA_CAIXA_LIVRE: TIntegerField;
    qryTerminalPESQUISA_RAPIDA: TStringField;
    qryTerminalBUSCA_BALANCA_BARRAS: TStringField;
    qryTerminalIMPRESSORA_FORTESREPORT: TStringField;
    qryTerminalMENSAGEM_PDV: TStringField;
    qryTerminalMOSTRAR_MENSAGEM_PDV: TStringField;
    qryTerminalQTD_TENTATIVA_CONECT_BAL: TIntegerField;
    qryTerminalIMPRIMIR_TEF_ESCPOS: TStringField;
    qryProdQTD_FISCAL: TBCDField;
    qryChaveMAQUINA: TStringField;
    qryChaveCHAVEACESSO: TStringField;
    qryXmlMaster: TFDQuery;
    qryXmlMasterCODIGO: TIntegerField;
    qryXmlMasterID_FORNECEDOR: TIntegerField;
    qryXmlMasterDATA_PEDIDO: TDateField;
    qryXmlMasterDATA_ENTRADA: TDateField;
    qryXmlMasterDATA_EMISSAO_NF: TDateField;
    qryXmlMasterNOTA_FISCAL: TStringField;
    qryXmlMasterMODELO: TStringField;
    qryXmlMasterSERIE: TStringField;
    qryXmlMasterCHAVE: TStringField;
    qryXmlMasterCFOP: TStringField;
    qryXmlMasterEMPRESA: TIntegerField;
    qryXmlMasterVIRTUAL_CNPJ: TStringField;
    qryXmlMasterVITUAL_UF: TStringField;
    qryXmlMasterVIRTUAL_FORNECEDOR: TStringField;
    qryXmlMasterXML: TMemoField;
    qryXmlMasterSUB_TOTAL: TFMTBCDField;
    qryXmlMasterFRETE: TFMTBCDField;
    qryXmlMasterOUTRAS_DESPESAS: TFMTBCDField;
    qryXmlMasterSEGURO: TFMTBCDField;
    qryXmlMasterDESCONTO: TFMTBCDField;
    qryXmlMasterTOTAL: TFMTBCDField;
    qryXmlMasterBASE_PIS: TFMTBCDField;
    qryXmlMasterTOTAL_PIS: TFMTBCDField;
    qryXmlMasterBASE_COFINS: TFMTBCDField;
    qryXmlMasterTOTAL_COFINS: TFMTBCDField;
    qryXmlMasterBASE_IPI: TFMTBCDField;
    qryXmlMasterTOTAL_IPI: TFMTBCDField;
    qryXmlMasterBASE_ICMS: TFMTBCDField;
    qryXmlMasterTOTAL_ICMS: TFMTBCDField;
    qryXmlMasterBASE_ST: TFMTBCDField;
    qryXmlMasterTOTAL_ST: TFMTBCDField;
    qryXmlMasterFK_USUARIO: TIntegerField;
    qryXMLProduto: TFDQuery;
    qryXMLProdutoID_PRODUTO_LOCAL: TFloatField;
    qryXMLProdutoID_FORNECEDOR: TFloatField;
    qryXMLProdutoID_PRODUTO_FORN: TStringField;
    qryXMLProdutoUN_E: TStringField;
    qryXMLProdutoUN_S: TStringField;
    qryXMLProdutoFK_GRUPO: TIntegerField;
    qryXMLProdutoFKEMPRESA: TIntegerField;
    qryXMLProdutoQTD_E: TFMTBCDField;
    qryXMLProdutoQTD_S: TFMTBCDField;
    qryCompra: TFDQuery;
    qryCompraID: TIntegerField;
    qryCompraEMPRESA: TSmallintField;
    qryCompraDTENTRADA: TDateField;
    qryCompraDTEMISSAO: TDateField;
    qryCompraFORNECEDOR: TIntegerField;
    qryCompraNR_NOTA: TStringField;
    qryCompraFRETE: TFMTBCDField;
    qryCompraDESPESAS: TFMTBCDField;
    qryCompraDESCONTO: TFMTBCDField;
    qryCompraBASE_IPI: TFMTBCDField;
    qryCompraTOTAL_IPI: TFMTBCDField;
    qryCompraBASE_ICM: TFMTBCDField;
    qryCompraTOTAL_ICM: TFMTBCDField;
    qryCompraBASE_ST: TFMTBCDField;
    qryCompraTOTAL_ST: TFMTBCDField;
    qryCompraBASE_PIS: TFMTBCDField;
    qryCompraTOTAL_PIS: TFMTBCDField;
    qryCompraBASE_COF: TFMTBCDField;
    qryCompraTOTAL_COF: TFMTBCDField;
    qryCompraTOTAL: TFMTBCDField;
    qryCompraGERA_CP: TStringField;
    qryCompraGERA_ES: TStringField;
    qryCompraAJUSTA_PC: TStringField;
    qryCompraAJUSTA_PV: TStringField;
    qryCompraEHFISCAL: TStringField;
    qryCompraLEUXML: TStringField;
    qryCompraSTATUS: TStringField;
    qryCompraRAZAO: TStringField;
    qryCompraVIRTUAL_SITUACAO: TStringField;
    qryCompraVIRTUAL_FORNECE: TStringField;
    qryCompraSEGURO: TFMTBCDField;
    qryCompraSUBTOTAL: TFMTBCDField;
    qryCompraVIRTUAL_UF: TStringField;
    qryCompraVIRTUAL_CNPJ: TStringField;
    qryCompraMODELO: TStringField;
    qryCompraSERIE: TStringField;
    qryCompraCHAVE: TStringField;
    qryCompraXML: TMemoField;
    qryCompraTIPO: TStringField;
    qryCompraTTOTAL: TAggregateField;
    QryXmlDetail: TFDQuery;
    QryXmlDetailCODIGO: TIntegerField;
    QryXmlDetailFK_XML_MASTER: TIntegerField;
    QryXmlDetailID_PRODUTO_LOC: TIntegerField;
    QryXmlDetailID_PRODUTO_FOR: TStringField;
    QryXmlDetailDESCRICAO_FORNECEDOR: TStringField;
    QryXmlDetailDESCRICAO_LOCAL: TStringField;
    QryXmlDetailUND_E: TStringField;
    QryXmlDetailUND_S: TStringField;
    QryXmlDetailNCM: TStringField;
    QryXmlDetailCFOP: TStringField;
    QryXmlDetailCST_IPI: TStringField;
    QryXmlDetailCST_PIS: TStringField;
    QryXmlDetailCST_COFINS: TStringField;
    QryXmlDetailCST_ICMS: TStringField;
    QryXmlDetailCODBARRA: TStringField;
    QryXmlDetailFK_GRUPO: TIntegerField;
    QryXmlDetailVIRTUAL_GRUPO: TStringField;
    QryXmlDetailQUANT_E: TFMTBCDField;
    QryXmlDetailQUANT_S: TFMTBCDField;
    QryXmlDetailVL_ITEM: TFMTBCDField;
    QryXmlDetailBASE_IPI: TFMTBCDField;
    QryXmlDetailALIQ_IPI: TFMTBCDField;
    QryXmlDetailVL_IPI: TFMTBCDField;
    QryXmlDetailBASE_PIS: TFMTBCDField;
    QryXmlDetailALIQ_PIS: TFMTBCDField;
    QryXmlDetailVL_PIS: TFMTBCDField;
    QryXmlDetailBASE_COFINS: TFMTBCDField;
    QryXmlDetailALIQ_COFINS: TFMTBCDField;
    QryXmlDetailVL_COFINS: TFMTBCDField;
    QryXmlDetailBASE_ICMS: TFMTBCDField;
    QryXmlDetailALIQ_ICMS: TFMTBCDField;
    QryXmlDetailVL_ICMS: TFMTBCDField;
    QryXmlDetailBASE_ST: TFMTBCDField;
    QryXmlDetailALIQ_ST: TFMTBCDField;
    QryXmlDetailVL_ST: TFMTBCDField;
    QryXmlDetailSEGURO: TFMTBCDField;
    QryXmlDetailDESPESAS: TFMTBCDField;
    QryXmlDetailFRETE: TFMTBCDField;
    QryXmlDetailDESCONTO: TFMTBCDField;
    QryXmlDetailREDBC: TFMTBCDField;
    QryXmlDetailFKEMPRESA: TIntegerField;
    QryXmlDetailEMBALAGEM: TFMTBCDField;
    QryXmlDetailVIRTUAL_UN: TStringField;
    QryXmlDetailCHECAR: TStringField;
    QryXmlDetailVIRTUAL_DESCRICAO: TStringField;
    QryXmlDetailVIRTUAL_BARRA: TStringField;
    QryXmlDetailREFERENCIA: TStringField;
    QryXmlDetailCEST: TStringField;
    QryXmlDetailCFOP_E: TStringField;
    QryXmlDetailCST_E: TStringField;
    QryXmlDetailPR_VENDA: TFMTBCDField;
    QryXmlDetailFK_GRADE_PRODUTO: TIntegerField;
    QryXmlDetailQTD_TOTAL: TFMTBCDField;
    QryXmlDetailFLAG: TStringField;
    QryXmlDetailPRECO_E: TFMTBCDField;
    QryXmlDetailPRECO_S: TFMTBCDField;
    qrySped_C170QTD: TBCDField;
    qrySped_C170VL_ITEM: TFMTBCDField;
    qrySped_C170VL_DESC: TFMTBCDField;
    qrySped_C170IND_MOV: TStringField;
    qrySped_C170CFOP: TStringField;
    qrySped_C170CST_ICMS: TStringField;
    qrySped_C170COD_NAT: TStringField;
    qrySped_C170VL_BC_ICMS: TFMTBCDField;
    qrySped_C170ALIQ_ICM: TFMTBCDField;
    qrySped_C170VL_ICMS: TFMTBCDField;
    qrySped_C170VL_BC_ICMS_ST: TFMTBCDField;
    qrySped_C170ALIQ_ST: TFMTBCDField;
    qrySped_C170VL_ICMS_ST: TFMTBCDField;
    qrySped_C170IND_APUR: TStringField;
    qrySped_C170CST_IPI: TStringField;
    qrySped_C170COD_ENQ: TStringField;
    qrySped_C170VL_BC_IPI: TFMTBCDField;
    qrySped_C170ALIQ_IPI: TFMTBCDField;
    qrySped_C170VL_IPI: TFMTBCDField;
    qrySped_C170CST_PIS: TStringField;
    qrySped_C170VL_BC_PIS: TFMTBCDField;
    qrySped_C170ALIQ_PIS_PERC: TBCDField;
    qrySped_C170QUANT_BC_PIS: TBCDField;
    qrySped_C170ALIQ_PIS_R: TFMTBCDField;
    qrySped_C170VL_PIS: TFMTBCDField;
    qrySped_C170CST_COFINS: TStringField;
    qrySped_C170VL_BC_COFINS: TFMTBCDField;
    qrySped_C170ALIQ_COFINS_PERC: TBCDField;
    qrySped_C170QUANT_BC_COFINS: TBCDField;
    qrySped_C170ALIQ_COFINS_R: TFMTBCDField;
    qrySped_C170VL_COFINS: TFMTBCDField;
    qrySped_C170COD_CTA: TStringField;
    qrySped_C170VL_OPR: TFMTBCDField;
    qrySped_C170FK_PRODUTO: TIntegerField;
    qrySped_C170FK_UNIDADE: TIntegerField;
    qryBoletoGerenciador: TFDQuery;
    qryBoletoGerenciadorCODIGO: TIntegerField;
    qryBoletoGerenciadorVENCIMENTO: TDateField;
    qryBoletoGerenciadorDATA_DOCUMENTO: TDateField;
    qryBoletoGerenciadorNUMERO_DOCUMENTO: TStringField;
    qryBoletoGerenciadorDATA_PROCESSAMENTO: TDateField;
    qryBoletoGerenciadorVALOR_DOCUMENTO: TFMTBCDField;
    qryBoletoGerenciadorSACADO_NOME_SACADO: TStringField;
    qryBoletoGerenciadorSACADO_CNPJCPF: TStringField;
    qryBoletoGerenciadorSACADO_LOGRADOURO: TStringField;
    qryBoletoGerenciadorSACADO_NUMERO: TStringField;
    qryBoletoGerenciadorSACADO_BAIRRO: TStringField;
    qryBoletoGerenciadorSACADO_CIDADE: TStringField;
    qryBoletoGerenciadorSACADO_UF: TStringField;
    qryBoletoGerenciadorSACADO_CEP: TStringField;
    qryBoletoGerenciadorVALOR_ABATIMENTO: TFMTBCDField;
    qryBoletoGerenciadorVALOR_MORA_JUROS: TFMTBCDField;
    qryBoletoGerenciadorVALOR_DESCONTO: TFMTBCDField;
    qryBoletoGerenciadorDATA_MORA_JUROS: TDateField;
    qryBoletoGerenciadorDATA_DESCONTO: TDateField;
    qryBoletoGerenciadorDATA_ABATIMENTO: TDateField;
    qryBoletoGerenciadorDATA_PROTESTO: TDateField;
    qryBoletoGerenciadorPERCENTUAL_MULTA: TFMTBCDField;
    qryBoletoGerenciadorINSTRUCAO1: TStringField;
    qryBoletoGerenciadorINSTRUCAO2: TStringField;
    qryBoletoGerenciadorPATH_PDF_BOLETO: TStringField;
    qryBoletoGerenciadorFK_CRECEBER: TIntegerField;
    qryBoletoGerenciadorFK_NFE_FATURA: TIntegerField;
    qryBoletoGerenciadorSTATUS: TStringField;
    qryBoletoGerenciadorRETORNO_WEB_SERVICE: TMemoField;
    qryBoletoGerenciadorNOSSO_NUMERO: TStringField;
    qryBoletoGerenciadorLINHA_DIGITAVEL: TStringField;
    qryBoletoParam: TFDQuery;
    qryBoletoParamCODIGO: TIntegerField;
    qryBoletoParamMS_LOCAL_PAGAMENTO: TStringField;
    qryBoletoParamESPECIE_DOCTO: TStringField;
    qryBoletoParamESPECIE_MOEDA: TStringField;
    qryBoletoParamACEITE: TStringField;
    qryBoletoParamCARTEIRA: TStringField;
    qryBoletoParamTIPO_DOCUMENTO: TStringField;
    qryBoletoParamBANCO: TStringField;
    qryBoletoParamTIPO_DISTRIBUICAO: TStringField;
    qryBoletoParamCARAC_TITULO: TStringField;
    qryBoletoParamRESPONSAVEL_EMISSAO: TStringField;
    qryBoletoParamTIPO_CARTEIRA: TStringField;
    qryBoletoParamCNAB_VERSAO: TStringField;
    qryBoletoParamCNAB_LV_LOTE: TIntegerField;
    qryBoletoParamCNAB_LV_ARQUIVO: TIntegerField;
    qryBoletoParamCNAB_CODIGO_TRANSMISSAO: TIntegerField;
    qryBoletoParamCNAB_DENSIDADE_GRAVACAO: TIntegerField;
    qryBoletoParamCNAB_PREFIXO_REMESSA: TIntegerField;
    qryBoletoParamCIP: TStringField;
    qryBoletoParamHOMOLOGACAO: TStringField;
    qryBoletoParamIMP_MSG_PADRAO_COMP_BANCO: TStringField;
    qryBoletoParamLER_CEDENTE_ARQ_RETORNO: TStringField;
    qryBoletoParamLER_NOSSO_NUM_COMPLETO: TStringField;
    qryBoletoParamREMOVER_ACENTUACAO_REMESSA: TStringField;
    qryBoletoParamBEN_AGENCIA: TIntegerField;
    qryBoletoParamBEN_AGENCIA_DV: TIntegerField;
    qryBoletoParamBEN_CONTA: TIntegerField;
    qryBoletoParamBEN_CONTA_DV: TIntegerField;
    qryBoletoParamBEN_AGENCIA_CONTA_DV: TIntegerField;
    qryBoletoParamBEN_CONVENIO: TStringField;
    qryBoletoParamBEN_MODALIDADE: TStringField;
    qryBoletoParamBEN_OPERACAO: TStringField;
    qryBoletoParamBEN_COD_CEDENTE: TIntegerField;
    qryBoletoParamWEBSERVICE_CLIENT_ID: TStringField;
    qryBoletoParamWEBSERVICE_CLIENT_SECRET: TStringField;
    qryBoletoParamWEBSERVICE_KEY_USER: TStringField;
    qryBoletoParamWEBSERVICE_INDICADOR_PIX: TStringField;
    qryBoletoParamWEBSERVICE_SSL_LIB: TStringField;
    qryBoletoParamPATH_REMESSA: TStringField;
    qryBoletoParamPATH_RETORNO_ARQUIVO: TStringField;
    qryBoletoParamFK_EMPRESA: TIntegerField;
    qryBoletoParamLAYOUT: TStringField;
    qryBoletoParamIMP_VERSO_FATURA: TStringField;
    qryBoletoParamNOSSO_NUMERO: TStringField;
    qryProdutos: TFDQuery;
    qryProdutosCODIGO: TIntegerField;
    qryProdutosREFERENCIA: TStringField;
    qryProdutosCODBARRA: TStringField;
    qryProdutosDESCRICAO: TStringField;
    qryProdutosGRUPO_SL: TStringField;
    qryProdutosPR_VENDA: TFMTBCDField;
    qryProdutosQTD_ATUAL: TFMTBCDField;
    qryProdutosQTD_FISCAL: TBCDField;
    qryProdutosLOCALIZACAO: TStringField;
    qryProdutosDT_CADASTRO: TDateField;
    qryUpdateProd: TFDQuery;
    qryUpdateProdEMPRESA: TSmallintField;
    qryUpdateProdCODIGO: TIntegerField;
    qryUpdateProdTIPO: TStringField;
    qryUpdateProdDESCRICAO: TStringField;
    qryUpdateProdCODBARRA: TStringField;
    qryUpdateProdREFERENCIA: TStringField;
    qryUpdateProdGRUPO: TIntegerField;
    qryUpdateProdUNIDADE: TStringField;
    qryUpdateProdULTFORN: TIntegerField;
    qryUpdateProdLOCALIZACAO: TStringField;
    qryUpdateProdCSTICMS: TStringField;
    qryUpdateProdCSTE: TStringField;
    qryUpdateProdCSTS: TStringField;
    qryUpdateProdCSTIPI: TStringField;
    qryUpdateProdCSOSN: TStringField;
    qryUpdateProdNCM: TStringField;
    qryUpdateProdFOTO: TBlobField;
    qryUpdateProdATIVO: TStringField;
    qryUpdateProdCFOP: TStringField;
    qryUpdateProdULT_COMPRA: TIntegerField;
    qryUpdateProdULT_COMPRA_ANTERIOR: TIntegerField;
    qryUpdateProdCOD_BARRA_ATACADO: TStringField;
    qryUpdateProdGRADE: TStringField;
    qryUpdateProdCEST: TStringField;
    qryUpdateProdEFISCAL: TStringField;
    qryUpdateProdPAGA_COMISSAO: TStringField;
    qryUpdateProdCOMPOSICAO: TStringField;
    qryUpdateProdPRECO_PROMO_ATACADO: TFMTBCDField;
    qryUpdateProdPRECO_PROMO_VAREJO: TFMTBCDField;
    qryUpdateProdINICIO_PROMOCAO: TDateField;
    qryUpdateProdFIM_PROMOCAO: TDateField;
    qryUpdateProdPR_VENDA_PRAZO: TFMTBCDField;
    qryUpdateProdPRECO_VARIAVEL: TStringField;
    qryUpdateProdAPLICACAO: TStringField;
    qryUpdateProdREDUCAO_BASE: TFMTBCDField;
    qryUpdateProdMVA: TFMTBCDField;
    qryUpdateProdFCP: TFMTBCDField;
    qryUpdateProdPRODUTO_PESADO: TStringField;
    qryUpdateProdSERVICO: TStringField;
    qryUpdateProdDT_CADASTRO: TDateField;
    qryUpdateProdPR_CUSTO2: TFMTBCDField;
    qryUpdateProdPERC_CUSTO: TFMTBCDField;
    qryUpdateProdCOMISSAO: TCurrencyField;
    qryUpdateProdDESCONTO: TCurrencyField;
    qryUpdateProdPR_CUSTO_ANTERIOR: TFMTBCDField;
    qryUpdateProdPR_VENDA_ANTERIOR: TFMTBCDField;
    qryUpdateProdALIQ_IPI: TFMTBCDField;
    qryUpdateProdALIQ_PIS: TCurrencyField;
    qryUpdateProdALIQ_COF: TCurrencyField;
    qryUpdateProdPR_CUSTO: TFMTBCDField;
    qryUpdateProdMARGEM: TCurrencyField;
    qryUpdateProdPR_VENDA: TFMTBCDField;
    qryUpdateProdQTD_ATUAL: TFMTBCDField;
    qryUpdateProdQTD_MIN: TFMTBCDField;
    qryUpdateProdE_MEDIO: TFMTBCDField;
    qryUpdateProdESTOQUE_INICIAL: TFMTBCDField;
    qryUpdateProdPESO: TFMTBCDField;
    qryUpdateProdALIQ_ICM: TCurrencyField;
    qryUpdateProdPRECO_ATACADO: TFMTBCDField;
    qryUpdateProdQTD_ATACADO: TFMTBCDField;
    qryEmpresaUSA_WHATS: TStringField;
    qryEmpresaPEDIR_COLE_ETIQUETA: TStringField;
    qryTerminalLER_PESO: TStringField;
    qrySped_H010CODIGO: TIntegerField;
    qrySped_H010QTD: TBCDField;
    qrySped_H010VL_UNIT: TFMTBCDField;
    qrySped_H010VL_ITEM: TFMTBCDField;
    qrySped_H010IND_PROP: TStringField;
    qrySped_H010COD_PART: TIntegerField;
    qrySped_H010TXT_COMPL: TStringField;
    qrySped_H010COD_CTA: TStringField;
    qrySped_H010FK_H005: TIntegerField;
    qrySped_H010FK_PRODUTO: TIntegerField;
    qrySped_H010FK_UNIDADE: TStringField;
    qrySped_H010FK_EMPRESA: TIntegerField;
    qrySped_H010FK_USUARIO: TIntegerField;
    qrySped_H010CST_ICMS: TStringField;
    qrySped_H010BC_ICMS: TFMTBCDField;
    qrySped_H010VL_ICMS: TFMTBCDField;
    qrySped_H005DT_INVE: TDateField;
    qrySped_ConfigREGIME_TRIBUTARIO: TStringField;
    qrySped_ConfigCONFIG_1601: TStringField;
    qrySped_ConfigADM_PADRAO_CARTAO_DEB: TIntegerField;
    qrySped_ConfigADM_PADRAO_CARTAO_CRE: TIntegerField;
    qrySped_ConfigADM_PADRAO_PIX: TIntegerField;
    qrySped_ConfigADM_PADRAO_VALE_ALI: TIntegerField;
    qryConfigPATHXMLENTRADA: TStringField;
    qryConfigTEF_GP: TIntegerField;
    qryConfigTEF_AUTO_ATIVAR_GP: TStringField;
    qryConfigTEF_MULT_CARTOES: TStringField;
    qryConfigTEF_AUTO_PAGAMENTO: TStringField;
    qryConfigTEF_AUTO_FINALIZA: TStringField;
    qryConfigTEF_EXIBIR_MSG_AUTETI: TStringField;
    qryConfigTEF_SLEEP: TIntegerField;
    qryConfigTEF_STS: TIntegerField;
    qryConfigTEF_NUM_VIAS: TIntegerField;
    qryConfigTEF_APLICACAO: TStringField;
    qryConfigTEF_RAZAO: TStringField;
    qryConfigTEF_REGISTRO_CERT: TStringField;
    qryConfigTEF_SOFT_HOUSE: TStringField;
    qryConfigTEF_VERS_APLICACAO: TStringField;
    qryConfigTIPO_IMP_ETQ: TStringField;
    qryConfigMODELO_ETQ_FAST: TStringField;
    qryConfigIMPRESSORA_FAST_ETQ: TStringField;
    qryConfigVENDAS_SIMPLES_NAO_MOV_CAIXA: TStringField;
    qryConfigSH_CON_LOGIN: TStringField;
    qryConfigSH_CON_PASS: TStringField;
    qryConfigSH_CON_SERVER: TStringField;
    qryConfigSH_CON_DATABASE: TStringField;
    qryConfigDASH_CON_LOGIN: TStringField;
    qryConfigDASH_CON_PASS: TStringField;
    qryConfigDASH_CON_SERVER: TStringField;
    qryConfigDASH_CON_DATABASE: TStringField;
    QRYNFCE_DBLOQUEADO: TStringField;
    QRYNFCE_DVICMSDESON: TBCDField;
    QRYNFCE_DALIQICMSDESON: TBCDField;
    QRYNFCE_DFK_GRADE: TIntegerField;
    QRYNFCE_DREDUCAO_BASE: TFMTBCDField;
    qryTerminalIMPRIME_PREVIEW: TStringField;
    qryTerminalTIPOFECHAMENTO: TStringField;
    qryTerminalMEIAFOLHA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure serial;
    procedure ConsultaCliente(var Codigo: Integer; var Razao: string;
      var Fantasia: string);
    procedure qryConfiguracaoAfterPost(DataSet: TDataSet);
    procedure qryItensCompraBeforeOpen(DataSet: TDataSet);
    procedure qryItensCompraAfterPost(DataSet: TDataSet);
    procedure qryItensOBeforeOpen(DataSet: TDataSet);
    procedure qryCaixaAfterPost(DataSet: TDataSet);
    procedure qryTelasAfterPost(DataSet: TDataSet);
    procedure qryTelasAfterDelete(DataSet: TDataSet);
    procedure qryPermissoesAfterPost(DataSet: TDataSet);
    procedure qryPermissoesAfterDelete(DataSet: TDataSet);
    procedure qryTerminalNewRecord(DataSet: TDataSet);
    procedure qryConfigNewRecord(DataSet: TDataSet);
    procedure qryCPAfterOpen(DataSet: TDataSet);
    procedure qryCRAfterOpen(DataSet: TDataSet);
    procedure qryFichaClienteAfterPost(DataSet: TDataSet);
    procedure qryFichaClienteAfterDelete(DataSet: TDataSet);
    procedure qryCaixaNewRecord(DataSet: TDataSet);
    procedure qryEmpresaNewRecord(DataSet: TDataSet);
    procedure ConexaoAfterConnect(Sender: TObject);
    procedure qryParametroAfterPost(DataSet: TDataSet);
    procedure qryParametroAfterDelete(DataSet: TDataSet);
    procedure qryChaveAfterPost(DataSet: TDataSet);
    procedure qryOrcamentoCalcFields(DataSet: TDataSet);
    procedure qryPessoasAfterPost(DataSet: TDataSet);
    procedure qryPessoasNewRecord(DataSet: TDataSet);
    procedure qryProdutosBeforeOpen(DataSet: TDataSet);
    procedure qryConfigBeforeDelete(DataSet: TDataSet);
    procedure qryTranspAfterPost(DataSet: TDataSet);
    procedure qryVendedorAfterPost(DataSet: TDataSet);
    procedure qryFPGAfterPost(DataSet: TDataSet);
    procedure qryPlanoAfterPost(DataSet: TDataSet);
    procedure qryGrupoAfterPost(DataSet: TDataSet);
    procedure qryCPAfterPost(DataSet: TDataSet);
    procedure qryCRAfterPost(DataSet: TDataSet);
    procedure qryEmpresaBeforePost(DataSet: TDataSet);
    procedure qryEmpresaID_CIDADEChange(Sender: TField);
    procedure qrySped_ConfigNewRecord(DataSet: TDataSet);
    procedure qryVeiculos_ReboqueNewRecord(DataSet: TDataSet);
    procedure qryConfigBeforePost(DataSet: TDataSet);
    procedure qryNFCE_MAfterPost(DataSet: TDataSet);
    procedure qryNFCE_MAfterDelete(DataSet: TDataSet);
    procedure qryCaixaBeforePost(DataSet: TDataSet);
    procedure qryPessoasBeforePost(DataSet: TDataSet);
    procedure qryContasCalcFields(DataSet: TDataSet);
    procedure qryEtiquetaNewRecord(DataSet: TDataSet);
    procedure qryEtq_CamposNewRecord(DataSet: TDataSet);
    procedure qryEtiquetaAfterPost(DataSet: TDataSet);
    procedure qryEtq_CamposAfterPost(DataSet: TDataSet);
    procedure qryParametroBeforeEdit(DataSet: TDataSet);
    procedure qryEtq_CamposBeforeInsert(DataSet: TDataSet);
    procedure qryEtq_CamposBeforePost(DataSet: TDataSet);
    procedure qryCCBeforePost(DataSet: TDataSet);
    procedure qryNFCE_MBeforePost(DataSet: TDataSet);
    procedure QRYNFCE_DBeforePost(DataSet: TDataSet);
    procedure qryIdiomasNewRecord(DataSet: TDataSet);
    procedure qryIdiomasAfterPost(DataSet: TDataSet);
    procedure qryFPGBeforePost(DataSet: TDataSet);
    procedure qryGrupoBeforePost(DataSet: TDataSet);
    procedure qryConfigCODIGO_ATIVACAOValidate(Sender: TField);
    procedure qryMotoristaAfterPost(DataSet: TDataSet);
    procedure qryMotoristaAfterDelete(DataSet: TDataSet);
    procedure qryMotoristaNewRecord(DataSet: TDataSet);
    procedure qryMotoristaBeforeInsert(DataSet: TDataSet);
    procedure qryMotoristaBeforePost(DataSet: TDataSet);
    procedure qryTranspBeforePost(DataSet: TDataSet);
    procedure qryMesasCalcFields(DataSet: TDataSet);
    procedure qryXmlMasterAfterDelete(DataSet: TDataSet);
    procedure qryXmlMasterAfterPost(DataSet: TDataSet);
    procedure QryXmlDetailAfterDelete(DataSet: TDataSet);
    procedure QryXmlDetailAfterEdit(DataSet: TDataSet);
    procedure QryXmlDetailAfterOpen(DataSet: TDataSet);
    procedure QryXmlDetailAfterPost(DataSet: TDataSet);
    procedure QryXmlDetailBeforePost(DataSet: TDataSet);
    procedure qryXMLProdutoAfterDelete(DataSet: TDataSet);
    procedure qryXMLProdutoAfterPost(DataSet: TDataSet);
    procedure QryXmlDetailQTD_TOTALChange(Sender: TField);
    procedure QryXmlDetailQUANT_SChange(Sender: TField);
  private
    procedure CriptografaSenha;
    procedure GravarTraducao(Codigo, idioma: Integer;
      tela, objeto, texto_pt_br, texto_traduzido: string);
    procedure CadastraObjeto(Formulario, objeto, Valor: String);
    procedure AjustaComposicao(IdProduto: Integer; E_S: String);

    { Private declarations }
  public
    vForm: Tform;
    aMenu: String;
    aUsuario: String;
    aTag: Integer;
    vMudouEstoque: boolean;
    ServidorAPP, SenhaAPP, SenhaLI, UsuarioAPP, DatabasLI, DatabaseAPP: String;
    IsGlobalOffline: boolean;
    FVerificouOnline: boolean;
    eSupervisor, vFazEntrega: boolean;
    FVerificaValidade: boolean;
    vAutorizar, vChamaImpressao: boolean;
    vPodeFecharCaixa, vPodeFecharVenda, vPodeFecharPedido,
      vPodeFecharCompra: boolean;
    vRetaguarda, vLancamentoCaixa, vFechaPrograma, vLiberaProduto,
      vLiberaPessoa: boolean;
    idEmpresa, vidLote, vCodProduto: Integer;
    vPrecoProduto: Extended;
    vCodGrupo: Integer;
    idCaixa, idUsuario: Integer;
    FMsg, vConta, vUsuario, nometerminal, tela, vEnviarSefa, MAC: string;
    TerminalCaixa: boolean;
    FTIpoPDV: String;
    IdVenda, Lote: Integer;
    FDataSistema: TDateTime;
    function GetParcelas(Codigo: Integer): String;
    function BloqueiaValidade: boolean;
    procedure AjustaPreco(produto, compra: Integer; preco, venda: Extended;
      bAjusteCompra: boolean = False);
    procedure CriaTerminal;
    procedure EstornaFinanceiro(Codigo: Integer);
    function Numerador(Tabela, Campo, filtra, where, Valor: String): Integer;
    procedure EstornaEstoque(Codigo: Integer; QtdAtual, QtdFiscal: real;
      op: word);
    procedure ChamaContato(Msg: String);
    function BuscaIcms(tipo, UFOrigem, UFDestino: String): real;
    function Alinha(Texto: String; Total: Integer; Lado: boolean): String;
    function Spaces(C: Integer): String;
    procedure CriaPastas;
    function Getcomputer: String;
    function Crypt(Action, Src: String): String;
    function buscafpg(tipo: string): Integer;
    function BuscaIntervalo(tipo: string): Integer;
    function ExecuteAndWaitEx(const CommandLine: string): DWORD;
    function DiasAtraso(DataVencimento, DataAtual: TDate; Carencia: Integer)
      : Extended;
    function CalculaJuros: Extended;
    procedure Conectado;
    procedure limpaFlagCP(Codigo: Integer);
    procedure limpaFlagCR(Codigo: Integer);
    procedure ConfiguraEstilo(Estilo: String);
    function Truncar(Valor: Extended; casas: Integer): Extended;
    function PegaNomePessoa(id: Integer): String;
    function BuscaCodigoIbge(cidade, uf: string): Integer;
    function GetBuildInfo(Prog: string): string;
    procedure LimpaTerminais;
    procedure SetComponentes;
    procedure GetComponentes;
    function BuscaTaxaCartao(id: Integer): Extended;
    function checanfce(Codigo: Integer): boolean;
    procedure AtualizaTerminal;
    function buscacodigoProduto(sql, parametro: STRING): Integer;
    function buscacodigoPessoa(referencia: STRING): Integer;
    function buscaemailPessoa(Codigo: Integer): String;
    procedure UpdateTipoBoleto(Codigo: Integer);
    procedure LimpaCaixa(Codigo: Integer);
    procedure InsereCaixa(Empresa, IDCR, FKPLANO, FKCONTA, ID_USUARIO: Integer;
      TIPO_MOVIMENTO, FPG, DOC, HISTORICO, TRANSFERENCIA, ECARTAO: String;
      ENTRADA: Extended);
    procedure AtualizaValidadeSistema(Codigo: Integer; CNPJ, Bloqueado: string;
      Data: TDate);
    function BuscaDescricaoProduto(Codigo: Integer): string;
    function FormataCPFCNPJ(Valor: String): String;
    function BuscaPlanoConta(Codigo: Integer): boolean;
    procedure DeletaRemessa(Caminho, Arquivo: String);
    function AlteraDataPreco(Codigo: Integer): TDate;
    function RetornoNumeroBoleto: Integer;
    function GeraNumeroNFe(idEmpresa, idserie: Integer): Integer;
    procedure estornaserial(idSerial: Integer);
    function EhNumero(S: string): boolean;
    Procedure AjustaCamposNovos(tela: string);
    procedure BloqueiaCliente;
    procedure LimpaTEF(NSU: String);
    procedure ChecaPDV;
    function BuscaDescricaoProdutoBarra(Codigo: String): string;
    procedure InsereMensagemZap(anexo, fone, Mensagem, MensagemPadrao, Pessoa,
      Empresa, Origem: String);
    procedure AbreTerminal;
    procedure UpdateTela(aform: string);
    procedure Habilitacoes(aMenu, aform: String);
    procedure ApagaNumeroSerie;
    procedure InserePermissoes(aTela: Integer);
    procedure AjustaPermissoes;
    procedure PassarServerPadrao;
    function GetMacAddress: string;
    function BuscaEstadoDesc(sigla: String): string;
    function BuscaEstadoSigla(sigla: String): string;
    function BuscarCFOP(CFOP: string): string;
    procedure Permissoes_NavBar;
    function LimpaString(str: string): string;
    function EhLetra(S: String): boolean;
    function GetIdFormaForAtalho(sAtalho: string): Integer;
    function BuscaValor(Codigo: Integer; tp: string): Extended;
    procedure AjustaCusto(produto: Integer; compra, custo: Extended);
    // update 43
    procedure AtualizaEstoque(Qtd, IdProduto: real); // update 43
    function GravaUltimoPreco(IdProduto: Integer; UltimoPreco: real): boolean;
    function DeletarUltimoPreco(IdProduto: Integer): boolean;
    function GetLocalIP: string;
    function ValidaGTIN(AGTIN: string): boolean;
    function TBRound(Value: Extended; Decimals: Integer): Extended;
    // Boleto
    function SoNumero(fField: String): String;
    function EhSoNumero(fField: string): boolean;
    function VerificaCodigoVenda(codigo: Integer): Boolean;
    function IncluiBoleto(dm: TdmForte; iCodCliente: Integer;
      dtVencimento: TDate; NumDocumento: string; rValor: Extended;
      rVlrJuros: Extended; rVlrDesconto: Extended; rVlrAbatimento: Extended;
      rPercMulta: Extended; dtJuros: string; dtDesconto: string;
      dtAbatimento: string; dtProtesto: string; sInstrucao01: string;
      sInstrucao02: string; dtEmissao: TDate; var CodBarras: string): boolean;
    function RegistraBoleto(dm: TdmForte): boolean;
    procedure ZerarListaBoleto(dm: TdmForte);
    procedure GerarBoleto(dm: TdmForte; var sPath: string; var sErro: string;
      bImprimir: boolean = False);
    procedure CarregarParametrosBoleto(dm: TdmForte);
    procedure GravarNoGerenciadorBoleto(dm: TdmForte; sOrigem: string;
      sPath: string; iCodCReceber: Integer = 0; iCodNFeFatura: Integer = 0;
      CodigoBarras: string = '');
    { Public declarations }
  end;

var
  Dados: TDados;
  FEmail: TEmail;
  VerificaVersao: boolean;
  nSerial, vSerial: string[30];
function iff(bExpressao: boolean; vValor1, vValor2: Variant): Variant;
function RetornaDataFormatoSQL(dData: string): String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses serial, uDadosWeb, uConexaoBD, uConsClientes;
{$R *.dfm}

procedure TDados.InserePermissoes(aTela: Integer);
var
  qryPermissoes: TFDQuery;
begin
  qryPermissoes := TFDQuery.Create(self);
  qryPermissoes.Connection := Dados.Conexao;
  qryPermissoes.Close;
  qryPermissoes.sql.Clear;
  qryPermissoes.sql.Add
    ('INSERT INTO PEMISSOES (FKUSUARIO, FKTELA, VISUALIZAR, EXCLUIR, EDITAR, INCLUIR, VISIVEL)');
  qryPermissoes.sql.Add
    ('VALUES ( :FKUSUARIO, :FKTELA, :VISUALIZAR, :EXCLUIR, :EDITAR, :INCLUIR, :VISIVEL);');
  qryPermissoes.ParamByName('FKUSUARIO').AsFloat :=
    Dados.qryUsuariosCODIGO.Value;
  qryPermissoes.ParamByName('FKTELA').AsFloat := Dados.qryTelasCODIGO.Value;
  // Permissão Full para todos user deposi de ter modificado a tabela permissões.
  qryPermissoes.ParamByName('VISUALIZAR').Value := 'S';
  qryPermissoes.ParamByName('EXCLUIR').Value := 'S';
  qryPermissoes.ParamByName('EDITAR').Value := 'S';
  qryPermissoes.ParamByName('INCLUIR').Value := 'S';
  qryPermissoes.ParamByName('VISIVEL').Value := 'S';
  // Permissão Full somente para o Admin
  { if Dados.qryUsuarios.RecordCount = 1 then
    begin
    qryPermissoes.ParamByName('VISUALIZAR').Value := 'S';
    qryPermissoes.ParamByName('EXCLUIR').Value := 'S';
    qryPermissoes.ParamByName('EDITAR').Value := 'S';
    qryPermissoes.ParamByName('INCLUIR').Value := 'S';
    qryPermissoes.ParamByName('VISIVEL').Value := 'S';
    end
    else
    begin
    qryPermissoes.ParamByName('VISUALIZAR').Value := 'N';
    qryPermissoes.ParamByName('EXCLUIR').Value := 'N';
    qryPermissoes.ParamByName('EDITAR').Value := 'N';
    qryPermissoes.ParamByName('INCLUIR').Value := 'N';
    qryPermissoes.ParamByName('VISIVEL').Value := 'N';
    end; }
  qryPermissoes.execsql;
  Conexao.Commit;
end;

procedure TDados.AjustaPermissoes;
begin
  qryTelas.Close;
  qryTelas.Open;
  qryUsuarios.Close;
  qryUsuarios.Open;
  qryUsuarios.First;
  while not qryUsuarios.Eof do
  begin
    qryPermissoes.Close;
    qryPermissoes.Params[0].Value := qryUsuariosCODIGO.Value;
    qryPermissoes.Open;
    qryTelas.First;
    while not qryTelas.Eof do
    begin
      if not(qryPermissoes.locate('FKTELA', qryTelas.FieldByName('CODIGO')
        .Value, [])) then
        InserePermissoes(qryTelas.FieldByName('CODIGO').AsInteger);
      qryTelas.Next;
    end;
    qryUsuarios.Next;
  end;
end;

procedure TDados.Habilitacoes(aMenu, aform: String);
begin
  UpdateTela(aform);
  qryPermissoesBotao.Close;
  qryPermissoesBotao.Params[0].Value := aform;
  qryPermissoesBotao.Params[1].Value := Dados.idUsuario;
  qryPermissoesBotao.Open;
end;

procedure TDados.DeletaRemessa(Caminho, Arquivo: String);
begin
  if FileExists(Caminho) then
    DeleteFile(pchar(Caminho));
  Dados.qryUpdate.Close;
  Dados.qryUpdate.sql.Text :=
    'update cbr_remessa set CANCELADA=''S'' where ID_CBR_REMESSA_UUID=:ID';
  Dados.qryUpdate.Params[0].Value := Arquivo;
  Dados.qryUpdate.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.UpdateTela(aform: string);
var
  qryTela: TFDQuery;
begin
  try
    qryTela := TFDQuery.Create(self);
    qryTela.Connection := Conexao;
    qryTela.Close;
    qryTela.sql.Clear;
    qryTela.sql.Text := 'update telas set grupo=:grupo where tela=:tela';
    qryTela.Params[0].Value := aform;
    qryTela.Params[1].Value := Dados.aMenu;
    qryTela.execsql;
    Conexao.Commit;
  except
    Conexao.RollbackRetaining;
  end;
end;

function TDados.BuscaPlanoConta(Codigo: Integer): boolean;
begin
  Result := true;
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text := 'SELECT CODIGO FROM PLANO WHERE CODIGO=:CODIGO';
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Open;
  if Dados.qryConsulta.IsEmpty then
    Result := False;
end;

function TDados.BuscarCFOP(CFOP: string): string;
begin
  Result := 'NAO';
  Dados.qryCFOP.Close;
  Dados.qryCFOP.sql.Text := 'SELECT * FROM CFOP WHERE CODIGO=:pCodigo';
  Dados.qryCFOP.Params[0].Value := strToint(CFOP);
  Dados.qryCFOP.Open;
  if not Dados.qryCFOP.IsEmpty then
    Result := 'SIM';
end;

procedure TDados.LimpaCaixa(Codigo: Integer);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text := 'DELETE FROM CAIXA WHERE FKRECEBER=:CODIGO';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.ChecaPDV;
begin
  Dados.qryTerminal.Close;
  Dados.qryTerminal.Params[0].Value := Dados.Getcomputer;
  Dados.qryTerminal.Open;
  AbreTerminal;
  if Dados.qryTerminalDELIVERY.Value = 'S' then
    Dados.FTIpoPDV := 'DELIVERY'
  else if Dados.qryTerminalRESTAURANTE.Value = 'S' then
    Dados.FTIpoPDV := 'RESTAURANTE'
  else
    Dados.FTIpoPDV := 'PDV';
end;

function TDados.BuscaTaxaCartao(id: Integer): Extended;
begin
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Clear;
  Dados.qryConsulta.sql.Add
    ('select coalesce(sum(fpg.taxa),0) as TAXA from forma_pagamento  fpg');
  Dados.qryConsulta.sql.Add('where');
  Dados.qryConsulta.sql.Add('fpg.codigo=:CODIGO;');
  Dados.qryConsulta.Params[0].AsInteger := id;
  Dados.qryConsulta.Open;
  try
    Result := Dados.qryConsulta.FieldByName('TAXA').AsFloat;
  except
    Result := 0;
  end;
end;

function TDados.GetParcelas(Codigo: Integer): String;
begin
  Result := '';
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Clear;
  Dados.qryConsulta.sql.Add
    ('select cr.dtvencimento, cr.valor from creceber cr');
  Dados.qryConsulta.sql.Add('where');
  Dados.qryConsulta.sql.Add('cr.fk_venda=:id');
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Open;
  Dados.qryConsulta.First;
  while not Dados.qryConsulta.Eof do
  begin
    Result := Result + ' ' + Dados.qryConsulta.FieldByName('dtvencimento')
      .AsString + ' ' + FormatFloat('0.00',
      Dados.qryConsulta.FieldByName('valor').AsFloat);
    Dados.qryConsulta.Next;
  end;
  if trim(Result) <> '' then
    Result := Result;
end;

procedure TDados.AjustaComposicao(IdProduto: Integer; E_S: String);
begin
end;

function TDados.Truncar(Valor: Extended; casas: Integer): Extended;
var
  multiplo: Integer;
begin
  case casas of
    1:
      multiplo := 10;
    2:
      multiplo := 100;
    3:
      multiplo := 1000;
    4:
      multiplo := 10000;
  else
    multiplo := 100;
  end;
  try
    Result := Trunc(Valor * multiplo) / multiplo;
  except
    Result := 0;
  end;
end;

function TDados.FormataCPFCNPJ(Valor: String): String;
begin
  Result := '';
  if (trim(Valor) <> '') and (Length(Valor) = 14) then
  begin
    Result := copy(Valor, 1, 2) + '.' + copy(Valor, 3, 3) + '.' +
      copy(Valor, 6, 3) + '/' + copy(Valor, 9, 4) + '-' + copy(Valor, 13, 2);
  end;
  if (trim(Valor) <> '') and (Length(Valor) = 11) then
  begin
    Result := copy(Valor, 1, 3) + '.' + copy(Valor, 4, 3) + '.' +
      copy(Valor, 7, 3) + '-' + copy(Valor, 10, 2);
  end;
end;

function TDados.EhNumero(S: string): boolean;
var
  i: Integer;
begin
  Result := true;
  for i := 1 to Length(S) do
  begin
    if not(S[i] in ['0' .. '9']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TDados.Crypt(Action, Src: String): String;
Label Fim;
var
  KeyLen: Integer;
  KeyPos: Integer;
  OffSet: Integer;
  Dest, Key, KeyNew: String;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  if (Src = '') Then
  begin
    Result := '';
    Goto Fim;
  end;
  Key := 'XNGREXCPAJHKQWERYTUIOP98756LKJHASFGMNBVCAXZ13450';
  KeyNew := 'PRODOXCPAJHKQWERYTUIOP98765LKJHASFGMNBVCAXZ01234';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 128;
  if (Action = UpperCase('C')) then
  begin
    // Randomize;
    OffSet := Range;
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := strToint('$' + copy(Src, 1, 2));
    // <--------------- adiciona o $ entra as aspas simples
    SrcPos := 3;
    repeat
      SrcAsc := strToint('$' + copy(Src, SrcPos, 2));
      // <--------------- adiciona o $ entra as aspas simples
      if (KeyPos < KeyLen) Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;
  Result := Dest;
Fim:
end;

procedure TDados.PassarServerPadrao;
begin
  try
    Dados.qryParametro.Close;
    Dados.qryParametro.Open;
    if (qryParametroSERVIDOR_APP.AsString = EmptyStr) or
      (qryParametroDATABASE_LI.AsString = EmptyStr) or
      (qryParametroUSUARIO_LI.AsString = EmptyStr) or
      (qryParametroSENHA_LI.AsString = EmptyStr) then
    begin
      if not(Dados.qryParametro.State in [dsEdit, dsInsert]) then
        Dados.qryParametro.Edit;
      { TODO : Trocar informações do Controle Licenças }
      qryParametroSERVIDOR_APP.AsString := ''; // IP do seu servidor
      Dados.qryParametroDATABASE_LI.AsString := Dados.Crypt('C', '');
      // Nome do banco de dados
      Dados.qryParametroUSUARIO_LI.AsString := Dados.Crypt('C', '');
      // Usuario do banco de dados
      Dados.qryParametroSENHA_LI.AsString := Dados.Crypt('C', '');

      Dados.qryParametro.Post;
      Conexao.Commit;
    end;
  except
  end;
end;

function TDados.PegaNomePessoa(id: Integer): String;
begin
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text := 'select razao from pessoa where codigo=:cod';
  Dados.qryConsulta.Params[0].Value := id;
  Dados.qryConsulta.Open;
  Result := Dados.qryConsulta.FieldByName('razao').AsString;
end;

procedure TDados.Permissoes_NavBar;
begin
  // permissoes navbar Dx
end;

function TDados.AlteraDataPreco(Codigo: Integer): TDate;
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'update produto set data_preco=current_date where codigo=:codigo';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.CriaPastas;
begin
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\Temp') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\Temp');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\Sped') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\Sped');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CTe') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CTe');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CTe\Enviadas')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CTe\Enviadas');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CTe\PDF') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CTe\PDF');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CTe\Eventos')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CTe\Eventos');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) +
    '\CTe\Inutilizacao') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CTe\Inutilizacao');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) +
    '\NFe\Inutilizacao') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\NFe\Inutilizacao');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MDFe') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MDFe');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MDFe\MDFe')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MDFe\MDFe');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MDFe\Evento')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MDFe\Evento');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MDFe\Salvar')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MDFe\Salvar');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MDFe\PDF')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MDFe\PDF');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe\PDF') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\PDF');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe\Venda')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\Venda');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) +
    '\CFe\Cancelamento') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\Cancelamento');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe\Envio')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\Envio');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe\Schemas')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\Schemas');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\CFe\Remessa')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\CFe\Remessa');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MFe') then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MFe');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MFe\Entrada')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MFe\Entrada');
  if not DirectoryExists(ExtractFilePath(Application.ExeName) + '\MFe\Saida')
  then
    CreateDir(ExtractFilePath(Application.ExeName) + '\MFe\Saida');
end;

function TDados.Spaces(C: Integer): String;
begin
  Result := StringOfChar(' ', C);
end;

function TDados.Alinha(Texto: String; Total: Integer; Lado: boolean): String;
begin
  if Lado Then // alinha a direita.
    Result := Spaces(Total - Length(Texto)) + Texto
  else // alinha a esquerda
    Result := Texto + Spaces(Total - Length(Texto));
end;

function TDados.Getcomputer: String;
var
  lpBuffer: pchar;
  nSize: DWORD;
const
  Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  nSize := Buff_Size;
  lpBuffer := StrAlloc(Buff_Size);
  GetComputerName(lpBuffer, nSize);
  Result := String(lpBuffer);
  StrDispose(lpBuffer);
end;

function TDados.GetMacAddress: string; // upd6 - Wagner Elias 08/01/2025
var
  Addresses: PIP_ADAPTER_ADDRESSES;
  Adapter: PIP_ADAPTER_ADDRESSES;
  BufLen: ULONG;
  MACAddress: string;
  i: Integer;
begin
  Result := '';
  BufLen := 0;

  // Chama a função para obter o tamanho necessário do buffer
  GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, nil, nil, BufLen);
  GetMem(Addresses, BufLen);

  try
    // Agora chama novamente para obter os dados
    if GetAdaptersAddresses(AF_UNSPEC, GAA_FLAG_INCLUDE_PREFIX, nil, Addresses,
      BufLen) = NO_ERROR then
    begin
      Adapter := Addresses;

      while Assigned(Adapter) do
      begin
        // Verifica se o adaptador está ativo e tem um endereço físico válido
        if (Adapter^.OperStatus = 1) and (Adapter^.PhysicalAddressLength > 0)
        then
        begin
          // Monta o MAC Address
          MACAddress := '';
          for i := 0 to Adapter^.PhysicalAddressLength - 1 do
          begin
            MACAddress := MACAddress + IntToHex(Adapter^.PhysicalAddress[i], 2);
            if i < Adapter^.PhysicalAddressLength - 1 then
              MACAddress := MACAddress + '-';
          end;

          Result := MACAddress;
          Exit;
        end;

        // Próximo adaptador
        Adapter := Adapter^.Next;
      end;
    end;
  finally
    FreeMem(Addresses);
  end;

  if Result = '' then
    raise Exception.Create('Nenhuma conexão ativa encontrada!');
end;

procedure TDados.estornaserial(idSerial: Integer);
begin
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Clear;
  Dados.qryConsulta.sql.Add
    (' update produto_serial set DOC_SAIDA=null, SITUACAO=null, DATA_BAIXA=null where codigo=:codigo');
  Dados.qryConsulta.Params[0].Value := idSerial;
  Dados.qryConsulta.Prepare;
  Dados.qryConsulta.execsql;
  Dados.Conexao.Commit;
end;

function iff(bExpressao: boolean; vValor1, vValor2: Variant): Variant;
begin
  if bExpressao then
    Result := vValor1
  else
    Result := vValor2;
end;

function TDados.BuscaCodigoIbge(cidade, uf: string): Integer;
begin
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text :=
    'SELECT CODIGO FROM CIDADE WHERE DESCRICAO=:DESCRI AND UF=:UF';
  Dados.qryConsulta.Params[0].Value := cidade;
  Dados.qryConsulta.Params[1].Value := uf;
  Dados.qryConsulta.Open;
  if not Dados.qryConsulta.IsEmpty then
    Result := Dados.qryConsulta.Fields[0].AsInteger;
end;

function TDados.BuscaIntervalo(tipo: string): Integer;
begin
  Result := 0;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Clear;
  Dados.qryExecute.sql.Add(' select INTERVALO from FORMA_PAGAMENTO');
  Dados.qryExecute.sql.Add(' where');
  Dados.qryExecute.sql.Add(' tipo=:TP');
  Dados.qryExecute.Params[0].Value := tipo;
  Dados.qryExecute.Open;
  Result := Dados.qryExecute.Fields[0].AsInteger;
end;

function TDados.buscaemailPessoa(Codigo: Integer): String;
begin
  Result := '';
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text :=
    'select email1 from pessoa where codigo=:codigo';
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Open;
  if not Dados.qryConsulta.IsEmpty then
    Result := Dados.qryConsulta.FieldByName('email1').AsString;
end;

function TDados.BuscaEstadoDesc(sigla: String): string;
begin
  // contar se tem mais que 1
  { qryContar.Close;                   // apagar
    qryContar.SQL.Text := 'select count(*) as contar from tb_estado where descricao like ''' + '%' + sigla + '%''';
    qryContar.Open;
    if qryContarCONTAR.Value > 1 then
    begin
    Result := 'CONS';
    end
    else if qryContarCONTAR.Value = 0 then
    begin
    Result := 'N';
    end
    else
    begin
    Dados.qryEstado.Close;
    Dados.qryEstado.SQL.Text := 'select * from tb_estado where descricao =:pSigla';
    Dados.qryEstado.Params[0].Value := sigla;
    Dados.qryEstado.Open;
    if not Dados.qryEstado.IsEmpty then
    begin
    Result := qryEstadoSIGLA.Value;
    end
    else
    begin
    Result := 'N';
    end;
    end; }
end;

function TDados.BuscaEstadoSigla(sigla: String): string;
begin
  { Dados.qryEstado.Close;
    Dados.qryEstado.SQL.Text := 'select * from tb_estado where sigla =:pSigla';
    Dados.qryEstado.Params[0].Value := sigla;
    Dados.qryEstado.Open;
    if not Dados.qryEstado.IsEmpty then
    begin
    Result := qryEstadoSIGLA.Value;
    end
    else
    begin
    Result := 'N';
    end; }
end;

function TDados.GeraNumeroNFe(idEmpresa: Integer; idserie: Integer): Integer;
begin
  Result := 0;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'SELECT COALESCE(MAX(NUMERO),0) qtd FROM NFE_MASTER WHERE SERIE=:SERIE AND FKEMPRESA=:EMPRESA';
  Dados.qryExecute.Params[0].Value := idserie;
  Dados.qryExecute.Params[1].Value := idEmpresa;
  Dados.qryExecute.Open;
  Result := Dados.qryExecute.FieldByName('qtd').AsInteger;
end;

function TDados.buscafpg(tipo: string): Integer;
begin
  Result := 0;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Clear;
  Dados.qryExecute.sql.Add(' select codigo from FORMA_PAGAMENTO');
  Dados.qryExecute.sql.Add(' where');
  Dados.qryExecute.sql.Add(' tipo=:TP');
  Dados.qryExecute.Params[0].Value := tipo;
  Dados.qryExecute.Open;
  Result := Dados.qryExecute.Fields[0].AsInteger;
end;

function RetornaDataFormatoSQL(dData: string): String;
begin
  if trim(dData) <> '' then
    Result := QuotedStr(FormatDateTime('DD.MM.YYYY',
      strtodate(StringReplace(dData, '.', '/', [rfReplaceAll]))));
end;

function EnDecryptString(StrValue: String; Chave: word): String;
var
  i: Integer;
  OutValue: String;
begin
  OutValue := '';
  for i := 1 to Length(StrValue) do
    OutValue := OutValue + Char(Not(Ord(StrValue[i]) - Chave));
  Result := OutValue;
end;

procedure TDados.ConexaoAfterConnect(Sender: TObject);
begin
  CriptografaSenha;
end;

procedure TDados.CriptografaSenha;
var
  Senha: string;
begin
  qryUsuarios.Close;
  qryUsuarios.Open;
  qryUsuarios.First;
  while not qryUsuarios.Eof do
  begin
    if qryUsuariosECAIXA.Value <> 'C' then
    begin
      qryUsuarios.Edit;
      Senha := Crypt('C', qryUsuariosSENHA.Value);
      qryUsuariosSENHA.Value := Senha;
      qryUsuariosECAIXA.Value := 'C';
      qryUsuarios.Post;
      Conexao.Commit;
    end;
    qryUsuarios.Next;
  end;
end;

procedure TDados.ApagaNumeroSerie;
begin
  Dados.qryChave.Close;
  Dados.qryChave.Params[0].Value := Dados.Getcomputer;
  Dados.qryChave.Open;
  if not Dados.qryChave.IsEmpty then
    Dados.qryChave.Delete;
  Conexao.Commit;
end;

function TDados.BloqueiaValidade: boolean;
var
  DataValidade: TDate;
begin
  Result := False;
  if Dados.qryTerminalDATA_SISTEMA.AsDateTime < Date then
  // data do sistema errada
  begin
    Result := true;
    Dados.qryEmpresa.Edit;
    Dados.qryEmpresaNSERIE.Value := '...';
    Dados.qryEmpresaDATA_VALIDADE.Value := Dados.Crypt('C', '01/01/1900');
    Dados.qryEmpresa.Post;
    Dados.Conexao.Commit;
  end;
  if Dados.Crypt('D', Dados.qryEmpresaCSENHA.AsString) = 'S' then
  // sistema bloqueado
  begin
    Result := true;
    Dados.qryEmpresa.Edit;
    Dados.qryEmpresaNSERIE.Value := '...';
    Dados.qryEmpresaDATA_VALIDADE.Value := Dados.Crypt('C', '01/01/1900');
    Dados.qryEmpresa.Post;
    Dados.Conexao.Commit;
    Dados.ApagaNumeroSerie;
  end;
  if (trim(qryEmpresaDATA_VALIDADE.AsString) = '') or
    (qryEmpresaDATA_VALIDADE.IsNull) then // data da validade limpa
  begin
    Result := true;
    Dados.qryEmpresa.Edit;
    Dados.qryEmpresaNSERIE.Value := '...';
    Dados.qryEmpresaDATA_VALIDADE.Value := Dados.Crypt('C', '01/01/1900');
    Dados.qryEmpresa.Post;
    Dados.Conexao.Commit;
    Dados.ApagaNumeroSerie;
  end;
  try
    DataValidade :=
      strtodate(Dados.Crypt('D', qryEmpresaDATA_VALIDADE.AsString));
  except
    Dados.qryEmpresa.Edit;
    Dados.qryEmpresaDATA_VALIDADE.Value := Dados.Crypt('C', '01/01/1900');
    Dados.qryEmpresa.Post;
    Dados.Conexao.Commit;
  end;
  if (DataValidade < Date) then // data de validade vencida
  begin
    Result := true;
    Dados.qryEmpresa.Edit;
    Dados.qryEmpresaNSERIE.Value := '...';
    Dados.qryEmpresaDATA_VALIDADE.Value := Dados.Crypt('C', '01/01/1900');
    Dados.qryEmpresa.Post;
    Dados.Conexao.Commit;
    ApagaNumeroSerie;
  end;
  if Result = true then
    FMsg := 'Sistema bloqueado, entre em contato com o adiministrador';
end;

function TDados.checanfce(Codigo: Integer): boolean;
begin
  try
    Result := False;
    Dados.qryConsulta.Close;
    Dados.qryConsulta.sql.Text :=
      'select NUMERO FROM NFCE_MASTER WHERE FK_VENDA=:ID AND SITUACAO<>''G'' AND SITUACAO<>''O''';
    Dados.qryConsulta.Params[0].Value := Codigo;
    Dados.qryConsulta.Open;
    if Dados.qryConsulta.Fields[0].AsFloat > 0 then
      Result := true;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TDados.CriaTerminal;
begin
  try
    FDataSistema := Date;
    if not Dados.qryEmpresa.IsEmpty then
    begin
      qryConfig.Close;
      qryConfig.Params[0].Value := qryEmpresaCODIGO.Value;
      qryConfig.Open;
      if qryConfig.IsEmpty then
      begin
        qryConfig.Insert;
        qryConfig.Post;
      end;
    end;
    Dados.qryTerminal.Close;
    Dados.qryTerminal.Params[0].Value := Dados.Getcomputer;
    Dados.qryTerminal.Open;
    if Dados.qryTerminal.locate('NOME', Dados.nometerminal, []) then
    begin
      Dados.qryTerminal.Edit;
      Dados.qryTerminalIP.Value := IdIPWatch1.LocalIP;
      if Dados.qryTerminal.FieldByName('RETAGUARDA').IsNull then
      begin
        Dados.qryTerminal.FieldByName('RETAGUARDA').AsString :=
          copy(ExtractFileName(Application.ExeName), 1,
          pos('.', ExtractFileName(Application.ExeName)) - 1);
      end;
      if Dados.qryTerminalDATA_SISTEMA.IsNull then
      begin
        Dados.qryTerminalDATA_SISTEMA.AsDateTime := FDataSistema;
        Dados.qryTerminal.Post;
      end
      else
      begin
        if FDataSistema > Dados.qryTerminalDATA_SISTEMA.AsDateTime then
          Dados.qryTerminalDATA_SISTEMA.Value := FDataSistema;
        Dados.qryTerminal.Post;
      end;
    end
    else
    begin
      Dados.qryTerminal.Insert;
      Dados.qryTerminalNOME.Value := Dados.nometerminal;
      Dados.qryTerminalIP.Value := IdIPWatch1.LocalIP;
      Dados.qryTerminalFLAG.Value := 'P';
      Dados.qryTerminalIMPRIME.Value := 'S';
      Dados.qryTerminalUSAGAVETA.Value := 'N';
      Dados.qryTerminalSERIE.Value := '1';
      Dados.qryTerminalNVIAS.Value := 1;
      Dados.qryTerminalVERSAO.Value := 1;
      Dados.qryTerminalCOLUNAS.Value := 42;
      Dados.qryTerminalL1.Value := 32;
      Dados.qryTerminalL2.Value := 32;
      Dados.qryTerminalL3.Value := 1;
      Dados.qryTerminalL4.Value := 1;
      Dados.qryTerminalNUMERACAO_INICIAL.Value := 1;
      Dados.qryTerminalTIPOIMPRESSORA.Value := '1';
      Dados.qryTerminalMODELO.Value := 'ELGIN';
      Dados.qryTerminalPORTA.Value := 'COM2';
      Dados.qryTerminalVELOCIDADE.AsString := '115200';
      Dados.qryTerminalEH_CAIXA.Value := 'S';
      Dados.qryTerminalDATA_VERSAO.AsDateTime := now;
      Dados.qryTerminalDATA_SISTEMA.AsDateTime := FDataSistema;
      Dados.qryTerminal.Post;
    end;
    Dados.Conexao.Commit;
    Dados.qryTerminal.Refresh;
  except
    // faz nada
  end;
end;

procedure TDados.ChamaContato(Msg: String);
var
  FContato: string;
begin
  FContato := 'Fale Conosco:' + sLineBreak + 'Site:' +
    Dados.qryParametroSITE.AsString + sLineBreak + 'Email:' +
    Dados.qryParametroEMAIL_SUPORTE.AsString + sLineBreak + 'Fone:' +
    Dados.qryParametroFONE1.Value +
    trim(' ' + Dados.qryParametroFONE2.AsString);
  ShowMessage(Msg + sLineBreak + FContato);
end;

function TDados.BuscaDescricaoProduto(Codigo: Integer): string;
begin
  Result := '';
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text :=
    'select DESCRICAO from produto where codigo=:codigo';
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Open;
  if not Dados.qryConsulta.IsEmpty then
    Result := Dados.qryConsulta.FieldByName('DESCRICAO').AsString;
end;

function TDados.BuscaDescricaoProdutoBarra(Codigo: String): string;
begin
  Result := '';
  Dados.qryConsulta.Close;
  qryConsulta.sql.Clear;
  Dados.qryConsulta.sql.Text :=
    'select DESCRICAO from produto where codbarra=:codigo';
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Open;
  if not Dados.qryConsulta.IsEmpty then
    Result := Dados.qryConsulta.FieldByName('DESCRICAO').AsString;
end;

function TDados.BuscaIcms(tipo, UFOrigem, UFDestino: String): real;
begin
  if UFDestino = 'PI' then
    UFDestino := 'P_I';
  if UFDestino = 'TO' then
    UFDestino := 'T_O';
  Result := 0;
  qryBuscaIcms.Close;
  qryBuscaIcms.Params[0].Value := UFOrigem;
  qryBuscaIcms.Open;
  Result := qryBuscaIcms.FieldByName(UFDestino).AsFloat;
end;

function IsFireBirdRunning: boolean;
const
  PROCESS_TERMINATE = $0001;
var
  Co: BOOL;
  FS: THandle;
  FP: TProcessEntry32;
  S: string;
begin
  FS := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FP.dwSize := Sizeof(FP);
  Co := Process32First(FS, FP);
  while Integer(Co) <> 0 do
  begin
    S := S + FP.szExeFile + #13;
    Co := Process32Next(FS, FP);
  end;
  CloseHandle(FS);
  if pos('fbserver', S) > 0 then
    Result := true
  else
    Result := False;
end;

function TDados.ExecuteAndWaitEx(const CommandLine: string): DWORD;
var
  tSI: TStartupInfo;
  tPI: TProcessInformation;
  ExitCode: DWORD;
begin
  FillChar(tSI, Sizeof(TStartupInfo), 0);
  tSI.cb := Sizeof(TStartupInfo);
  if CreateProcess(nil, pchar(CommandLine), nil, nil, False, 0, nil, nil,
    tSI, tPI) then
  begin
    try
      GetExitCodeProcess(tPI.hProcess, ExitCode);
      while ExitCode = STILL_ACTIVE do
      begin
        Application.ProcessMessages;
        // Check here if the ´wait´ is cancelled and call exit;
        GetExitCodeProcess(tPI.hProcess, ExitCode);
      end;
    finally
      CloseHandle(tPI.hProcess);
      CloseHandle(tPI.hThread);
    end;
  end
  else
    RaiseLastWin32Error;
end;

function TDados.DiasAtraso(DataVencimento, DataAtual: TDate; Carencia: Integer)
  : Extended;
Var
  Dias: Integer;
  DataCarencia: TDate;
begin
  Result := 0;
  DataCarencia := DataVencimento + Carencia;
  if DataAtual > DataCarencia then
    Result := DaysBetween(DataAtual, DataVencimento);
end;

function TDados.CalculaJuros: Extended;
begin
  Result := DiasAtraso(qryCRDTVENCIMENTO.Value, Date,
    Dados.qryEmpresaCARENCIA_JUROS.Value) * Dados.qryEmpresaJUROS_DIA.AsFloat;
end;

procedure TDados.Conectado;
var
  estado: DWORD;
begin
  if not InternetGetConnectedState(@estado, 0) then
    IsGlobalOffline := False
  else
  begin
    if (estado and INTERNET_CONNECTION_LAN <> 0) OR
      (estado and INTERNET_CONNECTION_MODEM <> 0) or
      (estado and INTERNET_CONNECTION_PROXY <> 0) then
      IsGlobalOffline := true;
  end;
end;

procedure TDados.ConfiguraEstilo(Estilo: String);
begin
  { try
    if Estilo = 'Amethyst Kamri' then
    TStyleManager.TrySetStyle('Amethyst Kamri')
    else
    if Estilo = 'Aqua Light Slate' then
    TStyleManager.TrySetStyle('Aqua Light Slate')
    else
    if Estilo = 'Luna' then
    TStyleManager.TrySetStyle('Luna')
    else
    if Estilo = 'Cyan Dusk' then
    TStyleManager.TrySetStyle('Cyan Dusk')
    else
    if Estilo = 'Emerald Light Slate' then
    TStyleManager.TrySetStyle('Emerald Light Slate')
    else
    if Estilo = 'Iceberg Classico' then
    TStyleManager.TrySetStyle('Iceberg Classico')
    else
    if Estilo = 'Lavender Classico' then
    TStyleManager.TrySetStyle('Lavender Classico')
    else
    if Estilo = 'Light' then
    TStyleManager.TrySetStyle('Light')
    else
    if Estilo = 'Luna' then
    TStyleManager.TrySetStyle('Luna')
    else
    if Estilo = 'Sapphire Kamri' then
    TStyleManager.TrySetStyle('Sapphire Kamri')
    else
    if Estilo = 'Silver' then
    TStyleManager.TrySetStyle('Silver')
    else
    if Estilo = 'Sky' then
    TStyleManager.TrySetStyle('Sky')
    else
    if Estilo = 'Slate Classico' then
    TStyleManager.TrySetStyle('Slate Classico')
    else
    if Estilo = 'Smokey Quartz Kamri' then
    TStyleManager.TrySetStyle('Smokey Quartz Kamri')
    else
    TStyleManager.TrySetStyle('Windows');
    except
    TStyleManager.TrySetStyle('Windows');
    end; }
end;

function TDados.GetBuildInfo(Prog: string): string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: word;
begin
  try
    VerInfoSize := GetFileVersionInfoSize(pchar(Prog), Dummy);
    GetMem(VerInfo, VerInfoSize);
    GetFileVersionInfo(pchar(Prog), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
    with (VerValue^) do
    begin
      V1 := dwFileVersionMS shr 16;
      V2 := dwFileVersionMS and $FFFF;
      V3 := dwFileVersionLS shr 16;
      V4 := dwFileVersionLS and $FFFF;
    end;
    FreeMem(VerInfo, VerInfoSize);
    Result := Format('%d.%d.%d.%d', [V1, V2, V3, V4]);
  except
    Result := '1.0.0';
  end;
end;

procedure TDados.CadastraObjeto(Formulario, objeto, Valor: String);
begin
  if not qryTradutor.locate('objeto', objeto) then
  begin
    if trim(Valor) <> '' then
    begin
      qryTradutor.Insert;
      qryTradutorCODIGO.Value := Dados.Numerador('TRADUTOR', 'CODIGO',
        'N', '', '');
      qryTradutorCODIGO_IDIOMA.Value := Dados.qryIdiomasCODIGO.Value;
      qryTradutorTELA.Value := Formulario;
      qryTradutorOBJETO.Value := objeto;
      qryTradutorTEXTO_PT_BR.Value := Valor;
      qryTradutor.Post;
      Conexao.Commit;
    end;
  end;
end;

procedure TDados.SetComponentes;
var
  i, j: Integer;
begin
  { if Dados.qryEmpresaMULTI_IDIOMA.Value = 'S' then
    begin
    qryTradutor.Close;
    qryTradutor.Params[0].Value := vForm.Name;
    qryTradutor.Params[1].Value := qryIdiomasCODIGO.Value;
    qryTradutor.Open;
    for i := 0 to vForm.ComponentCount - 1 do
    begin
    if vForm.Components[i] is TCustomEdit then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TCustomEdit).Text);
    if vForm.Components[i] is TCustomLabel then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TCustomLabel).Caption);
    if vForm.Components[i] is TSpeedButton then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TSpeedButton).Caption);
    if vForm.Components[i] is TButton then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TButton).Caption);
    if vForm.Components[i] is TBitBtn then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TBitBtn).Caption);
    if vForm.Components[i] is TTabSheet then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TTabSheet).Caption);
    if vForm.Components[i] is TMenuItem then
    CadastraObjeto(vForm.Name, vForm.Components[i].Name,
    (vForm.Components[i] as TMenuItem).Caption);
    if vForm.Components[i] is TDBGrid then
    begin
    for j := 0 to (vForm.Components[i] as TDBGrid).Columns.Count - 1 do
    begin
    CadastraObjeto(vForm.Name, (vForm.Components[i] as TDBGrid).Name + '.'
    + (vForm.Components[i] as TDBGrid).Columns[j].FieldName,
    (vForm.Components[i] as TDBGrid).Columns[j].Title.Caption);
    end;
    end;
    end;
    end; }
end;

procedure TDados.GetComponentes;
// var
// i, j: Integer;
// vNomeComp: String;
begin
  { aMenu := '';
    if Dados.qryEmpresaMULTI_IDIOMA.Value = 'S' then
    begin
    qryTradutor.Close;
    qryTradutor.Params[0].Value := vForm.Name;
    qryTradutor.Params[1].Value := qryIdiomasCODIGO.Value;
    qryTradutor.Open;
    qryTradutor.First;
    while not qryTradutor.Eof do
    begin
    if trim(qryTradutorTEXTO_TRADUZIDO.Value) <> '' then
    begin
    for i := 0 to vForm.ComponentCount - 1 do
    begin
    if vForm.Components[i] is TCustomEdit then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TCustomEdit).Text :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TCustomLabel then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TCustomLabel).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TSpeedButton then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TSpeedButton).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TButton then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TButton).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TBitBtn then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TBitBtn).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TTabSheet then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TTabSheet).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TMenuItem then
    begin
    if vForm.Components[i].Name = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TMenuItem).Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value;
    end;
    if vForm.Components[i] is TDBGrid then
    begin
    for j := 0 to (vForm.Components[i] as TDBGrid).Columns.Count - 1 do
    begin
    vNomeComp := (vForm.Components[i] as TDBGrid).Name + '.' +
    (vForm.Components[i] as TDBGrid).Columns[j].FieldName;
    if vNomeComp = qryTradutorOBJETO.Value then
    (vForm.Components[i] as TDBGrid).Columns[j].Title.Caption :=
    qryTradutorTEXTO_TRADUZIDO.Value
    end;
    end;
    end;
    end;
    qryTradutor.Next;
    end;
    end; }
end;

procedure TDados.AtualizaTerminal;
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'UPDATE VENDAS_TERMINAIS SET EMPRESA_ATIVA=:EMPRESA WHERE NOME=:NOME';
  Dados.qryExecute.Params[0].Value := Dados.idEmpresa;
  Dados.qryExecute.Params[1].Value := Getcomputer;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.GravarTraducao(Codigo, idioma: Integer;
  tela, objeto, texto_pt_br, texto_traduzido: string);
begin
  //
end;

function TDados.RetornoNumeroBoleto: Integer;
var
  vNumero, vNossoNumero: Integer;
begin
  Result := 0;
  qryNumeroBoleto.Close;
  qryNumeroBoleto.sql.Text :=
    'select coalesce(max(nboleto),0) as numero from creceber where tipo=''B'' ';
  qryNumeroBoleto.Open;
  vNossoNumero := qryNumeroBoleto.Fields[0].AsInteger;
  if vNossoNumero = 0 then
  begin
    qryNumeroBoleto.Close;
    qryNumeroBoleto.sql.Text :=
      'select coalesce(numero_boleto,0) from cbr_config';
    qryNumeroBoleto.Open;
    if qryNumeroBoleto.Fields[0].AsInteger > 0 then
      vNumero := qryNumeroBoleto.Fields[0].AsInteger
    else
      vNumero := 1;
  end
  else
    vNumero := vNossoNumero + 1;
  Result := vNumero;
end;

procedure TDados.UpdateTipoBoleto(Codigo: Integer);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'select nboleto from creceber where codigo=:codigo';
  Dados.qryExecute.Params[0].AsInteger := Codigo;
  Dados.qryExecute.Open;
  if Dados.qryExecute.FieldByName('nboleto').IsNull then
  begin
    Dados.qryUpdate.Close;
    Dados.qryUpdate.sql.Text :=
      'update creceber set TIPO=''B'', NBOLETO=:NBOLETO where codigo=:codigo';
    Dados.qryUpdate.ParamByName('codigo').Value := Codigo;
    Dados.qryUpdate.ParamByName('nboleto').Value := Dados.RetornoNumeroBoleto;
    Dados.qryUpdate.execsql;
    Dados.Conexao.Commit;
  end;
end;

procedure TDados.AjustaCamposNovos(tela: string);
begin
  // TThread.CreateAnonymousThread(
  // procedure
  // begin
  try
    if tela = 'compra' then
    begin
      // compras master
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select co.id as codigo, pes.razao from compra co');
      Dados.qryConsulta.sql.Add
        ('left join pessoa pes on pes.codigo = Co.fornecedor');
      Dados.qryConsulta.sql.Add('where co.nome is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update compra set nome=:nome where id=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('razao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsString;
        Dados.qryUpdate.Prepare;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
      // compras itens
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select ci.fk_produto as codigo, pro.descricao from compra_itens ci');
      Dados.qryConsulta.sql.Add
        ('left join produto pro on pro.codigo = Ci.FK_PRODUTO');
      Dados.qryConsulta.sql.Add('where ci.descricao is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update COMPRA_ITENS set descricao=:nome where fk_produto=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('descricao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
    end;
    if tela = 'orcamento' then
    begin
      // orcamento master
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select co.codigo, pes.razao from ORCAMENTO co');
      Dados.qryConsulta.sql.Add
        ('left join pessoa pes on pes.codigo = co.fk_cliente');
      Dados.qryConsulta.sql.Add('where co.cliente is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update orcamento set cliente=:nome where codigo=:codigo';
        Dados.qryUpdate.Params[0].AsString := Dados.qryConsulta.FieldByName
          ('razao').AsString;
        Dados.qryUpdate.Params[1].AsInteger := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
      // orcamento itens
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select oi.fk_produto as codigo, pro.descricao from orcamento_item oi');
      Dados.qryConsulta.sql.Add
        ('left join produto pro on pro.codigo = oi.FK_PRODUTO');
      Dados.qryConsulta.sql.Add('where oi.descricao is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update orcamento_item set descricao=:nome where fk_produto=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('descricao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
    end;
    if tela = 'os' then
    begin
      // os master
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select os.codigo, pes.razao from OS_MASTER os');
      Dados.qryConsulta.sql.Add
        ('left join pessoa pes on pes.codigo = os.fk_cliente');
      Dados.qryConsulta.sql.Add('where os.nome is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update OS_MASTER set nome=:nome where codigo=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('razao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
      // os itens
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select od.fk_produto as codigo, pro.descricao from OS_DETALHE od');
      Dados.qryConsulta.sql.Add
        ('left join produto pro on pro.codigo = od.FK_PRODUTO');
      Dados.qryConsulta.sql.Add('where od.discriminacao is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update OS_DETALHE set discriminacao=:nome where fk_produto=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('descricao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
    end;
    if tela = 'nfe' then
    begin
      // os master
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select NM.codigo, pes.razao from NFE_MASTER NM');
      Dados.qryConsulta.sql.Add
        ('left join pessoa pes on pes.codigo = NM.id_cliente');
      Dados.qryConsulta.sql.Add('where NM.nome is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update NFE_MASTER set nome=:nome where codigo=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('razao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
      // os itens
      Dados.qryConsulta.Close;
      Dados.qryConsulta.sql.Clear;
      Dados.qryConsulta.sql.Add
        ('select nd.ID_produto as codigo, pro.descricao from NFE_DETALHE nd');
      Dados.qryConsulta.sql.Add
        ('left join produto pro on pro.codigo = nd.ID_PRODUTO');
      Dados.qryConsulta.sql.Add('where nd.descricao is null ');
      Dados.qryConsulta.Open;
      Dados.qryConsulta.First;
      while not Dados.qryConsulta.Eof do
      begin
        Dados.qryUpdate.Close;
        Dados.qryUpdate.sql.Text :=
          'update NFE_DETALHE set descricao=:nome where ID_produto=:codigo';
        Dados.qryUpdate.Params[0].Value := Dados.qryConsulta.FieldByName
          ('descricao').AsString;
        Dados.qryUpdate.Params[1].Value := Dados.qryConsulta.FieldByName
          ('codigo').AsInteger;
        Dados.qryUpdate.execsql;
        Dados.Conexao.Commit;
        Dados.qryConsulta.Next;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
  // end).Start;
end;

procedure TDados.BloqueiaCliente;
begin

end;

procedure TDados.InsereMensagemZap(anexo: string; fone: string;
  Mensagem: String; MensagemPadrao: String; Pessoa: String; Empresa: String;
  Origem: String);
var
  DDD, Celular: string;
begin
  DDD := copy(TiraPontos(fone), 1, 2);
  Celular := '55' + DDD + trim(copy(TiraPontos(fone), 3, 10)) + '@c.us';
  // Celular := '55' + DDD + trim(copy(TiraPontos(fone), 4, 10)) + '@c.us';
  if not Dados.qryMensagemZap.Active then
    Dados.qryMensagemZap.Open;
  Dados.qryMensagemZap.Insert;
  Dados.qryMensagemZapCODIGO.Value := Dados.Numerador('MENSAGEM_ZAP', 'CODIGO',
    'N', '', '');
  Dados.qryMensagemZapDATA.AsDateTime := now;
  Dados.qryMensagemZapHORA.AsDateTime := now;
  Dados.qryMensagemZapANEXO.Value := anexo;
  Dados.qryMensagemZapMENSAGEM.Value := Mensagem;
  Dados.qryMensagemZapSTATUS.Value := 'PENDENTES';
  Dados.qryMensagemZapFONE.Value := Celular;
  Dados.qryMensagemZapMENSAGEM_PADRAO.Value := MensagemPadrao;
  Dados.qryMensagemZapNOME.Value := Pessoa;
  Dados.qryMensagemZapEMPRESA.Value := Empresa;
  Dados.qryMensagemZapORIGEM.Value := Origem;
  Dados.qryMensagemZap.Post;
  Dados.Conexao.Commit;
end;

procedure TDados.DataModuleCreate(Sender: TObject);
var
  iArq: TIniFile;
  nTentativas: word;
begin
  try
    nTentativas := 1;
    { TODO : Informações da conexão com banco de dados. }
    iArq := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Banco.ini');
    Conexao.Params.Values['User_Name'] := iArq.ReadString('BD', 'USER',
      'SYSDBA');
    Conexao.Params.Values['Password'] := iArq.ReadString('BD', 'PASS',
      'masterkey');
    Conexao.Params.Values['Port'] := iArq.ReadString('BD', 'PORT', '3050');
    Conexao.Params.Values['DriverID'] := 'FB';
    Conexao.Params.Values['Server'] := iArq.ReadString('BD', 'IP', '');
    // pega essa informação na linha do Banco.ini
    Conexao.Params.Values['Database'] := iArq.ReadString('BD', 'Path', '');
    // pega essa informação na linha do Banco.ini
    FBDriver.VendorLib := ExtractFilePath(Application.ExeName) + 'fbclient.dll';
    {
      while nTentativas <= 12 do
      begin
      if not IsFireBirdRunning then
      begin
      nTentativas := nTentativas + 1;
      if frmConexaoBD = nil then
      begin
      frmConexaoBD := TfrmConexaoBD.Create(Application);
      frmConexaoBD.Show;
      end;
      Application.ProcessMessages;
      sleep(10000);
      end
      else
      nTentativas := 13;
      end; }
    if nTentativas = 13 then
    begin
      if frmConexaoBD <> nil then
        frmConexaoBD.Close;
    end;
    try
      Conexao.Connected := true;
    Except
      ShowMessage('Não foi possivel conectar na base de dados!' + sLineBreak +
        'Verifique e pasta C:\Sistema\Dados\DADOS.FDB' + sLineBreak +
        ' Se não encontrar esse arquivo restaure um backup. ' + sLineBreak +
        'Ou contate o suporte do sistema !');
      Dados.vFechaPrograma := true;
      Application.Terminate;
    end;
  Finally
    iArq.Free;
  end;
  try
    Dados.nometerminal := Getcomputer;
    Dados.MAC := GetMacAddress;
    Dados.qryEmpresa.Close;
    Dados.qryEmpresa.Open;

    PassarServerPadrao;
    Dados.qryParametro.Close;
    Dados.qryParametro.Open;
    VerificaVersao := true;
    FEmail.GetEmail;
  except
    // faz nada
  end;
end;

Procedure TDados.AbreTerminal;
begin
  Dados.qryTerminal.locate('NOME', Dados.Getcomputer, []);
end;

procedure TDados.LimpaTEF(NSU: String);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'UPDATE VENDAS_FPG SET NSU=null, INDICE=null, REDE=null, REDECNPJ=null, FEZ_TEF=''N'' WHERE NSU=:ID';
  Dados.qryExecute.ParamByName('ID').AsString := NSU;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

function TDados.Numerador(Tabela, Campo, filtra, where, Valor: String): Integer;
begin
  Result := 0;
  if filtra = 'N' then
  begin
    qryNumerador.Close;
    qryNumerador.sql.Text := 'SELECT MAX(' + Campo + ')MAIOR FROM ' + Tabela;
    qryNumerador.Open;
  end;
  if filtra = 'S' then
  begin
    qryNumerador.Close;
    qryNumerador.sql.Text := 'SELECT MAX(' + Campo + ')MAIOR FROM ' + Tabela +
      ' WHERE ' + where + '=' + Valor;
    qryNumerador.Open;
  end;
  Result := qryNumerador.Fields[0].AsInteger + 1;
end;

procedure TDados.EstornaFinanceiro(Codigo: Integer);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'SELECT REMESSA_ARQUIVO, ID_CBR_REMESSA_UUID FROM CRECEBER WHERE FK_VENDA=:VD';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.Open;
  Dados.Conexao.Commit;
  DeletaRemessa(Dados.qryExecute.FieldByName('REMESSA_ARQUIVO').AsString,
    Dados.qryExecute.FieldByName('ID_CBR_REMESSA_UUID').AsString);
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text := 'DELETE FROM CAIXA WHERE FKVENDA=:VD';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text := 'DELETE FROM CRECEBER WHERE FK_VENDA=:VD';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text := 'DELETE FROM PESSOA_CONTA WHERE FKVENDA=:VD';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text := 'DELETE FROM CONTAS_MOVIMENTO WHERE FKVENDA=:VD';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.EstornaEstoque(Codigo: Integer; QtdAtual, QtdFiscal: real;
  op: word);
begin
  if op = 0 then
  begin
    // adiciona estoque
    Dados.qryExecute.Close;
    Dados.qryExecute.sql.Text :=
      'update produto set qtd_atual = qtd_atual + :qtd, e_medio = e_medio + :qtd1 where codigo=:cod';
    Dados.qryExecute.Params[0].Value := QtdAtual;
    Dados.qryExecute.Params[1].Value := QtdFiscal;
    Dados.qryExecute.Params[2].Value := Codigo;
    Dados.qryExecute.execsql;
    Dados.Conexao.Commit;
  end;
end;

procedure TDados.qryCaixaAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
  Dados.qryTransf.Close;
  Dados.qryTransf.Open;
  if qryCaixaTRANSFERENCIA.Value = 1 then
  begin
    Dados.qryTransf.Insert;
    Dados.qryTransfCODIGO.Value := Dados.Numerador('CAIXA', 'CODIGO',
      'N', '', '');
    Dados.qryTransfEMISSAO.Value := Date;
    Dados.qryTransfDOC.Value := 'TRF.' + Dados.qryCaixaCODIGO.AsString;
    Dados.qryTransfFKPLANO.Value := 0;
    Dados.qryTransfFKCONTA.Value := Dados.qryCaixaFK_CONTA1.Value;
    Dados.qryTransfHISTORICO.Value := 'TRANSFERENCIA P/ CAIXA Nº' +
      Dados.qryCaixaFKCONTA.AsString;
    Dados.qryTransfENTRADA.Value := qryCaixaSAIDA.AsFloat;;
    Dados.qryTransfSAIDA.Value := qryCaixaENTRADA.AsFloat;
    Dados.qryTransfSALDO.Value := 0;
    Dados.qryTransfFK_PAI.Value := Dados.qryCaixaFKCONTA.Value;
    Dados.qryTransfBLOQUEADO.Value := 'S';
    Dados.qryTransfFKVENDA.Value := Dados.qryCaixaFKVENDA.Value;
    if Dados.qryTransfSAIDA.Value > 0 then
      Dados.qryTransfFKPLANO.Value :=
        Dados.qryEmpresaID_PLANO_TRANSFERENCIA_D.Value;
    if Dados.qryTransfENTRADA.Value > 0 then
      Dados.qryTransfFKPLANO.Value :=
        Dados.qryEmpresaID_PLANO_TRANSFERENCIA_C.Value;
    Dados.qryTransfTRANSFERENCIA.Value := 1;
    Dados.qryTransf.Post;
  end;
  Conexao.Commit;
end;

procedure TDados.qryCaixaBeforePost(DataSet: TDataSet);
begin
  if Dados.qryCaixa.State in [dsInsert] then
    Dados.qryCaixaCODIGO.Value := Dados.Numerador('CAIXA', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryCaixaNewRecord(DataSet: TDataSet);
begin
  qryCaixaDT_CADASTRO.Value := Date;
end;

procedure TDados.qryCCBeforePost(DataSet: TDataSet);
begin
  if Dados.qryCC.State = dsInsert then
    Dados.qryCCCODIGO.Value := Dados.Numerador('PESSOA_CONTA', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryChaveAfterPost(DataSet: TDataSet);
begin
  qryEmpresa.Edit;
  qryEmpresaDATA_CADASTRO.Value := Crypt('C', datetostr(Date));
  qryEmpresaCHECA.Value := Crypt('C', 'PRODUCAO');
  qryEmpresaNSERIE.Value := '...';
  qryEmpresa.Post;
  Dados.Conexao.Commit;
end;

procedure TDados.qryConfigBeforeDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryConfigBeforePost(DataSet: TDataSet);
begin
  qryConfigEMAILSENHA.Value := Dados.Crypt('C', qryConfigEMAILSENHA.Value);
end;

procedure TDados.qryConfigCODIGO_ATIVACAOValidate(Sender: TField);
begin
  if Length(trim(qryConfigCODIGO_ATIVACAO.AsString)) < 8 then
    raise Exception.Create
      ('Tamanho do código de ativação não pode ter menos de oito caracteres!');
end;

procedure TDados.qryConfigNewRecord(DataSet: TDataSet);
begin
  Dados.qryConfigEMPRESA.Value := Dados.qryEmpresaCODIGO.Value;
  Dados.qryConfigAMBIENTE.Value := 1;
  Dados.qryConfigTIPO_EMISSAO.Value := 4;
  Dados.qryConfigATUALIZARXML.Value := 'N';
  Dados.qryConfigVISUALIZAERROSCHEMA.Value := 'S';
  Dados.qryConfigFORMATOALERTA.Value :=
    'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.';
  Dados.qryConfigFORMAEMISSAO.Value := 0;
  Dados.qryConfigMODELODF.Value := 1;
  Dados.qryConfigVERSAODF.Value := 3;
  Dados.qryConfigVERSAOQRCODE.Value := 2;
  Dados.qryConfigRETIRARACENTOS.Value := 'N';
  Dados.qryConfigSALVARGERAL.Value := 'N';
  Dados.qryConfigUF.Value := Dados.qryEmpresaUF.Value;
  Dados.qryConfigAMBIENTE.Value := 1;
  Dados.qryConfigVISUALIZAR.Value := 'N';
  Dados.qryConfigSALVARSOAP.Value := 'N';
  Dados.qryConfigAJUSTARAUTO.Value := 'S';
  Dados.qryConfigAGUARDAR.Value := 5;
  Dados.qryConfigINTERVALO.Value := 10;
  Dados.qryConfigTENTATIVAS.Value := 5;
  Dados.qryConfigSALVARARQUIVO.Value := 'N';
  Dados.qryConfigPASTAMENSAL.Value := 'S';
  Dados.qryConfigLITERAL.Value := 'N';
  Dados.qryConfigEMISSAOPATHNFE.Value := 'N';
  Dados.qryConfigSALVARPATHEVENTO.Value := 'N';
  Dados.qryConfigSEPARARPORCNPJ.Value := 'S';
  Dados.qryConfigSEPARARPORMODELO.Value := 'N';
  Dados.qryConfigEMAILSSL.Value := 'N';
  Dados.qryConfigFAZENTREGA.Value := 'N';
  Dados.qryConfigPATHSALVAR.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\xml';
  Dados.qryConfigPATHSCHEMAS.Value := ExtractFilePath(Application.ExeName) +
    'Schemas\NFe';
  Dados.qryConfigPATHNFE.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\enviadas';
  Dados.qryConfigPATHCAN.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\Cancelamento';
  Dados.qryConfigPATHINUTI.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\Inutilizacao';
  Dados.qryConfigPATHEVENTO.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\Evento';
  Dados.qryConfigPATHPDF.Value := ExtractFilePath(Application.ExeName) +
    'NFCe\PDF';
  Dados.qryConfigPATHSCHEMAS_NFE.Value := ExtractFilePath(Application.ExeName) +
    'Schemas\NFe';
  Dados.qryConfigPATHCCE_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\CCe';
  Dados.qryConfigPATHCAN_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\Cancelamento';
  Dados.qryConfigPATHINUTI_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\Inutilizacao';
  Dados.qryConfigPATHEVENTO_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\Evento';
  Dados.qryConfigPATHPDF_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\PDF';
  Dados.qryConfigPATHSALVARNFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\Xml';
  Dados.qryConfigPATHENVIADA_NFE.Value := ExtractFilePath(Application.ExeName) +
    'NFE\enviadas';
  Dados.qryConfigSERIE.Value := '1';
  Dados.qryConfigPESQUISA.Value := 'DESCRIÇÃO';
  Dados.qryConfigCLIENTE_PADRAO.Value := 1;
  Dados.qryConfigVENDEDOR_PADRAO.Value := 1;
  Dados.qryConfigCRYPTLIB.Value := '3';
  Dados.qryConfigHTTPLIB.Value := '2';
  Dados.qryConfigXMLSIGN.Value := '4';
  Dados.qryConfigSSL_TIPO.Value := 5;
  Dados.qryConfigVERSAONFE.Value := 3;
  Dados.qryConfigSERIE_NFE.Value := 1;
  Dados.qryConfigATUALIZARXML.Value := 'S';
  Dados.qryConfigVISUALIZAERROSCHEMA.Value := 'N';
  Dados.qryConfigRETIRARACENTOS.Value := 'S';
end;

procedure TDados.qryConfiguracaoAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryContasCalcFields(DataSet: TDataSet);
begin
  if qryContasSITUACAO.Value = 'A' then
    qryContasVIRTUAL_SITUACAO.Value := 'ABERTO';
  if qryContasSITUACAO.Value = 'F' then
    qryContasVIRTUAL_SITUACAO.Value := 'FECHADO';
end;

procedure TDados.qryCPAfterOpen(DataSet: TDataSet);
begin
  qryCPPagamento.Close;
  qryCPPagamento.Open;
end;

procedure TDados.qryCPAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryCRAfterOpen(DataSet: TDataSet);
begin
  qryCRRecebimento.Close;
  qryCRRecebimento.Open;
end;

procedure TDados.qryCRAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryEmpresaBeforePost(DataSet: TDataSet);
begin
  qryEmpresaID_UF.Value := qryEmpresaVIRTUAL_ID_UF.Value;
end;

procedure TDados.qryEmpresaID_CIDADEChange(Sender: TField);
begin
  if qryEmpresa.State in dsEditmodes then
    qryEmpresaUF.Value := qryEmpresaVIRTUAL_UF.Value;
end;

procedure TDados.qryEmpresaNewRecord(DataSet: TDataSet);
begin
  qryEmpresaID_UF.Value := 15;
  qryEmpresaID_CIDADE.Value := 1505502;
  qryEmpresaNSERIE.Value := '';
  qryEmpresaCSENHA.Value := '';
  qryEmpresaDATA_CADASTRO.AsString := Dados.Crypt('C', datetostr(Date));
  { TODO : Altera a quantidade de dias do Demo, padrão 7. }
  qryEmpresaDATA_VALIDADE.AsString := Dados.Crypt('C', datetostr(Date + 7));

  qryEmpresaCHECA.AsString := Dados.Crypt('C', 'DEMONSTRACAO');
  qryEmpresaFUNDACAO.Value := now;
  qryEmpresaUSU_CAD.Value := 0;
  qryEmpresaUSU_ATU.Value := 0;
  qryEmpresaID_PLANO_TRANSFERENCIA_C.Value := 3;
  qryEmpresaID_PLANO_TRANSFERENCIA_D.Value := 4;
  qryEmpresaID_CAIXA_GERAL.Value := 1;
  qryEmpresaBLOQUEAR_ESTOQUE_NEGATIVO.Value := 'S';
  qryEmpresaRECIBO_VIAS.Value := 'S';
  qryEmpresaCRT.Value := 1;
  qryEmpresaID_PLANO_VENDA.Value := 2;
  qryEmpresaOBSFISCO.Value :=
    'I - "DOCUMENTO EMITIDO POR ME OU EPP OPTANTE PELO SIMPLES NACIONAL"; e II - "NÃO GERA DIREITO A CRÉDITO FISCAL DE ISS E DE IPI".';
  qryEmpresaCFOP.Value := '5102';
  qryEmpresaCSOSN.Value := '102';
  qryEmpresaCST_ICMS.Value := '041';
  qryEmpresaCST_ENTRADA.Value := '07';
  qryEmpresaCST_SAIDA.Value := '07';
  qryEmpresaCST_IPI.Value := '53';
  qryEmpresaALIQ_PIS.Value := 0;
  qryEmpresaALIQ_COF.Value := 0;
  qryEmpresaALIQ_IPI.Value := 0;
  qryEmpresaALIQ_ICMS.Value := 0;
  qryEmpresaNSERIE.Value := Crypt('C', 'DEMONSTRACAO');
  qryEmpresaNTERM.Value := Crypt('C', '3');
  qryEmpresaIMP_F5.Value := 'S';
  qryEmpresaIMP_F6.Value := 'S';
  qryEmpresaMOSTRA_RESUMO_CAIXA.Value := 'S';
  qryEmpresaLIMITE_DIARIO.Value := 1;
  qryEmpresaPRAZO_MAXIMO.Value := 1;
  qryEmpresaUSA_PDV.Value := 'S';
  qryEmpresaEXIBE_RESUMO_CAIXA.Value := 'S';
  qryEmpresaRECOLHE_FCP.Value := 'N';
  qryEmpresaRECIBO_VIAS.Value := '1';
  qryEmpresaOBS_CARNE.Value := 'OBRIGADO PELA PREFERÊNCIA!';
  qryEmpresaCAIXA_UNICO.Value := 'N';
  qryEmpresaCHECA_ESTOQUE_FISCAL.Value := 'S';
  qryEmpresaBLOQUEAR_PRECO.Value := 'N';
  qryEmpresaN_INICIAL_NFCE.Value := 1;
  qryEmpresaN_INICIAL_NFE.Value := 1;
  qryEmpresaID_PLANO_CONTA_DEVOLUCAO.Value := 9;
  qryEmpresaID_PLA_CONTA_FICHA_CLI.Value := 10;
  qryEmpresaID_PLANO_CONTA_RETIRADA.Value := 11;
  qryEmpresaID_PLANO_TAXA_CARTAO.Value := 8;
  qryEmpresaEMPRESA_PADRAO.Value := 1;
  qryEmpresaCAIXA_RAPIDO.Value := 'S';
  qryEmpresaENVIAR_EMAIL_NFE.Value := 'N';
  qryEmpresaLANCAR_CARTAO_CREDITO.Value := 'N';
  qryEmpresaTABELA_PRECO.Value := 'N';
  qryEmpresaEXCLUI_PDV.Value := 'N';
  qryEmpresaDESCONTO_PROD_PROMO.Value := 'N';
  qryEmpresaRECIBO_VIAS.Value := 'N';
  qryEmpresaTRANSPORTADORA.Value := 'N';
  qryEmpresaVENDA_SEMENTE.Value := 'N';
  qryEmpresaINFORMAR_GTIN.Value := 'N';
end;

procedure TDados.qryEtiquetaAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryEtiquetaNewRecord(DataSet: TDataSet);
begin
  Dados.qryEtiquetaCODIGO.Value := Dados.Numerador('ETIQUETAS', 'CODIGO',
    'N', '', '');
end;

procedure TDados.qryEtq_CamposAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryEtq_CamposBeforeInsert(DataSet: TDataSet);
begin
  if qryEtiqueta.State in dsEditmodes then
    qryEtiqueta.Post;
  if qryEtq_Campos.RecordCount = 5 then
    abort;
end;

procedure TDados.qryEtq_CamposBeforePost(DataSet: TDataSet);
begin
  if qryEtq_CamposDESCRICAO.Value = 'CÓDIGO' then
    qryEtq_CamposCAMPO.Value := 'FK_PRODUTO';
  if qryEtq_CamposDESCRICAO.Value = 'DESCRIÇÃO' then
    qryEtq_CamposCAMPO.Value := 'DESCRICAO';
  if qryEtq_CamposDESCRICAO.Value = 'CÓDIGO DE BARRA' then
    qryEtq_CamposCAMPO.Value := 'CODBARRA';
  if qryEtq_CamposDESCRICAO.Value = 'REFERÊNCIA' then
    qryEtq_CamposCAMPO.Value := 'REFERENCIA';
  if qryEtq_CamposDESCRICAO.Value = 'PREÇO' then
    qryEtq_CamposCAMPO.Value := 'PR_VENDA';
  if qryEtq_CamposDESCRICAO.Value = 'PREÇO ATACADO' then
    qryEtq_CamposCAMPO.Value := 'PRECO_ATACADO';
  if qryEtq_CamposDESCRICAO.Value = 'UNIDADE' then
    qryEtq_CamposCAMPO.Value := 'UNIDADE';
  if qryEtq_CamposDESCRICAO.Value = 'GRUPO' then
    qryEtq_CamposCAMPO.Value := 'GRUPO';
  if qryEtq_CamposDESCRICAO.Value = 'LOCALIZAÇÃO' then
    qryEtq_CamposCAMPO.Value := 'LOCALIZACAO';
end;

procedure TDados.qryEtq_CamposNewRecord(DataSet: TDataSet);
begin
  Dados.qryEtq_CamposCODIGO.Value := Dados.Numerador('ETIQUETA_CAMPOS',
    'CODIGO', 'N', '', '');
  Dados.qryEtq_CamposFK_ETIQUETAS.Value := Dados.qryEtiquetaCODIGO.Value;
end;

{ procedure TDados.AjustaPreco(produto, compra: Integer; preco, venda: Extended);
  var
  vPrecoAnterior: Extended;
  begin
  try
  qryAjustaPreco.Close;
  qryAjustaPreco.Params[0].Value := produto;
  qryAjustaPreco.Open;
  qryAjustaPreco.Edit;
  vPrecoAnterior := qryAjustaPrecoPR_VENDA.AsFloat;
  qryAjustaPrecoPR_CUSTO.Value := preco;
  qryAjustaPrecoPR_CUSTO2.AsFloat :=
  SimpleRoundTo(qryAjustaPrecoPR_CUSTO.AsFloat +
  (qryAjustaPrecoPR_CUSTO.AsFloat * qryAjustaPrecoPERC_CUSTO.AsFloat /
  100), -2);
  qryAjustaPrecoPR_VENDA.AsFloat := SimpleRoundTo(venda, -2);
  qryAjustaPrecoMARGEM.AsFloat :=
  ((qryAjustaPrecoPR_VENDA.AsFloat / qryAjustaPrecoPR_CUSTO2.AsFloat)
  - 1) * 100;
  qryAjustaPreco.FieldByName('ULT_COMPRA').Value := compra;
  qryAjustaPreco.Post;
  Dados.Conexao.Commit;
  if qryAjustaPrecoPR_VENDA.AsFloat <> vPrecoAnterior then
  AlteraDataPreco(qryAjustaPrecoCODIGO.AsInteger);
  except
  Dados.Conexao.RollbackRetaining;
  end;
  end; }
procedure TDados.AjustaPreco(produto, compra: Integer; preco, venda: Extended;
  bAjusteCompra: boolean);
var
  vMargem: Extended;
begin
  try
    qryAjustaPreco.Close;
    qryAjustaPreco.Params[0].Value := produto;
    qryAjustaPreco.Open;

    qryAjustaPreco.Edit;

    qryAjustaPrecoPR_CUSTO.AsFloat := preco;

    qryAjustaPrecoPR_CUSTO2.AsFloat :=
      SimpleRoundTo(qryAjustaPrecoPR_CUSTO.AsFloat +
      (qryAjustaPrecoPR_CUSTO.AsFloat * qryAjustaPrecoPERC_CUSTO.AsFloat /
      100), -2);

    if bAjusteCompra then
    begin
      qryAjustaPrecoPR_VENDA.AsFloat := SimpleRoundTo(venda, -2);

      qryAjustaPrecoMARGEM.AsFloat :=
        ((qryAjustaPrecoPR_VENDA.AsFloat / qryAjustaPrecoPR_CUSTO2.AsFloat)
        - 1) * 100;
    end
    else
    begin
      // Verificar se a Margem está preenchida
      if qryAjustaPrecoMARGEM.AsFloat > 0 then
      begin
        vMargem := 0;
        vMargem := qryAjustaPrecoMARGEM.AsFloat / 100;
        vMargem := vMargem * qryAjustaPrecoPR_CUSTO2.AsFloat;
        qryAjustaPrecoPR_VENDA.AsFloat := qryAjustaPrecoPR_CUSTO2.AsFloat
          + vMargem
      end
      else
      begin
        qryAjustaPrecoPR_VENDA.AsFloat := SimpleRoundTo(venda, -2);

        qryAjustaPrecoMARGEM.AsFloat :=
          ((qryAjustaPrecoPR_VENDA.AsFloat / qryAjustaPrecoPR_CUSTO2.AsFloat)
          - 1) * 100;
      end;
    end;

    qryAjustaPreco.FieldByName('ULT_COMPRA').Value := compra;
    qryAjustaPreco.Post;
    Dados.Conexao.Commit;

  except
    Dados.Conexao.RollbackRetaining;
  end;
end;

procedure TDados.qryFichaClienteAfterDelete(DataSet: TDataSet);
begin
  Dados.Conexao.Commit;
end;

procedure TDados.qryFichaClienteAfterPost(DataSet: TDataSet);
begin
  Dados.Conexao.Commit;
end;

procedure TDados.qryFPGAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryFPGBeforePost(DataSet: TDataSet);
begin
  if qryFPGINTERVALO.IsNull then
    qryFPGINTERVALO.Value := 0;
  if qryFPGPARCELAS.IsNull then
    qryFPGPARCELAS.Value := 1;
  qryFPGDIAS.Value := qryFPGINTERVALO.Value;
end;

procedure TDados.qryGrupoAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryGrupoBeforePost(DataSet: TDataSet);
begin
  if Dados.qryGrupo.State = dsInsert then
    Dados.qryGrupoCODIGO.Value := Dados.Numerador('GRUPO', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryIdiomasAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryIdiomasNewRecord(DataSet: TDataSet);
begin
  qryIdiomasCODIGO.Value := Dados.Numerador('IDIOMAS', 'CODIGO', 'N', '', '');
end;

procedure TDados.qryItensCompraAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryItensCompraBeforeOpen(DataSet: TDataSet);
begin
  qryProd.Close;
  qryProd.ParamByName('id').Value := qryEmpresaCODIGO.Value;
  qryProd.Open;
end;

procedure TDados.qryItensOBeforeOpen(DataSet: TDataSet);
begin
  qryProd.Close;
  qryProd.ParamByName('id').Value := qryEmpresaCODIGO.Value;
  qryProd.Open;
end;

procedure TDados.qryMesasCalcFields(DataSet: TDataSet);
begin
  if qryMesas.Active then
  begin
    if qryMesasSITUACAO.Value = 'L' then
      qryMesasVIRTUAL_SITUACAO.Value := 'LIVRE';
    if qryMesasSITUACAO.Value = 'O' then
      qryMesasVIRTUAL_SITUACAO.Value := 'OCUPADA';
    qryMesasVIRTUAL_MESA.Value := 'MESA ' + FormatFloat('000',
      qryMesasCODIGO.AsInteger);
  end;
end;

procedure TDados.qryMotoristaAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryMotoristaAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryMotoristaBeforeInsert(DataSet: TDataSet);
begin
  if qryTransp.State in dsEditmodes then
    qryTransp.Post;
end;

procedure TDados.qryMotoristaBeforePost(DataSet: TDataSet);
begin
  if qryMotorista.State = dsInsert then
    qryMotoristaCODIGO.AsInteger := Dados.Numerador('TRANSPORTADORA_MOTORISTA',
      'CODIGO', 'N', '', '');
end;

procedure TDados.qryMotoristaNewRecord(DataSet: TDataSet);
begin
  qryMotoristaFK_TRANSPORTADORA.AsInteger := qryTranspCODIGO.AsInteger;
end;

procedure TDados.LimpaTerminais;
begin
  Dados.qryUpdate.Close;
  Dados.qryUpdate.sql.Text := 'DELETE FROM VENDAS_TERMINAIS';
  Dados.qryUpdate.execsql;
end;

procedure TDados.QRYNFCE_DBeforePost(DataSet: TDataSet);
begin
  if Dados.QRYNFCE_D.State = dsInsert then
    Dados.QRYNFCE_DCODIGO.Value := Dados.Numerador('NFCE_DETALHE', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryNFCE_MAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryNFCE_MAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryNFCE_MBeforePost(DataSet: TDataSet);
begin
  if Dados.qryNFCE_M.State = dsInsert then
    Dados.qryNFCE_MCODIGO.Value := Dados.Numerador('NFCE_MASTER', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryOrcamentoCalcFields(DataSet: TDataSet);
begin
  if qryOrcamentoSITUACAO.Value = 'A' then
    qryOrcamentoVIRTUAL_SITUACAO.Value := 'ABERTO';
  if qryOrcamentoSITUACAO.Value = 'F' then
    qryOrcamentoVIRTUAL_SITUACAO.Value := 'FECHADO';
  if qryOrcamentoSITUACAO.Value = 'C' then
    qryOrcamentoVIRTUAL_SITUACAO.Value := 'CANCELADO';
end;

procedure TDados.qryParametroAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryParametroAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryParametroBeforeEdit(DataSet: TDataSet);
begin
  try
    ServidorAPP := Dados.qryParametroSERVIDOR_APP.Value;
    SenhaAPP := Dados.Crypt('D', Dados.qryParametroSENHA_APP.Value);
    SenhaLI := Dados.Crypt('D', Dados.qryParametroSENHA_LI.Value);
    DatabaseAPP := Dados.Crypt('D', Dados.qryParametroDATABASE_APP.Value);
    DatabasLI := Dados.Crypt('D', Dados.qryParametroDATABASE_LI.Value);
    UsuarioAPP := Dados.Crypt('D', Dados.qryParametroUSUARIO_APP.Value);
  Except
    SenhaAPP := '';
    SenhaLI := '';
    DatabaseAPP := '';
    DatabasLI := '';
    UsuarioAPP := '';
  end;
end;

procedure TDados.AtualizaValidadeSistema(Codigo: Integer;
  CNPJ, Bloqueado: string; Data: TDate);
begin
  try
    Dados.qryAtualiza.Close;
    Dados.qryAtualiza.sql.Text :=
      'update EMPRESA set data_validade=:DATA, CSENHA=:CSENHA WHERE CODIGO=:COD';
    Dados.qryAtualiza.ParamByName('DATA').AsString :=
      Crypt('C', FormatDateTime('dd/mm/yyyy', Data));
    if Bloqueado = 'T' then
      Dados.qryAtualiza.ParamByName('CSENHA').Value := Crypt('C', 'S')
    else
      Dados.qryAtualiza.ParamByName('CSENHA').Value := Crypt('C', 'N');
    Dados.qryAtualiza.ParamByName('COD').Value := Dados.qryEmpresaCODIGO.Value;
    Dados.qryAtualiza.Prepare;
    Dados.qryAtualiza.execsql;
    Dados.Conexao.Commit;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TDados.qryPermissoesAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryPermissoesAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryPessoasAfterPost(DataSet: TDataSet);
var
  aTask: ITask;
begin
  Conexao.Commit;
end;

procedure TDados.qryPessoasBeforePost(DataSet: TDataSet);
begin
  if Dados.qryPessoas.State in [dsInsert] then
    Dados.qryPessoasCODIGO.Value := Dados.Numerador('PESSOA', 'CODIGO',
      'N', '', '');
  if Dados.qryPessoasREFERENCIA.IsNull then
    Dados.qryPessoasREFERENCIA.Value := Dados.qryPessoasCODIGO.Value;
end;

procedure TDados.qryPessoasNewRecord(DataSet: TDataSet);
begin
  Dados.qryPessoasCODIGO.Value := Dados.Numerador('PESSOA', 'CODIGO',
    'N', '', '');
  Dados.qryPessoasATIVO.Value := 'S';
  Dados.qryPessoasCLI.Value := 'S';
  Dados.qryPessoasEMPRESA.Value := Dados.qryEmpresaCODIGO.Value;
  Dados.qryPessoasFORN.Value := 'N';
  Dados.qryPessoasFAB.Value := 'N';
  Dados.qryPessoasIE.Value := '';
  Dados.qryPessoasFUN.Value := 'N';
  Dados.qryPessoasADM.Value := 'N';
  Dados.qryPessoasLIMITE.Value := 0;
  Dados.qryPessoasISENTO.Value := '2';
  Dados.qryPessoasSALARIO.Value := 0;
  Dados.qryPessoasCCF.Value := 'N';
  Dados.qryPessoasSPC.Value := 'N';
  Dados.qryPessoasTRAN.Value := 'N';
  Dados.qryPessoasFATURA.Value := 'N';
  Dados.qryPessoasCHEQUE.Value := 'N';
  Dados.qryPessoasUF.Value := Dados.qryEmpresaUF.Value;
  Dados.qryPessoasDT_CADASTRO.Value := Date;
  Dados.qryPessoasCODMUN.Value := Dados.qryEmpresaID_CIDADE.Value;
  Dados.qryPessoasMUNICIPIO.Value := Dados.qryEmpresaCIDADE.Value;
end;

procedure TDados.qryPlanoAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryProdutosBeforeOpen(DataSet: TDataSet);
begin
  qryGrupo.Close;
  qryGrupo.Open;
  qryUnidade.Close;
  qryUnidade.Open;
  qryFornecedor.Close;
  qryFornecedor.Open;
end;

procedure TDados.qrySped_ConfigNewRecord(DataSet: TDataSet);
begin
  qrySped_ConfigFK_EMPRESA.Value := qryEmpresaCODIGO.Value;
  qrySped_ConfigFK_USUARIO.Value := idUsuario;
end;

procedure TDados.qryTelasAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryTelasAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryTerminalNewRecord(DataSet: TDataSet);
begin
  Dados.qryTerminalEMPRESA.Value := Dados.qryEmpresaCODIGO.Value;
  Dados.qryTerminalMARGEM_ESQUERDA.Value := 0.7;
  Dados.qryTerminalMARGEM_DIREITA.Value := 0.7;
  Dados.qryTerminalMARGEM_INFERIOR.Value := 0.7;
  Dados.qryTerminalMARGEM_SUPERIOR.Value := 0.7;
  Dados.qryTerminalLARGURA_BOBINA.Value := 302;
  Dados.qryTerminalTAMANHO_FONTE.Value := 8;
  Dados.qryTerminalLINHAS_ENTRE_CUPOM.Value := '5';
  Dados.qryTerminalESPACO_ENTRE_LINHAS.Value := '0';
  // Dados.qryTerminalEXIBE_F6.Value := 'S';
end;

procedure TDados.qryTranspAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryTranspBeforePost(DataSet: TDataSet);
begin
  if Dados.qryTransp.State = dsInsert then
    Dados.qryTranspCODIGO.Value := Dados.Numerador('TRANSPORTADORA', 'CODIGO',
      'N', '', '');
end;

procedure TDados.qryVeiculos_ReboqueNewRecord(DataSet: TDataSet);
begin
  Dados.qryVeiculos_ReboqueCODIGO.Value := Dados.Numerador('VEICULOS_REBOQUE',
    'CODIGO', 'N', '', '');
  Dados.qryVeiculos_ReboquePLACA_CAVALO.Value :=
    Dados.qryVeiculos_cavaloPLACA.Value;
end;

procedure TDados.qryVendedorAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.QryXmlDetailAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.QryXmlDetailAfterEdit(DataSet: TDataSet);
begin
  if QryXmlDetailFK_GRUPO.IsNull then
    QryXmlDetailFK_GRUPO.Value := vCodGrupo;
end;

procedure TDados.QryXmlDetailAfterOpen(DataSet: TDataSet);
begin
  qryPesqProd.Close;
  qryPesqProd.Open;
end;

procedure TDados.QryXmlDetailAfterPost(DataSet: TDataSet);
begin
  vCodGrupo := QryXmlDetailFK_GRUPO.Value;
  Conexao.Commit;
end;

procedure TDados.QryXmlDetailBeforePost(DataSet: TDataSet);
begin
  if QryXmlDetail.State = dsInsert then
    QryXmlDetailCODIGO.Value := Dados.Numerador('XML_DETAIL', 'CODIGO',
      'N', '', '');

  QryXmlDetailCHECAR.Value := 'S';
  if (QryXmlDetailDESCRICAO_LOCAL.Value = QryXmlDetailVIRTUAL_DESCRICAO.Value)
    or (QryXmlDetailCODBARRA.Value = QryXmlDetailVIRTUAL_BARRA.Value) then
    QryXmlDetailCHECAR.Value := 'N';
end;

procedure TDados.QryXmlDetailQTD_TOTALChange(Sender: TField);
begin
  if QryXmlDetailQTD_TOTAL.Value > 0 then
    QryXmlDetailPRECO_S.Value := QryXmlDetailVL_ITEM.Value /
      QryXmlDetailQTD_TOTAL.Value;
end;

procedure TDados.QryXmlDetailQUANT_SChange(Sender: TField);
begin
  QryXmlDetailQTD_TOTAL.Value := QryXmlDetailEMBALAGEM.Value *
    QryXmlDetailQUANT_S.Value;
end;

procedure TDados.qryXmlMasterAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryXmlMasterAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryXMLProdutoAfterDelete(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.qryXMLProdutoAfterPost(DataSet: TDataSet);
begin
  Conexao.Commit;
end;

procedure TDados.serial;
var
  i, tamanho: Integer;
begin
  nSerial := '';
  vSerial := SerialNum('C'); // TiraPontos(Dados.qryEmpresaCNPJ.Value)
  tamanho := Length(vSerial);
  for i := 1 to tamanho do
  begin
    case vSerial[i] of
      'A':
        nSerial := nSerial + '8';
      'B':
        nSerial := nSerial + '6';
      'C':
        nSerial := nSerial + '3';
      'D':
        nSerial := nSerial + '2';
      'E':
        nSerial := nSerial + '0';
      'F':
        nSerial := nSerial + '2';
      'G':
        nSerial := nSerial + '4';
      'H':
        nSerial := nSerial + '5';
      'I':
        nSerial := nSerial + '0';
      'J':
        nSerial := nSerial + '7';
      'K':
        nSerial := nSerial + '!';
      'L':
        nSerial := nSerial + '@';
      'M':
        nSerial := nSerial + '#';
      'N':
        nSerial := nSerial + '$';
      'O':
        nSerial := nSerial + '%';
      'P':
        nSerial := nSerial + '6';
      'Q':
        nSerial := nSerial + '&';
      'R':
        nSerial := nSerial + '*';
      'S':
        nSerial := nSerial + '(';
      'T':
        nSerial := nSerial + ')';
      'U':
        nSerial := nSerial + '-';
      'V':
        nSerial := nSerial + '=';
      'X':
        nSerial := nSerial + '}';
      'W':
        nSerial := nSerial + '{';
      'Y':
        nSerial := nSerial + ']';
      'Z':
        nSerial := nSerial + '[';
      '0':
        nSerial := nSerial + 'I';
      '1':
        nSerial := nSerial + 'H';
      '2':
        nSerial := nSerial + 'G';
      '3':
        nSerial := nSerial + 'F';
      '4':
        nSerial := nSerial + 'E';
      '5':
        nSerial := nSerial + 'D';
      '6':
        nSerial := nSerial + 'C';
      '7':
        nSerial := nSerial + 'B';
      '8':
        nSerial := nSerial + 'A';
      '9':
        nSerial := nSerial + 'J';
    end;
  end;
end;

procedure TDados.limpaFlagCR(Codigo: Integer);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'update creceber set flag=''N'' where fkcliente=:id';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

procedure TDados.limpaFlagCP(Codigo: Integer);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Text :=
    'update cpagar set flag=''N'' where FKFORNECE=:id';
  Dados.qryExecute.Params[0].Value := Codigo;
  Dados.qryExecute.execsql;
  Dados.Conexao.Commit;
end;

function TDados.buscacodigoPessoa(referencia: STRING): Integer;
begin
  Result := 0;
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Text :=
    'SELECT CODIGO FROM PESSOA WHERE REFERENCIA=:REF';
  Dados.qryConsulta.Params[0].Value := referencia;
  Dados.qryConsulta.Open;

  if not Dados.qryConsulta.IsEmpty then
    Result := Dados.qryConsulta.FieldByName('CODIGO').AsInteger;

end;

function TDados.buscacodigoProduto(sql, parametro: STRING): Integer;
begin
  Result := 0;
  qryConsulta.Close;
  qryConsulta.sql.Clear;
  qryConsulta.sql.Text := sql;
  qryConsulta.Params[0].Value := parametro;
  qryConsulta.Open;
  if not qryConsulta.IsEmpty then
    Result := qryConsulta.Fields[0].AsInteger
  else
    raise Exception.Create('Produto não encontrado!');
end;

procedure TDados.InsereCaixa(Empresa, IDCR, FKPLANO, FKCONTA,
  ID_USUARIO: Integer; TIPO_MOVIMENTO, FPG, DOC, HISTORICO, TRANSFERENCIA,
  ECARTAO: String; ENTRADA: Extended);
begin
  Dados.qryExecute.Close;
  Dados.qryExecute.sql.Clear;
  Dados.qryExecute.sql.Add('INSERT INTO CAIXA (');
  Dados.qryExecute.sql.Add(' CODIGO,');
  Dados.qryExecute.sql.Add(' EMISSAO,');
  Dados.qryExecute.sql.Add(' DOC,');
  Dados.qryExecute.sql.Add(' FKPLANO,');
  Dados.qryExecute.sql.Add(' FKCONTA,');
  Dados.qryExecute.sql.Add(' HISTORICO,');
  Dados.qryExecute.sql.Add(' ENTRADA,');
  Dados.qryExecute.sql.Add(' SAIDA,');
  Dados.qryExecute.sql.Add(' TRANSFERENCIA,');
  Dados.qryExecute.sql.Add(' HORA_EMISSAO,');
  Dados.qryExecute.sql.Add(' ECARTAO,');
  Dados.qryExecute.sql.Add(' ID_USUARIO,');
  Dados.qryExecute.sql.Add(' EMPRESA,');
  Dados.qryExecute.sql.Add(' FKRECEBER,');
  Dados.qryExecute.sql.Add(' DT_CADASTRO,');
  Dados.qryExecute.sql.Add(' TIPO_MOVIMENTO,');
  Dados.qryExecute.sql.Add(' FPG)');
  Dados.qryExecute.sql.Add(' VALUES(');
  Dados.qryExecute.sql.Add(' :CODIGO,');
  Dados.qryExecute.sql.Add(' :EMISSAO,');
  Dados.qryExecute.sql.Add(' :DOC,');
  Dados.qryExecute.sql.Add(' :FKPLANO,');
  Dados.qryExecute.sql.Add(' :FKCONTA,');
  Dados.qryExecute.sql.Add(' :HISTORICO,');
  Dados.qryExecute.sql.Add(' :ENTRADA,');
  Dados.qryExecute.sql.Add(' :SAIDA,');
  Dados.qryExecute.sql.Add(' :TRANSFERENCIA,');
  Dados.qryExecute.sql.Add(' :HORA_EMISSAO,');
  Dados.qryExecute.sql.Add(' :ECARTAO,');
  Dados.qryExecute.sql.Add(' :ID_USUARIO,');
  Dados.qryExecute.sql.Add(' :EMPRESA,');
  Dados.qryExecute.sql.Add(' :FKRECEBER,');
  Dados.qryExecute.sql.Add(' :DT_CADASTRO,');
  Dados.qryExecute.sql.Add(' :TIPO_MOVIMENTO,');
  Dados.qryExecute.sql.Add(' :FPG)');
  Dados.qryExecute.ParamByName('CODIGO').Value :=
    Dados.Numerador('CAIXA', 'CODIGO', 'N', '', '');
  Dados.qryExecute.ParamByName('EMISSAO').AsDate := now;
  Dados.qryExecute.ParamByName('DOC').Value := DOC;
  Dados.qryExecute.ParamByName('FKPLANO').Value := FKPLANO;
  Dados.qryExecute.ParamByName('FKCONTA').Value := FKCONTA;
  Dados.qryExecute.ParamByName('HISTORICO').Value := HISTORICO;
  Dados.qryExecute.ParamByName('ENTRADA').Value := ENTRADA;
  Dados.qryExecute.ParamByName('SAIDA').Value := 0;
  Dados.qryExecute.ParamByName('TRANSFERENCIA').Value := TRANSFERENCIA;
  Dados.qryExecute.ParamByName('HORA_EMISSAO').Value := now;
  Dados.qryExecute.ParamByName('ECARTAO').Value := ECARTAO;
  Dados.qryExecute.ParamByName('ID_USUARIO').Value := ID_USUARIO;
  Dados.qryExecute.ParamByName('EMPRESA').Value := Empresa;
  Dados.qryExecute.ParamByName('FKRECEBER').Value := IDCR;
  Dados.qryExecute.ParamByName('DT_CADASTRO').Value := Date;
  Dados.qryExecute.ParamByName('TIPO_MOVIMENTO').Value := TIPO_MOVIMENTO;
  Dados.qryExecute.ParamByName('FPG').Value := FPG;
  Dados.qryExecute.execsql;
end;

{ TEmail }
procedure TEmail.GetEmail;
begin
  if not Dados.qryConfig.Active then
  begin
    Dados.qryConfig.Close;
    Dados.qryConfig.Open;
  end;
  if Dados.qryConfigEMAILSSL.AsString = 'S' then
    SSL := true;
  if Dados.qryConfigEMAILTLS.AsString = 'S' then
    TLS := true;
  usuario := Dados.qryConfigEMAILUSER.AsString;
  Senha := Dados.Crypt('D', Dados.qryConfigEMAILSENHA.AsString);
  servidor := Dados.qryConfigEMAILHOST.AsString;
  porta := Dados.qryConfigEMAILPORTA.AsString;
end;

function TDados.LimpaString(str: string): string;
var
  x: Integer;
  st: string;
begin
  st := '';
  for x := 1 to Length(str) do
  begin
    if (str[x] <> '-') and (str[x] <> '.') and (str[x] <> ',') and
      (str[x] <> '/') then
      st := st + str[x];
  end;
  LimpaString := st;
end;

function TDados.EhLetra(S: String): boolean;
var
  i: Integer;
  Texto: string;
begin
  try
    Result := False;
    Texto := UpperCase(S);
    for i := 1 to Length(Texto) do
    begin
      if Texto[i] in ['A' .. 'Z'] then
        Result := true
      else
      begin
        Result := False;
        Break;
      end;
    end;
  except
  end;
end;

function TDados.GetIdFormaForAtalho(sAtalho: string): Integer;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Dados.Conexao;
    qry.Close;
    qry.sql.Clear;
    qry.sql.Text := 'select codigo from forma_pagamento fp ' +
      'where fp.atalho = ' + QuotedStr(sAtalho);
    qry.Open;
    Result := qry.Fields[0].AsInteger;
  finally
    qry.Free;
  end;
end;

// Inicio modificações update 4.3
function TDados.BuscaValor(Codigo: Integer; tp: string): Extended;
begin
  Result := 0;
  Dados.qryConsulta.Close;
  Dados.qryConsulta.sql.Clear;
  Dados.qryConsulta.sql.Add(' select SUM(fpg.valor) from vendas_fpg  fpg ');
  Dados.qryConsulta.sql.Add(' where');
  Dados.qryConsulta.sql.Add(' fpg.vendas_master=:CODIGO and ');
  Dados.qryConsulta.sql.Add(' fpg.tipo=:TP and fpg.valor>0');
  Dados.qryConsulta.Params[0].Value := Codigo;
  Dados.qryConsulta.Params[1].Value := tp;
  Dados.qryConsulta.Open;
  Result := Dados.qryConsulta.Fields[0].AsFloat
end;

procedure TDados.ConsultaCliente(var Codigo: Integer;
  var Razao, Fantasia: string);
begin
  try
    try
      frmConsCliente := TfrmConsCliente.Create(Application);
      frmConsCliente.ShowModal;
    finally
      Codigo := frmConsCliente.iCodCliente;
      Razao := frmConsCliente.sRazao;
      Fantasia := frmConsCliente.sFantasia;
      frmConsCliente.Release;
    end;
  except
  end;
end;

function TDados.GetLocalIP: string;
var
  wsaData: TWSAData;
begin
  WSAStartup(257, wsaData);
  Result := trim(inet_ntoa(PInAddr(GetHostByName(nil)^.h_addr_list^)^));
end;

procedure TDados.AjustaCusto(produto: Integer; compra, custo: Extended);
begin
  try
    qryAjustaPreco.Close;
    qryAjustaPreco.Params[0].Value := produto;
    qryAjustaPreco.Open;

    qryAjustaPreco.Edit;

    qryAjustaPrecoPR_CUSTO.Value := compra;
    qryAjustaPrecoPR_CUSTO2.Value := custo;

    if custo <= 0 then
    begin
      qryAjustaPrecoPR_CUSTO2.AsFloat :=
        SimpleRoundTo(qryAjustaPrecoPR_CUSTO.AsFloat +
        (qryAjustaPrecoPR_CUSTO.AsFloat * qryAjustaPrecoPERC_CUSTO.AsFloat /
        100), -2);
    end
    else
    begin
      if qryAjustaPrecoPR_CUSTO.AsFloat > 0 then
        qryAjustaPrecoPERC_CUSTO.AsFloat :=
          SimpleRoundTo(((qryAjustaPrecoPR_CUSTO2.AsFloat * 100) /
          qryAjustaPrecoPR_CUSTO.AsFloat) - 100, -2);

      if qryAjustaPrecoPERC_CUSTO.AsFloat < 0 then
        qryAjustaPrecoPERC_CUSTO.AsFloat := 0;
    end;

    if qryAjustaPrecoPR_CUSTO.Value > 0 then
      qryAjustaPrecoMARGEM.AsFloat :=
        ((qryAjustaPrecoPR_VENDA.AsFloat * 100) /
        qryAjustaPrecoPR_CUSTO2.AsFloat) - 100;

    if qryAjustaPrecoMARGEM.Value < 0 then
      qryAjustaPrecoMARGEM.AsFloat := 0;

    qryAjustaPreco.Post;
    Dados.Conexao.Commit;
  except
    Dados.Conexao.RollbackRetaining;
  end;
end;

procedure TDados.AtualizaEstoque(Qtd, IdProduto: real);
begin
  qryExecute.Close;
  qryExecute.sql.Clear;
  qryExecute.sql.Add('update produto');
  qryExecute.sql.Add('set qtd_atual= qtd_atual + :qtd');
  qryExecute.sql.Add('where');
  qryExecute.sql.Add('(codigo=:cod) and ((servico is null) or servico=''N'')');

  qryExecute.ParamByName('cod').Value := IdProduto;
  qryExecute.ParamByName('qtd').Value := Qtd;

  qryExecute.execsql;
end;

function TDados.GravaUltimoPreco(IdProduto: Integer; UltimoPreco: real)
  : boolean;
var
  qry: TFDQuery;
begin
  Result := true;
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Conexao;
    try
      qry.Close;
      qry.sql.Clear;
      qry.sql.Text :=
        'insert into PROD_ULTIMOS_PRECOS (CODIGO, FKPRODUTO, ULTIMO_PRECO, DT_ULTIMO_PRECO, USUARIO)  '
        + 'values (:CODIGO, :FKPRODUTO, :ULTIMO_PRECO, :DT_ULTIMO_PRECO, :USUARIO)  ';
      qry.ParamByName('CODIGO').Value := Numerador('PROD_ULTIMOS_PRECOS',
        'CODIGO', 'N', '', '');
      qry.ParamByName('FKPRODUTO').Value := IdProduto;
      qry.ParamByName('ULTIMO_PRECO').Value := UltimoPreco;
      qry.ParamByName('DT_ULTIMO_PRECO').Value := Date;
      qry.ParamByName('USUARIO').Value := vUsuario;
      qry.execsql;
    except
      try
        qry.Close;
        qry.sql.Clear;
        qry.sql.Text := 'drop table PROD_ULTIMOS_PRECOS;';
        qry.execsql;
        qry.Close;
        qry.sql.Clear;
        qry.sql.Text := 'CREATE TABLE PROD_ULTIMOS_PRECOS ( ' +
          '    CODIGO SMALLINT, ' + '    FKPRODUTO INTEGER, ' +
          '    ULTIMO_PRECO DECIMAL(15,2), ' + '    DT_ULTIMO_PRECO date, ' +
          '    USUARIO VARCHAR(10)); ';
        qry.execsql;
        qry.Close;
        qry.sql.Clear;
        qry.sql.Text :=
          'insert into PROD_ULTIMOS_PRECOS (CODIGO, FKPRODUTO, ULTIMO_PRECO, DT_ULTIMO_PRECO, USUARIO)  '
          + 'values (:CODIGO, :FKPRODUTO, :ULTIMO_PRECO, :DT_ULTIMO_PRECO, :USUARIO)  ';
        qry.ParamByName('CODIGO').Value := Numerador('PROD_ULTIMOS_PRECOS',
          'CODIGO', 'N', '', '');
        qry.ParamByName('FKPRODUTO').Value := IdProduto;
        qry.ParamByName('ULTIMO_PRECO').Value := UltimoPreco;
        qry.ParamByName('DT_ULTIMO_PRECO').Value := Date;
        qry.ParamByName('USUARIO').Value := vUsuario;
        qry.execsql;
      except
        Result := False;
      end;
    end;
  finally
    qry.Free;
  end;
end;

function TDados.DeletarUltimoPreco(IdProduto: Integer): boolean;
var
  qry: TFDQuery;
begin
  Result := true;
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := Conexao;
    try
      qry.Close;
      qry.sql.Clear;
      qry.sql.Text := 'delete from PROD_ULTIMOS_PRECOS where FKPRODUTO = ' +
        IntToStr(IdProduto);
      qry.execsql;
    finally
      qry.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TDados.ZerarListaBoleto(dm: TdmForte);
begin
  dm.ACBrBoleto.ListadeBoletos.Clear;
end;

procedure TDados.GerarBoleto(dm: TdmForte; var sPath, sErro: string;
  bImprimir: boolean);
var
  vPath, vNamePDF: string;
  Boleto: TACBrBoleto;
begin
  try
    Boleto := dm.ACBrBoleto;
    vPath := ExtractFilePath(Application.ExeName) + 'Boleto';
    if not DirectoryExists(vPath) then
      ForceDirectories(vPath);
    vPath := vPath + '\' + FormatDateTime('mmyyyy', Date);
    if not DirectoryExists(vPath) then
      ForceDirectories(vPath);
    vNamePDF := 'Boleto_' + Boleto.ListadeBoletos[0].NumeroDocumento + '_' +
      FormatDateTime('ddmmyyyy', Boleto.ListadeBoletos[0].Vencimento) + '_' +
      Boleto.ListadeBoletos[0].Sacado.CNPJCPF + '.pdf';
    Boleto.ACBrBoletoFC.NomeArquivo := vPath + '\' + vNamePDF;
    Boleto.GerarPDF;
    sPath := vPath + vNamePDF;
    if bImprimir then
      Boleto.Imprimir;
  except
    on e: Exception do
    begin
      sErro := 'Falha ao Gerar Boleto.' + sLineBreak + 'Falha: ' + sLineBreak +
        e.Message;
    end;
  end;
end;

procedure TDados.CarregarParametrosBoleto(dm: TdmForte);
var
  Boleto: TACBrBoleto;
  i: TACBrBolLayOut;
  cbxLayOut: TStringList;
  icbxLayOut: Integer;
  xArquivo: String;
begin
  try
    // Ler Ini do Boleto
    xArquivo := ExtractFilePath(ParamStr(0)) +
      ChangeFileExt(ExtractFileName(ParamStr(0)), '_Boleto.ini');
    if (FileExists(xArquivo)) then
      dm.ACBrBoleto.LerConfiguracao(xArquivo);
    // Carregar Parametros
    Dados.qryBoletoParam.Close;
    Dados.qryBoletoParam.Params[0].AsInteger :=
      Dados.qryEmpresaCODIGO.AsInteger;
    Dados.qryBoletoParam.Open;
    try
      cbxLayOut := TStringList.Create;
      cbxLayOut.Clear;
      for i := Low(TACBrBolLayOut) to High(TACBrBolLayOut) do
        cbxLayOut.Add(GetEnumName(TypeInfo(TACBrBolLayOut), Integer(i)));
      icbxLayOut := cbxLayOut.IndexOf(Dados.qryBoletoParamLAYOUT.AsString);
    finally
      cbxLayOut.Free;
    end;

    Boleto := dm.ACBrBoleto;
    Boleto.ACBrBoletoFC.LayOut := TACBrBolLayOut(icbxLayOut);
    Boleto.ACBrBoletoFC.SoftwareHouse := 'LojaDev';

    Boleto.Cedente.Bairro := qryEmpresaBAIRRO.AsString;
    Boleto.Cedente.CEP := qryEmpresaCEP.AsString;
    Boleto.Cedente.cidade := qryEmpresaCIDADE.AsString;
    Boleto.Cedente.CNPJCPF := qryEmpresaCNPJ.AsString;
    Boleto.Cedente.FantasiaCedente := qryEmpresaFANTASIA.AsString;
    Boleto.Cedente.Nome := qryEmpresaFANTASIA.AsString;
    Boleto.Cedente.NumeroRes := qryEmpresaNUMERO.AsString;
    Boleto.Cedente.Telefone := qryEmpresaFONE.AsString;
    Boleto.Cedente.uf := qryEmpresaUF.AsString;

    // Boleto.Configuracoes.Arquivos.LogRegistro :=  True;
    Boleto.Configuracoes.Arquivos.LogNivel := TNivelLog(LogNormal);
    // nova função de Log dos Boletos
    Boleto.Configuracoes.Arquivos.PathGravarRegistro :=
      ExtractFilePath(Application.ExeName) + '\Boleto\Logs';

    Boleto.Cedente.CedenteWS.IndicadorPix :=
      Dados.qryBoletoParamWEBSERVICE_INDICADOR_PIX.AsString = 'S';
    Boleto.Cedente.CedenteWS.ClientID :=
      Dados.qryBoletoParamWEBSERVICE_CLIENT_ID.AsString;
    Boleto.Cedente.CedenteWS.ClientSecret :=
      Dados.qryBoletoParamWEBSERVICE_CLIENT_SECRET.AsString;
    Boleto.Cedente.CedenteWS.KeyUser :=
      Dados.qryBoletoParamWEBSERVICE_KEY_USER.AsString;
  except
    on e: Exception do
    begin
      Application.MessageBox(pchar('Falha ao Carregar Parametros Boleto.' +
        sLineBreak + 'Falha: ' + sLineBreak + e.Message), 'Boleto',
        MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TDados.GravarNoGerenciadorBoleto(dm: TdmForte; sOrigem, sPath: string;
  iCodCReceber: Integer; iCodNFeFatura: Integer; CodigoBarras: string);
var
  Boleto: TACBrBoleto;
begin
  try
    try
      Boleto := dm.ACBrBoleto;

      qryBoletoGerenciador.Close;
      qryBoletoGerenciador.Params[0].AsInteger := -1;
      qryBoletoGerenciador.Open;
      qryBoletoGerenciador.Insert;
      qryBoletoGerenciadorNOSSO_NUMERO.AsString := Boleto.ListadeBoletos[0]
        .NossoNumero;
      qryBoletoGerenciadorLINHA_DIGITAVEL.AsString := CodigoBarras;
      qryBoletoGerenciadorVENCIMENTO.AsDateTime := Boleto.ListadeBoletos[0]
        .Vencimento;
      qryBoletoGerenciadorDATA_DOCUMENTO.AsDateTime := Boleto.ListadeBoletos[0]
        .DataDocumento;
      qryBoletoGerenciadorNUMERO_DOCUMENTO.AsString := Boleto.ListadeBoletos[0]
        .NumeroDocumento;
      qryBoletoGerenciadorDATA_PROCESSAMENTO.AsDateTime := Boleto.ListadeBoletos
        [0].DataProcessamento;
      qryBoletoGerenciadorVALOR_DOCUMENTO.AsFloat := Boleto.ListadeBoletos[0]
        .ValorDocumento;
      qryBoletoGerenciadorSACADO_NOME_SACADO.AsString := Boleto.ListadeBoletos
        [0].Sacado.NomeSacado;
      qryBoletoGerenciadorSACADO_CNPJCPF.AsString := Boleto.ListadeBoletos[0]
        .Sacado.CNPJCPF;
      qryBoletoGerenciadorSACADO_LOGRADOURO.AsString := Boleto.ListadeBoletos[0]
        .Sacado.Logradouro;
      qryBoletoGerenciadorSACADO_NUMERO.AsString := Boleto.ListadeBoletos[0]
        .Sacado.Numero;
      qryBoletoGerenciadorSACADO_BAIRRO.AsString := Boleto.ListadeBoletos[0]
        .Sacado.Bairro;
      qryBoletoGerenciadorSACADO_CIDADE.AsString := Boleto.ListadeBoletos[0]
        .Sacado.cidade;
      qryBoletoGerenciadorSACADO_UF.AsString := Boleto.ListadeBoletos[0]
        .Sacado.uf;
      qryBoletoGerenciadorSACADO_CEP.AsString := Boleto.ListadeBoletos[0]
        .Sacado.CEP;
      qryBoletoGerenciadorVALOR_ABATIMENTO.AsFloat := Boleto.ListadeBoletos[0]
        .ValorAbatimento;
      qryBoletoGerenciadorVALOR_MORA_JUROS.AsFloat := Boleto.ListadeBoletos[0]
        .ValorMoraJuros;
      qryBoletoGerenciadorVALOR_DESCONTO.AsFloat := Boleto.ListadeBoletos[0]
        .ValorDesconto;
      qryBoletoGerenciadorDATA_MORA_JUROS.AsDateTime := Boleto.ListadeBoletos[0]
        .DataMoraJuros;
      qryBoletoGerenciadorDATA_DESCONTO.AsDateTime := Boleto.ListadeBoletos[0]
        .DataDesconto;
      qryBoletoGerenciadorDATA_ABATIMENTO.AsDateTime := Boleto.ListadeBoletos[0]
        .DataAbatimento;
      qryBoletoGerenciadorDATA_PROTESTO.AsDateTime := Boleto.ListadeBoletos[0]
        .DataProtesto;
      qryBoletoGerenciadorPERCENTUAL_MULTA.AsFloat := Boleto.ListadeBoletos[0]
        .PercentualMulta;
      qryBoletoGerenciadorINSTRUCAO1.AsString := Boleto.ListadeBoletos[0]
        .Instrucao1;
      qryBoletoGerenciadorINSTRUCAO2.AsString := Boleto.ListadeBoletos[0]
        .Instrucao2;
      qryBoletoGerenciadorPATH_PDF_BOLETO.AsString := sPath;
      qryBoletoGerenciadorFK_CRECEBER.AsInteger := iCodCReceber;
      qryBoletoGerenciadorFK_NFE_FATURA.AsInteger := iCodNFeFatura;
      qryBoletoGerenciadorRETORNO_WEB_SERVICE.Clear;
      qryBoletoGerenciador.Post;
    finally
      qryBoletoGerenciador.Close;
    end;
  except
    on e: Exception do
    begin
      Application.MessageBox(pchar('Falha ao Gravar no Gerenciador de Boleto.' +
        sLineBreak + 'Falha: ' + sLineBreak + e.Message), 'Boleto',
        MB_OK + MB_ICONERROR);
    end;
  end;
end;

function TDados.SoNumero(fField: String): String;
var
  i: Byte;
begin
  Result := '';
  for i := 1 To Length(fField) do
    if fField[i] In ['0' .. '9'] Then
      Result := Result + fField[i];
end;

function TDados.IncluiBoleto(dm: TdmForte; iCodCliente: Integer;
  dtVencimento: TDate; NumDocumento: string; rValor, rVlrJuros, rVlrDesconto,
  rVlrAbatimento, rPercMulta: Extended; dtJuros, dtDesconto, dtAbatimento,
  dtProtesto, sInstrucao01, sInstrucao02: string; dtEmissao: TDate;
  var CodBarras: string): boolean;
var
  qry: TFDQuery;
  Titulo: TACBrTitulo;
  VQtdeCarcA, VQtdeCarcB, VQtdeCarcC: Integer;
  VLinha, logo: string;
  i: Integer;
  Y: TACBrBolLayOut;
  cbxLayOut: TStringList;
  icbxLayOut: Integer;
begin
  try
    Result := False;
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Conexao;
      qry.Close;
      qry.sql.Clear;
      qry.sql.Text := 'select * from pessoa p ' + 'where (p.codigo=' +
        IntToStr(iCodCliente) + ')';
      qry.Open;
      if not qry.IsEmpty then
      begin
        // Abrir parametros de Boleto
        Dados.qryBoletoParam.Close;
        Dados.qryBoletoParam.Params[0].AsInteger :=
          Dados.qryEmpresaCODIGO.AsInteger;
        Dados.qryBoletoParam.Open;
        try
          cbxLayOut := TStringList.Create;
          cbxLayOut.Clear;
          for Y := Low(TACBrBolLayOut) to High(TACBrBolLayOut) do
            cbxLayOut.Add(GetEnumName(TypeInfo(TACBrBolLayOut), Integer(Y)));
          icbxLayOut := cbxLayOut.IndexOf(Dados.qryBoletoParamLAYOUT.AsString);
        finally
          cbxLayOut.Free;
        end;

        Titulo := dm.ACBrBoleto.CriarTituloNaLista;

        Titulo.Vencimento := dtVencimento;
        Titulo.DataDocumento := dtEmissao;
        Titulo.NumeroDocumento := NumDocumento;
        Titulo.EspecieDoc := Dados.qryBoletoParamESPECIE_DOCTO.AsString;

        if Dados.qryBoletoParamACEITE.AsString = 'SIM' then
          Titulo.Aceite := atSim
        else
          Titulo.Aceite := atNao;

        Titulo.DataProcessamento := now;
        Titulo.Carteira := Dados.qryBoletoParamCARTEIRA.AsString;
        Titulo.ValorDocumento := rValor;
        Titulo.Sacado.NomeSacado := qry.FieldByName('RAZAO').AsString;
        Titulo.Sacado.CNPJCPF :=
          OnlyNumber(SoNumero(qry.FieldByName('CNPJ').AsString));
        Titulo.Sacado.Logradouro := qry.FieldByName('ENDERECO').AsString;
        Titulo.Sacado.Numero := qry.FieldByName('NUMERO').AsString;
        Titulo.Sacado.Bairro := qry.FieldByName('BAIRRO').AsString;
        Titulo.Sacado.cidade := qry.FieldByName('MUNICIPIO').AsString;
        Titulo.Sacado.uf := qry.FieldByName('UF').AsString;
        Titulo.Sacado.CEP := OnlyNumber(qry.FieldByName('CEP').AsString);
        Titulo.ValorAbatimento := rVlrAbatimento;
        Titulo.LocalPagamento :=
          Dados.qryBoletoParamMS_LOCAL_PAGAMENTO.AsString;
        Titulo.ValorMoraJuros := rVlrJuros;
        Titulo.ValorDesconto := rVlrDesconto;
        Titulo.DataMoraJuros := StrToDateDef(dtJuros, 0);
        Titulo.DataDesconto := StrToDateDef(dtDesconto, 0);
        Titulo.DataAbatimento := StrToDateDef(dtAbatimento, 0);
        Titulo.DataProtesto := StrToDateDef(dtProtesto, 0);
        Titulo.PercentualMulta := rPercMulta;
        Titulo.CodigoMoraJuros := cjIsento;
        // Mensagem.Text     := memMensagem.Text;
        Titulo.OcorrenciaOriginal.tipo := toRemessaBaixar;
        Titulo.Instrucao1 := PadRight(trim(sInstrucao01), 2, '0');
        Titulo.Instrucao2 := PadRight(trim(sInstrucao02), 2, '0');

        Titulo.QtdePagamentoParcial := 1;
        Titulo.TipoPagamento := tpNao_Aceita_Valor_Divergente;
        Titulo.PercentualMinPagamento := 0;
        Titulo.PercentualMaxPagamento := 0;
        Titulo.ValorMinPagamento := 0;
        Titulo.ValorMaxPagamento := 0;

        CodBarras := dm.ACBrBoleto.Banco.MontarCodigoBarras(Titulo);
        Titulo.NossoNumero :=
          dm.ACBrBoleto.Banco.MontarCampoNossoNumero(Titulo);
        // QrCode.emv := '00020101021226870014br.gov.bcb.pix2565qrcodepix-h.bb.com.br/pix/v2/22657e83-ecac-4631-a767-65e16fc56bff5204000053039865802BR5925EMPRORT AMBIENTAL        6008BRASILIA62070503***6304BD3D';

        // dm.ACBrBoleto.AdicionarMensagensPadroes(Titulo,Mensagem);

        if icbxLayOut = 6 then
        begin
          for i := 0 to 3 do
          begin
            VLinha := '.';

            VQtdeCarcA := Length('Descrição Produto/Serviço ' + IntToStr(i));
            VQtdeCarcB := Length('Valor:');
            VQtdeCarcC := 85 - (VQtdeCarcA + VQtdeCarcB);

            VLinha := PadLeft(VLinha, VQtdeCarcC, '.');

            Titulo.Detalhamento.Add('Descrição Produto/Serviço ' + IntToStr(i) +
              ' ' + VLinha + ' Valor:   ' + PadRight(FormatCurr('R$ ###,##0.00',
              StrToCurr(FloatToStr(rValor)) * 0.25), 18, ' '));
          end;
          Titulo.Detalhamento.Add('');
          Titulo.Detalhamento.Add('');
          Titulo.Detalhamento.Add('');
          Titulo.Detalhamento.Add('');
          Titulo.Detalhamento.Add
            ('Desconto ........................................................................... Valor: R$ 0,00');
        end;

        if (not qryEmpresaLOGOMARCA.IsNull) then
        begin
          try
            logo := ExtractFileDir(ParamStr(0)) + '\acbr_logo.jpg';
            qryEmpresaLOGOMARCA.SaveToFile(logo);
            Titulo.ArquivoLogoEmp := logo; // logo da empresa
          except
          end;
        end;

        Titulo.Verso := ((Dados.qryBoletoParamIMP_VERSO_FATURA.AsString = 'S'));
      end;
      Result := true;
    finally
      qry.Free;
    end;
  except
    on e: Exception do
    begin
      Application.MessageBox(pchar('Falha ao incluir Boleto.' + sLineBreak +
        'Falha: ' + sLineBreak + e.Message), 'Boleto', MB_OK + MB_ICONERROR);
    end;
  end;
end;

function TDados.RegistraBoleto(dm: TdmForte): boolean;
var
  SLRemessa: TStringList;
  i, j: Integer;
  Boleto: TACBrBoleto;
begin
  try
    Result := False;
    Boleto := dm.ACBrBoleto;

    // Função de Envio
    Boleto.Configuracoes.WebService.Operacao := tpInclui;
    Boleto.EnviarBoleto;
    // <<< retorna como false se o httpresult code for diferente de 200,201,202
    // Verifica Lista com os retornos

    if Boleto.ListaConsultaRetornoWeb.Count > 0 then
    begin
      SLRemessa := TStringList.Create;
      try
        for i := 0 to Pred(Boleto.ListaConsultaRetornoWeb.Count) do
        begin
          // Ler todos os campos da classe Retorno
          SLRemessa.Add('Cod_Retorno=' + Boleto.ListaRetornoWeb[i].CodRetorno +
            sLineBreak + 'Msg_Retorno=' + Boleto.ListaRetornoWeb[i].MsgRetorno +
            sLineBreak + 'Ori_Retorno=' + Boleto.ListaRetornoWeb[i].OriRetorno +
            sLineBreak + 'HTTP_Result=' + IntToStr(Boleto.ListaRetornoWeb[i]
            .HTTPResultCode) + sLineBreak + 'JSON=' +
            Boleto.ListaRetornoWeb[i].JSON);
          for j := 0 to Pred(Boleto.ListaRetornoWeb[i].ListaRejeicao.Count) do
          begin
            SLRemessa.Add('[Rejeicao' + IntToStr(j) + ']' + sLineBreak +
              'Campo=' + Boleto.ListaRetornoWeb[i].ListaRejeicao[j].Campo +
              sLineBreak + 'Codigo=' + Boleto.ListaRetornoWeb[i].ListaRejeicao
              [j].Codigo + sLineBreak + 'Versao=' + Boleto.ListaRetornoWeb[i]
              .ListaRejeicao[j].Versao + sLineBreak + 'Mensagem=' +
              Boleto.ListaRetornoWeb[i].ListaRejeicao[j].Mensagem + sLineBreak +
              'Ocorrencia=' + Boleto.ListaRetornoWeb[i].ListaRejeicao[j]
              .Ocorrencia + sLineBreak + 'Valor=' + Boleto.ListaRetornoWeb[i]
              .ListaRejeicao[j].Valor + sLineBreak);
          end;

          SLRemessa.Add('HEADER' + sLineBreak + 'Versao=' +
            Boleto.ListaRetornoWeb[i].Header.Versao + sLineBreak +
            'Autenticacao=' + Boleto.ListaRetornoWeb[i].Header.Autenticacao +
            sLineBreak + 'Usuario_Servico=' + Boleto.ListaRetornoWeb[i]
            .Header.Usuario_Servico + sLineBreak + 'Usuario=' +
            Boleto.ListaRetornoWeb[i].Header.usuario + sLineBreak + 'Operacao='
            + TipoOperacaoToStr(Boleto.ListaRetornoWeb[i].Header.Operacao) +
            sLineBreak + 'Indice=' + IntToStr(Boleto.ListaRetornoWeb[i]
            .Header.Indice) + sLineBreak + 'Sistema_Origem=' +
            Boleto.ListaRetornoWeb[i].Header.Sistema_Origem + sLineBreak +
            'Agencia=' + Boleto.ListaRetornoWeb[i].Header.Agencia + sLineBreak +
            'ID_Origem=' + Boleto.ListaRetornoWeb[i].Header.Id_Origem +
            sLineBreak + 'Data_Hora=' + FormatDateTime('dd/mm/yyyy hh:nn:ss',
            Boleto.ListaRetornoWeb[i].Header.Data_Hora) + sLineBreak +
            'ID_Processo=' + Boleto.ListaRetornoWeb[i].Header.Id_Processo +
            sLineBreak + 'DADOS' + sLineBreak + 'Excessao=' +
            Boleto.ListaRetornoWeb[i].DadosRet.Excecao + sLineBreak +
            'CONTROLE_NEGOCIAL' + sLineBreak + 'Origem_Retorno=' +
            Boleto.ListaRetornoWeb[i].DadosRet.ControleNegocial.OriRetorno +
            sLineBreak + 'NSU=' + Boleto.ListaRetornoWeb[i]
            .DadosRet.ControleNegocial.NSU + sLineBreak + 'Cod_Retorno=' +
            Boleto.ListaRetornoWeb[i].DadosRet.ControleNegocial.CodRetorno +
            sLineBreak + 'Msg_Retorno=' + Boleto.ListaRetornoWeb[i]
            .DadosRet.ControleNegocial.Retorno + sLineBreak + 'COMPROVANTE' +
            sLineBreak + 'Data=' + FormatDateTime('dd/mm/yyyy',
            Boleto.ListaRetornoWeb[i].DadosRet.Comprovante.Data) + sLineBreak +
            'Hora=' + Boleto.ListaRetornoWeb[i].DadosRet.Comprovante.Hora +
            sLineBreak + 'ID_BOLETO' + sLineBreak + 'Codigo_Barras=' +
            Boleto.ListaRetornoWeb[i].DadosRet.IDBoleto.CodBarras + sLineBreak +
            'Linha_Digitavel=' + Boleto.ListaRetornoWeb[i]
            .DadosRet.IDBoleto.LinhaDig + sLineBreak + 'Nosso_Numero=' +
            Boleto.ListaRetornoWeb[i].DadosRet.IDBoleto.NossoNum + sLineBreak +
            'URL=' + Boleto.ListaRetornoWeb[i].DadosRet.IDBoleto.URL +
            sLineBreak + 'CONSULTA_BOLETO' + sLineBreak + 'Numero_Documento=' +
            Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.NumeroDocumento +
            sLineBreak + 'Data_Vencimento=' + FormatDateTime('dd/mm/yyyy',
            Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.Vencimento) +
            sLineBreak + 'Valor=' + CurrToStr(Boleto.ListaRetornoWeb[i]
            .DadosRet.TituloRet.ValorDocumento) + sLineBreak);
          if NaoEstaVazio(Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.CodBarras)
          then
          begin
            SLRemessa.Add('TITULO_RETORNO' + sLineBreak + 'vencimento_titulo=' +
              FormatDateTime('dd/mm/yyyy',
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.Vencimento) +
              sLineBreak + 'tipo_carteira_titulo=' + Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.Carteira + sLineBreak + 'nosso_numero=' +
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.NossoNumero +
              sLineBreak + 'seu_numero=' + Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.SeuNumero + sLineBreak + 'especie=' +
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.EspecieDoc +
              sLineBreak + 'codigo_barras=' + Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.CodBarras + sLineBreak +
              'numero_linha_digitavel=' + Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.LinhaDig + sLineBreak + 'local_pagamento=' +
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.Mensagem.Text +
              sLineBreak + 'data_processamento=' + FormatDateTime('dd/mm/yyyy',
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.DataProcessamento) +
              sLineBreak + 'data_emissao=' + FormatDateTime('dd/mm/yyyy',
              Boleto.ListaRetornoWeb[i].DadosRet.TituloRet.DataDocumento) +
              sLineBreak + 'uso_banco=' + Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.UsoBanco + sLineBreak + 'valor_titulo=' +
              CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorDocumento) + sLineBreak +
              'valor_desconto=' + CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorDesconto) + sLineBreak +
              'valor_outra_deducao=' + CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorDespesaCobranca) + sLineBreak +
              'valor_juro_multa=' + CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorMoraJuros) + sLineBreak +
              'valor_outro_acrescimo=' + CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorOutrosCreditos) + sLineBreak +
              'valor_total_cobrado=' + CurrToStr(Boleto.ListaRetornoWeb[i]
              .DadosRet.TituloRet.ValorPago) + sLineBreak +
              'texto_informacao_cliente_beneficiario=' + Boleto.ListaRetornoWeb
              [i].DadosRet.TituloRet.Informativo.Text);

          end;
        end;
        SLRemessa.SaveToFile(PathWithDelim(ExtractFilePath(Application.ExeName))
          + 'Boleto\RetornoRegistro.txt');
      finally
        SLRemessa.Free;
      end;
    end;
    Result := true;
  except
    on e: Exception do
    begin
      Application.MessageBox(pchar('Falha ao registrar Boleto.' + sLineBreak +
        'Falha: ' + sLineBreak + e.Message), 'Boleto', MB_OK + MB_ICONERROR);
    end;
  end;
end;

function TDados.ValidaGTIN(AGTIN: string): boolean;
var
  i, soma, resultado, base10: Integer;
begin
  // Verifica se todos os caracteres de AGTIN são números
  for i := 1 to Length(AGTIN) do
    if not(AGTIN[i] in ['0' .. '9']) then
    begin
      Result := False;
      Exit;
    end;
  // Verifica se AGTIN tem o tamanho necessário
  if Length(AGTIN) in [8, 12, 13, 14] then
  begin
    soma := 0;
    for i := 1 to (Length(AGTIN) - 1) do
    begin
      if Length(AGTIN) = 13 then
      begin
        if Odd(i) then
          soma := soma + (strToint(AGTIN[i]) * 1)
        else
          soma := soma + (strToint(AGTIN[i]) * 3);
      end
      else
      begin
        if Odd(i) then
          soma := soma + (strToint(AGTIN[i]) * 3)
        else
          soma := soma + (strToint(AGTIN[i]) * 1);
      end;
    end;
    base10 := soma;
    // Verifica se base10 é múltiplo de 10
    if not(base10 mod 10 = 0) then
    begin
      while not(base10 mod 10 = 0) do
      begin
        base10 := base10 + 1;
      end;
    end;
    resultado := base10 - soma;
    // Verifica se o resultado encontrado é igual ao caractere de controle
    if resultado = strToint(AGTIN[Length(AGTIN)]) then
      Result := true
    else
      Result := False;
  end
  else
    Result := False;
end;

function TDados.TBRound(Value: Extended; Decimals: Integer): Extended;
var
  Factor, Fraction: Extended;
begin
  Factor := IntPower(10, Decimals);
  Value := StrToFloat(FloatToStr(Value * Factor));
  Result := Int(Value);
  Fraction := Frac(Value);
  if Fraction >= 0.5 then
    Result := Result + 1
  else if Fraction <= -0.5 then
    Result := Result - 1;
  Result := Result / Factor;
end;

function TDados.EhSoNumero(fField: string): boolean;
var
  i: Byte;
begin
  Result := true;
  for i := 1 To Length(fField) do
  begin
    if not(fField[i] In ['0' .. '9']) Then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TDados.VerificaCodigoVenda(codigo: Integer): Boolean;
begin
  qryConsulta.Close;
  qryConsulta.SQL.Text := 'SELECT CODIGO FROM VENDAS_MASTER WHERE SITUACAO=''F''AND CODIGO = :CODIGO';
  qryConsulta.ParamByName('CODIGO').AsInteger := codigo;
  qryConsulta.Open;
  Result := not qryConsulta.IsEmpty;
end;


end.
