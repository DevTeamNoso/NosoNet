unit nosonet_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DefaultTranslator,
  ComCtrls, StdCtrls, Menus, Grids, LCLTranslator, ExtCtrls, NosoNet_Language,
  NosoNet_Functions, LCLType  ;

type

  { TForm1 }

   NodeData = Packed Record
     ip: string[15];
     Port : int64;
     end;

  TForm1 = class(TForm)
    ConsoleEdit: TEdit;
    MainMenu1: TMainMenu;
    Console: TMemo;
    MenuItem1: TMenuItem;
    PageControl1: TPageControl;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TimerLatido: TTimer;
    procedure ConsoleEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1Resize(Sender: TObject);
    procedure TimerLatidoTimer(Sender: TObject);

  private

  public

  end;

function StartApp():boolean;
function CloseApp():Boolean;
function Latido(): Boolean;
Procedure processLine(linetext:string);

CONST
  DefaultNodes : String = 'DefNodes '+
                            '45.146.252.103:8080 '+
                            '194.156.88.117:8080 '+
                            '192.210.226.118:8080 '+
                            '107.172.5.8:8080 '+
                            '185.239.239.184:8080 '+
                            '109.230.238.240:8080';
  AppVersion : string = '1.0';

var
  Form1: TForm1;

  NodeList : Array of NodeData; // Stores the info of the mainnet nodes
  G_ConsoleLines : TStringList;   // Text to be show on console
  G_ProcessLines : TStringList;  // ]Lines to be preocessed ordered
  G_LastConsoleCommand: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.OnActivate:= nil;
TimerLatido.Enabled:=false;
// Code to be run at launch
Console.Lines.Add(Restring1);
if not StartApp then CloseApp;
end;


/////////////////////// START APP RELATIVES /////////////////////////////////

function StartApp():boolean;
Begin
Result := false;
G_ConsoleLines := TStringlist.Create;
G_ProcessLines := TStringlist.Create;
LoadDefNodes;

Result := true;
Form1.TimerLatido.Enabled:=True;
End;

/////////////////////// EXECUTION RELATIVES /////////////////////////////////

procedure TForm1.TimerLatidoTimer(Sender: TObject);
begin
TimerLatido.Enabled:=false;
Latido;
TimerLatido.Enabled:=True;
end;

function Latido(): Boolean;
Begin
if G_ProcessLines.Count>0 then
   begin
   processLine(G_ProcessLines[0]);
   G_ProcessLines.Delete(0);
   end;
if G_ConsoleLines.Count>0 then
   begin
   Form1.Console.Lines.Add(G_ConsoleLines[0]);
   G_ConsoleLines.Delete(0);
   end;
Result := true;
End;

procedure TForm1.ConsoleEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LineText : String;
begin
LineText := ConsoleEdit.Text;
if Key=VK_RETURN then
   begin
   G_LastConsoleCommand := LineText;
   ConsoleEdit.Text := '';
   if LineText <> '' then G_ProcessLines.Add(LineText);
   end;
end;

Procedure processLine(linetext:string);
var
  command : string = '';
Begin
command := Parameter(LineText,0);
if uppercase(command) = 'EXIT' then closeapp
else if uppercase(command) = 'VER' then G_consolelines.Add(Format(Restring2,[AppVersion]))
else G_consolelines.Add(Format(Restring3,[command]));
End;

/////////////////////// CLOSE APP RELATIVES /////////////////////////////////

function CloseApp():Boolean;
Begin
Result := true;

form1.Close;

End;

// Adjust the size of the Sgrid for nodes
procedure TForm1.StringGrid1Resize(Sender: TObject);
begin
Stringgrid1.ColWidths[0] := Stringgrid1.Width div 5;
Stringgrid1.ColWidths[1] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[2] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[3] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[4] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[5] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[6] := Stringgrid1.Width div 10;
Stringgrid1.ColWidths[7] := Stringgrid1.Width div 10;
end;



END.

