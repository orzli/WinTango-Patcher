Func _CheckForUpdate()
   $sVerLatest = ""

   ;Check Database for new Version
   $sUrl = $FilesURL & "/LatestVersion.ini"
   $sDest = @TempDir & "\LatestVersion.ini"

   InetGet($sUrl,$sDest) ;Download the Infofile

   $sData = IniRead($sDest, "Updater", "MainApp", "") ;Version Latest
   $sVer = RegRead($AppRegKey, "Version") ;Version Installed

   $sUpdatedPaks = IniRead($sDest, "Updater", "UpdatedPaks", "all")

   FileDelete($sDest) ;Delete the Infofile

   If $sData <> $sVer Then
	  $sUrlChangelog = $FilesURL & "/Changelog.txt"
	  $sDestChangelog = @ScriptDir & "\Changelog.txt"

	  InetGet($sUrlChangelog,$sDestChangelog) ;Download Changelog to view

	  RegWrite($AppRegKey, "UpdatedPaks", "REG_SZ", $sUpdatedPaks) ;Tell the patcher which files are new

	  $sVerLatest = $sData

   ElseIf $sData = $sVer Then
	  $sVerLatest = $sVer

   EndIf

   Return $sVerLatest ;Return Latest Version Number
EndFunc


Func _DownloadLatestVersion($sUrl, $sDest)
   ;Progressbar muss "prgbarUpdate" heissen, damit es keine Fehler gibt!

   $iSize = InetGetSize($sUrl)
   $hDL = InetGet($sURL, $sDest, 1, 1)

   Do
	  $aInfo = InetGetInfo($hDL)
	  Sleep(500)
	  $iPercent = Round($aInfo[0] / $iSize * 100,2)

	  If $iPercent <> GUICtrlRead($prgbarUpdate) Then
		 If $iSize = 0 and $aInfo[1] <> 0 Then $iSize = $aInfo[1]
		 GUICtrlSetData($prgbarUpdate,$iPercent)
	  EndIf
   Until $aInfo[2]

   InetClose($hDL) ;Handle schlieﬂen um die Resourcen freizugeben
EndFunc


Func _RunDownload($sDest)
   If FileExists($sDest) Then
	  RunWait($ToolsDir & '\7z.exe x -yo"' & @TempDir & '" "' & $sDest & '"', @ScriptDir ,@SW_HIDE)
	  Run(StringTrimRight($sDest, 2) & "exe")
   Else
	  $errorMsg = "There seems to be a problem with the downloaded file. The following file cannot be found: " & $sDest
	  $query = MsgBox(20,"File Missing",$errorMsg & @CRLF & @CRLF & "Please visit: " & $AppWebsite & " to manually download the Installer." & @CRLF & @CRLF & "Do you want to open this URL now?")
	  If $query = 6 Then ShellExecute($AppWebsite)
   EndIf
EndFunc