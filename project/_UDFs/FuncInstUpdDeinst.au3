Func InstallMsg($Text)
   ;Status Box has to be called "lstPatchStatus" and the GUI "$MainGUI" to avoid script errors!

   ;$selEntry = GUICtrlRead($lstPatchStatus, 1) ;= zuletzt ausgewählter Eintrag
   $hIndexLastEntry = _GUICtrlListBox_GetCount($lstPatchStatus)-1
   $sTextLastEntry = _GUICtrlListBox_GetText($lstPatchStatus, $hIndexLastEntry)

   If $Text = "done" and StringInStr($sTextLastEntry, ">> done") = 0 Then
	  _GUICtrlListBox_ReplaceString($lstPatchStatus, $hIndexLastEntry, $sTextLastEntry & " >> done") ;add " >> done" to the last string
	  ControlCommand($MainGUI, "", $lstPatchStatus, "SelectString", $sTextLastEntry & " >> done")
	  Debug(GUICtrlRead($lstPatchStatus, 1)) ;neuen Eintrag weitergeben an Log

   ElseIf $Text <> $sTextLastEntry and $Text <> $sTextLastEntry & " >> done" Then
	  GUICtrlSetData($lstPatchStatus, $Text) ;write new Entry
	  ControlCommand($MainGUI, "", $lstPatchStatus, "SelectString", $Text)
	  Debug(GUICtrlRead($lstPatchStatus, 1)) ;neuen Eintrag weitergeben an Log

   ElseIf $sTextLastEntry = "" Then
	  GUICtrlSetData($lstPatchStatus, $Text) ;write new Entry
	  ControlCommand($MainGUI, "", $lstPatchStatus, "SelectString", $Text)
	  Debug(GUICtrlRead($lstPatchStatus, 1)) ;neuen Eintrag weitergeben an Log

   EndIf
EndFunc


