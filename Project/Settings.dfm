object Form11: TForm11
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'MiNiMi Settings'
  ClientHeight = 339
  ClientWidth = 424
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 89
    Caption = #1058#1077#1084#1072
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 40
      Width = 89
      Height = 13
      Caption = #1057#1084#1077#1085#1080#1090#1100' '#1090#1077#1084#1091' '#1085#1072':'
    end
    object Image1: TImage
      Left = 304
      Top = 13
      Width = 89
      Height = 60
      Stretch = True
    end
    object ComboBox1: TComboBox
      Left = 119
      Top = 37
      Width = 162
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103
      OnChange = ComboBox1Change
      Items.Strings = (
        #1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103
        #1059#1082#1088#1072#1080#1085#1072
        #1050#1080#1090#1072#1081
        #1042#1086#1089#1090#1086#1082
        #1052#1072#1078#1086#1088#1085#1072#1103)
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 103
    Width = 408
    Height = 114
    Caption = #1047#1074#1091#1082
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 97
      Height = 13
      Caption = #1043#1088#1086#1084#1082#1086#1089#1090#1100' '#1084#1091#1079#1099#1082#1080':'
    end
    object Label3: TLabel
      Left = 16
      Top = 56
      Width = 111
      Height = 13
      Caption = #1043#1088#1086#1084#1082#1086#1089#1090#1100' '#1101#1092#1092#1077#1082#1090#1086#1074':'
    end
    object TrackBar1: TTrackBar
      Left = 133
      Top = 16
      Width = 260
      Height = 45
      LineSize = 2
      Max = 200
      Min = 1
      Position = 1
      TabOrder = 1
      OnChange = TrackBar1Change
    end
    object TrackBar2: TTrackBar
      Left = 133
      Top = 48
      Width = 260
      Height = 45
      Max = 200
      Min = 1
      Position = 1
      TabOrder = 2
      OnChange = TrackBar2Change
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 83
      Width = 225
      Height = 17
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1079#1074#1091#1082#1086#1074#1086#1077' '#1089#1086#1087#1088#1086#1074#1086#1078#1076#1077#1085#1080#1077
      TabOrder = 0
      OnClick = CheckBox1Click
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 223
    Width = 408
    Height = 50
    Caption = #1056#1072#1089#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1080#1085#1076#1080#1082#1072#1090#1086#1088#1086#1074
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1057#1083#1077#1074#1072
      #1057#1087#1088#1072#1074#1072)
    TabOrder = 2
    OnClick = RadioGroup1Click
  end
  object RadioGroup2: TRadioGroup
    Left = 8
    Top = 279
    Width = 408
    Height = 50
    Caption = #1057#1083#1086#1078#1085#1086#1089#1090#1100
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1051#1077#1075#1082#1086
      #1053#1086#1088#1084#1072#1083#1100#1085#1086
      #1058#1088#1091#1076#1085#1086)
    TabOrder = 3
    OnClick = RadioGroup2Click
  end
end
