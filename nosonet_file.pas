unit NosoNet_file;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Procedure CheckOptions();
procedure SaveOptions(saving:boolean);
Procedure LoadOptions();

implementation

Uses
  nosonet_main, nosonet_language, nosonet_functions;

Procedure CheckOptions();
Begin
if not directoryexists('data') then CreateDir('data');
if not fileexists('data'+directoryseparator+'options.txt') then SaveOptions(false);
loadOptions;

End;

procedure SaveOptions(saving:boolean);
Begin
   try
   Assignfile(FileOptions, 'data'+directoryseparator+'options.txt');
   rewrite(FileOptions);
   writeln(FileOptions,'lang '+OPT_Lang);

   Closefile(FileOptions);
   if not saving then G_ConsoleLines.Add(Restring7)
   else G_ConsoleLines.Add(Restring6);
   Except on E:Exception do

   end;
End;

Procedure LoadOptions();
var
  linea:string;
Begin
   try
   Assignfile(FileOptions, 'data'+directoryseparator+'options.txt');
   reset(FileOptions);
   while not eof(FileOptions) do
      begin
      readln(FileOptions,linea);
      if parameter(linea,0) ='lang' then OPT_Lang := parameter (linea,1);

      end;

   Closefile(FileOptions);
   Except on E:Exception do

   end;

End;

END.

