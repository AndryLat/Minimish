unit ScreenSaver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, GifImg;

type
  TForm4 = class(TForm)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  ScreenSaverImg = 'res/backgrounds/screensaver.gif';

var
  Form4: TForm4;
  i: integer;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(ScreenSaverImg);
  (Image1.Picture.Graphic AS TGifImage).Animate := true;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  ProgressBar1.Position := ProgressBar1.Position + 10;
  i := i + 10;
  if i > 490 then
  begin
    Timer1.Enabled := false;
    Self.Close;
  end;
end;

begin
  i := 0;

end.
