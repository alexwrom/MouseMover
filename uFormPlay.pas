unit uFormPlay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uTranslate, Winapi.Windows, uTranscriptions, uAuthorization, FMX.Platform,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uLoadFile, FMX.Objects, FMX.Effects, FMX.Controls.Presentation, Data.DB, FMX.StdCtrls;

type
  TFormPlay = class(TForm)
    Image1: TImage;
    btnStart: TSpeedButton;
    Image: TImage;
    GlowEffect9: TGlowEffect;
    btnStartLang: TSpeedButton;
    Image2: TImage;
    GlowEffect1: TGlowEffect;
    btnStartSubtitle: TSpeedButton;
    Image3: TImage;
    GlowEffect2: TGlowEffect;
    btnStartName: TSpeedButton;
    Image4: TImage;
    GlowEffect3: TGlowEffect;
    btnCloseApp: TSpeedButton;
    Image9: TImage;
    GlowEffect8: TGlowEffect;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    timerStart: TTimer;
    timerSleepControl: TTimer;
    procedure btnCloseAppClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure timerSleepControlTimer(Sender: TObject);
    procedure timerStartTimer(Sender: TObject);
    procedure btnStartLangClick(Sender: TObject);
    procedure btnStartNameClick(Sender: TObject);
    procedure btnStartSubtitleClick(Sender: TObject);
  private
    { Private declarations }
    OldPos: TPoint;
    LoopCount: integer;
    NonStop: Boolean;
    TranslateLangCode: string;
    Svc: IFMXClipboardService;

  public
    { Public declarations }
  end;

var
  FormPlay: TFormPlay;

implementation

uses uMain;
{$R *.fmx}

procedure TFormPlay.btnCloseAppClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormPlay.btnStartClick(Sender: TObject);
begin
  if (btnStart.Tag = 2) and (MainForm.FrameSettName.swGetData.IsChecked) and ((MainForm.FrameSettName.mName.Text = '') or (MainForm.FrameSettName.mDetails.Text = '')) then
  begin
    ShowMessage('У Вас выбран режим ручного ввода названия и описания. Одно из полей не заполнено. Заполните его в меню настроек и повторите.');
  end
  else
  begin
    MainForm.setkey(Lo(GetUserDefaultUILanguage), sublang_default);

    if (MainForm.lbLang.Count > 0) and (MainForm.lbNameDetail.Count > 0) and (MainForm.lbNameDetail.Count > 0) then
    begin
      Self.Hide;
      GetCursorPos(OldPos);
      LoopCount := 1;
      if (Sender = btnStart) then
        NonStop := true;

      if btnStart.Tag <> 1 then
        LoopCount := Round((MainForm.lbLang.Count - 1) / 9);
      timerStart.Interval := 500;
      timerStart.Enabled := true;
      timerSleepControl.Enabled := true;
    end;
  end;
end;

procedure TFormPlay.btnStartLangClick(Sender: TObject);
begin
  NonStop := false;
  btnStart.Tag := 1;
  btnStartClick(nil);
end;

procedure TFormPlay.btnStartNameClick(Sender: TObject);
begin
  NonStop := false;
  btnStart.Tag := 2;
  btnStartClick(nil);
end;

procedure TFormPlay.btnStartSubtitleClick(Sender: TObject);
begin
  NonStop := false;
  btnStart.Tag := 3;
  btnStartClick(nil);
end;

procedure TFormPlay.FormCreate(Sender: TObject);
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc);
end;

