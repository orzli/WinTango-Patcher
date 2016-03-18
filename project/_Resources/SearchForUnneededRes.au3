#include <Array.au3>

;Skripte einlesen
$ScriptsDir = @ScriptDir & "\scripts\"
$ScriptsDir64 = @ScriptDir & "\scripts\x64\"

Global $data = ""

_Search($ScriptsDir)
_Search($ScriptsDir64)

If FileExists("output.txt") Then FileDelete("output.txt")
FileWrite("output.txt", $data)
;ShellExecute("output.txt")

;unique
$output = FileOpen("output.txt")
$aContentOutput = FileReadToArray($output)
FileClose($output)
FileDelete("output.txt")

$aContentOutput = _ArrayUnique($aContentOutput, "", 0)
_ArraySort($aContentOutput, 0, 1)

$dataUnique = ""
For $k = 1 to $aContentOutput[0]
   If $aContentOutput[$k] <> "" Then
	  If $k = $aContentOutput[0] Then
		 $dataUnique &= $aContentOutput[$k]
	  Else
		 $dataUnique &= $aContentOutput[$k] & @LF
	  EndIf
   EndIf
Next

If FileExists("UsedFiles.txt") Then FileDelete("UsedFiles.txt")
FileWrite("UsedFiles.txt", $dataUnique)
;ShellExecute("UsedFiles.txt")



;Resourcen einlesen
Global $theme = "gnome" ; = basic theme

;get Files
$aReturn = _RecursiveFileListToArray(@ScriptDir & "\" & $theme, "\.png\z|\.bmp\z|\.ico\z", 0) ;"\.png\z|\.svg\z"
;_ArrayDisplay($aReturn)
_ArraySort($aReturn, 0, 1)

$data = ""
For $k = 1 to $aReturn[0]
   $data &= $aReturn[$k] & @LF
Next

If FileExists("file_index.txt") Then FileDelete("file_index.txt")
FileWrite("file_index.txt", $data)
;ShellExecute("file_index.txt")



;Diff Skripte vs. Resourcen
$res_used = FileOpen("UsedFiles.txt")
$a_res_used = FileReadToArray($res_used)

$res = FileOpen("file_index.txt")
$a_res = FileReadToArray($res)


For $a = UBound($a_res) - 1 To 0 Step -1
    For $b = 0 To UBound($a_res_used) - 1
        If $a_res[$a] = $a_res_used[$b] or StringInStr($a_res[$a], "basebrd.dll") > 0 or StringInStr($a_res[$a], "\themes\") > 0 or StringInStr($a_res[$a], "\symbolic\") > 0 Then
            _ArrayDelete($a_res, $a)
            ExitLoop
        EndIf
    Next
Next


FileDelete("file_index.txt")
FileDelete("UsedFiles.txt")
_ArrayDisplay($a_res, "Unneeded files")



;=========================================================================================================
; Function Name:   _RecursiveFileListToArray($sPath, $sPattern, $iFlag = 0, $iFormat = 1, $sDelim = @CRLF)
; Description::    gibt Verzeichnisse und/oder Dateien (rekursiv) zurück, die
;                  einem RegExp-Pattern entsprechen
; Parameter(s):    $sPath = Startverzeichnis
;                  $sPattern = ein beliebiges RexExp-Pattern für die Auswahl
;                  $iFlag = Auswahl
;                           0 = Dateien & Verzeichnisse
;                           1 = nur Dateien
;                           2 = nur Verzeichnisse
;                  $iFormat = Rückgabeformat
;                             0 = String
;                             1 = Array mit [0] = Anzahl
;                             2 = Nullbasiertes Array
;                  $sDelim = Trennzeichen für die String-Rückgabe
; Requirement(s):  AutoIt 3.3.0.0
; Return Value(s): Array/String mit den gefundenen Dateien/Verzeichnissen
; Author(s):       Oscar (www.autoit.de)
;                  Anregungen von: bernd670 (www.autoit.de)
;=========================================================================================================
;Quelle: http://www.autoit.de/index.php?page=Thread&threadID=12423&highlight=_RecursiveFileListToArray
Func _RecursiveFileListToArray($sPath, $sPattern, $iFlag = 0, $iFormat = 1, $sDelim = @CRLF)
    Local $hSearch, $sFile, $sReturn = ''
    If StringRight($sPath, 1) <> '\' Then $sPath &= '\'
    $hSearch = FileFindFirstFile($sPath & '*.*')
    If @error Or $hSearch = -1 Then Return SetError(1, 0, $sReturn)
    While True
        $sFile = FileFindNextFile($hSearch)
        If @error Then ExitLoop
        If StringInStr(FileGetAttrib($sPath & $sFile), 'D') Then
            If StringRegExp($sPath & $sFile, $sPattern) And ($iFlag = 0 Or $iFlag = 2) Then $sReturn &= $sPath & $sFile & '\' & $sDelim
            $sReturn &= _RecursiveFileListToArray($sPath & $sFile & '\', $sPattern, $iFlag, 0)
            ContinueLoop
        EndIf
        If StringRegExp($sFile, $sPattern) And ($iFlag = 0 Or $iFlag = 1) Then $sReturn &= StringReplace($sPath & $sFile & $sDelim, @ScriptDir & "\" & $theme, "Resources") ;$sPath & $sFile & $sDelim
    WEnd
    FileClose($hSearch)
    If $iFormat Then Return StringSplit(StringTrimRight($sReturn, StringLen($sDelim)), $sDelim, $iFormat)

    Return $sReturn
 EndFunc




 ;Scripts Einlesen
Func _Search($dir)

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

	  _Action($ScriptsDir & $sFileName)
   WEnd

   ; Close the search handle.
   FileClose($hSearch)

EndFunc


Func _Action($file)

   $script = FileOpen($file)
   $aContent = FileReadToArray($script)
   ;_ArrayDisplay($aContent)
   FileClose($script)

   $used_files = ""
   For $i = 0 to UBound($aContent)-1
	  If StringInStr($aContent[$i], "-modify") > 0 Then
		 $string = StringSplit(StringReplace($aContent[$i], "-modify ", ""), ",")
		 ;_ArrayDisplay($string)

		 $used_files &= $string[1] & "|"
	  EndIf
   Next
   $used_files = StringTrimRight($used_files, 1)

   $aUsedFiles = StringSplit($used_files, "|")
   $aUsedFiles = _ArrayUnique($aUsedFiles, "", 1)
   ;_ArrayDisplay($aUsedFiles)

   For $j = 1 to $aUsedFiles[0]
	  $data &= $aUsedFiles[$j] & @LF
   Next

EndFunc