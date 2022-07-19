unit uAddEditForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, FireDAC.Comp.Client,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, FMX.ListView.Appearances;

type
  TAddEditForm = class(TForm)
    edName: TEdit;
    edCode: TEdit;
    btnSave: TSpeedButton;
    btnCancel: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddEditForm: TAddEditForm;

implementation

uses uMain, uLang;
{$R *.fmx}

procedure TAddEditForm.btnCancelClick(Sender: TObject);
begin
  Self.TagObject := nil;
  LangForm.btnEdit.Enabled := false;
  LangForm.btnDelete.Enabled := false;
  Self.Close;
end;

procedure TAddEditForm.btnSaveClick(Sender: TObject);
var
  tmpQuery: TFDQuery;
begin
  if Self.TagObject <> nil then
  begin
    tmpQuery := TFDQuery.Create(nil);
    tmpQuery.Connection := MainForm.Conn;
    tmpQuery.SQL.Add('update lang set lang_code = ''' + edCode.Text + ''', lang_name = ''' + edName.Text + ''' where lang_code = ''' + (Self.TagObject as TAppearanceListViewItem).Detail + '''');
    tmpQuery.ExecSQL;
    tmpQuery.DisposeOf;
  end
  else
  begin
    tmpQuery := TFDQuery.Create(nil);
    tmpQuery.Connection := MainForm.Conn;
    tmpQuery.SQL.Add('insert into lang (lang_code, lang_name) values (''' + edCode.Text + ''',''' + edName.Text + ''')');
    tmpQuery.ExecSQL;
    tmpQuery.DisposeOf;
  end;
  LangForm.Query.Active := false;
  LangForm.Query.Active := true;
  MainForm.Query.Active := false;
  MainForm.Query.Active := true;
  btnCancelClick(nil);
end;

procedure TAddEditForm.FormShow(Sender: TObject);
begin
  if Self.TagObject <> nil then
  begin
    edName.Text := (Self.TagObject as TAppearanceListViewItem).Text;
    edName.Text := Copy(edName.Text, Pos('-', edName.Text) + 2);
    edCode.Text := (Self.TagObject as TAppearanceListViewItem).Detail;
  end;
end;

end.
