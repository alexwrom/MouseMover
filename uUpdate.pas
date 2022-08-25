unit uUpdate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, uLoadFile, System.Threading, ShellApi,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects;

type
  TUpdateForm = class(TForm)
    AniIndicator: TAniIndicator;
    labWait: TLabel;
    Image1: TImage;
    ShadowEffect1: TShadowEffect;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

{$R *.fmx}

procedure TUpdateForm.FormShow(Sender: TObject);
var
  wideChars: array [0 .. 100] of WideChar;
  FileName: String;
  HWND: THandle;
begin
    FileName := GetTempWindows + '\Update AutoClicker.exe';
    TTask.Run( // uses System.Threading
      procedure
      begin
        GetInetFile(FileName, 'https://drive.google.com/u/0/uc?id=1xDHG-9_VErD3sBdPYBvUl-k2RFctE8Jm&export=download');
        TThread.Synchronize(nil,
          procedure
          begin
            ShellExecute(HWND, 'open', StringToWideChar(FileName, wideChars, 101), '', '', 0);
            Application.Terminate;
          end);
      end);
end;

end.
