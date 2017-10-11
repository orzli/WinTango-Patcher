Func ExtractResources()
   #Region: Scripts
   $sResName = "ResHacker Scripts"
   $sResFileLocal = @ScriptDir & '\Themes\scripts.7z'

   ;Extract resources
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Override Feature
   If FileExists(@DesktopDir & "\Override\scripts") Then DirCopy(@DesktopDir & "\Override\scripts", $ResourcesDir & "\scripts", 1)
   #EndRegion


   #Region: Resources
   $sResName = "Resources"

   $sResFileLocal = @ScriptDir & '\Themes\res-gnome.7z' ;base for all
   $sResFileLocal2 = ""
   $sResFileLocal3 = ""
   $sResFileLocal4 = ""

   If $SelectedTheme = "gnome" Then
	  ;use the above

   ElseIf $SelectedTheme = "cheser" or $SelectedTheme = "gnome-brave" or $SelectedTheme = "elementary" Then
	  $sResFileLocal4 = @ScriptDir & '\Themes\res-' & $SelectedTheme & '.7z'

   Else
	  ;2nd base images
	  $parent_theme = ""
	  $parent_theme2 = ""

	  If $SelectedTheme = "tango" Then
		 $parent_theme = "gnome-brave"

	  ElseIf $SelectedTheme = "tangerine" Then
		 $parent_theme = "gnome-brave"
		 $parent_theme2 = "tango"

	  ElseIf $SelectedTheme = "humanity" Then
		 $parent_theme = "elementary"

	  ElseIf $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
		 $parent_theme = "gnome-brave"

	  EndIf

	  $sResFileLocal2 = @ScriptDir & '\Themes\res-' & $parent_theme & '.7z'
	  $sResFileLocal3 = @ScriptDir & '\Themes\res-' & $parent_theme2 & '.7z'
	  $sResFileLocal4 = @ScriptDir & '\Themes\res-' & $SelectedTheme & '.7z' ;specific images

   EndIf

   ;Extract resources
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   ExtractArchive($sResFileLocal2, $ResourcesDir)
   ExtractArchive($sResFileLocal3, $ResourcesDir)
   If $SelectedTheme <> "gnome" Then ExtractResCleanup()
   ExtractArchive($sResFileLocal4, $ResourcesDir)
   InstallMsg("done")

   ;Override Feature
   If FileExists(@DesktopDir & "\Override\icons") Then DirCopy(@DesktopDir & "\Override\icons", $ResourcesDir & "\icons", 1)
   If FileExists(@DesktopDir & "\Override\bitmaps") Then DirCopy(@DesktopDir & "\Override\bitmaps", $ResourcesDir & "\bitmaps", 1)
   If FileExists(@DesktopDir & "\Override\shiki") Then DirCopy(@DesktopDir & "\Override\shiki", $ResourcesDir & "\shiki", 1)
   #EndRegion
EndFunc

Func ExtractResCleanup() ;cleanup Themes from other icon themes; at the moment a manual attempt...
   DirRemove($ResourcesDir & "\themes\Aimp", 1)
   FileDelete($ResourcesDir & "\themes\Firefox\*.xpi")
   DirRemove($ResourcesDir & "\themes\jDownloader", 1)
   DirRemove($ResourcesDir & "\themes\RadioSure\skins", 1)
   DirRemove($ResourcesDir & "\themes\SMPlayer", 1)
   FileDelete($ResourcesDir & "\themes\Thunderbird\*.xpi")
   DirRemove($ResourcesDir & "\themes\Winyl", 1)
EndFunc


