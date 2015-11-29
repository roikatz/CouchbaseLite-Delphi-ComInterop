object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 422
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 410
    Height = 185
    Caption = 'Couchbase sever'
    TabOrder = 0
    object Button1: TButton
      Left = 72
      Top = 111
      Width = 169
      Height = 25
      Caption = 'Multiple Write 1 Thread'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 72
      Top = 80
      Width = 169
      Height = 25
      Caption = 'One Write'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 72
      Top = 142
      Width = 169
      Height = 25
      Caption = 'Multiple Writes Many Threads'
      TabOrder = 2
      OnClick = Button3Click
    end
    object btnMixedLoad: TButton
      Left = 72
      Top = 16
      Width = 169
      Height = 58
      Caption = 'Mixed Read/Write load'
      TabOrder = 3
      OnClick = MixedReadWriteCB
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 199
    Width = 410
    Height = 221
    Caption = 'Couchbase Lite'
    TabOrder = 1
    object btnSync: TButton
      Left = 72
      Top = 27
      Width = 169
      Height = 30
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnSyncClick
    end
    object btnInsertCBL: TButton
      Left = 72
      Top = 63
      Width = 169
      Height = 26
      Caption = 'Insert'
      TabOrder = 1
      OnClick = btnInsertCBLClick
    end
    object btnGetCBL: TButton
      Left = 72
      Top = 95
      Width = 169
      Height = 26
      Caption = 'Get'
      TabOrder = 2
      OnClick = btnGetCBLClick
    end
    object Button7: TButton
      Left = 72
      Top = 127
      Width = 169
      Height = 26
      Caption = 'Update'
      TabOrder = 3
      OnClick = btnCBLUpdate
    end
    object Button8: TButton
      Left = 72
      Top = 159
      Width = 169
      Height = 26
      Caption = 'Delete'
      TabOrder = 4
      OnClick = btnCBLDelete
    end
    object editId: TEdit
      Left = 247
      Top = 64
      Width = 160
      Height = 21
      TabOrder = 5
    end
  end
end
