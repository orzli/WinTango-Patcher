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
;Notepad2
$dirTemp = @ScriptDir & "\_tmp\Resources\files"
$dirSource = @ScriptDir & "\#THEME#\files"
$fileOut = "files-notepad2-#THEME#.7z"

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


;Desktops
$dirTemp = @ScriptDir & "\_tmp\Resources\files"
$dirSource = @ScriptDir & "\#THEME#\files"
$fileOut = "files-desktops-#THEME#.7z"

;_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tango")
;_RoutineByTheme($dirSource, $dirTemp, $fileOut, "tangerine")
;_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome")
;_RoutineByTheme($dirSource, $dirTemp, $fileOut, "cheser")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-brave")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-human")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-noble")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wine")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "gnome-wise")
;_RoutineByTheme($dirSource, $dirTemp, $fileOut, "elementary")
_RoutineByTheme($dirSource, $dirTemp, $fileOut, "humanity")
#EndRegion


;Images
_ActionImages("bitmaps")
_ActionImages("icons")

;Apps
_ActionApps() ;misc in one pak

DirRemove($TempDirMain, 1)

TrayTip("Done!", "The Resource Packages were successfully created!", 5, 1)
Sleep(5000)


Func _RoutineStd($dirSource, $dirTemp, $sFileOut)
   DirCreate($dirTemp)
   DirCopy($dirSource, $dirTemp, 1)
   _Compress($sFileOut)
   DirRemove($TempDirMain, 1)
EndFunc


Func _ActionImages($sType)
   $dirTemp = @ScriptDir & "\_tmp\Resources\" & $sType
   $dirSource = @ScriptDir & "\#THEME#\" & $sType
   $fileOut = $sType & "-#THEME#.7z"

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
EndFunc

Func _RoutineByTheme($dirSource, $dirTemp, $sFileOut, $sTheme)
   $dirSource = StringReplace($dirSource, "#THEME#", $sTheme)
   $sFileOut = StringReplace($sFileOut, "#THEME#", $sTheme)

   DirCreate($dirTemp)
   DirCopy($dirSource, $dirTemp, 1)

   ;specials
   If StringInStr($sFileOut, "notepad2") > 0 Then FileDelete($dirTemp & "\Desktops.exe")

   If StringInStr($sFileOut, "desktops") > 0 Then FileDelete($dirTemp & "\Notepad2-*.exe")

   If StringInStr($sFileOut, "bitmaps") > 0 Then
	  $dirTempShiki = @ScriptDir & "\_tmp\Resources\shiki"
	  If $sTheme = "humanity" Then
		 $dirSourceShiki = @ScriptDir & "\gnome-human\shiki"
	  ElseIf $sTheme = "tangerine" Then
		 $dirSourceShiki = @ScriptDir & "\gnome-human\shiki"
	  Else
		 $dirSourceShiki = @ScriptDir & "\" & $sTheme & "\shiki"
	  EndIf

	  DirCreate($dirTempShiki)
	  DirCopy(@ScriptDir & "\gnome-brave\shiki", $dirTempShiki, 1)
	  DirCopy($dirSourceShiki, $dirTempShiki, 1)
   EndIf

   ;Compress & Cleanup
   _Compress($sFileOut)
   DirRemove($TempDirMain, 1)
EndFunc


