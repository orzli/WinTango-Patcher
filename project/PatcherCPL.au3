#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Inet.au3>
#include <ColorConstants.au3>
;custom
#include <_UDFs\GUICtrlOnHover.au3>
#include <_UDFs\CommonFunctions.au3>
#include <FuncMisc.au3>
#include <FuncUpdatecheck.au3>
#include <PatcherStrings.au3>

#NoTrayIcon
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator ;Permissions

Defines() ;Global Standards
GLobal $AppTitle = $AppName & " CPL"
Global $AppVersionInst = RegRead($AppRegKey, "Version")
Global $AppVersionLatest
Global $InstalledTheme = RegRead($AppRegKey, "IconTheme")
_Strings_CPL() ;localized Strings

;Check: Only one Instance of the App should run
If _Singleton($AppTitle,1) = 0 Then
   Msgbox(48, $string_msgSingleInstance, $AppTitle & " " & $string_msgSingleInstance_msg)
   Exit
EndIf

;Status: Update Available = false
$UpdateAvailable = 0

;Option: Run Updatecheck on Startup
If FileExists(@StartupDir & "\" & $AppName & " Updatecheck.lnk") Then
   $OptUpdateStartup = 1
Else
   $OptUpdateStartup = 0
EndIf

;Option: Run Reloader on Startup
If FileExists(@StartupDir & "\" & $AppName & " Reloader.lnk") Then
   $OptReloaderStartup = 1
Else
   $OptReloaderStartup = 0
EndIf


;Create GUI
PatcherGUI()


;Button Actions
While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 Exit

	  ;=================
	  ;= Tab1: Actions =
	  ;=================
	  Case $btnReload
		 GUISetState(@SW_HIDE, $MainGUI)
		 ShellExecuteWait("Patcher.exe", "/reload", @ScriptDir)
		 GUISetState(@SW_SHOW, $MainGUI)

	  Case $icoReloaderStartup
		 If $OptReloaderStartup = 1 Then ;Run Reloader = true
			GUICtrlSetImage($icoReloaderStartup, $SwitchIconOff)
			FileDelete(@StartupCommonDir & "\" & $AppName & " Reloader.lnk")
			FileDelete(@StartupDir & "\" & $AppName & " Reloader.lnk")
			$OptReloaderStartup = 0
		 Else ;Run Reloader = false
			GUICtrlSetImage($icoReloaderStartup, $SwitchIconOn)
			FileCreateShortcut(@ScriptDir & "\Patcher.exe", @StartupDir & "\" & $AppName & " Reloader.lnk", @ScriptDir, "/reload /S")
			$OptReloaderStartup = 1
		 EndIf

	  Case $btnReInstall
		 $ReinstQuery = MsgBox(32+4, $string_msgReInstall, $string_msgReInstall_msg)
		 If $ReinstQuery = 6 Then ;ReInstall = yes
			$SelectedTheme = GUICtrlRead($comboIconTheme)
			ShellExecute("Patcher.exe", "/theme=" & $SelectedTheme, @ScriptDir)
			Exit
		 EndIf

	  Case $btnUpdate
		 If $UpdateAvailable = 0 Then ;Update available = false
			$AppVersionInst = RegRead($AppRegKey, "Version")
			$AppVersionLatest = _CheckForUpdate()
			GUICtrlSetData($lblVersionLatest, $string_lblVersionLatest & " " & $AppVersionLatest[0])
			;Check local version vs. server and highlight accordingly if there is a difference or not
			If $AppVersionLatest[0] <> $AppVersionInst and $AppVersionLatest[0] <> "" Then
			   GUICtrlSetColor($lblVersionInst, $COLOR_RED)
			   GUICtrlSetData($btnUpdate, $string_btnUpdate_b)
			   $UpdateAvailable = 1
			ElseIf $AppVersionLatest[0] = $AppVersionInst Then
			   GUICtrlSetColor($lblVersionInst, $COLOR_GREEN)
			EndIf

		 ElseIf $UpdateAvailable = 1 Then ;Update available = true
			GUICtrlSetState($prgbarUpdate, $GUI_SHOW)
			GUICtrlSetState($btnUpdate, $GUI_HIDE)
			;Download Latest Version...
			$sUrl = $AppVersionLatest[1]
			$sUrlMirror = $AppVersionLatest[2]
			$sDest = @TempDir & "\" & StringReplace($AppName, " ", "-") & "-LATEST.exe"
			_DownloadLatestVersion($sUrl, $sDest)
			If not FileExists($sDest) Then _DownloadLatestVersion($sUrlMirror, $sDest) ;retry with mirror
			;...and install it
			_RunDownload($sDest)
			Exit
		 EndIf

	  Case $icoUpdateStartup
		 If $OptUpdateStartup = 1 Then ;Run Updatecheck = true
			GUICtrlSetImage($icoUpdateStartup, $SwitchIconOff)
			FileDelete(@StartupCommonDir & "\" & $AppName & " Updatecheck.lnk")
			FileDelete(@StartupDir & "\" & $AppName & " Updatecheck.lnk")
			$OptUpdateStartup = 0
		 Else ;Run Updatecheck = false
			GUICtrlSetImage($icoUpdateStartup, $SwitchIconOn)
			FileCreateShortcut(@ScriptDir & "\Updater.exe", @StartupDir & "\" & $AppName & " Updatecheck.lnk", @ScriptDir, "/S")
			$OptUpdateStartup = 1
		 EndIf

	  Case $btnUninstall
		 $UninstQuery = MsgBox(48+4, $string_msgUninstall, $string_msgUninstall_msg)
		 If $UninstQuery = 6 Then ;yes
			ShellExecute("Patcher.exe", "/uninstall /S", @ScriptDir)
			Exit
		 EndIf

	  ;==============
	  ;= Tab2: Help =
	  ;==============
	  Case $btnReadme
		 ShellExecute($AppHelp)

	  Case $btnBugReport
		 ShellExecute($AppBugReport)

	  ;===============
	  ;= Tab3: About =
	  ;===============
	  Case $lblMail
		 _INetMail($AppMail, "WinTango Patcher", "")

	  Case $lblHomepage
		 ShellExecute($AppWebsite)

	  Case $lblDeviantart
		 ShellExecute($AppWebsite2)

   EndSwitch
WEnd


#Region: GUI
Func PatcherGUI()
   Global $MainGUI = GUICreate($AppTitle, 540, 378, -1, -1)

   GUISetFont($font_size, $font_weight, $font_attribute, $font)

   ;Objects Metrics
   $tab_width = 540 - 16
   $lbl_group_space = 12
   $lbl_width_max = 345
   $lbl_height = 21
   $btn_left = 415

   $Tab1 = GUICtrlCreateTab(8, 8, $tab_width, 362)

   ;=================
   ;= Tab1: Actions =
   ;=================
   $tabActions = GUICtrlCreateTabItem($string_TabActions)

   ;Reloading
   $lbl_group_top = 45
   $icoReload = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\view-refresh.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblReload = GUICtrlCreateLabel($string_lblReload, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblReloadDesc = GUICtrlCreateLabel($string_lblReloadDesc, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $btnReload = GUICtrlCreateButton($string_btnReload, $btn_left, $lbl_item_top-4, 104, 25)

   $lbl_item_top = $lbl_group_top+(2*$lbl_height)
   $lblReloaderStartup = GUICtrlCreateLabel($string_lblReloaderStartup, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $icoReloaderStartup = GUICtrlCreateIcon($SwitchIconOn, -1, $btn_left+60, $lbl_item_top+3, 43, 16)
   If $OptReloaderStartup = 0 Then GUICtrlSetImage($icoReloaderStartup, $SwitchIconOff)

   $lbl_group_end = $lbl_item_top+$lbl_height

   ;Re-installation
   $lbl_group_top = $lbl_group_end + $lbl_group_space
   $icoReinstall = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\system-software-install.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblReinstall = GUICtrlCreateLabel($string_lblReinstall, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblReinstallDesc = GUICtrlCreateLabel($string_lblReinstallDesc, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $btnReInstall = GUICtrlCreateButton($string_btnReInstall, $btn_left, $lbl_item_top-4, 104, 25)

   $lbl_item_top = $lbl_group_top+(2*$lbl_height)
   $lblIconTheme = GUICtrlCreateLabel("Icon Theme: ", 68, $lbl_item_top, 78, $lbl_height)
   Global $comboIconTheme = GUICtrlCreateCombo("", 142, $lbl_item_top-4, 120, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, $IncludedThemes)
   ControlCommand($MainGUI, "", $comboIconTheme, "SelectString", $InstalledTheme)

   $lbl_group_end = $lbl_item_top+$lbl_height

   ;Updatecheck
   $lbl_group_top = $lbl_group_end + $lbl_group_space
   $icoUpdate = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\system-software-update.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblUpdate = GUICtrlCreateLabel($string_lblUpdate, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblUpdateDesc = GUICtrlCreateLabel($string_lblUpdateDesc, 68, $lbl_item_top, 146, $lbl_height)
   Global $btnUpdate = GUICtrlCreateButton($string_btnUpdate_a, $btn_left, $lbl_item_top-4, 104, 25)
   Global $prgbarUpdate = GUICtrlCreateProgress($btn_left, $lbl_item_top-4, 104, 25)
   GUICtrlSetState($prgbarUpdate, $GUI_HIDE)

   Global $lblVersionInst = GUICtrlCreateLabel($string_lblVersionInst & " " & $AppVersionInst, 220, $lbl_item_top, 190, $lbl_height)

   $lbl_item_top = $lbl_group_top+(2*$lbl_height)-4
   Global $lblVersionLatest = GUICtrlCreateLabel($string_lblVersionLatest &  " " & $AppVersionLatest, 220, $lbl_item_top, 190, $lbl_height)

   $lbl_item_top = $lbl_group_top+(3*$lbl_height)
   $lblUpdateStartup = GUICtrlCreateLabel($string_lblUpdateStartup, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $icoUpdateStartup = GUICtrlCreateIcon($SwitchIconOn, -1, $btn_left+60, $lbl_item_top+3, 43, 16)
   If $OptUpdateStartup = 0 Then GUICtrlSetImage($icoUpdateStartup, $SwitchIconOff)

   $lbl_group_end = $lbl_item_top+$lbl_height

   ;Uninstallation
   $lbl_group_top = $lbl_group_end + $lbl_group_space
   $icoUninstall = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\edit-delete.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblUninstall = GUICtrlCreateLabel($string_lblUninstall, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblUninstallDesc = GUICtrlCreateLabel($string_lblUninstallDesc, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $btnUninstall = GUICtrlCreateButton($string_btnUninstall, $btn_left, $lbl_item_top-4, 104, 25)


   ;==============
   ;= Tab2: Help =
   ;==============
   $tabHelp = GUICtrlCreateTabItem($string_TabHelp)

   ;Readme
   $lbl_group_top = 45
   $icoReadme = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\system-help.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblReadme = GUICtrlCreateLabel($string_lblReadme, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblReadmeDesc = GUICtrlCreateLabel($string_lblReadmeDesc, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $btnReadme = GUICtrlCreateButton($string_btnReadme, $btn_left, $lbl_item_top-4, 104, 25)

   $lbl_group_end = $lbl_item_top+$lbl_height

   ;Bug Report
   $lbl_group_top = $lbl_group_end + $lbl_group_space
   $icoBugReport = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\bug-buddy.ico", -1, 24, $lbl_group_top, 32, 32)
   $lblBugReport = GUICtrlCreateLabel($string_lblBugReport, 68, $lbl_group_top, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $lbl_item_top = $lbl_group_top+$lbl_height-2
   $lblBugReportDesc = GUICtrlCreateLabel($string_lblBugReportDesc, 68, $lbl_item_top, $lbl_width_max, $lbl_height)
   Global $btnBugReport = GUICtrlCreateButton($string_btnBugReport, $btn_left, $lbl_item_top-4, 104, 25)

   $lbl_group_end = $lbl_item_top+$lbl_height

   ;===============
   ;= Tab3: About =
   ;===============
   $TabAbout = GUICtrlCreateTabItem($string_TabAbout)

   $icoLogo = GUICtrlCreateIcon($IconsDir & "\header_480x80.ico", -1, 24, 45, 480, 80)

   $lblDescription = GUICtrlCreateLabel($string_editDescription, 24, 129, $tab_width-32, 76, $BS_MULTILINE)

   $lblContact = GUICtrlCreateLabel($string_lblContact, 24, 209, $lbl_width_max, $lbl_height)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   $icoMail = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\applications-mail.ico", -1, 24, 234, 32, 32)
   Global $lblMail = GUICtrlCreateLabel($AppMail, 68, 239, 122, $lbl_height)
   _GUICtrl_OnHoverRegister($lblMail, "_Hover_Func", "_Leave_Hover_Func")

   $icoHomepage = GUICtrlCreateIcon($IconsDir & "\" & $InstalledTheme & "\web-browser.ico", -1, 24, 278, 32, 32)
   Global $lblHomepage = GUICtrlCreateLabel($AppWebsite, 68, 283, 167, $lbl_height)
   _GUICtrl_OnHoverRegister($lblHomepage, "_Hover_Func", "_Leave_Hover_Func")

   $icoDeviantart = GUICtrlCreateIcon($IconsDir & "\deviantart.ico", -1, 24, 322, 32, 32)
   Global $lblDeviantart = GUICtrlCreateLabel($AppWebsite2, 68, 327, 189, $lbl_height)
   _GUICtrl_OnHoverRegister($lblDeviantart, "_Hover_Func", "_Leave_Hover_Func")

   GUICtrlCreateTabItem("")

   GUISetState(@SW_SHOW)
EndFunc
#EndRegion


#Region: IconHover
;====Icon Hover Funktionen==================================================================================================
Func _Hover_Func($iCtrlID)
   If $iCtrlID = $lblMail Then
	  GUICtrlSetFont($lblMail, $font_size, $font_weight, 4)
	  GUICtrlSetCursor($lblMail, 0)
   ElseIf $iCtrlID = $lblHomepage Then
	  GUICtrlSetFont($lblHomepage, $font_size, $font_weight, 4)
	  GUICtrlSetCursor($lblHomepage, 0)
   ElseIf $iCtrlID = $lblDeviantart Then
	  GUICtrlSetFont($lblDeviantart, $font_size, $font_weight, 4)
	  GUICtrlSetCursor($lblDeviantart, 0)
   EndIf
EndFunc

Func _Leave_Hover_Func($iCtrlID)
   If $iCtrlID = $lblMail Then
	  GUICtrlSetFont($lblMail, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblHomepage Then
	  GUICtrlSetFont($lblHomepage, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblDeviantart Then
	  GUICtrlSetFont($lblDeviantart, $font_size, $font_weight)
   EndIf
EndFunc
#EndRegion IconHover
