unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,  GifImg,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm12 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    RichEdit3: TRichEdit;
    TabSheet4: TTabSheet;
    RichEdit4: TRichEdit;
    TabSheet5: TTabSheet;
    RichEdit5: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.dfm}

uses PlayingForm;

procedure TForm12.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SoundsPlayer.Play;
    (Form5.Toy.Picture.Graphic AS TGifImage).ResumeDraw;
    Form5.Toy.Refresh;  Form5.Toy.Repaint;
  PlayingForm.Form5.UpdateTimer.Enabled := true;
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile('res/help_1.rtf');
  RichEdit2.Lines.LoadFromFile('res/help_2.rtf');
  RichEdit3.Lines.LoadFromFile('res/help_3.rtf');
  RichEdit4.Lines.LoadFromFile('res/help_4.rtf');
  RichEdit5.Lines.LoadFromFile('res/help_5.rtf');
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  PlayingForm.Form5.UpdateTimer.Enabled := false;
end;

end.
