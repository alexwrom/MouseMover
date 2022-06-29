program MouseMover;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {MainForm},
  uLang in 'uLang.pas' {LangForm},
  uTranslate in 'uTranslate.pas',
  uAddEditForm in 'uAddEditForm.pas' {AddEditForm},
  uLoadFile in 'uLoadFile.pas',
  uAuthorization in 'uAuthorization.pas' {AuthorizationForm},
  uContact in 'uContact.pas' {ContactForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAuthorizationForm, AuthorizationForm);
  Application.CreateForm(TLangForm, LangForm);
  Application.CreateForm(TAddEditForm, AddEditForm);
  Application.CreateForm(TContactForm, ContactForm);
  Application.Run;
end.
