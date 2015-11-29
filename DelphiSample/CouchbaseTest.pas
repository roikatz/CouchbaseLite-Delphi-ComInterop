unit CouchbaseTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls , CouchbaseFacade_TLB, CouchbaseLiteManager_TLB, ActiveX;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnMixedLoad: TButton;
    GroupBox2: TGroupBox;
    btnSync: TButton;
    btnInsertCBL: TButton;
    btnGetCBL: TButton;
    Button7: TButton;
    Button8: TButton;
    editId: TEdit;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure MixedReadWriteCB(Sender: TObject);

    procedure btnSyncClick(Sender: TObject);
    procedure btnInsertCBLClick(Sender: TObject);
    procedure btnGetCBLClick(Sender: TObject);
    procedure btnCBLDelete(Sender: TObject);
    procedure btnCBLUpdate(Sender: TObject);private
    { Private declarations }
  public
    CouchbaseLite : ICouchbaseLiteFacade;
    CBLDocumentId : WideString;

  end;

  TMyThread = class(TThread)
  private
    NFromRange : Integer;
    NToRange : Integer;
    BIsGet : Boolean;
    SName :String;
    procedure SetKeyName(const Value :String);
    procedure SetFromRange(const Value :Integer);
    procedure SetToRange(const Value :Integer);
    procedure SetIsGet(const Value :Boolean);
  protected
    procedure Execute; override;
    public
//     constructor Create(CreateSuspended: Boolean) ;
     property KeyName :String read SName write SetKeyName;
     property FromRange : Integer read NFromRange write SetFromRange;
     property ToRange : Integer read NToRange write SetToRange;
     property IsGet : Boolean read BIsGet write SetIsGet;
  end;
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TMyThread.SetKeyName(const Value: string);
begin
  SName := Value;
end;

procedure TMyThread.SetToRange(const Value: Integer);
begin
  NToRange := Value;
end;

procedure TMyThread.SetFromRange(const Value: Integer);
begin
  NFromRange := Value;
end;

procedure TMyThread.SetIsGet(const Value: Boolean);
begin
  BIsGet := Value;
end;

procedure TMyThread.Execute;
var
  Couchbase : IComCouchbaseFacade;
  i : Integer;
begin

  CoInitialize(Nil);

  Couchbase := CoComCouchbaseFacade.Create;

  if BIsGet then
  begin
    for i := NFromRange to NToRange do
      Couchbase.get('_delphiKey' + i.ToString);
  end
  else
    begin
    for i := NFromRange to NToRange do
      Couchbase.Upsert('_delphiKey' + i.ToString, 'Hello World');
    end;

  Couchbase.Disconnect;

  CoUnInitialize;

end;

procedure TForm1.btnCBLUpdate(Sender: TObject);
var
  document, updatedDocument : WideString;

begin
      document := '{"name": "Roi Katz", "age":32, "job":  "Couchbase SE1" }';
      updatedDocument := CouchbaseLite.Update(CBLDocumentId, document);
      ShowMessage(updatedDocument);
end;

procedure TForm1.btnGetCBLClick(Sender: TObject);
begin

 ShowMessage( CouchbaseLite.Get(editId.Text));
end;

procedure TForm1.btnInsertCBLClick(Sender: TObject);
var
  document : WideString;

begin
  document := '{"name": "Roi K", "age":31, "job":  "Couchbase SE" }';
  CBLDocumentId := CouchbaseLite.Insert(document);
  editId.Text := CBLDocumentId;
end;

procedure TForm1.btnCBLDelete(Sender: TObject);
begin
  if CouchbaseLite.Delete(CBLDocumentId) then
  begin
    ShowMessage('Document ' + CBLDocumentId + ' has been deleted');
    editId.Text := '';
  end
  else
     ShowMessage('Document has NOT been deleted');
end;

procedure TForm1.MixedReadWriteCB(Sender: TObject);
var
  I : Integer;
  MyThread1 : TMyThread;
  MyThread2 : TMyThread;
  MyThread3 : TMyThread;
  MyThread4 : TMyThread;
  MyThread5 : TMyThread;
  MyThread6 : TMyThread;
  MyThread7 : TMyThread;

