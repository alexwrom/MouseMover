﻿unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uContact, uFrameSettLang, uStartSettingSubtitle,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus, uAuthorization, uFrameSettName, uStartSettingName,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, ShellAPI, uImages, Math, StrUtils, uFormPlay,
  FMX.TabControl, FMX.Edit, FMX.EditBox, FMX.NumberBox, Winapi.Windows, System.Threading,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, Messages, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Comp.UI,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, uLang, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.ImageList,
  FMX.ImgList, FMX.Objects, uLoadFile, shlobj, FMX.SpinBox, IdIPMCastBase, IdIPMCastServer, uUpdate, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Effects, FMX.MultiView,
  FMX.Filter.Effects, Data.DB;

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
    Conn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    ImageList: TImageList;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
    lbSubtitles: TListBox;
    lbNameDetail: TListBox;
    lbLang: TListBox;
    lvProfiles: TListView;
    queryProfiles: TFDQuery;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField4: TLinkFillControlToField;
    QueryObjects: TFDQuery;
    layTop: TLayout;
    Label3: TLabel;
    btnAddProfile: TSpeedButton;
    Image2: TImage;
    btnDelProfile: TSpeedButton;
    Image3: TImage;
    layBottom: TLayout;
    btnChangeProfile: TSpeedButton;
    Image1: TImage;
    btnCancelProfile: TSpeedButton;
    Image4: TImage;
    LinkFillControlToField5: TLinkFillControlToField;
    LinkFillControlToField6: TLinkFillControlToField;
    recAddProfile: TRectangle;
    ShadowEffect13: TShadowEffect;
    Layout5: TLayout;
    btnEnterName: TSpeedButton;
    Image13: TImage;
    btnCancelEnterName: TSpeedButton;
    Image14: TImage;
    edProfileName: TEdit;
    Label5: TLabel;
    layProfiles: TLayout;
    Image16: TImage;
    Layout1: TLayout;
    GlowEffect10: TGlowEffect;
    GlowEffect11: TGlowEffect;
    GlowEffect12: TGlowEffect;
    GlowEffect13: TGlowEffect;
    GlowEffect15: TGlowEffect;
    GlowEffect16: TGlowEffect;
    imgBackground: TImage;
    btnStart: TSpeedButton;
    Image: TImage;
    effectPlay: TMonochromeEffect;
    GlowEffect9: TGlowEffect;
    ShadowEffect7: TShadowEffect;
    btnCloseApp: TSpeedButton;
    Image9: TImage;
    GlowEffect8: TGlowEffect;
    btnGoTo: TSpeedButton;
    Image11: TImage;
    GlowEffect5: TGlowEffect;
    btnInfo: TSpeedButton;
    Image10: TImage;
    GlowEffect4: TGlowEffect;
    btnMove: TSpeedButton;
    Image12: TImage;
    GlowEffect2: TGlowEffect;
    Layout2: TLayout;
    btnMasterLeft: TSpeedButton;
    Image5: TImage;
    GlowEffect1: TGlowEffect;
    Label1: TLabel;
    labCountTrial: TLabel;
    Label17: TLabel;
    Layout3: TLayout;
    btnSettings: TSpeedButton;
    Image7: TImage;
    effectPlaySett: TGlowEffect;
    effectPlaySettMono: TMonochromeEffect;
    Label2: TLabel;
    btnSystem: TSpeedButton;
    Image8: TImage;
    GlowEffect3: TGlowEffect;
    Label4: TLabel;
    btnLicense: TSpeedButton;
    Image6: TImage;
    GlowEffect6: TGlowEffect;
    btnUpdate: TSpeedButton;
    Image15: TImage;
    GlowEffect7: TGlowEffect;
    laySettings: TLayout;
    editPosCursor: TEdit;
    Image17: TImage;
    Circle1: TCircle;
    layControl: TLayout;
    laySettSubtitle: TLayout;
    btnStartSettingSub: TCornerButton;
    btnItemSubtitle: TCornerButton;
    btnCloseSetting: TSpeedButton;
    Image18: TImage;
    GlowEffect14: TGlowEffect;
    btnItemLang: TCornerButton;
    effectSel: TGlowEffect;
    btnItemName: TCornerButton;
    Label6: TLabel;
    recTextInfo: TCalloutRectangle;
    labTextInfo: TLabel;
    ShadowEffect1: TShadowEffect;
    swOnOffInfo: TSwitch;
    Label8: TLabel;
    procedure timerGetPosTimer(Sender: TObject);
    procedure timerCheckTrackTimer(Sender: TObject);
    procedure btnTrackingStartClick(Sender: TObject);
    procedure OpenFiles(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGoToClick(Sender: TObject);
    procedure btnLicenseClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnChangeProfileClick(Sender: TObject);
    procedure btnCancelProfileClick(Sender: TObject);
    procedure btnCloseSettingClick(Sender: TObject);
    procedure btnStartSettingSubClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnSystemClick(Sender: TObject);
    procedure btnCloseAppClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnMoveMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure btnMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure btnDelProfileClick(Sender: TObject);
    procedure btnAddProfileClick(Sender: TObject);
    procedure btnCancelEnterNameClick(Sender: TObject);
    procedure btnMasterLeftClick(Sender: TObject);
    procedure btnEnterNameClick(Sender: TObject);
    procedure btnItemLangClick(Sender: TObject);
    procedure btnItemNameClick(Sender: TObject);
    procedure btnItemSubtitleClick(Sender: TObject);
    procedure swOnOffInfoSwitch(Sender: TObject);
  private

    TagTranslate: byte;

    MovePoint: TPoint;
    procedure ItemsClick(Sender: TObject);
    function GetUserAppPath: string;
    function IsLangExists: boolean;
    procedure LoadFileToListBox(idType: integer; lListBox: TListBox);


    { Private declarations }

  public
    IsTrial: boolean;
    UserName: string;
    Password: string;
    ProfileID: integer;
    CurrListBox: TListBox;
    FrameSettLang: TFrameSettLang;
    FrameSettName: TFrameSettName;
    procedure SetInfo(Sender: TControl; InfoText: String);
    function CreateItem(itemType: integer; ListBox: TListBox; defHint: string = ''): TListBoxItem;
    procedure PostKeyEx32(key: word; const Shift: TShiftState);
    procedure setkey(const langid, sublangid: word); overload;
    procedure SetHint(HintText: string);
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnAddProfileClick(Sender: TObject);
begin
  recAddProfile.Visible := true;
  layBottom.Enabled := false;
  layTop.Enabled := false;
  lvProfiles.Enabled := false;
  edProfileName.Text := '';

  SetInfo(btnEnterName,'Введите имя профиля и нажмите сюда, чтобы создать профиль');
end;

procedure TMainForm.btnCancelEnterNameClick(Sender: TObject);
begin
  recAddProfile.Visible := false;
  layBottom.Enabled := true;
  layTop.Enabled := true;
  lvProfiles.Enabled := true;
end;

procedure TMainForm.btnCancelProfileClick(Sender: TObject);
begin
  layProfiles.Visible := false;
  imgBackground.Visible := true;
end;

procedure TMainForm.btnChangeProfileClick(Sender: TObject);
begin

  if lvProfiles.Selected <> nil then
  begin
    ProfileID := lvProfiles.Items[lvProfiles.Selected.Index].Detail.ToInteger;
    OpenFiles(nil);
    layProfiles.Visible := false;
    imgBackground.Visible := true;
    btnMasterLeft.Text := lvProfiles.Items[lvProfiles.Selected.Index].Text;
    effectPlay.Enabled := false;
    btnStart.Enabled := true;
    effectPlaySettMono.Enabled := false;
    btnSettings.Enabled := true;
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

    SetInfo(btnSettings,'Нажмите сюда, чтобы нстроить профиль');
  end;
end;

procedure TMainForm.btnCloseAppClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.btnCloseSettingClick(Sender: TObject);
begin
  laySettings.Visible := false;
  imgBackground.Visible := true;
end;

procedure TMainForm.btnDelProfileClick(Sender: TObject);
var
  tmpQuery: TFDQuery;
begin
  if lvProfiles.Selected <> nil then
    if MessageDlg('Удалить выбранный профиль?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
    begin
      if lvProfiles.Items[lvProfiles.Selected.Index].Detail.ToInteger = ProfileID then
      begin
        effectPlaySettMono.Enabled := true;
        effectPlay.Enabled := true;
        btnStart.Enabled := false;
        btnSettings.Enabled := false;
      end;

      tmpQuery := TFDQuery.Create(nil);
      tmpQuery.Connection := Conn;
      tmpQuery.SQL.Add('delete from profiles where id_profile = ' + lvProfiles.Items[lvProfiles.Selected.Index].Detail + ';' + 'delete from objects where id_profile = ' + lvProfiles.Items[lvProfiles.Selected.Index].Detail + ';');
      tmpQuery.ExecSQL;
      tmpQuery.DisposeOf;
      queryProfiles.Active := false;
      queryProfiles.Active := true;

    end;
end;

procedure TMainForm.btnEnterNameClick(Sender: TObject);
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := Conn;
  tmpQuery.SQL.Add('insert into profiles (name) values (''' + edProfileName.Text + ''');' +
    'insert into objects (id_profile, id_type, id_component, hint_component, id_order) select (select max(id_profile) from profiles), id_type, id_component, hint_component, id_order from template;');
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;
  queryProfiles.Active := false;
  queryProfiles.Active := true;
  btnCancelEnterNameClick(nil);

  lvProfiles.Selected := lvProfiles.Items[lvProfiles.ItemCount - 1];
  SetInfo(btnChangeProfile, 'Нажмите сюда, чтобы выбрать профиль');
end;

procedure TMainForm.btnGoToClick(Sender: TObject);
begin
  ShellAPI.ShellExecute(0, 'Open', 'https://www.youtube.com/channel/UCD7uILhzRHyib6H25UtJpYw', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.btnInfoClick(Sender: TObject);
begin
  ContactForm.ShowModal;
end;

procedure TMainForm.btnItemLangClick(Sender: TObject);
begin
  effectSel.Parent := Sender as TCornerButton;
  FrameSettLang.Visible := true;
  FrameSettName.Visible := false;
  laySettSubtitle.Visible := false;
  lbLang.ClearSelection;
  lbLang.ListItems[0].IsSelected := true;
  CurrListBox := lbLang;
end;

procedure TMainForm.btnItemNameClick(Sender: TObject);
begin
  effectSel.Parent := Sender as TCornerButton;
  FrameSettLang.Visible := false;
  FrameSettName.Visible := true;
  laySettSubtitle.Visible := false;
  CurrListBox := lbNameDetail;

  MainForm.SetInfo(FrameSettName.cbLang,'Нажмите сюда, чтобы выбрать исходный язык перевода.');
end;

procedure TMainForm.btnItemSubtitleClick(Sender: TObject);
begin
  effectSel.Parent := Sender as TCornerButton;
  FrameSettLang.Visible := false;
  FrameSettName.Visible := false;
  laySettSubtitle.Visible := true;
  CurrListBox := lbSubtitles;
end;

procedure TMainForm.btnMasterLeftClick(Sender: TObject);
begin
  layProfiles.Visible := true;
  imgBackground.Visible := false;

  SetInfo(btnAddProfile, 'Нажмите сюда, чтобы создать новый профиль');
end;

procedure TMainForm.btnMoveMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  GetCursorPos(MovePoint);
end;

procedure TMainForm.btnMoveMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  tmpMouse: TPoint;
begin
  if (ssLeft in Shift) then
  begin
    GetCursorPos(tmpMouse);
    MainForm.Left := MainForm.Left + Round((tmpMouse.X) - (MovePoint.X));
    MainForm.Top := MainForm.Top + Round((tmpMouse.Y) - (MovePoint.Y));
  end;
  MovePoint := tmpMouse;
end;

procedure TMainForm.btnSettingsClick(Sender: TObject);
begin
  laySettings.Visible := true;
  imgBackground.Visible := false;
  CurrListBox := lbLang;

  SetInfo(FrameSettLang.btnSettLang,'Выберите необходимые языки, нажмите сюда, для настройки времени задержек');
end;

procedure TMainForm.SetInfo(Sender: TControl; InfoText: String);
begin
   recTextInfo.Parent := Sender;
    recTextInfo.Position.X := -recTextInfo.Width + 42 + Sender.Width / 2;
    recTextInfo.Position.Y := Sender.Height;
    labTextInfo.Text := InfoText;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  MainForm.Visible := false;
  SetInfo(FormPlay.btnStart,'Нажмите сюда, чтобы выполнить все или на кнопки слева, чтобы запустить раздельно.');
  recTextInfo.Position.Y :=  recTextInfo.Position.Y - 30;
  FormPlay.ShowModal;
  MainForm.Visible := true;

end;

procedure TMainForm.btnStartSettingSubClick(Sender: TObject);
begin

  MainForm.Hide;
  MainForm.SetInfo(FormStartSubtitle.btnStart, 'Нажмите сюда, чтобы начать настройку. Соблюдайте инструкцию.');
  MainForm.recTextInfo.Position.Y := MainForm.recTextInfo.Position.Y - 70;
  MainForm.recTextInfo.Position.X := MainForm.recTextInfo.Position.X - 50;
  FormStartSubtitle.ShowModal;

  MainForm.FormStyle := TFormStyle.StayOnTop;
  MainForm.Show;
  MainForm.FormStyle := TFormStyle.Normal;
end;

procedure TMainForm.btnSystemClick(Sender: TObject);
begin
  LangForm.ShowModal;
end;

procedure TMainForm.btnTrackingStartClick(Sender: TObject);
begin
  Self.Hide;
  TagTranslate := (Sender as TCornerButton).Tag;
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
          btnUpdate.Visible := true;
          imgBackground.MultiResBitmap[0].Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap
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
        labCountTrial.Text := '∞';
        btnLicense.Visible := false;

        break
      end
      else
      begin
        IsTrial := true;
        labCountTrial.Text := GetLastCount.ToString;

        if btnUpdate.Visible then
          imgBackground.MultiResBitmap[0].Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap
        else
          imgBackground.MultiResBitmap[0].Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
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
  FrameSettLang.Parent := layControl;
  FrameSettLang.QueryLang.Active := true;
  FrameSettLang.Visible := true;

  FrameSettName := TFrameSettName.Create(nil);
  FrameSettName.Parent := layControl;
  FrameSettName.QueryLang.Active := true;
  FrameSettName.Visible := false;

  swOnOffInfo.IsChecked := GetOnOffHelp;
  recTextInfo.Visible := swOnOffInfo.IsChecked;
end;

function TMainForm.GetUserAppPath: string;
var
  path: array [0 .. MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path);
  result := path + '\AutoClicker\';
end;

procedure TMainForm.btnLicenseClick(Sender: TObject);
var
  AutForm: TAuthorizationForm;
begin
  AutForm := TAuthorizationForm.Create(nil);
  AutForm.ShowModal;
  AutForm.DisposeOf;
end;

procedure TMainForm.btnUpdateClick(Sender: TObject);
var
  UpdForm: TUpdateForm;
begin
  if MessageDlg('После загрузки приложение будет закрыто. Скачать новую версию?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
  begin
    UpdForm := TUpdateForm.Create(nil);
    UpdForm.ShowModal;
    UpdForm.DisposeOf;
  end;
end;

procedure TMainForm.OpenFiles(Sender: TObject);
begin
  FrameSettName.mName.Text := '';
  FrameSettName.mDetails.Text := '';
  if CurrListBox <> nil then
    CurrListBox := nil;
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

procedure TMainForm.swOnOffInfoSwitch(Sender: TObject);
begin
   recTextInfo.Visible := swOnOffInfo.IsChecked;
   SetOnOffHelp(swOnOffInfo.IsChecked);
end;

procedure TMainForm.timerCheckTrackTimer(Sender: TObject);
begin
  if (CurrListBox = lbLang) or (CurrListBox = lbSubtitles) then
  begin
    CurrListBox.Selected.Hint := editPosCursor.Text
  end
  else
  begin
    if (CurrListBox.Selected.Tag = itemPos) or (CurrListBox.Selected.Tag = itemGetLang) then
      CurrListBox.Selected.Hint := editPosCursor.Text
    else if (CurrListBox.Selected.Tag = itemTranslate) then
      CurrListBox.Selected.Hint := FormStartName.edSourcePos.Text + ';' + FormStartName.edTargetPos.Text + ';' + FormStartName.edCurrentSourcePos.Text + ';' + FormStartName.edCurrentTargetPos.Text + ';' +
        Copy(FrameSettName.cbLang.Selected.Text, FrameSettName.cbLang.Selected.Text.Length - 2, 2) + ';' + FrameSettName.swGetData.IsChecked.ToString;
  end;

  if FrameSettName.Visible then
  begin
    FormStartName.tcSettName.Next();
    FormStartName.FormStyle := TFormStyle.StayOnTop;
    FormStartName.Show;
  end
  else if laySettSubtitle.Visible then
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
begin
  GetCursorPos(posXY);

  if (CurrListBox.Selected.Tag = itemPos) or (CurrListBox.Selected.Tag = itemGetLang) then
  begin
    if editPosCursor.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
    begin
      timerCheckTrack.Enabled := true;
    end
    else
    begin
      editPosCursor.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
      timerCheckTrack.Enabled := false;
    end;
  end
  else
    case TagTranslate of
      0:
        begin
          if FormStartName.edSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
          end;
        end;
      1:
        begin
          if FormStartName.edTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
          end;
        end;
      2:
        begin
          if FormStartName.edCurrentSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edCurrentSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
          end;
        end;
      3:
        begin
          if FormStartName.edCurrentTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            FormStartName.edCurrentTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
          end;
        end;
    end;
end;

procedure TMainForm.PostKeyEx32(key: word; const Shift: TShiftState);

type
  TShiftKeyInfo = record
    Shift: byte;
    vkey: byte;
  end;

  byteset = set of 0 .. 7;
const
  shiftkeys: array [1 .. 3] of TShiftKeyInfo = ((Shift: Ord(ssctrl); vkey: VK_CONTROL), (Shift: Ord(ssShift); vkey: VK_SHIFT), (Shift: Ord(ssAlt); vkey: VK_MENU));
var
  flag: DWORD;
  bShift: byteset absolute Shift;
  I: integer;
begin
  for I := 1 to 3 do
  begin
    if shiftkeys[I].Shift in bShift then
      keybd_event(shiftkeys[I].vkey, MapVirtualKey(shiftkeys[I].vkey, 0), 0, 0);
  end; { For }
  flag := 0;

  keybd_event(key, MapVirtualKey(key, 0), flag, 0);
  flag := flag or KEYEVENTF_KEYUP;
  keybd_event(key, MapVirtualKey(key, 0), flag, 0);

  for I := 3 downto 1 do
  begin
    if shiftkeys[I].Shift in bShift then
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

        LangStr := Copy(s, 1, 2);
        FrameSettName.QueryLang.Locate('lang_code', LangStr, []);
        FrameSettName.cbLang.ItemIndex := FrameSettName.QueryLang.FieldByName('row').AsInteger - 1;

        Delete(s, 1, Pos(';', s));
        FrameSettName.swGetData.IsChecked := ABS(s.ToInteger).ToBoolean;

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
