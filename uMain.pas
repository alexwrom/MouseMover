unit uMain;

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
  FMX.Filter.Effects, Data.DB, uUtils;

const
  intInternalTimer = 100;

type
  TMainForm = class(TForm)
    timerCheckTrack: TTimer;
    timerGetPos: TTimer;
    Conn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkFillControlToField2: TLinkFillControlToField;
    LinkFillControlToField3: TLinkFillControlToField;
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
    Layout5: TLayout;
    btnEnterName: TSpeedButton;
    Image13: TImage;
    btnCancelEnterName: TSpeedButton;
    Image14: TImage;
    edProfileName: TEdit;
    Label5: TLabel;
    layProfiles: TLayout;
    Layout1: TLayout;
    btnStart: TSpeedButton;
    Image: TImage;
    effectPlay: TMonochromeEffect;
    GlowEffect9: TGlowEffect;
    btnCloseApp: TSpeedButton;
    Image9: TImage;
    btnGoTo: TSpeedButton;
    Image11: TImage;
    GlowEffect5: TGlowEffect;
    btnInfo: TSpeedButton;
    Image10: TImage;
    btnMove: TSpeedButton;
    Image12: TImage;
    btnMasterLeft: TSpeedButton;
    Image5: TImage;
    Label1: TLabel;
    labCountTrial: TLabel;
    Label17: TLabel;
    btnSettings: TSpeedButton;
    Image7: TImage;
    effectPlaySettMono: TMonochromeEffect;
    Label2: TLabel;
    btnSystem: TSpeedButton;
    Image8: TImage;
    Label4: TLabel;
    btnLicense: TSpeedButton;
    Image6: TImage;
    btnUpdate: TSpeedButton;
    Image15: TImage;
    laySettings: TLayout;
    editPosCursor: TEdit;
    layControl: TLayout;
    laySettSubtitle: TLayout;
    btnStartSettingSub: TCornerButton;
    btnItemSubtitle: TCornerButton;
    btnItemLang: TCornerButton;
    effectSel: TGlowEffect;
    btnItemName: TCornerButton;
    Label6: TLabel;
    Image28: TImage;
    imgBackground: TRectangle;
    ShadowEffect2: TShadowEffect;
    Layout3: TLayout;
    Layout6: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    labAppName: TLabel;
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    Rectangle2: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    btnCloseSetting: TSpeedButton;
    Image16: TImage;
    Label9: TLabel;
    ShadowSub: TShadowEffect;
    ShadowName: TShadowEffect;
    ShadowLang: TShadowEffect;
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
    function GetUserAppPath: string;
    function GetTypeId(lBlockType: TBlockType): string;

    { Private declarations }

  public
    itemType: TItemType;
    blockType: TBlockType;
    OrderId: integer;
    IsTrial: boolean;
    UserName: string;
    Password: string;
    ProfileID: integer;
    FrameSettLang: TFrameSettLang;
    FrameSettName: TFrameSettName;

    function GetCountLang: integer;
    function ActiveSQL(SQL: string): TFDQuery;
    procedure ExeSQL(SQL: string);
    procedure SetInfo(Sender: TControl; InfoText: String);
    procedure PostKeyEx32(key: word; const Shift: TShiftState);
    procedure setkey(const langid, sublangid: word); overload;
    procedure SetHint(lText: string);
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

  SetInfo(btnEnterName, 'Введите имя профиля и нажмите сюда, чтобы создать профиль');
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
var
  s: string;
  tmp: string;
  I: integer;
  LangStr: string;
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
    FrameSettLang.ListViewLang.Items.CheckAll(false);

    s := ActiveSQL('select hint_component from objects where id_profile = ' + ProfileID.ToString + ' and id_type = 1 and id_order = 1').FieldByName('hint_component').AsString;
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

    // Загружаем настройки переводов
    s := ActiveSQL('select hint_component from objects where id_profile = ' + ProfileID.ToString + ' and id_type = 2 and id_order = 5').FieldByName('hint_component').AsString;
    FormStartName.edCurrentSourcePos.Text := Copy(s, 1, Pos(';', s) - 1);
    Delete(s, 1, Pos(';', s));
    FormStartName.edCurrentTargetPos.Text := Copy(s, 1, Pos(';', s) - 1);
    Delete(s, 1, Pos(';', s));

    LangStr := Copy(s, 1, 2);
    FrameSettName.QueryLang.Locate('lang_code', LangStr, []);
    FrameSettName.cbLang.ItemIndex := FrameSettName.QueryLang.FieldByName('row').AsInteger - 1;

    Delete(s, 1, Pos(';', s));
    FrameSettName.swGetData.IsChecked := ABS(s.ToInteger).ToBoolean;

    SetInfo(btnSettings, 'Нажмите сюда, чтобы настроить профиль');
  end;
end;

function TMainForm.GetCountLang: integer;
begin
  result := ActiveSQL('select ROUND((Count(*) - 1) / 6) as cnt from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1').FieldByName('cnt').AsInteger;
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

