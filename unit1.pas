Unit Unit1;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, Unit2, Crt, DefaultTranslator;

Type
  TMine = Record
    bomb, flag, Open: Boolean;
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
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    Procedure CheckBox1Change(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure MenuItem4Click(Sender: TObject);
    Procedure MenuItem9Click(Sender: TObject);
    Procedure CounterCells(i, j: Integer);
    Procedure NewGame();
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

Resourcestring
  wonTime = 'You Won! And you still had left ';
  won = 'You Won!';
  playAgain = 'Want to play again?';
  yes = 'Yes';
  no = 'No';
  lostTime = 'You Lost! You still had ';
  lost = 'You Lost!';
  timesUp = 'Time is up! You Lost!';


Implementation

{$R *.lfm}

{ TForm1 }

Procedure TForm1.MenuItem2Click(Sender: TObject);
Begin
  Application.Terminate; //End game on file - exit.
End;

Procedure TForm1.MenuItem4Click(Sender: TObject);
Begin
  NewGame();       //new game at game-new
End;

Procedure TForm1.MenuItem9Click(Sender: TObject);
Var
  i, j: Integer;
  //set reveal as checked or not and changes to the array.open
Begin
  MenuItem9.Checked := Not MenuItem9.Checked;
  If MenuItem9.Checked = True Then
  Begin
    For i := 1 To 8 Do
    Begin
      For j := 1 To 8 Do
      Begin
        gameArray[i, j].Open := True;
      End;
    End;
  End
  Else If MenuItem9.Checked = False Then
  Begin
    For i := 1 To 8 Do
    Begin
      For j := 1 To 8 Do
      Begin
        gameArray[i, j].Open := False;
      End;
    End;
  End;
  Invalidate;
End;

Procedure TForm1.CounterCells(i, j: Integer);
Var
  m, n: Integer;        //recursive function to open cells around a blank one
Begin
  If (gameArray[i, j].counter = 0) And (gameArray[i, j].Open = False) And
    (gameArray[i, j].flag = False) Then
  Begin
    gameArray[i, j].Open := True;
    For m := -1 To 1 Do
    Begin
      For n := -1 To 1 Do
      Begin
        If (i + m >= 1) And (i + m <= 8) And (j + n >= 1) And (j + n <= 8) Then
          CounterCells(i + m, j + n);
      End;
    End;
  End
  Else If (gameArray[i, j].counter <> 0) And (gameArray[i, j].Open = False) Then
  Begin
    gameArray[i, j].Open := True;
  End;
  Invalidate;
End;

Procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  i, j, flagcount, opencount, a, b: Integer;
  //where all the click, left or right, are processed and subsquent changes to the array
Begin                                                  //victory checks
  If X Mod 50 = 0 Then
    i := X Div 50
  Else
    i := (X Div 50) + 1;
  If Y Mod 50 = 0 Then
    j := Y Div 50
  Else
    j := (Y Div 50) + 1;
  If (ssRight In Shift) Then
  Begin
    If Label5.Visible = True Then
    Begin
      Timer1.Enabled := True;
    End;
    CheckBox1.Visible := False;
    If (gameArray[i, j].flag = False) And (flags > 0) And
      (gameArray[i, j].Open = False) Then
    Begin
      gameArray[i, j].flag := True;
      flags := flags - 1;
      Label4.Caption := IntToStr(flags);
      Invalidate;
      flagcount := 0;
      opencount := 0;
      For a := 1 To 8 Do
      Begin
        For b := 1 To 8 Do
        Begin
          If gameArray[a, b].flag = True Then
          Begin
            flagcount := flagcount + 1;
          End;
        End;
      End;
      For a := 1 To 8 Do
      Begin
        For b := 1 To 8 Do
        Begin
          If gameArray[a, b].Open = False Then
          Begin
            opencount := opencount + 1;
          End;
        End;
      End;
      If opencount = flagcount Then
      Begin
        If Timer1.Enabled = True Then
        Begin
          Timer1.Enabled := False;
          ShowMessage(wonTime + Label5.Caption);
        End
        Else
          ShowMessage(won);
        MenuItem9Click(MenuItem9);
        Invalidate;
        Case QuestionDlg('playAgain', playAgain, mtCustom,
            [mrNo, no, mrYes, yes, 'IsDefault'], '') Of
          mrYes:
          Begin
            NewGame();
          End;
          mrNo: Halt;
          Else
            Halt;
        End;
      End;
    End
    Else If (gameArray[i, j].flag = True) Then
    Begin
      gameArray[i, j].flag := False;
      flags := flags + 1;
      Label4.Caption := IntToStr(flags);
      Invalidate;
    End;
  End
  Else If (ssLeft In Shift) And (gameArray[i, j].flag = False) Then
  Begin
    If Label5.Visible = True Then
    Begin
      Timer1.Enabled := True;
    End;
    CheckBox1.Visible := False;
    If gameArray[i, j].bomb = True Then
    Begin
      gameArray[i, j].Open := True;
      Invalidate;
      If Timer1.Enabled = True Then
      Begin
        Timer1.Enabled := False;
        ShowMessage(lostTime + label5.Caption);
      End
      Else
        ShowMessage(lost);
      MenuItem9Click(MenuItem9);
      Invalidate;
      Case QuestionDlg('playAgain', playAgain, mtCustom,
          [mrNo, no, mrYes, yes, 'IsDefault'], '') Of
        mrYes:
        Begin
          NewGame();
        End;
        mrNo: Halt;
        Else
          Halt;
      End;
    End
    Else If ((gameArray[i, j].counter = 0) Or (gameArray[i, j].counter <> 0)) And
      (gameArray[i, j].Open = False) Then
      CounterCells(i, j);
    flagcount := 0;
    opencount := 0;
    For a := 1 To 8 Do
    Begin
      For b := 1 To 8 Do
      Begin
        If gameArray[a, b].flag = True Then
        Begin
          flagcount := flagcount + 1;
        End;
      End;
    End;
    For a := 1 To 8 Do
    Begin
      For b := 1 To 8 Do
      Begin
        If gameArray[a, b].Open = False Then
        Begin
          opencount := opencount + 1;
        End;
      End;
    End;
    If opencount = flagcount Then
    Begin
      If Timer1.Enabled = True Then
      Begin
        Timer1.Enabled := False;
        ShowMessage(wonTime + Label5.Caption);
      End
      Else
        ShowMessage(won);
      MenuItem9Click(MenuItem9);
      Invalidate;
      Case QuestionDlg('playAgain', playAgain, mtCustom,
          [mrNo, no, mrYes, yes, 'IsDefault'], '') Of
        mrYes:
        Begin
          NewGame();
        End;
        mrNo: Halt;
        Else
          Halt;
      End;
    End;
  End;
End;

Procedure TForm1.NewGame();
Var
  i, j, b, m, n: Integer;
  //Procedure with the on create actions of the form
Begin
  Randomize;
  Seconds := 150;
  Timer1.Enabled := False;
  CheckBox1.Visible := True;
  CheckBox1.Checked := False;
  Label5.Caption := '02:30';
  flags := 10;
  b := 0;
  For i := 1 To 8 Do  // Inicializa bombs false
  Begin
    For j := 1 To 8 Do
    Begin
      gameArray[i, j].bomb := False;
      gameArray[i, j].flag := False;
      gameArray[i, j].Open := False;
    End;
  End;
  Repeat  // Coloca 10 bombs aleatoriamente
    Begin
      i := Random(9);
      j := Random(9);
      If (gameArray[i, j].bomb = False) And (i <> 0) And (j <> 0) Then
      Begin
        gameArray[i, j].bomb := True;
        b := b + 1;
      End;
    End;
  Until b = 10;
  For i := 1 To 8 Do  // Inicializa counters 0
  Begin
    For j := 1 To 8 Do
    Begin
      If gameArray[i, j].bomb = True Then
      Else
        gameArray[i, j].counter := 0;
    End;
  End;
  For i := 1 To 8 Do  // colocar os counter nas casas sem bomba
  Begin
    For j := 1 To 8 Do
    Begin
      If gameArray[i, j].bomb = True Then
      Else If gameArray[i, j].bomb = False Then
      Begin
        For m := -1 To 1 Do
        Begin
          For n := -1 To 1 Do
          Begin
            If (gameArray[i + m, j + n].bomb = True) And (i + m >= 1) And
              (i + m <= 8) And (j + n >= 1) And (j + n <= 8) Then
              gameArray[i, j].counter := gameArray[i, j].counter + 1;
          End;
        End;
      End;
    End;
  End;
  MenuItem9.Checked := False;
  Invalidate;
End;

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  NewGame();                            //when game is open
End;

Procedure TForm1.CheckBox1Change(Sender: TObject);
Begin
  If Label5.Visible = True Then                        //set timer as visible or not
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
  Form2.ShowModal;                        //show about at form 2 in help-about
End;

Procedure TForm1.PaintBox1Paint(Sender: TObject);
Var
  Bitmap, bmBomb, bmFlag: TBitmap;
  //main board, flag, bomb and counter drawer painter
  i, j, n, p: Integer;
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
  For i := 1 To 8 Do
  Begin
    For j := 1 To 8 Do
    Begin
      n := (i * 50) - 50;
      p := (j * 50) - 50;
      Bitmap.Canvas.Pen.Color := clBlack; //Line Color
      Bitmap.Canvas.Brush.Color := clInactiveCaption; //Brush color
      Bitmap.Canvas.Rectangle(n + 1, p + 1, n + 50 - 1, p + 50 - 1);
      //Write some text, in this case an *
      //Define Font properties
      Bitmap.Canvas.Font.Name := 'Liberation Mono';
      Bitmap.Canvas.Font.Style := [fsBold];
      Bitmap.Canvas.Font.Size := 10;
      Bitmap.Canvas.Font.Color := clBlack;
      //Write the text
      If (gameArray[i, j].bomb = True) And (gameArray[i, j].Open = True) Then
      Begin
        Bitmap.Canvas.Brush.Color := clWhite;
        Bitmap.Canvas.Rectangle(n + 1, p + 1, n + 50 - 1, p + 50 - 1);
        bmBomb := TBitmap.Create;
        bmBomb.LoadFromFile('bomb.bmp');
        Bitmap.Canvas.Draw(n, p, bmBomb);
        bmBomb.Free;
      End
      Else If ((gameArray[i, j].counter <> 0) Or (gameArray[i, j].counter = 0)) And
        (gameArray[i, j].Open = True) Then
      Begin
        Bitmap.Canvas.Brush.Color := clWhite;
        Bitmap.Canvas.Rectangle(n + 1, p + 1, n + 50 - 1, p + 50 - 1);
        If gameArray[i, j].counter <> 0 Then
          Bitmap.Canvas.TextOut(n + 50 Div 2, p + 50 Div 3,
            IntToStr(gameArray[i, j].counter));
      End
      Else If (gameArray[i, j].flag = True) And (gameArray[i, j].Open = False) Then
      Begin
        bmFlag := TBitmap.Create;
        bmFlag.LoadFromFile('flag.bmp');
        Bitmap.Canvas.Draw(n, p, bmFlag);
        bmFlag.Free;
      End;
      If (gameArray[i, j].flag = True) And (gameArray[i, j].Open = True) Then
      Begin
        bmFlag := TBitmap.Create;
        bmFlag.LoadFromFile('flag.bmp');
        Bitmap.Canvas.Draw(n, p, bmFlag);
        bmFlag.Free;
      End;
    End;
  End;
  PaintBox1.Canvas.Draw(0, 0, Bitmap);
  Bitmap.Free; //Free the memory used by the object Bitmap
End;

Procedure TForm1.Timer1Timer(Sender: TObject);
Var
  Min, Sec: String;
Begin                                                      //time control for the timer
  If Seconds = 0 Then
  Begin
    Timer1.Enabled := False;
    ShowMessage(timesUp);
    MenuItem9Click(MenuItem9);
    Invalidate;
    Case QuestionDlg('playAgain', playAgain, mtCustom,
        [mrNo, no, mrYes, yes, 'IsDefault'], '') Of
      mrYes:
      Begin
        NewGame();
      End;
      mrNo: Halt;
      Else
        Halt;
    End;
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
