Unit Unit1;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, Unit2;

Type
  TMine = Record
    bomb, flag: Boolean;
    counter: Integer;
  End;
  TArray = Array[1..8, 1..8] Of TMine;

  { TForm1 }

  TForm1 = Class(TForm)
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
    Procedure CheckBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure PaintBox1Paint(Sender: TObject);
    Procedure Timer1Timer(Sender: TObject);

  Private
    { private declarations }
  Public
    { public declarations }
  End;

Var
  Form1: TForm1;
  gameArray: TArray;
  Seconds, flags: Integer;

Implementation

{$R *.lfm}

{ TForm1 }

Procedure TForm1.MenuItem2Click(Sender: TObject);
Begin
  Application.Terminate;
End;

Procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  bmFlag: TBitmap;
  i, j, n, p: Integer;
Begin
  If (ssRight In Shift) And (flags > 0) Then
  Begin
    If Label5.Visible = True Then
    Begin
      Timer1.Enabled := True;
    End;
    bmFlag := TBitmap.Create;
    bmFlag.LoadFromFile('flag.bmp');
    i := x Div 50;
    j := y Div 50;
    n := 50 * i;
    p := 50 * j;
    CheckBox1.Visible := False;
    PaintBox1.Canvas.Draw(n, p, bmFlag);
    bmFlag.Free;
    flags := flags - 1;
    Label4.Caption := IntToStr(flags);
  End;
End;

Procedure TForm1.FormCreate(Sender: TObject);
Var
  x, y, b, m, n: Integer;
Begin
  Seconds := 150;
  Timer1.Enabled := False;
  Label5.Caption := '02:30';
  flags := 10;
  b := 0;
  For x := 1 To 8 Do  // Inicializa bombs false
  Begin
    For y := 1 To 8 Do
    Begin
      gameArray[x, y].bomb := False;
    End;
  End;
  Repeat  // Coloca 10 bombs aleatoriamente
    Begin
      Randomize;
      x := Random(9);
      y := Random(9);
      If Not gameArray[x, y].bomb And (x <> 0) And (y <> 0) Then
      Begin
        gameArray[x, y].bomb := True;
        b := b + 1;
      End;
    End;
  Until b = 10;
  For x := 1 To 8 Do  // Inicializa counters 0
  Begin
    For y := 1 To 8 Do
    Begin
      If gameArray[x, y].bomb = True Then
      Else
        gameArray[x, y].counter := 0;
    End;
  End;
  For x := 1 To 8 Do  // colocar os counter nas casas sem bomba
  Begin
    For y := 1 To 8 Do
    Begin
      If gameArray[x, y].bomb = True Then
      Else If gameArray[x, y].bomb = False Then
      Begin
        For m := -1 To 1 Do
        Begin
          For n := -1 To 1 Do
          Begin
            If (gameArray[x + m, y + n].bomb = True) And (x + m >= 1) And
              (x + m <= 8) And (y + n >= 1) And (y + n <= 8) Then
              gameArray[x, y].counter := gameArray[x, y].counter + 1;
          End;
        End;
      End;
    End;
  End;
End;

Procedure TForm1.CheckBox1Change(Sender: TObject);
Begin
  If Label5.Visible = True Then
  Begin
    Label5.Visible := False;
  End
  Else
  Begin
    Label5.Visible := True;
  End;
  If Label6.Visible = True Then
    Label6.Visible := False
  Else
    Label6.Visible := True;
End;

Procedure TForm1.MenuItem10Click(Sender: TObject);
Begin
  Form2.ShowModal;
End;

Procedure TForm1.PaintBox1Paint(Sender: TObject);
Var
  Bitmap, bmBomb: TBitmap;
  rectangleHeight, rectangleWidth, i, j, n, p: Integer;
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
      Bitmap.Canvas.Brush.Color := clWhite; //Brush color
      rectangleHeight := 50;
      rectangleWidth := 50;
      Bitmap.Canvas.Rectangle(i * rectangleWidth + 1, j * rectangleHeight + 1,
        i * rectangleWidth + rectangleWidth - 1, j * rectangleHeight +
        rectangleHeight - 1);
      //Write some text, in this case an *
      //Define Font properties
      Bitmap.Canvas.Font.Name := 'Liberation Mono';
      Bitmap.Canvas.Font.Style := [fsBold];
      Bitmap.Canvas.Font.Size := 10;
      Bitmap.Canvas.Font.Color := clBlack;
      //Write the text
       If gameArray[i + 1, j + 1].bomb Then
      Begin
        bmBomb := TBitmap.Create;
        bmBomb.LoadFromFile('bomb.bmp');
        n := 50 * i;
        p := 50 * j;
        Bitmap.Canvas.Draw(n, p, bmBomb);
        bmBomb.Free;
      End
      Else
        Bitmap.Canvas.TextOut(i * rectangleWidth + rectangleWidth Div
          2, j * rectangleHeight + rectangleHeight Div 3,
          IntToStr(gameArray[i + 1, j + 1].counter));
    End;
  End;
  PaintBox1.Canvas.Draw(0, 0, Bitmap);
  Bitmap.Free; //Free the memory used by the object Bitmap
End;

Procedure TForm1.Timer1Timer(Sender: TObject);
Var
  Min, Sec: String;
Begin
  If Seconds = 0 Then
  Begin
    Timer1.Enabled := False;
    ShowMessage('Time is up!');
  End
  Else
  Begin
    Dec(Seconds);
    Min := IntToStr(Seconds Div 60);
    Sec := IntToStr(Seconds Mod 60);
    If Length(Min) = 1 Then
      Min := '0' + Min;
    If Length(Sec) = 1 Then
      Sec := '0' + Sec;
    Label5.Caption := Min + ':' + Sec;
  End;
End;

End.
