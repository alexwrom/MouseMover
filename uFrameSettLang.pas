unit uFrameSettLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,System.Threading, uStartSettingLang,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Objects, FMX.ListView, FMX.Controls.Presentation,
  FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  FMX.ImgList, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrameSettLang = class(TFrame)
    Layout12: TLayout;
    btnSettLang: TSpeedButton;
    btnStartSettingLang: TCornerButton;
    ListViewLang: TListView;
    recPopup: TRectangle;
    btnOkPopup: TSpeedButton;
    Label25: TLabel;
    sbLangBtnPause: TSpinBox;
    Label26: TLabel;
    sbLangAddPause: TSpinBox;
    Layout15: TLayout;
    btnBackToLang: TSpeedButton;
    Label24: TLabel;
    ImageList: TImageList;
    QueryLang: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure btnStartSettingLangClick(Sender: TObject);
    procedure btnSettLangClick(Sender: TObject);
    procedure ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btnBackToLangClick(Sender: TObject);
    procedure btnOkPopupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uMain;

{$R *.fmx}

procedure TFrameSettLang.btnBackToLangClick(Sender: TObject);
begin
  recPopup.Visible := false;
end;

procedure TFrameSettLang.btnOkPopupClick(Sender: TObject);
var
  s: string;
begin
  s := MainForm.lbLang.ListItems[0].Hint;
  Delete(s, 1, Pos(';', s));
  Delete(s, 1, Pos(';', s));
  MainForm.lbLang.ListItems[0].Hint := sbLangBtnPause.Text + ';' + sbLangAddPause.Text + ';' + s;
  TTask.Run(
    procedure
    var
      I: integer;
    begin
      for I := 0 to MainForm.lbLang.Count - 1 do
        if MainForm.lbLang.ListItems[I].Tag = itemSeparator then
        begin
          MainForm.lbLang.ListItems[I + 3].Hint := sbLangBtnPause.Text;
          MainForm.lbLang.ListItems[I + 6].Hint := sbLangAddPause.Text;
        end;
    end);
  recPopup.Visible := false;

end;

procedure TFrameSettLang.btnSettLangClick(Sender: TObject);
begin
  recPopup.Visible := true;
end;

procedure TFrameSettLang.btnStartSettingLangClick(Sender: TObject);
begin
  MainForm.MultiViewSett.HideMaster;
  MainForm.Hide;
  FormStartLang.ShowModal;

  MainForm.FormStyle := TFormStyle.StayOnTop;
  MainForm.Show;
  MainForm.FormStyle := TFormStyle.Normal;
  MainForm.MultiViewSett.ShowMaster;
end;

procedure TFrameSettLang.ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  I, J: integer;
  s: string;
begin

  if AItem.Checked then
  begin

    MainForm.lbLang.Selected.Hint := MainForm.lbLang.Selected.Hint + AItem.Detail + ';';
    MainForm.lbLang.ClearSelection;

    MainForm.CreateItem(itemSeparator, MainForm.lbLang, AItem.Text);

    MainForm.CreateItem(itemPos, MainForm.lbLang, '0-0');
    // ќстальное пр€чем
    MainForm.CreateItem(itemClick, MainForm.lbLang);

    MainForm.CreateItem(itemSleep, MainForm.lbLang, sbLangBtnPause.Text);

    MainForm.CreateItem(itemText, MainForm.lbLang, AItem.Text);

    MainForm.CreateItem(itemEnter, MainForm.lbLang);

    MainForm.CreateItem(itemSleep, MainForm.lbLang, sbLangAddPause.Text);

    MainForm.CreateItem(itemScroll, MainForm.lbLang, '-10000');

    MainForm.CreateItem(itemSleep, MainForm.lbLang, '500');

    MainForm.lbLang.ListItems[0].IsSelected := true;
  end
  else
  begin
    s := MainForm.lbLang.Selected.Hint;
    Delete(s, Pos(AItem.Detail, s), Length(AItem.Detail) + 1);
    MainForm.lbLang.Selected.Hint := s;

    for I := 0 to MainForm.lbLang.Count - 1 do
      if (MainForm.lbLang.ListItems[I].Tag = itemSeparator) and (MainForm.lbLang.ListItems[I].Hint = AItem.Text) then
      begin

        for J := 1 to 9 do
          MainForm.lbLang.Items.Delete(I);

        break;
      end;

  end;
  MainForm.lbLang.ListItems[0].IsSelected := true;

end;

end.
