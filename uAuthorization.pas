unit uAuthorization;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, uLoadFile, System.Variants, Registry, IdMessage, IdSMTP, IdMessageClient,
  IdSMTPBase, IdSSLOpenSSL,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, FMX.TabControl, FMX.ListBox, System.JSON, System.Net.HTTPClient,
  System.NetEncoding, IdAttachmentFile, FMX.Objects;

type
  TAuthorizationForm = class(TForm)
    btnClose: TSpeedButton;
    IdMessage1: TIdMessage;
    IdSMTP1: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    TabControl: TTabControl;
    tabData: TTabItem;
    edEmail: TEdit;
    Label4: TLabel;
    tabPayInfo: TTabItem;
    tabSend: TTabItem;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    labScore: TLabel;
    btnSend: TButton;
    ToolBar1: TToolBar;
    btnBack: TButton;
    cbCurrency: TComboBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Image: TImage;
    btnAttach: TButton;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    edFIO: TEdit;
    tabMessage: TTabItem;
    Label7: TLabel;
    Label8: TLabel;
    btnReSend: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure cbCurrencyChange(Sender: TObject);
    procedure btnAttachClick(Sender: TObject);
    procedure btnReSendClick(Sender: TObject);
  private
    FileAttach: string;

    function GetScoreInCurr(CurrCode: string): double;
    function IsSendMessage: boolean;
    procedure SetIsSendMessage;
    procedure SendMessage;

    { Private declarations }
  public
    Trial: boolean;
    { Public declarations }
  end;

var
  AuthorizationForm: TAuthorizationForm;

implementation

uses uMain;

{$R *.fmx}

procedure TAuthorizationForm.btnAttachClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FileAttach := OpenDialog.FileName;
    Image.MultiResBitmap[0].Bitmap.LoadFromFile(FileAttach);
  end;
end;

procedure TAuthorizationForm.btnCloseClick(Sender: TObject);
begin
  if NOT MainForm.Visible then
    Application.Terminate;
end;

procedure TAuthorizationForm.btnReSendClick(Sender: TObject);
begin
  TabControl.ActiveTab := tabPayInfo;
  btnSend.Visible := true;
end;

procedure TAuthorizationForm.btnSendClick(Sender: TObject);

