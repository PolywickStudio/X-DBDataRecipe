unit xdatatransaction;

interface
uses
  System.Generics.Collections,
  SysUtils;

type
  TTransaction = class(TObject)
  private
    fdate: TDateTime;
    fdebit: currency;
    fcredit: currency;
    ftype: string;
    ftransaction: string;
    fcomment: string;
  public
    property EntryDate: TDateTime read fdate write fdate;
    property EntryDebit: currency  read fdebit write fdebit;
    property EntryCredit: currency  read fcredit write fcredit;
    property EntryType: string read ftype write ftype;
    property EntryTrans: string read ftransaction write ftransaction;
    property EntryComment: string read fcomment write fcomment;
  end;

  TTransactionList = class(TObjectList<TTransaction>)
  public
  end;

implementation

end.
