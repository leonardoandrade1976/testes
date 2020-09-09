program TesteLeonardo;

uses
  Vcl.Forms,
  UClientesForm in 'UClientesForm.pas' {Form1},
  UDMViaCep in 'UDMViaCep.pas' {DMViaCep: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMViaCep, DMViaCep);
  Application.Run;
end.
