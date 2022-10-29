;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "UMUI.nsh"

;--------------------------------
;UMUI Config

  !define UMUI_SKIN "blue++"
  !define UMUI_ULTRAMODERN_SMALL

  !define UMUI_VERSION "UMUI Beta 1"
  !define /date UMUI_VERBUILD "2.0_%Y-%m-%d"

  !define UMUI_VERSION_REGISTRY_VALUENAME "Version"
  !define UMUI_VERBUILD_REGISTRY_VALUENAME "VerBuild"

  !define UMUI_UNINSTALLPATH_REGISTRY_VALUENAME "uninstallpath"
  !define UMUI_INSTALLERFULLPATH_REGISTRY_VALUENAME "installpath"
  !define UMUI_UNINSTALL_FULLPATH "$INSTDIR\Uninstall.exe"

  !define UMUI_MAINTENANCEPAGE_MODIFY
  !define UMUI_MAINTENANCEPAGE_REPAIR
  !define UMUI_MAINTENANCEPAGE_REMOVE
  !define UMUI_MAINTENANCEPAGE_CONTINUE_SETUP
  !define UMUI_PREUNINSTALL_FUNCTION SemiUninst
  !define UMUI_PARAMS_REGISTRY_ROOT HKLM
  !define UMUI_PARAMS_REGISTRY_KEY "Software\Shrinkdows"
  !define UMUI_COMPONENTSPAGE_REGISTRY_VALUENAME "InstalledComponents"
  !define UMUI_INFORMATIONPAGE_USE_RICHTEXTFORMAT
  !define UMUI_USE_INSTALLOPTIONSEX

  !define UMUI_SETUPTYPEPAGE_STANDARD
  !define UMUI_SETUPTYPEPAGE_COMPLETE
  !define UMUI_SETUPTYPEPAGE_DEFAULTCHOICE ${UMUI_STANDARD}
  !define UMUI_SETUPTYPEPAGE_REGISTRY_VALUENAME "SetupType"

  !define UMUI_SETUPTYPEPAGE_STANDARD_TITLE "Sta${U+200B}ndard"
  !define UMUI_SETUPTYPEPAGE_COMPLETE_TITLE "Com${U+200B}plete"
  !define UMUI_SETUPTYPEPAGE_CUSTOM_TITLE "Cus${U+200B}tom"

  !insertmacro UMUI_DECLARECOMPONENTS_BEGIN
    !system 'python3 GenUMUISectionList.py>sect.nsi'
    !include 'sect.nsi'
    !system 'del /f /q sect.nsi'
  !insertmacro UMUI_DECLARECOMPONENTS_END

;--------------------------------
;General

  ;Name and file
  Name "Shrinkdows"
  OutFile "Shrinkdows.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$WINDIR\Shrinkdows\"
  
  ;Get installation folder from registry if available
  !define UMUI_INSTALLDIR_REGISTRY_VALUENAME "InstallDir"
  ;InstallDirRegKey HKLM "Software\Shrinkdows" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

  ShowInstDetails show
  ShowUninstDetails show

  ;BrandingText "© Tech Stuff and Just Joey"
  BrandingText " "

  !include "Sections.nsh"
  !include LogicLib.nsh

  Function .onInit
  UserInfo::GetAccountType
  pop $0
  ${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
  ${EndIf}
  FunctionEnd

;--------------------------------
;Interface Settings

;--------------------------------
;Pages

  !insertmacro UMUI_PAGE_MAINTENANCE
  !insertmacro UMUI_PAGE_UPDATE
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro UMUI_PAGE_INFORMATION "Info.rtf"
  !insertmacro UMUI_PAGE_SETUPTYPE
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro UMUI_PAGE_CONFIRM
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro UMUI_PAGE_ABORT
  
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
  !insertmacro UMUI_UNPAGE_ABORT
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Create Uninstaller" SecCreateUninstaller

  SectionIn RO
  
  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKLM "Software\Shrinkdows" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows" \
                 "DisplayName" "Shrinkdows"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows" \
                 "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows" \
                 "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows" \
                 "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows" \
                 "NoRepair" 1

SectionEnd

!system 'python3 GenInstall.py>sect.nsi'
!include 'sect.nsi'
!system 'del /f /q sect.nsi'

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecCreateUninstaller ${LANG_ENGLISH} "Create Uninstaller."
  !system 'python3 GenStrings1.py>sect.nsi'
  !include 'sect.nsi'
  !system 'del /f /q sect.nsi'

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecCreateUninstaller} $(DESC_SecCreateUninstaller)
    !system 'python3 GenStrings2.py>sect.nsi'
    !include 'sect.nsi'
    !system 'del /f /q sect.nsi'
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  !system 'python3 GenUninstall.py>sect.nsi'
  !include 'sect.nsi'
  !system 'del /f /q sect.nsi'

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey HKLM "Software\Shrinkdows"

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Shrinkdows"

SectionEnd

Function "SemiUninst"

  !system 'python3 GenUninstall.py>sect.nsi'
  !include 'sect.nsi'
  !system 'del /f /q sect.nsi'

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

FunctionEnd