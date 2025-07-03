unit uFormMensagem;

interface

  uses
  System.Classes, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Winapi.Windows, Vcl.Graphics;

type
  TFormMensagem = class(TForm)
  private
    procedure FormMensagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  public
    class procedure MostrarMensagem(const AMensagem: string);
  end;

implementation

{ TFormMensagem }

uses uPDV;

procedure TFormMensagem.FormMensagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close; // Fecha o formul�rio ao pressionar ESC
end;

class procedure TFormMensagem.MostrarMensagem(const AMensagem: string);
var
  FormMensagem: TFormMensagem;
  LabelTitulo, LabelMensagem, LabelAviso: TLabel;
begin
  // Cria��o do formul�rio tempor�rio
  FormMensagem := TFormMensagem.CreateNew(nil);
  try
    // Configura��o do formul�rio
    FormMensagem.Position := poScreenCenter;
    FormMensagem.BorderStyle := bsDialog;
    FormMensagem.Caption := 'Aviso Importante';
    FormMensagem.Width := 450; // Largura
    FormMensagem.Height := 220; // Altura reduzida para centralizar melhor
    FormMensagem.Color := clWhite; // Fundo branco
    FormMensagem.KeyPreview := True;
    FormMensagem.OnKeyDown := FormMensagem.FormMensagemKeyDown;

    // Adiciona o T�tulo
    LabelTitulo := TLabel.Create(FormMensagem);
    LabelTitulo.Parent := FormMensagem;
    LabelTitulo.Caption := 'PRODUTO N�O ENCONTRADO';
    LabelTitulo.Alignment := taCenter;
    LabelTitulo.Font.Size := 14; // Tamanho maior
    LabelTitulo.Font.Style := [fsBold]; // Negrito
    LabelTitulo.SetBounds(10, 20, FormMensagem.ClientWidth - 20, 30);

    // Adiciona a Mensagem Principal
    LabelMensagem := TLabel.Create(FormMensagem);
    LabelMensagem.Parent := FormMensagem;
    LabelMensagem.Font.Size := 10;
    LabelMensagem.Caption := 'O c�digo do produto informado n�o est� cadastrado no sistema.';
    LabelMensagem.Alignment := taCenter;
    LabelMensagem.AutoSize := False;
    LabelMensagem.WordWrap := True;
    LabelMensagem.SetBounds(10, 60, FormMensagem.ClientWidth - 20, 60); // Ajuste na altura

    // Adiciona o Aviso de Fechamento
    LabelAviso := TLabel.Create(FormMensagem);
    LabelAviso.Parent := FormMensagem;
    LabelAviso.Caption := 'Pressione ESC para fechar esta mensagem.';
    LabelAviso.Alignment := taCenter;
    LabelAviso.Font.Style := [fsItalic];
    LabelAviso.Font.Color := clGray;
    LabelAviso.SetBounds(10, 140, FormMensagem.ClientWidth - 20, 30); // Mais pr�ximo da mensagem principal

    // Exibe o formul�rio modal
    FormMensagem.ShowModal;
  finally
    FormMensagem.Free; // Libera o formul�rio ap�s o fechamento
  end;
end;



end.

