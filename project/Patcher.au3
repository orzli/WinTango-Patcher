#include <Misc.au3>
#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <ListViewConstants.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <UpDownConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>
#include <File.au3>
#include <GuiListBox.au3>
#include <Inet.au3>
#include <ColorConstants.au3>
;custom
#include <_UDFs\GUICtrlOnHover.au3>
#include <_UDFs\CommonFunctions.au3>
#include <_UDFs\FuncInstUpdDeinst.au3>
#include <_UDFs\XML_Handling.au3>
#include <_UDFs\MoveFileEx.au3>
#include <FuncMisc.au3>
#include <JobsPatcher.au3>
#include <JobsUninstaller.au3>
#include <JobsReloader.au3>
#include <PatcherStrings.au3>
#include <PatcherGUI.au3>

#NoTrayIcon

#Region Initiating
;Permissions
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#RequireAdmin
DllCall("kernel32.dll", "int", "Wow64DisableWow64FsRedirection", "int", 1) ;Umleitung für x86-Programm abschalten
RegWrite("HKCU\AppEvents\Schemes\Apps\.Default\Close\.Current", "", "REG_EXPAND_SZ", "")
RegWrite("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager", "AllowProtectedRenames", "REG_DWORD", "0x00000001")


;Defines
Defines() ;Global Standards
$errorFlag = 0

;Define Windows Version for further usage & make sure that the Patcher only runs on supported Windows Versions
Global $WinName = _GetWinVer()
If $WinName = "Not supported" Then
   MsgBox(16, "Compatibility", "This version of " & $AppName & " does not support your Windows Version.")
   Exit
EndIf

;Icon Theme
Global $SelectedTheme = RegRead($AppRegKey, "IconTheme")
If $SelectedTheme = "" Then
   $SelectedTheme = "Tango"
ElseIf $SelectedTheme = "brave" Then  ;can be deleted after a few releases
   $SelectedTheme = "Gnome-Brave"
ElseIf $SelectedTheme = "human" Then  ;can be deleted after a few releases
   $SelectedTheme = "Gnome-Human"
ElseIf $SelectedTheme = "noble" Then  ;can be deleted after a few releases
   $SelectedTheme = "Gnome-Noble"
ElseIf $SelectedTheme = "wine" Then  ;can be deleted after a few releases
   $SelectedTheme = "Gnome-Wine"
ElseIf $SelectedTheme = "wise" Then  ;can be deleted after a few releases
   $SelectedTheme = "Gnome-Wise"
EndIf

;localized Strings
_Strings_Patcher()
_Strings_Reloader()
_Strings_Uninstaller()

;Check: Only one Instance of the App should run
If _Singleton($AppName,1) = 0 Then
   Msgbox(48, $string_msgSingleInstance, $AppName & " " & $string_msgSingleInstance_msg)
   Exit
EndIf

;COM-Error Handler
$oMyError = ObjEvent("AutoIt.Error","MyErrFunc") ;Initialize a COM error handler
Func MyErrFunc() ;This is my custom defined error handler
   $errorMsg = "We intercepted a COM Error!"    & @CRLF  & @CRLF & _
   "err.description is: " & @TAB & $oMyError.description  & @CRLF & _
   "err.windescription:"   & @TAB & $oMyError.windescription & @CRLF & _
   "err.number is: "       & @TAB & hex($oMyError.number,8)  & @CRLF & _
   "err.lastdllerror is: "   & @TAB & $oMyError.lastdllerror   & @CRLF & _
   "err.scriptline is: "   & @TAB & $oMyError.scriptline   & @CRLF & _
   "err.source is: "       & @TAB & $oMyError.source       & @CRLF & _
   "err.helpfile is: "       & @TAB & $oMyError.helpfile     & @CRLF & _
   "err.helpcontext is: " & @TAB & $oMyError.helpcontext

   Debug($errorMsg)

   Msgbox(0,$AppName & "Error Handler",$errorMsg)
