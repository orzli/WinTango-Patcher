If FileExists("x64") Then DirRemove("x64")
DirCreate("x64\options")


;standards
$search = FileFindFirstFile(@ScriptDir & "\*.txt")
While 1
   $file = FileFindNextFile($search)
   If @error Then ExitLoop
   GenScript($file)
WEnd
FileClose($search)

;options
$search = FileFindFirstFile(@ScriptDir & "\options\*.txt")
While 1
   $file = FileFindNextFile($search)
   If @error Then ExitLoop
   GenScript($file, "options\")
WEnd
FileClose($search)


;Simple Version
Func GenScript($fileIN, $subDIR = "")
   ;$fileIN = "ActionCenter.dll.txt"
   $fileNAME = StringTrimRight($fileIN, 4)
   $fileNAME = StringReplace($fileNAME, "noorb_", "")
   $fileNAME = StringReplace($fileNAME, "notray_", "")
   $fileNAME = StringReplace($fileNAME, "symbolic_", "")

   $ScriptData_OLD = FileRead(@ScriptDir & "\" & $subDIR & $fileIN)
   $ScriptData_NEW = StringReplace($ScriptData_OLD, "\" & $fileNAME, "\x64\" & $fileNAME, 2)

   $fileOUT = @ScriptDir & "\x64\" & $subDIR & $fileIN
   FileWrite($fileOUT, "")
   $fileOUT = FileOpen($fileOUT, 256+2) ;UTF-8 berücksichtigen und alten Inhalt löschen
   FileWrite($fileOUT, $ScriptData_NEW)
   FileClose($fileOUT)
EndFunc