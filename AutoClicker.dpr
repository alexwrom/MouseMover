program AutoClicker;

uses
  System.StartUpCopy,
  FMX.Forms,
  uLang in 'uLang.pas' {LangForm},
  uTranslate in 'uTranslate.pas',
  uAddEditForm in 'uAddEditForm.pas' {AddEditForm},
  uLoadFile in 'uLoadFile.pas',
  uAuthorization in 'uAuthorization.pas' {AuthorizationForm},
  uContact in 'uContact.pas' {ContactForm},
  uUpdate in 'uUpdate.pas' {UpdateForm},
  uTranscriptions in 'uTranscriptions.pas',
  uMain in 'uMain.pas' {MainForm},
  uStartSettingLang in 'uStartSettingLang.pas' {FormStartLang},
  uFrameSettLang in 'uFrameSettLang.pas' {FrameSettLang: TFrame},
  uFrameSettName in 'uFrameSettName.pas' {FrameSettName: TFrame},
  uStartSettingName in 'uStartSettingName.pas' {FormStartName},
  uStartSettingSubtitle in 'uStartSettingSubtitle.pas' {FormStartSubtitle},
  uFormPlay in 'uFormPlay.pas' {FormPlay},
  uUtils in 'uUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAuthorizationForm, AuthorizationForm);
  Application.CreateForm(TLangForm, LangForm);
  Application.CreateForm(TAddEditForm, AddEditForm);
  Application.CreateForm(TContactForm, ContactForm);
  Application.CreateForm(TUpdateForm, UpdateForm);
  Application.CreateForm(TFormStartLang, FormStartLang);
  Application.CreateForm(TFormStartName, FormStartName);
  Application.CreateForm(TFormStartSubtitle, FormStartSubtitle);
  Application.CreateForm(TFormPlay, FormPlay);
  Application.Run;
end.
