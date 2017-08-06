object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 310
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 16
    Top = 24
    Width = 75
    Height = 25
    Caption = #21457#36865
    TabOrder = 0
    OnClick = btn1Click
  end
  object Edit1: TEdit
    Left = 104
    Top = 26
    Width = 377
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Memo1: TMemo
    Left = 104
    Top = 72
    Width = 377
    Height = 193
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object TcpClient1: TTcpClient
    OnSend = TcpClient1Send
    Left = 288
    Top = 32
  end
end
