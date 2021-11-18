unit NosoNet_Language;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  langdata = Packed Record
     code: string[2];
     name : string[20];
     end;

resourcestring
  Restring1 = 'Starting';
  Restring2 = 'NosoNet version %s';
  Restring3 = 'Command not valid (%s)';
  Restring4 = 'Language not valid: %s';
  Restring5 = 'New language : %s';
  Restring6 = 'Options saved';
  Restring7 = 'Options file created';
  Restring8 = 'Languages available: %s';

Procedure InitLangs();
Function LangCodeToName(Code:string): String;

var
  LangsArray : array of LangData;

implementation

uses
  nosonet_main;

Procedure InitLangs();
var
  NewLang : LangData;
  counter : integer;
Begin
SetLEngth(LangsArray,0);
// To add a new language translation, it MUST be added here.
NewLang.code:='es';NewLang.name:='Español';insert(NewLang,LangsArray,Length(LangsArray));
NewLang.code:='en';NewLang.name:='English';insert(NewLang,LangsArray,Length(LangsArray));
NewLang.code:='pt';NewLang.name:='Portuguese';insert(NewLang,LangsArray,Length(LangsArray));

For counter := 0 to length(LangsArray)-1 do
   begin
   if fileexists('languages'+directoryseparator+'nosonet.'+langsarray[counter].code+'.po') then
      G_LangsList := G_LangsList + LangsArray[counter].name+' ';
   end;
trim(G_LangsList);

G_ConsoleLines.Add(format(Restring8,[G_LangsList]));

End;

Function LangCodeToName(Code:string): String;
var
  counter : integer;
Begin
result := 'ERROR';
For counter := 0 to length(LangsArray)-1 do
   begin
   if LangsArray[counter].code = code then
      begin
      result := LangsArray[counter].name;
      break;
      end;
   end;
End;


END.

