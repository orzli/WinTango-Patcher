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
$AppTitle = $AppName & " Updater"
$AppVersionInst = RegRead($AppRegKey, "Version")
$AppVersionLatest = ""
_Strings_Updater() ;localized Strings



;Create GUI
$MainGUI = GUICreate($AppTitle, 491, 163, -1, -1)
$icoLogo = GUICtrlCreateIcon($IconsDir & "\header_480x80.ico", -1, 5, 5, 480, 80)
$lblCurrent = GUICtrlCreateLabel("", 12, 88, 466, 17)
Global $prgbarUpdate = GUICtrlCreateProgress(12, 112, 466, 17)
$lblOverall = GUICtrlCreateLabel("", 12, 136, 466, 17, $SS_RIGHT)
GUISetState(@SW_SHOW)


;Download
GUICtrlSetData($lblCurrent, $string_msgDownloading)


$sUrl = "http://www73.zippyshare.com/d/swSe3xxr/2685622/WinTango-Patcher-16.12.24-offline.exe"
$sDest = @TempDir & "\" & StringReplace($AppName, " ", "-") & "-LATEST.exe"
_DownloadLatestVersion($sUrl, $sDest)

GUICtrlSetData($lblOverall, $string_msgDownloadDone)
