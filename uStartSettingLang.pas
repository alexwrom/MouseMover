unit uStartSettingLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows, FMX.ListBox, uTranscriptions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TFormStartLang = class(TForm)
    btnStart: TCornerButton;
    timerCheckTrack: TTimer;
    timerGetPos: TTimer;
    labText: TLabel;
    Layout1: TLayout;
    btnApplyAll: TCornerButton;
    btnCancel: TCornerButton;
    Image1: TImage;
    Rectangle5: TRectangle;
    procedure btnStartClick(Sender: TObject);
    procedure timerGetPosTimer(Sender: TObject);
    procedure timerCheckTrackTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApplyAllClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    CountLang: integer;
    CurrItem: integer;
    PosClick: string;
    LangText: string;
    IsShowing: boolean;
    procedure FindNextItemPos;
  public
    { Public declarations }
  end;

var
  FormStartLang: TFormStartLang;

implementation

uses uMain;

{$R *.fmx}

procedure TFormStartLang.btnApplyAllClick(Sender: TObject);
var
  I: integer;
  s: string;
  J: integer;
  tmpPoint: TPoint;
begin
  Self.Hide;
  for I := MainForm.lbLang.Selected.Index + 1 to MainForm.lbLang.Count - 1 do
    if MainForm.lbLang.ListItems[I].Tag = itemPos then
    begin
      MainForm.lbLang.ClearSelection;
      MainForm.lbLang.ListItems[I].IsSelected := TRUE;
      LangText := MainForm.lbLang.ListItems[I + 3].Hint;
      MainForm.lbLang.ListItems[I].Hint := PosClick;

      tmpPoint.X := Round(StrToInt(Copy(PosClick, 1, Pos('-', PosClick) - 1)));
      tmpPoint.Y := Round(StrToInt(Copy(PosClick, Pos('-', PosClick) + 1)));

      SetCursorPos(tmpPoint.X, tmpPoint.Y);

      MainForm.setkey(Lo(GetUserDefaultUILanguage), sublang_default);

      mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
      mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
      sleep(1000);

      s := AnsiUPPERCASE(LangText);
      if Lo(GetUserDefaultUILanguage) = LANG_RUSSIAN then
        s := ConvertToEng(s);

      for J := 1 to Length(s) do
      begin
        keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), 0, 0);
        keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), KEYEVENTF_KEYUP, 0);
      end;

      MainForm.PostKeyEx32(13, [ssctrl]);
      sleep(300);
      mouse_event(MOUSEEVENTF_WHEEL, 0, 0, DWORD(-10000), 0);
      sleep(500);
    end;
  btnStart.Visible := false;
  btnApplyAll.Visible := false;
  labText.Text := 'Настройка языков завершена.';
  btnCancel.Visible := TRUE;
  Self.FormStyle := TFormStyle.StayOnTop;
  Self.Show;
end;

procedure TFormStartLang.btnCancelClick(Sender: TObject);
begin
  labText.Text := 'Перед началом настройки языков откройте в браузере Youtube Studio и перейдите в настройки субтитров на одном из Ваших новых видео.' +
    ' Затем вернитесь в программу и нажав кнопку "Начать" наведите на кнопку в браузере "ДОБАВИТЬ ПЕРЕВОД НА ДРУГОЙ ЯЗЫК".';
  btnStart.Text := 'Начать';
  Self.Close;
end;

procedure TFormStartLang.btnStartClick(Sender: TObject);
begin
  PosClick := '0-0';
  Self.Hide;
  timerCheckTrack.Enabled := TRUE;
  timerGetPos.Enabled := TRUE;
  btnStart.Text := 'Следующий язык';
end;

procedure TFormStartLang.timerCheckTrackTimer(Sender: TObject);
var
  s: string;
  J: integer;
begin

  MainForm.lbLang.Selected.Hint := PosClick;

  timerGetPos.Enabled := false;
  timerCheckTrack.Enabled := false;

  //
  MainForm.setkey(Lo(GetUserDefaultUILanguage), sublang_default);

  mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
  mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  sleep(1000);

  s := AnsiUPPERCASE(LangText);
  if Lo(GetUserDefaultUILanguage) = LANG_RUSSIAN then
    s := ConvertToEng(s);

  for J := 1 to Length(s) do
  begin
    keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), 0, 0);
    keybd_event(Ord(s[J]), MapVirtualKey(Ord(s[J]), 0), KEYEVENTF_KEYUP, 0);
  end;

  MainForm.PostKeyEx32(13, [ssctrl]);
  sleep(300);
  mouse_event(MOUSEEVENTF_WHEEL, 0, 0, DWORD(-10000), 0);
  sleep(500);

  Self.FormStyle := TFormStyle.StayOnTop;
  Self.Show;
  MainForm.SetHint(MainForm.CurrListBox.Selected.Hint);
  FindNextItemPos;
end;

procedure TFormStartLang.FindNextItemPos;
var
  I: integer;
begin
  for I := MainForm.lbLang.Selected.Index + 1 to MainForm.lbLang.Count - 1 do
    if MainForm.lbLang.ListItems[I].Tag = itemPos then
    begin
      MainForm.lbLang.ClearSelection;
      MainForm.lbLang.ListItems[I].IsSelected := TRUE;
      LangText := MainForm.lbLang.ListItems[I + 3].Hint;

      if IsShowing then
        labText.Text := 'Следующий язык "' + MainForm.lbLang.ListItems[I + 3].Hint + '".';

      if I >= 12 * 9 then
      begin
        labText.Text := labText.Text + #13#13 + 'Если Вы заметили, что кнопка "ДОБАВИТЬ ПЕРЕВОД НА ДРУГОЙ ЯЗЫК" не меняет своего положения, то нажмите на кнопку "Применить для остальных".';
        btnApplyAll.Visible := TRUE;
      end;
      break;
    end;

  if I = MainForm.lbLang.Count then
  begin
    btnStart.Visible := false;
    btnApplyAll.Visible := false;
    labText.Text := 'Настройка языков завершена.';
    btnCancel.Visible := TRUE;
  end;
end;

procedure TFormStartLang.FormShow(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbLang;
  if NOT IsShowing then
  begin
    if MainForm.lbLang.Count > 1 then
    begin
      MainForm.lbLang.ListItems[0].IsSelected := TRUE;
      FindNextItemPos;
      labText.Text := labText.Text + #13 + 'Начните настройку c языка "' + MainForm.lbLang.ListItems[MainForm.lbLang.Selected.Index + 3].Hint + '"';
    end;

    IsShowing := TRUE;
  end;
end;

procedure TFormStartLang.timerGetPosTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if PosClick = posXY.X.ToString + '-' + posXY.Y.ToString then
  begin
    btnStart.Hint := (StrToFloat(btnStart.Hint) - 0.1).ToString;
    timerCheckTrack.Enabled := TRUE;
  end
  else
  begin
    PosClick := posXY.X.ToString + '-' + posXY.Y.ToString;
    timerCheckTrack.Enabled := false;
    btnStart.Hint := '1';
  end;

end;

end.
