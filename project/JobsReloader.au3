Func ReAppearance()
   ;Branding
   UpdateFile("basebrd.dll", @WindowsDir & "\Branding\Basebrd") ;Windows Edition Banners
   UpdateFile("shellbrd.dll", @WindowsDir & "\Branding\ShellBrd") ;First Steps (CPL) + Windows Flags

   ;foobar2000 File Type Icons
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "aac.ico", $ResourcesDir & "\themes\foobar2000\aac.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ape.ico", $ResourcesDir & "\themes\foobar2000\ape.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "flac.ico", $ResourcesDir & "\themes\foobar2000\flac.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "generic.ico", $ResourcesDir & "\themes\foobar2000\generic.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "m4a.ico", $ResourcesDir & "\themes\foobar2000\m4a.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp3.ico", $ResourcesDir & "\themes\foobar2000\mp3.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp4.ico", $ResourcesDir & "\themes\foobar2000\mp4.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mpc.ico", $ResourcesDir & "\themes\foobar2000\mpc.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ogg.ico", $ResourcesDir & "\themes\foobar2000\ogg.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wav.ico", $ResourcesDir & "\themes\foobar2000\wav.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wma.ico", $ResourcesDir & "\themes\foobar2000\wma.ico")
   UpdateTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wv.ico", $ResourcesDir & "\themes\foobar2000\wv.ico")

   ;Gimp Theme/Images
   UpdateTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
   UpdateTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
   UpdateTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")
   UpdateTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
   UpdateTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
   UpdateTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")

   ;Inkscape Theme
   UpdateTheme("Inkscape", $ProgramFiles & "\Inkscape\inkscape.exe", $ProgramFiles & "\Inkscape\share\icons", "icons.svg", $ResourcesDir & "\themes\Inkscape\icons.svg")
   UpdateTheme("Inkscape", $ProgramFiles64 & "\Inkscape\inkscape.exe", $ProgramFiles & "\Inkscape\share\icons", "icons.svg", $ResourcesDir & "\themes\Inkscape\icons.svg")

   ;LibreOffice Images
   UpdateTheme("LibreOffice", $ProgramFiles & "\LibreOffice 4.0\program\soffice.exe", $ProgramFiles & "\LibreOffice 4.0\program", "intro.png", $ResourcesDir & "\themes\LibreOffice\intro.png")

   ;Mozilla Thunderbird Icons
   UpdateTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "abcardWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\abcardWindow.ico")
   UpdateTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "addressbookWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\addressbookWindow.ico")
   UpdateTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "messengerWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\messengerWindow.ico")
   UpdateTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "msgcomposeWindow.ico", $ResourcesDir & "\themes\Thunderbird\icons\msgcomposeWindow.ico")

   ;FreeFileSync
   UpdateTheme("FreeFileSync", $ProgramFiles & "\FreeFileSync\FreeFileSync.exe", $ProgramFiles & "\FreeFileSync", "Resources.zip", $ResourcesDir & "\themes\FreeFileSync\Resources.zip")
   UpdateTheme("FreeFileSync", $ProgramFiles64 & "\FreeFileSync\FreeFileSync.exe", $ProgramFiles64 & "\FreeFileSync", "Resources.zip", $ResourcesDir & "\themes\FreeFileSync\Resources.zip")
EndFunc


Func ReFiles($IniFile)
   $entrys = IniReadSectionNames($IniFile)

   For $i = 1 To $entrys[0]
	  $EntrysNumber = IniRead($IniFile, $entrys[$i], "Entrys", "1")

	  For $j = 1 To $EntrysNumber

		 $File = IniRead($IniFile, $entrys[$i], "File_" & $j, "")
		 $PathIni = IniRead($IniFile, $entrys[$i], "Path_" & $j, "")

		 ;Close App to avoid unnecessary reboots
		 $ProcessClosed = 0
		 If StringInStr($IniFile, "Apps") > 0 Then
			If ProcessExists($File) and $SilentInstall = 1 Then
			   ProcessClose($File)
			   $ProcessClosed = 1
			ElseIf ProcessExists($File) and $SilentInstall = 0 Then
			   CheckAndCloseProcess($File, $entrys[$i])
			   $ProcessClosed = 1
			EndIf
		 EndIf
		 ;End


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

		 If $Path <> "" and $File <> "" Then UpdateFile($File, $Path)
		 If $Path64 <> "" and $File <> "" Then UpdateFile64($File, $Path64)


		 ;Restart App if it was running
		 If $ProcessClosed = 1 Then
			If $Path <> "" and $File <> "" Then Run($Path & "\" & $File)
			If $Path64 <> "" and $File <> "" Then Run($Path64 & "\" & $File)
		 EndIf
		 ;End

	  Next

   Next
EndFunc


Func ReThemeSMPlayer($AppDir)
   If $SilentInstall = 0 Then InstallMsg("Reloading Theme: SMPlayer")

   If $SelectedTheme = "gnome-brave" or $SelectedTheme = "gnome-human" or $SelectedTheme = "gnome-noble" or $SelectedTheme = "gnome-wine" or $SelectedTheme = "gnome-wise" Then
	  $theme_SMPlayer = "gnome-" &  $SelectedTheme
   Else
	  $theme_SMPlayer = $SelectedTheme
   EndIf

   DirCopy($ResourcesDir & "\themes\SMPlayer", $AppDir & "\SMPlayer\themes", 1)
   IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "iconset", _StringTitleCase($theme_SMPlayer)) ;activate Theme
   IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "style", "WindowsVista") ;activate Theme
   IniWrite(@UserProfileDir & "\.smplayer\smplayer.ini", "gui", "gui", "DefaultGUI") ;activate Theme

   If $SilentInstall = 0 Then InstallMsg("done")
EndFunc


Func PostReload()
   FileDelete($ToolsDir & "\ResHacker.ini")
   DirRemove($NewFilesDir, 1)
   DirRemove(@DesktopDir & "\Override", 1)
EndFunc