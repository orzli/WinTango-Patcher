Func _CheckForUpdate()
   Local $sVerLatest[2]
   ;[0] = Version
   ;[1] = URL

   ;Check Database for new Version
   $sUrl = $FilesURL & "/v0.0/LatestVersion.ini"
   $sDest = @TempDir & "\LatestVersion.ini"
   If FileExists($sDest) Then FileDelete($sDest)

   InetGet($sUrl,$sDest) ;Download the Infofile

   $sData = IniRead($sDest, "Updater", "MainApp", "") ;Version Latest
   $sVer = RegRead($AppRegKey, "Version") ;Version Installed

   If $sData = "" Then
	  ;MsgBox(0, "error", "download error")
	  $sVerLatest[0] = $sVer

   ElseIf $sData <> $sVer Then
	  $sUrlChangelog = $FilesURL & "/v" & $sData & "/Changelog.txt"
	  $sDestChangelog = @ScriptDir & "\Changelog.txt"
	  If FileExists($sDestChangelog) Then FileDelete($sDestChangelog)

	  InetGet($sUrlChangelog,$sDestChangelog) ;Download Changelog to view

	  $sVerLatest[0] = $sData

   ElseIf $sData = $sVer Then
	  $sVerLatest[0] = $sVer

   EndIf

   $sVerLatest[1] = IniRead($sDest, "Updater", "URL", "") ;URL for Installer
   $sVerLatest[2] = IniRead($sDest, "Updater", "URL2", "") ;URL for Installer (Mirror)

   FileDelete($sDest) ;Delete the Infofile

   Return $sVerLatest ;Return Latest Version Number
EndFunc


Func _DownloadLatestVersion($sUrl, $sDest)
   ;Progressbar muss "prgbarUpdate" heissen, damit es keine Fehler gibt!

   If FileExists($sDest) Then FileDelete($sDest)

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
	  Run($sDest)
   Else
	  $errorMsg = "There seems to be a problem with the downloaded file. The following file cannot be found: " & $sDest
	  $query = MsgBox(20,"File Missing",$errorMsg & @CRLF & @CRLF & "Please visit: " & $AppWebsite & " to manually download the Installer." & @CRLF & @CRLF & "Do you want to open this URL now?")
	  If $query = 6 Then ShellExecute($AppWebsite)
   EndIf
EndFunc