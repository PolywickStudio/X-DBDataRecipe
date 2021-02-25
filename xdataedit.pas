// Polywick Studio
// Copyright (c) 2021 by Polywick Studio
// MIT License
unit xdataedit;
interface
uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.Variants,
  System.UITypes,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.DBGrids,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.Mask,
  Vcl.Menus,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows,
  xdatatransaction,
  XDBData,
  XDBList;

type
  TForm2 = class(TForm)
    About1: TMenuItem;
    Copy1: TMenuItem;
    CSV1: TMenuItem;
    Cut1: TMenuItem;
    dbList: TXDBData;
    dbListdate: TDateField;
    dbListmfield: TStringField;
    dbListpfield: TStringField;
    dbListtfield: TCurrencyField;
    dbListtype: TStringField;
    dbListufield: TCurrencyField;
    edtMField: TDBMemo;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    dsList: TDataSource;
    edtDField: TDBEdit;
    edtTField: TDBEdit;
    edtPField: TDBEdit;
    edtType: TDBEdit;
    edtUField: TDBEdit;
    ExporttoCSV1: TMenuItem;
    gridList: TDBGrid;
    Help1: TMenuItem;
    ImportfromCSV1: TMenuItem;
    lblComment: TLabel;
    lblDField: TLabel;
    lblTField: TLabel;
    lblTransaction: TLabel;
    lblType: TLabel;
    lblUField: TLabel;
    menuMain: TMainMenu;
    mniN2: TMenuItem;
    mniN3: TMenuItem;
    mnuEdit: TMenuItem;
    mnuFile: TMenuItem;
    mnuFileClear: TMenuItem;
    mnuFileExit: TMenuItem;
    mnuFileNew: TMenuItem;
    mnuFileOpen: TMenuItem;
    mnuFileSave: TMenuItem;
    N1: TMenuItem;
    navList: TDBNavigator;
    Paste1: TMenuItem;
    pnlComment: TPanel;
    pnlDetail: TPanel;
    pnlDField: TPanel;
    pnlTField: TPanel;
    pnlTransaction: TPanel;
    pnlType: TPanel;
    pnlUField: TPanel;
    SelectAll1: TMenuItem;
    Splitter1: TSplitter;
    Undo1: TMenuItem;
    sbrStatus: TStatusBar;
    mnuFileSaveAs: TMenuItem;
    Label1: TLabel;
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure dbListAfterDelete(DataSet: TDataSet);
    procedure dbListAfterPost(DataSet: TDataSet);
    procedure dbListCountRecords(DataSet: TDataSet; var Count: Integer);
    procedure dbListDeleteRecord(DataSet: TDataSet; Index: Integer);
    procedure dbListGetFieldData(DataSet: TDataSet; Index: Integer;
      Field: TField; var Data: Variant);
    procedure dbListInsertRecord(DataSet: TDataSet; Index: Integer);
    procedure dbListSetFieldData(DataSet: TDataSet; Index: Integer;
      Field: TField; const Data: Variant);
    procedure ExporttoCSV1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ImportfromCSV1Click(Sender: TObject);
    procedure mnuFileClearClick(Sender: TObject);
    procedure mnuFileExitClick(Sender: TObject);
    procedure mnuFileNewClick(Sender: TObject);
    procedure mnuFileOpenClick(Sender: TObject);
    procedure mnuFileSaveAsClick(Sender: TObject);
    procedure mnuFileSaveClick(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure dbListAfterScroll(DataSet: TDataSet);
    procedure dbListNewRecord(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure About1Click(Sender: TObject);
  protected
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  private
    sFilename: string;
    bModified: boolean;
    atl: TTransactionList;
    procedure InitOpen(iType: integer);
    procedure InitSave(iType: integer);
    procedure FileOpen(AFileName: string);
    procedure FileSave(AFileName: string);
    procedure SetFilename(AFilename: string);
  end;

var
  Form2: TForm2;

implementation

uses
  CSVClass,
  Winapi.ShellAPI;

const
  FTYPE_QIF = 0;
  FTYPE_CSV = 1;

{$R *.dfm}

//==============================================================================
// Forms
//==============================================================================

procedure TForm2.FormCreate(Sender: TObject);
var
  sFile: string;
begin
  DragAcceptFiles(Handle, True);
  SetFilename('');
  bModified := false;
  atl := TTransactionList.Create;
  //
  var iNo: Integer;
  for iNo := 1 to ParamCount do begin
    if (ParamStr(iNo) <> '') then begin
      sFile := sFile + ParamStr(iNo) + ' ';
    end;
    if FileExists(sFile) then begin
      FileOpen(sFile);
    end;
  end;
  if (dbList.Active = false) then begin
    dbList.Active := true;
    dbList.First;
  end;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  DragAcceptFiles(Self.Handle, False);
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  iNo: integer;
begin
  if (sFilename <> '') then begin
    mnuFileSaveClick(sender);
  end else if bModified then begin
    iNo := MessageDlg('You have unsaved changes. Do you want to save?', mtWarning, [mbYes, mbNo, mbCancel], 0);
    if (iNo = mrYes) then begin
      mnuFileSaveClick(sender);
    end;
    if iNo = mrCancel then begin
      CanClose := false;
    end;
  end;
end;

procedure TForm2.WMDropFiles(var Msg: TWMDropFiles);
var
  DropH: HDROP;               // drop handle
  DroppedFileCount: Integer;  // number of files dropped
  FileNameLength: Integer;    // length of a dropped file name
  FileName: string;           // a dropped file name
  I: Integer;                 // loops thru all dropped files
  //DropPoint: TPoint;          // point where files dropped
begin
  inherited;
  DropH := Msg.Drop;
  try
    DroppedFileCount := DragQueryFile(DropH, $FFFFFFFF, nil, 0);
    for I := 0 to Pred(DroppedFileCount) do
    begin
      FileNameLength := DragQueryFile(DropH, 0, nil, 0);
      SetLength(FileName, FileNameLength);
      DragQueryFile(DropH, 0, PChar(FileName), FileNameLength + 1);
      //
      if (sFilename = '') and (sFilename <> FileName) then begin
        FileOpen(FileName);
      end else begin
        if (sFilename <> FileName) then begin
          ShellExecute(
            Handle, 'open', PChar(System.ParamStr(0)),
            PChar(FileName), nil, SW_SHOWNORMAL);
        end;
      end;
    end;
    //DragQueryPoint(DropH, DropPoint);
  finally
    DragFinish(DropH);
  end;
  Msg.Result := 0;
end;

//==============================================================================
// File Menu
//==============================================================================

procedure TForm2.SetFilename(AFilename: string);
begin
  sFilename := AFilename;
  sbrStatus.Panels[0].Text := sFilename;
end;

procedure TForm2.FileOpen(AFileName: string);
var
  str: string;
  iNo: integer;
  iTmp: Integer;
  ts: TStringList;
  trans: TTransaction;

  function Trimx(AStr: string): string;
  begin
    Result := Trim(AStr);
    while Result.StartsWith('''') do begin
      Result := Copy(Result, 2, Length(Result));
    end;
  end;

begin
  dbList.Active := false;
  if FileExists(AFileName) then begin
    ts := TStringList.Create;
    atl.Clear;
    ts.LoadFromFile(AFileName);
    trans := nil;
    for iNo := 0 to (ts.Count - 1) do begin
      str := ts[iNo];
      if str.StartsWith('!') then begin
        continue;
      end else if str.StartsWith('^') then begin
        if (trans <> nil) then begin
          atl.Add(trans);
          trans := nil;
        end;
        continue;
      end else if str.StartsWith('D') then begin
        if TryStrToInt(copy(str, 2, 1), iTmp) then begin
          trans := TTransaction.Create;
          trans.EntryDate := StrToDate(Copy(str, 2, Length(str)));
        end;
      end else if str.StartsWith('U-') then begin
        trans.EntryDebit := StrToCurr(Copy(str, 3, Length(str)));
      end else if str.StartsWith('T-') then begin
        trans.EntryCredit := StrToCurr(Copy(str, 3, Length(str)));
      end else if str.StartsWith('P') then begin
        trans.EntryTrans := TrimX(Copy(str, 2, Length(str)));
      end else if str.StartsWith('M') then begin
        trans.EntryComment := TrimX(Copy(str, 2, Length(str)));
      end else if str.StartsWith('N') then begin
        trans.EntryType := TrimX(Copy(str, 2, Length(str)));
      end;
    end;
    ts.Free;
    SetFilename(AFilename);
    //
    dbList.Active := true;
    dbList.First;
  end;
end;

procedure TForm2.mnuFileOpenClick(Sender: TObject);
begin
  InitOpen(FTYPE_QIF);
  if dlgOpen.Execute then begin
    var sFile := dlgOpen.FileName;
    if (sFilename = '') and (sFilename <> sFile) then begin
      FileOpen(sFile);
    end else begin
      if (sFilename <> sFile) then begin
        ShellExecute(
          Handle, 'open', PChar(System.ParamStr(0)),
          PChar(sFile), nil, SW_SHOWNORMAL);
      end;
    end;
  end;
end;

procedure TForm2.FileSave(AFileName: string);
var
  iNo: integer;
  sPath: string;
  ts: TStringList;
  trans: TTransaction;
begin
  sPath := ExtractFilePath(AFileName);
  if DirectoryExists(sPath) then begin
    ts := TStringList.create;
    try
      ts.Add('!Type:Bank');
      for iNo := 0 to (atl.count - 1) do begin
        trans := atl.Items[iNo];
        ts.Add('D' + FormatDateTime('MM/DD/YYYY', trans.EntryDate));
        ts.Add('U-' + FloatToStr(trans.EntryDebit));
        ts.Add('T-' + FloatToStr(trans.EntryCredit));
        ts.Add('N' + trans.EntryType);
        ts.Add('P' + trans.EntryTrans);
        ts.Add('M' + trans.EntryComment);
        ts.Add('^');
      end;
      ts.Add('D');
      ts.Add('^');
      ts.SaveToFile(AFileName);
      SetFilename(AFilename);
      bModified := false;
    except
      on E: Exception do begin
        ShowMessage(E.Message);
      end;
    end;
    ts.Destroy;
  end;
end;

procedure TForm2.mnuFileSaveAsClick(Sender: TObject);
var
  sFile: string;
begin
  InitSave(FTYPE_QIF);
  if dlgSave.Execute then begin
    sFile := dlgSave.FileName;
    FileSave(sFile);
  end;
end;

procedure TForm2.mnuFileSaveClick(Sender: TObject);
var
  sFile: string;
begin
  sFile := sFilename;
  if (sFile = '') then begin
    InitSave(FTYPE_QIF);
    if dlgSave.Execute then begin
      sFile := dlgSave.FileName;
    end;
  end;
  FileSave(sFile);
end;

procedure TForm2.mnuFileNewClick(Sender: TObject);
begin
  if (sFilename <> '') and (atl.Count > 0) then
    ShellExecute(Handle, 'open', PChar(System.ParamStr(0)), '', nil, SW_SHOWNORMAL);
end;

procedure TForm2.mnuFileClearClick(Sender: TObject);
begin
  var iCount := atl.Count;
  dbList.DisableControls;
  dbList.Last;
  while (dbList.RecordCount > 0) do begin
    dbList.Delete;
  end;
  dbList.EnableControls;
  bModified := (sFilename <> '') and (iCount > 0);
end;

procedure TForm2.mnuFileExitClick(Sender: TObject);
begin
  Close;
end;

//==============================================================================
// Edit Menu
//==============================================================================

procedure TForm2.Undo1Click(Sender: TObject);
var
  aCtrl: TWinControl;
begin
  aCtrl := ActiveControl;
  if aCtrl <> nil then begin
    if aCtrl.ClassType = TDBEdit then begin
      TDBEdit(aCtrl).Undo;
    end;
    if aCtrl.ClassType = TDBMemo then begin
      TDBMemo(aCtrl).Undo;
    end;
  end;
end;

procedure TForm2.Cut1Click(Sender: TObject);
var
  aCtrl: TWinControl;
begin
  aCtrl := ActiveControl;
  if aCtrl <> nil then begin
    if aCtrl.ClassType = TDBEdit then begin
      TDBEdit(aCtrl).CutToClipboard;
    end;
    if aCtrl.ClassType = TDBMemo then begin
      TDBMemo(aCtrl).CutToClipboard;
    end;
  end;
end;

procedure TForm2.About1Click(Sender: TObject);
begin
  ShowMessage(
    'Polywick Studio''s QIF Editor' +#13#10 +
    'https://www.polywickstudio.com');
end;

procedure TForm2.Copy1Click(Sender: TObject);
var
  aCtrl: TWinControl;
begin
  aCtrl := ActiveControl;
  if aCtrl <> nil then begin
    if aCtrl.ClassType = TDBEdit then begin
      TDBEdit(aCtrl).CopyToClipboard;
    end;
    if aCtrl.ClassType = TDBMemo then begin
      TDBMemo(aCtrl).CopyToClipboard;
    end;
  end;
end;

procedure TForm2.Paste1Click(Sender: TObject);
var
  aCtrl: TWinControl;
begin
  aCtrl := ActiveControl;
  if aCtrl <> nil then begin
    if aCtrl.ClassType = TDBEdit then begin
      TDBEdit(aCtrl).PasteFromClipboard;
    end;
    if aCtrl.ClassType = TDBMemo then begin
      TDBMemo(aCtrl).PasteFromClipboard;
    end;
  end;
end;

procedure TForm2.SelectAll1Click(Sender: TObject);
var
  aCtrl: TWinControl;
begin
  aCtrl := ActiveControl;
  if aCtrl <> nil then begin
    if aCtrl.ClassType = TDBEdit then begin
      TDBEdit(aCtrl).SelectAll;
    end;
    if aCtrl.ClassType = TDBMemo then begin
      TDBMemo(aCtrl).SelectAll;
    end;
  end;
end;

//==============================================================================
// CSV Import and Export
//==============================================================================

procedure TForm2.InitOpen(iType: integer);
begin
  case iType of
    FTYPE_QIF: begin
        dlgOpen.DefaultExt := '.qif';
        dlgOpen.Filter := 'QIF File (*.qif)|*.qif|All Files (*.*)|*.*';
      end;
    FTYPE_CSV: begin
        dlgOpen.DefaultExt := '.csv';
        dlgOpen.Filter := 'CSV File (*.csv)|*.csv|All Files (*.*)|*.*';
      end;
  end;
end;

procedure TForm2.InitSave(iType: integer);
begin
  case iType of
    FTYPE_QIF: begin
        dlgSave.DefaultExt := '.qif';
        dlgSave.Filter := 'QIF File (*.qif)|*.qif|All Files (*.*)|*.*';
      end;
    FTYPE_CSV: begin
        dlgSave.DefaultExt := '.csv';
        dlgSave.Filter := 'CSV File (*.csv)|*.csv|All Files (*.*)|*.*';
      end;
  end;
end;

procedure TForm2.ImportfromCSV1Click(Sender: TObject);
var
  sErr: string;
  sFile: string;
  trans: TTransaction;
  dt: TDateTime;
  ft: Extended;

  function TrimTrailing(sStr: string): string;
  begin
    Result := sStr;
    if length(sStr) >= 1 then begin
      if (sStr[length(sStr)] = '"') or (sStr[length(sStr)] = '''') then begin
        delete(sStr, length(sStr), 1);
        Result := sStr;
      end;
    end;
  end;

begin
  InitOpen(FTYPE_CSV);
  if dlgOpen.Execute then begin
    dbList.Active := false;
    sFile := dlgOpen.FileName;
    if FileExists(sFile) then begin
      atl.Clear;
      var aCSV := TnvvCSVFileReader.Create();
      //var aCSV2 := TnvvCSVStringReader.Create();
      aCSV.SetFile(sFile);
      aCSV.UseFieldQuoting := true;
      aCSV.QuoteCharCode := Ord('"');
      aCSV.HeaderPresent := true;
      aCSV.IgnoreEmptyLines := true;
      aCSV.Open;
      //
      var iNoX := 1;
      repeat
        try
          if aCSV.FieldCount = 0 then begin
            inc(iNoX);
            aCSV.Next;
          end else begin
            if Trim(aCSV.Fields[0].Value) = '' then begin
              inc(iNoX);
              aCSV.Next;
              continue;
            end;
            //
            trans := TTransaction.Create;
            var sFMT := aCSV.Fields[0].Value;
            dt := 0;
            TryStrToDate(sFMT, dt);
            trans.EntryDate := dt;
            //
            sFMT := aCSV.Fields[1].Value;
            TryStrToFloat(sFMT, ft);
            trans.EntryDebit := ft;
            //
            sFMT := aCSV.Fields[2].Value;
            TryStrToFloat(sFMT, ft);
            trans.EntryCredit := ft;
            //
            trans.EntryType := TrimTrailing(aCSV.Fields[3].Value);
            trans.EntryTrans := TrimTrailing(aCSV.Fields[4].Value);
            trans.EntryComment := TrimTrailing(aCSV.Fields[5].Value);
            //
            inc(iNoX);
            atl.Add(trans);
            aCSV.Next;
          end;
        except
          on E: Exception do begin
            sErr := sErr + Format('Line %d: %s %s', [iNox, E.Message, E.StackTrace]) + #13#10;
            aCSV.Next;
          end;
        end;
      until aCSV.Eof;
    end;
    dbList.Active := true;
    dbList.Last;
    if (sErr <> '') then begin
      ShowMessage(sErr);
    end;
  end;
end;

procedure TForm2.ExporttoCSV1Click(Sender: TObject);
var
  sFile: string;
  sLine: string;
  t: TTransaction;
  iNo, iNo2: integer;
  //stream: TFileStream;
  fmt: TFormatSettings;
begin
  InitSave(FTYPE_CSV);
  if dlgSave.Execute then begin
    sFile := dlgSave.FileName;
    fmt := TFormatSettings.Create;
    fmt.ShortDateFormat := 'mm/dd/yyyy';
    var ts := TStringList.Create;
    try
      for iNo2 := 0 to gridList.Columns.Count - 1 do begin
        sLine := sLine + gridList.Columns[iNo2].Title.Caption + ',';
      end;
      SetLength(sLine, Length(sLine) - 1);
      ts.Add(sLine);
      for iNo := 0 to (atl.Count - 1) do begin
        t := atl[iNo];
        sLine := Format('"%s","%s","%s","%s","%s","%s"', [
            DateToStr(t.EntryDate, fmt),
            FormatFloat('#0.00', t.EntryDebit),
            FormatFloat('#0.00', t.EntryCredit),
            t.EntryType, t.EntryTrans, t.EntryComment]);
        ts.Add(sLine);
      end;
      ts.SaveToFile(sFile);
    finally
      //stream.free;
      ts.Free;
    end;
  end;
end;

//==============================================================================
// X-Data
//==============================================================================

procedure TForm2.dbListAfterDelete(DataSet: TDataSet);
begin
  bModified := true;
end;

procedure TForm2.dbListAfterPost(DataSet: TDataSet);
begin
  bModified := true;
end;

procedure TForm2.dbListAfterScroll(DataSet: TDataSet);
begin
  //navList.Re
end;

procedure TForm2.dbListCountRecords(DataSet: TDataSet; var Count: Integer);
begin
  Count := atl.Count;
end;

procedure TForm2.dbListGetFieldData(DataSet: TDataSet; Index: Integer;
  Field: TField; var Data: Variant);
var
  trans: TTransaction;
begin
  trans := atl[Index];
  if field.name = 'dbListdate' then begin
    Data := trans.EntryDate;
  end;
  if field.name = 'dbListufield' then begin
    Data := trans.EntryDebit;
  end;
  if field.name = 'dbListtfield' then begin
    Data := trans.EntryCredit;
  end;
  if field.name = 'dbListpfield' then begin
    Data := trans.EntryTrans;
  end;
  if field.name = 'dbListmfield' then begin
    Data := trans.EntryComment;
  end;
  if field.name = 'dbListtype' then begin
    Data := trans.EntryType;
  end;
end;

procedure TForm2.dbListSetFieldData(DataSet: TDataSet; Index: Integer;
  Field: TField; const Data: Variant);
var
  trans: TTransaction;
begin
  trans := atl[Index];
  if field.name = 'dbListdate' then begin
    trans.EntryDate := Data;
  end;
  if field.name = 'dbListufield' then begin
    trans.EntryDebit := Data;
  end;
  if field.name = 'dbListtfield' then begin
    trans.EntryCredit := Data;
  end;
  if field.name = 'dbListpfield' then begin
    trans.EntryTrans := Data;
  end;
  if field.name = 'dbListmfield' then begin
    trans.EntryComment := Data;
  end;
  if field.name = 'dbListtype' then begin
    trans.EntryType := Data;
  end;
end;

procedure TForm2.dbListInsertRecord(DataSet: TDataSet; Index: Integer);
begin
  atl.Insert(Index, TTransaction.Create);
end;

procedure TForm2.dbListNewRecord(DataSet: TDataSet);
begin
  dbListdate.AsDateTime := Now;
end;

procedure TForm2.dbListDeleteRecord(DataSet: TDataSet; Index: Integer);
begin
  atl.Delete(Index);
end;

end.


