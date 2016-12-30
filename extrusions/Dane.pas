unit Dane;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Math, Menus, jpeg, Grids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    RadioGroup1: TRadioGroup;
    Label5: TLabel;
    Button1: TButton;
    Edit7: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    ComboBox1: TComboBox;
    Image1: TImage;
    ComboBox2: TComboBox;
    Label15: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label20: TLabel;
    Label27: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var    {zmienne globalne}
  Form1: TForm1;
  n : Integer ;
  dw, dk, hw, Dkr, Pw, Pd, g, r1, r2, Rt: Real;    {typ zmiennoprzecinkowy}
implementation

uses Wyniki;

{$R *.dfm}

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin                   {procedura wyboru materia³u (stal lub inne materia³y)}
case RadioGroup1.ItemIndex of
 0:
 begin
 ComboBox2.Visible := False;   {wyswietla listê wyboru rodzajów stali}
 ComboBox1.Visible := True;
 ComboBox1.Text:= 'Wybierz materia³';
 Edit7.Text:= '0'
 end;
 1:
 begin
 ComboBox1.Visible := False;
 ComboBox2.Visible := True;    {wyswietla listê wyboru rodzajów innych metali}
 ComboBox2.Text:= 'Wybierz materia³';
 Edit7.Text:= '0'
 end;
end;
end;
procedure TForm1.ComboBox1Change(Sender: TObject);
begin            {wstawia wartosc Rt w zale¿nosci od wybranej stali}
case ComboBox1.ItemIndex of
0: Edit7.Text :='280';
1: Edit7.Text :='350';
2: Edit7.Text :='450';
3: Edit7.Text :='530';
4: Edit7.Text :='540';
5: Edit7.Text :='350';
6: Edit7.Text :='470';
7: Edit7.Text :='500';
end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin      {wstawia wartosc Rt w zale¿nosci od wybranego materia³u}
case ComboBox2.ItemIndex of
0: Edit7.Text :='80';
1: Edit7.Text :='130';
2: Edit7.Text :='170';
3: Edit7.Text :='240';
4: Edit7.Text :='280';
5: Edit7.Text :='420';

end;
end;
procedure TForm1.Button1Click(Sender: TObject); {obliczenia}
var
k, z : Real ;
I : Integer;
d : array [0..5] of Real;
m, h, eps, epsc : array [1..5] of Real;
begin

 begin
  begin
    Try              {procedura obs³ugi wyj¹tku dla liczb zmiennoprzecinkowych}
      StrToFloat(Edit1.Text);
      StrToFloat(Edit2.Text);
      StrToFloat(Edit3.Text);
      StrToFloat(Edit4.Text);
      StrToFloat(Edit5.Text);
      StrToFloat(Edit6.Text);
    except
      begin
       MessageBox(0,'WprowadŸ liczbê!', 'B³¹d wartosci',MB_OK);
       exit;
      end;
  end;
 end;

begin
dw := StrToFloat(Edit1.Text);
dk := StrToFloat(Edit2.Text);
hw := StrToFloat(Edit3.Text);
r1 := StrToFloat(Edit4.Text);
r2 := StrToFloat(Edit5.Text);
g := StrToFloat(Edit6.Text);
Rt := StrToFloat(Edit7.Text);
  begin
   if (dw<0)or (dk<0) or (hw < 0) or (r1<0) or (r2<0) or (g<0)or (Rt<0) then    {sprawdzenie czy wprowadzono liczby dodatnie}
   begin
   MessageBox(0,'WprowadŸ liczbê dodatni¹!', 'B³¹d wartosci',MB_OK);
   exit;
   end;
   if  (dw=0)or (dk=0) or (hw = 0) then
   begin
   MessageBox(0,'WprowadŸ liczbê wiêksz¹ od zera!', 'B³¹d wartosci',MB_OK);
   exit;
   end;
   if dw>dk then
   begin
   MessageBox(0,'Srednica ko³nierza musi byc wiêksza od srednicy wytloczki! Zmieñ dane', 'B³¹d wartosci',MB_OK);
   exit;
   end;
    begin
  if (RadioGroup1.ItemIndex <> 0) and(RadioGroup1.ItemIndex <> 1)  then      {obs³uga wyboru materia³u}
  begin
  MessageBox(0,'Wybierz  rodzaj materia³u!', 'Uzupe³nij dane',MB_OK);
  exit;
  end;
  begin
  if ((ComboBox1.ItemIndex >7)or(ComboBox1.ItemIndex <0)) and (RadioGroup1.ItemIndex = 0 )  then
  begin
  MessageBox(0,'Wybierz gatunek stali!', 'Uzupe³nij dane',MB_OK);
  exit;
  end;
  if ((ComboBox2.ItemIndex >5)or(ComboBox2.ItemIndex <0)) and (RadioGroup1.ItemIndex = 1)then
  begin
  MessageBox(0,'Wybierz materia³!', 'Uzupe³nij dane',MB_OK);
  exit;
  end;
  end;
  end;
  end;
