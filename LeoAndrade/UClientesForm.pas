unit UClientesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase,

  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessageClient,
  IdSMTPBase,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdAttachment, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edtNome: TEdit;
    edtIdentidade: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtCpf: TEdit;
    Label4: TLabel;
    edtTelefone: TEdit;
    Label5: TLabel;
    edtEmail: TEdit;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    edtCEP: TEdit;
    Label7: TLabel;
    edtLogradouro: TEdit;
    Label8: TLabel;
    edtNumero: TEdit;
    Label9: TLabel;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtCidade: TEdit;
    Label12: TLabel;
    edtUF: TEdit;
    edtPais: TEdit;
    Label13: TLabel;
    Enviar: TButton;
    IdSMTP1: TIdSMTP;
    IdSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure edtCEPExit(Sender: TObject);
    procedure EnviarClick(Sender: TObject);
  private
    procedure consultarCep(Cep:string);
    procedure EnviarEmail();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UDMViaCep;

procedure TForm1.consultarCep(Cep: string);
begin
  DMViaCep.RESTClient1.BaseURL:='https://viacep.com.br/ws/'+cep+'/json';
  DMViaCep.RESTRequest1.Execute;
end;

procedure TForm1.edtCEPExit(Sender: TObject);
begin

  consultarCep(edtCep.Text);

  edtLogradouro.Text  := DMViaCep.FDMemTable1.FieldByName('logradouro').AsString; //CEP.GetLogradouro;
  edtBairro.Text      := DMViaCep.FDMemTable1.FieldByName('bairro').AsString;
  edtCidade.Text      := DMViaCep.FDMemTable1.FieldByName('localidade').AsString;
  edtUF.Text          := DMViaCep.FDMemTable1.FieldByName('uf').AsString;

  if pos(edtUF.Text , 'AC,AL,AP,AM,BA,CE,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,SP,RJ,RN,RS,RO,RR,SC,SP,SE,TO,DF') > 0 then
    edtPais.Text := 'BRASIL';

end;

procedure TForm1.EnviarClick(Sender: TObject);
var I:Integer;
begin
  EnviarEmail();

  // Limpa todos os campos de edição
  for I := 0 to ComponentCount-1 do
    if Components[i] is TEdit then
      TEdit(Components[i]).Clear;

  edtNome.SetFocus;

end;

procedure TForm1.EnviarEmail();
var
  smtp: TIdSMTP;
  IdMessage: TIdMessage;
  Anexo: TIdAttachment;
  sNomeArquivoXmlCadastro: String;

  procedure SalvaXml;
  var
    XMLDocument: TXMLDocument;
    NodeTabela, NodeRegistro, NodeEndereco: IXMLNode;
    I: Integer;
  begin
    XMLDocument := TXMLDocument.Create(Self);
    try
      XMLDocument.Active := True;
      NodeTabela := XMLDocument.AddChild('Cliente');

      NodeRegistro := NodeTabela.AddChild('Registro');
      NodeRegistro.ChildValues['Nome'] := 'Nome: ' + edtNome.Text;
      NodeRegistro.ChildValues['Identidade'] := 'Identidade: ' +
        edtIdentidade.Text;
      NodeRegistro.ChildValues['Cpf'] := 'Cpf: ' + edtCpf.Text;
      NodeRegistro.ChildValues['Telefone'] := 'Telefone: ' + edtTelefone.Text;
      NodeRegistro.ChildValues['Email'] := 'Email: ' + edtEmail.Text;
      NodeEndereco := NodeRegistro.AddChild('Endereco');
      NodeEndereco.ChildValues['CEP'] := edtCEP.Text;
      NodeEndereco.ChildValues['Logradouro'] := edtLogradouro.Text;
      NodeEndereco.ChildValues['Numero'] := edtNumero.Text;
      NodeEndereco.ChildValues['Complemento'] := edtComplemento.Text;
      NodeEndereco.ChildValues['Bairro'] := edtBairro.Text;
      NodeEndereco.ChildValues['Cidade'] := edtCidade.Text;
      NodeEndereco.ChildValues['Estado'] := edtUF.Text;
      NodeEndereco.ChildValues['Pais'] := edtPais.Text;

      sNomeArquivoXmlCadastro := ExtractFilePath(Application.ExeName) +
        '\Cadastro.xml';
      XMLDocument.SaveToFile(sNomeArquivoXmlCadastro);
    finally
      XMLDocument.Free;
    end;
  end;

