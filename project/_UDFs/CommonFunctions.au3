#cs ----------------------------------------------------------------------------

 Author:         Various

 Script Function:
	Collection of multiple Functions to use inside any AutoIt Project.

#ce ----------------------------------------------------------------------------


;Check for running Tasks
Func CheckAndCloseProcess($ProcessName, $ProcessAppName, $vClosingTimeout = 10)
   ;Usage: CheckAndCloseProcess("Name of the Process as its found in the TaskManager", "Full AppName for the Dialog")
   ;Example: CheckAndCloseProcess("firefox.exe", "Mozilla Firefox")

   ;Localization
   $s_OSLangNumeric = StringRight(@OSLang, 2) ; @OSLang is four characters in length, the first two is the dialect and the remaining is the language.
   If $s_OSLangNumeric = "07" Then ;German
	  $s_MsgBox_Title = "Schließe " & $ProcessAppName
	  $s_MsgBox_Line1 = "Bitte schließen Sie alle Instanzen von " & $ProcessAppName & ", um Datenverlust zu vermeiden. In " & $vClosingTimeout & " Sekunden werden automatich alle Instanzen der Anwendung geschlossen!"
	  $s_MsgBox_Line2 = "Möchten Sie die Anwendung nun schließen?"
   Else ;English
	  $s_MsgBox_Title = "Closing " & $ProcessAppName
	  $s_MsgBox_Line1 = "Please close all instances of " & $ProcessAppName & " to prevent loss of data. All tasks will be closed automatically in " & $vClosingTimeout & " seconds!"
	  $s_MsgBox_Line2 = "Do you want to close the application now?"
   EndIf

   ;The Action
   If ProcessExists($ProcessName) Then
	  $task = MsgBox(49, $s_MsgBox_Title, $s_MsgBox_Line1 & @CRLF & @CRLF & $s_MsgBox_Line2, $vClosingTimeout)
	  If $task = -1 Then ;Time is up
		 ProcessClose($ProcessName)
	  ElseIf $task = 1 Then ;Yes
		 ProcessClose($ProcessName)
	  ElseIf $task = 2 Then ;No
		 ;Do nothing, leave the process alive
	  EndIf
   EndIf
EndFunc


;Search for Strings in Array
Func _StringInArray($a_Array, $s_String)
   ;Usage: If _StringInArray($Array, "String to Search") is true Then do XY
   ;Example: If _StringInArray($CmdLine, '/silent') Then $Silentmode = 1

   Local $i_ArrayLen = UBound($a_Array) - 1
   For $i = 0 To $i_ArrayLen
	  If $a_Array[$i] = $s_String Then
		 Return $i
	  EndIf
   Next
   SetError(1)
   Return 0
 EndFunc   ;==>_StringInArray