Dkr := power(((dk*dk)-(2.28*r1*dw)-(0.56*r1*r1)+(4*dw*hw)-(1.72*r2*dw)+(0.55*r2*r2)),0.5);  {srednica kr¹¿ka}
Pw := 1.2*pi*g*Dkr*Rt  ;  {si³a wykrawania}
k:= (g/Dkr)*100;
 begin
 if (k<=0.06) then     {przypisanie wartosci m w zale¿nosci od stosunku g/D}
  begin
  m[1]:= 0.6;
  m[2]:= 0.8;
  m[3]:= 0.82;
  m[4]:= 0.84;
  m[5]:= 0.86;
  end;
 if (k>=0.06) and (k<0.2) then
  begin
  m[1]:= 0.6;
  m[2]:= 0.8;
  m[3]:= 0.82;
  m[4]:= 0.84;
  m[5]:= 0.86;
  end;
 if (k>=0.2) and (k<0.5) then
  begin
  m[1]:= 0.57;
  m[2]:= 0.78;
  m[3]:= 0.80;
  m[4]:= 0.83;
  m[5]:= 0.85;
  end;
 if (k>=0.5) and (k<1) then
  begin
  m[1]:= 0.55;
  m[2]:= 0.76;
  m[3]:= 0.79;
  m[4]:= 0.82;
  m[5]:= 0.84;
  end;
 if (k>=1) and (k<1.5) then
  begin
  m[1]:= 0.53;
  m[2]:= 0.75;
  m[3]:= 0.78;
  m[4]:= 0.80;
  m[5]:= 0.82;
  end;
 if (k>=1.5) and (k<2) then
  begin
  m[1]:= 0.51;
  m[2]:= 0.73;
  m[3]:= 0.75;
  m[4]:= 0.78;
  m[5]:= 0.80;
  end;
 if (k>=2)  then
  begin
  m[1]:= 0.46;
  m[2]:= 0.7;
  m[3]:= 0.72;
  m[4]:= 0.74;
  m[5]:= 0.78;
  end;
  begin
  Form1.Visible := false;{ukrywa okno z danymi}
  Form2:= Tform2.Create(self); {Tworzy now¹ formatkê z wynkami obliczeñ}
   begin
   Form2.Wyniki.Cells[0,0] := 'Numer operacji';
   Form2.Wyniki.Cells[1,0] := 'm_n';
   Form2.Wyniki.Cells[2,0] := 'd_n';
   Form2.Wyniki.Cells[3,0] := 'h_n';
   Form2.Wyniki.Cells[4,0] := 'eps';
   Form2.Wyniki.Cells[5,0] := 'eps_1,n';
   Form2.Wyniki.Cells[6,0] := '(g/d_n-1)100';
   Form2.Wyniki.Cells[7,0] := 'Dociskacz';
    begin
     z:= (dw/Dkr);  {stosunek srednicy gotowego naczynia do srednicy kra¿ka}
     d[0]:= Dkr;
     if z >= m[1] then         {warunek na ilosc operacji}
      begin
      n:=1;
      m[1]:= z;
      d[1]:= dw
      end
      else
       begin
       if z>= m[1]*m[2] then
        begin
        n:=2;
        m[1]:= z/m[2];
        d[2]:= dw;
        d[1]:= d[2]/m[2];
        end
        else
         begin
         if z>= m[1]*m[2]*m[3] then
          begin
          n:=3;
          m[1]:= z/(m[2]*m[3]);
          d[3]:= dw;
          d[2]:= d[3]/m[3];
          d[1]:= d[2]/m[2];
          end
          else
           begin
           if z>= m[1]*m[2]*m[3]*m[4] then
            begin
            n:=4;
            m[1]:= z/(m[2]*m[3]*m[4]);
            d[4]:= dw;
            d[3]:= d[4]/m[4];
            d[2]:= d[3]/m[3];
            d[1]:= d[2]/m[2];
            end
            else
             begin
             if z>= m[1]*m[2]*m[3]*m[4]*m[5] then
              begin
              n:=5;
              m[1]:= z/(m[2]*m[3]*m[4]*m[5]);
              d[5]:= dw;
              d[4]:= d[5]/m[5];
              d[3]:= d[4]/m[4];
              d[2]:= d[3]/m[3];
              d[1]:= d[2]/m[2];
              end
              else
               begin
               Form2.Close;
               MessageBox(0,'Wymagane jest wiêcej ni¿ 5 operacji ci¹gnienia! Zmieñ dane', 'Uwaga',MB_OK);
               exit;
               end;
             end;
           end;
         end;
       end;
     begin
     if k<= 5*(1-m[1])then
     Form2.Wyniki.Cells[7,1]:= 'Potrzebny'      {Warunek na dociskacz w pierwszej operacji}
     else
     Form2.Wyniki.Cells[7,1]:= 'Niepotrzebny'
     end;
    for i:=1 to n do
     begin
     h[i] := ((Dkr*Dkr)-((dk*dk)-(2.28*r1*d[i])-(0.56*r1*r1)-(1.72*r2*d[i])+(0.55*r2*r2)))/(4*d[i]);
     h[n] := hw;
     eps[i]:= ln(1/m[i]);
     epsc[i]:= ln(Dkr/d[i]);
     Form2.Wyniki.RowCount := (n+1);
     Form2.Wyniki.Cells[0,i]:= IntToStr(i);
     Form2.Wyniki.Cells[1,i]:= FloatToStr(RoundTo(m[i],-2));
     Form2.Wyniki.Cells[2,i]:= FloatToStr(RoundTo(d[i],0));
     Form2.Wyniki.Cells[3,i]:= FloatToStr(RoundTo(h[i],0));
     Form2.Wyniki.Cells[4,i]:= FloatToStr(RoundTo(eps[i],-2));
     Form2.Wyniki.Cells[5,i]:= FloatToStr(RoundTo(epsc[i],-2));
     Form2.Wyniki.Cells[6,i]:= FloatToStr(RoundTo((g/d[i-1])*100,-2));

     end;
     begin
     for i:=1 to n do         {warunek na dociskacz w kolejnych operacjach przet³aczania}
     begin
     if (g/d[i-1])*100 >1/m[i] then
     Form2.Wyniki.Cells[7,i] := 'Niepotrzebny'
     else
     Form2.Wyniki.Cells[7,i] := 'Potrzebny'
     end;
     end;
   Form2.Label2.Caption :=  'Œrednica kr¹¿ka D = '+FloatToStr(RoundTo(Dkr,-2))+' mm';
   Form2.Label3.Caption :=  'Si³a wykrawania P = '+FloatToStr(RoundTo(Pw/1000,0))+' kN';
   Form2.Label4.Caption :=  'Ilosc operacji n = '+ IntToStr(n);
   end;
  Form2.ShowModal; {wyswietla now¹ formatkê}
  Form2.Free;  {zwalnia komponent}
  end;
end;

end;
end;
end;
end;
end.
