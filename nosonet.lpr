program nosonet;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, nosonet_main, NosoNet_Language, NosoNet_Functions, NosoNet_File, LCLTranslator
  { you can add units after this };

{$R *.res}

begin
  SetDefaultLang('en');
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

