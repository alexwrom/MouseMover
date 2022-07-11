unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.FMXUI.Wait, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, FMX.ListView, System.ImageList,
  FMX.ImgList, FMX.Menus, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.Edit, FMX.ScrollBox, FMX.Memo, IdBaseComponent, IdMessage, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TMainForm = class(TForm)
    ListView: TListView;
    Query: TFDQuery;
    Conn: TFDConnection;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    ImageList: TImageList;
    btnAdd: TSpeedButton;
    btnEdit: TSpeedButton;
    btnDel: TSpeedButton;
    SpeedButton1: TSpeedButton;
    btnSendAll: TSpeedButton;
    edHeader: TMemo;
    edFooter: TMemo;
    edText: TMemo;
    edThema: TEdit;
    IdMessage1: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure btnSendAllClick(Sender: TObject);
  private
    procedure SendMessage(EMailTo: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnSendAllClick(Sender: TObject);
var
  I: Integer;
  SendList: string;
begin
  for I := 0 to ListView.ItemCount - 1 do
  begin
    if ListView.Items[I].ImageIndex = 1 then
    begin
      if SendList <> '' then
        SendList := ',' + SendList;
      SendList := ListView.Items[I].Detail;
    end;
  end;
  SendMessage(SendList);
end;

procedure TMainForm.SendMessage(EMailTo: string);
begin
  IdSMTP1.Username := 'alexwrom@mail.ru'; // Логин
  IdSMTP1.Password := 'irAt8u6Q9GkwTORWaHPf'; // Пароль
  IdSMTP1.Host := 'smtp.mail.ru'; // Хост
  IdSMTP1.Port := 25; // Порт (25 - по умолчанию)
  IdMessage1.CharSet := 'windows-1251'; // Кодировка в теле сообщения
  IdMessage1.Body.text := edHeader.text + #13#10 + edText.text + #13#10 + edFooter.text; // Текст сообщения
  IdMessage1.ContentType := 'text/html';
  IdMessage1.Subject := edThema.text; // Тема сообщения
  IdMessage1.From.Address := 'alexwrom@mail.ru'; // Адрес отправителя
  IdMessage1.From.Name := 'MouseMover by Samasiuk';
  IdMessage1.Recipients.EMailAddresses := EMailTo; // Кому отправить письмо (можно через запятую если несколько e-mail'ов)

  IdSSLIOHandlerSocketOpenSSL1.DefaultPort := 0;
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvTLSv1;
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode := sslmUnassigned;

  IdSMTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  IdSMTP1.UseTLS := utUseExplicitTLS;
  try
    // Соединение с почтовым сервером
    IdSMTP1.Connect();
    IdSMTP1.Send(IdMessage1);
    ShowMessage('Рассылка отправлена');
  except
  end;
  // Отсоединяемся от почтового сервера
  IdSMTP1.Disconnect;
end;

end.
