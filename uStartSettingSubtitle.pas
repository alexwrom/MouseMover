unit uStartSettingSubtitle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.ImageList, FMX.ImgList, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl;

type
  TFormStartSubtitle = class(TForm)
    tcSettSub: TTabControl;
    TabItem1: TTabItem;
    btnSettNamePosAdd: TSpeedButton;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    btnPauseOne: TSpeedButton;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem10: TTabItem;
    btnClose: TSpeedButton;
    labText: TLabel;
    Image: TImage;
    ImageList: TImageList;
    btnSettTranslate: TSpeedButton;
    btnPauseTwo: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    sbPauseTwo: TSpinBox;
    TabItem9: TTabItem;
    btnPublish: TSpeedButton;
    procedure btnSettNamePosAddClick(Sender: TObject);
    procedure btnPauseOneClick(Sender: TObject);
    procedure btnSettTranslateClick(Sender: TObject);
    procedure btnPauseTwoClick(Sender: TObject);
    procedure btnPublishClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStartSubtitle: TFormStartSubtitle;

implementation

uses uMain;

{$R *.fmx}

procedure TFormStartSubtitle.btnCloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormStartSubtitle.btnPauseOneClick(Sender: TObject);
begin
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[2].IsSelected := true;
  MainForm.SetHint(sleepTime.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на кнопку "Перевести".';
  tcSettSub.Height := 50;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
  Image.Visible := true;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.btnPauseTwoClick(Sender: TObject);
begin
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[5].IsSelected := true;
  MainForm.SetHint(sbPauseTwo.Text);

  labText.Text := 'После нажатия кнопки "Указать" наведите указатель на кнопку "Опубликовать".';
  tcSettSub.Height := 50;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;
  Image.Visible := true;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.btnPublishClick(Sender: TObject);
begin
  labText.Text := 'Настройка завершена.';
  Image.Visible := false;
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[6].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  Self.Hide;
end;

procedure TFormStartSubtitle.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу до открытия окна редактирования. Если нет, то используйте данные по-умолчанию.';
  tcSettSub.Height := 120;
  Image.Visible := false;
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[0].IsSelected := true;

  MainForm.btnTrackingStartClick(Sender);

  Self.Hide;
end;

procedure TFormStartSubtitle.btnSettTranslateClick(Sender: TObject);
begin
  labText.Text := 'Если Ваш компьютерный медленно работает, то здесь Вы можете указать большую паузу перевода субтитров. Если нет, то используйте данные по-умолчанию.';
  tcSettSub.Height := 120;
  Image.Visible := false;
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[3].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  Self.Hide;
end;

procedure TFormStartSubtitle.FormShow(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbSubtitles;
end;

end.
