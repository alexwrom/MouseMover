unit uFrameSettLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Threading, uStartSettingLang, StrUtils,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Edit, FMX.EditBox, FMX.SpinBox, FMX.Objects, FMX.ListView, FMX.Controls.Presentation,
  FMX.Layouts, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  FMX.ImgList, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Effects, uUtils;

type
  TFrameSettLang = class(TFrame)
    Layout12: TLayout;
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
    btnSettLang: TSpeedButton;
    Image12: TImage;
    Layout1: TLayout;
    Image1: TImage;
    Image2: TImage;
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

const
  ONLY_PAUSE_1 = 'with tmp as (select * from objects  where  id_type = 1 and id_component = 3 and id_profile = %s) select id_object from ' +
    '(select t.*,(SELECT count(*) FROM tmp b  WHERE t.id_order >= b.id_order) as row from tmp t where row = 1 or (row - 1)';
  ONLY_PAUSE_2 = 'with tmp as (select * from objects  where  id_type = 1 and id_component = 3 and id_profile = %s) select id_object from ' +
    '(select t.*,(SELECT count(*) FROM tmp b  WHERE t.id_order >= b.id_order) as row from tmp t where row = 2 or (row - 2)';
  ONLY_PAUSE_3 = 'with tmp as (select * from objects  where  id_type = 1 and id_component = 3 and id_profile = %s) select id_object from ' + '(select t.*,(SELECT count(*) FROM tmp b  WHERE t.id_order >= b.id_order) as row from tmp t where row';

{$R *.fmx}

procedure TFrameSettLang.btnBackToLangClick(Sender: TObject);
begin
  recPopup.Visible := false;
end;

procedure TFrameSettLang.btnOkPopupClick(Sender: TObject);
var
  s: string;
begin
  MainForm.OrderId := 1;
  MainForm.blockType := blockLang;
  s := MainForm.ActiveSQL('select hint_component from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order = 1').FieldByName('hint_component').AsString;
  Delete(s, 1, Pos(';', s));
  Delete(s, 1, Pos(';', s));

  MainForm.SetHint(sbLangBtnPause.Text + ';' + sbLangAddPause.Text + ';' + s);
  MainForm.ExeSQL('update objects set hint_component = ' + sbLangBtnPause.Text + ' where id_object in (' + Format(ONLY_PAUSE_1, [MainForm.ProfileID.ToString]) + ' % 3 = 0))');
  MainForm.ExeSQL('update objects set hint_component = ' + sbLangAddPause.Text + ' where id_object in (' + Format(ONLY_PAUSE_2, [MainForm.ProfileID.ToString]) + ' % 3 = 0))');
  // tmpQuery.SQL.Add('update objects set hint_component = ' + sbLangAddPause.Text + ' where id_object in ('+Format(ONLY_PAUSE_3,[MainForm.ProfileID.ToString])+')');

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
  if MainForm.ActiveSQL('select Count(*) as cnt from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1').FieldByName('cnt').AsInteger > 1 then
  begin
    MainForm.Hide;
    MainForm.SetInfo(FormStartLang.btnStart, 'Нажмите сюда, чтобы начать настройку. Соблюдайте инструкцию.');
    FormStartLang.ShowModal;

    MainForm.Show;
    MainForm.FormStyle := TFormStyle.Normal;
  end;

end;

procedure TFrameSettLang.ListViewLangItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  I, J: integer;
  s: string;
  IsNotFirst: boolean;
  textItem: string;
  IdOrder: string;
begin
  MainForm.OrderId := 1;
  MainForm.blockType := blockLang;
  if AItem.Checked then
  begin

    MainForm.SetHint(MainForm.ActiveSQL('select hint_component from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order = 1').FieldByName('hint_component').AsString + AItem.Detail + ';');

    if MainForm.GetCountLang = 0 then
    begin
      MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 1,(select hint_component from objects where id_profile = ' + MainForm.ProfileID.ToString +
        ' and id_type = 1 and id_component = 1 order by id_order desc limit 1), (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1),' + MainForm.ProfileID.ToString + ')');

      MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 2,'''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1),' +
        MainForm.ProfileID.ToString + ')');
    end
    else
    begin
      MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 18,''' + ((MainForm.GetCountLang * 2) + 4).ToString + ''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString +
        ' and id_type = 1),' + MainForm.ProfileID.ToString + ')');
        MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 16,'''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString +
        ' and id_type = 1),' + MainForm.ProfileID.ToString + ')');
    end;

    MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 3,''' + sbLangBtnPause.Text + ''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString +
      ' and id_type = 1),' + MainForm.ProfileID.ToString + ')');
    MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 17,''' + AItem.Text + ''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1),' +
      MainForm.ProfileID.ToString + ')');

    MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 16,'''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1),' +
      MainForm.ProfileID.ToString + ')');
    MainForm.ExeSQL('insert into objects (id_type , id_component,hint_component, id_order,id_profile) values (1, 3,''' + sbLangAddPause.Text + ''', (select Count(*) + 1 from objects where id_profile = ' + MainForm.ProfileID.ToString +
      ' and id_type = 1),' + MainForm.ProfileID.ToString + ')');

  end
  else
  begin
    s := MainForm.ActiveSQL('select hint_component from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order = 1').FieldByName('hint_component').AsString;
    Delete(s, Pos(AItem.Detail, s), Length(AItem.Detail) + 1);
    MainForm.SetHint(s);
     IdOrder := MainForm.ActiveSQL('select (id_order - 3) as id_order from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_component = 17 and hint_component = ''' + AItem.Text + '''').FieldByName('id_order').AsString;

     MainForm.ExeSQL('update objects set hint_component = TO_CHAR(TO_NUMBER(hint_component) - 2) where id_profile = ' + MainForm.ProfileID.ToString +
     ' and id_type = 1 and id_component = 18 and id_order >= ' + IdOrder + ' + 6;');
     MainForm.ExeSQL('delete from objects where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order between ' + IdOrder + ' and ' + IdOrder + ' + 5;');
     MainForm.ExeSQL('update objects set id_order = id_order - 6 where id_profile = ' + MainForm.ProfileID.ToString + ' and id_type = 1 and id_order >= ' + IdOrder + ' + 6;');
  end;

end;

end.
