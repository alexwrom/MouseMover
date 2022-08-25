unit uStartSettingLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows, FMX.ListBox, uTranscriptions, uUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Effects, System.ImageList, FMX.ImgList;

type
  TFormStartLang = class(TForm)
    timerCheckTrack: TTimer;
    timerGetPos: TTimer;
    btnCancel: TCornerButton;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnClose: TSpeedButton;
    Image16: TImage;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    btnStart: TCornerButton;
    labText: TLabel;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    Image1: TImage;
    procedure btnStartClick(Sender: TObject);
    procedure timerGetPosTimer(Sender: TObject);
    procedure timerCheckTrackTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    CountLang: integer;
    CurrItem: integer;
    PosClick: string;
    LangText: string;
    IsShowing: boolean;
    ActiveIndex: integer;
  public
    { Public declarations }
  end;

var
  FormStartLang: TFormStartLang;

implementation

uses uMain,uFormPlay;

{$R *.fmx}

procedure TFormStartLang.btnCancelClick(Sender: TObject);
begin
  labText.Text := 'Перед началом настройки языков откройте в браузере Youtube Studio и перейдите в настройки субтитров на одном из Ваших новых видео.' +
    ' Затем вернитесь в программу и нажав кнопку "Начать" наведите на кнопку в браузере "ДОБАВИТЬ ПЕРЕВОД НА ДРУГОЙ ЯЗЫК".';
  btnStart.Text := 'Начать';
  MainForm.SetInfo(MainForm.btnItemName, 'Нажмите сюда, чтобы перейти в раздел настройки переводов названия и описания.');
  btnCancel.Visible := false;
  btnStart.Visible := true;
  Self.Close;

end;

procedure TFormStartLang.btnStartClick(Sender: TObject);
begin
  PosClick := '0-0';
  Self.Hide;
  timerCheckTrack.Enabled := true;
  timerGetPos.Enabled := true;
  btnStart.Visible := false;
  labText.Text := 'Настройка языков завершена.';
  btnCancel.Visible := true;
  MainForm.setkey(Lo(GetUserDefaultUILanguage), sublang_default);
end;

procedure TFormStartLang.timerCheckTrackTimer(Sender: TObject);
var
  s: string;
  J: integer;
begin

  timerGetPos.Enabled := false;
  timerCheckTrack.Enabled := false;

  MainForm.OrderId := 2;
  MainForm.SetHint(PosClick);
  FormPlay.IsShow := false;
  Self.FormStyle := TFormStyle.StayOnTop;
  FormPlay.btnStartLangClick(nil);
end;

procedure TFormStartLang.FormShow(Sender: TObject);
var
  check: integer;
begin
  MainForm.blockType := blockLang;

end;

procedure TFormStartLang.timerGetPosTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if PosClick = posXY.X.ToString + '-' + posXY.Y.ToString then
  begin
    timerCheckTrack.Enabled := true;
  end
  else
  begin
    PosClick := posXY.X.ToString + '-' + posXY.Y.ToString;
    timerCheckTrack.Enabled := false;
  end;

end;

end.
