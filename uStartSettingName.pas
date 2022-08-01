unit uStartSettingName;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl, FMX.Objects, System.ImageList, FMX.ImgList;

type
  TFormStartName = class(TForm)
    tcSettName: TTabControl;
    TabItem1: TTabItem;
    btnSettNamePosAdd: TSpeedButton;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    edSourcePos: TEdit;
    btnGetPosNameBlock: TSpeedButton;
    TabItem5: TTabItem;
    edTargetPos: TEdit;
    btnGetPosDetailsBlock: TSpeedButton;
    TabItem6: TTabItem;
    btnGetPosCurrNameBlock: TSpeedButton;
    edCurrentSourcePos: TEdit;
    TabItem7: TTabItem;
    btnGetPosCurrDetailsBlock: TSpeedButton;
    edCurrentTargetPos: TEdit;
    TabItem8: TTabItem;
    TabItem9: TTabItem;
    btnSettGetLang: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    sleepTimeTwo: TSpinBox;
    btnPublish: TSpeedButton;
    labText: TLabel;
    Image: TImage;
    btnPauseOne: TSpeedButton;
    ImageList: TImageList;
    btnPauseTwo: TSpeedButton;
    TabItem10: TTabItem;
    btnClose: TSpeedButton;
    Rectangle5: TRectangle;
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
  Image.Visible := false;
  tcSettName.Height := 120;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(btnGetPosCurrDetailsBlock);
  Self.Hide;
end;

procedure TFormStartName.btnGetPosCurrNameBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Описание" исходного языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[4].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(btnGetPosCurrNameBlock);
  Self.Hide;
end;

procedure TFormStartName.btnGetPosDetailsBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Название" исходного языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[3].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(btnGetPosDetailsBlock);
  Self.Hide;
end;

procedure TFormStartName.btnGetPosNameBlockClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Описание" целового языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  MainForm.btnTrackingStartClick(btnGetPosNameBlock);
  Self.Hide;
end;

procedure TFormStartName.btnPauseOneClick(Sender: TObject);
begin
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[2].IsSelected := true;
  MainForm.SetHint(sleepTime.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на первые буквы названия целового языка.';
  tcSettName.Height := 50;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
  Image.Visible := true;
  tcSettName.Next();

end;

procedure TFormStartName.btnPauseTwoClick(Sender: TObject);
begin
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[5].IsSelected := true;
    MainForm.SetHint(sleepTimeTwo.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на кнопку "Опубликовать".';
  tcSettName.Height := 50;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[5].MultiResBitmap[0].Bitmap;
  Image.Visible := true;
  tcSettName.Next();
end;

procedure TFormStartName.btnStopSettName(Sender: TObject);
begin
  labText.Text := 'Настройка завершена.';
  Image.Visible := false;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[6].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  Self.Hide;
end;

procedure TFormStartName.FormShow(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbNameDetail;
end;

procedure TFormStartName.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormStartName.btnSettGetLangClick(Sender: TObject);
begin
  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на блок "Название" целового языка.';
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[3].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  Self.Hide;
end;

procedure TFormStartName.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу до открытия окна редактирования. Если нет, то используйте данные по-умолчанию.';
  tcSettName.Height := 120;
  Image.Visible := false;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[0].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  Self.Hide;
end;

end.
