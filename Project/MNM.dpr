program MNM;

uses
  Vcl.Forms,
  SysUtils,
  ScreenSaver in 'ScreenSaver.pas' {Form4},
  MainMenu in 'MainMenu.pas' {Form3},
  PlayingForm in 'PlayingForm.pas' {Form5},
  Settings in 'Settings.pas' {Form11},
  Help in 'Help.pas' {Form12},
  Kitchen in 'Kitchen.pas' {Form13},
  Frame in 'Frame.pas' {Frame1: TFrame},
  Scores in 'Scores.pas' {Form1};

{$R *.res}

var
  Form4: TForm4;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Form4 := TForm4.Create(Application);
  Form4.Timer1.Enabled := true;
  Form4.ShowModal;

  FreeAndNil(Form4);

  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
