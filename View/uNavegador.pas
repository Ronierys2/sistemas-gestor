unit uNavegador;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw;

type
  TfrmNavegador = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNavegador: TfrmNavegador;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse código fonte.

{$R *.dfm}

procedure TfrmNavegador.FormShow(Sender: TObject);
begin
 WindowState := wsMaximized;
 WebBrowser1.Navigate('http://www.nfe.fazenda.gov.br/portal/consultaResumoCompletaAntiga.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=');
end;

end.
