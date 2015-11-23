unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GifImg,
  PngImage, PlayingForm;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image3MouseEnter(Sender: TObject);
    procedure Image4MouseLeave(Sender: TObject);
    procedure Image4MouseEnter(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // Êîíñòàíòû, õðàíÿùèå ïóòü ê êàðòèíêàì êíîïêè. È îçíà÷àåò íîðìàëüíîå ñîñòîÿíèå, Ð - íàæàòîå (îò àíãëèéñêèõ ñëîâ)
  NewGameBtnNImg = 'res/buttons/newgame.png';
  LoadBtnNImg = 'res/buttons/resume.png';
  RecordsBtnNImg = 'res/buttons/records.png';
  ExitBtnNImg = 'res/buttons/exit.png';

  NewGameBtnPImg = 'res/buttons/newgame_pressed.png';
  LoadBtnPImg = 'res/buttons/resume_pressed.png';
  RecordsBtnPImg = 'res/buttons/records_pressed.png';
  ExitBtnPImg = 'res/buttons/exit_pressed.png';

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Scores;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(NewGameBtnNImg);
  Image2.Picture.LoadFromFile(LoadBtnNImg);
  Image3.Picture.LoadFromFile(RecordsBtnNImg);
  Image4.Picture.LoadFromFile(ExitBtnNImg);
end;

procedure TForm3.Image1Click(Sender: TObject);
begin
  Form5.name := InputBox('Введите имя для вашего питомца', 'Имя:', 'MiNiMish');
  PlayingForm.theme := 3;
  Form5.startGame;
  PlayingForm.Form5.Show;
  Self.Hide;
end;

procedure TForm3.Image1MouseEnter(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(NewGameBtnPImg);
end;

procedure TForm3.Image1MouseLeave(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(NewGameBtnNImg);
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  Form5.LoadGame;
  Form5.Show;
  Self.Hide;
end;

procedure TForm3.Image2MouseEnter(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(LoadBtnPImg);
end;

procedure TForm3.Image2MouseLeave(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(LoadBtnNImg);
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
  Scores.Form1.ShowModal;
end;

procedure TForm3.Image3MouseEnter(Sender: TObject);
begin
  Image3.Picture.LoadFromFile(RecordsBtnPImg);
end;

procedure TForm3.Image3MouseLeave(Sender: TObject);
begin
  Image3.Picture.LoadFromFile(RecordsBtnNImg);
end;

procedure TForm3.Image4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm3.Image4MouseEnter(Sender: TObject);
begin
  Image4.Picture.LoadFromFile(ExitBtnPImg);
end;

procedure TForm3.Image4MouseLeave(Sender: TObject);
begin
  Image4.Picture.LoadFromFile(ExitBtnNImg);
end;

end.
