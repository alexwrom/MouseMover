unit uStartSettingName;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows,uUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl, FMX.Objects, System.ImageList, FMX.ImgList, FMX.Effects, FMX.Layouts;

type
  TFormStartName = class(TForm)
    tcSettName: TTabControl;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    TabItem3: TTabItem;
    TabItem6: TTabItem;
    edCurrentSourcePos: TEdit;
    TabItem7: TTabItem;
    edCurrentTargetPos: TEdit;
    labText: TLabel;
    ImageList: TImageList;
    btnStart: TCornerButton;
    TabItem1: TTabItem;
    TabItem11: TTabItem;
    Label5: TLabel;
    Label6: TLabel;
    sleepLoop: TSpinBox;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnCloseForm: TSpeedButton;
    Image16: TImage;
    Rectangle3: TRectangle;
    ShadowEffect1: TShadowEffect;
    Image: TImage;
    Rectangle4: TRectangle;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    procedure btnSettNamePosAddClick(Sender: TObject);
    procedure btnGetPosCurrNameBlockClick(Sender: TObject);
    procedure btnGetPosCurrDetailsBlockClick(Sender: TObject);
    procedure btnPauseOneClick(Sender: TObject);
    procedure btnSettGetLangClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure PauseSleepLoop(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStartName: TFormStartName;

implementation

uses uMain;
{$R *.fmx}

procedure TFormStartName.btnGetPosCurrDetailsBlockClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу между переводами. Если нет, то используйте данные по-умолчанию.';
  MainForm.itemType := itemTranslate;
  MainForm.OrderId := 5;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := 'Продолжить';
  (Sender As TCornerButton).OnClick := PauseSleepLoop;
  Image.MultiResBitmap[0].Bitmap := nil;
  tcSettName.Visible := true;
  Self.Hide;
end;

procedure TFormStartName.btnGetPosCurrNameBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Описание" исходного языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  MainForm.itemType := itemTranslate;
  MainForm.OrderId := 5;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosCurrDetailsBlockClick;
  (Sender As TCornerButton).Tag := 3;
  Self.Hide;
end;


procedure TFormStartName.btnPauseOneClick(Sender: TObject);
begin
  MainForm.itemType := itemSleep;
  MainForm.OrderId := 3;
  MainForm.SetHint(sleepTime.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на первые буквы названия целового языка.';
  tcSettName.Visible := false;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
  (Sender As TCornerButton).Text := 'Указать';
  (Sender As TCornerButton).OnClick := btnSettGetLangClick;
  tcSettName.Next();

end;


procedure TFormStartName.PauseSleepLoop(Sender: TObject);
begin
  labText.Text := 'Настройка завершена.';
  MainForm.itemType := itemSleep;
  MainForm.OrderId := 9;
  MainForm.SetHint(sleepLoop.Text);
  (Sender As TCornerButton).Text := 'Завершить';
  (Sender As TCornerButton).OnClick := btnCloseClick;
  tcSettName.Visible := false;
end;

procedure TFormStartName.FormShow(Sender: TObject);
begin
  MainForm.blockType := blockName;
  if Self.Tag = 0 then
  begin
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  end;
  Self.Tag := 1;
end;

procedure TFormStartName.btnCloseClick(Sender: TObject);
begin
  labText.Text := 'Перед началом настройки названия и описания откройте в браузере Youtube Studio и перейдите в настройки субтитров на одном из ' +
    'Ваших новых видео. Затем вернитесь в программу и нажав кнопку "Начать" наведите на самую нижнюю кнопку в браузере "ДОБАВИТЬ" в колонке "Название и описание".';
  tcSettName.Visible := false;
  tcSettName.ActiveTab := TabItem1;
  btnStart.Text := 'Начать';
  btnStart.OnClick := btnSettNamePosAddClick;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[4].MultiResBitmap[0].Bitmap;
  Self.Tag := 1;

  MainForm.SetInfo(MainForm.btnItemSubtitle, 'Нажмите сюда, чтобы перейти в раздел настройки переводов субтитров.');
  Self.Close;

end;

procedure TFormStartName.btnSettGetLangClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Название" исходного языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;
  MainForm.itemType := itemGetLang;
  MainForm.OrderId := 4;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosCurrNameBlockClick;
  (Sender As TCornerButton).Tag := 2;
  Self.Hide;
end;

procedure TFormStartName.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу до открытия окна редактирования. Если нет, то используйте данные по-умолчанию.';
  MainForm.itemType := itemPos;
  MainForm.OrderId := 1;

  (Sender As TCornerButton).Text := 'Продолжить';
  (Sender As TCornerButton).OnClick := btnPauseOneClick;
  Image.MultiResBitmap[0].Bitmap := nil;
  tcSettName.Visible := true;
  Self.Hide;
  MainForm.btnTrackingStartClick(Sender);
  Self.Tag := 0;
end;

end.