#Region Options
Func Apply_OS_Res()
   ;Copy some OS specific ressources

   If $WinName = "Win7" Then
	  ;SnippingTool
	  FileCopy($ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\Win7\130.bmp", $ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\130.bmp", 1)
	  FileCopy($ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\Win7\131.bmp", $ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\131.bmp", 1)
	  FileCopy($ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\Win7\134.bmp", $ResourcesDir & "\bitmaps\tweaked\SnippingTool.exe\134.bmp", 1)
   EndIf
EndFunc

;General Options
Func Apply_NoTray()
   ;Don't patch Tray Icons
   InstallMsg("Applying: Don't patch Tray Icons")

   FileCopy($ResourcesDir & "\Scripts\options\notray_SndVolSSO.dll.txt", $ResourcesDir & "\Scripts\SndVolSSO.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\notray_taskbarcpl.dll.txt", $ResourcesDir & "\Scripts\taskbarcpl.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\notray_pnidui.dll.txt", $ResourcesDir & "\Scripts\pnidui.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\notray_ActionCenter.dll.txt", $ResourcesDir & "\Scripts\ActionCenter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\notray_batmeter.dll.txt", $ResourcesDir & "\Scripts\batmeter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\notray_dropbox.exe.txt", $ResourcesDir & "\Scripts\dropbox.exe.txt", 1)

   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_SndVolSSO.dll.txt", $ResourcesDir & "\Scripts\x64\SndVolSSO.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_taskbarcpl.dll.txt", $ResourcesDir & "\Scripts\x64\taskbarcpl.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_pnidui.dll.txt", $ResourcesDir & "\Scripts\x64\pnidui.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_ActionCenter.dll.txt", $ResourcesDir & "\Scripts\x64\ActionCenter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_batmeter.dll.txt", $ResourcesDir & "\Scripts\x64\batmeter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\notray_dropbox.exe.txt", $ResourcesDir & "\Scripts\dropbox.exe.txt", 1)

   InstallMsg("done")
EndFunc

Func Apply_SymbolicTray()
   ;Use symbolic tray icons
   InstallMsg("Applying: Use symbolic Tray Icons")

   FileCopy($ResourcesDir & "\Scripts\options\symbolic_SndVolSSO.dll.txt", $ResourcesDir & "\Scripts\SndVolSSO.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\symbolic_taskbarcpl.dll.txt", $ResourcesDir & "\Scripts\taskbarcpl.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\symbolic_pnidui.dll.txt", $ResourcesDir & "\Scripts\pnidui.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\symbolic_ActionCenter.dll.txt", $ResourcesDir & "\Scripts\ActionCenter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\symbolic_batmeter.dll.txt", $ResourcesDir & "\Scripts\batmeter.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\options\symbolic_dropbox.exe.txt", $ResourcesDir & "\Scripts\dropbox.exe.txt", 1)

   FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_SndVolSSO.dll.txt", $ResourcesDir & "\Scripts\x64\SndVolSSO.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_taskbarcpl.dll.txt", $ResourcesDir & "\Scripts\x64\taskbarcpl.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_pnidui.dll.txt", $ResourcesDir & "\Scripts\x64\pnidui.dll.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_ActionCenter.dll.txt", $ResourcesDir & "\Scripts\x64\ActionCenter.dll.txt", 1)
   ;FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_batmeter.dll.txt", $ResourcesDir & "\Scripts\x64\batmeter.dll.txt", 1) ;no x64 needed!
   FileCopy($ResourcesDir & "\Scripts\x64\options\symbolic_dropbox.exe.txt", $ResourcesDir & "\Scripts\x64\dropbox.exe.txt", 1)

   InstallMsg("done")
EndFunc

Func Apply_NoStartOrb()
   ;Don't patch Start Orb
   InstallMsg("Applying: Don't patch Start Orb")

   FileCopy($ResourcesDir & "\Scripts\options\noorb_explorer.exe.txt", $ResourcesDir & "\Scripts\explorer.exe.txt", 1)
   FileCopy($ResourcesDir & "\Scripts\x64\options\noorb_explorer.exe.txt", $ResourcesDir & "\Scripts\x64\explorer.exe.txt", 1)

   InstallMsg("done")
EndFunc

Func Apply_Notepad2()
   ;Replace MS Notepad with Notepad2
   $sResName = "Notepad2"
   $sResFileLocal = @ScriptDir & '\Themes\files-' & $SelectedTheme & '.7z'

   ;Extract
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Patch
   InstallMsg("Replacing: Microsoft Notepad with " & $sResName)

   If $OsArch = "x86" Then
	  DirCreate(@DesktopDir & "\Override")
	  FileCopy($ResourcesDir & "\files\notepad2-" & _GetOSLanguage() & ".exe", @DesktopDir & "\Override\notepad.exe", 1)
   Else
	  DirCreate(@DesktopDir & "\Override\x64")
	  FileCopy($ResourcesDir & "\files\notepad2-" & _GetOSLanguage() & "-x64.exe", @DesktopDir & "\Override\notepad.exe", 1)
	  FileCopy($ResourcesDir & "\files\notepad2-" & _GetOSLanguage() & ".exe", @DesktopDir & "\Override\x64\notepad.exe", 1)
   EndIf

   FileWrite(@UserProfileDir & "\AppData\Roaming\notepad2.ini", "[Notepad2]")

   InstallMsg("done")
EndFunc

Func Apply_Desktops()
   ;Install Sysinternals Desktops
   $sResName = "Sysinternals Desktops"
   $sResFileLocal = @ScriptDir & '\Themes\files-' & $SelectedTheme & '.7z'

   ;Extract
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Install
   InstallMsg("Installing: " & $sResName)

   FileCopy($ResourcesDir & "\files\desktops.exe", @WindowsDir & "\desktops.exe", 1)
   RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Sysinternals Desktops", "REG_SZ", @WindowsDir & "\desktops.exe") ;Add to Autostart

   InstallMsg("done")
EndFunc

Func Apply_UpdaterStartup()
   ;Automatically Check for Updates
   InstallMsg("Applying: Automatically Check for Updates on Startup")

   FileDelete(@StartupCommonDir & "\" & $AppName & " Updatecheck.lnk")
   FileCreateShortcut(@ScriptDir & "\Updater.exe", @StartupDir & "\" & $AppName & " Updatecheck.lnk", @ScriptDir, "/S")

   InstallMsg("done")
EndFunc

Func Apply_ReloaderStartup()
   ;Automatically Reload on Boot
   InstallMsg("Applying: Automatically Reload on Startup")

   FileDelete(@StartupCommonDir & "\" & $AppName & " Reloader.lnk")
   FileCreateShortcut(@ScriptDir & "\Patcher.exe", @StartupDir & "\" & $AppName & " Reloader.lnk", @ScriptDir, "/reload /S")

   InstallMsg("done")
EndFunc

;Windows: Theme
Func ApplyTheme_UXThemePatch($sMethod)
   ;Apply UXThemePatch
   If $sMethod = "direct" Then
	  ;Install
	  InstallMsg("Applying: UXTheme Patch (Direct Method)")
	  RunWait($ToolsDir & "\UltraUXThemePatcher.exe /S")
	  RegWrite($AppRegKey, "UxThemePatch", "REG_SZ", "1")
	  InstallMsg("done")
   Else
	  ;Install
	  InstallMsg("Applying: UXTheme Patch (Service Method")
	  RunWait($ToolsDir & "\UXTheme_Multi-Patcher.exe")
	  RegWrite($AppRegKey, "UxThemePatch", "REG_SZ", "1")
	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_Wallpapers()
   ;Matching Wallpapers for the VS
   $sResName = "Wallpapers"
   $sResFileLocal = @ScriptDir & '\Themes\wallpapers.7z'

   ;Extract
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Install
   InstallMsg("Installing: " & $sResName)
   ;FileCopy($ResourcesDir & "\themes\Windows\Wallpapers\*.png", @WindowsDir & "\Web\Wallpaper", 1)
   ;FileCopy($ResourcesDir & "\themes\Windows\Wallpapers\*.jpg", @WindowsDir & "\Web\Wallpaper", 1)
   DirCopy($ResourcesDir & "\themes\Windows\Wallpapers", @WindowsDir & "\Web\Wallpaper", 1)
   InstallMsg("done")
EndFunc

Func ApplyTheme_Cursors($Cursor_Style)
   ;Ubuntu Classic Cursors
   $sResName = $Cursor_Style & " Cursors"
   $sResFileLocal = @ScriptDir & '\Themes\cursors-' & $Cursor_Style & '.7z'

   ;Extract
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Install
   InstallMsg("Installing: " & $sResName)

   DirCreate(@WindowsDir & "\Cursors\" & $Cursor_Style)
   FileCopy($ResourcesDir & "\themes\Windows\Cursors\*.cur", @WindowsDir & "\Cursors\" & $Cursor_Style, 9)
   FileCopy($ResourcesDir & "\themes\Windows\Cursors\*.ani", @WindowsDir & "\Cursors\" & $Cursor_Style, 9)

   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Arrow", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\normal.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Help", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\help.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "AppStarting", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\working.ani")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Wait", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\busy.ani")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Crosshair", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\precision.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "IBeam", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\text.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "NWPen", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\handwriting.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "No", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\unavailable.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNS", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\vertical_resize.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeWE", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\horizontal_resize.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNWSE", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\diagonal_resize_1.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNESW", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\diagonal_resize_2.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeAll", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\move.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "UpArrow", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\alternate.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Hand", "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\link.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors\Schemes", $Cursor_Style, "REG_SZ", @WindowsDir & "\Cursors\" & $Cursor_Style & "\normal.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\help.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\working.ani," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\busy.ani," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\precision.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\text.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\handwriting.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\unavailable.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\vertical_resize.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\horizontal_resize.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\diagonal_resize_1.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\diagonal_resize_2.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\move.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\alternate.cur," & @WindowsDir & "\Cursors\" & $Cursor_Style & "\link.cur")

   InstallMsg("done")
EndFunc

Func ApplyTheme_VisualStyle($VS_Name)
   ;VisualStyle
   $sResName = "Visual Style for Windows"

   ;Definitions
   If $VS_Name = "elementary" Then
	  $sResFileLocal = @ScriptDir & '\Themes\visualstyle-elementary.7z'

	  $VS_FileName = "elementary"

   ElseIf $VS_Name = "Ubuntu" Then
	  $sResFileLocal = @ScriptDir & '\Themes\visualstyle-ubuntu.7z'

	  $VS_FileName = "Ubuntu"

   ElseIf $VS_Name = "Shiki-Colors" Then
	  $sResFileLocal = @ScriptDir & '\Themes\visualstyle-shikicolors.7z'

	  If $SelectedTheme = "gnome" Then
		 $VS_FileName = "Shiki-Colors Dust"
	  ElseIf $SelectedTheme = "cheser" or $SelectedTheme = "tango" or $SelectedTheme = "elementary" Then
		 $VS_FileName = "Shiki-Colors Brave"
	  ElseIf $SelectedTheme = "tangerine" or $SelectedTheme = "humanity" Then
		 $VS_FileName = "Shiki-Colors Human"
	  Else
		 $VS_FileName = "Shiki-Colors " & $SelectedTheme
	  EndIf
   EndIf

   ;Extract
   InstallMsg("Extracting: " & $sResName)
   ExtractArchive($sResFileLocal, $ResourcesDir)
   InstallMsg("done")

   ;Install
   InstallVisualStyle($VS_Name, $VS_FileName)


;~    InstallMsg("Installing: " & $sResName)

;~    FileDelete(@WindowsDir & "\Resources\Themes\" & $VS_Name)
;~    DirRemove(@WindowsDir & "\Resources\Themes\" & $VS_Name, 1)

;~    DirCreate(@WindowsDir & "\Resources\Themes\" & $VS_Name & "\Shell\NormalColor\en-US")
;~    FileCopy($ResourcesDir & "\themes\Windows\" & $WinName & "\*.theme", @WindowsDir & "\Resources\Themes", 9)
;~    FileCopy($ResourcesDir & "\themes\Windows\" & $WinName & "\*.msstyles", @WindowsDir & "\Resources\Themes\" & $VS_Name, 9)
;~    FileCopy($ResourcesDir & "\themes\Windows\" & $WinName & "\shellstyle.dll", @WindowsDir & "\Resources\Themes\" & $VS_Name & "\Shell\NormalColor", 9)
;~    FileCopy($ResourcesDir & "\themes\Windows\" & $WinName & "\shellstyle.dll.mui", @WindowsDir & "\Resources\Themes\" & $VS_Name & "\Shell\NormalColor\en-US", 9)
;~    ;Fonts
;~    If $VS_Name = "elementary" Then InstallFont($ResourcesDir & "\themes\Windows\Fonts\*.ttf")


   ;Apply theme; only if uxtheme is patched
   If RegRead($AppRegKey, "UxThemePatch") = "1" and FileExists(@WindowsDir & "\Resources\Themes\" & $VS_FileName & ".theme") Then
	  ShellExecuteWait(@WindowsDir & "\Resources\Themes\" & $VS_FileName & ".theme")
	  sleep(4000)
	  send("!{f4}")
   ElseIf FileExists(@WindowsDir & "\Resources\Themes\" & $VS_FileName & ".theme") Then
	  FileCreateShortcut(@WindowsDir & "\Resources\Themes\" & $VS_FileName & ".theme", @DesktopCommonDir & "\Apply " & $VS_Name & " Theme.lnk")
   EndIf

   InstallMsg("done")
EndFunc

Func ApplyTheme_Branding()
   ;Check the EditionID for the right branding
   $EditionID = RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "EditionID")

   If $EditionID = "Ultimate" Then
	  FileCopy($ResourcesDir & "\bitmaps\basebrd.dll\ultimate\*.bmp", $ResourcesDir & "\bitmaps\basebrd.dll", 1)
   ElseIf $EditionID = "Professional" Then
	  FileCopy($ResourcesDir & "\bitmaps\basebrd.dll\professional\*.bmp", $ResourcesDir & "\bitmaps\basebrd.dll", 1)
   ElseIf $EditionID = "HomePremium" Then
	  FileCopy($ResourcesDir & "\bitmaps\basebrd.dll\homepremium\*.bmp", $ResourcesDir & "\bitmaps\basebrd.dll", 1)
   ElseIf $EditionID = "HomeBasic" Then
	  FileCopy($ResourcesDir & "\bitmaps\basebrd.dll\homebasic\*.bmp", $ResourcesDir & "\bitmaps\basebrd.dll", 1)
   ElseIf $EditionID = "Starter" Then
	  FileCopy($ResourcesDir & "\bitmaps\basebrd.dll\starter\*.bmp", $ResourcesDir & "\bitmaps\basebrd.dll", 1)
   EndIf

   InstallFile("basebrd.dll", @WindowsDir & "\Branding\Basebrd") ;Windows Edition Banners
   InstallFile("shellbrd.dll", @WindowsDir & "\Branding\ShellBrd") ;First Steps (CPL) + Windows Flags
EndFunc
#EndRegion


#Region System Files
;Windows: System Files
Func PatchWindowsFiles()
   ;=====Systemfiles====================
   For $ChBox In $CheckboxesDict.Keys ()
	  If BitAND(GUICtrlRead($ChBox), 1) Then
		 $FileName = $CheckboxesDict ($ChBox)
		 $InstallFiles.enqueue ($FileName)
	  EndIf
   Next

   $IniFile = $IniFileWin

   If $InstallFiles.count > 0 Then
	  Do
		 $EntrysNumber = IniRead($IniFile, $InstallFiles.Peek, "Entrys", "1")

		 For $j = 1 To $EntrysNumber

			$File = IniRead($IniFile, $InstallFiles.Peek, "File_" & $j, "")
			$PathIni = IniRead($IniFile, $InstallFiles.Peek, "Path_" & $j, "")

			If not StringInStr($PathIni, "WindowsDir") = 0 Then
			   $Path = StringReplace($PathIni, "WindowsDir", @WindowsDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataLocal") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataLocal", EnvGet("LOCALAPPDATA"))
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataRoaming") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataRoaming", @AppDataDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "SystemDir") = 0 Then
			   $Path = StringReplace($PathIni, "SystemDir", @WindowsDir & "\System32")
			   $Path64 = StringReplace($PathIni, "SystemDir", @WindowsDir & "\SysWOW64")
			ElseIf not StringInStr($PathIni, "ProgramFilesDir") = 0 Then
			   $Path = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles)
			   $Path64 = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles64)
			Else
			   $Path = $PathIni
			   $Path64 = ""
			EndIf

			If $Path <> "" and $File <> "" Then
			   ;Specials for IE 10+ Users who won't be able to use it properly if these files get patched:
			   If $keepIEusable = 1 and $File = "ExplorerFrame.dll" Then
				  InstallMsg("Skipping File: " & $Path & "\" & $File & " for IE compatibility")
				  UninstallFile($File, $Path)
			   ElseIf $keepIEusable = 1 and $File = "inetcpl.cpl" Then
				  InstallMsg("Skipping File: " & $Path & "\" & $File & " for IE compatibility")
				  UninstallFile($File, $Path)
			   ElseIf $NotPatchShell32 = 1 or $keepIEusable = 1 and $File = "shell32.dll" Then
				  InstallMsg("Skipping File: " & $Path & "\" & $File & " for IE/Sound compatibility")
				  UninstallFile($File, $Path)
			   Else ;normal mode:
				  InstallFile($File, $Path)
			   EndIf
			EndIf

			If $Path64 <> "" and $File <> "" Then
			   ;Specials for IE 10+ Users who won't be able to use it properly if these files get patched:
			   If $keepIEusable = 1 and $File = "ExplorerFrame.dll" Then
				  InstallMsg("Skipping File: " & $Path64 & "\" & $File & " for IE compatibility")
				  UninstallFile64($File, $Path64)
			   ElseIf $keepIEusable = 1 and $File = "inetcpl.cpl" Then
				  InstallMsg("Skipping File: " & $Path64 & "\" & $File & " for IE compatibility")
				  UninstallFile64($File, $Path64)
			   ElseIf $NotPatchShell32 = 1 or $keepIEusable = 1 and $File = "shell32.dll" Then
				  InstallMsg("Skipping File: " & $Path64 & "\" & $File & " for IE/Sound compatibility")
				  UninstallFile64($File, $Path64)
			   Else ;normal mode:
				  InstallFile64($File, $Path64)
			   EndIf
			EndIf

		 Next

		 $InstallFiles.dequeue

	  Until Not $InstallFiles.count
   EndIf


   ;UnPatch all files not compatible with the used Windows Version if they somehow got patched
   $IniFile = @ScriptDir & "\filesWindows.ini"
   $entrys = IniReadSectionNames($IniFile)

   For $i = 1 to $entrys[0]
	  $WinSupport = IniRead($IniFile, $entrys[$i], "Win", "")

	  If $WinSupport <> "All" and StringInStr($WinSupport, $WinName) = 0 Then

		 $EntrysNumber = IniRead($IniFile, $entrys[$i], "Entrys", "1")

		 For $j = 1 To $EntrysNumber

			$File = IniRead($IniFile, $entrys[$i], "File_" & $j, "")
			$PathIni = IniRead($IniFile, $entrys[$i], "Path_" & $j, "")

			If not StringInStr($PathIni, "WindowsDir") = 0 Then
			   $Path = StringReplace($PathIni, "WindowsDir", @WindowsDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataLocal") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataLocal", EnvGet("LOCALAPPDATA"))
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataRoaming") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataRoaming", @AppDataDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "SystemDir") = 0 Then
			   $Path = StringReplace($PathIni, "SystemDir", @WindowsDir & "\System32")
			   $Path64 = StringReplace($PathIni, "SystemDir", @WindowsDir & "\SysWOW64")
			ElseIf not StringInStr($PathIni, "ProgramFilesDir") = 0 Then
			   $Path = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles)
			   $Path64 = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles64)
			Else
			   $Path = $PathIni
			   $Path64 = ""
			EndIf

			If $Path <> "" and $File <> "" Then UninstallFile($File, $Path)
			If $Path64 <> "" and $File <> "" Then UninstallFile64($File, $Path64)

		 Next

	  EndIf
   Next
EndFunc
#EndRegion


#Region 3rd Party Apps
;3rd Party Apps: Themes
Func ApplyTheme_Aimp()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\AIMP3\AIMP3.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: Aimp")

	  CheckAndCloseProcess("AIMP3.exe", "AIMP")

	  FileCopy($ResourcesDir & "\themes\Aimp\*.acs3", $ProgramFiles & "\AIMP3\Skins", 1)

	  ;activate Theme
	  If $SelectedTheme = "gnome-brave" or $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
		 $theme_Aimp = "Shiki-" & StringReplace($SelectedTheme, "gnome-", "") & ".acs3"
	  ElseIf $SelectedTheme = "elementary" Then
		 $theme_Aimp = $SelectedTheme & ".acs3"
	  Else
		 $theme_Aimp = "Shiki-" & $SelectedTheme & ".acs3"
	  EndIf
	  IniWrite(@AppDataDir & "\AIMP3\AIMP3.ini", "Skins", "Skin", $theme_Aimp)

	  InstallMsg("done")

   ElseIf FileExists($ProgramFiles & "\AIMP\AIMP.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: Aimp")

	  CheckAndCloseProcess("AIMP.exe", "AIMP")

	  FileCopy($ResourcesDir & "\themes\Aimp\*.acs3", $ProgramFiles & "\AIMP\Skins", 1)

	  ;activate Theme
	  If $SelectedTheme = "gnome-brave" or $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
		 $theme_Aimp = "Shiki-" & StringReplace($SelectedTheme, "gnome-", "") & ".acs3"
	  ElseIf $SelectedTheme = "elementary" Then
		 $theme_Aimp = $SelectedTheme & ".acs3"
	  Else
		 $theme_Aimp = "Shiki-" & $SelectedTheme & ".acs3"
	  EndIf
	  IniWrite(@AppDataDir & "\AIMP\AIMP.ini", "Skins", "Skin", $theme_Aimp)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_jDownloader()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\jDownloader\jDownloader.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: jDownloader")

	  CheckAndCloseProcess("jdownloader.exe", "jDownloader")

	  DirCopy($ResourcesDir & "\themes\jDownloader", $ProgramFiles & "\jDownloader\jd", 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_FreeFileSync()
   If FileExists($ProgramFiles & "\FreeFileSync\FreeFileSync.exe") or FileExists($ProgramFiles64 & "\FreeFileSync\FreeFileSync.exe") Then
	  ;Install
	  CheckAndCloseProcess("FreeFileSync.exe", "FreeFileSync")

	  InstallTheme("FreeFileSync", $ProgramFiles & "\FreeFileSync\FreeFileSync.exe", $ProgramFiles & "\FreeFileSync", "Resources.zip", $ResourcesDir & "\themes\FreeFileSync\Resources.zip")
	  InstallTheme("FreeFileSync", $ProgramFiles64 & "\FreeFileSync\FreeFileSync.exe", $ProgramFiles64 & "\FreeFileSync", "Resources.zip", $ResourcesDir & "\themes\FreeFileSync\Resources.zip")
   EndIf
EndFunc

Func ApplyTheme_Firefox()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\Mozilla Firefox\firefox.exe") or FileExists($ProgramFiles64 & "\Mozilla Firefox\firefox.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: Mozilla Firefox")

	  CheckAndCloseProcess("firefox.exe", "Mozilla Firefox")

	  $FirefoxAppPath = @AppDataDir & "\Mozilla\Firefox\" & StringReplace(IniRead(@AppDataDir & "\Mozilla\Firefox\profiles.ini", "Profile0", "Path", "Error"), "/", "\")
	  DirCreate($FirefoxAppPath & "\extensions")
	  ;Cleanup OLD
	  FileDelete($FirefoxAppPath & "\extensions\Gnome-Brave@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Gnome-Human@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Gnome-Noble@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Gnome-Wine@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Gnome-Wise@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Gnome@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Cheser@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Tango@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Tangerine@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Elementary@Windows.xpi")
	  FileDelete($FirefoxAppPath & "\extensions\Humanity@Windows.xpi")
	  ;Cleanup done
	  FileCopy($ResourcesDir & "\themes\Firefox\*.xpi", $FirefoxAppPath & "\extensions", 9)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_Thunderbird()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe") Then
	  ;Install
	  InstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "abcardWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\abcardWindow.ico")
	  InstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "addressbookWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\addressbookWindow.ico")
	  InstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "messengerWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\messengerWindow.ico")
	  InstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "msgcomposeWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\msgcomposeWindow.ico")

	  InstallMsg("Installing Theme: Mozilla Thunderbird")

	  CheckAndCloseProcess("thunderbird.exe", "Mozilla Thunderbird")

	  FileCopy($ResourcesDir & "\themes\Thunderbird\*.xpi", $ProgramFiles & "\Mozilla Thunderbird\extensions", 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_SMPlayer()
   ;Theme - no need for a backup
   If $SelectedTheme = "gnome-brave" or $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
	  $theme_SMPlayer = "gnome-" &  $SelectedTheme
   Else
	  $theme_SMPlayer = $SelectedTheme
   EndIf

   If FileExists($ProgramFiles & "\SMPlayer\SMPlayer.exe") Then
	  InstallMsg("Installing Theme: SMPlayer")

	  CheckAndCloseProcess("SMPlayer.exe", "SMPlayer")

	  DirCopy($ResourcesDir & "\themes\SMPlayer", $ProgramFiles & "\SMPlayer\themes", 1)

	  ;activate Theme
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "iconset", _StringTitleCase($theme_SMPlayer))
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "style", "WindowsVista")
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "gui", "DefaultGUI")

	  InstallMsg("done")
   ElseIf FileExists($ProgramFiles64 & "\SMPlayer\SMPlayer.exe") Then
	  InstallMsg("Installing Theme: SMPlayer")

	  CheckAndCloseProcess("SMPlayer.exe", "SMPlayer")

	  DirCopy($ResourcesDir & "\themes\SMPlayer", $ProgramFiles64 & "\SMPlayer\themes", 1)

	  ;activate Theme
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "iconset", _StringTitleCase($theme_SMPlayer))
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "style", "WindowsVista")
	  IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "gui", "DefaultGUI")

	  InstallMsg("done")
   EndIf
EndFunc

;Themes in one PAK:
Func ApplyTheme_DiskInfo()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\CrystalDiskInfo\DiskInfo.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: CrystalDiskInfo")

	  CheckAndCloseProcess("DiskInfo.exe", "Crystal DiskInfo")

	  DirCopy($ResourcesDir & "\themes\CrystalDiskInfo", $ProgramFiles & "\CrystalDiskInfo\CdiResource\themes", 1)

	  ;activate Theme
;~  	  If $SelectedTheme = "elementary" Then ;WIP!
;~ 		 $theme_DiskInfo = "elementary"
;~  	  Else
;~ 		 $theme_DiskInfo = "Shiki-Colors"
;~  	  EndIf
;~ 	  IniWrite($ProgramFiles & "\CrystalDiskInfo\DiskInfo.ini", "Setting", "Theme", $theme_DiskInfo)

	  IniWrite($ProgramFiles & "\CrystalDiskInfo\DiskInfo.ini", "Setting", "Theme", "Shiki-Colors")

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_Foobar2000()
   If FileExists($ProgramFiles & "\foobar2000\foobar2000.exe") Then
	  ;Install
	  CheckAndCloseProcess("foobar2000.exe", "foobar2000")

	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "aac.ico", $ResourcesDir & "\themes\foobar2000\aac.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ape.ico", $ResourcesDir & "\themes\foobar2000\ape.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "flac.ico", $ResourcesDir & "\themes\foobar2000\flac.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "generic.ico", $ResourcesDir & "\themes\foobar2000\generic.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "m4a.ico", $ResourcesDir & "\themes\foobar2000\m4a.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp3.ico", $ResourcesDir & "\themes\foobar2000\mp3.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp4.ico", $ResourcesDir & "\themes\foobar2000\mp4.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mpc.ico", $ResourcesDir & "\themes\foobar2000\mpc.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ogg.ico", $ResourcesDir & "\themes\foobar2000\ogg.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wav.ico", $ResourcesDir & "\themes\foobar2000\wav.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wma.ico", $ResourcesDir & "\themes\foobar2000\wma.ico")
	  InstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wv.ico", $ResourcesDir & "\themes\foobar2000\wv.ico")
   EndIf
EndFunc

Func ApplyTheme_Gimp()
   If FileExists($ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe") or FileExists($ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe") Then
	  ;Install
	  CheckAndCloseProcess("gimp-2.8.exe", "GIMP")

	  InstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
	  InstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
	  InstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")

	  InstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
	  InstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
	  InstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")
   EndIf
EndFunc

Func ApplyTheme_Inkscape()
   If FileExists($ProgramFiles & "\Inkscape\Inkscape.exe") or FileExists($ProgramFiles64 & "\Inkscape\Inkscape.exe") Then
	  ;Install
	  CheckAndCloseProcess("inkscape.exe", "Inkscape")

	  InstallTheme("Inkscape", $ProgramFiles & "\Inkscape\inkscape.exe", $ProgramFiles & "\Inkscape\share\icons", "icons.svg", $ResourcesDir & "\themes\Inkscape\icons.svg")
	  InstallTheme("Inkscape", $ProgramFiles64 & "\Inkscape\inkscape.exe", $ProgramFiles64 & "\Inkscape\share\icons", "icons.svg", $ResourcesDir & "\themes\Inkscape\icons.svg")
   EndIf
EndFunc

Func ApplyTheme_LibreOffice()
   If FileExists($ProgramFiles & "\LibreOffice 4\program\soffice.exe") or FileExists($ProgramFiles & "\LibreOffice 5\program\soffice.exe") or FileExists($ProgramFiles64 & "\LibreOffice 5\program\soffice.exe") Then
	  ;Install

	  ;4.x
	  InstallTheme("LibreOffice", $ProgramFiles & "\LibreOffice 4\program\soffice.exe", $ProgramFiles & "\LibreOffice 4\share\config", "images_tango.zip", $ResourcesDir & "\themes\LibreOffice\images_tango.zip")
	  InstallTheme("LibreOffice", $ProgramFiles & "\LibreOffice 4\program\soffice.exe", $ProgramFiles & "\LibreOffice 4\program", "intro.png", $ResourcesDir & "\themes\LibreOffice\intro.png")

	  ;5.x
	  InstallTheme("LibreOffice", $ProgramFiles & "\LibreOffice 5\program\soffice.exe", $ProgramFiles & "\LibreOffice 5\program", "intro.png", $ResourcesDir & "\themes\LibreOffice\intro.png")
	  InstallTheme("LibreOffice", $ProgramFiles64 & "\LibreOffice 5\program\soffice.exe", $ProgramFiles64 & "\LibreOffice 5\program", "intro.png", $ResourcesDir & "\themes\LibreOffice\intro.png")
   EndIf
EndFunc

Func ApplyTheme_MPC()
   If FileExists($ProgramFiles & "\MPC-HC\mpc-hc.exe") or FileExists($ProgramFiles64 & "\MPC-HC\mpc-hc64.exe") then
	  ;Theme - no need for a backup
	  If FileExists($ProgramFiles & "\MPC-HC\mpc-hc.exe") Then
		 InstallMsg("Installing Theme: Media Player Classic HC")

		 FileCopy($ResourcesDir & "\Themes\MPCHC\toolbar_24.bmp", $ProgramFiles & "\MPC-HC\toolbar.bmp", 1)

		 InstallMsg("done")
	  ElseIf FileExists($ProgramFiles64 & "\MPC-HC\mpc-hc64.exe") Then
		 InstallMsg("Installing Theme: Media Player Classic HC")

		 FileCopy($ResourcesDir & "\Themes\MPCHC\toolbar_24.bmp", $ProgramFiles64 & "\MPC-HC\toolbar.bmp", 1)

		 InstallMsg("done")
	  EndIf
   EndIf
EndFunc

Func ApplyTheme_MSOffice()
   ;Office 2010 icons
   If FileExists(@WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}\wordicon.exe") Then
	  InstallMsg("Installing Theme: Microsoft Office 2010")

	  RunWait($ResourcesDir & "\themes\Office2010\Patch_pptico.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_wordicon.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_xlicons.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")

	  InstallMsg("done")

   ;Office 2013 icons
   ElseIf FileExists(@WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}\wordicon.exe") Then
	  InstallMsg("Installing Theme: Microsoft Office 2013")

	  RunWait($ResourcesDir & "\themes\Office2010\Patch_pptico.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_wordicon.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_xlicons.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")

	  InstallMsg("done")

   ;Office 2016 icons
   ElseIf FileExists(@WindowsDir & "\Installer\{90160000-0011-0000-1000-0000000FF1CE}\wordicon.exe") Then
	  InstallMsg("Installing Theme: Microsoft Office 2016")

	  RunWait($ResourcesDir & "\themes\Office2010\Patch_pptico.exe -auto -nobackup", @WindowsDir & "\Installer\{90160000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_wordicon.exe -auto -nobackup", @WindowsDir & "\Installer\{90160000-0011-0000-1000-0000000FF1CE}")
	  RunWait($ResourcesDir & "\themes\Office2010\Patch_xlicons.exe -auto -nobackup", @WindowsDir & "\Installer\{90160000-0011-0000-1000-0000000FF1CE}")

   EndIf
EndFunc

Func ApplyTheme_Pidgin()
   If FileExists($ProgramFiles & "\Pidgin\Pidgin.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: Pidgin")

	  DirCopy($ResourcesDir & "\themes\Pidgin", $ProgramFiles & "\Pidgin", 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_RadioSure()
   ;Theme - no need for a backup
   If FileExists(@LocalAppDataDir & "\RadioSure\RadioSure.exe") Then
	  InstallMsg("Installing Theme: RadioSure")

	  CheckAndCloseProcess("RadioSure.exe", "RadioSure")

	  DirCopy($ResourcesDir & "\themes\RadioSure", @LocalAppDataDir & "\RadioSure", 1)

	  ;activate Theme
	  If $SelectedTheme = "gnome-brave" or $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
		 $theme_RadioSure = "GnomeColors"
	  Else
		 $theme_RadioSure = $SelectedTheme
	  EndIf
	  XmlModify(@LocalAppDataDir & "\RadioSure\RadioSure.xml", "skin", $theme_RadioSure)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_Rainlendar()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\Rainlendar2\Rainlendar2.exe") Then
	  InstallMsg("Installing Theme: Rainlendar2")

	  CheckAndCloseProcess("Rainlendar2.exe", "Rainlendar")

	  FileCopy($ResourcesDir & "\themes\Rainlendar\*.r2skin", $ProgramFiles & "\Rainlendar2\skins", 1)

	  InstallMsg("done")
   ElseIf FileExists($ProgramFiles64 & "\Rainlendar2\Rainlendar2.exe") Then
	  InstallMsg("Installing Theme: Rainlendar2")

	  CheckAndCloseProcess("Rainlendar2.exe", "Rainlendar")

	  FileCopy($ResourcesDir & "\themes\Rainlendar\*.r2skin", $ProgramFiles64 & "\Rainlendar2\skins", 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_uTorrent()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\uTorrent\uTorrent.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: uTorrent")

	  CheckAndCloseProcess("uTorrent.exe", "uTorrent")

	  FileCopy($ResourcesDir & "\themes\uTorrent\*.bmp", @AppDataDir & "\uTorrent", 1)
	  FileCopy($ResourcesDir & "\themes\uTorrent\*.ico", @AppDataDir & "\uTorrent", 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func ApplyTheme_VLC()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\VideoLAN\VLC\vlc.exe") and $SelectedTheme = "elementary" or $SelectedTheme = "humanity" Then
	  ;Install
	  InstallMsg("Installing Theme: VLC")

	  CheckAndCloseProcess("vlc.exe", "VideoLAN")

	  FileCopy($ResourcesDir & "\themes\VLC\*.vlt", $ProgramFiles & "\VideoLAN\VLC\skins", 1)

	  ;activate Theme
	  CfgModify(@AppDataDir & "\vlc\vlcrc", "skins2-last=", $ProgramFiles & "\VideoLAN\VLC\skins\elementaryDark", ".vlt")

	  InstallMsg("done")

   ElseIf FileExists($ProgramFiles64 & "\VideoLAN\VLC\vlc.exe") and $SelectedTheme = "elementary" or $SelectedTheme = "humanity" Then
	  ;Install
	  InstallMsg("Installing Theme: VLC")

	  CheckAndCloseProcess("vlc.exe", "VideoLAN")

	  FileCopy($ResourcesDir & "\themes\VLC\*.vlt", $ProgramFiles64 & "\VideoLAN\VLC\skins", 1)

	  ;activate Theme
	  CfgModify(@AppDataDir & "\vlc\vlcrc", "skins2-last=", $ProgramFiles64 & "\VideoLAN\VLC\skins\elementaryDark", ".vlt")

	  InstallMsg("done")

   EndIf
EndFunc

Func ApplyTheme_Winyl()
   ;Theme - no need for a backup
   If FileExists($ProgramFiles & "\Winyl\Winyl.exe") Then
	  ;Install
	  InstallMsg("Installing Theme: Winyl")

	  CheckAndCloseProcess("Winyl.exe", "Winyl")

	  FileCopy($ResourcesDir & "\themes\Winyl\*.wzp", $ProgramFiles & "\Winyl\Skin", 1)

	  ;activate Theme
	  If $SelectedTheme = "elementary" Then
		 $theme_Winyl = $SelectedTheme
	  ElseIf $SelectedTheme = "cheser" Then
		 $theme_Winyl = "Flat Gnome"
	  Else
		 $theme_Winyl = "Flat " & $SelectedTheme
	  EndIf
	  CfgModify(@AppDataDir & "\Winyl\Settings.xml", '<skin ID="', $theme_Winyl, '" Pack')
	  ;_ReplaceXML_v2(@AppDataDir & "\Winyl\Settings.xml", "skin", $theme_Winyl, 1)

	  InstallMsg("done")
   EndIf
EndFunc


;3rd Party Apps: File
Func PatchAppFiles()
   ;=====Appfiles====================
   For $ChBox In $CheckboxesDictApps.Keys ()
	  If BitAND(GUICtrlRead($ChBox), 1) Then
		 $FileName = $CheckboxesDictApps ($ChBox)
		 $InstallFilesApps.enqueue ($FileName)
	  EndIf
   Next

   $IniFile = $IniFileApps

   If $InstallFilesApps.count > 0 Then
	  Do
		 $EntrysNumber = IniRead($IniFile, $InstallFilesApps.Peek, "Entrys", "1")

		 For $j = 1 To $EntrysNumber

			$File = IniRead($IniFile, $InstallFilesApps.Peek, "File_" & $j, "")
			$PathIni = IniRead($IniFile, $InstallFilesApps.Peek, "Path_" & $j, "")

			If not StringInStr($PathIni, "WindowsDir") = 0 Then
			   $Path = StringReplace($PathIni, "WindowsDir", @WindowsDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataLocal") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataLocal", EnvGet("LOCALAPPDATA"))
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "AppDataRoaming") = 0 Then
			   $Path = StringReplace($PathIni, "AppDataRoaming", @AppDataDir)
			   $Path64 = ""
			ElseIf not StringInStr($PathIni, "SystemDir") = 0 Then
			   $Path = StringReplace($PathIni, "SystemDir", @WindowsDir & "\System32")
			   $Path64 = StringReplace($PathIni, "SystemDir", @WindowsDir & "\SysWOW64")
			ElseIf not StringInStr($PathIni, "ProgramFilesDir") = 0 Then
			   $Path = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles)
			   $Path64 = StringReplace($PathIni, "ProgramFilesDir", $ProgramFiles64)
			Else
			   $Path = $PathIni
			   $Path64 = ""
			EndIf

			If $Path <> "" and $File <> "" Then InstallFile($File, $Path)
			If $Path64 <> "" and $File <> "" Then InstallFile64($File, $Path64)

		 Next

		 $InstallFilesApps.dequeue

	  Until Not $InstallFilesApps.count
   EndIf


   ;Temporarily unpatch files until bugs are solved
   UninstallFile("VirtualBox.exe", $ProgramFiles & "\Oracle\VirtualBox")
   UninstallFile64("VirtualBox.exe", $ProgramFiles64 & "\Oracle\VirtualBox")

EndFunc
#EndRegion


Func PostInstall()
   ;Cleanup
   FileDelete($ToolsDir & "\ResHacker.ini")
   DirRemove(@DesktopDir & "\Override", 1)

   ;Patcher Information
   RegWrite($AppRegKey, "Version", "REG_SZ", $AppVersion)
   RegWrite($AppRegKey, "IconTheme", "REG_SZ", $SelectedTheme)

   ;Unistaller
   RegWrite($UninstallRegKey, "DisplayName", "REG_SZ", $AppName)
   RegWrite($UninstallRegKey, "UninstallString", "REG_SZ", @ScriptDir & "\patcher.exe /uninstall")
   RegWrite($UninstallRegKey, "DisplayIcon", "REG_SZ", @ScriptDir & "\patcher.exe")
   RegWrite($UninstallRegKey, "DisplayVersion", "REG_SZ", $AppVersion)
   RegWrite($UninstallRegKey, "URLInfoAbout", "REG_SZ", $AppWebsite)
   RegWrite($UninstallRegKey, "Publisher", "REG_SZ", $AppPublisher)

   ;Add to Control Panel
   $CLSID = "{77708248-f839-436b-8919-527c410f48b9}"
   RegWrite("HKEY_CLASSES_ROOT\CLSID\" & $CLSID, "", "REG_SZ", $AppName)
   RegWrite("HKEY_CLASSES_ROOT\CLSID\" & $CLSID, "InfoTip", "REG_SZ", $AppName & " Settings & Infos")
   RegWrite("HKEY_CLASSES_ROOT\CLSID\" & $CLSID, "System.ControlPanel.Category", "REG_SZ", "1")
   RegWrite("HKEY_CLASSES_ROOT\CLSID\" & $CLSID & "\DefaultIcon", "", "REG_SZ", @ScriptDir & "\PatcherCPL.exe")
   RegWrite("HKEY_CLASSES_ROOT\CLSID\" & $CLSID & "\Shell\Open\Command", "", "REG_SZ", @ScriptDir & "\PatcherCPL.exe")
   RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\" & $CLSID, "", "REG_SZ", "Adds " & $AppName & " to the Control Panel")
EndFunc
