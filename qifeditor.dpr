program qifeditor;

uses
  Vcl.Forms,
  xdataedit in 'xdataedit.pas' {Form2},
  xdatatransaction in 'xdatatransaction.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'QIF Editor';
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
