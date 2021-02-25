object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'QIF Editor'
  ClientHeight = 392
  ClientWidth = 983
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 617
    Top = 0
    Height = 373
    ExplicitLeft = 384
    ExplicitTop = 48
    ExplicitHeight = 100
  end
  object gridList: TDBGrid
    Left = 0
    Top = 0
    Width = 617
    Height = 373
    Align = alLeft
    DataSource = dsList
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'date'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Date (D)'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ufield'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Debit (U)'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tfield'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Credit (T)'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'type'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Type'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pfield'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Transaction (P)'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mfield'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Comment (M)'
        Visible = True
      end>
  end
  object pnlDetail: TPanel
    Left = 620
    Top = 0
    Width = 363
    Height = 373
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object pnlDField: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 10
      Width = 357
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object lblDField: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 19
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Date (&D):'
        FocusControl = edtDField
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 272
        Top = 3
        Width = 82
        Height = 19
        Align = alRight
        AutoSize = False
        Caption = 'MM/DD/YYYY'
      end
      object edtDField: TDBEdit
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 177
        Height = 25
        Hint = 'MM/DD/YYYY'
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'date'
        DataSource = dsList
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object pnlUField: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 357
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object lblUField: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 19
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Debit (&U):'
        FocusControl = edtUField
      end
      object edtUField: TDBEdit
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 265
        Height = 25
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'ufield'
        DataSource = dsList
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object pnlTField: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 86
      Width = 357
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object lblTField: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 19
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Credit (&T):'
        FocusControl = edtTField
      end
      object edtTField: TDBEdit
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 265
        Height = 25
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'tfield'
        DataSource = dsList
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object pnlType: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 124
      Width = 357
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 3
      object lblType: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 19
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'T&ype:'
        FocusControl = edtType
      end
      object edtType: TDBEdit
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 265
        Height = 25
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'type'
        DataSource = dsList
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object pnlTransaction: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 162
      Width = 357
      Height = 25
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 4
      object lblTransaction: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 19
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Transaction (&P):'
        FocusControl = edtPField
        ExplicitLeft = 0
        ExplicitTop = 6
      end
      object edtPField: TDBEdit
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 265
        Height = 25
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'pfield'
        DataSource = dsList
        TabOrder = 0
        ExplicitHeight = 23
      end
    end
    object pnlComment: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 200
      Width = 357
      Height = 89
      Margins.Top = 10
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 5
      object lblComment: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 80
        Height = 83
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Comment (&M):'
        FocusControl = edtMField
        ExplicitLeft = 0
        ExplicitTop = 6
        ExplicitHeight = 19
      end
      object edtMField: TDBMemo
        AlignWithMargins = True
        Left = 89
        Top = 0
        Width = 265
        Height = 89
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alClient
        DataField = 'mfield'
        DataSource = dsList
        MaxLength = 250
        TabOrder = 0
      end
    end
    object navList: TDBNavigator
      AlignWithMargins = True
      Left = 3
      Top = 345
      Width = 357
      Height = 25
      DataSource = dsList
      Align = alBottom
      TabOrder = 6
      TabStop = True
    end
  end
  object sbrStatus: TStatusBar
    Left = 0
    Top = 373
    Width = 983
    Height = 19
    Panels = <
      item
        Width = 200
      end>
  end
  object menuMain: TMainMenu
    Left = 64
    Top = 64
    object mnuFile: TMenuItem
      Caption = '&File'
      object mnuFileNew: TMenuItem
        Caption = '&New...'
        ShortCut = 16462
        OnClick = mnuFileNewClick
      end
      object mnuFileOpen: TMenuItem
        Caption = '&Open...'
        ShortCut = 16463
        OnClick = mnuFileOpenClick
      end
      object mnuFileSave: TMenuItem
        Caption = '&Save...'
        ShortCut = 16467
        OnClick = mnuFileSaveClick
      end
      object mnuFileSaveAs: TMenuItem
        Caption = 'Save &As...'
        ShortCut = 24659
        OnClick = mnuFileSaveAsClick
      end
      object mnuFileClear: TMenuItem
        Caption = 'Clea&r'
        ShortCut = 16466
        OnClick = mnuFileClearClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuFileExit: TMenuItem
        Caption = 'E&xit'
        OnClick = mnuFileExitClick
      end
    end
    object mnuEdit: TMenuItem
      Caption = '&Edit'
      object Undo1: TMenuItem
        Caption = '&Undo'
        ShortCut = 16474
        OnClick = Undo1Click
      end
      object mniN2: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Caption = 'Cu&t'
        ShortCut = 16472
        OnClick = Cut1Click
      end
      object Copy1: TMenuItem
        Caption = '&Copy'
        ShortCut = 16451
        OnClick = Copy1Click
      end
      object Paste1: TMenuItem
        Caption = '&Paste'
        ShortCut = 16470
        OnClick = Paste1Click
      end
      object mniN3: TMenuItem
        Caption = '-'
      end
      object SelectAll1: TMenuItem
        Caption = 'Select &All'
        ShortCut = 16449
        OnClick = SelectAll1Click
      end
    end
    object CSV1: TMenuItem
      Caption = 'CS&V'
      object ImportfromCSV1: TMenuItem
        Caption = 'Import from CSV...'
        OnClick = ImportfromCSV1Click
      end
      object ExporttoCSV1: TMenuItem
        Caption = 'Export to CSV...'
        OnClick = ExporttoCSV1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About...'
        OnClick = About1Click
      end
    end
  end
  object dsList: TDataSource
    DataSet = dbList
    Left = 64
    Top = 192
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '.qif'
    Filter = 'QIF File (*.qif)|*.qif|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 64
    Top = 274
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.qif'
    Filter = 'QIF File (*.qif)|*.qif|All Files (*.*)|*.*'
    Options = [ofEnableSizing]
    Left = 64
    Top = 318
  end
  object dbList: TXDBData
    AfterDelete = dbListAfterDelete
    AfterPost = dbListAfterPost
    AfterScroll = dbListAfterScroll
    OnCountRecords = dbListCountRecords
    OnDeleteRecord = dbListDeleteRecord
    OnGetFieldData = dbListGetFieldData
    OnInsertRecord = dbListInsertRecord
    OnNewRecord = dbListNewRecord
    OnSetFieldData = dbListSetFieldData
    Left = 64
    Top = 148
    object dbListdate: TDateField
      FieldName = 'date'
      DisplayFormat = 'MM/dd/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object dbListufield: TCurrencyField
      FieldName = 'ufield'
    end
    object dbListtfield: TCurrencyField
      FieldName = 'tfield'
    end
    object dbListtype: TStringField
      FieldName = 'type'
      Size = 50
    end
    object dbListpfield: TStringField
      FieldName = 'pfield'
      Size = 50
    end
    object dbListmfield: TStringField
      FieldName = 'mfield'
      Size = 250
    end
  end
end
