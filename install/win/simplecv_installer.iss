; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "SimpleCV Superpack"
#define MyAppVersion "1.1"
#define MyAppPublisher "Ingenuitas Inc. "
#define MyAppURL "http://www.simplecv.org"
#define MyAppExeName "Shell.py"
#define Ingenuitas "Ingenuitas"
#define IngenuitasURL "http://www.ingenuitas.com"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A7CA7116-FAFE-4247-91AE-50D81C9FA6B1}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=C:\SimpleCV\installer
SetupIconFile=C:\SimpleCV\installer\simplecv.ico
OutputBaseFilename=SimpleCV-Superpack-1.1
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
#include <C:\SimpleCV\installer\it_download.iss>;

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";


[Files]
Source: "C:\SimpleCV\InstallSource\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Code]
procedure InitializeWizard();
begin
 itd_init;

 //Let's download two zipfiles from my website..
 itd_addfile('http://pygame.org/ftp/pygame-1.9.2a0.win32-py2.7.msi',expandconstant('{tmp}\pygame.msi'))
 
 itd_addfile('http://downloads.sourceforge.net/project/scipy/scipy/0.9.0/scipy-0.9.0-win32-superpack-python2.7.exe',expandconstant('{tmp}\sci-py.exe'))
 itd_addfile('http://www.python.org/ftp/python/2.7.2/python-2.7.2.msi',expandconstant('{tmp}\python27.msi'));

 itd_addfile('http://downloads.sourceforge.net/project/opencvlibrary/opencv-win/2.2/OpenCV-2.2.0-win32-vs2010.exe',expandconstant('{tmp}\opencv.exe'));
 itd_addfile('http://downloads.sourceforge.net/project/numpy/NumPy/1.6.1rc1/numpy-1.6.1rc1-win32-superpack-python2.7.exe',expandconstant('{tmp}\numpy.exe'))

 itd_addfile('http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11.win32-py2.7.exe',expandconstant('{tmp}\ezinstall.exe'))
 itd_addfile('http://ipython.scipy.org/dist/0.10.2/ipython-0.10.2.win32-setup.exe',expandconstant('{tmp}\ipython.exe')) 
 //Start the download after the "Ready to install" screen is shown
 itd_downloadafter(wpReady);
end;
var
  ResultCode: Integer;
  pythonCmd: String;
  pythonSrc: String;
procedure CurStepChanged(CurStep: TSetupStep);
begin

 
 if CurStep=ssInstall then begin //Lets install those files that were downloaded for us
  pythonCmd := '/i /quiet '
  pythonSrc := ExpandConstant('{tmp}\python27.msi')
  Insert(pythonSrc,pythonCmd,3);
  Exec('msiexec.exe', pythonCmd, '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
  
  pythonCmd := '/i /quiet '
  pythonSrc := ExpandConstant('{tmp}\pygame.msi')
  Insert(pythonSrc,pythonCmd,3);
  Exec('msiexec.exe', pythonCmd, '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
    
  Exec(ExpandConstant('{tmp}\ezinstall.exe'), '', '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{tmp}\numpy.exe'), '', '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{tmp}\sci-py.exe'), '', '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{tmp}\ipython.exe'), '', '', SW_SHOW,ewWaitUntilTerminated, ResultCode);
  Exec(ExpandConstant('{tmp}\openCV.exe'), '', '', SW_SHOW,ewWaitUntilTerminated, ResultCode);  
  end;
 if CurStep=ssPostInstall then begin
  Exec(ExpandConstant('{app}\setup.bat'),'','',SW_SHOW,ewWaitUntilTerminated, ResultCode);
 end

end;

[Icons]
Name: "{commondesktop}\SimpleCV Shell"; Filename: "C:\Python27\python.exe"; WorkingDir: ""; Parameters: " -m SimpleCV.__init__"; IconFilename: "{app}\simplecv.ico"; Tasks: desktopicon
Name: "{group}\SimpleCV Shell"; Filename: "C:\Python27\python.exe"; WorkingDir: ""; Parameters: " -m SimpleCV.__init__"; IconFilename: "{app}\simplecv.ico";
Name: "{group}\Examples"; Filename: "C:\Program Files\SimpleCV Superpack\simplecv-git\SimpleCV\examples"; WorkingDir: ""; IconFilename: "{app}\simplecv.ico";
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:ProgramOnTheWeb,{#Ingenuitas}}"; Filename: "{#IngenuitasURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"



[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, "&", "&&")}}"; Flags: shellexec postinstall skipifsilent

[Setup]
AlwaysRestart = yes 

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};C:/Python27/;C:/Python27/Scripts/;C:/OpenCV2.2/bin/;"
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: expandsz; ValueName: "PythonPath"; ValueData: "{olddata};C:/OpenCV2.2/Python2.7/Lib/site-packages;"