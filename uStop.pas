unit uStop;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions, FMX.ActnList, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TStopForm = class(TForm)
    btnStart: TSpeedButton;
    Image1: TImage;
    ActionList: TActionList;
    ActionStop: TAction;
    Label1: TLabel;
    Label2: TLabel;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StopForm: TStopForm;

implementation

{$R *.fmx}

procedure TStopForm.Image1Click(Sender: TObject);
begin
  ActionStop.Execute;
end;

end.
