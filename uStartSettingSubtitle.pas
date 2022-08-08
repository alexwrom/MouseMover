unit uStartSettingSubtitle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.ImageList, FMX.ImgList, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl, FMX.Effects;

type
  TFormStartSubtitle = class(TForm)
    tcSettSub: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem10: TTabItem;
    labText: TLabel;
    ImageList: TImageList;
    Label5: TLabel;
    Label6: TLabel;
    sbPauseTwo: TSpinBox;
    TabItem9: TTabItem;
    imgBackground: TImage;
    btnStart: TCornerButton;
    Image: TCircle;
    btnCloseForm: TSpeedButton;
    Image9: TImage;
    GlowEffect8: TGlowEffect;
    Rectangle5: TRectangle;
    Rectangle1: TRectangle;
    TabItem11: TTabItem;
    Rectangle2: TRectangle;
    sleepLoop: TSpinBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnSettNamePosAddClick(Sender: TObject);
    procedure btnPauseOneClick(Sender: TObject);
    procedure btnSettTranslateClick(Sender: TObject);
    procedure btnPauseTwoClick(Sender: TObject);
    procedure btnPublishClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure PauseSleepLoop(Sender: TObject);
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
  labText.Text :=
    '����� ������� ��������� ��������� �������� � �������� Youtube Studio � ��������� � ��������� ��������� �� ����� �� ����� ����� �����. ����� ��������� � ��������� � ����� ������ "������" �������� �� ������������� ������ "��������" � ������� "��������".';
  tcSettSub.Visible := false;
  tcSettSub.Index := 0;
  btnStart.Text := '������';
  btnStart.OnClick := btnSettNamePosAddClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[3].MultiResBitmap[0].Bitmap;
  Self.Tag := 1;
  Self.Close;
end;

procedure TFormStartSubtitle.btnPauseOneClick(Sender: TObject);
begin
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[2].IsSelected := true;
  MainForm.SetHint(sleepTime.Text);

  labText.Text := '����� ������� ������ "�������" �������� ��������� �� ������ "���������".';
  tcSettSub.Visible := false;
  (Sender As TCornerButton).Text := '�������';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[0].MultiResBitmap[0].Bitmap;
  (Sender As TCornerButton).OnClick := btnSettTranslateClick;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.btnPauseTwoClick(Sender: TObject);
begin
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[5].IsSelected := true;
  MainForm.SetHint(sbPauseTwo.Text);

  labText.Text := '����� ������� ������ "�������" �������� ��������� �� ������ "������������".';
  Image.Fill.Bitmap.Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;
  tcSettSub.Visible := false;
  (Sender As TCornerButton).Text := '�������';
  (Sender As TCornerButton).OnClick := btnPublishClick;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.btnPublishClick(Sender: TObject);
begin
  labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� ����� ����������. ���� ���, �� ����������� ������ ��-���������.';
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[6].IsSelected := true;
  tcSettSub.Visible := true;

  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := PauseSleepLoop;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  Self.Hide;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.PauseSleepLoop(Sender: TObject);
begin
  labText.Text := '��������� ���������.';
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[8].IsSelected := true;
  MainForm.SetHint(sleepLoop.Text);
  (Sender As TCornerButton).Text := '���������';
  (Sender As TCornerButton).OnClick := btnCloseClick;
  tcSettSub.Visible := false;
end;

procedure TFormStartSubtitle.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� �� �������� ���� ��������������. ���� ���, �� ����������� ������ ��-���������.';
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[0].IsSelected := true;
  tcSettSub.Visible := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := btnPauseOneClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  Self.Tag := 0;
  Self.Hide;
end;

procedure TFormStartSubtitle.btnSettTranslateClick(Sender: TObject);
begin
  labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� �������� ���������. ���� ���, �� ����������� ������ ��-���������.';
  MainForm.lbSubtitles.ClearSelection;
  MainForm.lbSubtitles.ListItems[3].IsSelected := true;
  MainForm.btnTrackingStartClick(Sender);
  tcSettSub.Visible := true;
  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := btnPauseTwoClick;
  Image.Fill.Bitmap.Bitmap := ImageList.Source[2].MultiResBitmap[0].Bitmap;
  Self.Hide;
end;

procedure TFormStartSubtitle.FormShow(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbSubtitles;
  if Self.Tag = 0 then
  begin
    mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
    mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
  end;
  Self.Tag := 1;
end;

end.
