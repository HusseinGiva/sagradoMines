unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
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
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PaintBox1: TPaintBox;
    Timer1: TTimer;
    procedure Label7Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
  begin
    Application.Terminate;
  end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Bitmap: TBitmap;
  rectangleHeight, rectangleWidth, i, j: integer;
begin
  Bitmap := TBitmap.Create;
  // Initializes the Bitmap Size
  Bitmap.Height := PaintBox1.Height;
  Bitmap.Width := PaintBox1.Width;
  //Draw the background in white
  Bitmap.Canvas.Pen.Color := clWhite; //Line Color
  Bitmap.Canvas.Brush.Color := clWhite; //Fill Color
  Bitmap.Canvas.Rectangle(0, 0, PaintBox1.Width, PaintBox1.Height);
  // Draws squares
  for i := 0 to 7 do
     begin
       for j := 0 to 7 do
         begin
           Bitmap.Canvas.Pen.Color := clBlack; //Line Color
           Bitmap.Canvas.Brush.Color := clYellow; //Brush color
           rectangleHeight := PaintBox1.Height div 8;
           rectangleWidth := PaintBox1.Width div 8;
           Bitmap.Canvas.Rectangle(i*rectangleWidth+1, j*rectangleHeight+1, i*rectangleWidth+rectangleWidth-1, j*rectangleHeight+rectangleHeight-1);
           //Write some text, in this case an *
           //Define Font properties
           Bitmap.Canvas.Font.Name := 'Liberation Mono';
           Bitmap.Canvas.Font.Style := [fsBold];
           Bitmap.Canvas.Font.Size := 10;
           Bitmap.Canvas.Font.Color := clBlack;
           //Write the text
           Bitmap.Canvas.TextOut(i*rectangleWidth+rectangleWidth div 2, j*rectangleHeight+rectangleHeight div 3, '*');
         end;
     end;
  PaintBox1.Canvas.Draw(0, 0, Bitmap);
  Bitmap.Free; //Free the memory used by the object Bitmap
end;

procedure TForm1.Label7Click(Sender: TObject);
begin

end;



end.