Endfunc


;Objects
Global $FilesList = ObjCreate("System.Collections.ArrayList")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$FilesList''")
Global $CheckboxesDict = ObjCreate("Scripting.Dictionary")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$CheckboxesDict''")
Global $InstallFiles = ObjCreate("System.Collections.Queue")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$InstallFiles''")
Global $FilesListApps = ObjCreate("System.Collections.ArrayList")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$FilesListApps''")
Global $CheckboxesDictApps = ObjCreate("Scripting.Dictionary")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$CheckboxesDictApps''")
Global $InstallFilesApps = ObjCreate("System.Collections.Queue")
If @error=1 Then MsgBox(0,"Object Error","There was an error with creating the Object ''$InstallFilesApps''")


;PreInstall
_PreInstall()
_CleanupOld()


;Misc
Global $CurrentStatus = "idle"
Global $UpdatedFileCount = 1
#EndRegion


#Region Commandline Switches
;Modus
If $CmdLine[0] = 0 Then
   Global $Modus = "Patcher"
ElseIf _StringInArray($CmdLine, '/uninstall') Then
   Global $Modus = "Uninstaller"
ElseIf _StringInArray($CmdLine, '/reload') Then
   Global $Modus = "Reloader"
Else
   ;_Show_CMD_Reference()
   Global $Modus = "Patcher"
EndIf
If FileExists($Modus & ".log") Then FileDelete($Modus & ".log")


;Theme
If not $CmdLine[0] = 0 Then
   If _StringInArray($CmdLine, '/theme=gnome') Then $SelectedTheme = "gnome"
   If _StringInArray($CmdLine, '/theme=gnome-brave') Then $SelectedTheme = "gnome-brave"
   If _StringInArray($CmdLine, '/theme=gnome-human') Then $SelectedTheme = "gnome-human"
   If _StringInArray($CmdLine, '/theme=gnome-noble') Then $SelectedTheme = "gnome-noble"
   If _StringInArray($CmdLine, '/theme=gnome-wine') Then $SelectedTheme = "gnome-wine"
   If _StringInArray($CmdLine, '/theme=gnome-wise') Then $SelectedTheme = "gnome-wise"
   If _StringInArray($CmdLine, '/theme=cheser') Then $SelectedTheme = "cheser"
   If _StringInArray($CmdLine, '/theme=tango') Then $SelectedTheme = "tango"
   If _StringInArray($CmdLine, '/theme=tangerine') Then $SelectedTheme = "tangerine"
   If _StringInArray($CmdLine, '/theme=elementary') Then $SelectedTheme = "elementary"
   If _StringInArray($CmdLine, '/theme=humanity') Then $SelectedTheme = "humanity"
EndIf


;Silent
Global $SilentInstall = 0
If not $CmdLine[0] = 0 Then
   If _StringInArray($CmdLine, '/S') Then
	  $SilentInstall = 1
   EndIf
EndIf
#EndRegion


#Region Patcher Modus
If $Modus = "Uninstaller" Then
   If $SilentInstall = 0 Then
	  $UninstQuery = MsgBox(48+4, $string_msgUninstall, $string_msgUninstall_msg)
	  If $UninstQuery = 7 Then
		 Exit
	  EndIf
   EndIf
   PatcherGUI("Uninstaller")

ElseIf $Modus = "Reloader" Then
   Global $UpdatedFileCount = 0
   PatcherGUI("Reloader")

Else
   ;MainGUI
   PatcherGUI("Patcher")
EndIf
#EndRegion


