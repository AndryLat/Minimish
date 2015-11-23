object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 415
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 550
    Height = 400
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 398
    Width = 550
    Height = 17
    DoubleBuffered = True
    Max = 500
    ParentDoubleBuffered = False
    BarColor = clFuchsia
    BackgroundColor = clPurple
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 592
    Top = 296
  end
end
