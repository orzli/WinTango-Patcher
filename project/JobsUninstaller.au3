Func UnAppearance()
   ;VS
   ShellExecuteWait(@WindowsDir & "\Resources\Themes\aero.theme");apply native Windows Theme
   sleep(8000)
   send("!{f4}")

   DirRemove(@WindowsDir & "\Resources\Themes\Shiki-Colors", 1) ;Win7
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors [Basic].theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Brave.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Human.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Noble.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Wine.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Wise.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Carbonite.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Dust.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Elementary.theme")
   FileDelete(@WindowsDir & "\Resources\Themes\Shiki-Colors Humanity.theme")
   FileDelete(@DesktopCommonDir & "\Apply Shiki-Colors Theme.lnk")
   If FileExists(@WindowsDir & "\Resources\Themes\Shiki-Colors") Then MoveEx(@WindowsDir & "\Resources\Themes\Shiki-Colors", "")

   DirRemove(@WindowsDir & "\Resources\Themes\elementary", 1) ;Win7
   FileDelete(@WindowsDir & "\Resources\Themes\elementary.theme")
   FileDelete(@DesktopCommonDir & "\Apply elementary Theme.lnk")
   If FileExists(@WindowsDir & "\Resources\Themes\elementary") Then MoveEx(@WindowsDir & "\Resources\Themes\elementary", "")

   DirRemove(@WindowsDir & "\Resources\Themes\ubuntu", 1) ;Win7
   FileDelete(@WindowsDir & "\Resources\Themes\ubuntu.theme")
   FileDelete(@DesktopCommonDir & "\Apply Ubuntu Theme.lnk")
   If FileExists(@WindowsDir & "\Resources\Themes\ubuntu") Then MoveEx(@WindowsDir & "\Resources\Themes\ubuntu", "")

   ;Disable Taskbar Transparency
   FileDelete(@StartupCommonDir & "\OpaqueTaskbar.lnk")

   ;Shiki-Colors Wallpapers
   $search = FileFindFirstFile(@WindowsDir & "\Web\Wallpaper\Arc-*.png")
   While 1
	  $file = FileFindNextFile($search)
	  If @error Then ExitLoop
	  FileDelete(@WindowsDir & "\Web\Wallpaper\" & $file)
   WEnd
   FileClose($search)

   ;Elementary/Humanity Wallpaper
   FileDelete(@WindowsDir & "\Web\Wallpaper\elementary.png")
   FileDelete(@WindowsDir & "\Web\Wallpaper\ubuntu.png")
   FileDelete(@WindowsDir & "\Web\Wallpaper\elementary.jpg")
   FileDelete(@WindowsDir & "\Web\Wallpaper\ubuntu.jpg")
   DirRemove(@WindowsDir & "\Web\Wallpaper\elementary OS", 1)

   ;Cursors
   DirRemove(@WindowsDir & "\Cursors\ubuntu", 1)
   RegDelete("HKCU\Control Panel\Cursors\Schemes", "Ubuntu")
   DirRemove(@WindowsDir & "\Cursors\elementary", 1)
   RegDelete("HKCU\Control Panel\Cursors\Schemes", "elementary")
   ;set to standard cursors
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Arrow", "REG_SZ", @WindowsDir & "\Cursors\normal.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Help", "REG_SZ", @WindowsDir & "\Cursors\help.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "AppStarting", "REG_SZ", @WindowsDir & "\Cursors\working.ani")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Wait", "REG_SZ", @WindowsDir & "\Cursors\busy.ani")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Crosshair", "REG_SZ", @WindowsDir & "\Cursors\precision.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "IBeam", "REG_SZ", @WindowsDir & "\Cursors\text.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "NWPen", "REG_SZ", @WindowsDir & "\Cursors\handwriting.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "No", "REG_SZ", @WindowsDir & "\Cursors\unavailable.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNS", "REG_SZ", @WindowsDir & "\Cursors\vertical_resize.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeWE", "REG_SZ", @WindowsDir & "\Cursors\horizontal_resize.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNWSE", "REG_SZ", @WindowsDir & "\Cursors\diagonal_resize_1.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeNESW", "REG_SZ", @WindowsDir & "\Cursors\diagonal_resize_2.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "SizeAll", "REG_SZ", @WindowsDir & "\Cursors\move.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "UpArrow", "REG_SZ", @WindowsDir & "\Cursors\alternate.cur")
   RegWrite("HKEY_CURRENT_USER\Control Panel\Cursors", "Hand", "REG_SZ", @WindowsDir & "\Cursors\link.cur")

   ;Desktops
   ProcessClose("Desktops.exe")
   FileDelete(@WindowsDir & "\Desktops.exe")
   RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Sysinternals Desktops")

   ;Branding
   UninstallFile("basebrd.dll", @WindowsDir & "\Branding\Basebrd") ;Windows Edition Banners
   UninstallFile("shellbrd.dll", @WindowsDir & "\Branding\ShellBrd") ;First Steps (CPL) + Windows Flags


   ;========================================
   ;=== App Themes =========================
   ;========================================

   ;Aimp Themes
   CheckAndCloseProcess("AIMP3.exe", "AIMP")
   FileDelete($ProgramFiles & "\AIMP3\Skins\Shiki*.acs3")
   FileDelete($ProgramFiles & "\AIMP3\Skins\elementary.acs3")

   ;foobar2000 File Type Icons
   CheckAndCloseProcess("foobar2000.exe", "foobar2000")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "aac.ico", $ResourcesDir & "\themes\foobar2000\aac.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ape.ico", $ResourcesDir & "\themes\foobar2000\ape.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "flac.ico", $ResourcesDir & "\themes\foobar2000\flac.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "generic.ico", $ResourcesDir & "\themes\foobar2000\generic.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "m4a.ico", $ResourcesDir & "\themes\foobar2000\m4a.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp3.ico", $ResourcesDir & "\themes\foobar2000\mp3.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mp4.ico", $ResourcesDir & "\themes\foobar2000\mp4.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "mpc.ico", $ResourcesDir & "\themes\foobar2000\mpc.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "ogg.ico", $ResourcesDir & "\themes\foobar2000\ogg.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wav.ico", $ResourcesDir & "\themes\foobar2000\wav.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wma.ico", $ResourcesDir & "\themes\foobar2000\wma.ico")
   UninstallTheme("foobar2000", $ProgramFiles & "\foobar2000\foobar2000.exe", $ProgramFiles & "\foobar2000\icons", "wv.ico", $ResourcesDir & "\themes\foobar2000\wv.ico")

   ;Gimp Theme/Images
   CheckAndCloseProcess("gimp-2.8.exe", "GIMP")
   UninstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
   UninstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
   UninstallTheme("Gimp", $ProgramFiles & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")
   UninstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-logo.png", $ResourcesDir & "\themes\Gimp\gimp-logo.png")
   UninstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "gimp-splash.png", $ResourcesDir & "\themes\Gimp\gimp-splash.png")
   UninstallTheme("Gimp", $ProgramFiles64 & "\GIMP 2\bin\gimp-2.8.exe", $ProgramFiles64 & "\GIMP 2\share\gimp\2.0\images", "wilber.png", $ResourcesDir & "\themes\Gimp\wilber.png")

   ;Inkscape Theme
   CheckAndCloseProcess("inkscape.exe", "Inkscape")
   UninstallTheme("Inkscape", $ProgramFiles & "\Inkscape\inkscape.exe", $ProgramFiles & "\Inkscape\share\icons", "icons.svg", $ResourcesDir & "\themes\Inkscape\icons.svg")

   ;jDownloader Themes
   CheckAndCloseProcess("jdownloader.exe", "jDownloader")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\gnome.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\cheser.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\brave.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\human.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\noble.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\wine.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\wise.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\tango.icl")
   FileDelete($ProgramFiles & "\jDownloader\jd\themes\tangerine.icl")
   DirRemove($ProgramFiles & "\jDownloader\jd\img\gnome", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\cheser", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\brave", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\human", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\noble", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\wine", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\wise", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\tango", 1)
   DirRemove($ProgramFiles & "\jDownloader\jd\img\tangerine", 1)

   ;LibreOffice Theme
   UninstallTheme("LibreOffice", $ProgramFiles & "\LibreOffice 4\program\soffice.exe", $ProgramFiles & "\LibreOffice 4\program", "intro.png", $ResourcesDir & "\themes\LibreOffice\intro.png")

   ;Media Player Classic Theme
   FileDelete($ProgramFiles & "\MPC-HC\toolbar.bmp")
   FileDelete($ProgramFiles64 & "\MPC-HC\toolbar.bmp")

   ;Office 2010 icons
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_pptico.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_wordicon.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_xlicons.exe -auto -nobackup", @WindowsDir & "\Installer\{90140000-0011-0000-1000-0000000FF1CE}")

   ;Office 2013 icons
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_pptico.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_wordicon.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")
   RunWait($ResourcesDir & "\themes\Office2010\UnPatch_xlicons.exe -auto -nobackup", @WindowsDir & "\Installer\{90150000-0011-0000-1000-0000000FF1CE}")

   ;Firefox Theme
   CheckAndCloseProcess("firefox.exe", "Mozilla Firefox")
   $FirefoxAppPath = @AppDataDir & "\Mozilla\Firefox\" & StringReplace(IniRead(@AppDataDir & "\Mozilla\Firefox\profiles.ini", "Profile0", "Path", "Error"), "/", "\")

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

   FileDelete($FirefoxAppPath & "\extensions\Gnome-Brave-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Gnome-Human-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Gnome-Noble-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Gnome-Wine-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Gnome-Wise-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Gnome-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Cheser-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Tango-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Tangerine-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Elementary-Extras@Windows.xpi")
   FileDelete($FirefoxAppPath & "\extensions\Humanity-Extras@Windows.xpi")

   ;Mozilla Thunderbird Theme
   CheckAndCloseProcess("thunderbird.exe", "Mozilla Thunderbird")
   UninstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "abcardWindow.ico", $ResourcesDir & "\themes\Firefox Thunderbird\Thunderbird\abcardWindow.ico")
   UninstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "addressbookWindow.ico", $ResourcesDir & "\themes\Firefox Thunderbird\Thunderbird\addressbookWindow.ico")
   UninstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "messengerWindow.ico", $ResourcesDir & "\themes\Firefox Thunderbird\Thunderbird\messengerWindow.ico")
   UninstallTheme("Mozilla Thunderbird", $ProgramFiles & "\Mozilla Thunderbird\thunderbird.exe", $ProgramFiles & "\Mozilla Thunderbird\chrome\icons\default", "msgcomposeWindow.ico", $ResourcesDir & "\themes\Firefox Thunderbird\Thunderbird\msgcomposeWindow.ico")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome-Brave@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome-Human@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome-Noble@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome-Wine@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome-Wise@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Gnome@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Cheser@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Tango@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Tangerine@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Elementary@Windows.xpi")
   FileDelete($ProgramFiles & "\Mozilla Thunderbird\extensions\Humanity@Windows.xpi")

   ;RadioSure Theme
   CheckAndCloseProcess("RadioSure.exe", "RadioSure")
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\Tango.rsn", 1)
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\Tangerine.rsn", 1)
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\Gnome.rsn", 1)
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\Gnome-Colors.rsn", 1)
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\elementary.rsn", 1)
   DirRemove(@LocalAppDataDir & "\RadioSure\skins\Humanity.rsn", 1)

   ;Rainlendar Theme
   CheckAndCloseProcess("Rainlendar2.exe", "Rainlendar")
   FileDelete($ProgramFiles & "\Rainlendar2\skins\Tango HCal.r2skin")
   FileDelete($ProgramFiles64 & "\Rainlendar2\skins\Tango HCal.r2skin")

   ;SMPlayer Themes
   CheckAndCloseProcess("SMPlayer.exe", "SMPlayer")
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\cheser", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome-brave", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome-human", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome-noble", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome-wine", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\gnome-wise", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\tango", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\tagerine", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\elementary", 1)
   DirRemove($ProgramFiles & "\SMPlayer\themes\humanity", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\cheser", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome-brave", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome-human", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome-noble", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome-wine", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\gnome-wise", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\tango", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\tagerine", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\elementary", 1)
   DirRemove($ProgramFiles64 & "\SMPlayer\themes\humanity", 1)

   ;uTorrent Theme
   CheckAndCloseProcess("uTorrent.exe", "uTorrent")
   FileDelete(@AppDataDir & "\uTorrent\tabs.bmp")
   FileDelete(@AppDataDir & "\uTorrent\toolbar.bmp")
   FileDelete(@AppDataDir & "\uTorrent\tstatus.bmp")
   FileDelete(@AppDataDir & "\uTorrent\main.ico")
   FileDelete(@AppDataDir & "\uTorrent\tray.ico")

   ;Crystal DiskInfo
   CheckAndCloseProcess("DiskInfo.exe", "Crystal DiskInfo")
   DirRemove($ProgramFiles & "\CrystalDiskInfo\CdiResource\themes\Shiki-Colors", 1)
   DirRemove($ProgramFiles & "\CrystalDiskInfo\CdiResource\themes\elementary", 1)

   ;VLC
   CheckAndCloseProcess("vlc.exe", "VideoLAN")
   FileDelete($ProgramFiles & "\VideoLAN\VLC\skins\elementaryDark.vlt")
   FileDelete($ProgramFiles64 & "\VideoLAN\VLC\skins\elementaryDark.vlt")

   ;Winyl Theme
   CheckAndCloseProcess("Winyl.exe", "Winyl")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome-Brave.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome-Human.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome-Noble.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome-Wine.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Gnome-Wise.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Tango.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Tangerine.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat elementary.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\elementary.wzp")
   FileDelete($ProgramFiles & "\Winyl\Skin\Flat Humanity.wzp")
EndFunc


Func UnFiles($IniFile)
   $entrys = IniReadSectionNames($IniFile)

   For $i = 1 To $entrys[0]
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

   Next
EndFunc


Func PostUnInstall()
   ;Remove shortcuts
   FileDelete(@StartupDir & "\" & $AppName & " Reloader.lnk")
   FileDelete(@StartupDir & "\" & $AppName & " Updatecheck.lnk")

   ;Control Panel
   $CLSID = "{77708248-f839-436b-8919-527c410f48b9}"
   RegDelete("HKCR\CLSID\" & $CLSID)
   RegDelete("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\" & $CLSID)

   ;Entry in Registry
   RegDelete($UninstallRegKey)
   RegDelete("HKLM\Software\" & $AppName)

   ;Delete all Patcher Files
   DirRemove(@ScriptDir & "\Backup", 1)
   DirRemove(@ScriptDir & "\Logs", 1)
   DirRemove(@ScriptDir & "\NewFiles", 1)
   DirRemove(@ScriptDir & "\Override", 1)
   DirRemove(@ScriptDir & "\Resources", 1)
   DirRemove(@ScriptDir & "\Themes", 1)
   DirRemove(@ScriptDir & "\Tools", 1)
   DirRemove(@ScriptDir & "\Icons", 1)
   DirRemove(@ScriptDir & "\Lang", 1)
   FileDelete(@ScriptDir & "\filesApps.ini")
   FileDelete(@ScriptDir & "\filesWindows.ini")
   FileDelete(@ScriptDir & "\Patcher.exe")
   FileDelete(@ScriptDir & "\Patcher.log")
   FileDelete(@ScriptDir & "\Reloader.log")
   FileDelete(@ScriptDir & "\PatcherCPL.exe")
   FileDelete(@ScriptDir & "\readme.pdf")
   FileDelete(@ScriptDir & "\Release Notes.txt")
   FileDelete(@ScriptDir & "\Updater.exe")

   FileDelete(@ScriptDir & "\*.*")

   DirRemove(@ScriptDir, 1) ;remove the main folder

   ;In case the removal of the main folder had no success, try the MoveEx method
   FileDelete(@ScriptDir & "\" & @ScriptName)
   MoveEx(@ScriptDir & "\" & @ScriptName, "")
   MoveEx(@ScriptDir, "")

EndFunc


;~ Func _SelfDelete($iDelay = 0)
;~     Local $sCmdFile
;~     FileDelete(@TempDir & "scratch.bat")
;~     $sCmdFile = 'ping -n ' & $iDelay & ' 127.0.0.1 > nul' & @CRLF _
;~              & ':loop' & @CRLF _
;~              & 'del "' & @ScriptFullPath & '"' & @CRLF _
;~              & 'if exist "' & @ScriptFullPath & '" goto loop' & @CRLF _
;~              & 'del ' & @TempDir & 'scratch.bat'
;~     FileWrite(@TempDir & "scratch.bat", $sCmdFile)
;~     Run(@TempDir & "scratch.bat", @TempDir, @SW_HIDE)
;~ EndFunc;==>_SelfDelete