begin
  ExeSQL('insert into profiles (name) values (''' + edProfileName.Text + ''');' +
    'insert into objects (id_profile, id_type, id_component, hint_component, id_order) select (select max(id_profile) from profiles), id_type, id_component, hint_component, id_order from template;');
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
  ShadowLang.Enabled := false;
  ShadowName.Enabled := true;
  ShadowSub.Enabled := true;
  FrameSettLang.Visible := true;
  FrameSettName.Visible := false;
  laySettSubtitle.Visible := false;
end;

procedure TMainForm.btnItemNameClick(Sender: TObject);
begin
  effectSel.Parent := Sender as TCornerButton;
  ShadowLang.Enabled := true;
  ShadowName.Enabled := false;
  ShadowSub.Enabled := true;
  FrameSettLang.Visible := false;
  FrameSettName.Visible := true;
  laySettSubtitle.Visible := false;

  MainForm.SetInfo(FrameSettName.cbLang, 'Нажмите сюда, чтобы выбрать исходный язык перевода.');
end;

procedure TMainForm.btnItemSubtitleClick(Sender: TObject);
begin
  effectSel.Parent := Sender as TCornerButton;
  ShadowLang.Enabled := true;
  ShadowName.Enabled := true;
  ShadowSub.Enabled := false;
  FrameSettLang.Visible := false;
  FrameSettName.Visible := false;
  laySettSubtitle.Visible := true;
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
  SetInfo(FrameSettLang.btnSettLang, 'Выберите необходимые языки, нажмите сюда, для настройки времени задержек');
end;

procedure TMainForm.SetInfo(Sender: TControl; InfoText: String);
begin
  recTextInfo.Parent := Sender;
  recTextInfo.Position.X := -recTextInfo.Width / 2 + Sender.Width / 2;
  recTextInfo.Position.Y := Sender.Height;
  labTextInfo.Text := InfoText;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  MainForm.Visible := false;
  SetInfo(FormPlay.btnStartLang, 'Нажмите сюда, чтобы выполнить заполнение языков.');
  recTextInfo.Position.Y := recTextInfo.Position.Y - 30;
  FormPlay.ShowModal;
  MainForm.Visible := true;

end;

procedure TMainForm.btnStartSettingSubClick(Sender: TObject);
begin

  Hide;
  SetInfo(FormStartSubtitle.btnStart, 'Нажмите сюда, чтобы начать настройку. Соблюдайте инструкцию.');

  FormStartSubtitle.sleepTime.Text := ActiveSQL('select hint_component from objects where id_profile = ' + ProfileID.ToString + ' and id_type= 3 and id_order = 3').FieldByName('hint_component').AsString;
  FormStartSubtitle.sbPauseTwo.Text := ActiveSQL('select hint_component from objects where id_profile = ' + ProfileID.ToString + ' and id_type= 3 and id_order = 6').FieldByName('hint_component').AsString;
  FormStartSubtitle.sleepLoop.Text := ActiveSQL('select hint_component from objects where id_profile = ' + ProfileID.ToString + ' and id_type= 3 and id_order = 9').FieldByName('hint_component').AsString;
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

  Conn.Params.Database := GetUserAppPath + 'library.dll';
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
        if Pos(s, labAppName.Text) = 0 then
        begin
          ShowMessage('Для Вас доступно новое обновление. v' + s);
          btnUpdate.Visible := true;
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
        labCountTrial.Visible := false;
        btnLicense.Visible := false;

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
var
  tmpText: string;
begin
  if (blockType = blockLang) or (blockType = blockSubtitle) then
  begin
    SetHint(editPosCursor.Text);
  end
  else
  begin
    if (itemType = itemPos) or (itemType = itemGetLang) then
      SetHint(editPosCursor.Text)
    else if (itemType = itemTranslate) then
    begin
      tmpText := FormStartName.edCurrentSourcePos.Text + ';' + FormStartName.edCurrentTargetPos.Text + ';' + Copy(FrameSettName.cbLang.Selected.Text, FrameSettName.cbLang.Selected.Text.Length - 2, 2) + ';' +
        FrameSettName.swGetData.IsChecked.ToString;
      SetHint(tmpText);
    end;
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
end;

procedure TMainForm.ExeSQL(SQL: string);
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := MainForm.Conn;
  tmpQuery.SQL.Add(SQL);
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;
end;

function TMainForm.ActiveSQL(SQL: string): TFDQuery;
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := MainForm.Conn;
  tmpQuery.SQL.Add(SQL);
  tmpQuery.Active := true;
  result := tmpQuery;
end;

procedure TMainForm.SetHint(lText: string);
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := Conn;

  tmpQuery.SQL.Add('update objects set hint_component = ''' + lText + ''' where id_profile = ' + ProfileID.ToString + ' and id_type = ' + GetTypeId(blockType) + ' and id_order=' + OrderId.ToString);
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;
end;

function TMainForm.GetTypeId(lBlockType: TBlockType): string;
begin
  result := '0';
  case lBlockType of
    blockLang:
      result := '1';
    blockName:
      result := '2';
    blockSubtitle:
      result := '3';
  end;
  { case lItemType of
    itemPos:
    result := '1';
    itemSleep:
    result := '3';
    itemScroll:
    result := '4';
    itemTranslate:
    result := '13';
    itemGetLang:
    result := '14';
    itemText:
    result := '17';
    itemLang:
    result := '22';
    end; }
end;

procedure TMainForm.timerGetPosTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if (itemType = itemPos) or (itemType = itemGetLang) then
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

end.