While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 If $CurrentStatus = "busy" Then
			$CancelMsg = MsgBox(64, $string_msgExit, $string_msgNoExit_msg)
		 Else
			$CancelMsg = MsgBox(48+1, $string_msgExit, $string_msgExit_msg)
			If $CancelMsg = 1 Then ExitPatcher()
		 EndIf

	  ;Tab: Actions
	  Case $comboIconTheme
		 $SelectedTheme_old = $SelectedTheme
		 $SelectedTheme = GUICtrlRead($comboIconTheme)

		 ;Preview
		 If $SelectedTheme_old <> $SelectedTheme Then
			GUICtrlSetImage($icoPreview1, $IconsDir & "\" & $SelectedTheme & "\video-display.ico")
			GUICtrlSetImage($icoPreview2, $IconsDir & "\" & $SelectedTheme & "\go-next.ico")
			GUICtrlSetImage($icoPreview3, $IconsDir & "\" & $SelectedTheme & "\drive-harddisk.ico")
			GUICtrlSetImage($icoPreview4, $IconsDir & "\" & $SelectedTheme & "\folder.ico")

			GUICtrlSetImage($icoMail, $IconsDir & "\" & $SelectedTheme & "\applications-mail.ico")
			GUICtrlSetImage($icoHomepage, $IconsDir & "\" & $SelectedTheme & "\web-browser.ico")
			GUICtrlSetImage($icoNotes, $IconsDir & "\" & $SelectedTheme & "\text-x-license.ico")
			GUICtrlSetImage($icoChangelog, $IconsDir & "\" & $SelectedTheme & "\text-x-changelog.ico")

		 EndIf

		 ;Choose matching VS
		 If $SelectedTheme = "Humanity" or $SelectedTheme = "Tangerine" Then
			ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "Ubuntu")
		 ElseIf $SelectedTheme = "elementary" Then
			ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "elementary")
		 Else
			ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "Shiki-Colors")
		 EndIf

		 ;Choose matching Cursors
		 If GUICtrlRead($comboVisualStyle) = "elementary" Then
			ControlCommand($MainGUI, "", $comboCursors, "SelectString", "elementary")
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-elementary.ico")
		 Else
			ControlCommand($MainGUI, "", $comboCursors, "SelectString", "Ubuntu")
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-ubuntu.ico")
		 EndIf

		 ;Choose matching TrayIcons
		 If GUICtrlRead($comboVisualStyle) = "elementary" Then
			ControlCommand($MainGUI, "", $comboTrayIcons, "SelectString", "Symbolic")
		 Else
			ControlCommand($MainGUI, "", $comboTrayIcons, "SelectString", "Colorfull")
		 EndIf

	  Case $btnPatch
		 If $CurrentStatus = "idle" Then
			Patch() ;Action!
		 ElseIf $CurrentStatus = "done" Then
			If $UpdatedFileCount > 0 Then Shutdown(6) ;Neustarten erzwingen
			ExitPatcher()
		 ElseIf $CurrentStatus = "error" Then
			ShellExecute($AppBugReport)
			ShellExecute("Patcher.log")
			ExitPatcher()
		 EndIf


	  ;Tab: Options
	  Case $switchTrayIcons
		 $OptTrayIcons = Switch_ChangeState($OptTrayIcons, $switchTrayIcons)
		 If $OptTrayIcons = 0 Then
			GUICtrlSetState($comboTrayIcons, $GUI_DISABLE)
		 Else
			GUICtrlSetState($comboTrayIcons, $GUI_ENABLE)
		 EndIf

	  Case $switchStartOrb
		 $OptStartOrb = Switch_ChangeState($OptStartOrb, $switchStartOrb)

	  Case $switchNotepad2
		 $OptNotepad2 = Switch_ChangeState($OptNotepad2, $switchNotepad2)

	  Case $switchDesktops
		 $OptDesktops = Switch_ChangeState($OptDesktops, $switchDesktops)

	  Case $switchUpdater
		 $OptUpdater = Switch_ChangeState($OptUpdater, $switchUpdater)

	  Case $switchReloader
		 $OptReloader = Switch_ChangeState($OptReloader, $switchReloader)

	  Case $switchVisualStyle
		 If $WinName <> "Win10" Then ;dont let the user switch it on, when using Win10
			$OptVisualStyle = Switch_ChangeState($OptVisualStyle, $switchVisualStyle)
			If $OptVisualStyle = 0 Then
			   GUICtrlSetState($chkUniversalThemePatcher, $GUI_UNCHECKED)
			   GUICtrlSetState($chkUniversalThemeService, $GUI_UNCHECKED)
			   GUICtrlSetState($chkUniversalThemePatcher, $GUI_DISABLE)
			   GUICtrlSetState($chkUniversalThemeService, $GUI_DISABLE)
			   GUICtrlSetState($comboVisualStyle, $GUI_DISABLE)
			Else
			   GUICtrlSetState($chkUniversalThemePatcher, $CheckBoxStatusWinAll)
			   GUICtrlSetState($chkUniversalThemeService, $CheckBoxStatusWinAll_un)
			   GUICtrlSetState($chkUniversalThemePatcher, $GUI_ENABLE)
			   GUICtrlSetState($chkUniversalThemeService, $GUI_ENABLE)
			   GUICtrlSetState($comboVisualStyle, $GUI_ENABLE)
			EndIf
		 EndIf

	  Case $comboVisualStyle
		 If GUICtrlRead($comboVisualStyle) = "elementary" Then
			ControlCommand($MainGUI, "", $comboCursors, "SelectString", "elementary")
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-elementary.ico")
		 Else
			ControlCommand($MainGUI, "", $comboCursors, "SelectString", "Ubuntu")
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-ubuntu.ico")
		 EndIf

	  Case $switchCursors
		 $OptCursors = Switch_ChangeState($OptCursors, $switchCursors)
		 If $OptCursors = 0 Then
			GUICtrlSetState($comboCursors, $GUI_DISABLE)
		 Else
			GUICtrlSetState($comboCursors, $GUI_ENABLE)
		 EndIf

	  Case $comboCursors
		 If GUICtrlRead($comboCursors) = "elementary" Then
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-elementary.ico")
		 Else
			GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-ubuntu.ico")
		 EndIf

	  Case $switchWallpapers
		 $OptWallpapers = Switch_ChangeState($OptWallpapers, $switchWallpapers)


	  ;Tab: Advanced Options
	  Case $tab
		 ; Check which Tab is active
		 $iCurrTab = GUICtrlRead($tab)
		 ; If the Tab has changed
		 If $iCurrTab = 2 Then
			GUISetState(@SW_SHOW, $FilesGUI)
		 Else
			GUISetState(@SW_HIDE, $FilesGUI)
		 EndIf

	  Case $btnEditAppPaths
		 ShellExecuteWait("filesApps.ini")


	  ;Tab: About
	  Case $lblMail
		 _INetMail($AppMail, "WinTango Patcher", "")

	  Case $lblHomepage
		 ShellExecute($AppWebsite)

	  Case $lblDeviantart
		 ShellExecute($AppWebsite2)

	  Case $lblNotes
		 ShellExecute("Release Notes.txt")

	  Case $lblChangelog
		 ShellExecute("Changelog.txt")

   EndSwitch
WEnd




#Region: Patcher Routines
Func _PreInstall()
   DirCreate(@ScriptDir & "\Themes")
   DirCreate($ToolsDir)
   DirCreate($BackupDir)
   DirCreate($LogsDir)
   DirCreate($NewFilesDir)
   DirCreate($OverrideDir)
   If $OsArch = "x64" Then
	  DirCreate($BackupDir64)
	  DirCreate($LogsDir64)
	  DirCreate($NewFilesDir64)
	  DirCreate($OverrideDir64)
   EndIf
EndFunc

Func _CleanupOld()
   ;since v16.01.07
   FileDelete(@ScriptDir & "\images.dll")
   FileDelete(@ScriptDir & "\Readme.pdf")
   FileDelete($ToolsDir & "\OpaqueTaskbar*.*")
   FileDelete($ToolsDir & "\UXThemePatchers.txt")
   FileDelete($ToolsDir & "\UltraUXThemePatcher_*.exe")
   FileDelete($ToolsDir & "\UXTheme_Multi-Patcher_*.exe")
   ;since v16.12.24
   FileDelete(@ScriptDir & "\Themes\files-desktops-*.7z")
   FileDelete(@ScriptDir & "\Themes\files-notepad2-*.7z")
   FileDelete(@ScriptDir & "\Themes\images-*.7z")
   FileDelete(@ScriptDir & "\Themes\theme-*.7z")
   FileDelete(@ScriptDir & "\Themes\icons-*.7z")
   FileDelete(@ScriptDir & "\Themes\bitmaps-*.7z")

EndFunc

Func Patch()
   GUICtrlSetState($tab, $GUI_DISABLE)
   GUICtrlSetState($comboIconTheme, $GUI_DISABLE)
   GUICtrlSetState($btnPatch, $GUI_DISABLE)
   $CurrentStatus = "busy"

   ;Now that the user started patching, delete old files to prevent left over files / clear update registry
   DirRemove($ResourcesDir, 1)
   RegWrite($AppRegKey, "UpdatedPaks", "REG_SZ", "none")
   ;LOGs
   DirRemove($LogsDir, 1)
   DirCreate($LogsDir)
   If $OsArch = "x64" Then DirCreate($LogsDir64)

   ;Download all the needed resources
   Debug("=== Extract Basics Start ===")
   ExtractResources()
   Local $iSize = DirGetSize($ResourcesDir)
   Debug("Resources DirSize: " & Round($iSize / 1024 / 1024) & " MB")
   ;Error-Check
   If $iSize = -1 or $iSize = 0 Then
	  InstallMsg("Error: Resources Dir empty or not existing!")
	  $errorFlag = 1
   EndIf
   ;Error-Check End
   Debug("=== Extract Basics End ===")

   ;The patching magic:
   If $errorFlag = 0 Then
	  Debug("=== ApplyOptions Start ===")
	  If $OptTrayIcons = 1 Then
		 If GUICtrlRead($comboTrayIcons) = "Symbolic" Then Apply_SymbolicTray()
	  Else
		 Apply_NoTray()
	  EndIf

	  If $OptStartOrb = 0 Then Apply_NoStartOrb()

	  If $OptVisualStyle = 1 Then ApplyTheme_VisualStyle(GUICtrlRead($comboVisualStyle))
	  If $OptWallpapers = 1 Then ApplyTheme_Wallpapers()
	  If $OptCursors = 1 Then ApplyTheme_Cursors(GUICtrlRead($comboCursors))

	  If $OptNotepad2 = 1 Then Apply_Notepad2()
	  If $OptDesktops = 1 Then Apply_Desktops()

	  If $OptUpdater = 1 Then Apply_UpdaterStartup()
	  If $OptReloader = 1 Then Apply_ReloaderStartup()
	  Debug("=== ApplyOptions End ===")

	  Debug("=== ApplyAdvancedOptions Start ===")
	  If GUICtrlRead($chkNoShell32) = 1 Then
		 Global $NotPatchShell32 = 1 ;Don't patch shell32.dll
	  Else
		 Global $NotPatchShell32 = 0
	  EndIf

	  If GUICtrlRead($chkUsingIE) = 1 Then
		 Global $keepIEusable = 1 ;Internet Explorer Usability
	  Else
		 Global $keepIEusable = 0
	  EndIf

	  If GUICtrlRead($chkUniversalThemePatcher) = 1 Then ApplyTheme_UXThemePatch("direct")
	  If GUICtrlRead($chkUniversalThemeService) = 1 Then ApplyTheme_UXThemePatch("service")
	  Debug("=== ApplyAdvancedOptions Start ===")

	  Debug("=== PatchWindowsFiles Start ===")
	  If GUICtrlRead($chkBranding) = 1 Then ApplyTheme_Branding()
	  PatchWindowsFiles()
	  Debug("=== PatchWindowsFiles End ===")

	  Debug("=== ApplyAppearanceApps Start ===")
	  If GUICtrlRead($chkAimpTheme) = 1 Then ApplyTheme_Aimp() ;Aimp Shiki-Colors Theme
	  If GUICtrlRead($chkDiskInfoTheme) = 1 Then ApplyTheme_DiskInfo() ;CrystalDiskInfo Shiki-Colors Theme
	  If GUICtrlRead($chkfoobar2000Theme) = 1 Then ApplyTheme_Foobar2000() ;foobar2000 File Type Icons
	  If GUICtrlRead($chkFreeFileSyncTheme) = 1 Then ApplyTheme_FreeFileSync() ;FreeFileSync Theme
	  If GUICtrlRead($chkGimpTheme) = 1 Then ApplyTheme_Gimp() ;Gimp Theme/Images
	  If GUICtrlRead($chkInkscapeTheme) = 1 Then ApplyTheme_Inkscape() ;Inkscape Theme
	  If GUICtrlRead($chkjDownloaderTheme) = 1 Then ApplyTheme_jDownloader() ;jDownloader Theme
	  If GUICtrlRead($chkLibreOfficeTheme) = 1 Then ApplyTheme_LibreOffice() ;LibreOffice Images
	  If GUICtrlRead($chkMPCTheme) = 1 Then ApplyTheme_MPC() ;Media Player Classic HC Theme
	  If GUICtrlRead($chkMSOfficeTheme) = 1 Then  ApplyTheme_MSOffice() ;Microsoft Office
	  If GUICtrlRead($chkFirefoxTheme) = 1 Then ApplyTheme_Firefox() ;Mozilla Firefox Theme
	  If GUICtrlRead($chkThunderbirdTheme) = 1 Then ApplyTheme_Thunderbird() ;Mozilla Thunderbird Theme
	  If GUICtrlRead($chkPidginTheme) = 1 Then ApplyTheme_Pidgin() ;Pidgin Theme
	  If GUICtrlRead($chkRadioSureTheme) = 1 Then ApplyTheme_RadioSure() ;RadioSure Theme
	  If GUICtrlRead($chkRainlendarTheme) = 1 Then ApplyTheme_Rainlendar() ;Rainlendar Theme
	  If GUICtrlRead($chkSMPlayerTheme) = 1 Then ApplyTheme_SMPlayer() ;SMPlayer Theme
	  If GUICtrlRead($chkUTorrentTheme) = 1 Then ApplyTheme_uTorrent() ;uTorrent 2.x Theme
	  If GUICtrlRead($chkVLCTheme) = 1 Then ApplyTheme_VLC() ;VLC Theme
	  If GUICtrlRead($chkWinylTheme) = 1 Then ApplyTheme_Winyl() ;Winyl Theme
	  Debug("=== ApplyAppearanceApps End ===")

	  Debug("=== PatchAppFiles Start ===")
	  PatchAppFiles()
	  Debug("=== PatchAppFiles End ===")

	  InstallMsg("Clearing Icon-/Thumbnail-Cache...")
	  ClearIconCache()
	  InstallMsg("done")

	  PostInstall()
   EndIf

   GUICtrlSetData($lstPatchStatus, @LF)

   If $errorFlag = 0 Then
	  InstallMsg($string_msgPatchingDone) ;Patching completed.
	  InstallMsg($string_msgPatchingDoneRestart) ;In order to apply these changes you have to restart your system!
	  GUICtrlSetData($btnPatch, $string_btnRestart)
	  $CurrentStatus = "done"
   Else
	  InstallMsg("The Patcher ended with an error!")
	  InstallMsg("Please report this Bug to me by clicking the button above!")
	  GUICtrlSetData($btnPatch, "Bugreport")
	  GUICtrlSetColor($btnPatch, "0xff0000")
	  $CurrentStatus = "error"
   EndIf

   GuiCtrlSetState($btnPatch, $GUI_ENABLE)
   GuiCtrlSetState($btnPatch, $GUI_FOCUS)
EndFunc
#EndRegion


#Region: Uninstaller Routines
Func UnPatch()
   GUICtrlSetState($tab, $GUI_DISABLE)
   GUICtrlSetState($comboIconTheme, $GUI_DISABLE)
   GUICtrlSetState($btnPatch, $GUI_DISABLE)
   $CurrentStatus = "busy"

   ;The uninstalling magic:
   UnAppearance()
   UnFiles($IniFileWin)
   UnFiles($IniFileApps)

   InstallMsg("Clearing Icon-/Thumbnail-Cache...")
   ClearIconCache()
   InstallMsg("done")

   ;Messages
   InstallMsg($string_msgUninstalling)
   PostUnInstall()
   InstallMsg("done")

   GUICtrlSetData($lstPatchStatus, @LF)
   InstallMsg($string_msgUninstallingDone)
   InstallMsg($string_msgUninstallingDoneRestart)

   GUICtrlSetData($btnPatch, $string_btnRestart)
   GuiCtrlSetState($btnPatch, $GUI_ENABLE)
   GuiCtrlSetState($btnPatch, $GUI_FOCUS)

   $CurrentStatus = "done"
EndFunc
#EndRegion


#Region: Reloader Routines
Func Reload()
   GUICtrlSetState($tab, $GUI_DISABLE)
   GUICtrlSetState($comboIconTheme, $GUI_DISABLE)
   GUICtrlSetState($btnPatch, $GUI_DISABLE)
   $CurrentStatus = "busy"

   ;The reloading magic:
   ReAppearance()
   ReFiles($IniFileWin)
   ReFiles($IniFileApps)

   ;Messages
   If $SilentInstall = 0 Then
	  If $UpdatedFileCount > 0 Then
		 ;bei neuen dateien
		 InstallMsg("Clearing Icon-/Thumbnail-Cache...")
		 ClearIconCache()
		 InstallMsg("done")

		 GUICtrlSetData($lstPatchStatus, @LF)
		 InstallMsg($UpdatedFileCount & " " & $string_msgReloaderDone)
		 InstallMsg($string_msgReloaderDone2)
		 InstallMsg($string_msgReloaderDoneRestart)

		 GUICtrlSetData($btnPatch, $string_btnRestart)
		 GuiCtrlSetState($btnPatch, $GUI_ENABLE)
		 GuiCtrlSetState($btnPatch, $GUI_FOCUS)
	  Else
		 ;keine veränderungen
		 GUICtrlSetData($lstPatchStatus, @LF)
		 InstallMsg($string_msgReloaderNone)

		 GUICtrlSetData($btnPatch, $string_btnClose)
		 GuiCtrlSetState($btnPatch, $GUI_ENABLE)
		 GuiCtrlSetState($btnPatch, $GUI_FOCUS)
	  EndIf
   EndIf

   PostReload()
   $CurrentStatus = "done"

   If $SilentInstall = 1 Then
	  ;Silent - show MsgBox only if modified files were found
	  If $UpdatedFileCount > 0 Then
		 ClearIconCache()
		 $RestartQuery = MsgBox(36, $AppName & " Reloader", $UpdatedFileCount & " " & $string_msgReloaderSilent)
		 If $RestartQuery = 6 Then
			Shutdown(6) ;Neustarten erzwingen
			Exit
		 Else
			Exit
		 EndIf
	  Else
		 Exit
	  EndIf
   EndIf
EndFunc
#EndRegion


Func ExitPatcher()
   DirRemove($NewFilesDir, 1)
   ;If $modus = "Uninstaller" and $CurrentStatus = "done" then _SelfDelete(2)
   Exit
EndFunc