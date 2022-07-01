unit uLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uAddEditForm,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.DialogService, FMX.Effects;

type
  TLangForm = class(TForm)
    ListView: TListView;
    Query: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Layout1: TLayout;
    btnAdd: TButton;
    LinkFillControlToField1: TLinkFillControlToField;
    btnEdit: TButton;
    btnDelete: TButton;
    ShadowEffect1: TShadowEffect;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LangForm: TLangForm;

implementation

uses uMain;
{$R *.fmx}

procedure TLangForm.btnAddClick(Sender: TObject);
begin
  AddEditForm.ShowModal;
end;

procedure TLangForm.btnDeleteClick(Sender: TObject);
var
  tmpQuery: TFDQuery;
begin
  TDialogService.MessageDialog('Вы согласны с удалением?', TmsgDlgType.mtInformation, [TmsgDlgBtn.mbYes, TmsgDlgBtn.mbNo], TmsgDlgBtn.mbYes, 0,
    procedure(const AResult: TmodalResult)
    var
      SelHint: string;
      Index: integer;
    begin
      if AResult = mrYes then
      begin
        tmpQuery := TFDQuery.Create(nil);
        tmpQuery.Connection := MainForm.Conn;
        tmpQuery.SQL.Add('delete from lang where lang_code = ''' + ListView.Items[ListView.Selected.Index].Detail + '''');
        tmpQuery.ExecSQL;
        tmpQuery.DisposeOf;

        Query.Active := false;
        Query.Active := true;
      end;
    end);
end;

procedure TLangForm.btnEditClick(Sender: TObject);
begin
  AddEditForm.TagObject := ListView.Items[ListView.Selected.Index];
  AddEditForm.ShowModal;
end;

procedure TLangForm.FormShow(Sender: TObject);
begin
  Query.Active := false;
  Query.Active := true;
end;

procedure TLangForm.ListViewChange(Sender: TObject);
begin
  btnEdit.Enabled := true;
  btnDelete.Enabled := true;
end;

end.
