unit uFrameSettLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Threading, uStartSettingLang, StrUtils,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Objects, FMX.ListView, FMX.Controls.Presentation,
  FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  FMX.ImgList, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Effects;

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
    Rectangle1: TRectangle;
    Rectangle5: TRectangle;
    Layout1: TLayout;
    InnerGlowEffect1: TInnerGlowEffect;
    InnerGlowEffect2: TInnerGlowEffect;
    procedure btnStartSettingLangClick(Sender: TObject);
    procedure btnSettLangClick(Sender: TObject);
    procedure ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure btnBackToLangClick(Sender: TObject);
    procedure btnOkPopupClick(Sender: TObject);
  private
    procedure InsHint(IdComponent: integer; HintText: string);
    procedure DelHint(IdOrder: integer);
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
  MainForm.lbLang.ClearSelection;
  MainForm.lbLang.ListItems[0].IsSelected := true;
  s := MainForm.lbLang.Selected.Hint;
  Delete(s, 1, Pos(';', s));
  Delete(s, 1, Pos(';', s));

  MainForm.lbLang.Selected.Hint := sbLangBtnPause.Text + ';' + sbLangAddPause.Text + ';' + s;
  MainForm.SetHint(MainForm.lbLang.Selected.Hint);

  TTask.Run(
    procedure
    var
      I: integer;
    begin
      for I := 0 to MainForm.lbLang.Count - 1 do
        if MainForm.lbLang.ListItems[I].Tag = itemSeparator then
        begin
          MainForm.lbLang.ClearSelection;
          MainForm.lbLang.ListItems[I + 3].IsSelected := true;
          MainForm.lbLang.Selected.Hint := sbLangBtnPause.Text;
          MainForm.SetHint(MainForm.lbLang.Selected.Hint);

          MainForm.lbLang.ClearSelection;
          MainForm.lbLang.ListItems[I + 6].IsSelected := true;
          MainForm.lbLang.Selected.Hint := sbLangAddPause.Text;
          MainForm.SetHint(MainForm.lbLang.Selected.Hint);
        end;
    end);
  recPopup.Visible := false;
  MainForm.SetInfo(btnStartSettingLang, 'Нажмите сюда, чтобы запустить настройку автозаполнения языков');
end;

procedure TFrameSettLang.btnSettLangClick(Sender: TObject);
begin
  recPopup.Visible := true;
  MainForm.SetInfo(btnOkPopup, 'Нажмите сюда, чтобы сохранить введенные данные');
end;

procedure TFrameSettLang.btnStartSettingLangClick(Sender: TObject);
begin
  if MainForm.lbLang.Count > 1 then
  begin
    MainForm.Hide;
    MainForm.SetInfo(FormStartLang.btnStart, 'Нажмите сюда, чтобы начать настройку. Соблюдайте инструкцию.');
    MainForm.recTextInfo.Position.Y := MainForm.recTextInfo.Position.Y - 70;
    MainForm.recTextInfo.Position.X := MainForm.recTextInfo.Position.X - 50;
    FormStartLang.ShowModal;

    MainForm.Show;
    MainForm.FormStyle := TFormStyle.Normal;
  end;

end;

procedure TFrameSettLang.DelHint(IdOrder: integer);
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := MainForm.Conn;

  tmpQuery.SQL.Add('delete from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order between ' + IdOrder.ToString + ' and ' + (IdOrder + 9).ToString + ';' +
    'update objects set id_order = id_order - 9 where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order > ' + (IdOrder + 9).ToString + ';');
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;

end;

procedure TFrameSettLang.ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  I, J: integer;
  s: string;
  IsNotFirst: boolean;
  textItem: string;
begin

  if AItem.Checked then
  begin
    IsNotFirst := MainForm.lbLang.Count >= 10;
    MainForm.lbLang.Selected.Hint := MainForm.lbLang.Selected.Hint + AItem.Detail + ';';
    MainForm.SetHint(MainForm.lbLang.Selected.Hint);

    MainForm.lbLang.ClearSelection;

    MainForm.CreateItem(itemSeparator, MainForm.lbLang, AItem.Text);
    InsHint(itemSeparator, AItem.Text);

    if IsNotFirst then
      textItem := MainForm.lbLang.ListItems[MainForm.lbLang.Count - 9].Hint
    else
      textItem := '0-0';

    MainForm.CreateItem(itemPos, MainForm.lbLang, textItem);
    InsHint(itemPos, textItem);
    // Остальное прячем
    MainForm.CreateItem(itemClick, MainForm.lbLang);
    InsHint(itemClick, '');

    if IsNotFirst then
      textItem := MainForm.lbLang.ListItems[MainForm.lbLang.Count - 9].Hint
    else
      textItem := sbLangBtnPause.Text;

    MainForm.CreateItem(itemSleep, MainForm.lbLang, textItem);
    InsHint(itemSleep, textItem);

    MainForm.CreateItem(itemText, MainForm.lbLang, AItem.Text);
    InsHint(itemText, AItem.Text);

    MainForm.CreateItem(itemEnter, MainForm.lbLang);
    InsHint(itemEnter, '');

    if IsNotFirst then
      textItem := MainForm.lbLang.ListItems[MainForm.lbLang.Count - 9].Hint
    else
      textItem := sbLangAddPause.Text;

    MainForm.CreateItem(itemSleep, MainForm.lbLang, textItem);
    InsHint(itemSleep, textItem);

    MainForm.CreateItem(itemScroll, MainForm.lbLang, '-10000');
    InsHint(itemScroll, '-10000');

    MainForm.CreateItem(itemSleep, MainForm.lbLang, '500');
    InsHint(itemSleep, '500');

    MainForm.lbLang.ListItems[0].IsSelected := true;
  end
  else
  begin
    s := MainForm.lbLang.Selected.Hint;
    Delete(s, Pos(AItem.Detail, s), Length(AItem.Detail) + 1);
    MainForm.lbLang.Selected.Hint := s;
    MainForm.SetHint(MainForm.lbLang.Selected.Hint);

    for I := 0 to MainForm.lbLang.Count - 1 do
      if (MainForm.lbLang.ListItems[I].Tag = itemSeparator) and (MainForm.lbLang.ListItems[I].Hint = AItem.Text) then
      begin

        for J := 1 to 9 do
          MainForm.lbLang.Items.Delete(I);

        DelHint(I + 1);
        break;
      end;

  end;
  MainForm.lbLang.ListItems[0].IsSelected := true;

end;

procedure TFrameSettLang.InsHint(IdComponent: integer; HintText: string);
var
  tmpQuery: TFDQuery;
begin
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := MainForm.Conn;

  tmpQuery.SQL.Add('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1,' + IdComponent.ToString + ',''' + HintText + ''',' + MainForm.lbLang.Count.ToString + ',' + MainForm.ProfileID.ToString + ')');
  tmpQuery.ExecSQL;
  tmpQuery.DisposeOf;
end;

end.
