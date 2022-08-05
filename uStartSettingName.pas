unit uStartSettingName;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl, FMX.Objects, System.ImageList, FMX.ImgList, FMX.Effects;

type
  TFormStartName = class(TForm)
    tcSettName: TTabControl;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    edSourcePos: TEdit;
    TabItem5: TTabItem;
    edTargetPos: TEdit;
    TabItem6: TTabItem;
    edCurrentSourcePos: TEdit;
    TabItem7: TTabItem;
    edCurrentTargetPos: TEdit;
    TabItem8: TTabItem;
    TabItem9: TTabItem;
    Label3: TLabel;
    Label4: TLabel;
    sleepTimeTwo: TSpinBox;
    labText: TLabel;
    ImageList: TImageList;
    TabItem10: TTabItem;
    imgBackground: TImage;
    btnCloseForm: TSpeedButton;
    Image9: TImage;
    GlowEffect8: TGlowEffect;
    btnStart: TCornerButton;
    TabItem1: TTabItem;
    Rectangle5: TRectangle;
    Image: TCircle;
    Rectangle1: TRectangle;
    procedure btnSettNamePosAddClick(Sender: TObject);
    procedure btnGetPosNameBlockClick(Sender: TObject);
    procedure btnGetPosDetailsBlockClick(Sender: TObject);
    procedure btnGetPosCurrNameBlockClick(Sender: TObject);
    procedure btnGetPosCurrDetailsBlockClick(Sender: TObject);
    procedure btnPauseOneClick(Sender: TObject);
    procedure btnSettGetLangClick(Sender: TObject);
    procedure btnPauseTwoClick(Sender: TObject);
    procedure btnStopSettName(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
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
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу на загрузку перевода. Если нет, то используйте данные по-умолчанию.';
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := 'Продолжить';
  (Sender As TCornerButton).OnClick := btnPauseTwoClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[6].MultiResBitmap[0].Bitmap;
  tcSettName.Visible := true;
  Self.Hide;
end;

procedure TFormStartName.btnGetPosCurrNameBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Описание" исходного языка.';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[4].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosCurrDetailsBlockClick;
  (Sender As TCornerButton).Tag := 3;
  Self.Hide;
end;

procedure TFormStartName.btnGetPosDetailsBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Название" исходного языка.';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[3].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosCurrNameBlockClick;
  (Sender As TCornerButton).Tag := 2;
  Self.Hide;
end;

procedure TFormStartName.btnGetPosNameBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Описание" целового языка.';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosDetailsBlockClick;
  (Sender As TCornerButton).Tag := 1;
  Self.Hide;
end;

procedure TFormStartName.btnPauseOneClick(Sender: TObject);
begin
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[2].IsSelected := true;
  MainForm.SetHint(sleepTime.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на первые буквы названия целового языка.';
  tcSettName.Visible := false;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
  (Sender As TCornerButton).Text := 'Указать';
  (Sender As TCornerButton).OnClick := btnSettGetLangClick;
  tcSettName.Next();

end;

procedure TFormStartName.btnPauseTwoClick(Sender: TObject);
begin
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[5].IsSelected := true;
  MainForm.SetHint(sleepTimeTwo.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на кнопку "Опубликовать".';
  tcSettName.Visible := false;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[5].MultiResBitmap[0].Bitmap;
  (Sender As TCornerButton).Text := 'Указать';
  (Sender As TCornerButton).OnClick := btnStopSettName;
  tcSettName.Next();
end;

procedure TFormStartName.btnStopSettName(Sender: TObject);
begin
  labText.Text := 'Настройка завершена.';
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[6].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := 'Завершить';
  (Sender As TCornerButton).OnClick := btnCloseClick;
  Self.Hide;
end;

procedure TFormStartName.FormShow(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbNameDetail;
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
  tcSettName.Index := 0;
  btnStart.Text := 'Начать';
  btnStart.OnClick := btnSettNamePosAddClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[7].MultiResBitmap[0].Bitmap;
  Self.Tag := 1;
  Self.Close;
end;

procedure TFormStartName.btnSettGetLangClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Название" целового языка.';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[3].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).OnClick := btnGetPosNameBlockClick;
  (Sender As TCornerButton).Tag := 0;
  Self.Hide;
end;

procedure TFormStartName.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу до открытия окна редактирования. Если нет, то используйте данные по-умолчанию.';

  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[0].IsSelected := true;

  (Sender As TCornerButton).Text := 'Продолжить';
  (Sender As TCornerButton).OnClick := btnPauseOneClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[6].MultiResBitmap[0].Bitmap;
  tcSettName.Visible := true;
  Self.Hide;
  MainForm.btnTrackingStartClick(Sender);
  Self.Tag := 0;
end;

end.
