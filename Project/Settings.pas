unit Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, PngImage,
  GifImg,
  Vcl.StdCtrls;

type
  TForm11 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

uses PlayingForm;

procedure TForm11.CheckBox1Click(Sender: TObject);
begin
  PlayingForm.DisableSounds := CheckBox1.Checked;
  if PlayingForm.DisableSounds then
  begin
    PlayingForm.MusicVolume := 0;
    PlayingForm.SoundsVolume := 0;
  end
  else
  Begin
    PlayingForm.MusicVolume := TrackBar1.Position;
    PlayingForm.SoundsVolume := TrackBar2.Position;
  End;

  PlayingForm.MusicPlayer.Volume := PlayingForm.MusicVolume;
  PlayingForm.SoundsPlayer.Volume := PlayingForm.SoundsVolume;

end;

procedure TForm11.ComboBox1Change(Sender: TObject);
begin
  PlayingForm.theme := ComboBox1.ItemIndex;
  case PlayingForm.theme of
    ThemeStandart:
      begin
        Image1.Picture.LoadFromFile(BackGroundImg3);
        PlayingForm.Form5.Background.Picture.LoadFromFile(BackGroundImg3);
        MusicPlayer.play(BackgroundMusic3);
      end;
    ThemeVostok:
      begin
        Image1.Picture.LoadFromFile(BackGroundImg5);
        PlayingForm.Form5.Background.Picture.LoadFromFile(BackGroundImg5);
        MusicPlayer.play(BackgroundMusic5);
      end;
    ThemeKitaj:
      begin
        Image1.Picture.LoadFromFile(BackGroundImg1);
        PlayingForm.Form5.Background.Picture.LoadFromFile(BackGroundImg1);
        MusicPlayer.play(BackgroundMusic1);
      end;
    ThemeUkraine:
      begin
        Image1.Picture.LoadFromFile(BackGroundImg4);
        PlayingForm.Form5.Background.Picture.LoadFromFile(BackGroundImg4);
        MusicPlayer.play(BackgroundMusic4);
      end;
    ThemeMajor:
      begin
        Image1.Picture.LoadFromFile(BackGroundImg2);
        PlayingForm.Form5.Background.Picture.LoadFromFile(BackGroundImg2);
        MusicPlayer.play(BackgroundMusic2);
      end;
  end;
  Form5.Toy.Picture.LoadFromFile(NormalStateGif);
  (Form5.Toy.Picture.Graphic AS TGifImage).Animate := true;
end;

procedure TForm11.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SoundsPlayer.play;
  (Form5.Toy.Picture.Graphic AS TGifImage).ResumeDraw;
  Form5.Toy.Refresh;
  Form5.Toy.Repaint;
  Form5.UpdateTimer.Enabled := true;
end;

procedure TForm11.FormShow(Sender: TObject);
begin
  Form5.UpdateTimer.Enabled := false;
  TrackBar1.Position := PlayingForm.MusicVolume;
  TrackBar2.Position := PlayingForm.SoundsVolume;
  CheckBox1.Checked := PlayingForm.DisableSounds;
  RadioGroup2.ItemIndex := PlayingForm.difficulty;
  ComboBox1.ItemIndex := PlayingForm.theme;

  case PlayingForm.theme of
    ThemeStandart:
      Image1.Picture.LoadFromFile(BackGroundImg3);
    ThemeVostok:
      Image1.Picture.LoadFromFile(BackGroundImg5);
    ThemeKitaj:
      Image1.Picture.LoadFromFile(BackGroundImg1);
    ThemeUkraine:
      Image1.Picture.LoadFromFile(BackGroundImg4);
    ThemeMajor:
      Image1.Picture.LoadFromFile(BackGroundImg2);
  end;
end;

procedure TForm11.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0:
      begin
        PlayingForm.Indicatorsposition := 0;
        PlayingForm.Form5.Frame11.Left := 8;
      end;
    1:
      begin
        PlayingForm.Indicatorsposition := 1;
        PlayingForm.Form5.Frame11.Left := 670;
      end;
  end;
end;

procedure TForm11.RadioGroup2Click(Sender: TObject);
begin
  PlayingForm.difficulty := RadioGroup2.ItemIndex;
end;

procedure TForm11.TrackBar1Change(Sender: TObject);
begin
  PlayingForm.MusicPlayer.Volume := TrackBar1.Position;
  PlayingForm.MusicVolume := TrackBar1.Position;
end;

procedure TForm11.TrackBar2Change(Sender: TObject);
begin
  PlayingForm.SoundsPlayer.Volume := TrackBar1.Position;
  PlayingForm.SoundsVolume := TrackBar1.Position;
end;

end.
