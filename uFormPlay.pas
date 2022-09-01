unit uFormPlay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uTranslate, Winapi.Windows, uTranscriptions, uAuthorization, FMX.Platform, uUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uLoadFile, FMX.Objects, FMX.Effects, FMX.Controls.Presentation, Data.DB, FMX.StdCtrls, FireDAC.Comp.Client, FMX.Layouts;

type
  TFormPlay = class(TForm)
    btnStartLang: TSpeedButton;
    Image2: TImage;
    btnStartSubtitle: TSpeedButton;
    Image3: TImage;
    GlowEffect2: TGlowEffect;
    btnStartName: TSpeedButton;
    Image4: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    timerStart: TTimer;
    timerSleepControl: TTimer;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnCloseApp: TSpeedButton;
    Image16: TImage;
    procedure btnCloseAppClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure timerSleepControlTimer(Sender: TObject);
    procedure timerStartTimer(Sender: TObject);
    procedure btnStartLangClick(Sender: TObject);
    procedure btnStartNameClick(Sender: TObject);
    procedure btnStartSubtitleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    OldPos: TPoint;
    LoopCount: integer;
    TranslateLangCode: string;
    Svc: IFMXClipboardService;

  public
    { Public declarations }
    IsShow: Boolean;
  end;

var
  FormPlay: TFormPlay;

implementation

uses uMain, uStartSettingLang;
{$R *.fmx}

procedure TFormPlay.btnCloseAppClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormPlay.btnStartClick(Sender: TObject);
var
  allCount: integer;
begin
  if (Self.Tag = 2) and (MainForm.FrameSettName.swGetData.IsChecked) and ((MainForm.FrameSettName.mName.Text = '') or (MainForm.FrameSettName.mDetails.Text = '')) then
  begin
    ShowMessage('У Вас выбран режим ручного ввода названия и описания. Одно из полей не заполнено. Заполните его в меню настроек и повторите.');
  end
  else
  begin
    MainForm.setkey(Lo(GetUserDefaultUILanguage), sublang_default);

    allCount := MainForm.GetCountLang;
    if (allCount > 0) then
    begin
      Self.Hide;
      GetCursorPos(OldPos);
      LoopCount := 1;

      if Self.Tag <> 1 then
        LoopCount := allCount;
      timerStart.Interval := 500;
      timerStart.Enabled := true;
      timerSleepControl.Enabled := true;
    end;
  end;
end;

procedure TFormPlay.btnStartLangClick(Sender: TObject);
begin
  Self.Tag := 1;
  btnStartClick(nil);
end;

procedure TFormPlay.btnStartNameClick(Sender: TObject);
begin
  Self.Tag := 2;
  btnStartClick(nil);
end;

procedure TFormPlay.btnStartSubtitleClick(Sender: TObject);
begin
  Self.Tag := 3;
  btnStartClick(nil);
end;

procedure TFormPlay.FormCreate(Sender: TObject);
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc);
end;

procedure TFormPlay.FormShow(Sender: TObject);
begin
  IsShow := true;
end;

procedure TFormPlay.timerSleepControlTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if OldPos <> posXY then
  begin
    Self.Tag := 1;
    timerSleepControl.Enabled := false;
    timerStart.Enabled := false;
    Self.FormStyle := TFormStyle.StayOnTop;
    Self.Show;
  end;
  OldPos := posXY;
end;

procedure TFormPlay.timerStartTimer(Sender: TObject);
var
  I, J: integer;
  tmpPoint: TPoint;
  TranslateLangCodeName, TranslateText, tmpPos: string;
  myLang: string;
  AutForm: TAuthorizationForm;
  s: string;
  tmpSP: string;
  tmpTP: string;
  tmpCSP: string;
  tmpCTP: string;
  IsAutoData: Boolean;
  OldInd: integer;
  tmpQuery: TFDQuery;
  HintText: string;
  indexPos: integer;
