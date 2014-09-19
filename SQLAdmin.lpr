program SQLAdmin;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Connect, mainunit, metaunit, referenunit;

{$R *.res}

begin
  Application.Title:='SQLAdmin';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TConnectModule, ConnectModule);
  Application.CreateForm(TRefenForm, RefenForm);
  Application.Run;
end.

