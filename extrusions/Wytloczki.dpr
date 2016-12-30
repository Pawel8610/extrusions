program Wytloczki;

uses
  Forms,
  Dane in 'Dane.pas' {Form1},
  Wyniki in 'Wyniki.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
