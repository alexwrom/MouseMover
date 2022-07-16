unit uLoadFile;

interface

uses System.Types, System.SysUtils, FMX.Forms, Wininet, Registry, WinApi.Windows, IdHashMessageDigest, FMX.Dialogs, System.Threading;

function GetInetFile(FileName: string; URL: string): boolean;
function Win7: string;
function ProductID: string;
function GetHardID: string;
function GetID(): string;
function Hash(InText: string): string;
function GetLastCount: Integer;
procedure SetCountLang(LastCount: Integer);
function GetTempWindows: string;

implementation

function GetTempWindows: string;
var
  lng: DWORD;
  thePath: string;
begin
  SetLength(thePath, MAX_PATH);
  lng := GetTempPath(MAX_PATH, PChar(thePath));
  SetLength(thePath, lng);
  result := thePath;
end;

function GetInetFile(FileName: string; URL: string): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array [1 .. BufferSize] of Byte;
  BufferLen: DWORD;
  f: file;
  sAppName: string;
begin
  result := false;

  sAppName := ExtractFileName(Application.Name);
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    try
      hURL := InternetOpenURL(hSession, PChar(URL), nil, 0, 0, 0);
      try
        AssignFile(f, FileName);
        Rewrite(f, 1);

        repeat
          InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
          BlockWrite(f, Buffer, BufferLen);

        until BufferLen = 0;
        result := True;
      finally
        CloseFile(f);
        InternetCloseHandle(hURL);
      end;
    finally
      InternetCloseHandle(hSession);
    end;
  except
    ShowMessage('Ошибка проверки авторизации. Возможно,отсутствует соединение с интернетом.');
    Application.Terminate;
  end;
end;

function GetID(): string;
var
  FReestr: TRegistry; // Определяем переменную
  b: boolean;
begin
  FReestr := TRegistry.Create(KEY_READ);
  FReestr.Rootkey := HKEY_LOCAL_MACHINE;
  FReestr.OpenKey('SYSTEM\CurrentControlSet\Control\SystemInformation', false);

  result := Hash(Win7 + ProductID + GetHardID + FReestr.ReadString('ComputerHardwareId'));
  FreeAndNil(FReestr); // Уничтожаем переменную
end;

function Hash(InText: string): string;
begin
  with TIdHashMessageDigest5.Create do
  begin
    result := HashStringAsHex(InText);
    DisposeOf;
  end;
end;

function GetHardID: string;
var
  SerialNum: DWORD;
  a, b: DWORD;
  Buffer: array [0 .. 255] of char;
begin
  if GetVolumeInformation('C:\', Buffer, SizeOf(Buffer), @SerialNum, a, b, nil, 0) then
    result := IntToStr(SerialNum);
end;

function ProductID: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  Reg.Rootkey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', false);
  result := Reg.ReadString('ProductId');
  Reg.Free;
end;

function Win7: string;
var
  FReestr: TRegIniFile; // Определяем переменную
  b: boolean;
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', false);
  result := FReestr.ReadString('MouseMover', 'GUID', '');

end;

procedure SetCountLang(LastCount: Integer);
var
  FReestr: TRegIniFile; // Определяем переменную
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', True);
  FReestr.WriteString('MouseMover', 'TRIAL', Hash(LastCount.ToString));
  FreeAndNil(FReestr); // Уничтожаем переменную
end;

function GetLastCount: Integer;
var
  FReestr: TRegIniFile; // Определяем переменную
  TrialCount: string;
  I: Integer;
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', True);
  result := 0;
  for I := 0 to 200 do
  begin
    TrialCount := FReestr.ReadString('MouseMover', 'TRIAL', Hash('0'));
    if TrialCount = Hash(I.ToString) then
    begin
      result := I;
      break
    end;
  end;

  FreeAndNil(FReestr); // Уничтожаем переменную
end;

end.
