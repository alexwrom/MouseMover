unit uContact;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Effects;

type
  TContactForm = class(TForm)
    Label7: TLabel;
    labCopyright: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnCloseApp: TSpeedButton;
    Image16: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseAppClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ContactForm: TContactForm;

implementation

{$R *.fmx}

procedure TContactForm.btnCloseAppClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TContactForm.FormCreate(Sender: TObject);
var
  fs: TFormatSettings;
begin
  fs := TFormatSettings.Create;
  fs.ShortDateFormat := 'yyyy';

  labCopyright.Text := Format(labCopyright.Text, [DateToStr(Now(), fs)]);
end;

end.
