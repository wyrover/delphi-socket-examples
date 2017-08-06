object FrmMain: TFrmMain
  Left = 192
  Top = 131
  Caption = 'FrmMain'
  ClientHeight = 402
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = #21551#21160#26381#21153
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 16
    Top = 47
    Width = 75
    Height = 25
    Caption = #20851#38381#26381#21153
    TabOrder = 1
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 97
    Top = 18
    Width = 417
    Height = 273
    Lines.Strings = (
      'mmo1')
    TabOrder = 2
  end
  object btn3: TButton
    Left = 16
    Top = 78
    Width = 75
    Height = 25
    Caption = #28165#31354#26085#24535
    TabOrder = 3
    OnClick = btn3Click
  end
  object TcpServer1: TTcpServer
    Left = 32
    Top = 200
  end
end
