program MouseMovier;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {MainForm},
  uLang in 'uLang.pas' {LangForm},
  uTranslate in 'uTranslate.pas',
  uAddEditForm in 'uAddEditForm.pas' {AddEditForm},
  uLoadFile in 'uLoadFile.pas',
  uAuthorization in 'uAuthorization.pas' {AuthorizationForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLangForm, LangForm);
  Application.CreateForm(TAddEditForm, AddEditForm);
  Application.CreateForm(TAuthorizationForm, AuthorizationForm);
  Application.Run;
end.
