object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'MiNiMi Game'
  ClientHeight = 594
  ClientWidth = 792
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Background: TImage
    Left = -5
    Top = 0
    Width = 807
    Height = 529
  end
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 41
    Height = 41
    Stretch = True
    Transparent = True
    OnClick = Image1Click
    OnMouseEnter = Image1MouseEnter
    OnMouseLeave = Image1MouseLeave
  end
  object Image2: TImage
    Left = 8
    Top = 55
    Width = 41
    Height = 41
    Proportional = True
    Stretch = True
    Transparent = True
    OnClick = Image2Click
    OnMouseEnter = Image2MouseEnter
    OnMouseLeave = Image2MouseLeave
  end
  object StatisticsImg: TImage
    Left = 536
    Top = 8
    Width = 250
    Height = 65
    Stretch = True
  end
  object Toy: TImage
    Left = 130
    Top = 145
    Width = 550
    Height = 400
    Center = True
    IncrementalDisplay = True
    Proportional = True
    Stretch = True
    Transparent = True
  end
  object ImgButton1: TImage
    Left = 122
    Top = 535
    Width = 105
    Height = 49
    OnClick = ImgButton1Click
    OnMouseEnter = ImgButton1MouseEnter
    OnMouseLeave = ImgButton1MouseLeave
  end
  object ImgButton2: TImage
    Left = 233
    Top = 535
    Width = 105
    Height = 49
    OnClick = ImgButton2Click
    OnMouseEnter = ImgButton2MouseEnter
    OnMouseLeave = ImgButton2MouseLeave
  end
  object ImgButton3: TImage
    Left = 344
    Top = 535
    Width = 105
    Height = 49
    OnClick = ImgButton3Click
    OnMouseEnter = ImgButton3MouseEnter
    OnMouseLeave = ImgButton3MouseLeave
  end
  object ImgButton4: TImage
    Left = 455
    Top = 535
    Width = 105
    Height = 49
    OnClick = ImgButton4Click
    OnMouseEnter = ImgButton4MouseEnter
    OnMouseLeave = ImgButton4MouseLeave
  end
  object ImgButton5: TImage
    Left = 566
    Top = 535
    Width = 105
    Height = 49
    OnClick = ImgButton5Click
    OnMouseEnter = ImgButton5MouseEnter
    OnMouseLeave = ImgButton5MouseLeave
  end
  object Label1: TLabel
    Left = 122
    Top = 633
    Width = 31
    Height = 13
    Caption = #1057#1087#1072#1090#1100
  end
  object Label2: TLabel
    Left = 233
    Top = 633
    Width = 37
    Height = 13
    Caption = #1050#1091#1087#1072#1090#1100
  end
  object Label3: TLabel
    Left = 344
    Top = 633
    Width = 59
    Height = 13
    Caption = #1056#1072#1079#1074#1083#1077#1082#1072#1090#1100
  end
  object Label4: TLabel
    Left = 455
    Top = 633
    Width = 43
    Height = 13
    Caption = #1050#1086#1088#1084#1080#1090#1100
  end
  object Label5: TLabel
    Left = 566
    Top = 633
    Width = 31
    Height = 13
    Caption = #1050#1091#1093#1085#1103
  end
  object Label6: TLabel
    Left = 566
    Top = 8
    Width = 203
    Height = 36
    Alignment = taCenter
    AutoSize = False
    Caption = 'Label6'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe Print'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 566
    Top = 42
    Width = 203
    Height = 31
    Alignment = taCenter
    AutoSize = False
    Caption = 'Label7'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe Print'
    Font.Style = []
    ParentFont = False
  end
  object Image3: TImage
    Left = 8
    Top = 102
    Width = 41
    Height = 41
    Proportional = True
    Stretch = True
    Transparent = True
    OnClick = Image3Click
    OnMouseEnter = Image3MouseEnter
    OnMouseLeave = Image3MouseLeave
  end
  inline Frame11: TFrame1
    Left = 8
    Top = 268
    Width = 116
    Height = 261
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 268
    ExplicitWidth = 116
    ExplicitHeight = 261
    inherited Image6: TImage
      Left = 2
      Top = 7
      Stretch = True
      ExplicitLeft = 2
      ExplicitTop = 7
    end
    inherited Image1: TImage
      Proportional = True
      Stretch = True
    end
    inherited Image2: TImage
      Stretch = True
    end
    inherited Image4: TImage
      Proportional = True
      Stretch = True
    end
    inherited Image5: TImage
      Proportional = True
      Stretch = True
      Transparent = True
    end
    inherited Image7: TImage
      Stretch = True
    end
    inherited Image8: TImage
      Stretch = True
    end
    inherited Image9: TImage
      Stretch = True
    end
    inherited ProgressBar1: TProgressBar
      Max = 1000
    end
    inherited ProgressBar2: TProgressBar
      Max = 1000
    end
    inherited ProgressBar3: TProgressBar
      Max = 1000
    end
    inherited ProgressBar4: TProgressBar
      Max = 1000
    end
    inherited ProgressBar5: TProgressBar
      Max = 1000
    end
  end
  object UpdateTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = UpdateTimerTimer
    Left = 64
    Top = 544
  end
  object TrayIcon1: TTrayIcon
    BalloonFlags = bfInfo
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 752
    Top = 528
  end
end
