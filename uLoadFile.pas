unit uLoadFile;

interface

uses System.Types, System.SysUtils, FMX.Forms, Wininet, Registry, WinApi.Windows, IdHashMessageDigest, FMX.Dialogs;

function GetInetFile(FileName: string): boolean;
function Win7: string;
function ProductID: string;
function GetHardID: string;
function GetID(): string;
function Hash(InText: string): string;

implementation

function GetInetFile(FileName: string): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array [1 .. BufferSize] of Byte;
  BufferLen: DWORD;
  f: file;
  sAppName: string;
begin
  Result := False;
  sAppName := ExtractFileName(Application.Name);
  hSession := InternetOpen(PChar(sAppName), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    try
      hURL := InternetOpenURL(hSession, PChar('https://drive.google.com/u/0/uc?id=1MSbOx0b9JO_il_wd_CkzUIcp4zXNgZpS&export=download'), nil, 0, 0, 0);
      try
        AssignFile(f, FileName);
        Rewrite(f, 1);
        repeat
          InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
          BlockWrite(f, Buffer, BufferLen);
        until BufferLen = 0;
        Result := True;
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
  FReestr.OpenKey('SYSTEM\CurrentControlSet\Control\SystemInformation', False);

  Result := Hash(Win7 + ProductID + GetHardID + FReestr.ReadString('ComputerHardwareId'));
  FreeAndNil(FReestr); // Уничтожаем переменную
end;

function Hash(InText: string): string;
begin
  with TIdHashMessageDigest5.Create do
  begin
    Result := HashStringAsHex(InText);
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
    Result := IntToStr(SerialNum);
end;

function ProductID: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ);
  Reg.Rootkey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', False);
  Result := Reg.ReadString('ProductId');
  Reg.Free;
end;

function Win7: string;
var
  FReestr: TRegIniFile; // Определяем переменную
  b: boolean;
begin
  FReestr := TRegIniFile.Create('software');
  FReestr.OpenKey('Samalex', False);
  Result := FReestr.ReadString('MouseMover', 'GUID', '');

end;

end.
