unit uMainOld;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uContact,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus, uAuthorization,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, ShellAPI, uImages, Math,StrUtils,
  FMX.TabControl, FMX.Edit, FMX.EditBox, FMX.NumberBox, Winapi.Windows, FMX.Platform, System.Threading,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, Messages, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Comp.UI,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, uTranslate, uLang, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, System.ImageList,
  FMX.ImgList, FMX.Objects, uLoadFile, shlobj, FMX.SpinBox, IdIPMCastBase, IdIPMCastServer, uUpdate, uTranscriptions, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Effects;

type
  TMainForm = class(TForm)
    ListBox: TListBox;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;
    PopupMenu: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    TabControl: TTabControl;
    tabPos: TTabItem;
    tabSleep: TTabItem;
    btnTrackingStart: TSpeedButton;
    timerCheckTrack: TTimer;
    timerGetPos: TTimer;
    editPosCursor: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    Label3: TLabel;
    Label4: TLabel;
    btnStart: TSpeedButton;
    timerStart: TTimer;
    timerSleepControl: TTimer;
    tabScroll: TTabItem;
    Label5: TLabel;
    numScroll: TNumberBox;
    MenuItem5: TMenuItem;
    swScroll: TSwitch;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    editCurrDisplay: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    btnCorrect: TSpeedButton;
    setDisplay: TEdit;
    currFileName: TEdit;
    btnViewPos: TSpeedButton;
    MenuItem10: TMenuItem;
    Query: TFDQuery;
    Conn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    TabTranslate: TTabItem;
    btnViewPosNameBlock: TSpeedButton;
    btnViewPosDetailsBlock: TSpeedButton;
    mName: TMemo;
    mDetails: TMemo;
    labCountWord: TLabel;
    Label13: TLabel;
    MainMenu: TMainMenu;
    MenuItem18: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem20: TMenuItem;
    ItemSave: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    BindingsList1: TBindingsList;
    BindSourceDB1: TBindSourceDB;
    LinkFillControlToField1: TLinkFillControlToField;
    Label14: TLabel;
    ImageList: TImageList;
    MenuItem19: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    tabSeparator: TTabItem;
    Label15: TLabel;
    edSeparator: TEdit;
    Image: TImage;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    Label16: TLabel;
    btnGoTo: TSpeedButton;
    Layout1: TLayout;
    Label17: TLabel;
    labCountTrial: TLabel;
    miLicense: TMenuItem;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    sbLoopCount: TSpinBox;
    editInterval: TSpinBox;
    sleepTime: TSpinBox;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    Layout6: TLayout;
    btnGetPosNameBlock: TSpeedButton;
    edSourcePos: TEdit;
    Layout7: TLayout;
    btnGetPosDetailsBlock: TSpeedButton;
    edTargetPos: TEdit;
    Layout8: TLayout;
    Label11: TLabel;
    cbLang: TComboBox;
    Label12: TLabel;
    Layout9: TLayout;
    layBtns: TLayout;
    LinkFillControlToField2: TLinkFillControlToField;
    StatusBar: TStatusBar;
    miUpdate: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    Layout11: TLayout;
    MenuItem29: TMenuItem;
    tabLang: TTabItem;
    ListViewLang: TListView;
    LinkFillControlToField3: TLinkFillControlToField;
    layAutoData: TGridPanelLayout;
    Layout10: TLayout;
    btnGetPosCurrDetailsBlock: TSpeedButton;
    edCurrentTargetPos: TEdit;
    Layout: TLayout;
    btnGetPosCurrNameBlock: TSpeedButton;
    edCurrentSourcePos: TEdit;
    btnInfo: TSpeedButton;
    btnInfo2: TSpeedButton;
    btnInfo4: TSpeedButton;
    btnInfo3: TSpeedButton;
    btnInfoPos: TSpeedButton;
    Layout13: TLayout;
    btnView: TSpeedButton;
    edNamePos: TEdit;
    Label18: TLabel;
    swGetData: TSwitch;
    Layout14: TLayout;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    layHandData: TLayout;
    Label22: TLabel;
    Label23: TLabel;
    btnSettLang: TSpeedButton;
    Layout12: TLayout;
    tabDefPause: TTabItem;
    recPopup: TRectangle;
    Label24: TLabel;
    btnOkPopup: TSpeedButton;
    Label25: TLabel;
    sbLangBtnPause: TSpinBox;
    Label26: TLabel;
    sbLangAddPause: TSpinBox;
    Layout15: TLayout;
    btnBackToLang: TSpeedButton;
    ShadowEffect1: TShadowEffect;
    procedure btnAddClick(Sender: TObject);
    procedure timerGetPosTimer(Sender: TObject);
    procedure timerCheckTrackTimer(Sender: TObject);
    procedure btnTrackingStartClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure sleepTimeChangeTracking(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure timerStartTimer(Sender: TObject);
    procedure timerSleepControlTimer(Sender: TObject);
    procedure numScrollChangeTracking(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCorrectClick(Sender: TObject);
    procedure ItemSaveClick(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure btnViewPosClick(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure mNameChangeTracking(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure cbLangChange(Sender: TObject);
    procedure edSeparatorChangeTracking(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure btnGoToClick(Sender: TObject);
    procedure miLicenseClick(Sender: TObject);
    procedure miUpdateClick(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure MenuItem29Click(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure edNamePosChangeTracking(Sender: TObject);
    procedure swGetDataSwitch(Sender: TObject);
    procedure btnSettLangClick(Sender: TObject);
    procedure btnOkPopupClick(Sender: TObject);
    procedure btnBackToLangClick(Sender: TObject);
  private
    LoopCount: integer;
    IsTrial: boolean;
    OldPos: TPoint;
    CurrLangCode: String;
    TranslateLangCode: string;
    TagTranslate: byte;
    Svc: IFMXClipboardService;
    procedure setkey(const langid, sublangid: word); overload;

    procedure ItemsClick(Sender: TObject);
    function CreateItem(itemType: integer; defHint: string = ''): TListBoxItem;
    procedure Save(FileName: String);
    procedure PostKeyEx32(key: word; const shift: TShiftState);
    function GetUserAppPath: string;
    function IsLangExists: boolean;
    { Private declarations }

  public
    UserName: string;
    Password: string;
    { Public declarations }
  end;

const
  intInternalTimer = 100;
  intSetDisplay = 101;
  intLoopCount = 102;
  intBtnViewTag = 103;
  itemPos = 1;
  itemClick = 2;
  itemSleep = 3;
  itemScroll = 4;
  itemSeparator = 5;
  itemRightClick = 6;
  itemDoubleClick = 7;
  itemCtrlA = 8;
  itemCtrlC = 9;
  itemCtrlV = 12;
  itemTranslate = 13;
  itemGetLang = 14;
  itemTab = 15;
  itemEnter = 16;
  itemText = 17;

  itemLang = 22;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnAddClick(Sender: TObject);
begin
  PopupMenu.Popup(Screen.MousePos.X, Screen.MousePos.Y);
end;

procedure TMainForm.btnBackToLangClick(Sender: TObject);
begin
  if MessageDlg('Сохранить внесенные изменения?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
  begin
    btnOkPopupClick(nil);
  end;
  TabControl.ActiveTab := tabLang;
end;

procedure TMainForm.btnCorrectClick(Sender: TObject);
var
  I: integer;
  cmbDis: string;
  setH: integer;
  incH: Double;
  setW: integer;
  incW: Double;
  newW: String;
  newH: String;
begin
  cmbDis := setDisplay.Text;
  setW := Copy(cmbDis, 1, Pos(' x', cmbDis) - 1).ToInteger;
  setH := Copy(cmbDis, Pos('x ', cmbDis) + 2).ToInteger;
  incW := GetDeviceCaps(GetDC(0), HORZRES) / setW;
  incH := GetDeviceCaps(GetDC(0), VERTRES) / setH;

  setDisplay.Text := editCurrDisplay.Text;
  for I := 0 to ListBox.Count - 1 do
  begin
    case ListBox.ListItems[I].Tag of
      itemPos:
        begin
          newW := Round(Copy(ListBox.ListItems[I].Hint, 1, Pos('-', ListBox.ListItems[I].Hint) - 1).ToInteger * incW).ToString;
          newH := Round(Copy(ListBox.ListItems[I].Hint, Pos('-', ListBox.ListItems[I].Hint) + 1).ToInteger * incH).ToString;
          ListBox.ListItems[I].Hint := newW + '-' + newH;
        end;
      itemScroll:
        begin
          ListBox.ListItems[I].Hint := (Round(ListBox.ListItems[I].Hint.ToInteger * incH)).ToString;
        end;
    end;

  end;
end;

procedure TMainForm.btnDelClick(Sender: TObject);
begin
  if NOT(ListBox.Selected = nil) then
  begin
    if ListBox.Selected.Tag = itemLang then
      ListViewLang.Items.CheckAll(false);

    ListBox.Items.Delete(ListBox.Selected.Index);
    TabControl.Visible := false;
  end;
end;

procedure TMainForm.btnDownClick(Sender: TObject);
begin
  if ListBox.Items.Count > 0 then
    if ListBox.Selected.Index < ListBox.Count - 1 then
    begin
      ListBox.Selected.Index := ListBox.Selected.Index + 1;
      ListBox.ListItems[ListBox.Selected.Index + 1].IsSelected := true;
    end;
end;

procedure TMainForm.btnGoToClick(Sender: TObject);
begin
  ShellAPI.ShellExecute(0, 'Open', 'https://www.youtube.com/channel/UCD7uILhzRHyib6H25UtJpYw', nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.btnInfoClick(Sender: TObject);
var
  ImageForm: TImageForm;
begin
  ImageForm := TImageForm.Create(nil);
  ImageForm.Image.Bitmap := ImageForm.ImageList.Source[(Sender as TSpeedButton).Tag].MultiResBitmap[0].Bitmap;
  ImageForm.ShowModal;
  ImageForm.DisposeOf;
end;

procedure TMainForm.btnOkPopupClick(Sender: TObject);
var
  s: string;
begin
  if MessageDlg('Сохранено! Изменить параметры для уже добавленных языков?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
  begin
    s := ListBox.Selected.Hint;
    Delete(s, 1, Pos(';', s));
    Delete(s, 1, Pos(';', s));
    ListBox.Selected.Hint := sbLangBtnPause.Text + ';' + sbLangAddPause.Text + ';' + s;
    TTask.Run(
      procedure
      var
        I: integer;
      begin
        for I := 0 to ListBox.Count - 1 do
          if ListBox.ListItems[I].Tag = itemSeparator then
          begin
            ListBox.ListItems[I + 3].Hint := sbLangBtnPause.Text;
            ListBox.ListItems[I + 6].Hint := sbLangAddPause.Text;
          end;
      end);
  end;
  TabControl.ActiveTab := tabLang;
end;

procedure TMainForm.btnSettLangClick(Sender: TObject);
begin
  TabControl.ActiveTab := tabDefPause;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  if NOT swGetData.IsChecked then
  begin
    mName.Text := '';
    mDetails.Text := '';
  end;

  setkey(Lo(GetUserDefaultUILanguage), sublang_default);

  if ListBox.Count > 0 then
  begin
    LoopCount := Round(sbLoopCount.Value);
    Self.Hide;
    GetCursorPos(OldPos);
    timerStart.Interval := editInterval.Text.ToInteger;
    timerStart.Enabled := true;
    timerSleepControl.Enabled := true;
    btnStart.Tag := 1;
  end;
end;

procedure TMainForm.btnTrackingStartClick(Sender: TObject);
begin
  Self.Hide;
  TagTranslate := (Sender as TSpeedButton).Tag;
  timerCheckTrack.Enabled := true;
  timerGetPos.Enabled := true;
end;

procedure TMainForm.btnUpClick(Sender: TObject);
begin
  if ListBox.Items.Count > 0 then
    if ListBox.Selected.Index > 0 then
    begin
      ListBox.Selected.Index := ListBox.Selected.Index - 1;
      ListBox.ListItems[ListBox.Selected.Index - 1].IsSelected := true;
    end;
end;

procedure TMainForm.btnViewClick(Sender: TObject);
begin
  btnView.Tag := IfThen(btnView.Tag = 0, 1, 0);
  btnView.ImageIndex := IfThen(btnView.Tag = 0, 33, 34);
  btnView.Hint := StrUtils.IfThen(btnView.Tag = 0, 'Спрятать нередактируемые объекты', 'Отобразить нередактируемые объекты');
  TTask.Run(
    procedure
    var
      I: integer;
      tmpBox: TListBox;
    begin
      btnView.Enabled := false;
      try
        for I := 0 to ListBox.Count - 1 do
        begin
          if ListBox.ListItems[I].Tag in [itemTab, itemEnter, itemClick, itemRightClick, itemDoubleClick, itemCtrlA, itemCtrlC, itemCtrlV] then
            ListBox.ListItems[I].Height := IfThen(btnView.Tag = 1, 0, 20);

          if IsLangExists then
          begin
            if ListBox.ListItems[I].Tag in [itemEnter, itemText, itemClick, itemScroll, itemSleep] then
              ListBox.ListItems[I].Height := IfThen(btnView.Tag = 1, 0, 20);
          end;

        end;
      except
        btnView.Tag := IfThen(btnView.Tag = 0, 1, 0);
        btnViewClick(nil);
        exit;
      end;
      TThread.Synchronize(nil,
        procedure
        begin
          btnView.Enabled := true;
          ListBox.ScrollToItem(ListBox.ListItems[ListBox.Count - 1]);
          ListBox.ScrollToItem(ListBox.ListItems[0]);
        end)
    end);

end;

procedure TMainForm.btnViewPosClick(Sender: TObject);
var
  tmpPoint: TPoint;
begin
  { if (ListBox.Selected.Tag = itemPos) or (ListBox.Selected.Tag = itemGetLang) then
    begin
    tmpPoint.X := Round(StrToInt(Copy(editPosCursor.Text, 1, Pos('-', editPosCursor.Text) - 1)));
    tmpPoint.Y := Round(StrToInt(Copy(editPosCursor.Text, Pos('-', editPosCursor.Text) + 1)));
    end
    else if (Sender as TSpeedButton).Tag = 0 then
    begin
    tmpPoint.X := Round(StrToInt(Copy(edSourcePos.Text, 1, Pos('-', edSourcePos.Text) - 1)));
    tmpPoint.Y := Round(StrToInt(Copy(edSourcePos.Text, Pos('-', edSourcePos.Text) + 1)));
    end
    else
    begin
    tmpPoint.X := Round(StrToInt(Copy(edTargetPos.Text, 1, Pos('-', edTargetPos.Text) - 1)));
    tmpPoint.Y := Round(StrToInt(Copy(edTargetPos.Text, Pos('-', edTargetPos.Text) + 1)));
    end;
    timerSleepControl.Enabled := false;
    SetCursorPos(tmpPoint.X, tmpPoint.Y); }
end;

procedure TMainForm.cbLangChange(Sender: TObject);
begin
  ListBox.Selected.Hint := edSourcePos.Text + ';' + edTargetPos.Text + ';' + edCurrentSourcePos.Text + ';' + edCurrentTargetPos.Text + ';' + Copy(cbLang.Selected.Text, Pos('(', cbLang.Selected.Text) + 1, 2) + ';' + swGetData.IsChecked.ToString;
end;

function TMainForm.CreateItem(itemType: integer; defHint: string = ''): TListBoxItem;
var
  newIndex: integer;
begin

  layBtns.Enabled := Not IsLangExists;
  // lItem.StyleLookup := 'listboxitemnodetail';

  result := TListBoxItem.Create(nil);
  with result do
  begin

    // ItemData.Bitmap := ImageList.Source[itemType - 1].MultiResBitmap[0].Bitmap;
    StyledSettings := [];

    case itemType of
      itemLang:
        begin
          Text := 'Выбрать языки';
          Hint := '500;300;';
        end;
      itemText:
        Text := 'Набрать текст';
      itemEnter:
        Text := 'Клавиша "Ввод"';
      itemTab:
        Text := 'Табуляция';
      itemPos:
        begin
          if defHint <> '' then
            Text := Copy(defHint, Pos(';', defHint) + 1)
          else
            Text := 'Переместить курсор';
          Hint := '0-0;Переместить курсор';
        end;
      itemSleep:
        begin
          Text := 'Пауза';
          Hint := '0';
        end;
      itemClick:
        begin
          Text := 'Нажатие мыши';
        end;
      itemScroll:
        begin
          Text := 'Прокрутить колесом';
          Hint := '-1000';
        end;
      itemSeparator:
        begin
          if defHint <> '' then
            Text := '----' + defHint + '----'
          else
            Text := '----<>----';
          Hint := '';
          TextSettings.Font.Style := [TFontStyle.fsBold];
        end;

      itemRightClick:
        begin
          Text := 'Нажатие правой клавиши мыши';
        end;

      itemDoubleClick:
        begin
          Text := 'Двойное нажатие мыши';
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
          if defHint <> '' then
            Text := Copy(defHint, Pos(';', defHint) + 1)
          else
            Text := 'Получить язык';
          Hint := '0-0;Получить язык';
        end;
      itemTranslate:
        begin
          Text := 'Перевести блок';
          Hint := '0-0;0-0;0-0;0-0;en';
        end;
    end;

    if defHint <> '' then
      Hint := defHint;

    if itemType in [itemTab, itemEnter, itemClick, itemRightClick, itemDoubleClick, itemCtrlA, itemCtrlC, itemCtrlV] then
      Height := IfThen(btnView.Tag = 1, 0, 20);

    Tag := itemType;

    OnClick := ItemsClick;
  end;

  if ListBox.Selected <> nil then
  begin
    newIndex := ListBox.Selected.Index + 1;
    ListBox.InsertObject(newIndex, result);
  end
  else
  begin
    ListBox.AddObject(result);
  end;

end;

function TMainForm.IsLangExists: boolean;
var
  I: integer;
begin
  result := false;
  for I := 0 to ListBox.Count - 1 do
    if ListBox.ListItems[I].Tag = itemLang then
    begin
      result := true;
      exit;
    end;
end;

procedure TMainForm.edNamePosChangeTracking(Sender: TObject);
begin
  if ListBox.Selected.Tag in [itemPos, itemGetLang] then
  begin
    ListBox.Selected.Hint := editPosCursor.Text + ';' + edNamePos.Text;
    ListBox.Selected.Text := edNamePos.Text;
  end;
end;

procedure TMainForm.edSeparatorChangeTracking(Sender: TObject);
begin

  if ListBox.Selected.Tag = itemSeparator then
  begin
    if edSeparator.Text = '' then
    begin
      ListBox.Selected.Hint := '';
      ListBox.Selected.Text := '----<>----';
    end
    else
    begin
      ListBox.Selected.Hint := edSeparator.Text;
      ListBox.Selected.Text := '----' + edSeparator.Text + '----';
    end;
  end
  else if ListBox.Selected.Tag = itemText then
    ListBox.Selected.Hint := edSeparator.Text;
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
  editCurrDisplay.Text := GetDeviceCaps(GetDC(0), HORZRES).ToString + ' x ' + GetDeviceCaps(GetDC(0), VERTRES).ToString;
  Conn.Params.Database := GetUserAppPath + 'base.db';
  Conn.Connected := true;
  Query.Active := true;

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
end;

function TMainForm.GetUserAppPath: string;
var
  path: array [0 .. MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path);
  result := path + '\MouseMover\';
end;

procedure TMainForm.MenuItem10Click(Sender: TObject);
begin
  CreateItem(itemSeparator);
end;

procedure TMainForm.MenuItem11Click(Sender: TObject);
begin
  CreateItem(itemRightClick);
end;

procedure TMainForm.MenuItem12Click(Sender: TObject);
begin
  CreateItem(itemDoubleClick);
end;

procedure TMainForm.MenuItem13Click(Sender: TObject);
begin
  CreateItem(itemCtrlA);
end;

procedure TMainForm.MenuItem14Click(Sender: TObject);
begin
  CreateItem(itemCtrlC);
end;

procedure TMainForm.MenuItem15Click(Sender: TObject);
begin
  CreateItem(itemCtrlV);
end;

procedure TMainForm.MenuItem16Click(Sender: TObject);
begin
  CreateItem(itemTranslate);
end;

procedure TMainForm.MenuItem17Click(Sender: TObject);
begin
  CreateItem(itemGetLang);
end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
  CreateItem(itemPos);
end;

procedure TMainForm.MenuItem25Click(Sender: TObject);
begin
  ContactForm.ShowModal;
end;

procedure TMainForm.MenuItem26Click(Sender: TObject);
begin
  CreateItem(itemTab);
end;

procedure TMainForm.MenuItem27Click(Sender: TObject);
begin
  CreateItem(itemEnter);
end;

procedure TMainForm.MenuItem28Click(Sender: TObject);
begin
  CreateItem(itemText);
end;

procedure TMainForm.MenuItem29Click(Sender: TObject);
var
  I: integer;
begin
  if ListBox.Count > 0 then
  begin
    if MessageDlg('Выбор компонента "Выбрать языки" повлечет очистку списка введенных компонентов. Продолжить?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = 6 then
    begin
      ListBox.Clear;
      CreateItem(itemLang);
      layBtns.Enabled := false;
      btnView.Tag := 1;
    end;
  end
  else
  begin
    CreateItem(itemLang);
    layBtns.Enabled := false;
    btnView.Tag := 1;
  end;
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

procedure TMainForm.MenuItem2Click(Sender: TObject);
begin
  CreateItem(itemClick);
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
  CreateItem(itemSleep);
end;

procedure TMainForm.MenuItem4Click(Sender: TObject);
begin
  SaveDialog.InitialDir := GetUserAppPath;
  if SaveDialog.Execute then
  begin
    Save(SaveDialog.FileName);
    currFileName.Text := ExtractFileName(SaveDialog.FileName);
    ItemSave.Enabled := true;
  end;
end;

procedure TMainForm.MenuItem5Click(Sender: TObject);
begin
  CreateItem(itemScroll);
end;

procedure TMainForm.MenuItem6Click(Sender: TObject);
var
  itemID: integer;
  lText: string;
  List: TStringList;

begin
  TabControl.Visible := false;
  OpenDialog.InitialDir := GetUserAppPath;
  if OpenDialog.Execute then
  begin
    currFileName.Hint := ExtractFileDir(OpenDialog.FileName) + '\';
    currFileName.Text := ExtractFileName(OpenDialog.FileName);

    ItemSave.Enabled := true;

    ListBox.Clear;

    TTask.Run( // uses System.Threading
      procedure
      var
        I: integer;
      begin
        List := TStringList.Create;

        List.LoadFromFile(OpenDialog.FileName);
        for I := 0 to List.Count - 1 do

        begin
          lText := List[I];
          if lText <> '' then
          begin
            itemID := Copy(lText, 1, Pos('-', lText) - 1).ToInteger;
            case itemID of
              intBtnViewTag:
                begin
                  btnView.Tag := Copy(lText, Pos('-', lText) + 1).ToInteger;
                  btnView.ImageIndex := IfThen(btnView.Tag = 0, 33, 34);
                end;
              intInternalTimer, 10:
                editInterval.Text := Copy(lText, Pos('-', lText) + 1);
              intSetDisplay, 11:
                setDisplay.Text := Copy(lText, Pos('-', lText) + 1);
              intLoopCount:
                sbLoopCount.Text := Copy(lText, Pos('-', lText) + 1);
              itemLang, itemTab, itemEnter, itemText, itemPos, itemClick, itemSleep, itemScroll, itemRightClick, itemDoubleClick, itemCtrlA, itemCtrlC, itemCtrlV, itemTranslate, itemGetLang:
                begin
                  try
                    with CreateItem(itemID) do
                    begin
                      Hint := Copy(lText, Pos('-', lText) + 1);

                      if itemID = itemPos then
                        if Pos(';', lText) = 0 then
                        begin
                          Text := 'Переместить курсор';
                        end
                        else
                        begin
                          Text := Copy(lText, Pos(';', lText) + 1);
                          Hint := Copy(lText, Pos('-', lText) + 1);
                        end;

                      if IsLangExists then
                        if itemID in [itemEnter, itemText, itemClick, itemSleep, itemScroll] then
                          Height := 0;
                    end;
                  except
                    List.Free;
                    MenuItem6Click(nil);
                    exit;
                  end;
                end;
              itemSeparator:
                begin
                  try
                    with CreateItem(itemID) do
                    begin
                      Hint := Copy(lText, Pos('-', lText) + 1);
                      if Hint = '' then
                        Text := '----<>----'
                      else
                        Text := '----' + Copy(lText, Pos('-', lText) + 1) + '----';
                    end;
                  except
                    List.Free;
                    MenuItem6Click(nil);
                    exit;
                  end;
                end;
            end;
          end;
        end;

        TThread.Synchronize(nil,
          procedure
          begin
            List.Free;
          end);
      end);
    layBtns.Enabled := Not IsLangExists;
  end;

end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin
  LangForm.ShowModal;
end;

procedure TMainForm.MenuItem9Click(Sender: TObject);
begin
  currFileName.Text := '';
  ItemSave.Enabled := false;
  setDisplay.Text := '';
  ListBox.Clear;
  TabControl.Visible := false;
  layBtns.Enabled := true;
end;

procedure TMainForm.mNameChangeTracking(Sender: TObject);
begin
  labCountWord.Text := mName.Text.Length.ToString + '/100';
end;

procedure TMainForm.Save(FileName: String);
var
  f: TextFile;
  I: integer;
  Text: string;
  Flags: TReplaceFlags;
begin
  AssignFile(f, StringReplace(FileName, '.smm', '', Flags) + '.smm');
  Rewrite(f);
  Writeln(f, '100-' + editInterval.Text);
  Writeln(f, '101-' + setDisplay.Text);
  Writeln(f, '102-' + sbLoopCount.Text);
  Writeln(f, '103-' + btnView.Tag.ToString);
  for I := 0 to ListBox.Count - 1 do
  begin
    Text := ListBox.ListItems[I].Tag.ToString + '-' + ListBox.ListItems[I].Hint;
    Writeln(f, Text);
  end;

  CloseFile(f);
end;

procedure TMainForm.ItemSaveClick(Sender: TObject);
begin
  Save(currFileName.Hint + currFileName.Text);
end;

procedure TMainForm.numScrollChangeTracking(Sender: TObject);
begin
  if swScroll.IsChecked then
    ListBox.Selected.Hint := '-' + numScroll.Text
  else
    ListBox.Selected.Hint := numScroll.Text;
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

procedure TMainForm.sleepTimeChangeTracking(Sender: TObject);
begin
  ListBox.Selected.Hint := sleepTime.Text;
end;

procedure TMainForm.swGetDataSwitch(Sender: TObject);
begin
  layHandData.Visible := swGetData.IsChecked;
  layAutoData.Visible := NOT swGetData.IsChecked;
  ListBox.Selected.Hint := edSourcePos.Text + ';' + edTargetPos.Text + ';' + edCurrentSourcePos.Text + ';' + edCurrentTargetPos.Text + ';' + Copy(cbLang.Selected.Text, Pos('(', cbLang.Selected.Text) + 1, 2) + ';' + swGetData.IsChecked.ToString;
end;

procedure TMainForm.timerCheckTrackTimer(Sender: TObject);
begin
  if (ListBox.Selected.Tag = itemPos) or (ListBox.Selected.Tag = itemGetLang) then
  begin
    btnTrackingStart.Text := 'Начать запись позиции';
    ListBox.Selected.Hint := editPosCursor.Text
  end
  else
  begin
    case TagTranslate of
      0:
        btnGetPosNameBlock.Text := 'Начать запись позиции целового названия';
      1:
        btnGetPosDetailsBlock.Text := 'Начать запись позиции целового описания';
      2:
        btnGetPosCurrNameBlock.Text := 'Начать запись позиции исходного названия';
      3:
        btnGetPosCurrDetailsBlock.Text := 'Начать запись позиции исходного описания';
    end;
    ListBox.Selected.Hint := edSourcePos.Text + ';' + edTargetPos.Text + ';' + edCurrentSourcePos.Text + ';' + edCurrentTargetPos.Text + ';' + Copy(cbLang.Selected.Text, Pos('(', cbLang.Selected.Text) + 1, 2) + ';' + swGetData.IsChecked.ToString;
  end;

  timerGetPos.Enabled := false;
  timerCheckTrack.Enabled := false;
  Self.FormStyle := TFormStyle.StayOnTop;
  Self.Show;
  Self.FormStyle := TFormStyle.Normal;
end;

procedure TMainForm.timerGetPosTimer(Sender: TObject);
var
  posXY: TPoint;
begin
  GetCursorPos(posXY);

  if (ListBox.Selected.Tag = itemPos) or (ListBox.Selected.Tag = itemGetLang) then
  begin
    if editPosCursor.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
    begin
      btnTrackingStart.Hint := (StrToFloat(btnTrackingStart.Hint) - 0.1).ToString;
      btnTrackingStart.Text := 'Не двигайте мышью еще ' + btnTrackingStart.Hint + ' сек.';;
      timerCheckTrack.Enabled := true;
    end
    else
    begin
      editPosCursor.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
      timerCheckTrack.Enabled := false;
      btnTrackingStart.Hint := '2,5';
      btnTrackingStart.Text := 'Не двигайте мышью еще 2,5 сек.';
    end;
  end
  else
    case TagTranslate of
      0:
        begin
          if edSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            btnGetPosNameBlock.Hint := (StrToFloat(btnGetPosNameBlock.Hint) - 0.1).ToString;
            btnGetPosNameBlock.Text := 'Не двигайте мышью еще ' + btnGetPosNameBlock.Hint + ' сек.';;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            edSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            btnGetPosNameBlock.Hint := '2,5';
            btnGetPosNameBlock.Text := 'Не двигайте мышью еще 2,5 сек.';
          end;
        end;
      1:
        begin
          if edTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            btnGetPosDetailsBlock.Hint := (StrToFloat(btnGetPosDetailsBlock.Hint) - 0.1).ToString;
            btnGetPosDetailsBlock.Text := 'Не двигайте мышью еще ' + btnGetPosDetailsBlock.Hint + ' сек.';;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            edTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            btnGetPosDetailsBlock.Hint := '2,5';
            btnGetPosDetailsBlock.Text := 'Не двигайте мышью еще 2,5 сек.';
          end;
        end;
      2:
        begin
          if edCurrentSourcePos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            btnGetPosCurrNameBlock.Hint := (StrToFloat(btnGetPosCurrNameBlock.Hint) - 0.1).ToString;
            btnGetPosCurrNameBlock.Text := 'Не двигайте мышью еще ' + btnGetPosCurrNameBlock.Hint + ' сек.';;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            edCurrentSourcePos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            btnGetPosCurrNameBlock.Hint := '2,5';
            btnGetPosCurrNameBlock.Text := 'Не двигайте мышью еще 2,5 сек.';
          end;
        end;
      3:
        begin
          if edCurrentTargetPos.Text = posXY.X.ToString + '-' + posXY.Y.ToString then
          begin
            btnGetPosCurrDetailsBlock.Hint := (StrToFloat(btnGetPosCurrDetailsBlock.Hint) - 0.1).ToString;
            btnGetPosCurrDetailsBlock.Text := 'Не двигайте мышью еще ' + btnGetPosCurrDetailsBlock.Hint + ' сек.';;
            timerCheckTrack.Enabled := true;
          end
          else
          begin
            edCurrentTargetPos.Text := posXY.X.ToString + '-' + posXY.Y.ToString;
            timerCheckTrack.Enabled := false;
            btnGetPosCurrDetailsBlock.Hint := '2,5';
            btnGetPosCurrDetailsBlock.Text := 'Не двигайте мышью еще 2,5 сек.';
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

  if LoopCount <> 0 then
  begin
    for I := 0 to ListBox.Count - 1 do
    begin
      case ListBox.ListItems[I].Tag of
        itemPos:
          begin
            if Pos(';', ListBox.ListItems[I].Hint) = 0 then
            begin
              tmpPoint.X := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, 1, Pos('-', ListBox.ListItems[I].Hint) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, Pos('-', ListBox.ListItems[I].Hint) + 1)));
            end
            else
            begin
              tmpPoint.X := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, 1, Pos('-', ListBox.ListItems[I].Hint) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, Pos('-', ListBox.ListItems[I].Hint) + 1, Pos(';', ListBox.ListItems[I].Hint) - Pos('-', ListBox.ListItems[I].Hint) - 1)));
            end;

            timerSleepControl.Enabled := false;
            OldPos := tmpPoint;
            SetCursorPos(tmpPoint.X, tmpPoint.Y);
            timerSleepControl.Enabled := true;
          end;
        itemSleep:
          begin
            sleep(ListBox.ListItems[I].Hint.ToInteger);
          end;
        itemClick:
          begin
            mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          end;
        itemScroll:
          begin
            mouse_event(MOUSEEVENTF_WHEEL, 0, 0, DWORD(ListBox.ListItems[I].Hint.ToInteger), 0);
          end;

        itemRightClick:
          begin
            mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
            mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
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
        itemTab:
          begin
            PostKeyEx32(9, [ssctrl]);
          end;
        itemEnter:
          begin
            PostKeyEx32(13, [ssctrl]);
          end;
        itemText:
          begin
            s := AnsiUPPERCASE(ListBox.ListItems[I].Hint);
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
            tmpPoint.X := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, 1, Pos('-', ListBox.ListItems[I].Hint) - 1)));
            tmpPoint.Y := Round(StrToInt(Copy(ListBox.ListItems[I].Hint, Pos('-', ListBox.ListItems[I].Hint) + 1)));
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
              OldInd := cbLang.Selected.Index;
              Query.Locate('lang_name', TranslateLangCodeName, [loPartialKey]);
              TranslateLangCode := Query.FieldByName('lang_code').AsString;
              cbLang.ItemIndex := OldInd;
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

            tmpPos := ListBox.ListItems[I].Hint;
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

            if mName.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := Round(StrToInt(Copy(tmpCSP, 1, Pos('-', tmpCSP) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(tmpCSP, Pos('-', tmpCSP) + 1, Pos(';', tmpCSP) - 1 - Pos('-', tmpCSP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              mName.Text := Svc.GetClipBoard.ToString;
            end;

            if mDetails.Text = '' then
            begin
              sleep(100);
              tmpPoint.X := Round(StrToInt(Copy(tmpCTP, 1, Pos('-', tmpCTP) - 1)));
              tmpPoint.Y := Round(StrToInt(Copy(tmpCTP, Pos('-', tmpCTP) + 1, Pos(';', tmpCTP) - 1 - Pos('-', tmpCTP))));
              timerSleepControl.Enabled := false;
              OldPos := tmpPoint;
              SetCursorPos(tmpPoint.X, tmpPoint.Y);
              mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
              mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
              PostKeyEx32(Ord('A'), [ssctrl]);
              sleep(200);
              PostKeyEx32(Ord('C'), [ssctrl]);
              sleep(200);
              mDetails.Text := Svc.GetClipBoard.ToString;
            end;

            // Название
            if TranslateLangCode <> '' then
            begin

              Svc.SetClipboard(Copy(GoogleTranslate(mName.Text, myLang, TranslateLangCode), 1, 100));
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

            PostKeyEx32(Ord('A'), [ssctrl]);
            sleep(100);
            PostKeyEx32(Ord('V'), [ssctrl]);
            sleep(100);

            // Описание
            if TranslateLangCode <> '' then
            begin
              Svc.SetClipboard(GoogleTranslate(mDetails.Text, myLang, TranslateLangCode));
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
  queryLang: string;
begin
  case (Sender as TListBoxItem).Tag of
    itemPos, itemGetLang:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := tabPos;
        if Pos(';', (Sender as TListBoxItem).Hint) = 0 then
        begin
          editPosCursor.Text := (Sender as TListBoxItem).Hint;
          if (Sender as TListBoxItem).Tag = itemGetLang then
            edNamePos.Text := 'Получить язык'
          else
            edNamePos.Text := 'Переместить курсор';
        end
        else
        begin
          editPosCursor.Text := Copy((Sender as TListBoxItem).Hint, 1, Pos(';', (Sender as TListBoxItem).Hint) - 1);
          edNamePos.Text := Copy((Sender as TListBoxItem).Hint, Pos(';', (Sender as TListBoxItem).Hint) + 1);
        end;

        if (Sender as TListBoxItem).Tag = itemGetLang then
          btnInfoPos.Tag := 4
        else
          btnInfoPos.Tag := 5;
      end;
    itemTranslate:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := TabTranslate;
        s := (Sender as TListBoxItem).Hint;
        edSourcePos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        edTargetPos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        edCurrentSourcePos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));
        edCurrentTargetPos.Text := Copy(s, 1, Pos(';', s) - 1);
        Delete(s, 1, Pos(';', s));

        if Pos(';', s) = 0 then
          Query.Locate('lang_code', s, [])
        else
        begin
          queryLang := Copy(s, 1, Pos(';', s) - 1);
          Query.Locate('lang_code', queryLang, []);
          Delete(s, 1, Pos(';', s));
          swGetData.IsChecked := s.ToBoolean;
        end;

        cbLang.ItemIndex := Query.FieldByName('row').AsInteger - 1;

      end;
    itemSleep:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := tabSleep;
        sleepTime.Text := (Sender as TListBoxItem).Hint;
      end;
    itemClick, itemRightClick, itemDoubleClick, itemCtrlA, itemCtrlC, itemCtrlV, itemTab, itemEnter:
      begin
        TabControl.Visible := false;
      end;
    itemSeparator, itemText:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := tabSeparator;
        edSeparator.Text := (Sender as TListBoxItem).Hint;
      end;
    itemScroll:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := tabScroll;
        swScroll.IsChecked := (Sender as TListBoxItem).Hint.ToInteger < 0;
        numScroll.Value := ABS((Sender as TListBoxItem).Hint.ToInteger);
      end;
    itemLang:
      begin
        TabControl.Visible := true;
        TabControl.ActiveTab := tabLang;
        ListViewLang.Items.CheckAll(false);
        s := (Sender as TListBoxItem).Hint;
        try
          sbLangBtnPause.Value := Copy(s, 1, Pos(';', s) - 1).ToInteger;
          Delete(s, 1, Pos(';', s));
        except
        end;

        try
          sbLangAddPause.Value := Copy(s, 1, Pos(';', s) - 1).ToInteger;
          Delete(s, 1, Pos(';', s));
        except
        end;

        while Length(s) > 0 do
        begin
          tmp := Copy(s, Pos(';', s) - 3, 2);
          Delete(s, 1, Pos(';', s));
          for I := 0 to ListViewLang.Items.Count - 1 do
            if ListViewLang.Items[I].Detail = tmp then
              ListViewLang.Items[I].Checked := true;
        end;
      end;
  end;

end;

procedure TMainForm.ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  I, J: integer;
  s: string;
begin

  if AItem.Checked then
  begin

    ListBox.Selected.Hint := ListBox.Selected.Hint + AItem.Detail + ';';
    ListBox.ClearSelection;

    CreateItem(itemSeparator, AItem.Text);

    CreateItem(itemPos, '0-0;Кнопка "Добавить перевод на другой язык"').Height := 20;
    // Остальное прячем
    CreateItem(itemClick).Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemSleep, sbLangBtnPause.Text).Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemText, AItem.Text).Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemEnter).Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemSleep, sbLangAddPause.Text).Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemScroll, '-10000').Height := IfThen(btnView.Tag = 1, 0, 20);

    CreateItem(itemSleep, '500').Height := IfThen(btnView.Tag = 1, 0, 20);

    ListBox.ListItems[0].IsSelected := true;
  end
  else
  begin
    s := ListBox.Selected.Hint;
    Delete(s, Pos(AItem.Detail, s), Length(AItem.Detail) + 1);
    ListBox.Selected.Hint := s;

    for I := 0 to ListBox.Count - 1 do
      if (ListBox.ListItems[I].Tag = itemSeparator) and (ListBox.ListItems[I].Hint = AItem.Text) then
      begin
        editPosCursor.Text := '0-0';
        edSeparator.Text := '';
        for J := 1 to 9 do
          ListBox.Items.Delete(I);

        break;
      end;

  end;
  ListBox.ListItems[0].IsSelected := true;
end;

end.
