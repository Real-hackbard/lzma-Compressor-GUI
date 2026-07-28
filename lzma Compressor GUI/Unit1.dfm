object Form1: TForm1
  Left = 2047
  Top = 143
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'lzma Compressor GUI'
  ClientHeight = 568
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 296
    Height = 33
    Caption = 'lzma Compressor GUI'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 16
    Top = 534
    Width = 12
    Height = 13
    Caption = '...'
  end
  object Label4: TLabel
    Left = 48
    Top = 40
    Width = 304
    Height = 13
    Caption = 'LZMA is default and general compression method of 7zip format'
  end
  object Label5: TLabel
    Left = 8
    Top = 515
    Width = 62
    Height = 13
    Caption = 'Parameters :'
  end
  object Label7: TLabel
    Left = 263
    Top = 241
    Width = 35
    Height = 13
    Caption = 'Cores :'
  end
  object Label8: TLabel
    Left = 257
    Top = 268
    Width = 41
    Height = 13
    Caption = 'Priority :'
  end
  object Button2: TButton
    Left = 296
    Top = 512
    Width = 82
    Height = 21
    Caption = 'Compress'
    Enabled = False
    TabOrder = 0
    TabStop = False
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 549
    Width = 470
    Height = 19
    Panels = <
      item
        Text = 'Size :'
        Width = 35
      end
      item
        Text = '0'
        Width = 100
      end
      item
        Text = 'New Size :'
        Width = 65
      end
      item
        Text = '0'
        Width = 110
      end
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 558
    ExplicitWidth = 465
  end
  object CheckBox1: TCheckBox
    Left = 32
    Top = 240
    Width = 105
    Height = 17
    Hint = 'The original file is preserved and is not compressed.'
    TabStop = False
    Caption = ' Keep original file'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 32
    Top = 263
    Width = 53
    Height = 17
    Hint = 'Force overwrite of output file'
    TabStop = False
    Caption = ' Force'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object CheckBox3: TCheckBox
    Left = 32
    Top = 449
    Width = 91
    Height = 17
    Hint = 'Display help message in console.'
    TabStop = False
    Caption = ' Help message'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = CheckBox3Click
  end
  object CheckBox4: TCheckBox
    Left = 32
    Top = 472
    Width = 211
    Height = 17
    Hint = 'Write the data to the console and output it.'
    TabStop = False
    Caption = ' Write output to console && keep original'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = CheckBox4Click
  end
  object CheckBox12: TCheckBox
    Left = 193
    Top = 514
    Width = 97
    Height = 17
    TabStop = False
    Caption = 'Show Console'
    TabOrder = 6
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 80
    Width = 447
    Height = 60
    Caption = ' Compress '
    TabOrder = 7
    object Label2: TLabel
      Left = 16
      Top = 27
      Width = 23
      Height = 13
      Caption = 'File :'
    end
    object Edit1: TEdit
      Left = 45
      Top = 24
      Width = 349
      Height = 21
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object Button3: TButton
      Left = 400
      Top = 24
      Width = 33
      Height = 21
      Caption = '...'
      TabOrder = 1
      TabStop = False
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 146
    Width = 447
    Height = 60
    Caption = ' Decompress '
    TabOrder = 8
    object Label6: TLabel
      Left = 16
      Top = 27
      Width = 23
      Height = 13
      Caption = 'File :'
    end
    object Edit2: TEdit
      Left = 45
      Top = 24
      Width = 349
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object Button4: TButton
      Left = 400
      Top = 24
      Width = 33
      Height = 21
      Caption = '...'
      TabOrder = 1
      TabStop = False
      OnClick = Button4Click
    end
  end
  object Button5: TButton
    Left = 384
    Top = 512
    Width = 75
    Height = 21
    Caption = 'Decompress'
    Enabled = False
    TabOrder = 9
    TabStop = False
    OnClick = Button5Click
  end
  object ComboBox1: TComboBox
    Left = 304
    Top = 238
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 10
    TabStop = False
    Text = '2'
    Items.Strings = (
      '1'
      '2'
      '4'
      '6'
      '8'
      '12')
  end
  object ComboBox2: TComboBox
    Left = 304
    Top = 265
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 11
    TabStop = False
  end
  object GroupBox3: TGroupBox
    Left = 32
    Top = 306
    Width = 185
    Height = 105
    Caption = ' Compression '
    TabOrder = 12
    object Label9: TLabel
      Left = 16
      Top = 24
      Width = 120
      Height = 13
      Caption = 'Level [1 ... 9] (default 5)'
    end
    object Label10: TLabel
      Left = 16
      Top = 48
      Width = 44
      Height = 13
      Caption = 'Level  : 5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ScrollBar1: TScrollBar
      Left = 5
      Top = 72
      Width = 174
      Height = 17
      Max = 9
      Min = 1
      PageSize = 0
      Position = 3
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 234
    Top = 306
    Width = 215
    Height = 105
    Caption = ' Suffix '
    TabOrder = 13
    object Label11: TLabel
      Left = 107
      Top = 67
      Width = 23
      Height = 13
      Caption = 'Ext :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 21
      Width = 108
      Height = 13
      Caption = 'Use provided suffix on'
    end
    object Label13: TLabel
      Left = 16
      Top = 40
      Width = 162
      Height = 13
      Caption = 'compressed files (default *.lzma).'
    end
    object Edit3: TEdit
      Left = 136
      Top = 64
      Width = 57
      Height = 21
      TabStop = False
      TabOrder = 0
      Text = 'lzma'
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 'Executable (*.exe)|*.exe|All files (*.*)|*.*'
    Options = [ofHideReadOnly]
    Title = 'Programme EXE - UPX GUI'
    Left = 320
    Top = 16
  end
  object OpenDialog2: TOpenDialog
    Filter = 'lzma compressed file (*.lzma)|*.lzma|All files (*.*)|*.*'
    Left = 392
    Top = 16
  end
end
