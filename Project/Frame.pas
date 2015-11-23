unit Frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFrame1 = class(TFrame)
    Image1: TImage;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    Image2: TImage;
    ProgressBar3: TProgressBar;
    Image3: TImage;
    ProgressBar4: TProgressBar;
    Image4: TImage;
    Image5: TImage;
    ProgressBar5: TProgressBar;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    procedure ProgressBar1MouseEnter(Sender: TObject);
    procedure ProgressBar1MouseLeave(Sender: TObject);
    procedure ProgressBar2MouseLeave(Sender: TObject);
    procedure ProgressBar2MouseEnter(Sender: TObject);
    procedure ProgressBar3MouseEnter(Sender: TObject);
    procedure ProgressBar3MouseLeave(Sender: TObject);
    procedure ProgressBar4MouseLeave(Sender: TObject);
    procedure ProgressBar4MouseEnter(Sender: TObject);
    procedure ProgressBar5MouseEnter(Sender: TObject);
    procedure ProgressBar5MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFrame1.ProgressBar1MouseEnter(Sender: TObject);
begin
ProgressBar1.ShowHint := true;
end;

procedure TFrame1.ProgressBar1MouseLeave(Sender: TObject);
begin
ProgressBar1.ShowHint := false;
end;

procedure TFrame1.ProgressBar2MouseEnter(Sender: TObject);
begin
ProgressBar2.ShowHint := true;
end;

procedure TFrame1.ProgressBar2MouseLeave(Sender: TObject);
begin
ProgressBar2.ShowHint := false;
end;

procedure TFrame1.ProgressBar3MouseEnter(Sender: TObject);
begin
ProgressBar3.ShowHint := true;
end;

procedure TFrame1.ProgressBar3MouseLeave(Sender: TObject);
begin
ProgressBar3.ShowHint := false;
end;

procedure TFrame1.ProgressBar4MouseEnter(Sender: TObject);
begin
ProgressBar4.ShowHint := true;
end;

procedure TFrame1.ProgressBar4MouseLeave(Sender: TObject);
begin
ProgressBar4.ShowHint := false;
end;

procedure TFrame1.ProgressBar5MouseEnter(Sender: TObject);
begin
 ProgressBar5.ShowHint := true;
end;

procedure TFrame1.ProgressBar5MouseLeave(Sender: TObject);
begin
ProgressBar5.ShowHint := false;
end;

end.
