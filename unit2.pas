Unit Unit2;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

Type

  { TForm2 }

  TForm2 = Class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PaintBox1: TPaintBox;
    Procedure PaintBox1Paint(Sender: TObject);
  Private
    { private declarations }
  Public
    { public declarations }
  End;

Var
  Form2: TForm2;

Implementation

{$R *.lfm}

{ TForm2 }

Procedure TForm2.PaintBox1Paint(Sender: TObject);
Var
  bmLogo: TBitmap;
Begin
  bmLogo := TBitmap.Create;
  bmLogo.LoadFromFile('logo.bmp');
  PaintBox1.Canvas.Draw(0, 0, bmLogo);
  bmLogo.Free;
End;

End.
