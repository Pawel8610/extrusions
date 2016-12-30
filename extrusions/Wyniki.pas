unit wyniki;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, jpeg ;

type
  TForm2 = class(TForm)
    Wyniki: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Dane;


{$R *.dfm}


procedure TForm2.Button1Click(Sender: TObject);
begin
form2.Close ;
Form1.Visible := true;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
form2.close;
form1.close;
end;


end.
