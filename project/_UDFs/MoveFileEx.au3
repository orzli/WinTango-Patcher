
;MoveEx - Replace files on reboot
Func MoveEx($OldFile, $NewFile)
   ;Replace a File: MoveEx("oldfile", "newfile")
   ;Delete a File: MoveEx("oldfile", "")

   If RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations") = 0 Then
	  RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "")
   EndIf

   $MoveExData = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations")

   If $MoveExData = "" Then
	  If $NewFile = "" Then ;delete a file
		 RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", "\??\" & $OldFile & @LF & $NewFile)
	  Else ;append new renames
		 RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", "\??\" & $OldFile & @LF & "!\??\" & $NewFile)
	  EndIf

   Else
	  If $NewFile = "" Then ;delete a file
		 RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $MoveExData & @LF & "\??\" & $OldFile & @LF & $NewFile)
	  Else ;append new renames
		 RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager", "PendingFileRenameOperations", "REG_MULTI_SZ", $MoveExData & @LF & "\??\" & $OldFile & @LF & "!\??\" & $NewFile)
	  EndIf
   EndIf

 EndFunc




 ;=================================================================================================================
 ;Specials
 ;=================================================================================================================

 #Region Clear Icon- & Thumbnail-Cache
Func ClearIconCache()
   ;Deletes all the cache files on reboot for proper display of changed resources
   ;Usage: just call the function

   $Path = @HomeDrive & "\Users"
   $cSep = "|"
   $usersReal = ""

   $aFileList = _FileListToArray($Path, "*")

   If IsArray($aFileList) Then
	  For $j = 1 to $aFileList[0]
		 $usersReal &= $aFileList[$j] & $cSep
	  Next
   EndIf

   $usersReal = StringReplace($usersReal, "All Users|", "")
   $usersReal = StringReplace($usersReal, "Default User|", "")
   $usersReal = StringReplace($usersReal, "Default|", "")
   $usersReal = StringReplace($usersReal, "Public|", "")
   $usersReal = StringReplace($usersReal, "UpdatusUser|", "")
   $usersReal = StringReplace($usersReal, "desktop.ini|", "")

   $user = StringSplit($usersReal, $cSep)

   If IsArray($user) Then
	  For $i = 1 to $user[0]
		 If not $user[$i] = "" Then
			ClearIconCacheRoutine($user[$i])
		 EndIf
	  Next
   Else
	  ClearIconCacheRoutine(@UserName)
   EndIf
EndFunc

Func ClearIconCacheRoutine($Profile)
   MoveEx(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\IconCache.db", "")

   ;IconCache
   $search = FileFindFirstFile(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\iconcache_*.db")
   While 1
	  $file = FileFindNextFile($search)
	  If @error Then ExitLoop
	  MoveEx(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\" & $file, "")
   WEnd
   FileClose($search)

   ;Thumbcache
   $search = FileFindFirstFile(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db")
   While 1
	  $file = FileFindNextFile($search)
	  If @error Then ExitLoop
	  MoveEx(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\" & $file, "")
   WEnd
   FileClose($search)

   ;TileCache
   $search = FileFindFirstFile(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\TileCache*.dat")
   While 1
	  $file = FileFindNextFile($search)
	  If @error Then ExitLoop
	  MoveEx(@HomeDrive & "\Users\" & $Profile & "\AppData\Local\Microsoft\Windows\Explorer\" & $file, "")
   WEnd
   FileClose($search)
EndFunc
#EndRegion