Func _ActionApps()
   $sTheme = "tango"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   _RoutineApps("office2010", $sTheme, 2, 1)
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "tangerine"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not TANGERINE
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   _RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   _RoutineApps("office2010", $sTheme, 2, 1)
   _RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   _RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "cheser"
   ;_RoutineApps("crystaldiskinfo", $sTheme, 2, 1) ;not CHESER
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   ;_RoutineApps("mpchc", $sTheme, 2, 1) ;not CHESER
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not CHESER
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   ;_RoutineApps("radiosure", $sTheme, 2, 1) ;not CHESER
   ;_RoutineApps("winyl", $sTheme, 2, 1) ;not CHESER

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome-brave"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not GNOME-COLORS
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome-human"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not GNOME-COLORS
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome-noble"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not GNOME-COLORS
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome-wine"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not GNOME-COLORS
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "gnome-wise"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   ;_RoutineApps("office2010", $sTheme, 2, 1) ;not GNOME-COLORS
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "elementary"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   _RoutineApps("office2010", $sTheme, 2, 1)
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("vlc", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)

   $sTheme = "humanity"
   _RoutineApps("crystaldiskinfo", $sTheme, 2, 1)
   ;_RoutineApps("foobar2000", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("gimp", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("inkscape", $sTheme, 2, 1) ;only GNOME
   ;_RoutineApps("libreoffice", $sTheme, 2, 1) ;only GNOME;CHESER
   _RoutineApps("mpchc", $sTheme, 2, 1)
   _RoutineApps("office2010", $sTheme, 2, 1)
   ;_RoutineApps("openoffice", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("pidgin", $sTheme, 2, 1)
   ;_RoutineApps("rainlendar", $sTheme, 2, 1) ;only GNOME
   _RoutineApps("utorrent", $sTheme, 2, 1)
   _RoutineApps("radiosure", $sTheme, 2, 1)
   _RoutineApps("winyl", $sTheme, 2, 1)

   _RoutineApps("aimp", $sTheme, 1, 1)
   _RoutineApps("smplayer", $sTheme, 1, 1)
   _RoutineApps("jdownloader", $sTheme, 1, 1)
   _RoutineApps("firefox", $sTheme, 1, 1)
   _RoutineApps("firefox-thunderbird", $sTheme, 2, 1)

   _Compress("theme-apps-" & $sTheme & ".7z")
   DirRemove($TempDirMain, 1)
EndFunc

Func _RoutineApps($sApp, $sTheme, $vRoutine = 1, $OnlyCopy = 0)
   $dirTemp = @ScriptDir & "\_tmp\Resources\themes\" & $sApp
   $dirSourceCommon = @ScriptDir & "\gnome\themes\" & $sApp
   $dirSourceCommonColors = @ScriptDir & "\gnome-brave\themes\" & $sApp
   $dirSourceCommonTango = @ScriptDir & "\tango\themes\" & $sApp
   $dirSourceCommonElementary = @ScriptDir & "\elementary\themes\" & $sApp
   $dirSource = @ScriptDir & "\" & $sTheme & "\themes\" & $sApp
   $fileOut = "theme-" & $sApp & "-" & $sTheme & ".7z"

   DirCreate($dirTemp)

   If $vRoutine = 2 Then
	  DirCopy($dirSourceCommon, $dirTemp, 1)
	  If $sTheme = "gnome-human" Then DirCopy($dirSourceCommonColors, $dirTemp, 1)
	  If $sTheme = "gnome-noble" Then DirCopy($dirSourceCommonColors, $dirTemp, 1)
	  If $sTheme = "gnome-wine" Then DirCopy($dirSourceCommonColors, $dirTemp, 1)
	  If $sTheme = "gnome-wise" Then DirCopy($dirSourceCommonColors, $dirTemp, 1)
	  If $sTheme = "humanity" Then DirCopy($dirSourceCommonElementary, $dirTemp, 1)
	  If $sTheme = "tangerine" Then DirCopy($dirSourceCommonTango, $dirTemp, 1)

	  ;Special
	  If $sApp = "firefox-thunderbird" Then FileDelete($dirTemp & "\*.xpi")

	  If $sApp = "radiosure" and $sTheme <> "gnome" Then DirRemove($dirTemp & "\skins\gnome.rsn", 1)
	  If $sApp = "radiosure" and $sTheme = "humanity" Then DirRemove($dirTemp & "\skins\elementary.rsn", 1)
	  If $sApp = "radiosure" and $sTheme = "tangerine" Then DirRemove($dirTemp & "\skins\tango.rsn", 1)

	  If $sApp = "winyl" and $sTheme <> "gnome" Then FileDelete($dirTemp & "\Flat Gnome.wzp")
	  If $sApp = "winyl" and $sTheme = "gnome-human" Then FileDelete($dirTemp & "\Flat Gnome-Brave.wzp")
	  If $sApp = "winyl" and $sTheme = "gnome-noble" Then FileDelete($dirTemp & "\Flat Gnome-Brave.wzp")
	  If $sApp = "winyl" and $sTheme = "gnome-wine" Then FileDelete($dirTemp & "\Flat Gnome-Brave.wzp")
	  If $sApp = "winyl" and $sTheme = "gnome-wise" Then FileDelete($dirTemp & "\Flat Gnome-Brave.wzp")
	  If $sApp = "winyl" and $sTheme = "humanity" Then FileDelete($dirTemp & "\elementary.wzp")
	  If $sApp = "winyl" and $sTheme = "tangerine" Then FileDelete($dirTemp & "\Flat Tango.wzp")

	  If $sApp = "crystaldiskinfo" and $sTheme = "elementary" Then DirRemove($dirTemp & "\Shiki-Colors", 1)
	  If $sApp = "crystaldiskinfo" and $sTheme = "humanity" Then DirRemove($dirTemp & "\elementary", 1)

	  DirCopy($dirSource, $dirTemp, 1)

   ElseIf $vRoutine = 1 Then
	  DirCopy($dirSource, $dirTemp, 1)

   EndIf

   ;Compress & Cleanup
   If $OnlyCopy = 0 Then _Compress($fileOut)
   If $OnlyCopy = 0 Then DirRemove($TempDirMain, 1)
EndFunc


Func _Compress($fileOut)
   $7zip_exe = @ScriptDir & "\7z.exe"

   $command = $7zip_exe & ' a -mx9 "' & $OutDir & '\' & $fileOut & '" "' & @ScriptDir & '\_tmp\Resources\*" -xr@exclude.txt'
   ;MsgBox(0,"",$command)

   ;RunWait(@ComSpec & ' /c ' & $command, "", @SW_HIDE)
   RunWait($command, @ScriptDir ,@SW_HIDE)

EndFunc