Func InstallFile($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) Then
	  ;Display currently patching file
	  InstallMsg("Patching File: " & $TargetFolder & "\" & $FileName)

	  ;============================================================
	  ;Backup file
	  If FileExists($OverrideDir & "\" & $FileName) Then
		 ;do nothing - skip backup
	  Else
		 If FileExists($BackupDir & "\" & $FileName) Then
			;file exists, now we check system version against registered modified version
			$RegEntry = RegRead($AppRegPathFiles, $FileName)
			If $RegEntry = "" Then FileCopy($TargetFolder & "\" & $FileName, $BackupDir, 1);just in case it exists and we just didn't register it for some reason, recopy

			;check if file sizes differ
			If $RegEntry = FileGetSize($TargetFolder & "\" & $FileName) Then
			   ;sizes are the same...no need for another backup
			Else
			   FileCopy($TargetFolder & "\" & $FileName, $BackupDir, 1)
			EndIf
		 Else
			FileCopy($TargetFolder & "\" & $FileName, $BackupDir, 1)
		 EndIf
	  EndIf

	  ;============================================================
	  ;Modify file

	  ;Overriding Feature
	  If FileExists(@DesktopDir & "\Override\" & $FileName) Then
		 FileCopy(@DesktopDir & "\Override\" & $FileName, $OverrideDir & "\" & $FileName, 1)
		 FileCopy($OverrideDir & "\" & $FileName, $NewFilesDir & "\" & $FileName, 1)
	  Else
		 ;ResHacker
		 RunWait($ToolsDir & '\ResHacker.exe -script "' & $ResourcesDir & '\scripts\' & $FileName &'.txt"')
		 FileMove($ToolsDir & "\ResHacker.log", $LogsDir & "\" & $FileName & ".log", 1)
	  EndIf

	  ;write size to registry
	  $FileSize = FileGetSize($NewFilesDir & "\" & $FileName)
	  RegWrite($AppRegPathFiles, $FileName, "REG_SZ", $FileSize)

	  ;replace file in target folder
	  FileMove($NewFilesDir & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
	  MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName)

	  InstallMsg("done")
   EndIf
EndFunc

Func InstallFile64($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) Then
	  ;Display currently patching file
	  InstallMsg("Patching File: " & $TargetFolder & "\" & $FileName)

	  ;============================================================
	  ;Backup file
	  If FileExists($OverrideDir64 & "\" & $FileName) Then
		 ;do nothing - skip backup
	  Else
		 If FileExists($BackupDir64 & "\" & $FileName) Then
			;file exists, now we check system version against registered modified version
			$RegEntry = RegRead($AppRegPathFiles64, $FileName)
			If $RegEntry = "" Then FileCopy($TargetFolder & "\" & $FileName, $BackupDir64, 1);just in case it exists and we just didn't register it for some reason, recopy

			;check if file sizes differ
			If $RegEntry = FileGetSize($TargetFolder & "\" & $FileName) Then
			   ;sizes are the same...no need for another backup
			Else
			   FileCopy($TargetFolder & "\" & $FileName, $BackupDir64, 1)
			EndIf
		 Else
			FileCopy($TargetFolder & "\" & $FileName, $BackupDir64, 1)
		 EndIf
	  EndIf

	  ;============================================================
	  ;Modify file

	  ;Overriding Feature
	  If FileExists(@DesktopDir & "\Override\x64\" & $FileName) Then
		 FileCopy(@DesktopDir & "\Override\x64\" & $FileName, $OverrideDir64 & "\" & $FileName, 1)
		 FileCopy($OverrideDir64 & "\" & $FileName, $NewFilesDir64 & "\" & $FileName, 1)
	  Else
		 ;ResHacker
		 RunWait($ToolsDir & '\ResHacker.exe -script "' & $ResourcesDir & '\scripts\x64\' & $FileName &'.txt"')
		 FileMove($ToolsDir & "\ResHacker.log", $LogsDir64 & "\" & $FileName & ".log", 1)
	  EndIf

	  ;write size to registry
	  $FileSize = FileGetSize($NewFilesDir64 & "\" & $FileName)
	  RegWrite($AppRegPathFiles64, $FileName, "REG_SZ", $FileSize)

	  ;replace file in target folder
	  FileMove($NewFilesDir64 & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
	  MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName)

	  InstallMsg("done")
   EndIf

EndFunc

Func InstallTheme($App, $AppExePath, $TargetFolder, $FileToCopy, $ResFile)
   ;check if the app the theme is for is installed
   If FileExists($AppExePath) Then
	  ;Display currently patching file
	  InstallMsg("Installing Theme: " & $App)

	  ;create backup - only if needed
	  If FileExists($BackupDir & "\" & $FileToCopy) Then
		 ;file exists, now we check system version against registered modified version
		 $RegEntry = RegRead($AppRegPathFiles, $FileToCopy)
		 If $RegEntry = "" Then FileCopy($TargetFolder & "\" & $FileToCopy, $BackupDir, 1);just in case it exists and we just didn't register it for some reason, recopy

		 ;check if file sizes differ
		 If $RegEntry = FileGetSize($TargetFolder & "\" & $FileToCopy) Then
			;sizes are the same...no need for another backup
		 Else
			FileCopy($TargetFolder & "\" & $FileToCopy, $BackupDir, 1)
		 EndIf
	  Else
		 FileCopy($TargetFolder & "\" & $FileToCopy, $BackupDir, 1)
	  EndIf

	  ;write size to registry
	  $FileSize = FileGetSize($ResFile)
	  RegWrite($AppRegPathFiles, $FileToCopy, "REG_SZ", $FileSize)

	  ;replace file in target folder
	  FileCopy($ResFile, $TargetFolder & "\" & $FileToCopy, 1)

	  InstallMsg("done")
   EndIf
EndFunc

Func InstallVisualStyle($Name, $FileName)
   InstallMsg("Installing: " & $FileName & " Visual Style")

   $WindowsThemesDir = @WindowsDir & "\Resources\Themes"
   $DirDest = @WindowsDir & "\Resources\Themes\" & $Name
   $DirSource = $ResourcesDir & "\themes\Windows\" & $WinName
   $FileMain = $FileName & ".msstyles"

   ;Cleanup Old
   FileDelete(@WindowsDir & "\Resources\Themes\" & $Name & ".theme")
   DirRemove(@WindowsDir & "\Resources\Themes\" & $Name, 1)

   DirCreate(@WindowsDir & "\Resources\Themes\" & $Name & "\Shell\NormalColor")
   ;DirCreate(@WindowsDir & "\Resources\Themes\" & $Name & "\Shell\NormalColor\en-US")


;~    If FileExists($DirDest & "\" & $FileMain) Then ;main file may be locked, so replace after reboot
;~ 	  FileCopy($DirSource & "\" & $FileMain, $DirDest & "\" & $FileMain_new)
;~ 	  MoveEx($DirDest & "\" & $FileMain, $DirDest & "\" & $FileMain_new)
;~    EndIf

   ;Copy Files
   FileCopy($DirSource & "\*.theme", $WindowsThemesDir, 9)
   FileCopy($DirSource & "\*.msstyles", $DirDest, 9)
   If FileCopy($DirSource & "\" & $FileMain, $DirDest, 9) = 0 Then MoveEx($DirSource & "\" & $FileMain, $DirDest & "\" & $FileMain) ;main file may be locked (FileCopy = 0), then replace after reboot (MoveEx)
   If FileCopy($DirSource & "\shellstyle.dll", $DirDest & "\Shell\NormalColor", 9) = 0 Then MoveEx($DirSource & "\shellstyle.dll", $DirDest & "\Shell\NormalColor\shellstyle.dll")
   ;FileCopy($DirSource & "\shellstyle.dll.mui", $DirDest & "\Shell\NormalColor\en-US", 9)

   ;Fonts
   ;If $Name = "elementary" Then InstallFont($ResourcesDir & "\themes\Windows\Fonts\*.ttf")

EndFunc



Func UpdateFile($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) Then
	  ;If we didn't back it up, don't start modifying it now - Mr. User will have to reuse the installer. This ensures simplified perpetual ignorance of unselected options.
	  If FileExists($BackupDir & "\" & $FileName) Then

		 ;Check if file sizes differ
		 $RegEntry = RegRead($AppRegPathFiles, $FileName)
		 If FileExists($OverrideDir & "\" & $FileName) Then
			$File = $OverrideDir & "\" & $FileName
		 Else
			$File = $TargetFolder & "\" & $FileName
		 EndIf

		 If $RegEntry = FileGetSize($File) Then
			;sizes are the same...no need for reloading
		 Else
			;Display currently patching file
			If $SilentInstall = 0 Then InstallMsg("Reloading File: " & $TargetFolder & "\" & $FileName)

			;Backup file (if no override is present)
			If not FileExists($OverrideDir & "\" & $FileName) Then
			   FileCopy($TargetFolder & "\" & $FileName, $BackupDir, 1)
			   RunWait($ToolsDir & '\ResHacker.exe -script "' & $ResourcesDir & '\scripts\' & $FileName &'.txt"')
			   FileMove($ToolsDir & "\ResHacker.log", $LogsDir & "\" & $FileName & ".log", 1)
			Else
			   FileCopy($OverrideDir & "\" & $FileName, $NewFilesDir & "\" & $FileName, 1)
			EndIf

			;write new size to registry
			$FileSize = FileGetSize($NewFilesDir & "\" & $FileName)
			RegWrite($AppRegPathFiles, $FileName, "REG_SZ", $FileSize)

			;replace file in target folder
			FileMove($NewFilesDir & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
			If FileMove($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName, 1) = 0 Then
			   MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName) ;replace locked file on reboot
			   $UpdatedFileCount = $UpdatedFileCount + 1 ;tell the patcher to reboot
			EndIf

			If $SilentInstall = 0 Then InstallMsg("done")


			;Special: also reload theme, which may got deleted when re-installing the app
			If $FileName = "SMPlayer.exe" Then ReThemeSMPlayer($ProgramFiles)
		 EndIf
	  EndIf
   EndIf
EndFunc

Func UpdateFile64($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) Then
	  ;If we didn't back it up, don't start modifying it now - Mr. User will have to reuse the installer. This ensures simplified perpetual ignorance of unselected options.
	  If FileExists($BackupDir64 & "\" & $FileName) Then

		 ;Check if file sizes differ
		 $RegEntry = RegRead($AppRegPathFiles64, $FileName)
		 If FileExists($OverrideDir64 & "\" & $FileName) Then
			$File = $OverrideDir64 & "\" & $FileName
		 Else
			$File = $TargetFolder & "\" & $FileName
		 EndIf

		 If $RegEntry = FileGetSize($File) Then
			;sizes are the same...no need for reloading
		 Else
			;Display currently patching file
			If $SilentInstall = 0 Then InstallMsg("Reloading File: " & $TargetFolder & "\" & $FileName)

			;Backup file (if no override is present)
			If not FileExists($OverrideDir64 & "\" & $FileName) Then
			   FileCopy($TargetFolder & "\" & $FileName, $BackupDir64, 1)
			   RunWait($ToolsDir & '\ResHacker.exe -script "' & $ResourcesDir & '\scripts\x64\' & $FileName &'.txt"')
			   FileMove($ToolsDir & "\ResHacker.log", $LogsDir64 & "\" & $FileName & ".log", 1)
			Else
			   FileCopy($OverrideDir64 & "\" & $FileName, $NewFilesDir64 & "\" & $FileName, 1)
			EndIf

			;write new size to registry
			$FileSize = FileGetSize($NewFilesDir64 & "\" & $FileName)
			RegWrite($AppRegPathFiles64, $FileName, "REG_SZ", $FileSize)

			;replace file in target folder
			FileMove($NewFilesDir64 & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
			If FileMove($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName, 1) = 0 Then
			   MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName) ;replace locked file on reboot
			   $UpdatedFileCount = $UpdatedFileCount + 1 ;tell the patcher to reboot
			EndIf

			If $SilentInstall = 0 Then InstallMsg("done")


			;Special: also reload theme, which may got deleted when re-installing the app
			If $FileName = "SMPlayer.exe" Then ReThemeSMPlayer($ProgramFiles64)
		 EndIf
	  EndIf
   EndIf
EndFunc

Func UpdateTheme($App, $AppExePath, $TargetFolder, $FileToCopy, $ResFile)
   If FileExists($AppExePath) Then
	  ;If we didn't back it up, don't start modifying it now - Mr. User will have to reuse the installer. This ensures simplified perpetual ignorance of unselected options.
	  If FileExists($BackupDir & "\" & $FileToCopy) Then

		 ;Check if file sizes differ
		 $RegEntry = RegRead($AppRegPathFiles, $FileToCopy)

		 If $RegEntry = FileGetSize($TargetFolder & "\" & $FileToCopy) Then
			;sizes are the same...no need for reloading
		 Else
			;Display currently patching file
			If $SilentInstall = 0 Then
			   InstallMsg("Reloading Theme: " & $App)
			EndIf

			;Backup file
			FileCopy($TargetFolder & "\" & $FileToCopy, $BackupDir, 1)

			;write new size to registry
			$FileSize = FileGetSize($ResFile)
			RegWrite($AppRegPathFiles, $FileToCopy, "REG_SZ", $FileSize)

			;replace file in target folder
			If FileCopy($ResFile, $TargetFolder & "\" & $FileToCopy, 1) = 0 Then
			   MoveEx($ResFile, $TargetFolder & "\" & $FileToCopy) ;replace locked file on reboot
			   $UpdatedFileCount = $UpdatedFileCount + 1 ;tell the patcher to reboot
			EndIf

			If $SilentInstall = 0 Then
			   InstallMsg("done")
			EndIf
		 EndIf
	  EndIf
   EndIf
EndFunc



Func UninstallFile($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) and FileExists($BackupDir & "\" & $FileName) Then
	  ;Display currently patching file
	  InstallMsg("Restoring File: " & $TargetFolder & "\" & $FileName)

	  ;Delete file size from registry
	  RegDelete($AppRegPathFiles, $FileName)

	  ;Cleanup logs
	  FileDelete($LogsDir & "\" & $FileName & ".log")

	  ;replace file in target folder
	  FileMove($BackupDir & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
	  MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName)

	  InstallMsg("done")
   EndIf
EndFunc

Func UninstallFile64($FileName, $TargetFolder)
   If FileExists($TargetFolder & "\" & $FileName) and FileExists($BackupDir64 & "\" & $FileName) Then
	  ;Display currently patching file
	  InstallMsg("Restoring File: " & $TargetFolder & "\" & $FileName)

	  ;Delete file size from registry
	  RegDelete($AppRegPathFiles64, $FileName)

	  ;Cleanup logs
	  FileDelete($LogsDir64 & "\" & $FileName & ".log")

	  ;replace file in target folder
	  FileMove($BackupDir64 & "\" & $FileName, $TargetFolder & "\" & $FileName & ".xpize", 1)
	  MoveEx($TargetFolder & "\" & $FileName & ".xpize", $TargetFolder & "\" & $FileName)

	  InstallMsg("done")
   EndIf
EndFunc

Func UninstallTheme($App, $AppExePath, $TargetFolder, $FileToCopy, $ResFile)
   If FileExists($AppExePath) and FileExists($BackupDir & "\" & $FileToCopy) Then
	  ;Display currently patching file
	  InstallMsg("Restoring Theme: " & $App)

	  ;Delete file size from registry
	  RegDelete($AppRegPathFiles64, $FileToCopy)

	  ;replace file in target folder
	  FileMove($BackupDir & "\" & $FileToCopy, $TargetFolder & "\" & $FileToCopy, 1)

	  InstallMsg("done")
   EndIf
EndFunc