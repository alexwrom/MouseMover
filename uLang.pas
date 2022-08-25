unit uLang;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uAddEditForm, uLoadFile,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.DialogService, FMX.Effects, FMX.Objects, FMX.Edit, Registry;

type
  TLangForm = class(TForm)
    ListView: TListView;
    Query: TFDQuery;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    ShadowEffect1: TShadowEffect;
    Background: TRectangle;
    ShadowEffect5: TShadowEffect;
    Layout2: TLayout;
    Label9: TLabel;
    btnCloseApp: TSpeedButton;
    Image16: TImage;
    layBottom: TLayout;
    btnEdit: TSpeedButton;
    Image1: TImage;
    btnAdd: TSpeedButton;
    Image4: TImage;
    btnDelete: TSpeedButton;
    Image2: TImage;
    Layout1: TLayout;
    edEmail: TEdit;
    edFIO: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Layout3: TLayout;
    labTextInfo: TLabel;
    swOnOffInfo: TSwitch;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewChange(Sender: TObject);
    procedure edFIOChangeTracking(Sender: TObject);
    procedure btnCloseAppClick(Sender: TObject);
    procedure swOnOffInfoSwitch(Sender: TObject);
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

procedure TLangForm.btnCloseAppClick(Sender: TObject);
begin
  Self.Close;
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

procedure TLangForm.edFIOChangeTracking(Sender: TObject);
var
  FReestr: TRegIniFile; // Определяем переменную
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', true);
  FReestr.WriteString('MouseMover', 'FIO', edFIO.text);
  FReestr.WriteString('MouseMover', 'EMail', edEmail.text);

  FreeAndNil(FReestr); // Уничтожаем переменную
end;

procedure TLangForm.FormShow(Sender: TObject);
var
  FReestr: TRegIniFile; // Определяем переменную
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', true);
  edFIO.text := FReestr.ReadString('MouseMover', 'FIO', '');
  edEmail.text := FReestr.ReadString('MouseMover', 'EMail', '');
  FreeAndNil(FReestr); // Уничтожаем переменную

  edFIO.OnChangeTracking := edFIOChangeTracking;
  edEmail.OnChangeTracking := edFIOChangeTracking;

  Query.Active := false;
  Query.Active := true;
  swOnOffInfo.IsChecked := GetOnOffHelp;
end;

procedure TLangForm.ListViewChange(Sender: TObject);
begin
  btnEdit.Enabled := true;
  btnDelete.Enabled := true;
end;

procedure TLangForm.swOnOffInfoSwitch(Sender: TObject);
begin
  MainForm.recTextInfo.Visible := swOnOffInfo.IsChecked;
  MainForm.recTextInfo.Parent := MainForm.btnMasterLeft;
  SetOnOffHelp(swOnOffInfo.IsChecked);
end;

end.
