unit PlayingForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Frame, Vcl.StdCtrls,
  PngImage, Jpeg, GifImg, bass_simple, bass, IniFiles,
  Vcl.MPlayer, Vcl.AppEvnts;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    StatisticsImg: TImage;
    Background: TImage;
    Toy: TImage;
    ImgButton1: TImage;
    ImgButton2: TImage;
    ImgButton3: TImage;
    ImgButton4: TImage;
    ImgButton5: TImage;
    Frame11: TFrame1;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    UpdateTimer: TTimer;
    Label7: TLabel;
    TrayIcon1: TTrayIcon;
    Image3: TImage;
    procedure initGame;
    procedure updateGame;
    procedure loadGame;
    procedure saveGame;
    procedure startGame;
    procedure ImgButton1MouseEnter(Sender: TObject);
    procedure ImgButton2MouseLeave(Sender: TObject);
    procedure ImgButton3MouseLeave(Sender: TObject);
    procedure ImgButton4MouseLeave(Sender: TObject);
    procedure ImgButton5MouseLeave(Sender: TObject);
    procedure ImgButton1MouseLeave(Sender: TObject);
    procedure ImgButton2MouseEnter(Sender: TObject);
    procedure ImgButton3MouseEnter(Sender: TObject);
    procedure ImgButton4MouseEnter(Sender: TObject);
    procedure ImgButton5MouseEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure ImgButton2Click(Sender: TObject);
    procedure ImgButton3Click(Sender: TObject);
    procedure ImgButton1Click(Sender: TObject);
    procedure ImgButton5Click(Sender: TObject);
    procedure ImgButton4Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image3MouseEnter(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    name: String;
    // procedure WinMsgsHandler(var Msg: TMessage); message WM_SYSCOMMAND;
    procedure OnEndPlay(BassObj: TObject);

    { Public declarations }
  end;

const

  // Картинки кнопок в их обычном состоянии
  Btn1NormalFile = 'res/buttons/kormit.png';
  Btn2NormalFile = 'res/buttons/kupat.png';
  Btn3NormalFile = 'res/buttons/rasvlech.png';
  Btn4NormalFile = 'res/buttons/son.png';
  Btn5NormalFile = 'res/buttons/kuhnya.png';
  // Картинки кнопок в наведелнном на них состоянии
  Btn1PressedFile = 'res/buttons/kormit_pressed.png';
  Btn2PressedFile = 'res/buttons/kupatpressed.png';
  Btn3PressedFile = 'res/buttons/rasvlechpressed.png';
  Btn4PressedFile = 'res/buttons/son_pressed.png';
  Btn5PressedFile = 'res/buttons/kuhnya_pressed.png';
  // Фоновые изоражения разных тем
  BackGroundImg1 = 'res/backgrounds/kitay.jpg';
  BackGroundImg2 = 'res/backgrounds/major.jpg';
  BackGroundImg3 = 'res/backgrounds/standart.jpg';
  BackGroundImg4 = 'res/backgrounds/ukrain.jpg';
  BackGroundImg5 = 'res/backgrounds/vostok.jpg';
  // Музыкальные файлы разных тем
  BackgroundMusic1 = 'res/backgrounds/music/kitay.mp3';
  BackgroundMusic2 = 'res/backgrounds/music/major.mp3';
  BackgroundMusic3 = 'res/backgrounds/music/stndart.mp3';
  BackgroundMusic4 = 'res/backgrounds/music/ukraina.mp3';
  BackgroundMusic5 = 'res/backgrounds/music/vostok.mp3';
  // Состояния чудовища
  BorningState = 0;
  NormalState = 1;
  EatingState = 2;
  PlayingState = 3;
  WashingState = 4;
  SleepingState = 5;
  CryingState = 6;
  DirtyState = 7;
  // Темы
  ThemeStandart = 0;
  ThemeVostok = 3;
  ThemeKitaj = 2;
  ThemeUkraine = 1;
  ThemeMajor = 4;
  // Файлы состояний (гифка и звук)
  BorningStateGif = 'res/states/born.gif';
  BorningStateMp3 = 'res/states/born.mp3';
  NormalStateGif = 'res/states/norm.gif';
  EatingStateGif = 'res/states/eat.gif';
  EatingStateMp3 = 'res/states/eat.mp3'; // !
  PlayingStateGif = 'res/states/dance.gif';
  PlayingStateMp3 = 'res/states/dance.mp3';
  WashingStateGif = 'res/states/wosh.gif';
  WashingStateMp3 = 'res/states/wash.mp3';
  SleepingStateGif = 'res/states/sleep.gif'; // !
  SleepingStateMp3 = 'res/states/sleep.mp3'; // !
  CryingStateGif = 'res/states/cry.gif';
  CryingStateMp3 = 'res/states/cry.mp3';
  DirtyStateGif = 'res/states/dirty.gif';
  DirtyStateMp3 = 'res/states/dirty.mp3';

  // Прочее
  NeedsBackground = 'res/backgrounds/fondlyanujd.png';
  SettingsIcon = 'res/settingsicon.png';
  SettingsIconPressed = 'res/settingsicon_pressed.png';
  HelpIcon = 'res/helpicon.png';
  HelpIconPressed = 'res/helpicon_pressed.png';
  PlayIcon = 'res/playicon.png';
  PlayIconPressed = 'res/playicon_pressed.png';
  PauseIcon = 'res/pauseicon.png';
  PauseIconPressed = 'res/pauseicon_pressed.png';
  LabelFrame = 'res/backgrounds/ramkaimya.png';
  SleepIcon = 'res/sleepicon.png';
  EatIcon = 'res/eatingicon.png';
  WashIcon = 'res/washingicon.png';
  WoodIcon = 'res/gameicon.png';
  AgeIcon = 'res/time.png';
  FoodIcon = 'res/food.png';

  // Еда
  NothingFood = 0;
  GoodFood = 1;
  BadFood = 2;
  DeadFood = 3;

var
  Form5: TForm5;

  currentState: integer;
  steps: integer = 0;

  // Потребности
  Health: real = 1000;
  Mood: real = 1000;
  Hunger: real = 1000;
  Sleep: real = 1000;
  Age: integer = 0;

  Score: integer = 0;
  IsFinish: boolean = false;

  isStart: boolean = true;
  isDead: boolean = false;

  step: integer = 0;

  MusicPlayer: TBassSimple;
  SoundsPlayer: TBassSimple;

  // настрйоки
  MusicVolume: integer = 5;
  SoundsVolume: integer = 250;
  Indicatorsposition: integer = 0;
  DisableSounds: boolean = false;

  theme: integer = 0;

  difficulty: integer = 0;

  food: array [1 .. 3] of integer; // слоты для еды.
  eatingFood: integer; // номер еды, которую сейчас хавает чудик

  isFirstShow: boolean = true;

implementation

{$R *.dfm}

uses MainMenu, Help, Kitchen, Settings;

procedure TForm5.OnEndPlay(BassObj: TObject);
begin
  MusicPlayer.Play; // если чек бокс установлен значит играем заново
end;

procedure TForm5.initGame;
var
  g: TGifImage;
begin
  // загружаем необходимые картинки
  Image1.Picture.LoadFromFile(HelpIcon);
  Image2.Picture.LoadFromFile(SettingsIcon);
  Image3.Picture.LoadFromFile(PauseIcon);
  StatisticsImg.Picture.LoadFromFile(LabelFrame);

  ImgButton1.Picture.LoadFromFile(Btn4NormalFile);
  ImgButton2.Picture.LoadFromFile(Btn2NormalFile);
  ImgButton3.Picture.LoadFromFile(Btn3NormalFile);
  ImgButton4.Picture.LoadFromFile(Btn1NormalFile);
  ImgButton5.Picture.LoadFromFile(Btn5NormalFile);

  Frame11.Image6.Picture.LoadFromFile(NeedsBackground);
  Frame11.Image1.Picture.LoadFromFile(SleepIcon);
  Frame11.Image3.Picture.LoadFromFile(WashIcon);
  Frame11.Image2.Picture.LoadFromFile(WoodIcon);
  Frame11.Image4.Picture.LoadFromFile(EatIcon);
  Frame11.Image5.Picture.LoadFromFile(AgeIcon);

  Frame11.Image7.Picture.LoadFromFile(FoodIcon);
  Frame11.Image8.Picture.LoadFromFile(FoodIcon);
  Frame11.Image9.Picture.LoadFromFile(FoodIcon);

  // инициализируем музыкальные плееры для воспроизведения музыки и звуков
  SoundsPlayer := TBassSimple.Create(Self.Handle);
  SoundsPlayer.Volume := SoundsVolume;

  MusicPlayer := TBassSimple.Create(Self.Handle);
  MusicPlayer.Volume := MusicVolume;
  MusicPlayer.OnEndPlay := OnEndPlay;

  isDead := false;

  // Загружаем тему
  case theme of
    ThemeStandart:
      begin
        Background.Picture.LoadFromFile(BackGroundImg3);
        MusicPlayer.Play(BackgroundMusic3);
      end;
    ThemeVostok:
      begin
        Background.Picture.LoadFromFile(BackGroundImg5);
        MusicPlayer.Play(BackgroundMusic5);
      end;
    ThemeKitaj:
      begin
        Background.Picture.LoadFromFile(BackGroundImg1);
        MusicPlayer.Play(BackgroundMusic1);
      end;
    ThemeUkraine:
      begin
        Background.Picture.LoadFromFile(BackGroundImg4);
        MusicPlayer.Play(BackgroundMusic4);
      end;
    ThemeMajor:
      begin
        Background.Picture.LoadFromFile(BackGroundImg2);
        MusicPlayer.Play(BackgroundMusic2);
      end;
  end;

  // Устанавливаем панель индикаторов в необходимое положение
  case Indicatorsposition of
    0: // left
      begin
        Frame11.Left := 8;
      end;
    1: // right
      begin
        Frame11.Left := 670;
      end;
  end;

  Label6.Caption := name;

  // загружаем гифку чудовища
  g := TGifImage.Create;

  // Стартовое состояние - рождение
  if isStart then
  begin
    currentState := BorningState;
    g.LoadFromFile(BorningStateGif)
  end
  else
  begin
    currentState := NormalState;
    g.LoadFromFile(NormalStateGif);
  end;

  g.Animate := true;
  Toy.Picture.Assign(g);

  // запускаем игру
  UpdateTimer.Enabled := true;

end;

Procedure TForm5.updateGame;
var
  buttonSelected: integer;
begin
  // В зависимотсти от текущего состояния выполняеляем необходимые дейсвтия
  case currentState of
    BorningState:
      begin
        if steps = 35 then
        // Шаги являются своеобразной задержкой, количеством времени, которое чудик пребывает в этом состоянии
        begin
          SoundsPlayer.Stop;
          currentState := NormalState;
          Toy.Picture.LoadFromFile(NormalStateGif);
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          steps := 0;
          Score := Score + Random(10 + 10 * difficulty);
        end
        else
          inc(steps);
      end;
    NormalState:
      begin
        if Health < 500 then
        begin
          currentState := DirtyState;
          Toy.Picture.LoadFromFile(DirtyStateGif);
          SoundsPlayer.Play(DirtyStateMp3);
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          if TrayIcon1.Visible then
          begin
            TrayIcon1.BalloonTitle := 'Грязнуля';
            TrayIcon1.BalloonHint := 'Я уже грязный, мне бы ванну принять...';
            TrayIcon1.ShowBalloonHint;
          end;

        end;
        if Mood < 400 then
        begin
          currentState := CryingState;
          Toy.Picture.LoadFromFile(CryingStateGif);
          SoundsPlayer.Play(CryingStateMp3);
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          if TrayIcon1.Visible then
          begin
            TrayIcon1.BalloonTitle := 'Печалька';
            TrayIcon1.BalloonHint := 'Мне скучно. Давай играть?';
            TrayIcon1.ShowBalloonHint;
          end;
        end;
      end;
    WashingState:
      Begin
        if steps = 25 then
        begin
          currentState := NormalState;
          Toy.Picture.LoadFromFile(NormalStateGif);
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          steps := 0;
          Score := Score + Random(10 + 10 * difficulty);
          Health := Health + 200 + Random(300);
          if Health > 1000 then
            Health := 1000;
          SoundsPlayer.Stop;
        end
        else
          inc(steps);
      End;
    PlayingState:
      begin
        if steps = 60 then
        begin
          SoundsPlayer.Stop;
          if Health < 500 then
          begin
            currentState := DirtyState;
            SoundsPlayer.Play(DirtyStateMp3);
            Toy.Picture.LoadFromFile(DirtyStateGif);
          end
          else
          begin
            currentState := NormalState;
            Toy.Picture.LoadFromFile(NormalStateGif);
          end;
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          steps := 0;
          Score := Score + Random(10 + 10 * difficulty);
          Mood := Mood + 200 + Random(300);
          if Mood > 1000 then
            Mood := 1000;
        end
        else
          inc(steps);
      end;
    SleepingState:
      begin
        if steps = 30 then
          SoundsPlayer.Play(SleepingStateMp3);
        if steps = 80 then
        begin
          SoundsPlayer.Stop;
          if Health < 500 then
          begin
            currentState := DirtyState;
            SoundsPlayer.Play(DirtyStateMp3);
            Toy.Picture.LoadFromFile(DirtyStateGif);
          end
          else
          begin
            currentState := NormalState;
            Toy.Picture.LoadFromFile(NormalStateGif);
          end;
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          steps := 0;
          Score := Score + Random(10 + 10 * difficulty);
          Sleep := Sleep + 400 + Random(300);
          if Sleep > 1000 then
            Sleep := 1000;

        end
        else
          inc(steps);
      end;
    EatingState:
      begin
        if steps = 15 then
          SoundsPlayer.Play(EatingStateMp3);
        if steps = 50 then
        begin
          SoundsPlayer.Stop;
          if Health < 200 then
          begin
            currentState := DirtyState;
            SoundsPlayer.Play(DirtyStateMp3);
            Toy.Picture.LoadFromFile(DirtyStateGif);
          end
          else
          begin
            currentState := NormalState;
            Toy.Picture.LoadFromFile(NormalStateGif);
          end;
          (Toy.Picture.Graphic AS TGifImage).Animate := true;
          steps := 0;
          Score := Score + Random(10 + 10 * difficulty);
          if food[eatingFood] = GoodFood then
            Hunger := Hunger + 400 + Random(300);
          if food[eatingFood] = BadFood then
            Hunger := Hunger + Random(300);
          if food[eatingFood] = DeadFood then
          begin
            ShowMessage
              ('Говорила мама: "Не корми детей вкусняшками", вот и отравился питомец и теперь живет в больнице, подключенный к приборам жизнеобеспечения. Стыдно...');
            isDead := true;
            Self.Close;
          end;
          food[eatingFood] := NothingFood;
          // Убираем съеденную еду с панели индикаторов
          case eatingFood of
            3:
              Frame11.Image9.Visible := false;
            2:
              Frame11.Image8.Visible := false;
            1:
              Frame11.Image7.Visible := false;
          end;
        end
        else
          inc(steps);
      end;
  end;

  // увеличиваем время, которое живет чудик
  Frame11.ProgressBar5.Max := (3000 + 1000 * difficulty * 3);
  inc(Age);

  if Age = (3000 + 1000 * difficulty * 3) then
  // если он живет уже nк такстов игры, значит можно считать, что юзер выиграл
  begin
    IsFinish := true;
    buttonSelected :=
      MessageDlg
      ('Ваш питомец прожил достойную жизнь с вами. Продолжить? (игра будет на усложненном режиме)',
      mtInformation, mbYesNo, 0);
    if buttonSelected = mrNo then
      Self.Close;
    if buttonSelected = mrYes then
      difficulty := 1;
  end;

  // Увеличиваем счет
  Score := Score + Random(2 + 2 * difficulty);
  Label7.Caption := 'Счет: ' + IntToStr(Score);

  // Изменяем значения потребностей
  Mood := Mood - Random(5 + 5 * difficulty) * 0.67;
  Health := Health - Random(5 + 5 * difficulty) * 0.58;
  Sleep := Sleep - Random(5 + 5 * difficulty) * 0.34;
  Hunger := Hunger - Random(5 + 5 * difficulty) * 0.27;

  // обновляем показатели еды
  if food[1] = NothingFood then
    Frame11.Image7.Visible := false
  else
    Frame11.Image7.Visible := true;
  if food[2] = NothingFood then
    Frame11.Image8.Visible := false
  else
    Frame11.Image8.Visible := true;
  if food[3] = NothingFood then
    Frame11.Image9.Visible := false
  else
    Frame11.Image9.Visible := true;

  // Проверяем, не хана ли нашему питомцу
  if Mood <= 0 then
  begin
    UpdateTimer.Enabled := false;
    ShowMessage
      ('Если не обращаться на питомца внимание и не развлекать его, он уйдет к другому, как, в принципе, только что это и сделал. Его новая семья уделяет ему намного больше внимания, чем вы.');
    Self.Close;
  end;
  if Health <= 0 then
  begin
    UpdateTimer.Enabled := false;
    ShowMessage
      ('Дитя изредка мыть надо, а то блохи его уже достали и пошло оно искать более чистой жизни. Кстати, нашло, но вы об этом узнали только потом и возращаться к вам питомец не захотел.');
    Self.Close;
  end;
  if Sleep <= 0 then
  begin
    UpdateTimer.Enabled := false;
    ShowMessage
      ('"Что за дом? Никак поспать не дают" - кричало дитя и ушло с дому на поиски более тихого места. Больше его вы не видели, а жило дитя долго, счастливо и без вас.');
    Self.Close;
  end;
  if Hunger <= 0 then
  begin
    UpdateTimer.Enabled := false;
    ShowMessage
      ('"Хозяин, там в холодильнике мышь повесилась, я так больше не могу, пойду в магазин Сникерс куплю, а то кушать охота." Больше вы питомца не видели, он нашел сытное место со всеми условиями.');
    Self.Close;
  end;
end;

procedure TForm5.loadGame;
var
  ini: TIniFile;
  tmpInt: integer;
begin
  ini := TIniFile.Create(GetCurrentDir + '/load.ini');

  if NOT ini.SectionExists('game') then
  begin
    ShowMessage('Извините, сохраненных игр нет! Начинаем новую.');
    ini.Free;
    name := InputBox('Введите имя для вашего питомца', 'Имя:', 'MiNiMish');
    startGame;
    exit;
  end;
  try
    try
      name := ini.ReadString('game', 'name', 'MiNiMish');
      if Length(name) > 150 then
        name := 'MiNiMish';

      Health := ini.ReadFloat('game', 'health', 1000);
      if (Health > 1000) OR (Health < 1) then
        Health := 1000;

      Mood := ini.ReadFloat('game', 'mood', 1000);
      if (Mood > 1000) OR (Mood < 1) then
        Mood := 1000;

      Hunger := ini.ReadFloat('game', 'hunger', 1000);
      if (Hunger > 1000) OR (Hunger < 1) then
        Hunger := 1000;

      Sleep := ini.ReadFloat('game', 'sleep', 1000);
      if (Sleep > 1000) OR (Sleep < 1) then
        Sleep := 1000;

      if (Health < 50) OR (Mood < 50) OR (Hunger < 50) OR (Sleep < 50) then
      begin
        tmpInt := MessageDlg
          ('В загружаемой игре вы уже проиграли. Начнем новую игру (Нет) или вы хотите лицезреть свой проигрыш (Да)?',
          mtInformation, mbYesNo, 0);
        if tmpInt = mrNo then
        begin
          name := InputBox('Введите имя для вашего питомца', 'Имя:',
            'MiNiMish');
          startGame;
          exit;
        end;
      end;

      Age := ini.ReadInteger('game', 'age', 0);
      if (Age < 1) then
        Age := 1;

      Score := ini.ReadInteger('game', 'score', 0);
      if (Score < 1) then
        Score := 1;

      IsFinish := ini.ReadBool('game', 'finish', false);

      tmpInt := ini.ReadInteger('game', 'musicvolume', 50);
      if (tmpInt > 245) OR (tmpInt < 1) then
        tmpInt := 50;
      MusicVolume := tmpInt;

      tmpInt := ini.ReadInteger('game', 'soundsvolume', 250);
      if (tmpInt > 245) OR (tmpInt < 1) then
        tmpInt := 100;
      SoundsVolume := tmpInt;

      tmpInt := ini.ReadInteger('game', 'indicatorsposition', 0);
      if NOT((tmpInt = 0) OR (tmpInt = 1)) then
        tmpInt := 0;
      Indicatorsposition := tmpInt;

      DisableSounds := ini.ReadBool('game', 'disablesounds', false);

      tmpInt := ini.ReadInteger('game', 'theme', 0);
      if (tmpInt > 5) OR (tmpInt < 0) then
        tmpInt := 0;
      theme := tmpInt;

      tmpInt := ini.ReadInteger('game', 'difficulty', 0);
      if (tmpInt > 2) OR (tmpInt < 0) then
        tmpInt := 0;
      difficulty := tmpInt;

      food[1] := ini.ReadInteger('game', 'food1', 0);
      if (food[1] > 3) OR (food[1] < 0) then
        food[1] := 0;
      food[2] := ini.ReadInteger('game', 'food2', 0);
      if (food[2] > 3) OR (food[2] < 0) then
        food[2] := 0;
      food[3] := ini.ReadInteger('game', 'food3', 0);
      if (food[3] > 3) OR (food[3] < 0) then
        food[3] := 0;

      initGame;

    except
      ShowMessage
        ('Загрузка игры не удалась. Начинаем новую игру. Мы не виноваты, это вы своими шаловливыми ручками попытались хакнуть нас, но не тут-то было!');
      name := InputBox('Введите имя для вашего питомца', 'Имя:', 'MiNiMish');
      startGame;
    end;
  finally
    ini.Free;
  end;
end;

procedure TForm5.saveGame;
var
  ini: TIniFile;
  f: TextFile;
  tmp: String;
begin
  ini := TIniFile.Create(GetCurrentDir + '/load.ini');
  ini.WriteString('game', 'name', name);

  ini.WriteFloat('game', 'health', Health);
  ini.WriteFloat('game', 'mood', Mood);
  ini.WriteFloat('game', 'hunger', Hunger);
  ini.WriteFloat('game', 'sleep', Sleep);
  ini.WriteInteger('game', 'age', Age);

  ini.WriteInteger('game', 'score', Score);
  ini.WriteBool('game', 'finish', IsFinish);

  ini.WriteInteger('game', 'musicvolume', MusicVolume);
  ini.WriteInteger('game', 'soundsvolume', SoundsVolume);
  ini.WriteInteger('game', 'indicatorsposition', Indicatorsposition);
  ini.WriteBool('game', 'disablesounds', DisableSounds);

  ini.WriteInteger('game', 'theme', theme);
  ini.WriteInteger('game', 'difficulty', difficulty);

  ini.WriteInteger('game', 'food1', food[1]);
  ini.WriteInteger('game', 'food2', food[2]);
  ini.WriteInteger('game', 'food3', food[3]);

  ini.UpdateFile;

  ini.Free;

  AssignFile(f, 'res/scores.dat');
  Append(f);
  tmp := name + ',' + IntToStr(Score) + ',';
  if IsFinish then
    tmp := tmp + 'win'
  else
    tmp := tmp + 'lose';
  if isDead then
    tmp := tmp + ' and dead';
  case difficulty of
    0:
      tmp := tmp + ', easy';
    1:
      tmp := tmp + ', normal';
    2:
      tmp := tmp + ', hard';
  end;
  WriteLn(f, tmp);
  CloseFile(f);

end;

procedure TForm5.startGame;
begin
  steps := 0;
  Health := 1000;
  Mood := 1000;
  Hunger := 1000;
  Sleep := 1000;
  Age := 0;

  Score := 0;
  IsFinish := false;

  isStart := true;
  isDead := false;

  step := 0;

  MusicVolume := 5;
  SoundsVolume := 250;
  Indicatorsposition := 0;
  DisableSounds := false;

  theme := 0;

  difficulty := 0;

  initGame;
end;

procedure TForm5.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.ShowBalloonHint;
  ShowWindow(Handle, SW_RESTORE);
  SetForegroundWindow(Handle);
  // TrayIcon1.Visible := false;
end;

procedure TForm5.UpdateTimerTimer(Sender: TObject);
begin
  updateGame;

  Frame11.ProgressBar1.position := Round(Sleep);
  Frame11.ProgressBar2.position := Round(Mood);
  Frame11.ProgressBar3.position := Round(Health);
  Frame11.ProgressBar4.position := Round(Hunger);
  Frame11.ProgressBar5.position := Age;
end;

procedure TForm5.ApplicationEvents1Minimize(Sender: TObject);
begin
  // TrayIcon1.Visible := true;
  // Убираем с панели задач
  ShowWindow(Handle, SW_HIDE); // Скрываем программу
  ShowWindow(Application.Handle, SW_HIDE); // Скрываем кнопку с TaskBar'а
  SetWindowLong(Application.Handle, GWL_EXSTYLE,
    GetWindowLong(Application.Handle, GWL_EXSTYLE) or (not WS_EX_APPWINDOW));

end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  saveGame;
  Self.Hide;
  MainMenu.Form3.Show;
  MusicPlayer.Stop;
  SoundsPlayer.Stop;
  UpdateTimer.Enabled := false;
end;

procedure TForm5.FormShow(Sender: TObject);
begin;
end;

procedure TForm5.Image1Click(Sender: TObject);
begin
  SoundsPlayer.Pause;
  (Toy.Picture.Graphic AS TGifImage).SuspendDraw;
  Help.Form12.ShowModal;
end;

procedure TForm5.Image1MouseEnter(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(HelpIconPressed);
end;

procedure TForm5.Image1MouseLeave(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(HelpIcon);
end;

procedure TForm5.Image2Click(Sender: TObject);
begin
  SoundsPlayer.Pause;
  (Toy.Picture.Graphic AS TGifImage).SuspendDraw;
  Settings.Form11.ShowModal;
end;

procedure TForm5.Image2MouseEnter(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(SettingsIconPressed);
end;

procedure TForm5.Image2MouseLeave(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(SettingsIcon);
end;

procedure TForm5.Image3Click(Sender: TObject);
begin
  if UpdateTimer.Enabled then
  begin
    UpdateTimer.Enabled := false;
    SoundsPlayer.Pause;
    (Toy.Picture.Graphic AS TGifImage).SuspendDraw;
  end
  else
  begin
    SoundsPlayer.Play;
    (Form5.Toy.Picture.Graphic AS TGifImage).ResumeDraw;
    Form5.Toy.Refresh;
    Form5.Toy.Repaint;
    UpdateTimer.Enabled := true;
  end;

end;

procedure TForm5.Image3MouseEnter(Sender: TObject);
begin
  if UpdateTimer.Enabled then
    Image3.Picture.LoadFromFile(PauseIconPressed)
  else
    Image3.Picture.LoadFromFile(PlayIconPressed);
end;

procedure TForm5.Image3MouseLeave(Sender: TObject);
begin
  if UpdateTimer.Enabled then
    Image3.Picture.LoadFromFile(PauseIcon)
  else
    Image3.Picture.LoadFromFile(PlayIcon);
end;

procedure TForm5.ImgButton1Click(Sender: TObject);
begin
  if steps = 0 then
  begin
    currentState := SleepingState;
    Toy.Picture.LoadFromFile(SleepingStateGif);
    (Toy.Picture.Graphic AS TGifImage).Animate := true;
  end;
end;

procedure TForm5.ImgButton1MouseEnter(Sender: TObject);
begin
  if steps = 0 then
    ImgButton1.Picture.LoadFromFile(Btn4PressedFile);
end;

procedure TForm5.ImgButton1MouseLeave(Sender: TObject);
begin
  ImgButton1.Picture.LoadFromFile(Btn4NormalFile);
end;

procedure TForm5.ImgButton2Click(Sender: TObject);
begin
  if steps = 0 then
  begin
    currentState := WashingState;
    Toy.Picture.LoadFromFile(WashingStateGif);
    (Toy.Picture.Graphic AS TGifImage).Animate := true;
    SoundsPlayer.Play(WashingStateMp3);
  end;
end;

procedure TForm5.ImgButton2MouseEnter(Sender: TObject);
begin
  if steps = 0 then
    ImgButton2.Picture.LoadFromFile(Btn2PressedFile);
end;

procedure TForm5.ImgButton2MouseLeave(Sender: TObject);
begin
  ImgButton2.Picture.LoadFromFile(Btn2NormalFile);
end;

procedure TForm5.ImgButton3Click(Sender: TObject);
begin
  if steps = 0 then
  begin
    currentState := PlayingState;
    Toy.Picture.LoadFromFile(PlayingStateGif);
    (Toy.Picture.Graphic AS TGifImage).Animate := true;
    SoundsPlayer.Play(PlayingStateMp3);
  end;
end;

procedure TForm5.ImgButton3MouseEnter(Sender: TObject);
begin
  if steps = 0 then
    ImgButton3.Picture.LoadFromFile(Btn3PressedFile);
end;

procedure TForm5.ImgButton3MouseLeave(Sender: TObject);
begin
  ImgButton3.Picture.LoadFromFile(Btn3NormalFile);
end;

procedure TForm5.ImgButton4Click(Sender: TObject);
begin
  if steps = 0 then
  begin
    eatingFood := 0;
    // выбираем, какую еду кушаем.
    if NOT(food[1] = NothingFood) then
      eatingFood := 1;
    if NOT(food[2] = NothingFood) then
      eatingFood := 2;
    if NOT(food[3] = NothingFood) then
      eatingFood := 3;
    if eatingFood = 0 then
    begin
      exit;
    end;

    currentState := EatingState;
    Toy.Picture.LoadFromFile(EatingStateGif);
    (Toy.Picture.Graphic AS TGifImage).Animate := true;

  end;
end;

procedure TForm5.ImgButton4MouseEnter(Sender: TObject);
begin
  if steps = 0 then
    ImgButton4.Picture.LoadFromFile(Btn1PressedFile);
end;

procedure TForm5.ImgButton4MouseLeave(Sender: TObject);
begin
  ImgButton4.Picture.LoadFromFile(Btn1NormalFile);
end;

procedure TForm5.ImgButton5Click(Sender: TObject);
begin
  if steps = 0 then
    Kitchen.Form13.ShowModal;
end;

procedure TForm5.ImgButton5MouseEnter(Sender: TObject);
begin
  if steps = 0 then
    ImgButton5.Picture.LoadFromFile(Btn5PressedFile);
end;

procedure TForm5.ImgButton5MouseLeave(Sender: TObject);
begin
  ImgButton5.Picture.LoadFromFile(Btn5NormalFile);
end;

end.