begin
      MyThread1 := TMyThread.Create(True);
      MyThread1.FreeOnTerminate := True;
      MyThread1.BIsGet := True;

      MyThread2 := TMyThread.Create(True);
      MyThread2.FreeOnTerminate := True;

       MyThread3 := TMyThread.Create(True);
       MyThread3.FreeOnTerminate := True;

       MyThread4 := TMyThread.Create(True);
       MyThread4.FreeOnTerminate := True;
       MyThread4.BIsGet := True;

       MyThread5 := TMyThread.Create(True);
       MyThread5.FreeOnTerminate := True;

       MyThread6 := TMyThread.Create(True);
       MyThread6.FreeOnTerminate := True;

       MyThread7 := TMyThread.Create(True);
       MyThread7.FreeOnTerminate := True;
       MyThread7.BIsGet := True;

      MyThread1.NFromRange := 1;
      MyThread1.NToRange := 100000;

      MyThread2.NFromRange := 100001;
      MyThread2.NToRange := 200000;

      MyThread3.NFromRange := 200001;
      MyThread3.NToRange := 300000;

      MyThread4.NFromRange := 300001;
      MyThread4.NToRange := 400000;

      MyThread5.NFromRange := 400001;
      MyThread5.NToRange := 500000;

      MyThread6.NFromRange := 500001;
      MyThread6.NToRange := 600000;

      MyThread7.NFromRange := 600001;
      MyThread7.NToRange := 700000;



       MyThread1.Start;
       MyThread2.Start;
       MyThread3.Start;
       MyThread4.Start;
       MyThread5.Start;
       MyThread6.Start;
       MyThread7.Start;
end;


procedure TForm1.btnSyncClick(Sender: TObject);
begin

  if btnSync.Caption = 'Start' then
  begin
    CoInitialize(Nil);
    CouchbaseLite := CoCouchbaseLiteFacade.Create;

    CouchbaseLite.StartSyncGateway('localhost');

    btnSync.Caption := 'Stop';
  end
  else
  begin
    CouchbaseLite.StopSyncGateway;
    btnSync.Caption := 'Start';

    CoUninitialize;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I : Integer;
  MyThread : TMyThread;
  Couchbase : IComCouchbaseFacade;
begin
  CoInitialize(Nil);

  Couchbase := CoComCouchbaseFacade.Create;

  for I := 1 to 1000000 do
  begin
      Couchbase.Upsert('_delphiKey' + i.ToString, 'Hello World');
  end;

  Couchbase.Disconnect;

  CoUnInitialize;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Couchbase : IComCouchbaseFacade;

begin
  Couchbase := CoComCouchbaseFacade.Create;
//
  Couchbase.Upsert('_delphiKey' , 'Hello World');
//
  Couchbase.Disconnect;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  I : Integer;
  MyThread1 : TMyThread;
  MyThread2 : TMyThread;
  MyThread3 : TMyThread;
  MyThread4 : TMyThread;
  MyThread5 : TMyThread;
  MyThread6 : TMyThread;
  MyThread7 : TMyThread;
  MyThread8 : TMyThread;
  MyThread9 : TMyThread;
  MyThread10 : TMyThread;

begin
      MyThread1 := TMyThread.Create(True);
      MyThread1.FreeOnTerminate := True;

      MyThread2 := TMyThread.Create(True);
      MyThread2.FreeOnTerminate := True;

       MyThread3 := TMyThread.Create(True);
       MyThread3.FreeOnTerminate := True;

       MyThread4 := TMyThread.Create(True);
       MyThread4.FreeOnTerminate := True;

       MyThread5 := TMyThread.Create(True);
       MyThread5.FreeOnTerminate := True;

       MyThread6 := TMyThread.Create(True);
       MyThread6.FreeOnTerminate := True;

       MyThread7 := TMyThread.Create(True);
       MyThread7.FreeOnTerminate := True;

       MyThread8 := TMyThread.Create(True);
       MyThread8.FreeOnTerminate := True;

       MyThread9 := TMyThread.Create(True);
       MyThread9.FreeOnTerminate := True;

       MyThread10 := TMyThread.Create(True);
       MyThread10.FreeOnTerminate := True;

      MyThread1.NFromRange := 1;
      MyThread1.NToRange := 100000;

      MyThread2.NFromRange := 100001;
      MyThread2.NToRange := 200000;

      MyThread3.NFromRange := 200001;
      MyThread3.NToRange := 300000;

      MyThread4.NFromRange := 300001;
      MyThread4.NToRange := 400000;

      MyThread5.NFromRange := 400001;
      MyThread5.NToRange := 500000;

      MyThread6.NFromRange := 500001;
      MyThread6.NToRange := 600000;

      MyThread7.NFromRange := 600001;
      MyThread7.NToRange := 700000;

      MyThread8.NFromRange := 700001;
      MyThread8.NToRange := 800000;

      MyThread9.NFromRange := 800001;
      MyThread9.NToRange := 900000;

      MyThread10.NFromRange := 900001;
      MyThread10.NToRange := 1000000;


       MyThread1.Start;
       MyThread2.Start;
       MyThread3.Start;
       MyThread4.Start;
       MyThread5.Start;
       MyThread6.Start;
       MyThread7.Start;
//       MyThread8.Start;
//       MyThread9.Start;
//       MyThread10.Start;
end;





end.
