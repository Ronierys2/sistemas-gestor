unit uConexaoBD;

interface //Suporte e Vendas direto no Whatsapp (48)998463846

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmConexaoBD = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConexaoBD: TfrmConexaoBD;

implementation //Acesse lojadodesenvolvedor.com.br e saiba mais sobre esse código fonte.

{$R *.dfm}

procedure TfrmConexaoBD.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_f4 then
    abort;
end;

procedure TfrmConexaoBD.FormShow(Sender: TObject);
begin
 //Label1.Caption :='Aguarde...'+sLineBreak+'Tentando conectar ao Banco de Dados.';
 //Label1.Repaint;
 //Label1.Refresh;
end;

end.
