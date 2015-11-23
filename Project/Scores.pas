unit Scores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  f: textFile;
begin
  AssignFile(f, 'res/scores.dat');
  Rewrite(f);
  CloseFile(f);
  StringGrid1.Cells[0, 0] := 'Питомец';
  StringGrid1.Cells[1, 0] := 'Счет';
  StringGrid1.Cells[2, 0] := 'Финал';
  StringGrid1.Cells[3, 0] := 'Сложность';
  StringGrid1.RowCount := 1;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  f: textFile;
  sl: TStringList;
  str: String;
  i: integer;
begin
  StringGrid1.RowCount := 1;
  sl := TStringList.Create;
  i := 0;
  StringGrid1.Cells[0, 0] := 'Питомец';
  StringGrid1.Cells[1, 0] := 'Счет';
  StringGrid1.Cells[2, 0] := 'Финал';
  StringGrid1.Cells[3, 0] := 'Сложность';
  AssignFile(f, 'res/scores.dat');
  Reset(f);
  while not eof(f) do
  begin
    inc(i);
    if i > 100 then
      break;
    ReadLn(f, str);
    sl.CommaText := str;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, i] := sl.Strings[0];
    StringGrid1.Cells[1, i] := sl.Strings[1];
    StringGrid1.Cells[2, i] := sl.Strings[2];
    StringGrid1.Cells[3, i] := sl.Strings[3];
  end;
  CloseFile(f);

end;

end.
