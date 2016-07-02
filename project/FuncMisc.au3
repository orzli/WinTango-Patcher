Func Defines()
   ;This defines all the globally used Variables

   Global $AppName = "WinTango Patcher"
   Global $AppVersion = "16.06.XX"
   Global $AppPublisher = "heebijeebi"
   Global $AppRegKey = "HKLM\Software\" & $AppName

   Global $AppWebsite = "http://wintango.blogspot.de"
   Global $AppWebsite2 = "http://heebijeebi.deviantart.com"
   Global $AppMail = "heebijeebi@gmx.net"
   Global $AppBugReport = "http://wintango.blogspot.de/p/bug-report.html"
   Global $AppHelp = "http://wintango.blogspot.de/p/help.html"

   ;Themes
   Global $IncludedThemes = "Tango|Tangerine|Gnome|Cheser|Gnome-Brave|Gnome-Human|Gnome-Noble|Gnome-Wine|Gnome-Wise|elementary|Humanity"

   ;Icons
   Global $IconsDir = @ScriptDir & "\Icons"
   Global $SwitchIconOn = $IconsDir & "\switch-on.ico"
   Global $SwitchIconOff = $IconsDir & "\switch-off.ico"

   ;Text
   Global $font = "Segoe UI"
   Global $font_size = 10
   Global $font_weight = 400
   Global $font_weight_special = 800
   Global $font_attribute = 0
   Global $font_attribute_special = 2

   ;Registry
   Global $AppRegPathFiles = "HKLM\Software\" & $AppName & "\Files"
   Global $AppRegPathFiles64 = "HKLM\Software\" & $AppName & "\Files\x64"
   Global $UninstallRegKey = "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\" & $AppName

   ;URLs
   Global $FilesURL = "https://dl.dropboxusercontent.com/u/825387/WinTango-Patcher"

   ;Folders
   Global $ResourcesDir = @ScriptDir & "\Resources"
   Global $ToolsDir = @ScriptDir & "\Tools"
   Global $BackupDir = @ScriptDir & "\Backup"
   Global $BackupDir64 = @ScriptDir & "\Backup\x64"
   Global $LogsDir = @ScriptDir & "\Logs"
   Global $LogsDir64 = @ScriptDir & "\Logs\x64"
   Global $NewFilesDir = @ScriptDir & "\NewFiles"
   Global $NewFilesDir64 = @ScriptDir & "\NewFiles\x64"
   Global $OverrideDir = @ScriptDir & "\Override"
   Global $OverrideDir64 = @ScriptDir & "\Override\x64"

   If FileExists(@WindowsDir & "\SysWOW64\cmd.exe") Then
	  ;64-Bit
	  Global $ProgramFiles = @HomeDrive & "\Program Files (x86)"
	  Global $ProgramFiles64 = @HomeDrive & "\Program Files"
	  Global $OsArch = "x64"
   Else
	  ;32-Bit
	  Global $ProgramFiles = @HomeDrive & "\Program Files"
	  Global $ProgramFiles64 = @HomeDrive & "\Program Files (x86)" ;doesn't exist but thats good so the patcher wouldn't patch a file twice
	  Global $OsArch = "x86"
   Endif

   ;INIs
   Global $IniFileWin = @ScriptDir & "\filesWindows.ini"
   Global $IniFileApps = @ScriptDir & "\filesApps.ini"

   ;UXTheme Patchers
   Global $UXPatchReg = "HKLM\Software\UltraUXThemePatcher"
   Global $UXPatchFile = $ProgramFiles & "\UltraUXThemePatcher\Uninstall.exe"

   Global $UXServiceReg = "HKLM\Software\Windows X\UXTheme Multi-Patcher"
   Global $UXServiceFile = $ProgramFiles & "\UXTheme Multi-Patcher\themeengine.exe"
EndFunc
