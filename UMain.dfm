object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'Envik - Path editor'
  ClientHeight = 593
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    635
    593)
  PixelsPerInch = 96
  TextHeight = 13
  object btnGet: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = btnGetClick
  end
  object btnSet: TButton
    Left = 8
    Top = 535
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Set'
    TabOrder = 1
    OnClick = btnSetClick
  end
  object btnClose: TButton
    Left = 526
    Top = 535
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Exit'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object lbPathes: TListBox
    Left = 8
    Top = 39
    Width = 593
    Height = 482
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 3
    OnDblClick = lbPathesDblClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 574
    Width = 635
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object btnAdd: TButton
    Left = 607
    Top = 39
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '+'
    TabOrder = 5
    OnClick = btnAddClick
  end
  object btnEdit: TButton
    Left = 607
    Top = 88
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 6
    OnClick = btnEditClick
  end
  object btnDel: TButton
    Left = 607
    Top = 112
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '-'
    TabOrder = 7
    OnClick = btnDelClick
  end
  object btnCopy: TButton
    Left = 607
    Top = 63
    Width = 25
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '+..'
    TabOrder = 8
    OnClick = btnCopyClick
  end
end
