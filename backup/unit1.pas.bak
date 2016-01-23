Unit Unit1;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, Unit2;

Type

  { TForm1 }

  TForm1 = Class(TForm)
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure MenuItem5Click(Sender: TObject);
    Procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  Private
    Seconds: integer;
    { private declarations }
  Public
    { public declarations }
  End;

Var
  Form1: TForm1;

Implementation

{$R *.lfm}

{ TForm1 }

Procedure TForm1.MenuItem2Click(Sender: TObject);
Begin
  Application.Terminate;
End;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Seconds := 600;
  Timer1.Enabled := False;
  Label5.Caption := '10:00';
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  If Label5.Visible = True Then
    Begin
    Timer1.Enabled := False;
    Label5.Visible := False;
    end
  Else
  Begin
    Timer1.Enabled := True;
    Label5.Visible := True;
  end;
  If Label6.Visible = True Then
    Label6.Visible := False
  Else
    Label6.Visible := True;
end;

Procedure TForm1.MenuItem10Click(Sender: TObject);
Begin
  Form2.ShowModal;
End;

Procedure TForm1.PaintBox1Paint(Sender: TObject);
Var
  Bitmap: TBitmap;
  rectangleHeight, rectangleWidth, i, j: Integer;
Begin
  Bitmap := TBitmap.Create;
  // Initializes the Bitmap Size
  Bitmap.Height := PaintBox1.Height;
  Bitmap.Width := PaintBox1.Width;
  //Draw the background in white
  Bitmap.Canvas.Pen.Color := clWhite; //Line Color
  Bitmap.Canvas.Brush.Color := clWhite; //Fill Color
  Bitmap.Canvas.Rectangle(0, 0, PaintBox1.Width, PaintBox1.Height);
  // Draws squares
  For i := 0 To 7 Do
  Begin
    For j := 0 To 7 Do
    Begin
      Bitmap.Canvas.Pen.Color := clBlack; //Line Color
      Bitmap.Canvas.Brush.Color := clYellow; //Brush color
      rectangleHeight := PaintBox1.Height Div 8;
      rectangleWidth := PaintBox1.Width Div 8;
      Bitmap.Canvas.Rectangle(i * rectangleWidth + 1, j * rectangleHeight + 1,
        i * rectangleWidth + rectangleWidth - 1, j * rectangleHeight + rectangleHeight - 1);
      //Write some text, in this case an *
      //Define Font properties
      Bitmap.Canvas.Font.Name := 'Liberation Mono';
      Bitmap.Canvas.Font.Style := [fsBold];
      Bitmap.Canvas.Font.Size := 10;
      Bitmap.Canvas.Font.Color := clBlack;
      //Write the text
      Bitmap.Canvas.TextOut(i * rectangleWidth + rectangleWidth Div
        2, j * rectangleHeight + rectangleHeight Div 3, '*');
    End;
  End;
  PaintBox1.Canvas.Draw(0, 0, Bitmap);
  Bitmap.Free; //Free the memory used by the object Bitmap
End;


procedure TForm1.Timer1Timer(Sender: TObject);
var Min, Sec: string;
begin
  if Seconds = 0 then begin
    Timer1.Enabled := False;
    ShowMessage('Done!');
  end
  else begin
    dec(Seconds);
    Min := IntToStr(Seconds div 60); // integer division
    Sec := IntToStr(Seconds mod 60); // remainder
    if Length(Min) = 1 then Min := '0' + Min;
    if Length(Sec) = 1 then Sec := '0' + Sec;
    Label5.Caption := Min + ':' + Sec;
  end;
end;



End.
