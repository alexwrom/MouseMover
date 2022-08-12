unit uFrameSettName;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uStartSettingName,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Memo.Types, FMX.Edit, FMX.TabControl, FMX.ListBox, FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.EditBox, FMX.SpinBox, FMX.Objects;

type
  TFrameSettName = class(TFrame)
    Label13: TLabel;
    Label14: TLabel;
    layHandData: TLayout;
    mDetails: TMemo;
    mName: TMemo;
    labCountWord: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Layout14: TLayout;
    swGetData: TSwitch;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Layout8: TLayout;
    Label11: TLabel;
    cbLang: TComboBox;
    QueryLang: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    Layout12: TLayout;
    btnStartSettingName: TCornerButton;
    Rectangle5: TRectangle;
    Layout1: TLayout;
    procedure swGetDataSwitch(Sender: TObject);
    procedure cbLangChange(Sender: TObject);
    procedure mNameChangeTracking(Sender: TObject);
    procedure btnStartSettingNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uMain;

{$R *.fmx}

procedure TFrameSettName.btnStartSettingNameClick(Sender: TObject);
begin
  MainForm.Hide;
  MainForm.SetInfo(FormStartName.btnStart, 'Нажмите сюда, чтобы начать настройку. Соблюдайте инструкцию.');
   MainForm.recTextInfo.Position.Y := MainForm.recTextInfo.Position.Y - 70;
  MainForm.recTextInfo.Position.X := MainForm.recTextInfo.Position.X - 50;
  FormStartName.ShowModal;

  MainForm.FormStyle := TFormStyle.StayOnTop;
  MainForm.Show;
  MainForm.FormStyle := TFormStyle.Normal;

end;

procedure TFrameSettName.cbLangChange(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbNameDetail;
  MainForm.lbNameDetail.Selected.Hint := FormStartName.edSourcePos.Text + ';' + FormStartName.edTargetPos.Text + ';' + FormStartName.edCurrentSourcePos.Text + ';' + FormStartName.edCurrentTargetPos.Text + ';' +
    Copy(cbLang.Selected.Text, cbLang.Selected.Text.Length - 2, 2) + ';' + swGetData.IsChecked.ToString;
  MainForm.SetHint(MainForm.lbNameDetail.Selected.Hint);

  MainForm.SetInfo(btnStartSettingName, 'Нажмите сюда, чтобы запустить настройку перевода.');
end;

procedure TFrameSettName.mNameChangeTracking(Sender: TObject);
begin
  labCountWord.Text := mName.Text.Length.ToString + '/100';
end;

procedure TFrameSettName.swGetDataSwitch(Sender: TObject);
begin
  MainForm.CurrListBox := MainForm.lbNameDetail;
  MainForm.lbNameDetail.ClearSelection;
  MainForm.lbNameDetail.ListItems[4].IsSelected := true;
  layHandData.Visible := swGetData.IsChecked;
  MainForm.lbNameDetail.Selected.Hint := FormStartName.edSourcePos.Text + ';' + FormStartName.edTargetPos.Text + ';' + FormStartName.edCurrentSourcePos.Text + ';' + FormStartName.edCurrentTargetPos.Text + ';' +
    Copy(cbLang.Selected.Text, cbLang.Selected.Text.Length - 2, 2) + ';' + swGetData.IsChecked.ToString;
  MainForm.SetHint(MainForm.lbNameDetail.Selected.Hint);

end;

end.
