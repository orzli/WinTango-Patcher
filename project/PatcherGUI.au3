Func PatcherGUI($Modus = "Patcher")
   Global $MainGUI = GUICreate($AppName, 562, 378, -1, -1)

   GUISetFont($font_size, $font_weight, $font_attribute, $font)

   Global $tab = GUICtrlCreateTab(8, 8, 545, 361)

   ;===============
   ;= Tab1: Patch =
   ;===============
   $tabPatch = GUICtrlCreateTabItem($Modus)

   $icoLogo = GUICtrlCreateIcon($IconsDir & "\header_480x80.ico", -1, 40, 41, 480, 80)

   $lblIconTheme = GUICtrlCreateLabel("Icon Theme:", 24, 136, 80, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   Global $comboIconTheme = GUICtrlCreateCombo("", 107, 131, 129, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, $IncludedThemes)
   ControlCommand($MainGUI, "", $comboIconTheme, "SelectString", $SelectedTheme)

   Global $icoPreview1 = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\video-display.ico", -1, 256, 127, 32, 32)
   Global $icoPreview2 = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\go-next.ico", -1, 296, 127, 32, 32)
   Global $icoPreview3 = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\drive-harddisk.ico", -1, 336, 127, 32, 32)
   Global $icoPreview4 = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\folder.ico", -1, 376, 127, 32, 32)

   Global $btnPatch = GUICtrlCreateButton("Patch!", 432, 131, 105, 25)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   Global $lstPatchStatus = GUICtrlCreateList("", 24, 178, 513, 195, $WS_VSCROLL)

   ;=================
   ;= Tab2: Options =
   ;=================
   $tabOption = GUICtrlCreateTabItem("Options")

   $lblTrayIcons = GUICtrlCreateLabel("Tray Icons", 24, 48, 71, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblTrayIcons_desc = GUICtrlCreateLabel("Patch Tray Icons with the following style:", 94, 48, 237, 21)
   Global $comboTrayIcons = GUICtrlCreateCombo("", 336, 45, 89, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "Colorfull|Symbolic")
   ;select the matching item
   If $SelectedTheme = "elementary" Then
	  ControlCommand($MainGUI, "", $comboTrayIcons, "SelectString", "Symbolic")
   Else
	  ControlCommand($MainGUI, "", $comboTrayIcons, "SelectString", "Colorfull")
   EndIf
   Global $switchTrayIcons = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 50, 43, 16)
   Global $OptTrayIcons = 1

   $lblStartOrb = GUICtrlCreateLabel("Start Orb", 24, 80, 64, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblStartOrb_desc = GUICtrlCreateLabel("Patch the button which opens the startmenu", 87, 80, 259, 21)
   Global $switchStartOrb = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 82, 43, 16)
   Global $OptStartOrb = 1

   $lblNotepad2 = GUICtrlCreateLabel("Notepad2", 24, 112, 68, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblNotepad2_desc = GUICtrlCreateLabel("Replace Microsoft Notepad with Notepad2 (EN/DE/CN)", 91, 112, 329, 21)
   Global $switchNotepad2 = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 114, 43, 16)
   Global $OptNotepad2 = 1

   $lblDesktops = GUICtrlCreateLabel("Sysinternals Desktops", 24, 144, 143, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblDesktops_desc = GUICtrlCreateLabel("Add the feature of multiple Desktops to Windows 7", 168, 144, 303, 21)
   Global $switchDesktops = GUICtrlCreateIcon($SwitchIconOff, -1, 490, 146, 43, 16)
   Global $OptDesktops = 0

   $lblUpdater = GUICtrlCreateLabel("Updatecheck", 24, 176, 86, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblUpdater_desc = GUICtrlCreateLabel("Automatically check for Updates on system startup", 111, 176, 299, 21)
   Global $switchUpdater = GUICtrlCreateIcon($SwitchIconOff, -1, 490, 178, 43, 16)
   Global $OptUpdater = 0

   $lblReloader = GUICtrlCreateLabel("Reload", 24, 208, 50, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblReloader_desc = GUICtrlCreateLabel("Automatically reload on startup for constant modding", 75, 208, 318, 21)
   Global $switchReloader = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 210, 43, 16)
   Global $OptReloader = 1

   $lblVisualStyle = GUICtrlCreateLabel("Visual Style", 24, 240, 80, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblVisualStyle_desc = GUICtrlCreateLabel("Select the desired Visual Style:", 103, 240, 180, 21)
   Global $comboVisualStyle = GUICtrlCreateCombo("", 286, 237, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "Shiki-Colors|elementary|Ubuntu")
   ;select the matching item
   If $SelectedTheme = "Humanity" or $SelectedTheme = "Tangerine" Then
	  ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "Ubuntu")
   ElseIf $SelectedTheme = "elementary" Then
	  ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "elementary")
   Else
	  ControlCommand($MainGUI, "", $comboVisualStyle, "SelectString", "Shiki-Colors")
   EndIf
   Global $switchVisualStyle = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 242, 43, 16)
   If $WinName = "Win10" Then ;disable for Windows 10; no theme included right now
	  Global $OptVisualStyle = 0
	  GUICtrlSetImage($switchVisualStyle, $SwitchIconOff)
	  GUICtrlSetState($comboVisualStyle, $GUI_DISABLE)
   Else
	  Global $OptVisualStyle = 1
   EndIf

   $lblCursors = GUICtrlCreateLabel("Cursors", 24, 272, 54, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblCursors_desc = GUICtrlCreateLabel("Install a matching Cursor Set:", 79, 272, 175, 21)
   Global $comboCursors = GUICtrlCreateCombo("", 254, 269, 105, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
   GUICtrlSetData(-1, "Ubuntu|elementary")
   Global $icoCursors_prev = GUICtrlCreateIcon($IconsDir & "\cursors-ubuntu.ico", -1, 368, 266, 96, 32)
   ;select the matching item
   If GUICtrlRead($comboVisualStyle) = "elementary" Then
	  ControlCommand($MainGUI, "", $comboCursors, "SelectString", "elementary")
	  GUICtrlSetImage($icoCursors_prev, $IconsDir & "\cursors-elementary.ico")
   Else
	  ControlCommand($MainGUI, "", $comboCursors, "SelectString", "Ubuntu")
   EndIf
   Global $switchCursors = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 274, 43, 16)
   Global $OptCursors = 1

   $lblWallpapers = GUICtrlCreateLabel("Wallpaper", 24, 304, 71, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $lblWallpapers_desc = GUICtrlCreateLabel("Copy matching wallpapers for the supported icon themes", 94, 304, 340, 21)
   Global $switchWallpapers = GUICtrlCreateIcon($SwitchIconOn, -1, 490, 306, 43, 16)
   Global $OptWallpapers = 1


   ;==========================
   ;= Tab3: Advanced Options =
   ;==========================
   Global $tabExpert = GUICtrlCreateTabItem("Advanced Options")

   FilesPage(540, 333, 10, 34) ;scrollable Child GUI

   GUIRegisterMsg($WM_SIZE, "WM_SIZE")
   GUIRegisterMsg($WM_VSCROLL, "WM_VSCROLL")
   GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")
   GUIRegisterMsg($WM_MOUSEWHEEL, "WM_MOUSEWHEEL")


   ;===============
   ;= Tab4: About =
   ;===============
   $TabAbout = GUICtrlCreateTabItem("About")

   $icoLogo2 = GUICtrlCreateIcon($IconsDir & "\header_480x80.ico", -1, 40, 41, 480, 80)

   $editDescription = GUICtrlCreateLabel("The WinTango Patcher is a mostly self-explanatory graphical wizard designed to make simple the process of modifying your system files with resources which were created by the Tango Desktop Project, the GNOME Project, the Gnome-Colors Project, the Elementary Project and many other open-source projects.", 24, 129, 480, 76, $BS_MULTILINE)

   $lblContact = GUICtrlCreateLabel("Contact", 24, 209, 51, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   Global $icoMail = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\applications-mail.ico", -1, 24, 234, 32, 32)
   Global $lblMail = GUICtrlCreateLabel($AppMail, 68, 239, 122, 21)
   _GUICtrl_OnHoverRegister($lblMail, "_Hover_Func", "_Leave_Hover_Func")

   Global $icoHomepage = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\web-browser.ico", -1, 24, 278, 32, 32)
   Global $lblHomepage = GUICtrlCreateLabel($AppWebsite, 68, 283, 167, 21)
   _GUICtrl_OnHoverRegister($lblHomepage, "_Hover_Func", "_Leave_Hover_Func")

   Global $icoDeviantart = GUICtrlCreateIcon($IconsDir & "\deviantart.ico", -1, 24, 322, 32, 32)
   Global $lblDeviantart = GUICtrlCreateLabel($AppWebsite2, 68, 327, 189, 21)
   _GUICtrl_OnHoverRegister($lblDeviantart, "_Hover_Func", "_Leave_Hover_Func")


   $lblInfo = GUICtrlCreateLabel("Information", 312, 209, 78, 21)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)

   Global $icoNotes = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\text-x-license.ico", -1, 312, 234, 32, 32)
   Global $lblNotes = GUICtrlCreateLabel("Release Notes", 356, 239, 88, 21)
   _GUICtrl_OnHoverRegister($lblNotes, "_Hover_Func", "_Leave_Hover_Func")

   Global $icoChangelog = GUICtrlCreateIcon($IconsDir & "\" & $SelectedTheme & "\text-x-changelog.ico", -1, 312, 278, 32, 32)
   Global $lblChangelog = GUICtrlCreateLabel("Changelog", 356, 283, 67, 21)
   _GUICtrl_OnHoverRegister($lblChangelog, "_Hover_Func", "_Leave_Hover_Func")

   GUICtrlCreateTabItem("")

   ;=========
   ;= Modus =
   ;=========

   ;Patcher normal
   If $Modus = "Patcher" and $SilentInstall = 0 Then
	  GUISetState(@SW_SHOW)
   EndIf

   ;Patcher quiet
   If $Modus = "Patcher" and $SilentInstall = 1 Then
	  GUISetState(@SW_SHOW)
	  Patch()
   EndIf


   ;Uninstaller
   If $Modus = "Uninstaller" Then
	  GUISetState(@SW_SHOW)
	  UnPatch()
   EndIf


   ;Reloader normal
   If $Modus = "Reloader" and $SilentInstall = 0 Then
	  GUISetState(@SW_SHOW)
	  Reload()
   EndIf

   ;Reloader silent
   If $Modus = "Reloader" and $SilentInstall = 1 Then
	  Reload()
   EndIf

EndFunc


#Region Advanced Options ChildGUI
Func FilesPage($ChildGUI_width, $ChildGUI_height, $ChildGUI_left, $ChildGUI_top)
   Global $FilesGUI

   $FilesGUI = GUICreate("Child GUI", $ChildGUI_width, $ChildGUI_height, $ChildGUI_left, $ChildGUI_top, $WS_POPUP, $WS_EX_MDICHILD, $MainGUI)
   GUISetBkColor($COLOR_WHITE, $FilesGUI)

   GUISetFont($font_size, $font_weight, $font_attribute, $font)

   GUISetState(@SW_HIDE)
   GUICtrlSetResizing($FilesGUI, $GUI_DOCKALL)

   _GUIScrollBars_Init($FilesGUI)
   ;_GUIScrollBars_SetScrollInfoMax($FilesGUI, $SB_VERT, 107) ;Vertikale Scrollhöhe
   _GUIScrollBars_ShowScrollBar($FilesGUI, $SB_HORZ, False) ;Horizontale Scrollbar ausblenden

   Global $width = $ChildGUI_width - 44
   Global $height = 12
   Global $left = 12
   Global $CheckBoxSum = 0
   Global $CheckBoxPuffer = 24

   _OptionsAppearance()
   _AppearanceApps()
   _AppFiles()
   _WinFiles()

   _GUIScrollBars_SetScrollInfoMax($FilesGUI, $SB_VERT, Round($CheckBoxSum*1.52,0)) ;Vertikale Scrollhöhe

   GUISwitch($MainGUI)
EndFunc

Func _OptionsAppearance()
   Global $CheckBoxStatusWinAll, $CheckBoxStatusWinAll_un
   Global $CheckBoxStatusWin7, $CheckBoxStatusWin7_un
   Global $CheckBoxStatusWin8, $CheckBoxStatusWin8_forced
   Global $CheckBoxStatusWin10

   $CheckBoxStatusWinAll = $GUI_CHECKED
   $CheckBoxStatusWinAll_un = $GUI_UNCHECKED

   If $WinName = "Win7" Then
	  $CheckBoxStatusWin7 = $GUI_CHECKED
	  $CheckBoxStatusWin7_un = $GUI_UNCHECKED

	  $CheckBoxStatusWin8 = $GUI_DISABLE
	  $CheckBoxStatusWin8_forced = $CheckBoxStatusWin7_un

	  $CheckBoxStatusWin10 = $GUI_DISABLE

   ElseIf $WinName = "Win8" Then
	  $CheckBoxStatusWin7 = $GUI_DISABLE
	  $CheckBoxStatusWin7_un = $GUI_DISABLE

	  $CheckBoxStatusWin8 = $GUI_CHECKED
	  $CheckBoxStatusWin8_forced = $GUI_CHECKED

	  $CheckBoxStatusWin10 = $GUI_DISABLE

   ElseIf $WinName = "Win10" Then
	  $CheckBoxStatusWin7 = $GUI_DISABLE
	  $CheckBoxStatusWin7_un = $GUI_DISABLE

	  $CheckBoxStatusWin8 = $GUI_DISABLE
	  $CheckBoxStatusWin8_forced = $GUI_CHECKED

	  $CheckBoxStatusWin10 = $GUI_CHECKED

   EndIf


   ;==============================================
   ;===== Risky ==================================
   ;==============================================
   $lblOptions = GUICtrlCreateLabel("Risky Files", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;==============================================

   $height = $height + $CheckBoxPuffer
   Global $chkNoShell32 = GUICtrlCreateCheckbox("Don't patch shell32.dll (Possible Sound Problems)", $left, $height, $width, 20)
   GUICtrlSetState(-1, $CheckBoxStatusWin7)
   $CheckBoxSum = $CheckBoxSum + 1


   $height = $height + $CheckBoxPuffer
   Global $chkUsingIE = GUICtrlCreateCheckbox("I want to be able to use Internet Explorer 10/11", $left, $height, $width, 20)
   If _IE_Version() > 9 Then
	  GUICtrlSetState(-1, $CheckBoxStatusWinAll)
   Else
	  GUICtrlSetState(-1, $CheckBoxStatusWinAll_un)
   EndIf
   $CheckBoxSum = $CheckBoxSum + 1


   ;==============================================
   ;===== UX Theme ===============================
   ;==============================================
   $height = $height + $CheckBoxPuffer + 10 ;Abstand letzte Checkbox zu neuer Überschrift
   $lblUxThemePatch = GUICtrlCreateLabel("UXTheme Patch", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;==============================================

   GUIStartGroup()

   ;Choose the right Option in order of compatibility (e.g. VirtualBox!) or already installed UXTheme Patchers
   If FileExists($UXPatchFile) or FileExists($UXServiceFile) Then ;already installed?
	  $CheckBoxStatusUXPatch = $CheckBoxStatusWinAll_un
	  $CheckBoxStatusUXService = $CheckBoxStatusWinAll_un
   ElseIf FileExists($ProgramFiles & "\Oracle\VirtualBox\VirtualBox.exe") or FileExists($ProgramFiles64 & "\Oracle\VirtualBox\VirtualBox.exe") Then ;VirtualBox installed?
	  $CheckBoxStatusUXPatch = $CheckBoxStatusWinAll_un
	  $CheckBoxStatusUXService = $CheckBoxStatusWinAll
   Else ;none of the above
	  $CheckBoxStatusUXPatch = $CheckBoxStatusWinAll
	  $CheckBoxStatusUXService = $CheckBoxStatusWinAll_un
   EndIf

   $height = $height + $CheckBoxPuffer
   Global $chkUniversalThemePatcher = GUICtrlCreateRadio("Direct Method: Patch files", $left, $height, $width-90, 20)
   GUICtrlSetState(-1, $CheckBoxStatusUXPatch)
   If FileExists($UXPatchFile) or FileExists($UXServiceFile) Then GUICtrlSetState(-1, $GUI_DISABLE)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer
   Global $chkUniversalThemeService = GUICtrlCreateRadio("Service Method: Installs a Service", $left, $height, $width-90, 20)
   GUICtrlSetState(-1, $CheckBoxStatusUXService)
   If FileExists($UXPatchFile) or FileExists($UXServiceFile) Then GUICtrlSetState(-1, $GUI_DISABLE)
   $CheckBoxSum = $CheckBoxSum + 1

   ;Disable UXThemePatch for Win10 as there is no theme yet
   If $WinName = "Win10" Then
	  GUICtrlSetState($chkUniversalThemePatcher, $GUI_UNCHECKED)
	  GUICtrlSetState($chkUniversalThemeService, $GUI_UNCHECKED)
	  GUICtrlSetState($chkUniversalThemePatcher, $GUI_DISABLE)
	  GUICtrlSetState($chkUniversalThemeService, $GUI_DISABLE)
   EndIf

EndFunc

Func _WinFiles()
   ;==============================================
   ;=====Systemfiles==============================
   ;==============================================
   $height = $height + $CheckBoxPuffer + 10 ;Abstand letzte Checkbox zu neuer Überschrift
   $lblSystemfiles = GUICtrlCreateLabel("Windows: System Files", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;==============================================

   $height = $height + $CheckBoxPuffer
   Global $chkBranding = GUICtrlCreateCheckbox("Branding Images/Icons", $left, $height, $width, 20)
   GUICtrlSetState($chkBranding, $CheckBoxStatusWin7)
   $CheckBoxSum = $CheckBoxSum + 1


   $IniFile = @ScriptDir & "\filesWindows.ini"

   $entrys = IniReadSectionNames($IniFile)

   For $i = 1 To $entrys[0]
	  $FilesList.add ($entrys[$i])
   Next

   $FilesList.sort

   Local $ControlID

   For $Entry In $FilesList
	  $WinSupport = IniRead($IniFile, $Entry, "Win", "All")

	  If $WinSupport = "All" or StringInStr($WinSupport, $WinName) > 0 Then
		 $CheckBoxStatus = $GUI_CHECKED

		 $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
		 $ControlID = GUICtrlCreateCheckbox($Entry, $left, $height, $width, 20)
		 GUICtrlSetState($ControlID, $CheckBoxStatus)
		 $CheckBoxSum = $CheckBoxSum + 1

		 $CheckboxesDict.add ($ControlID, $Entry)
	  Else
		 ;don't even show the option

		 ;for compatibility TESTING:
;~ 		 $CheckBoxStatus = $GUI_ENABLE
;~
;~ 		 $height = $height + 20 ;Abstand zwischen Checkboxen
;~ 		 $ControlID = GUICtrlCreateCheckbox($Entry, 12, $height, $width, 20)
;~ 		 GUICtrlSetState($ControlID, $CheckBoxStatus)
;~ 		 $CheckBoxSum = $CheckBoxSum + 1

;~ 		 $CheckboxesDict.add ($ControlID, $Entry)
	  EndIf
   Next
EndFunc

Func _AppearanceApps()
   ;==============================================
   ;=====3rd Party Programfiles===================
   ;==============================================
   $height = $height + $CheckBoxPuffer + 10 ;Abstand letzte Checkbox zu neuer Überschrift
   $lblApplicationsThemes = GUICtrlCreateLabel("3rd Party Applications", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;==============================================

   $height = $height + $CheckBoxPuffer
   Global $btnEditAppPaths = GUICtrlCreateButton("Edit Paths for 3rd Party Applications", $left, $height, $width, $CheckBoxPuffer)
   $CheckBoxSum = $CheckBoxSum + 1


   ;=========================================
   ;=====3rd Party Themes ===================
   ;=========================================
   $height = $height + $CheckBoxPuffer + 10 ;Abstand letzte Checkbox zu neuer Überschrift
   $lblApplicationsThemes = GUICtrlCreateLabel("3rd Party Applications: Themes", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;=========================================

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkAimpTheme = GUICtrlCreateCheckbox("Aimp Shiki-Colors Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkDiskInfoTheme = GUICtrlCreateCheckbox("CrystalDiskInfo Shiki-Colors Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkfoobar2000Theme = GUICtrlCreateCheckbox("foobar2000 Filetype-Icons", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkFreeFileSyncTheme = GUICtrlCreateCheckbox("FreeFileSync Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkGimpTheme = GUICtrlCreateCheckbox("Gimp Theme/Images", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkInkscapeTheme = GUICtrlCreateCheckbox("Inkscape Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkjDownloaderTheme = GUICtrlCreateCheckbox("jDownloader Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkLibreOfficeTheme = GUICtrlCreateCheckbox("LibreOffice Images", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkMPCTheme = GUICtrlCreateCheckbox("Media Player Classic HC Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkMSOfficeTheme = GUICtrlCreateCheckbox("Microsoft Office Filetype-Icons", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkFirefoxTheme = GUICtrlCreateCheckbox("Mozilla Firefox Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkThunderbirdTheme = GUICtrlCreateCheckbox("Mozilla Thunderbird Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkPidginTheme = GUICtrlCreateCheckbox("Pidgin Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkRadioSureTheme = GUICtrlCreateCheckbox("RadioSure Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkRainlendarTheme = GUICtrlCreateCheckbox("Rainlendar Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkSMPlayerTheme = GUICtrlCreateCheckbox("SMPlayer Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkUTorrentTheme = GUICtrlCreateCheckbox("uTorrent 2.x Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkVLCTheme = GUICtrlCreateCheckbox("VLC Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1

   $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
   Global $chkWinylTheme = GUICtrlCreateCheckbox("Winyl Theme", $left, $height, $width, 20)
   GUICtrlSetState(-1, $GUI_CHECKED)
   $CheckBoxSum = $CheckBoxSum + 1
EndFunc

Func _AppFiles()
   ;==============================================
   ;=====3rd Party Programfiles===================
   ;==============================================
   $height = $height + $CheckBoxPuffer + 10 ;Abstand letzte Checkbox zu neuer Überschrift
   $lblApplications = GUICtrlCreateLabel("3rd Party Applications: Files", $left, $height, $width, 20)
   GUICtrlSetFont(-1, $font_size, $font_weight_special, $font_attribute_special)
   $CheckBoxSum = $CheckBoxSum + 1
   ;==============================================

   $IniFile = @ScriptDir & "\filesApps.ini"

   $entrys = IniReadSectionNames($IniFile)

   For $i = 1 To $entrys[0]
	  $FilesListApps.add ($entrys[$i])
   Next

   $FilesListApps.sort

   Local $ControlID

   For $Entry In $FilesListApps
	  $WinSupport = IniRead($IniFile, $Entry, "Win", "All")

	  If $WinSupport = "All" or StringInStr($WinSupport, $WinName) > 0 Then
		 $CheckBoxStatus = $GUI_CHECKED

		 $height = $height + $CheckBoxPuffer ;Abstand zwischen Checkboxen
		 $ControlID = GUICtrlCreateCheckbox($Entry, $left, $height, $width, 20)
		 GUICtrlSetState($ControlID, $CheckBoxStatus)
		 $CheckBoxSum = $CheckBoxSum + 1

		 $CheckboxesDictApps.add ($ControlID, $Entry)
	  Else
		 ;don't even show the option
	  EndIf
   Next
EndFunc
#EndRegion


Func Switch_ChangeState($sCurrentState, $sControl)
   If $sCurrentState = 1 Then
	  GUICtrlSetImage($sControl, $SwitchIconOff)
	  $sNewState = 0
   Else
	  GUICtrlSetImage($sControl, $SwitchIconOn)
	  $sNewState = 1
   EndIf

   Return $sNewState
EndFunc


#Region IconHover
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
   ElseIf $iCtrlID = $lblNotes Then
	  GUICtrlSetFont($lblNotes, $font_size, $font_weight, 4)
	  GUICtrlSetCursor($lblNotes, 0)
   ElseIf $iCtrlID = $lblChangelog Then
	  GUICtrlSetFont($lblChangelog, $font_size, $font_weight, 4)
	  GUICtrlSetCursor($lblChangelog, 0)
   EndIf
EndFunc

Func _Leave_Hover_Func($iCtrlID)
   If $iCtrlID = $lblMail Then
	  GUICtrlSetFont($lblMail, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblHomepage Then
	  GUICtrlSetFont($lblHomepage, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblDeviantart Then
	  GUICtrlSetFont($lblDeviantart, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblNotes Then
	  GUICtrlSetFont($lblNotes, $font_size, $font_weight)
   ElseIf $iCtrlID = $lblChangelog Then
	  GUICtrlSetFont($lblChangelog, $font_size, $font_weight)
   EndIf
EndFunc
#EndRegion IconHover