begin

  SalvaXml;

  smtp := TIdSMTP.Create(nil);
  IdMessage := TIdMessage.Create(nil);
  try
    with IdMessage do
    begin
      From.Name := 'Leonardo Andrade';
      From.Address := 'leonardo.andrade@hotmail.com';
      Recipients.EMailAddresses := 'leonardo.andrade@hotmail.com';
      Priority := mpHighest;
      Subject := 'Teste Leonardo Andrade';
      smtp.Host := 'smtp.live.com';
      smtp.Port := 465;
      smtp.Username := 'leonardo.andrade@hotmail.com';
      smtp.Password := 'Lca230949@';
    end;
    with smtp do
    begin
      try
        IOHandler := IdSSL;
        UseTLS := utUseExplicitTLS;
      except
        on E: Exception do
        begin
          IOHandler := TIdIOHandler.MakeDefaultIOHandler(nil);
          UseTLS := utNoTLSSupport;
        end;
      end;
      if Assigned(IdSSL) then
      begin
        IdSSL.SSLOptions.Method := sslvSSLv23;
        IdSSL.SSLOptions.Mode := sslmClient;
      end;
      AuthType := satDefault;
    end;
    with TIdText.Create(IdMessage.Messageparts) do
    begin
      Body.Text := 'Teste Leonardo Andrade';
      ContentTransfer := '7bit';
      ContentType := 'text/plain';
    end;
    with TIdText.Create(IdMessage.Messageparts) do
    begin
      ContentType := 'multipart/related';
      Body.Clear;
    end;
    with TIdText.Create(IdMessage.Messageparts) do
    begin
      Body.Clear;
      ContentType := 'text/html';
      CharSet := 'UTF-8';
      Body.Add('<html>');
      Body.Add('<meta charset="utf-8">');
      Body.Add('<BODY>');
      Body.Add('<div style = "width: 700px; text-align: left;">');
      Body.Add('<BR><BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Nome: '
        + PChar(edtNome.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Identidade: '
        + PChar(edtIdentidade.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Cpf: '
        + PChar(edtCpf.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Telefone: '
        + PChar(edtTelefone.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">E-mail: '
        + PChar(edtEmail.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">CEP: '
        + PChar(edtCEP.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Logradouro: '
        + PChar(edtLogradouro.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Número: '
        + PChar(edtNumero.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Complemento: '
        + PChar(edtComplemento.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Bairro: '
        + PChar(edtBairro.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">Cidade: '
        + PChar(edtCidade.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">UF: '
        + PChar(edtUF.Text) + '</FONT> <BR>');
      Body.Add('<BR> <FONT style= "font-size: 12px; color: #190707; font-family: Arial, Sans-Serif;">País: '
        + PChar(edtPais.Text) + '</FONT> <BR>');
      Body.Add('</div>');
      Body.Add('</BODY>');
      ContentTransfer := '7bit';
      ContentType := 'text/html';
      ParentPart := 1;
    end;

    if FileExists(sNomeArquivoXmlCadastro) then
    begin
      TIdAttachmentFile.Create(IdMessage.Messageparts, sNomeArquivoXmlCadastro);
    end;
    smtp.Connect;
    smtp.Authenticate;
    smtp.Send(IdMessage);
    smtp.Disconnect;

    Screen.Cursor := crDefault;
    ShowMessage('Cadastro realizado com sucesso!');

  except
    on E: Exception do
      MessageDlg('Erro na tentativa de enviar o cadastro, motivo: ' + E.Message,
        mtInformation, [mbOk], 0);
  end;
  FreeAndNil(smtp);
  FreeAndNil(IdMessage);
end;

end.