;Install one or more Fonts
Func InstallFont($sSourceFile, $sFontDescript="", $sFontsPath="")
   ;Example: InstallFont("C:\Fonts\*.*")

   Local Const $HWND_BROADCAST = 0xFFFF
   Local Const $WM_FONTCHANGE = 0x1D

   If $sFontsPath = "" Then $sFontsPath = @WindowsDir & "\fonts"

   Local $sFontName = StringRegExpReplace($sSourceFile, "^.*\\", "")
   If Not FileCopy($sSourceFile, $sFontsPath & "\" & $sFontName, 1) Then Return SetError(1, 0, 0)

   Local $hSearch = FileFindFirstFile($sSourceFile)
   Local $iFontIsWildcard = StringRegExp($sFontName, "\*|\?")
   Local $aRet, $hGdi32_DllOpen = DllOpen("gdi32.dll")

   If $hSearch = -1 Then Return SetError(2, 0, 0)
   If $hGdi32_DllOpen = -1 Then Return SetError(3, 0, 0)

   While 1
	  $sFontName = FileFindNextFile($hSearch)
	  If @error Then ExitLoop

	  If $iFontIsWildcard Then $sFontDescript = StringRegExpReplace($sFontName, "\.[^\.]*$", "")

	  $aRet = DllCall($hGdi32_DllOpen, "Int", "AddFontResource", "str", $sFontsPath & "\" & $sFontName)
	  If IsArray($aRet) And $aRet[0] > 0 Then
		 RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", $sFontDescript, "REG_SZ", $sFontsPath & "\" & $sFontName)
	  EndIf
   WEnd

   DllClose($hGdi32_DllOpen)
   DllCall("user32.dll", "Int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_FONTCHANGE, "int", 0, "int", 0)
   Return 1
EndFunc


;Write Debug File
Func Debug($Text)
   $DebugFileName = @ScriptDir & "\" & $Modus & ".log"
   $DebugTextNew = $Text
   If FileExists($DebugFileName) Then
	  $DebugFile = FileOpen($DebugFileName,1)
	  $sData = $DebugTextNew & @CRLF
	  FileWrite($DebugFile, $sData)
	  FileClose($DebugFile)
   Else
	  FileWrite($DebugFileName, "")
	  $DebugFile = FileOpen($DebugFileName,1)
	  $sData = "Patcher Version: " & $AppVersion & @CRLF & _
			   "Theme: " & $SelectedTheme & @CRLF & _
			   @CRLF & _
			   "Windows: " & $WinName & " (" & $OsArch & ")" & @CRLF & _
			   "Language : " & @OSLang & @CRLF & _
			   "Program Files Dirs: " & $ProgramFiles & " | " & $ProgramFiles64 & @CRLF & _
			   ".NET Framework: " & _GetInstalledDotNetVersions() & @CRLF & _
			   @CRLF & _
			   $DebugTextNew & @CRLF
	  FileWrite($DebugFile, $sData)
	  FileClose($DebugFile)
   EndIf
EndFunc


#Region Gather Information
;Check IE Version
Func _IE_Version()
   $DllVer = FileGetVersion(@SystemDir & "\mshtml.dll")
   $DllVer = StringSplit($DllVer, ".")

   $IEVer = $DllVer[1]

   Return $IEVer
EndFunc


;Check NET Framework Version
Func _GetInstalledDotNetVersions()
   $verNETFramework = ""
   Local $result[1]

   For $i= 1 to 10
	  $tmp = RegEnumKey("HKLM\Software\Microsoft\.NETFramework", $i)
	  If @error <> 0 then ExitLoop
	  If StringLeft($tmp, 1) = "v" Then
	  $tmp = StringTrimLeft($tmp, 1)
	  _ArrayAdd($result, $tmp)
	  EndIf
   Next

   $verNETFramework = _ArrayMax($result,0)

   Return $verNETFramework
EndFunc


;Check OS Language
Func _GetOSLanguage()
   Local $OSLang = ""

   $iOSLang = StringRight(@OSLang, 2) ; @OSLang is four characters in length, the first two is the dialect and the remaining is the language.

   If $iOSLang = "07" Then ;Deutsch
	  $OSLang = "DE"
   ElseIf $iOSLang = "04" Then ;Chinesisch
	  $OSLang = "CN"
   Else
	  $OSLang = "EN"
   EndIf

   Return $OSLang
EndFunc


;Check Windows Version
Func _GetWinVer()
   Local $v_WinName = ""

   ;v1
;~    $WinVer = RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "CurrentVersion")

;~    If $WinVer = "6.1" Then ;Win7
;~ 	  Global $WinName = "Win7"
;~    ElseIf $WinVer = "6.2" Then ;Win8
;~ 	  Global $WinName = "Win8"
;~    ElseIf $WinVer = "6.3" Then ;Win8.1
;~ 	  Global $WinName = "Win8"
;~    ElseIf $WinVer = "6.4" Then ;Win10
;~ 	  Global $WinName = "Win10"
;~    Else ;not supported
;~ 	  MsgBox(16, "Compatibility", "This version of " & $AppName & " does not support your Windows Version.")
;~ 	  Exit
;~    EndIf

   ;v2 - CurrentVersion seems not to have changed since win8, other distinction needed
;~    $v_WinVer = RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion", "ProductName")

;~    If StringInStr($v_WinVer, "Windows 7") > 0 Then ;Win7
;~ 	  Global $v_WinName = "Win7"
;~    ElseIf StringInStr($v_WinVer, "Windows 8") > 0 Then ;Win8
;~ 	  Global $v_WinName = "Win8"
;~    ElseIf StringInStr($v_WinVer, "Windows 10") > 0 Then ;Win10
;~ 	  Global $v_WinName = "Win10"
;~    Else ;not supported
;~ 	  Global $v_WinName = "Not supported"
;~    EndIf

   ;v3
   $v_WinVer = FileGetVersion(@SystemDir & "\WinVer.exe")
   If StringInStr($v_WinVer, "6.1") > 0 Then ;Win7
	  $v_WinName = "Win7"
   ElseIf StringInStr($v_WinVer, "6.2") > 0 Then ;Win8
	  $v_WinName = "Win8"
   ElseIf StringInStr($v_WinVer, "6.3") > 0 Then ;Win8
	  $v_WinName = "Win8"
   ElseIf StringInStr($v_WinVer, "10.0") > 0 Then ;Win10
	  $v_WinName = "Win10"
   Else ;not supported
	  $v_WinName = "Not supported"
   EndIf

   ;MsgBox(0, "", $v_WinVer & " | " & $v_WinName)

   Return $v_WinName
EndFunc
#EndRegion


#Region Scrollbar Functions
;Info: Make a GUI scrollable
;Usage: Paste the Code into your GUI code
;_GUIScrollBars_Init($MyGUI)
;_GUIScrollBars_SetScrollInfoMax($MyGUI, $SB_VERT, 100) ;vertical scrolling height
;_GUIScrollBars_SetScrollInfoMax($MyGUI, $SB_HORZ, 100) ;horizontal scrolling width or
;_GUIScrollBars_ShowScrollBar($MyGUI, $SB_HORZ, False) ;hide horizontal Scrollbar

Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
    #forceref $iMsg, $wParam
    Local $iIndex = -1, $iCharY, $iCharX, $iClientMaxX, $iClientX, $iClientY, $iMax
    For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
        If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
            $iIndex = $x
            $iClientMaxX = $__g_aSB_WindowInfo[$iIndex][1]
            $iCharX = $__g_aSB_WindowInfo[$iIndex][2]
            $iCharY = $__g_aSB_WindowInfo[$iIndex][3]
            $iMax = $__g_aSB_WindowInfo[$iIndex][7]
            ExitLoop
        EndIf
    Next
    If $iIndex = -1 Then Return 0

    Local $tSCROLLINFO = DllStructCreate($tagSCROLLINFO)

    ; Retrieve the dimensions of the client area.
    $iClientX = BitAND($lParam, 0x0000FFFF)
    $iClientY = BitShift($lParam, 16)
    $__g_aSB_WindowInfo[$iIndex][4] = $iClientX
    $__g_aSB_WindowInfo[$iIndex][5] = $iClientY

    ; Set the vertical scrolling range and page size
    DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
    DllStructSetData($tSCROLLINFO, "nMin", 0)
    DllStructSetData($tSCROLLINFO, "nMax", $iMax)
    DllStructSetData($tSCROLLINFO, "nPage", $iClientY / $iCharY)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)

    ; Set the horizontal scrolling range and page size
    DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
    DllStructSetData($tSCROLLINFO, "nMin", 0)
    DllStructSetData($tSCROLLINFO, "nMax", 2 + $iClientMaxX / $iCharX)
    DllStructSetData($tSCROLLINFO, "nPage", $iClientX / $iCharX)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_HSCROLL($hWnd, $iMsg, $wParam, $lParam)
    #forceref $iMsg, $lParam
    Local $iScrollCode = BitAND($wParam, 0x0000FFFF)

    Local $iIndex = -1, $iCharX, $iPosX
    Local $iMin, $iMax, $iPage, $iPos, $iTrackPos

    For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
        If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
            $iIndex = $x
            $iCharX = $__g_aSB_WindowInfo[$iIndex][2]
            ExitLoop
        EndIf
    Next
    If $iIndex = -1 Then Return 0

    ; ; Get all the horizontal scroll bar information
    Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_HORZ)
    $iMin = DllStructGetData($tSCROLLINFO, "nMin")
    $iMax = DllStructGetData($tSCROLLINFO, "nMax")
    $iPage = DllStructGetData($tSCROLLINFO, "nPage")
    ; Save the position for comparison later on
    $iPosX = DllStructGetData($tSCROLLINFO, "nPos")
    $iPos = $iPosX
    $iTrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")
    #forceref $iMin, $iMax
    Switch $iScrollCode

        Case $SB_LINELEFT ; user clicked left arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - 1)

        Case $SB_LINERIGHT ; user clicked right arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + 1)

        Case $SB_PAGELEFT ; user clicked the scroll bar shaft left of the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - $iPage)

        Case $SB_PAGERIGHT ; user clicked the scroll bar shaft right of the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + $iPage)

        Case $SB_THUMBTRACK ; user dragged the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iTrackPos)
    EndSwitch

    ; // Set the position and then retrieve it.  Due to adjustments
    ; //   by Windows it may not be the same as the value set.

    DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
    _GUIScrollBars_GetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
    ;// If the position has changed, scroll the window and update it
    $iPos = DllStructGetData($tSCROLLINFO, "nPos")
    If ($iPos <> $iPosX) Then _GUIScrollBars_ScrollWindow($hWnd, $iCharX * ($iPosX - $iPos), 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_HSCROLL

Func WM_VSCROLL($hWnd, $iMsg, $wParam, $lParam)
    #forceref $iMsg, $wParam, $lParam
    Local $iScrollCode = BitAND($wParam, 0x0000FFFF)
    Local $iIndex = -1, $iCharY, $iPosY
    Local $iMin, $iMax, $iPage, $iPos, $iTrackPos

    For $x = 0 To UBound($__g_aSB_WindowInfo) - 1
        If $__g_aSB_WindowInfo[$x][0] = $hWnd Then
            $iIndex = $x
            $iCharY = $__g_aSB_WindowInfo[$iIndex][3]
            ExitLoop
        EndIf
    Next
    If $iIndex = -1 Then Return 0

    ; Get all the vertial scroll bar information
    Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_VERT)
    $iMin = DllStructGetData($tSCROLLINFO, "nMin")
    $iMax = DllStructGetData($tSCROLLINFO, "nMax")
    $iPage = DllStructGetData($tSCROLLINFO, "nPage")
    ; Save the position for comparison later on
    $iPosY = DllStructGetData($tSCROLLINFO, "nPos")
    $iPos = $iPosY
    $iTrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")

    Switch $iScrollCode
        Case $SB_TOP ; user clicked the HOME keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $iMin)

        Case $SB_BOTTOM ; user clicked the END keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $iMax)

        Case $SB_LINEUP ; user clicked the top arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - 1)

        Case $SB_LINEDOWN ; user clicked the bottom arrow
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + 1)

        Case $SB_PAGEUP ; user clicked the scroll bar shaft above the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos - $iPage)

        Case $SB_PAGEDOWN ; user clicked the scroll bar shaft below the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iPos + $iPage)

        Case $SB_THUMBTRACK ; user dragged the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $iTrackPos)
    EndSwitch

    ; // Set the position and then retrieve it.  Due to adjustments
    ; //   by Windows it may not be the same as the value set.

    DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    _GUIScrollBars_GetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    ;// If the position has changed, scroll the window and update it
    $iPos = DllStructGetData($tSCROLLINFO, "nPos")

    If ($iPos <> $iPosY) Then
        _GUIScrollBars_ScrollWindow($hWnd, 0, $iCharY * ($iPosY - $iPos))
        $iPosY = $iPos
    EndIf

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_VSCROLL

Func WM_MOUSEWHEEL($hWnd, $Msg, $wParam)
   #forceref $Msg, $wParam

   If $wParam == "0x00780000" Then _Scroll_Up($FilesGUI)
   If $wParam == "0xFF880000" Then _Scroll_Down($FilesGUI)
EndFunc   ;==>WM_MOUSEWHEEL

Func _Scroll_Down($hScrollGUI)
     for $i = 0 To 4 Step 1
         WM_VSCROLL($hScrollGUI, 0x0, 0x00000001, 0) ;1 mal kurz nach oben Scrollen - selber Effekt wie auf den Pfeil klicken
     Next
EndFunc   ;==>_Scroll_Down

Func _Scroll_Up($hScrollGUI)
    for $i = 0 To 4 Step 1
         WM_VSCROLL($hScrollGUI, 0x0, 0x00000000, 0) ;1 mal kurz nach unten Scrollen - selber Effekt wie auf den Pfeil klicken
     Next
EndFunc   ;==>_Scroll_Up
#EndRegion
