program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  DumpHEX in 'DumpHEX.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