procedure TFormPlay.timerSleepControlTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if OldPos <> posXY then
  begin
    btnStart.Tag := 1;
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
begin
  case btnStart.Tag of
    1:
      MainForm.CurrListBox := MainForm.lbLang;
    2:
      MainForm.CurrListBox := MainForm.lbNameDetail;
    3:
      MainForm.CurrListBox := MainForm.lbSubtitles;
  end;

  timerStart.Enabled := false;
  if LoopCount <> 0 then
  begin
    for I := 0 to MainForm.CurrListBox.Count - 1 do
    begin
      case MainForm.CurrListBox.ListItems[I].Tag of
        itemPos:
          begin
            if Pos(';', MainForm.CurrListBox.ListItems[I].Hint) = 0 then
            begin
              tmpPoint.X := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, 1, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) + 1)));
            end
            else
            begin
              tmpPoint.X := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, 1, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) + 1, Pos(';', MainForm.CurrListBox.ListItems[I].Hint) - Pos('-', MainForm.CurrListBox.ListItems[I].Hint) - 1)));
            end;

            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;
          end;
        itemSleep:
          begin
            sleep(MainForm.CurrListBox.ListItems[I].Hint.ToInteger);
          end;
        itemClick:
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          end;
        itemScroll:
          begin
            mouse_event(MOUSEEVENTF_WHEEL, 0, 0, DWORD(MainForm.CurrListBox.ListItems[I].Hint.ToInteger), 0);
          end;

        itemDoubleClick:
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          end;

        itemCtrlA:
          begin
            MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
          end;
        itemCtrlC:
          begin
            MainForm.PostKeyEx32(Ord('C'), [ssctrl]);
          end;
        itemCtrlV:
          begin
            MainForm.PostKeyEx32(Ord('V'), [ssctrl]);
          end;

        itemEnter:
          begin
            MainForm.PostKeyEx32(13, [ssctrl]);
          end;
        itemText:
          begin
            s := AnsiUPPERCASE(MainForm.CurrListBox.ListItems[I].Hint);
            if Lo(GetUserDefaultUILanguage) = LANG_RUSSIAN then
              s := ConvertToEng(s);

            for J := 1 to Length(s) do
            begin
              keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), 0, 0);
              keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), KEYEVENTF_KEYUP, 0);
            end;
          end;

        itemGetLang:
          begin
            TranslateLangCode := '';
            tmpPoint.X := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, 1, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(MainForm.CurrListBox.ListItems[I].Hint, Pos('-', MainForm.CurrListBox.ListItems[I].Hint) + 1)));
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

        itemTranslate:
          begin
            if MainForm.IsTrial then
            begin
              SetCountLang(GetLastCount - 1);
              MainForm.labCountTrial.Text := GetLastCount.ToString;
            end;

            tmpPos := MainForm.CurrListBox.ListItems[I].Hint;
            tmpSP := Copy(tmpPos, 1, Pos(';', tmpPos));
            Delete(tmpPos, 1, Pos(';', tmpPos));
            tmpTP := Copy(tmpPos, 1, Pos(';', tmpPos));
            Delete(tmpPos, 1, Pos(';', tmpPos));
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
            tmpPoint.X := Round(StrToInt(Copy(tmpSP, 1, Pos('-', tmpSP) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(tmpSP, Pos('-', tmpSP) + 1, Pos(';', tmpSP) - 1 - Pos('-', tmpSP))));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

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
            tmpPoint.X := Round(StrToInt(Copy(tmpTP, 1, Pos('-', tmpTP) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(tmpTP, Pos('-', tmpTP) + 1, Pos(';', tmpTP) - 1 - Pos('-', tmpTP))));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

            MainForm.PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            MainForm.PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);

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
    end;

    if timerStart.Interval <> 0 then
      timerStart.Enabled := true;

    Dec(LoopCount);
  end
  else
  begin
    case btnStart.Tag of
      1:
        btnStart.Tag := 2;
      2:
        btnStart.Tag := 3;
      3:
        btnStart.Tag := 1;
    end;

    if (btnStart.Tag = 1) or (NOT NonStop) then
    begin
      btnStart.Tag := 1;
      timerSleepControl.Enabled := false;
      timerStart.Enabled := false;
      Self.FormStyle := TFormStyle.StayOnTop;
      Self.Show;
    end
    else
      btnStartClick(nil);
  end;

end;

end.
