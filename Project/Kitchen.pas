unit Kitchen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Jpeg, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TForm13 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label2: TLabel;
    ComboBox3: TComboBox;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cookPressedImg = 'res/cookpressed.png';
  CookImg = 'res/cook.png';

var
  Form13: TForm13;

implementation

{$R *.dfm}

uses PlayingForm;

procedure TForm13.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form5.UpdateTimer.Enabled := true;
end;

procedure TForm13.FormShow(Sender: TObject);
begin
  Form5.UpdateTimer.Enabled := false;
end;

procedure TForm13.Image2Click(Sender: TObject);
var
  tmp: integer;
  t1, t2, t3: boolean;
begin
  case ComboBox1.ItemIndex of
    0:
      t1 := true;
    2:
      t1 := true;
    4:
      t1 := true;
  else
    t1 := false;
  end;

  case ComboBox2.ItemIndex of
    1:
      t2 := true;
    3:
      t2 := true;
    0:
      t2 := true;
  else
    t2 := false;
  end;

  case ComboBox3.ItemIndex of
    2:
      t3 := true;
    3:
      t3 := true;
    0:
      t3 := true;
  else
    t3 := false;
  end;

  if (t1 XOR t2) XOR (t2 XOR t3) then
    tmp := PlayingForm.GoodFood
  else
    tmp := PlayingForm.BadFood;

  if CheckBox1.Checked AND ((Random(100) = 63) OR (Random(100) = 42)) then
    tmp := DeadFood;

  if PlayingForm.food[1] = NothingFood then
  begin
    PlayingForm.Form5.Frame11.Image7.Visible := true;
    PlayingForm.food[1] := tmp;
  end
  else if PlayingForm.food[2] = NothingFood then
  begin
    PlayingForm.Form5.Frame11.Image8.Visible := true;
    PlayingForm.food[2] := tmp;
  end
  else
  begin
    PlayingForm.Form5.Frame11.Image9.Visible := true;
    PlayingForm.food[3] := tmp;
  end;

end;

procedure TForm13.Image2MouseEnter(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(cookPressedImg);
end;

procedure TForm13.Image2MouseLeave(Sender: TObject);
begin
  Image2.Picture.LoadFromFile(CookImg);
end;

end.
