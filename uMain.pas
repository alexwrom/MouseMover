unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uContact, uFrameSettLang, uStartSettingSubtitle,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus, uAuthorization, uFrameSettName, uStartSettingName,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, ShellAPI, uImages, Math, StrUtils,
  FMX.TabControl, FMX.Edit, FMX.EditBox, FMX.NumberBox, Winapi.Windows, FMX.Platform, System.Threading,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, Messages, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Comp.UI,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, uTranslate, uLang, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.ImageList,
  FMX.ImgList, FMX.Objects, uLoadFile, shlobj, FMX.SpinBox, IdIPMCastBase, IdIPMCastServer, uUpdate, uTranscriptions, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Effects, FMX.MultiView,
  FMX.Filter.Effects;

const
  intInternalTimer = 100;

  itemPos = 1;
  itemClick = 2;
  itemSleep = 3;
  itemScroll = 4;
  itemSeparator = 5;
  itemDoubleClick = 7;
  itemCtrlA = 8;
  itemCtrlC = 9;
  itemCtrlV = 12;
  itemTranslate = 13;
  itemGetLang = 14;
  itemEnter = 16;
  itemText = 17;

  itemLang = 22;

type
  TMainForm = class(TForm)
    timerCheckTrack: TTimer;
    timerGetPos: TTimer;
    btnStart: TSpeedButton;
    timerStart: TTimer;
    timerSleepControl: TTimer;
    Conn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    MainMenu: TMainMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    ImageList: TImageList;
    Image: TImage;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    miLicense: TMenuItem;
    LinkFillControlToField2: TLinkFillControlToField;
    StatusBar: TStatusBar;
    miUpdate: TMenuItem;
    LinkFillControlToField3: TLinkFillControlToField;
    effectPlay: TShadowEffect;
    MultiViewLeft: TMultiView;
    btnMasterLeft: TSpeedButton;
    lbSubtitles: TListBox;
    lbNameDetail: TListBox;
    lbLang: TListBox;
    lvProfiles: TListView;
    queryProfiles: TFDQuery;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField4: TLinkFillControlToField;
    QueryObjects: TFDQuery;
    Layout1: TLayout;
    Label3: TLabel;
    btnAddProfile: TSpeedButton;
    Image2: TImage;
    ShadowEffect3: TShadowEffect;
    btnDelProfile: TSpeedButton;
    Image3: TImage;
    ShadowEffect4: TShadowEffect;
    Layout4: TLayout;
    btnChangeProfile: TSpeedButton;
    Image1: TImage;
    ShadowEffect2: TShadowEffect;
    btnCancelProfile: TSpeedButton;
    Image4: TImage;
    ShadowEffect5: TShadowEffect;
    MonochromeEffect1: TMonochromeEffect;
    Layout5: TLayout;
    btnSettings: TCornerButton;
    MultiViewSett: TMultiView;
    tcSettings: TTabControl;
    TabSettLang: TTabItem;
    TabSettName: TTabItem;
    TabSettSubtitle: TTabItem;
    LinkFillControlToField5: TLinkFillControlToField;
    LinkFillControlToField6: TLinkFillControlToField;
    editPosCursor: TEdit;
    Layout6: TLayout;
    btnCloseSetting: TCornerButton;
    Layout12: TLayout;
    btnStartSettingSub: TCornerButton;
    Label17: TLabel;
    labCountTrial: TLabel;
    btnGoTo: TSpeedButton;
    Image5: TImage;
    ShadowEffect1: TShadowEffect;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    procedure timerGetPosTimer(Sender: TObject);
    procedure timerCheckTrackTimer(Sender: TObject);
    procedure btnTrackingStartClick(Sender: TObject);
    procedure OpenFiles(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure timerStartTimer(Sender: TObject);
    procedure timerSleepControlTimer(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure btnGoToClick(Sender: TObject);
    procedure miLicenseClick(Sender: TObject);
    procedure miUpdateClick(Sender: TObject);
    procedure btnChangeProfileClick(Sender: TObject);
    procedure btnCancelProfileClick(Sender: TObject);
    procedure TabSettLangClick(Sender: TObject);
    procedure btnCloseSettingClick(Sender: TObject);
    procedure btnStartSettingSubClick(Sender: TObject);
    procedure TabSettNameClick(Sender: TObject);
    procedure TabSettSubtitleClick(Sender: TObject);
    procedure MultiViewSettShown(Sender: TObject);
  private
    LoopCount: integer;
    IsTrial: boolean;
    OldPos: TPoint;
    CurrLangCode: String;
    TranslateLangCode: string;
    TagTranslate: byte;
    Svc: IFMXClipboardService;

    procedure ItemsClick(Sender: TObject);
    function GetUserAppPath: string;
    function IsLangExists: boolean;
    procedure LoadFileToListBox(idType: integer; lListBox: TListBox);

    { Private declarations }

  public

    UserName: string;
    Password: string;
    ProfileID: integer;
    CurrListBox: TListBox;
    FrameSettLang: TFrameSettLang;
    FrameSettName: TFrameSettName;
    function CreateItem(itemType: integer; ListBox: TListBox; defHint: string = ''): TListBoxItem;
    procedure PostKeyEx32(key: word; const shift: TShiftState);
    procedure setkey(const langid, sublangid: word); overload;
    procedure SetHint(HintText: string);
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnCancelProfileClick(Sender: TObject);
begin
  MultiViewLeft.HideMaster;
end;

procedure TMainForm.btnChangeProfileClick(Sender: TObject);
begin

  if lvProfiles.Selected <> nil then
  begin
    ProfileID := lvProfiles.Items[lvProfiles.Selected.Index].Detail.ToInteger;
    OpenFiles(nil);
    MultiViewLeft.HideMaster;
    btnMasterLeft.Text := lvProfiles.Items[lvProfiles.Selected.Index].Text;
    effectPlay.Enabled := true;
    btnStart.Enabled := true;
    btnSettings.Enabled := true;
    FrameSettName.mName.Text := '';
    FrameSettName.mDetails.Text := '';

    CurrListBox := lbLang;
    lbLang.ClearSelection;
    lbLang.ListItems[0].IsSelected := true;
    ItemsClick(lbLang.ListItems[0]);

    CurrListBox := lbNameDetail;
    lbNameDetail.ClearSelection;
    lbNameDetail.ListItems[4].IsSelected := true;
    ItemsClick(lbNameDetail.ListItems[4]);
  end;
end;

procedure TMainForm.btnCloseSettingClick(Sender: TObject);
begin
  MultiViewSett.HideMaster;
end;

procedure TMainForm.btnGoToClick(Sender: TObject);
begin
  ShellAPI.ShellExecute(0, 'Open', 'https://www.youtube.com/channel/UCD7uILhzRHyib6H25UtJpYw', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  if (FrameSettName.swGetData.IsChecked) and ((FrameSettName.mName.Text = '') or (FrameSettName.mDetails.Text = '')) then
  begin
    ShowMessage('У Вас выбран режим ручного ввода названия и описания. Одно из полей пустое. Введите его в меню настроек.');
  end
  else
  begin
    setkey(Lo(GetUserDefaultUILanguage), sublang_default);

    if lbLang.Count > 0 then
    begin
      Self.Hide;
      GetCursorPos(OldPos);
      timerStart.Interval := 200;
      timerStart.Enabled := true;
      timerSleepControl.Enabled := true;
      btnStart.Tag := 1;
    end;
  end;
end;

procedure TMainForm.btnStartSettingSubClick(Sender: TObject);
begin
  MainForm.MultiViewSett.HideMaster;
  MainForm.Hide;
  FormStartSubtitle.ShowModal;

  MainForm.FormStyle := TFormStyle.StayOnTop;
  MainForm.Show;
  MainForm.FormStyle := TFormStyle.Normal;
  MainForm.MultiViewSett.ShowMaster;
end;

procedure TMainForm.btnTrackingStartClick(Sender: TObject);
begin
  MultiViewSett.HideMaster;
  Self.Hide;
  TagTranslate := (Sender as TSpeedButton).Tag;
  timerCheckTrack.Enabled := true;
  timerGetPos.Enabled := true;
end;

function TMainForm.CreateItem(itemType: integer; ListBox: TListBox; defHint: string = ''): TListBoxItem;
var
  newIndex: integer;
begin

  result := TListBoxItem.Create(nil);
  with result do
  begin

    StyledSettings := [];

    case itemType of
      itemLang:
        begin
          Text := 'Выбрать языки';
        end;
      itemText:
        Text := 'Набрать текст';
      itemEnter:
        Text := 'Клавиша "Ввод"';
      itemPos:
        begin
          if defHint <> '' then
            Text := Copy(defHint, Pos(';', defHint) + 1)
          else
            Text := 'Переместить курсор';
        end;
      itemSleep:
        begin
          Text := 'Пауза';
        end;
      itemClick:
        begin
          Text := 'Нажатие мыши';
        end;
      itemScroll:
        begin
          Text := 'Прокрутить колесом';
        end;
      itemSeparator:
        begin
          Text := '----' + defHint + '----';
          TextSettings.Font.Style := [TFontStyle.fsBold];
        end;

      itemCtrlA:
        begin
          Text := 'Выбрать все (Ctrl + A)';
        end;

      itemCtrlC:
        begin
          Text := 'Копировать (Ctrl + C)';
        end;
      itemCtrlV:
        begin
          Text := 'Вставить (Ctrl + V)';
        end;
      itemGetLang:
        begin

          Text := 'Получить язык';
        end;
      itemTranslate:
        begin
          Text := 'Перевести блок';
        end;
    end;

    Hint := defHint;
    showhint := true;
    Tag := itemType;

    OnClick := ItemsClick;
  end;

  ListBox.AddObject(result);

end;

function TMainForm.IsLangExists: boolean;
var
  I: integer;
begin
  result := false;
  for I := 0 to lbLang.Count - 1 do
    if lbLang.ListItems[I].Tag = itemLang then
    begin
      result := true;
      exit;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  FileName: string;
  FileTxt: TextFile;
  s: string;
  IsFindCode: boolean;
  AutForm: TAuthorizationForm;
  IsReadUpdate: boolean;
  IsReadSMTP: boolean;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc);
  Conn.Params.Database := GetUserAppPath + 'base.db';
  Conn.Connected := true;
  queryProfiles.Active := true;

  FileName := GetTempWindows + '\tmpMouseMover.txt';

  GetInetFile(FileName, 'https://drive.google.com/u/0/uc?id=1MSbOx0b9JO_il_wd_CkzUIcp4zXNgZpS&export=download');
  IsFindCode := false;
  IsReadUpdate := false;
  IsReadSMTP := false;
  if FileExists(FileName) then
  begin
    AssignFile(FileTxt, FileName);
    Reset(FileTxt);
    while NOT EOF(FileTxt) do
    begin

      // Проверка обновления
      if NOT IsReadUpdate then
      begin
        Readln(FileTxt, s);
        if Pos(s, Self.Caption) = 0 then
        begin
          ShowMessage('Для Вас доступно новое обновление. v' + s);
          miUpdate.Text := 'Обновить до версии ' + s;
          miUpdate.Visible := true;
        end;
        IsReadUpdate := true;
      end;
      // SMTP
      if NOT IsReadSMTP then
      begin
        Readln(FileTxt, s);
        UserName := Copy(s, Pos('Username:', s) + 9, Pos(';', s) - 10);
        Password := Copy(s, Pos('Password:', s) + 9);
        IsReadSMTP := true;
      end;
      // Проверка на наличие ключа
      Readln(FileTxt, s);
      if Pos(GetID, s) > 0 then
      begin
        IsFindCode := true;
        IsTrial := false;
        labCountTrial.Text := 'Безлимит';
        miLicense.Visible := false;
        break
      end
      else
      begin
        IsTrial := true;
        labCountTrial.Text := GetLastCount.ToString;
      end;
    end;
    CloseFile(FileTxt);
    Erase(FileTxt);
    if NOT IsFindCode then
    begin
      if GetLastCount = 0 then
      begin
        AutForm := TAuthorizationForm.Create(nil);
        AutForm.ShowModal;
        AutForm.DisposeOf;
      end
    end
  end;

  FrameSettLang := TFrameSettLang.Create(nil);
  FrameSettLang.Parent := TabSettLang;
  FrameSettLang.QueryLang.Active := true;

  FrameSettName := TFrameSettName.Create(nil);
  FrameSettName.Parent := TabSettName;
  FrameSettName.QueryLang.Active := true;
end;

function TMainForm.GetUserAppPath: string;
var
  path: array [0 .. MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path);
  result := path + '\MouseMover\';
end;

procedure TMainForm.miLicenseClick(Sender: TObject);
var
  AutForm: TAuthorizationForm;
begin
  AutForm := TAuthorizationForm.Create(nil);
  AutForm.ShowModal;
  AutForm.DisposeOf;
end;

procedure TMainForm.miUpdateClick(Sender: TObject);
var
  UpdForm: TUpdateForm;
begin
  if MessageDlg('После загрузки приложение будет закрыто. Убедитесь, что Вы сохранили все изменения. Продолжить?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
  begin
    UpdForm := TUpdateForm.Create(nil);
    UpdForm.ShowModal;
    UpdForm.DisposeOf;
  end;
end;

procedure TMainForm.MultiViewSettShown(Sender: TObject);
begin
  CurrListBox := lbLang;
end;

procedure TMainForm.OpenFiles(Sender: TObject);
begin
  LoadFileToListBox(1, lbLang);
  LoadFileToListBox(2, lbNameDetail);
  LoadFileToListBox(3, lbSubtitles);
end;

procedure TMainForm.LoadFileToListBox(idType: integer; lListBox: TListBox);
// begin

// TTask.Run( // uses System.Threading
// procedure
var
  I: integer;
  tmpQuery: TFDQuery;
  lText: string;
  itemID: integer;
begin
  lListBox.Clear;
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := Conn;
  tmpQuery.SQL := QueryObjects.SQL;
  tmpQuery.Active := false;
  tmpQuery.ParamByName('profile').Value := ProfileID;
  tmpQuery.ParamByName('type').Value := idType;
  tmpQuery.Active := true;
  tmpQuery.First;

  while NOT tmpQuery.EOF do
  begin
    itemID := tmpQuery.FieldByName('id_component').AsInteger;
    lText := tmpQuery.FieldByName('hint_component').AsString;

    case itemID of
      itemLang, itemSeparator, itemEnter, itemText, itemPos, itemClick, itemSleep, itemScroll, itemDoubleClick, itemCtrlA, itemCtrlC, itemCtrlV, itemTranslate, itemGetLang:
        begin
          try
            CreateItem(itemID, lListBox, lText);
          except
            OpenFiles(nil);
            exit;
          end;
        end;
    end;
    tmpQuery.Next;

  end;
  // TThread.Synchronize(nil,
  // procedure
  // begin
  tmpQuery.DisposeOf;
  // end);
  // end);

end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin
  LangForm.ShowModal;
end;

procedure TMainForm.setkey(const langid, sublangid: word);
var
  Layout: array [0 .. kl_namelength] of char;
  d: word;
  s: string;
begin
  d := (sublangid shl 10) or langid or (longint(0) shl 16);
  s := inttohex(d, 8);
  loadkeyboardlayout(strcopy(Layout, pchar(s)), klf_activate);
end;

procedure TMainForm.TabSettLangClick(Sender: TObject);
begin
  lbLang.ClearSelection;
  lbLang.ListItems[0].IsSelected := true;
  CurrListBox := lbLang;
end;

procedure TMainForm.TabSettNameClick(Sender: TObject);
begin
  CurrListBox := lbNameDetail;
end;

procedure TMainForm.TabSettSubtitleClick(Sender: TObject);
begin
  CurrListBox := lbSubtitles;
end;

procedure TMainForm.timerCheckTrackTimer(Sender: TObject);
begin
  if (CurrListBox = lbLang) or (CurrListBox = lbSubtitles) then
  begin
    CurrListBox.Selected.Hint := editPosCursor.Text
  end
  else
  begin
    if (CurrListBox.Selected.Tag = itemPos) then
      CurrListBox.Selected.Hint := editPosCursor.Text
    else if (CurrListBox.Selected.Tag = itemTranslate) then
      CurrListBox.Selected.Hint := FormStartName.edSourcePos.Text + ';' + FormStartName.edTargetPos.Text + ';' + FormStartName.edCurrentSourcePos.Text + ';' + FormStartName.edCurrentTargetPos.Text + ';' +
        Copy(FrameSettName.cbLang.Selected.Text, Pos('(', FrameSettName.cbLang.Selected.Text) + 1, 2) + ';' + FrameSettName.swGetData.IsChecked.ToString;
  end;

  if tcSettings.ActiveTab = TabSettName then
  begin
    FormStartName.tcSettName.Next();
    FormStartName.FormStyle := TFormStyle.StayOnTop;
    FormStartName.Show;
  end
  else if tcSettings.ActiveTab = TabSettSubtitle then
  begin
    FormStartSubtitle.tcSettSub.Next();
    FormStartSubtitle.FormStyle := TFormStyle.StayOnTop;
    FormStartSubtitle.Show;
  end
  else
  begin
    Self.FormStyle := TFormStyle.StayOnTop;
    Self.Show;
    Self.FormStyle := TFormStyle.Normal;
    MultiViewSett.ShowMaster;
  end;
  timerGetPos.Enabled := false;
  timerCheckTrack.Enabled := false;
  SetHint(CurrListBox.Selected.Hint);
end;

procedure TMainForm.SetHint(HintText: string);
var
  tmpQuery: TFDQuery;
  idType: integer;
begin
  CurrListBox.Selected.Hint := HintText;
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := Conn;

  if CurrListBox = lbLang then
    idType := 1
  else if CurrListBox = lbNameDetail then
    idType := 2
  else
    idType := 3;

  tmpQuery.SQL.Add('update objects set hint_component = ''' + HintText + ''' where id_profile = ' + ProfileID.ToString + ' and id_type = ' + idType.ToString + ' and id_order=' + (CurrListBox.Selected.Index + 1).ToString);
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;
end;

procedure TMainForm.timerGetPosTimer(Sender: TObject);
var
  posXY: TPoint;
  Seconds: double;
begin
  GetCursorPos(posXY);
  Seconds := 2.5;

  if (CurrListBox.Selected.Tag = itemPos) or (CurrListBox.Selected.Tag = itemGetLang) then
  begin
    if editPosCursor.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
    begin
      Seconds := Seconds - 0.1;
      timerCheckTrack.Enabled := true;
    end
    else
    begin
      editPosCursor.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
      timerCheckTrack.Enabled := false;
      Seconds := 2.5;
    end;
  end
  else
    case TagTranslate of
      0:
        begin
          if FormStartName.edSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            Seconds := Seconds - 0.1;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            Seconds := 2.5;
          end;
        end;
      1:
        begin
          if FormStartName.edTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            Seconds := Seconds - 0.1;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            Seconds := 2.5;
          end;
        end;
      2:
        begin
          if FormStartName.edCurrentSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            Seconds := Seconds - 0.1;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edCurrentSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            Seconds := 2.5;
          end;
        end;
      3:
        begin
          if FormStartName.edCurrentTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            Seconds := Seconds - 0.1;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edCurrentTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            Seconds := 2.5;
          end;
        end;
    end;
end;

procedure TMainForm.timerSleepControlTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if OldPos <> posXY then
  begin
    btnStartClick(nil);
    timerSleepControl.Enabled := false;
    timerStart.Enabled := false;
    Self.FormStyle := TFormStyle.StayOnTop;
    Self.Show;
    Self.FormStyle := TFormStyle.Normal;
  end;
  OldPos := posXY;
end;

procedure TMainForm.timerStartTimer(Sender: TObject);
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
  IsAutoData: boolean;
  OldInd: integer;
begin
  timerStart.Enabled := false;
  LoopCount := ROUND((lbLang.Count - 1) / 9);
  if LoopCount <> 0 then
  begin
    for I := 0 to lbLang.Count - 1 do
    begin
      case lbLang.ListItems[I].Tag of
        itemPos:
          begin
            if Pos(';', lbLang.ListItems[I].Hint) = 0 then
            begin
              tmpPoint.X := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, 1, Pos('-', lbLang.ListItems[I].Hint) - 1)));
              tmpPoint.Y := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, Pos('-', lbLang.ListItems[I].Hint) + 1)));
            end
            else
            begin
              tmpPoint.X := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, 1, Pos('-', lbLang.ListItems[I].Hint) - 1)));
              tmpPoint.Y := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, Pos('-', lbLang.ListItems[I].Hint) + 1, Pos(';', lbLang.ListItems[I].Hint) - Pos('-', lbLang.ListItems[I].Hint) - 1)));
            end;

            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;
          end;
        itemSleep:
          begin
            sleep(lbLang.ListItems[I].Hint.ToInteger);
          end;
        itemClick:
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          end;
        itemScroll:
          begin
            mouse_event(MOUSEEVENTF_WHEEL, 0, 0, DWORD(lbLang.ListItems[I].Hint.ToInteger), 0);
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
            PostKeyEx32(Ord('A'), [ssctrl]);
          end;
        itemCtrlC:
          begin
            PostKeyEx32(Ord('C'), [ssctrl]);
          end;
        itemCtrlV:
          begin
            PostKeyEx32(Ord('V'), [ssctrl]);
          end;

        itemEnter:
          begin
            PostKeyEx32(13, [ssctrl]);
          end;
        itemText:
          begin
            s := AnsiUPPERCASE(lbLang.ListItems[I].Hint);
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
            tmpPoint.X := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, 1, Pos('-', lbLang.ListItems[I].Hint) - 1)));
            tmpPoint.Y := ROUND(StrToInt(Copy(lbLang.ListItems[I].Hint, Pos('-', lbLang.ListItems[I].Hint) + 1)));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

            PostKeyEx32(Ord('C'), [ssctrl]);

            sleep(200);
            TranslateLangCodeName := Svc.GetClipBoard.ToString;

            if TranslateLangCodeName <> '' then
            begin
              OldInd := FrameSettName.cbLang.Selected.Index;
              FrameSettName.QueryLang.Locate('lang_name', TranslateLangCodeName, [loPartialKey]);
              TranslateLangCode := FrameSettName.QueryLang.FieldByName('lang_code').AsString;
              FrameSettName.cbLang.ItemIndex := OldInd;
            end;
            sleep(200);
          end;

        itemTranslate:
          begin
            if IsTrial then
            begin
              SetCountLang(GetLastCount - 1);
              labCountTrial.Text := GetLastCount.ToString;
            end;

            tmpPos := lbLang.ListItems[I].Hint;
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

            if FrameSettName.mName.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := ROUND(StrToInt(Copy(tmpCSP, 1, Pos('-', tmpCSP) - 1)));
              tmpPoint.Y := ROUND(StrToInt(Copy(tmpCSP, Pos('-', tmpCSP) + 1, Pos(';', tmpCSP) - 1 - Pos('-', tmpCSP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              FrameSettName.mName.Text := Svc.GetClipBoard.ToString;
            end;

            if FrameSettName.mDetails.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := ROUND(StrToInt(Copy(tmpCTP, 1, Pos('-', tmpCTP) - 1)));
              tmpPoint.Y := ROUND(StrToInt(Copy(tmpCTP, Pos('-', tmpCTP) + 1, Pos(';', tmpCTP) - 1 - Pos('-', tmpCTP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              FrameSettName.mDetails.Text := Svc.GetClipBoard.ToString;
            end;

            // Название
            if TranslateLangCode <> '' then
            begin

              Svc.SetClipboard(Copy(GoogleTranslate(FrameSettName.mName.Text, myLang, TranslateLangCode), 1, 100));
            end
            else
              Svc.SetClipboard('Перевед данного языка не поддерживается!!!');

            sleep(100);
            tmpPoint.X := ROUND(StrToInt(Copy(tmpSP, 1, Pos('-', tmpSP) - 1)));
            tmpPoint.Y := ROUND(StrToInt(Copy(tmpSP, Pos('-', tmpSP) + 1, Pos(';', tmpSP) - 1 - Pos('-', tmpSP))));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

            PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);

            // Описание
            if TranslateLangCode <> '' then
            begin
              Svc.SetClipboard(GoogleTranslate(FrameSettName.mDetails.Text, myLang, TranslateLangCode));
            end
            else
              Svc.SetClipboard('');

            sleep(100);
            tmpPoint.X := ROUND(StrToInt(Copy(tmpTP, 1, Pos('-', tmpTP) - 1)));
            tmpPoint.Y := ROUND(StrToInt(Copy(tmpTP, Pos('-', tmpTP) + 1, Pos(';', tmpTP) - 1 - Pos('-', tmpTP))));
            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;

            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);

            PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);

            if IsTrial then
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
    timerSleepControl.Enabled := false;
    timerStart.Enabled := false;
    Self.FormStyle := TFormStyle.StayOnTop;
    Self.Show;
    Self.FormStyle := TFormStyle.Normal;
  end;
end;

procedure TMainForm.PostKeyEx32(key: word; const shift: TShiftState);

type
  TShiftKeyInfo = record
    shift: byte;
    vkey: byte;
  end;

  byteset = set of 0 .. 7;
const
  shiftkeys: array [1 .. 3] of TShiftKeyInfo = ((shift: Ord(ssctrl); vkey: VK_CONTROL), (shift: Ord(ssShift); vkey: VK_SHIFT), (shift: Ord(ssAlt); vkey: VK_MENU));
var
  flag: DWORD;
  bShift: byteset absolute shift;
  I: integer;
begin
  for I := 1 to 3 do
  begin
    if shiftkeys[I].shift in bShift then
      keybd_event(shiftkeys[I].vkey, MapVirtualKey(shiftkeys[I].vkey, 0), 0, 0);
  end; { For }
  flag := 0;

  keybd_event(key, MapVirtualKey(key, 0), flag, 0);
  flag := flag or KEYEVENTF_KEYUP;
  keybd_event(key, MapVirtualKey(key, 0), flag, 0);

  for I := 3 downto 1 do
  begin
    if shiftkeys[I].shift in bShift then
      keybd_event(shiftkeys[I].vkey, MapVirtualKey(shiftkeys[I].vkey, 0), KEYEVENTF_KEYUP, 0);
  end; { For }
end; { PostKeyEx32 }

procedure TMainForm.ItemsClick(Sender: TObject);
var
  s: string;
  tmp: string;
  I: integer;
  LangStr: string;
begin
  case (Sender as TListBoxItem).Tag of
    itemTranslate:
      begin
        s := (Sender as TListBoxItem).Hint;
        FormStartName.edSourcePos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        FormStartName.edTargetPos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        FormStartName.edCurrentSourcePos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        FormStartName.edCurrentTargetPos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));

        if Pos(';', s) = 0 then
          FrameSettName.QueryLang.Locate('lang_code', s, [])
        else
        begin
          LangStr := Copy(s, 1, Pos(';', s) - 1);
          FrameSettName.QueryLang.Locate('lang_code', LangStr, []);
          Delete(s, 1, Pos(';', s));
          FrameSettName.swGetData.IsChecked := s.ToBoolean;
        end;
        FrameSettName.cbLang.ItemIndex := FrameSettName.QueryLang.FieldByName('row').AsInteger - 1;
      end;

    itemLang:
      begin
        FrameSettLang.ListViewLang.Items.CheckAll(false);
        s := (Sender as TListBoxItem).Hint;
        try
          FrameSettLang.sbLangBtnPause.Value := Copy(s, 1, Pos(';', s) - 1).ToInteger;
          Delete(s, 1, Pos(';', s));
        except
        end;

        try
          FrameSettLang.sbLangAddPause.Value := Copy(s, 1, Pos(';', s) - 1).ToInteger;
          Delete(s, 1, Pos(';', s));
        except
        end;

        while Length(s) > 0 do
        begin
          tmp := Copy(s, Pos(';', s) - 3, 2);
          Delete(s, 1, Pos(';', s));
          for I := 0 to FrameSettLang.ListViewLang.Items.Count - 1 do
            if FrameSettLang.ListViewLang.Items[I].Detail = tmp then
              if NOT FrameSettLang.ListViewLang.Items[I].Checked then
                FrameSettLang.ListViewLang.Items[I].Checked := true;
        end;
      end;
  end;

end;

end.
