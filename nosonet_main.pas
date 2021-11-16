unit nosonet_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DefaultTranslator,
  ComCtrls, StdCtrls, Menus, Grids, LCLTranslator, NosoNet_Language, NosoNet_Functions ;

type

  { TForm1 }

   NodeData = Packed Record
     ip: string[15];
     Port : int64;
     end;

  TForm1 = class(TForm)
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    PageControl1: TPageControl;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1Resize(Sender: TObject);

  private

  public

  end;

function StartApp():boolean;
function CloseApp():Boolean;

CONST
  DefaultNodes : String = 'DefNodes '+
                            '45.146.252.103:8080 '+
                            '194.156.88.117:8080 '+
                            '192.210.226.118:8080 '+
                            '107.172.5.8:8080 '+
                            '185.239.239.184:8080 '+
                            '109.230.238.240:8080';

var
  Form1: TForm1;

  NodeList : Array of NodeData; // Stores the info of the mainnet nodes

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormActivate(Sender: TObject);
begin
Form1.OnActivate:= nil;
// Code to be run at launch
memo1.Lines.Add(Restring1);
if not StartApp then CloseApp;
end;

/////////////////////// START APP RELATIVES /////////////////////////////////

function StartApp():boolean;
Begin
Result := false;
LoadDefNodes;

Result := true;
End;

/////////////////////// CLOSE APP RELATIVES /////////////////////////////////

function CloseApp():Boolean;
Begin

Result := true;
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