begin
  case Self.Tag of
    1:
      tmpQuery := MainForm.ActiveSQL('select * from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 order by id_order');
    2:
      tmpQuery := MainForm.ActiveSQL('select * from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 2 order by id_order');
    3:
      tmpQuery := MainForm.ActiveSQL('select * from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 3 order by id_order');
  end;
  indexPos := 1;
  timerStart.Enabled := false;
  if LoopCount <> 0 then
  begin
    while NOT tmpQuery.Eof do
    begin
      HintText := tmpQuery.FieldByName('hint_component').AsString;
      case tmpQuery.FieldByName('id_component').AsInteger of
        1: // Position
          begin

            tmpPoint.X := Round(StrToInt(Copy(HintText, 1, Pos('-', HintText) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(HintText, Pos('-', HintText) + 1)));

            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;

          end;
        3: // Sleep
          begin
            sleep(HintText.ToInteger);
          end;
        2: // Click
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          end;
        4: // Page Down
          begin
            MainForm.PostKeyEx32(35, []);
          end;

        8: // Ctrl + A
          begin
            MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
          end;
        9: // Ctrl + C
          begin
            MainForm.PostKeyEx32(Ord('C'), [ssctrl]);
          end;
        12: // Ctrl +V
          begin
            MainForm.PostKeyEx32(Ord('V'), [ssctrl]);
          end;

        16: // Enter
          begin
            MainForm.PostKeyEx32(13, []);
          end;
        17: // KeyEnter text
          begin
            s := AnsiUPPERCASE(HintText);
            if Lo(GetUserDefaultUILanguage) = LANG_RUSSIAN then
              s := ConvertToEng(s);

            for J := 1 to Length(s) do
            begin
              keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), 0, 0);
              keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), KEYEVENTF_KEYUP, 0);
            end;
          end;
        18: // Tabulation
          begin
            for I := 1 to ABS(HintText.ToInteger) do
            begin
              if HintText.ToInteger > 0 then
                MainForm.PostKeyEx32(9, [])
              else
                MainForm.PostKeyEx32(9, [ssshift]);
              sleep(1);
            end;
          end;

        14: // Get Language
          begin
            TranslateLangCode := '';
            tmpPoint.X := Round(StrToInt(Copy(HintText, 1, Pos('-', HintText) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(HintText, Pos('-', HintText) + 1)));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

            MainForm.PostKeyEx32(Ord('C'), [ssctrl]);

            sleep(200);
            TranslateLangCodeName := Svc.GetClipBoard.ToString;

            if TranslateLangCodeName <> '' then
            begin
              OldInd := MainForm.FrameSettName.cbLang.Selected.Index;
              MainForm.FrameSettName.QueryLang.Locate('lang_name', TranslateLangCodeName, [loPartialKey]);
              TranslateLangCode := MainForm.FrameSettName.QueryLang.FieldByName('lang_code').AsString;
              MainForm.FrameSettName.cbLang.ItemIndex := OldInd;
            end;
            sleep(200);
          end;

        13: // Translate
          begin
            if MainForm.IsTrial then
            begin
              SetCountLang(GetLastCount - 1);
              MainForm.labCountTrial.Text := GetLastCount.ToString;
            end;

            tmpPos := HintText;
            tmpCSP := Copy(tmpPos, 1, Pos(';', tmpPos));
            Delete(tmpPos, 1, Pos(';', tmpPos));
            tmpCTP := Copy(tmpPos, 1, Pos(';', tmpPos));
            Delete(tmpPos, 1, Pos(';', tmpPos));
            myLang := Copy(tmpPos, 1, Pos(';', tmpPos) - 1);
            Delete(tmpPos, 1, Pos(';', tmpPos));
            IsAutoData := Copy(tmpPos, 1).ToBoolean;

            if MainForm.FrameSettName.mName.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := Round(StrToInt(Copy(tmpCSP, 1, Pos('-', tmpCSP) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(tmpCSP, Pos('-', tmpCSP) + 1, Pos(';', tmpCSP) - 1 - Pos('-', tmpCSP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              MainForm.PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              MainForm.FrameSettName.mName.Text := Svc.GetClipBoard.ToString;
            end;

            if MainForm.FrameSettName.mDetails.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := Round(StrToInt(Copy(tmpCTP, 1, Pos('-', tmpCTP) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(tmpCTP, Pos('-', tmpCTP) + 1, Pos(';', tmpCTP) - 1 - Pos('-', tmpCTP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              MainForm.PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              MainForm.FrameSettName.mDetails.Text := Svc.GetClipBoard.ToString;
            end;

            // Название
            if TranslateLangCode <> '' then
            begin

              Svc.SetClipboard(Copy(GoogleTranslate(MainForm.FrameSettName.mName.Text, myLang, TranslateLangCode), 1, 100));
            end
            else
              Svc.SetClipboard('Перевед данного языка не поддерживается!!!');

            sleep(100);

            MainForm.PostKeyEx32(9, []);
            MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            MainForm.PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);

            // Описание
            if TranslateLangCode <> '' then
            begin
              Svc.SetClipboard(GoogleTranslate(MainForm.FrameSettName.mDetails.Text, myLang, TranslateLangCode));
            end
            else
              Svc.SetClipboard('');

            sleep(100);

            MainForm.PostKeyEx32(9, []);
            MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            MainForm.PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);
            MainForm.PostKeyEx32(9, []);
            MainForm.PostKeyEx32(13, []);

            if MainForm.IsTrial then
              if GetLastCount = 0 then
              begin
                timerStart.Enabled := false;
                timerSleepControl.Enabled := false;
                AutForm := TAuthorizationForm.Create(nil);
                AutForm.FormStyle := TFormStyle.StayOnTop;
                AutForm.ShowModal;
                AutForm.DisposeOf;
                exit;
              end;
          end;
      end;
      tmpQuery.Next;
    end;

    if timerStart.Interval <> 0 then
      timerStart.Enabled := true;

    Dec(LoopCount);
  end
  else
  begin
    sleep(1000);
    MainForm.PostKeyEx32(35, []);
    sleep(100);

    Self.Tag := 1;
    timerSleepControl.Enabled := false;
    timerStart.Enabled := false;

    if IsShow then
    begin
      Self.FormStyle := TFormStyle.StayOnTop;
      Self.Show;
    end
    else
      FormStartLang.Show;
  end;

end;

end.
