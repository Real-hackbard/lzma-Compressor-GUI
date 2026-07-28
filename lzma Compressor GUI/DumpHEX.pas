unit DumpHEX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls;

type
  TForm2 = class(TForm)
    ListBox1: TListBox;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    Search1: TMenuItem;
    FindDialog1: TFindDialog;
    SaveDialog1: TSaveDialog;
    Save1: TMenuItem;
    N1: TMenuItem;
    procedure Search1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;
  TextExists : boolean;

implementation

{$R *.dfm}
{$R-}

uses
  Unit1;

function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
begin
  Result := MessageBoxA(Handle, PAnsiChar(Message), PAnsiChar(Caption), Flags);
end;

function SubString(substr: string; s: string): integer;
function Right(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:=''
    else
      result:=copy(s, pos(substr, s)+length(substr),
                                     length(s)-pos(substr, s)+
                                     length(substr));
end;

begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:= Right(substr,s);
    inc(result);
  end;
end;

function HexB (b: Byte): String;
 const HexChar: Array[0..15] of Char = '0123456789ABCDEF';
 begin
  result:= HexChar[b shr 4]+HexChar[b and $0f];
 end;

procedure HexDump(var data; size: Integer; s: TStrings);
 const
  sepHex=' ';
  sepAsc=' ';
  nonAsc='.';
 var
  i : Integer;
  hexDat, ascDat : String;
  buff : Array[0..1] of Byte Absolute data;
 begin
  hexDat:='';
  ascDat:='';
  for i:=0 to size-1 do
   begin
    hexDat:=hexDat+' '+HexB(buff[i]);
    if ((buff[i]>31) and (buff[i]<>255)) then
      ascDat:=ascDat+ ANSIChar(buff[i])
    else
      ascDat:=ascDat+nonAsc;
    if (((i+1) mod 16)<>0) and (((i+1) mod 8)=0) then
      hexDat:=hexDat+' '+sepHex;
    if ((i+1) mod 16)=0 then
     begin
      s.Add(hexdat+sepAsc+' '+ascdat);
      hexdat:='';
      ascdat:='';
     end;
   end;

  if (size mod 16)<>0 then
   begin
    if (size mod 16)<8 then
      hexDat:=hexDat+StringOfChar(' ',(8-(size mod 8))*2)
              +sepHex+StringOfChar(' ',16)
    else
      hexDat:=hexDat+StringOfChar(' ',(16-(size mod 16))*2);
    s.Add(hexDat + sepAsc + ascDat);
   end;
 end;

procedure TForm2.FindDialog1Find(Sender: TObject);
var
  MaxCapacity, CurrentIndex, EndSearch,
  RealPos : integer;
  SearchText, CurrentItem : string;
  TextFound : integer;
  SearchAgain : boolean;
begin
  SearchText := FindDialog1.FindText;
  RealPos := ListBox1.ItemIndex;
  MaxCapacity := ListBox1.Items.Count - 1;
  SearchAgain := False;
  TextExists := False;
  if RealPos = -1 then
  begin
    RealPos := 0;
    CurrentIndex := 0;
    EndSearch := MaxCapacity;
  end else begin
    CurrentIndex := RealPos;
    EndSearch := (MaxCapacity + RealPos) - 1;
  end;

  while CurrentIndex < EndSearch do
  begin
    CurrentItem := ListBox1.Items.Strings[CurrentIndex];
    TextFound := SubString(UpperCase(SearchText), UpperCase(CurrentItem));
    if CurrentIndex = RealPos then
    begin
      TextFound := 0;
    end;

    if TextFound > 0 then
    begin
      TextExists := True;
      ListBox1.ItemIndex := CurrentIndex;
      Exit;
    end;
    if CurrentIndex >= MaxCapacity then
    begin
      SearchAgain := True;
      Break;
    end;

    Inc(CurrentIndex);
  end;

  if SearchAgain = True then
  begin
    CurrentIndex := 0;
    while CurrentIndex < RealPos do
    begin
      CurrentItem := ListBox1.Items.Strings[CurrentIndex];
      TextFound := SubString(UpperCase(SearchText), UpperCase(CurrentItem));

      if CurrentIndex = RealPos then
      begin
        TextFound := 0;
      end;

      if TextFound > 0 then
      begin
        TextExists := True;
        ListBox1.ItemIndex := CurrentIndex;
        Exit;
      end;
      Inc(CurrentIndex);
    end;
  end;

  if TextExists = False then
    MsgBox(FindDialog1.Handle, 'Text "' + SearchText + '" not found.', 'Result', 64);
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to 100 do
    ListBox1.Items.Add(IntToStr(i));   // Fill ListBox with values
  ListBox1.Style := lbOwnerDrawFixed;  // can also be set in the Object Inspector
end;

procedure TForm2.FormShow(Sender: TObject);
var
  FStream: TFileStream;
  buff: array[0..$fff] of Byte;
  nRead: Integer;
begin
  Screen.Cursor := crHourGlass;
  SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  Application.ProcessMessages;
  ListBox1.Items.Clear;
  ListBox1.Items.BeginUpdate;
  FStream := TFileStream.Create(Form1.OpenDialog1.FileName, fmOpenRead or fmShareDenyWrite);
  try
    repeat
      nRead := FStream.Read(Buff, SizeOf(Buff));
      if nRead<>0 then hexdump(buff, nRead, ListBox1.Items);
    until nRead=0;
  finally
    FStream.Free;
  end;

  ListBox1.Items.Endupdate;
  StatusBar1.Panels[1].Text := IntToStr(ListBox1.Items.Count);
  Screen.Cursor := crDefault;
  Form1.StatusBar1.Panels[5].Text := 'done.';
  Form2.SetFocus;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
  StatusBar1.Panels[3].Text := IntToStr(ListBox1.ItemIndex);
end;

procedure TForm2.Save1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    ListBox1.Items.SaveToFile(SaveDialog1.FileName + '.ini');
end;

procedure TForm2.Search1Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

end.
