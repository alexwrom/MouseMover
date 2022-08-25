unit uStartSettingSubtitle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, Winapi.Windows, uUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.ImageList, FMX.ImgList, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.StdCtrls, FMX.Controls.Presentation, FMX.TabControl, FMX.Effects, FMX.Layouts;

type
  TFormStartSubtitle = class(TForm)
    tcSettSub: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    sleepTime: TSpinBox;
    TabItem4: TTabItem;
    labText: TLabel;
    ImageList: TImageList;
    Label5: TLabel;
    Label6: TLabel;
    sbPauseTwo: TSpinBox;
    btnStart: TCornerButton;
    TabItem11: TTabItem;
    sleepLoop: TSpinBox;
    Label3: TLabel;
    Label4: TLabel;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnCloseForm: TSpeedButton;
    Image16: TImage;
    Rectangle3: TRectangle;
    ShadowEffect1: TShadowEffect;
    Image: TImage;
    Rectangle8: TRectangle;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    procedure btnSettNamePosAddClick(Sender: TObject);
    procedure btnPauseOneClick(Sender: TObject);
    procedure btnPauseTwoClick(Sender: TObject);
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
  tcSettSub.ActiveTab := TabItem1;
  btnStart.Text := '������';
  btnStart.OnClick := btnSettNamePosAddClick;
  Image.MultiResBitmap[0].Bitmap := ImageList.Source[1].MultiResBitmap[0].Bitmap;

  MainForm.SetInfo(MainForm.btnStart,'������� ����, ����� ������� � ���� ����������.');
  Self.Close;
end;

procedure TFormStartSubtitle.btnPauseOneClick(Sender: TObject);
begin
  MainForm.itemType := itemSleep;
  MainForm.OrderId := 3;
  MainForm.SetHint(sleepTime.Text);

   labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� �������� ���������. ���� ���, �� ����������� ������ ��-���������.';

  tcSettSub.Visible := true;
  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := btnPauseTwoClick;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.btnPauseTwoClick(Sender: TObject);
begin
  MainForm.itemType := itemSleep;
  MainForm.OrderId := 6;
  MainForm.SetHint(sbPauseTwo.Text);

   labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� ����� ����������. ���� ���, �� ����������� ������ ��-���������.';
  tcSettSub.Visible := true;

  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := PauseSleepLoop;
  tcSettSub.Next();
end;

procedure TFormStartSubtitle.PauseSleepLoop(Sender: TObject);
begin
  labText.Text := '��������� ���������.';
  MainForm.itemType := itemSleep;
  MainForm.OrderId := 9;
  MainForm.SetHint(sleepLoop.Text);
  (Sender As TCornerButton).Text := '���������';
  (Sender As TCornerButton).OnClick := btnCloseClick;
  tcSettSub.Visible := false;
end;


procedure TFormStartSubtitle.btnSettNamePosAddClick(Sender: TObject);
begin
  labText.Text := '���� ��� ������������ �������� ��������, �� ����� �� ������ ������� ������� ����� �� �������� ���� ��������������. ���� ���, �� ����������� ������ ��-���������.';
  MainForm.itemType := itemPos;
  MainForm.OrderId := 1;
  tcSettSub.Visible := true;
  MainForm.btnTrackingStartClick(Sender);
  (Sender As TCornerButton).Text := '����������';
  (Sender As TCornerButton).OnClick := btnPauseOneClick;
  Image.MultiResBitmap[0].Bitmap := nil;
  Self.Hide;
end;

procedure TFormStartSubtitle.FormShow(Sender: TObject);
begin
  MainForm.blockType := blockSubtitle;
end;

end.
