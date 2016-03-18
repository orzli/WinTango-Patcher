#include <Array.au3>

;Skripte
Global $ScriptsDir = @ScriptDir & "\scripts\"
Global $data = ""

$query = InputBox("Search in Scripts", "Please enter the string you want to search for:", "")
If @error = 1 Then Exit

_Search($ScriptsDir, $query)

MsgBox(0, "Search Result", $data)


 ;Scripts Einlesen
Func _Search($dir, $query)

   ; Assign a Local variable the search handle of all files in the current directory.
   Local $hSearch = FileFindFirstFile($dir & "*.txt")

   ; Check if the search was successful, if not display a message and return False.
   If $hSearch = -1 Then
	  MsgBox($MB_SYSTEMMODAL, "", "Error: No files/directories matched the search pattern.")
	  Return False
   EndIf

   ; Assign a Local variable the empty string which will contain the files names found.
   Local $sFileName = ""

   While 1
	  $sFileName = FileFindNextFile($hSearch)
	  ; If there is no more file matching the search.
	  If @error Then ExitLoop

	  _Action($ScriptsDir & $sFileName, $sFileName, $query)
   WEnd

   ; Close the search handle.
   FileClose($hSearch)

EndFunc


Func _Action($file, $filename, $query)

   $script = FileOpen($file)
   $content = FileRead($script)
   FileClose($script)

   $matching_files = ""
   If StringInStr($content, $query) > 0 Then $matching_files &= $filename & "|"


   $a_matching_files = StringSplit($matching_files, "|")
   $a_matching_files = _ArrayUnique($a_matching_files, "", 1)
   ;_ArrayDisplay($a_matching_files)

   For $j = 1 to $a_matching_files[0]
	  If $a_matching_files[$j] <> "" Then $data &= $a_matching_files[$j] & @LF
   Next

EndFunc