begin

  if TabControl.ActiveTab = tabData then
    if (edEmail.text = '') or (edFIO.text = '') then
      ShowMessage('��������� ��� ����!!!')
    else
    begin
      SetIsSendMessage;
      ShowMessage('����� ���������� � ���������� MouseMover.' + #13#10 + '��� ��� �������� Trial ������ ���������� � ������������ �������� ���������.');

      Self.Close;
      MainForm.Show;
    end
  else if TabControl.ActiveTab = tabPayInfo then
    TabControl.Next()
  else
  begin
    ShowMessage('���� �� �� ���������� ��������, �������������� ������, �� ����� ������ ����� ������������ ��� ������. ���� �� ������ ��� �������, �� ������ ��������� �������� ��� ��������� ������� ����������.');
    SendMessage();
  end;
end;

procedure TAuthorizationForm.SendMessage();
var
  imgpart: TIdAttachmentFile;
begin
  SetIsSendMessage;
  IdSMTP1.Username := 'alexwrom@mail.ru'; // �����
  IdSMTP1.Password := 'gJhz0ZnHGUcJIpdiRi4K'; // ������
  IdSMTP1.Host := 'smtp.mail.ru'; // ����
  IdSMTP1.Port := 25; // ���� (25 - �� ���������)
  IdMessage1.CharSet := 'windows-1251'; // ��������� � ���� ���������
  IdMessage1.Body.text := '������� �.�.: ' + edFIO.text + #13#10 + 'Email: ' + edEmail.text + #13#10 + 'ID ������������: ' + GetID; // ����� ���������
  IdMessage1.Subject := '�������'; // ���� ���������
  IdMessage1.From.Address := 'alexwrom@mail.ru'; // ����� �����������
  IdMessage1.From.Name := 'MouseMover - ������� ��������';
  IdMessage1.Recipients.EMailAddresses := 'alexwrom@gmail.com'; // ���� ��������� ������ (����� ����� ������� ���� ��������� e-mail'��)

  if FileAttach <> '' then
  begin
    IdMessage1.ContentType := 'multipart/alternative';
    IdMessage1.MessageParts.Clear;
    IdMessage1.IsEncoded := true;
    imgpart := TIdAttachmentFile.Create(IdMessage1.MessageParts, FileAttach);
    imgpart.ContentType := 'image/jpeg';
  end
  else
    IdMessage1.ContentType := 'text/html';

  IdSSLIOHandlerSocketOpenSSL1.DefaultPort := 0;
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method := sslvTLSv1;
  IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode := sslmUnassigned;

  IdSMTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
  IdSMTP1.UseTLS := utUseExplicitTLS;
  try
    // ���������� � �������� ��������
    IdSMTP1.Connect();
    IdSMTP1.Send(IdMessage1);
    ShowMessage('����� �������� ������ �� ��������� ���� ����� ������ ��������� ������������� �������.' + #13#10 + '������� �� ��������� ����� � ��������� �����������.' + #13#10 + #13#10 +
      'P.S. ���������� ��������� ����� ������� ������� ''Ok''. ��������������� ����������� �� ������� ����� ��������� ��������� �� ��������������.');
    Application.Terminate;
  except
    ShowMessage('������ �������� ��������� ��������������. ��������� �����');
  end;
  // ������������� �� ��������� �������
  IdSMTP1.Disconnect;
end;

procedure TAuthorizationForm.btnBackClick(Sender: TObject);
begin
  TabControl.Previous();
  if TabControl.ActiveTab = tabData then
    btnBack.Visible := false;
end;

procedure TAuthorizationForm.cbCurrencyChange(Sender: TObject);
begin
  case cbCurrency.ItemIndex of
    0:
      labScore.text := (Round(50 * GetScoreInCurr('840'))).ToString + ' �.';
    1:
      labScore.text := (Round(50 * GetScoreInCurr('840') / GetScoreInCurr('643') * 100)).ToString + ' �.';
    2:
      labScore.text := '50 $';
    3:
      labScore.text := (Round(50 * GetScoreInCurr('840') / GetScoreInCurr('978'))).ToString + ' �';
  end;
end;

function TAuthorizationForm.GetScoreInCurr(CurrCode: string): double;
var
  AResponce: IHTTPResponse;
  FHTTPClient: THTTPClient;
  AAPIUrl: String;
  j: Integer;
  s: string;
begin
  AAPIUrl := 'https://www.nbrb.by/api/exrates/rates/' + CurrCode + '?parammode=1';
  FHTTPClient := THTTPClient.Create;
  FHTTPClient.UserAgent := 'Mozilla/5.0 (Windows; U; Windows NT 6.1; ru-RU) Gecko/20100625 Firefox/3.6.6';
  result := 0;
  AResponce := FHTTPClient.Get(AAPIUrl);

  if AResponce.StatusCode = 200 then
  begin
    try
      s := AResponce.ContentAsString;
      result := TJSONObject.ParseJSONValue(AResponce.ContentAsString).GetValue<double>('Cur_OfficialRate');
    except
      result := 0;
    end;
  end;
end;

procedure TAuthorizationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if NOT MainForm.Visible then
    Application.Terminate;
end;

procedure TAuthorizationForm.FormShow(Sender: TObject);
begin

  if IsSendMessage then
  begin
    Trial := false;
    TabControl.ActiveTab := tabMessage;
    btnSend.Visible := false;
  end
  else
  begin
    Trial := true;
    TabControl.ActiveTab := tabData;
    btnSend.Visible := true;
  end;
end;

function TAuthorizationForm.IsSendMessage(): boolean;
var
  FReestr: TRegIniFile; // ���������� ����������
  b: boolean;
begin
  result := false;
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', false);
  result := FReestr.ReadBool('MouseMover', 'IsSend', false);

  edEmail.text := FReestr.ReadString('MouseMover', 'EMail', '');
  edFIO.text := FReestr.ReadString('MouseMover', 'FIO', '');
  FreeAndNil(FReestr); // ���������� ����������
end;

procedure TAuthorizationForm.SetIsSendMessage();
var
  FReestr: TRegIniFile; // ���������� ����������
  b: boolean;
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', true);
  FReestr.WriteBool('MouseMover', 'IsSend', true);
  FReestr.WriteString('MouseMover', 'FIO', edFIO.text);
  FReestr.WriteString('MouseMover', 'EMail', edEmail.text);
  FReestr.WriteString('MouseMover', 'GUID', Hash(edEmail.text));

  if FReestr.ReadString('MouseMover', 'TRIAL', '') = '' then
    FReestr.WriteString('MouseMover', 'TRIAL', Hash('200'));
  FreeAndNil(FReestr); // ���������� ����������
end;

end.
