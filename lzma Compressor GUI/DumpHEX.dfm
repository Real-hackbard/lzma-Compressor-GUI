object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Dump HEX'
  ClientHeight = 428
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 483
    Height = 409
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 409
    Width = 483
    Height = 19
    Panels = <
      item
        Text = 'Count :'
        Width = 50
      end
      item
        Width = 100
      end
      item
        Text = 'Line :'
        Width = 40
      end
      item
        Text = '0'
        Width = 50
      end>
    ExplicitTop = 414
    ExplicitWidth = 503
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 96
    object Search1: TMenuItem
      Caption = 'Search'
      OnClick = Search1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Save1: TMenuItem
      Caption = 'Save'
      OnClick = Save1Click
    end
  end
  object FindDialog1: TFindDialog
    OnFind = FindDialog1Find
    Left = 304
    Top = 176
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Ini file (*.ini)|*.ini'
    Left = 304
    Top = 256
  end
end
