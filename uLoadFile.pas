unit uLoadFile;

interface

uses System.Types, System.SysUtils, FMX.Forms, Wininet, Registry, WinApi.Windows, IdHashMessageDigest, FMX.Dialogs;

function GetInetFile(FileName: string): boolean;
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

  if FReestr.ValueExists('ComputerHardwareId') then
    Result := Hash(FReestr.ReadString('ComputerHardwareId'));
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

end.
