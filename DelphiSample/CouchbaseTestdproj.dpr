program CouchbaseTestdproj;

uses
  Vcl.Forms,
  CouchbaseTest in 'CouchbaseTest.pas' {Form1},
  CouchbaseFacade_TLB in '..\17.0\Imports\CouchbaseFacade_TLB.pas',
  CouchbaseLiteManager_TLB in '..\17.0\Imports\CouchbaseLiteManager_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
