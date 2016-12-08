#cs ----------------------------------------------------------------------------

 Build Resource Packages for the WinTango Patcher.

#ce ----------------------------------------------------------------------------

Global $TempDirMain = @ScriptDir & "\_tmp"
Global $OutDir = @ScriptDir & "\_ARCHIVES"

FileDelete($OutDir & "\*.7z")
DirRemove($TempDirMain, 1)
DirCreate($OutDir)


#Region Standards
;Scripts
$dirTemp = @ScriptDir & "\_tmp\Resources\scripts"
$dirSource = @ScriptDir & "\scripts"
$fileOut = "scripts.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)


;Cursors
$dirTemp = @ScriptDir & "\_tmp\Resources\themes\Windows\Cursors"

;Ubuntu
$dirSource = @ScriptDir & "\_Cursors\ubuntu"
$fileOut = "cursors-ubuntu.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)

;elementary
$dirSource = @ScriptDir & "\_Cursors\elementary"
$fileOut = "cursors-elementary.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)


;Visual Style
$dirTemp = @ScriptDir & "\_tmp\Resources\themes\Windows"

;Shiki-Colors
$dirSource = @ScriptDir & "\_VisualStyles\shiki-colors"
$fileOut = "visualstyle-shikicolors.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)

;elementaryOS
$dirSource = @ScriptDir & "\_VisualStyles\elementary"
$fileOut = "visualstyle-elementary.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)

;Ubuntu
$dirSource = @ScriptDir & "\_VisualStyles\ubuntu"
$fileOut = "visualstyle-ubuntu.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)


;Wallpapers
$dirTemp = @ScriptDir & "\_tmp\Resources\themes\Windows\Wallpapers"
$dirSource = @ScriptDir & "\_Wallpapers"
$fileOut = "wallpapers.7z"

_RoutineStd($dirSource, $dirTemp, $fileOut)
#EndRegion


#Region Files
;Files
$dirTemp = @ScriptDir & "\_tmp\Resources\files"
$dirSource = @ScriptDir & "\#THEME#\files"
$fileOut = "files-#THEME#.7z"

_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tango")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tangerine")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "cheser")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-brave")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-human")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-noble")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wine")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wise")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "elementary")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "humanity")
#EndRegion


#Region Resources
$dirTemp = @ScriptDir & "\_tmp\Resources"
$dirSource = @ScriptDir & "\#THEME#"
$fileOut = "res-#THEME#.7z"

_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tango")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tangerine")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "cheser")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-brave")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-human")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-noble")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wine")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wise")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "elementary")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "humanity")
#EndRegion


DirRemove($TempDirMain, 1)

TrayTip("Done!", "The Resource Packages were successfully created!", 5, 1)
Sleep(5000)


Func _RoutineStd($dirSource, $dirTemp, $sFileOut)
   DirCreate($dirTemp)
   DirCopy($dirSource, $dirTemp, 1)
   _Compress($sFileOut)
   DirRemove($TempDirMain, 1)
EndFunc


Func _RoutineByTheme($dirSource, $dirTemp, $sFileOut, $sTheme)
   $dirSource = StringReplace($dirSource, "#THEME#", $sTheme)
   $sFileOut = StringReplace($sFileOut, "#THEME#", $sTheme)

   DirCreate($dirTemp)
   DirCopy($dirSource, $dirTemp, 1)

   ;specials
   If StringInStr($sFileOut, "res-") > 0 Then
	  DirRemove($dirTemp & "\_WIP", 1)
	  DirRemove($dirTemp & "\files", 1)
   EndIf

   ;Compress & Cleanup
   _Compress($sFileOut)
   DirRemove($TempDirMain, 1)
EndFunc

Func _Compress($fileOut)
   $7zip_exe = @ScriptDir & "\7z.exe"

   $command = $7zip_exe & ' a -mx9 "' & $OutDir & '\' & $fileOut & '" "' & @ScriptDir & '\_tmp\Resources\*" -xr@exclude.txt'
   ;MsgBox(0,"",$command)

   ;RunWait(@ComSpec & ' /c ' & $command, "", @SW_HIDE)
   RunWait($command, @ScriptDir ,@SW_HIDE)

EndFunc