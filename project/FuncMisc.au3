Func Defines()
   ;This defines all the globally used Variables

   Global $AppName = "WinTango Patcher"
   Global $AppVersion = "16.01.07"
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
   Global $FilesURL_Stable = "https://dl.dropboxusercontent.com/u/825387/WinTango-Patcher"
   Global $FilesURL_Beta = "https://dl.dropboxusercontent.com/u/825387/WinTango-Patcher_BETA"

   Global $FilesURL = $FilesURL_Beta ;$FilesURL_Stable ;define which is the main source

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


#Region Download Routines
Func DownloadResources($sName, $sFileLocal, $sFileServer)
   If FileExists($sFileLocal) Then FileDelete($sFileLocal)
   InstallMsg("Downloading: " & $sName)
   $sURL = $sFileServer
   $iSize = InetGetSize($sUrl)
   $hDL = InetGet($sURL, $sFileLocal, 1, 1)
   Do
	  $hIndexLastEntry = _GUICtrlListBox_GetCount($lstPatchStatus)-1
	  $sTextLastEntry = _GUICtrlListBox_GetText($lstPatchStatus, $hIndexLastEntry)

	  $aInfo = InetGetInfo($hDL)
	  Sleep(500)
	  $iPercent = Round($aInfo[0] / $iSize * 100)

	  $sDlPercentageText = "Downloading: " & $sName & " (" & $iPercent & " %)..."
	  _GUICtrlListBox_ReplaceString($lstPatchStatus, $hIndexLastEntry, $sDlPercentageText)
	  ControlCommand($MainGUI, "", $lstPatchStatus, "SelectString", $sDlPercentageText)

	  ;GUICtrlSetData($lstPatchStatus, "")
	  ;GUICtrlSetData($lstPatchStatus, "Downloading: " & $sName & " (" & $iPercent & " %)...")
   Until $aInfo[2]
   InetClose($hDL) ;Handle schließen um die Resourcen freizugeben

   ;retry once if filesizes differ
   If FileGetSize($sFileLocal) < $iSize Then
	  InstallMsg("Error Downloading: " & $sName)
	  InstallMsg("Re-Downloading: " & $sName)
	  $sURL = $sFileServer
	  $iSize = InetGetSize($sUrl)
	  $hDL = InetGet($sURL, $sFileLocal, 1, 1)
	  Do
		 $hIndexLastEntry = _GUICtrlListBox_GetCount($lstPatchStatus)-1
		 $sTextLastEntry = _GUICtrlListBox_GetText($lstPatchStatus, $hIndexLastEntry)

		 $aInfo = InetGetInfo($hDL)
		 Sleep(500)
		 $iPercent = Round($aInfo[0] / $iSize * 100)

		 $sDlPercentageText = "Re-Downloading: " & $sName & " (" & $iPercent & " %)..."
		 _GUICtrlListBox_ReplaceString($lstPatchStatus, $hIndexLastEntry, $sDlPercentageText)
		 ControlCommand($MainGUI, "", $lstPatchStatus, "SelectString", $sDlPercentageText)

		 ;GUICtrlSetData($lstPatchStatus, "")
		 ;GUICtrlSetData($lstPatchStatus, "Re-Downloading: " & $sName & " (" & $iPercent & " %)...")
	  Until $aInfo[2]
	  InetClose($hDL) ;Handle schließen um die Resourcen freizugeben
   EndIf

   ;if still not right -> Error Msg
   If FileGetSize($sFileLocal) < $iSize Then
	  DownloadError($sFileLocal, "missing")
   EndIf

   InstallMsg("done")
EndFunc

Func DownloadError($sErrorFile, $sErrorType = "missing")
   InstallMsg("Error Downloading: " & $sErrorFile)

   If $sErrorType = "size" Then
	  $errorMsg = "There seems to be a problem with the downloaded file. The filesize of the downloaded file differs from the source-file."
	  Debug("File Download Error: " & $errorMsg)
	  $query = MsgBox(20,"Filesize Error",$errorMsg & @CRLF & @CRLF & "Please visit: " & $AppWebsite & " to download the Offline-Installer." & @CRLF & @CRLF & "Do you want to open this URL now?")
	  If $query = 6 Then ShellExecute($AppWebsite)
	  Exit

   Else
	  $errorMsg = "There seems to be a problem with the downloaded file. The following file cannot be found: " & $sErrorFile
	  Debug("File Missing Error: " & $errorMsg)
	  $query = MsgBox(20,"File Missing",$errorMsg & @CRLF & @CRLF & "Please visit: " & $AppWebsite & " to download the Offline-Installer." & @CRLF & @CRLF & "Do you want to open this URL now?")
	  If $query = 6 Then ShellExecute($AppWebsite)
	  Exit

   EndIf
EndFunc
#EndRegion