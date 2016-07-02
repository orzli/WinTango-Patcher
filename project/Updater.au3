#Include <File.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
;custom
#include <_UDFs\CommonFunctions.au3>
#include <FuncMisc.au3>
#include <FuncUpdatecheck.au3>
#include <PatcherStrings.au3>

#NoTrayIcon
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator ;Permissions

Defines() ;Global Standards
Global $AppTitle = $AppName & " Updater"
Global $AppVersionInst = RegRead($AppRegKey, "Version")
Global $AppVersionLatest
_Strings_Updater() ;localized Strings

;Mode: Silent
Global $SilentInstall = 0
If not $CmdLine[0] = 0 Then
   If _StringInArray($CmdLine, '/S') Then $SilentInstall = 1
EndIf


;Create GUI
$MainGUI = GUICreate($AppTitle, 491, 163, -1, -1)
$icoLogo = GUICtrlCreateIcon($IconsDir & "\header_480x80.ico", -1, 5, 5, 480, 80)
$lblCurrent = GUICtrlCreateLabel("", 12, 88, 466, 17)
Global $prgbarUpdate = GUICtrlCreateProgress(12, 112, 466, 17)
$lblOverall = GUICtrlCreateLabel("", 12, 136, 466, 17, $SS_RIGHT)
If $SilentInstall = 0 Then GUISetState(@SW_SHOW)


;Actions
DirCreate($ToolsDir)
DirCreate(@ScriptDir & "\Themes")

GUICtrlSetData($lblCurrent,$string_msgChecking)
$AppVersionLatest = _CheckForUpdate()

If $AppVersionInst = $AppVersionLatest[0] Then
   GUICtrlSetData($lblOverall, $string_msgNoUpdate)
   If $SilentInstall = 0 Then Sleep(3000)
   Exit
EndIf

If $AppVersionInst <> $AppVersionLatest[0] Then
   $sDataChangelog = FileRead(@ScriptDir & "\Changelog.txt")

   $queryUpdate = MsgBox(4, $string_msgYesUpdate, $AppName & " " & $AppVersionLatest & " " & $string_msgYesUpdate_msg1 & @LF & @LF & $string_msgYesUpdate_msg2 & @LF & @LF & $sDataChangelog)
   If $queryUpdate = 6 Then
	  ;ja - weitermachen!
   Else
	  Exit
   EndIf
EndIf


;Download
GUICtrlSetData($lblCurrent, $string_msgDownloading)

$sUrl = $AppVersionLatest[1]
$sDest = @TempDir & "\" & StringReplace($AppName, " ", "-") & "-LATEST.exe"
_DownloadLatestVersion($sUrl, $sDest)

GUICtrlSetData($lblOverall, $string_msgDownloadDone)
Sleep(2000)


;Run Installer
_RunDownload($sDest)


Exit