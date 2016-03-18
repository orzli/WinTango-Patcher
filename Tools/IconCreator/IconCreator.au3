#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <ComboConstants.au3>
#include <ColorConstants.au3>
#include <File.au3>

Global $OutputPath = @ScriptDir
Global $convert_exe = @ScriptDir & "\convert.exe"

#Region FileIncludes
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\convert.exe", $convert_exe)
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_bzlib_.dll", @ScriptDir & "\CORE_RL_bzlib_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_cairo_.dll", @ScriptDir & "\CORE_RL_cairo_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_exr_.dll", @ScriptDir & "\CORE_RL_exr_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_glib_.dll", @ScriptDir & "\CORE_RL_glib_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_jp2_.dll", @ScriptDir & "\CORE_RL_jp2_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_jpeg_.dll", @ScriptDir & "\CORE_RL_jpeg_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_lcms_.dll", @ScriptDir & "\CORE_RL_lcms_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_librsvg_.dll", @ScriptDir & "\CORE_RL_librsvg_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_libxml_.dll", @ScriptDir & "\CORE_RL_libxml_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_lqr_.dll", @ScriptDir & "\CORE_RL_lqr_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_magick_.dll", @ScriptDir & "\CORE_RL_magick_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_Magick++_.dll", @ScriptDir & "\CORE_RL_Magick++_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_openjpeg_.dll", @ScriptDir & "\CORE_RL_openjpeg_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_pango_.dll", @ScriptDir & "\CORE_RL_pango_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_png_.dll", @ScriptDir & "\CORE_RL_png_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_tiff_.dll", @ScriptDir & "\CORE_RL_tiff_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_ttf_.dll", @ScriptDir & "\CORE_RL_ttf_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_wand_.dll", @ScriptDir & "\CORE_RL_wand_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_webp_.dll", @ScriptDir & "\CORE_RL_webp_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\CORE_RL_zlib_.dll", @ScriptDir & "\CORE_RL_zlib_.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\msvcr120.dll", @ScriptDir & "\msvcr120.dll")
FileInstall("D:\Software\_Temp\WinTango_Patcher\icon-themes\_src\vcomp120.dll", @ScriptDir & "\vcomp120.dll")
#EndRegion

Global $App_Temp_Dir = @TempDir & "\IconCreator"
DirCreate($App_Temp_Dir)


#Region GUI
$MainGUI = GUICreate("IconCreator", 579, 420, -1, -1)

;Source
$lblSource = GUICtrlCreateLabel("Icon Set:", 8, 12, 53, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$inSourcePath = GUICtrlCreateCombo("", 64, 8, 138, 21, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_SORT))
GUICtrlSetData($inSourcePath, _GetFolders(@ScriptDir))
ControlCommand($MainGUI, "", $inSourcePath, "SetCurrentSelection", 0) ;ersten Eintrag auswählen

$Categories = GUICtrlCreateLabel("Category:", 8, 40, 53, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$inCategory = GUICtrlCreateCombo("", 64, 37, 138, 215, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL,$CBS_SORT))
GUICtrlSetData($inCategory, _GetFolders(@ScriptDir & "\" & GUICtrlRead($inSourcePath)))
ControlCommand($MainGUI, "", $inCategory, "SetCurrentSelection", 0) ;ersten Eintrag auswählen


;Preview & List
$height = 70
$Preview = GUICtrlCreateLabel("Preview:", 8, $height, 53, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
Global $picPreview

$lstSource = GUICtrlCreateList("", 8, $height + 60, 193, 285, BitOR($LBS_SORT,$WS_VSCROLL))


;Sizes
$Group1 = GUICtrlCreateGroup("Icon Sizes", 216, 10, 353, 290)

$lblSizesA = GUICtrlCreateLabel("Standard Sizes", 232, 30, 89, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

$height = 48
Global $chk16px = GUICtrlCreateCheckbox("16x16", 232, $height, 81, 17)
Global $chk24px = GUICtrlCreateCheckbox("24x24", 232, $height + 24, 81, 17)
Global $chk32px = GUICtrlCreateCheckbox("32x32", 232, $height + 48, 81, 17)
Global $chk48px = GUICtrlCreateCheckbox("48x48", 232, $height + 72, 81, 17)
Global $chk64px = GUICtrlCreateCheckbox("64x64", 232, $height + 96, 81, 17)
Global $chk128px = GUICtrlCreateCheckbox("128x128", 232, $height + 120, 81, 17)
Global $chk256px = GUICtrlCreateCheckbox("256x256", 232, $height + 144, 81, 17)

$lblSizesB = GUICtrlCreateLabel("Special Sizes", 352, 30, 80, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

Global $chk8px = GUICtrlCreateCheckbox("8x8", 352, $height, 81, 17)
Global $chk10px = GUICtrlCreateCheckbox("10x10", 352, $height + 24, 81, 17)
Global $chk20px = GUICtrlCreateCheckbox("20x20", 352, $height + 48, 81, 17)
Global $chk22px = GUICtrlCreateCheckbox("22x22", 352, $height + 72, 81, 17)
Global $chk40px = GUICtrlCreateCheckbox("40x40", 352, $height + 96, 81, 17)
Global $chk60px = GUICtrlCreateCheckbox("60x60", 352, $height + 120, 81, 17)
Global $chk72px = GUICtrlCreateCheckbox("72x72", 352, $height + 144, 81, 17)
Global $chk96px = GUICtrlCreateCheckbox("96x96", 352, $height + 168, 81, 17)
Global $chk196px = GUICtrlCreateCheckbox("196x196", 352, $height + 192, 81, 17)

$chkMisc1 = GUICtrlCreateCheckbox("", 464, $height, 17, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$Input1 = GUICtrlCreateInput("", 488, $height - 2, 65, 21)
GUICtrlSetState(-1, $GUI_DISABLE)

$chkMisc2 = GUICtrlCreateCheckbox("", 464, $height + 24, 17, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$Input2 = GUICtrlCreateInput("", 488, $height + 22, 65, 21)
GUICtrlSetState(-1, $GUI_DISABLE)

$chkMisc3 = GUICtrlCreateCheckbox("", 464, $height + 48, 17, 17)
GUICtrlSetState(-1, $GUI_DISABLE)
$Input3 = GUICtrlCreateInput("", 488, $height + 46, 65, 21)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateGroup("", -99, -99, 1, 1)


;Output
$height = $height + 216 + 45
$lblOut = GUICtrlCreateLabel("Output:", 216, $height+3, 50, 21)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$inOutputPath = GUICtrlCreateInput($OutputPath, 266, $height, 303, 21, $ES_READONLY)


;Action
$btnCreate = GUICtrlCreateButton("Create ICO...", 216, $height + 30, 353, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetState(-1, $GUI_DISABLE)

$btnCreatePNG = GUICtrlCreateButton("Create PNG...", 216, $height + 65, 353, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetState(-1, $GUI_DISABLE)


;Get Files
_SelectCatCombo()

GUISetState(@SW_SHOW)

ControlCommand($MainGUI, "", $lstSource, "SetCurrentSelection", 0) ;ersten Eintrag auswählen

#EndRegion

While 1
   $nMsg = GUIGetMsg()
   Switch $nMsg
	  Case $GUI_EVENT_CLOSE
		 DirRemove($App_Temp_Dir & "\", 1)
		 FileDelete("convert.exe")
		 FileDelete("*.dll")
		 Exit


	  Case $inSourcePath
		 $inIconSet = GUICtrlRead($inSourcePath)

		 GUICtrlSetData($inCategory, "")
		 GUICtrlSetData($inCategory, _GetFolders(@ScriptDir & "\" & $inIconSet))
		 ControlCommand($MainGUI, "", $inCategory, "SetCurrentSelection", 0) ;ersten Eintrag auswählen
		 ;If $inPath <> $inPath_new Then ControlCommand($MainGUI, "", $inCategory, "SelectString", "actions")


	  Case $inCategory
		 _SelectCatCombo()

	  Case $lstSource
		 GUICtrlDelete($picPreview)

		 $selFilePath = ""
		 $selFile = GUICtrlRead($lstSource, 1) ;= ausgewählter Eintrag
		 $inPath = GUICtrlRead($inSourcePath)
		 $cat = GUICtrlRead($inCategory)

		 GUICtrlSetState($chk8px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk10px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk16px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk20px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk22px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk24px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk32px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk40px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk48px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk60px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk64px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk72px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk96px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk128px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk196px, $GUI_UNCHECKED)
		 GUICtrlSetState($chk256px, $GUI_UNCHECKED)

		 GUICtrlSetState($chk8px, $GUI_DISABLE)
		 GUICtrlSetState($chk10px, $GUI_DISABLE)
		 GUICtrlSetState($chk16px, $GUI_DISABLE)
		 GUICtrlSetState($chk20px, $GUI_DISABLE)
		 GUICtrlSetState($chk22px, $GUI_DISABLE)
		 GUICtrlSetState($chk24px, $GUI_DISABLE)
		 GUICtrlSetState($chk32px, $GUI_DISABLE)
		 GUICtrlSetState($chk40px, $GUI_DISABLE)
		 GUICtrlSetState($chk48px, $GUI_DISABLE)
		 GUICtrlSetState($chk60px, $GUI_DISABLE)
		 GUICtrlSetState($chk64px, $GUI_DISABLE)
		 GUICtrlSetState($chk72px, $GUI_DISABLE)
		 GUICtrlSetState($chk96px, $GUI_DISABLE)
		 GUICtrlSetState($chk128px, $GUI_DISABLE)
		 GUICtrlSetState($chk196px, $GUI_DISABLE)
		 GUICtrlSetState($chk256px, $GUI_DISABLE)


		 $font_Size = 9
		 $font_Weight_FileExists = 700
		 $font_Weight_FileNotExists = 100
		 $font_Attribute_FileNotExists = ""


		 ;standards
		 $selFilePath_16 = _Find($selFile & ".png", $inPath & "\" & $cat & "\16")
		 $selFilePath_16_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\16")
		 If $selFilePath_16 <> "0" or $selFilePath_16_svg <> "0" Then
			GUICtrlSetState($chk16px, $GUI_ENABLE)
			GUICtrlSetFont($chk16px, $font_Size, $font_Weight_FileExists)
		 Else
			GUICtrlSetState($chk16px, $GUI_DISABLE)
			GUICtrlSetFont($chk16px, $font_Size, $font_Weight_FileNotExists)
		 EndIf

		 $selFilePath_24 = _Find($selFile & ".png", $inPath & "\" & $cat & "\24")
		 $selFilePath_24_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\24")
		 If $selFilePath_24 <> "0" or $selFilePath_24_svg <> "0" Then
			GUICtrlSetState($chk24px, $GUI_ENABLE)
			GUICtrlSetFont($chk24px, $font_Size, $font_Weight_FileExists)
		 Else
			GUICtrlSetState($chk24px, $GUI_DISABLE)
			GUICtrlSetFont($chk24px, $font_Size, $font_Weight_FileNotExists)
		 EndIf

		 $selFilePath_32 = _Find($selFile & ".png", $inPath & "\" & $cat & "\32")
		 $selFilePath_32_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\32")
		 If $selFilePath_32 <> "0" or $selFilePath_32_svg <> "0" Then
			GUICtrlSetState($chk32px, $GUI_ENABLE)
			GUICtrlSetFont($chk32px, $font_Size, $font_Weight_FileExists)
		 Else
			GUICtrlSetState($chk32px, $GUI_DISABLE)
			GUICtrlSetFont($chk32px, $font_Size, $font_Weight_FileNotExists)
		 EndIf

		 $selFilePath_48 = _Find($selFile & ".png", $inPath & "\" & $cat & "\48")
		 $selFilePath_48_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\48")
		 If $selFilePath_48 <> "0" or $selFilePath_48_svg <> "0" Then
			GUICtrlSetState($chk48px, $GUI_ENABLE)
			GUICtrlSetFont($chk48px, $font_Size, $font_Weight_FileExists)
		 Else
			GUICtrlSetState($chk48px, $GUI_DISABLE)
			GUICtrlSetFont($chk48px, $font_Size, $font_Weight_FileNotExists)
		 EndIf

		 $selFilePath_256 = _Find($selFile & ".png", $inPath & "\" & $cat & "\256")
		 $selFilePath_256_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\256")
		 If $selFilePath_256 <> "0" or $selFilePath_256_svg <> "0" Then
			GUICtrlSetState($chk256px, $GUI_ENABLE)
			GUICtrlSetFont($chk256px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk256px, $GUI_ENABLE)
			GUICtrlSetFont($chk256px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 ;specials
		 $selFilePath_8 = _Find($selFile & ".png", $inPath & "\" & $cat & "\8")
		 If $selFilePath_8 <> "0" Then
			GUICtrlSetState($chk8px, $GUI_ENABLE)
			GUICtrlSetFont($chk8px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_16 <> "0" Then
			GUICtrlSetState($chk8px, $GUI_ENABLE)
			GUICtrlSetFont($chk8px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_10 = _Find($selFile & ".png", $inPath & "\" & $cat & "\10")
		 If $selFilePath_10 <> "0" Then
			GUICtrlSetState($chk10px, $GUI_ENABLE)
			GUICtrlSetFont($chk10px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_16 <> "0" Then
			GUICtrlSetState($chk10px, $GUI_ENABLE)
			GUICtrlSetFont($chk10px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_20 = _Find($selFile & ".png", $inPath & "\" & $cat & "\20")
		 If $selFilePath_20 <> "0" Then
			GUICtrlSetState($chk20px, $GUI_ENABLE)
			GUICtrlSetFont($chk20px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_16 <> "0" Then
			GUICtrlSetState($chk20px, $GUI_ENABLE)
			GUICtrlSetFont($chk20px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_22 = _Find($selFile & ".png", $inPath & "\" & $cat & "\22")
		 $selFilePath_22_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\22")
		 If $selFilePath_22 <> "0" or $selFilePath_22_svg <> "0" Then
			GUICtrlSetState($chk22px, $GUI_ENABLE)
			GUICtrlSetFont($chk22px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_16 <> "0" Then
			GUICtrlSetState($chk22px, $GUI_ENABLE)
			GUICtrlSetFont($chk22px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_40 = _Find($selFile & ".png", $inPath & "\" & $cat & "\40")
		 If $selFilePath_40 <> "0" Then
			GUICtrlSetState($chk40px, $GUI_ENABLE)
			GUICtrlSetFont($chk40px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_32 <> "0" Then
			GUICtrlSetState($chk40px, $GUI_ENABLE)
			GUICtrlSetFont($chk40px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_60 = _Find($selFile & ".png", $inPath & "\" & $cat & "\60")
		 $selFilePath_60_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\60")
		 If $selFilePath_60 <> "0" or $selFilePath_60_svg <> "0" Then
			GUICtrlSetState($chk60px, $GUI_ENABLE)
			GUICtrlSetFont($chk60px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk60px, $GUI_ENABLE)
			GUICtrlSetFont($chk60px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_64 = _Find($selFile & ".png", $inPath & "\" & $cat & "\64")
		 $selFilePath_64_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\64")
		 If $selFilePath_64 <> "0" or $selFilePath_64_svg <> "0" Then
			GUICtrlSetState($chk64px, $GUI_ENABLE)
			GUICtrlSetFont($chk64px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk64px, $GUI_ENABLE)
			GUICtrlSetFont($chk64px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_72 = _Find($selFile & ".png", $inPath & "\" & $cat & "\72")
		 If $selFilePath_72 <> "0" Then
			GUICtrlSetState($chk72px, $GUI_ENABLE)
			GUICtrlSetFont($chk72px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_64 <> "0" or $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk72px, $GUI_ENABLE)
			GUICtrlSetFont($chk72px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_96 = _Find($selFile & ".png", $inPath & "\" & $cat & "\96")
		 If $selFilePath_96 <> "0" Then
			GUICtrlSetState($chk96px, $GUI_ENABLE)
			GUICtrlSetFont($chk96px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_64 <> "0" or $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk96px, $GUI_ENABLE)
			GUICtrlSetFont($chk96px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_128 = _Find($selFile & ".png", $inPath & "\" & $cat & "\128")
		 $selFilePath_128_svg = _Find($selFile & ".svg", $inPath & "\" & $cat & "\128")
		 If $selFilePath_128 <> "0" or $selFilePath_128_svg <> "0" Then
			GUICtrlSetState($chk128px, $GUI_ENABLE)
			GUICtrlSetFont($chk128px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_64 <> "0" or $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk128px, $GUI_ENABLE)
			GUICtrlSetFont($chk128px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf

		 $selFilePath_196 = _Find($selFile & ".png", $inPath & "\" & $cat & "\196")
		 If $selFilePath_196 <> "0" Then
			GUICtrlSetState($chk196px, $GUI_ENABLE)
			GUICtrlSetFont($chk196px, $font_Size, $font_Weight_FileExists)
		 ElseIf $selFilePath_128 <> "0" or $selFilePath_64 <> "0" or $selFilePath_48 <> "0" Then
			GUICtrlSetState($chk196px, $GUI_ENABLE)
			GUICtrlSetFont($chk196px, $font_Size, $font_Weight_FileNotExists, $font_Attribute_FileNotExists)
		 EndIf


		 $selFilePath = $selFilePath_48
		 If $selFilePath = "0" Then $selFilePath = $selFilePath_32
		 If $selFilePath = "0" Then $selFilePath = $selFilePath_24
		 If $selFilePath = "0" Then $selFilePath = $selFilePath_16

		 ShellExecuteWait($convert_exe, "-background none " & $selFilePath & " " & $App_Temp_Dir & "\preview.ico", @ScriptDir, "", @SW_HIDE)

		 $picPreview = GUICtrlCreateIcon($App_Temp_Dir & "\preview.ico", -1, 64, 70, 48, 48)

		 GUICtrlSetState($btnCreate, $GUI_ENABLE)
		 GUICtrlSetState($btnCreatePNG, $GUI_ENABLE)

	  Case $btnCreate
		 $selFile = GUICtrlRead($lstSource, 1) ;= ausgewählter Eintrag
		 $cat = GUICtrlRead($inCategory)
		 $inPath = @ScriptDir & "\" & GUICtrlRead($inSourcePath)
		 $outPath = GUICtrlRead($inOutputPath)

		 _CreateIcon($selFile, $inPath, $cat, $outPath)

	  Case $btnCreatePNG
		 $selFile = GUICtrlRead($lstSource, 1) ;= ausgewählter Eintrag
		 $cat = GUICtrlRead($inCategory)
		 $inPath = @ScriptDir & "\" & GUICtrlRead($inSourcePath)
		 $outPath = GUICtrlRead($inOutputPath)

		 _CreateIcon($selFile, $inPath, $cat, $outPath, "png")

   EndSwitch
WEnd


Func _GetFolders($searchDir)
   $a_Folders = _FileListToArray ($searchDir, "*", 2)
   $s_FoldersList = ""

   If IsArray($a_Folders) Then
	  For $i = 1 to $a_Folders[0]
		 If $a_Folders[$i] <> "_src" and $a_Folders[$i] <> "_NEU" Then $s_FoldersList &= $a_Folders[$i] & "|"
	  Next
   EndIf

   Return $s_FoldersList
EndFunc


Func _SelectCatCombo()
   GUICtrlSetData($lstSource, "")
   $FileList = _GetFiles(GUICtrlRead($inSourcePath) & "\" & GUICtrlRead($inCategory))
   GUICtrlSetData($lstSource, $FileList)
   ControlCommand($MainGUI, "", $lstSource, "SetCurrentSelection", 0) ;ersten Eintrag auswählen
EndFunc


Func _CreateIcon($sFileName, $sInPath, $sCat, $sOutPath, $action = "ico")
   DirCreate($sOutPath)
   DirCreate($App_Temp_Dir)

   $suffix = ""


   ;Files
   Global $vFilePath_16 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "16")
   Global $vFilePath_16_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "16")
   Global $vFilePath_24 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "24")
   Global $vFilePath_24_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "24")
   Global $vFilePath_32 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "32")
   Global $vFilePath_32_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "32")
   Global $vFilePath_48 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "48")
   Global $vFilePath_48_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "48")
   Global $vFilePath_256 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "256")
   Global $vFilePath_256_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "256")

   Global $vFilePath_8 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "8")
   Global $vFilePath_8_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "8")
   Global $vFilePath_10 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "10")
   Global $vFilePath_10_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "10")
   Global $vFilePath_20 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "20")
   Global $vFilePath_20_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "20")
   Global $vFilePath_22 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "22")
   Global $vFilePath_22_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "22")
   Global $vFilePath_40 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "40")
   Global $vFilePath_40_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "40")
   Global $vFilePath_60 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "60")
   Global $vFilePath_60_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "60")
   Global $vFilePath_64 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "64")
   Global $vFilePath_64_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "64")
   Global $vFilePath_72 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "72")
   Global $vFilePath_72_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "72")
   Global $vFilePath_96 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "96")
   Global $vFilePath_96_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "96")
   Global $vFilePath_128 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "128")
   Global $vFilePath_128_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "128")
   Global $vFilePath_196 = _GenFilePath($sFileName, $sInPath, $sCat, "png", "196")
   Global $vFilePath_196_svg = _GenFilePath($sFileName, $sInPath, $sCat, "svg", "196")


   ;8px
   $icoSize = "8"
   Global $FilePath_8 = ""
   If GUICtrlRead($chk8px) = 1 Then
	  If FileExists($vFilePath_8) Then
		 $FilePath_8 = $vFilePath_8
	  ElseIf FileExists($vFilePath_8_svg) Then ;no PNG but a SVG available
		 $FilePath_8 = $vFilePath_8_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_16
		 $sFileSVG_alt = $vFilePath_16_svg
		 $FilePath_8 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= ""
	  EndIf
   EndIf


   ;10px
   $icoSize = "10"
   Global $FilePath_10 = ""
   If GUICtrlRead($chk10px) = 1 Then
	  If FileExists($vFilePath_10) Then
		 $FilePath_10 = $vFilePath_10
	  ElseIf FileExists($vFilePath_10_svg) Then ;no PNG but a SVG available
		 $FilePath_10 = $vFilePath_10_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_16
		 $sFileSVG_alt = $vFilePath_16_svg
		 $FilePath_10 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;16px
   $icoSize = "16"
   Global $FilePath_16 = ""
   If GUICtrlRead($chk16px) = 1 Then
	  If FileExists($vFilePath_16) Then
		 $FilePath_16 = $vFilePath_16
	  ElseIf FileExists($vFilePath_16_svg) Then ;no PNG but a SVG available
		 $FilePath_16 = $vFilePath_16_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_24
		 $sFileSVG_alt = $vFilePath_24_svg
		 $FilePath_16 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;20px
   $icoSize = "20"
   Global $FilePath_20 = ""
   If GUICtrlRead($chk20px) = 1 Then
	  If FileExists($vFilePath_20) Then
		 $FilePath_20 = $vFilePath_20
	  ElseIf FileExists($vFilePath_20_svg) Then ;no PNG but a SVG available
		 $FilePath_20 = $vFilePath_20_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_16
		 $sFileSVG_alt = $vFilePath_16_svg
		 $FilePath_20 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;22px
   $icoSize = "22"
   Global $FilePath_22 = ""
   If GUICtrlRead($chk22px) = 1 Then
	  If FileExists($vFilePath_22) Then
		 $FilePath_22 = $vFilePath_22
	  ElseIf FileExists($vFilePath_22_svg) Then ;no PNG but a SVG available
		 $FilePath_22 = $vFilePath_22_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_16
		 $sFileSVG_alt = $vFilePath_16_svg
		 $FilePath_22 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;24px
   $icoSize = "24"
   Global $FilePath_24 = ""
   If GUICtrlRead($chk24px) = 1 Then
	  If FileExists($vFilePath_24) Then
		 $FilePath_24 = $vFilePath_24
	  ElseIf FileExists($vFilePath_24_svg) Then ;no PNG but a SVG available
		 $FilePath_24 = $vFilePath_24_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_16
		 $sFileSVG_alt = $vFilePath_16_svg
		 $FilePath_24 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;32px
   $icoSize = "32"
   Global $FilePath_32 = ""
   If GUICtrlRead($chk32px) = 1 Then
	  If FileExists($vFilePath_32) Then
		 $FilePath_32 = $vFilePath_32
	  ElseIf FileExists($vFilePath_32_svg) Then ;no PNG but a SVG available
		 $FilePath_32 = $vFilePath_32_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_24
		 $sFileSVG_alt = $vFilePath_24_svg
		 $FilePath_32 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;40px
   $icoSize = "40"
   Global $FilePath_40 = ""
   If GUICtrlRead($chk40px) = 1 Then
	  If FileExists($vFilePath_40) Then
		 $FilePath_40 = $vFilePath_40
	  ElseIf FileExists($vFilePath_40_svg) Then ;no PNG but a SVG available
		 $FilePath_40 = $vFilePath_40_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_32
		 $sFileSVG_alt = $vFilePath_32_svg
		 $FilePath_40 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;48px
   $icoSize = "48"
   Global $FilePath_48 = ""
   If GUICtrlRead($chk48px) = 1 Then
	  If FileExists($vFilePath_48) Then
		 $FilePath_48 = $vFilePath_48
	  ElseIf FileExists($vFilePath_48_svg) Then ;no PNG but a SVG available
		 $FilePath_48 = $vFilePath_48_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_32
		 $sFileSVG_alt = $vFilePath_32_svg
		 $FilePath_48 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;60px
   $icoSize = "60"
   Global $FilePath_60 = ""
   If GUICtrlRead($chk60px) = 1 Then
	  If FileExists($vFilePath_60) Then
		 $FilePath_60 = $vFilePath_60
	  ElseIf FileExists($vFilePath_60_svg) Then ;no PNG but a SVG available
		 $FilePath_60 = $vFilePath_60_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_48
		 $sFileSVG_alt = $vFilePath_48_svg
		 $FilePath_60 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;64px
   $icoSize = "64"
   Global $FilePath_64 = ""
   If GUICtrlRead($chk64px) = 1 Then
	  If FileExists($vFilePath_64) Then
		 $FilePath_64 = $vFilePath_64
	  ElseIf FileExists($vFilePath_64_svg) Then ;no PNG but a SVG available
		 $FilePath_64 = $vFilePath_64_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_48
		 $sFileSVG_alt = $vFilePath_48_svg
		 $FilePath_64 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;72px
   $icoSize = "72"
   Global $FilePath_72 = ""
   If GUICtrlRead($chk72px) = 1 Then
	  If FileExists($vFilePath_72) Then
		 $FilePath_72 = $vFilePath_72
	  ElseIf FileExists($vFilePath_72_svg) Then ;no PNG but a SVG available
		 $FilePath_72 = $vFilePath_72_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_64
		 $sFileSVG_alt = $vFilePath_64_svg
		 $sFilePNG_alt2 = $vFilePath_48
		 $sFileSVG_alt2 = $vFilePath_48_svg
		 $FilePath_72 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt, $sFileSVG_alt2, $sFilePNG_alt2)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;96px
   $icoSize = "96"
   Global $FilePath_96 = ""
   If GUICtrlRead($chk96px) = 1 Then
	  If FileExists($vFilePath_96) Then
		 $FilePath_96 = $vFilePath_96
	  ElseIf FileExists($vFilePath_96_svg) Then ;no PNG but a SVG available
		 $FilePath_96 = $vFilePath_96_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_128
		 $sFileSVG_alt = $vFilePath_128_svg
		 $sFilePNG_alt2 = $vFilePath_64
		 $sFileSVG_alt2 = $vFilePath_64_svg
		 $sFilePNG_alt3 = $vFilePath_48
		 $sFileSVG_alt3 = $vFilePath_48_svg
		 $FilePath_96 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt, $sFileSVG_alt2, $sFilePNG_alt2, $sFileSVG_alt3, $sFilePNG_alt3)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;128px
   $icoSize = "128"
   Global $FilePath_128 = ""
   If GUICtrlRead($chk128px) = 1 Then
	  If FileExists($vFilePath_128) Then
		 $FilePath_128 = $vFilePath_128
	  ElseIf FileExists($vFilePath_128_svg) Then ;no PNG but a SVG available
		 $FilePath_128 = $vFilePath_128_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_256
		 $sFileSVG_alt = $vFilePath_256_svg
		 $sFilePNG_alt2 = $vFilePath_64
		 $sFileSVG_alt2 = $vFilePath_64_svg
		 $sFilePNG_alt3 = $vFilePath_96
		 $sFileSVG_alt3 = $vFilePath_96_svg
		 $sFilePNG_alt4 = $vFilePath_48
		 $sFileSVG_alt4 = $vFilePath_48_svg
		 $FilePath_128 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt, $sFileSVG_alt2, $sFilePNG_alt2, $sFileSVG_alt3, $sFilePNG_alt3, $sFileSVG_alt4, $sFilePNG_alt4)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;196px
   $icoSize = "196"
   Global $FilePath_196 = ""
   If GUICtrlRead($chk196px) = 1 Then
	  If FileExists($vFilePath_196) Then
		 $FilePath_196 = $vFilePath_196
	  ElseIf FileExists($vFilePath_196_svg) Then ;no PNG but a SVG available
		 $FilePath_196 = $vFilePath_196_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_128
		 $sFileSVG_alt = $vFilePath_128_svg
		 $sFilePNG_alt2 = $vFilePath_64
		 $sFileSVG_alt2 = $vFilePath_64_svg
		 $sFilePNG_alt3 = $vFilePath_96
		 $sFileSVG_alt3 = $vFilePath_96_svg
		 $sFilePNG_alt4 = $vFilePath_48
		 $sFileSVG_alt4 = $vFilePath_48_svg
		 $FilePath_196 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt, $sFileSVG_alt2, $sFilePNG_alt2, $sFileSVG_alt3, $sFilePNG_alt3, $sFileSVG_alt4, $sFilePNG_alt4)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;256px
   $icoSize = "256"
   Global $FilePath_256 = ""
   If GUICtrlRead($chk256px) = 1 Then
	  If FileExists($vFilePath_256) Then
		 $FilePath_256 = $vFilePath_256
	  ElseIf FileExists($vFilePath_256_svg) Then ;no PNG but a SVG available
		 $FilePath_256 = $vFilePath_256_svg
	  Else ;use a fallback Image of a nearby size - this is just a placeholder, because the result might be very blurry!
		 $sFilePNG_alt = $vFilePath_128
		 $sFileSVG_alt = $vFilePath_128_svg
		 $sFilePNG_alt2 = $vFilePath_64
		 $sFileSVG_alt2 = $vFilePath_64_svg
		 $sFilePNG_alt3 = $vFilePath_96
		 $sFileSVG_alt3 = $vFilePath_96_svg
		 $sFilePNG_alt4 = $vFilePath_48
		 $sFileSVG_alt4 = $vFilePath_48_svg
		 $FilePath_256 = _GenFallbackImage($icoSize, $sFileName, $sFileSVG_alt, $sFilePNG_alt, $sFileSVG_alt2, $sFilePNG_alt2, $sFileSVG_alt3, $sFilePNG_alt3, $sFileSVG_alt4, $sFilePNG_alt4)
	  EndIf

	  If $suffix = "" Then
		 $suffix = "_+" & $icoSize
	  Else
		 $suffix &= "_" & $icoSize
	  EndIf
   EndIf


   ;cleanup filename
   If StringInStr($suffix, "16") > 0 and StringInStr($suffix, "32") > 0 and StringInStr($suffix, "48") > 0 Then
	  $suffix = StringReplace($suffix, "16", "", 1)
	  $suffix = StringReplace($suffix, "32", "", 1)
	  $suffix = StringReplace($suffix, "48", "", 1)
	  $suffix = StringReplace($suffix, "___", "_")
	  $suffix = StringReplace($suffix, "__", "_")
	  $suffix = StringReplace($suffix, "+_", "+")
	  If StringRight($suffix, 1) = "_" Then $suffix = StringTrimRight($suffix, 1)
	  If StringRight($suffix, 2) = "_+" Then $suffix = StringTrimRight($suffix, 2)
   Else
	  $suffix = StringReplace($suffix, "+", "")
   EndIf


   ;create the icon
   If $action = "ico" Then _ConvertToIco($outPath, $selFile, $suffix)

   If $action = "png" Then _ConvertToPng($outPath, $selFile)

EndFunc



Func _ConvertToIco($sOutPath, $sName, $sNameSuffix)
   ;SVG/PNG 2 ICO: convert.exe -background none INPUT1.svg INPUT2.png OUTPUT.ico

   ShellExecuteWait($convert_exe, "-background none " & $FilePath_256 & " " & $FilePath_196 & " " & $FilePath_128 & " " & $FilePath_96 & " " & $FilePath_72 & " " & $FilePath_64 & " " & $FilePath_60 & " " & $FilePath_48 & " " & $FilePath_40 & " " & $FilePath_32 & " "  & $FilePath_24 & " "  & $FilePath_22 & " " & $FilePath_20 & " " & $FilePath_16 & " " & $FilePath_10 & " " & $FilePath_8 & " " & $sOutPath & "\" & $sName & $sNameSuffix & ".ico", @ScriptDir, "", @SW_HIDE)

   TrayTip("Erfolg!", "Das Icon wurde erfolgreich erstellt.", 1)
EndFunc

Func _ConvertToPng($sOutPath, $sName)
   ;PNG resize: convert.exe -resize 32x32 INPUT.png OUTPUT.png
   ;SVG 2 PNG: convert.exe -background none INPUT.svg OUTPUT.png
   ;SVG 2 PNG SIZE : convert.exe -background none -resize 32x32 INPUT.svg OUTPUT.png

   If $FilePath_256 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_256 & " " & $sOutPath & "\" & $sName & "_256.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_196 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_196 & " " & $sOutPath & "\" & $sName & "_196.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_128 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_128 & " " & $sOutPath & "\" & $sName & "_128.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_96 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_96 & " " & $sOutPath & "\" & $sName & "_96.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_72 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_72 & " " & $sOutPath & "\" & $sName & "_72.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_64 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_64 & " " & $sOutPath & "\" & $sName & "_64.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_60 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_60 & " " & $sOutPath & "\" & $sName & "_60.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_48 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_48 & " " & $sOutPath & "\" & $sName & "_48.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_40 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_40 & " " & $sOutPath & "\" & $sName & "_40.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_32 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_32 & " " & $sOutPath & "\" & $sName & "_32.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_24 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_24 & " " & $sOutPath & "\" & $sName & "_24.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_22 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_22 & " " & $sOutPath & "\" & $sName & "_22.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_20 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_20 & " " & $sOutPath & "\" & $sName & "_20.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_16 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_16 & " " & $sOutPath & "\" & $sName & "_16.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_10 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_10 & " " & $sOutPath & "\" & $sName & "_10.png", @ScriptDir, "", @SW_HIDE)
   If $FilePath_8 <> "" Then ShellExecuteWait($convert_exe, "-background none " & $FilePath_8 & " " & $sOutPath & "\" & $sName & "_8.png", @ScriptDir, "", @SW_HIDE)

   TrayTip("Erfolg!", "Das/die Bild(er) wurde(n) erfolgreich erstellt.", 1)
EndFunc


Func _GenFilePath($sFileName, $sInPath, $sCat, $vType = "png", $vSize = "16")
   $FilePath_X = ""

   $Search = _Find($sFileName & "." & $vType, $sInPath & "\" & $sCat & "\" & $vSize)

   If $Search <> "0" Then $FilePath_X = $Search

   Return $FilePath_X
EndFunc


Func _GenFallbackImage($s_IconSize, $s_FileName, $s_FileSVG_alt, $s_FilePNG_alt, $s_FileSVG_alt2 = "", $s_FilePNG_alt2 = "", $s_FileSVG_alt3 = "", $s_FilePNG_alt3 = "", $s_FileSVG_alt4 = "", $s_FilePNG_alt4 = "")
   $s_FilePNG = $App_Temp_Dir & "\" & $s_FileName & "_" & $s_IconSize & ".png"

   If $s_IconSize = "20" or $s_IconSize = "40" Then
	  $v_Parameters = "-background none -gravity center -extent " & $s_IconSize & "x" & $s_IconSize ;place image inside a larger canvas
   Else
	  $v_Parameters = "-background none -density 4000 -resize " & $s_IconSize & "x" & $s_IconSize ;fully resize
   EndIf

   If FileExists($s_FileSVG_alt) Then ;SVG alternative
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FileSVG_alt & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FileSVG_alt2) Then ;SVG alternative 2
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FileSVG_alt2 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FileSVG_alt3) Then ;SVG alternative 3
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FileSVG_alt3 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FileSVG_alt4) Then ;SVG alternative 4
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FileSVG_alt4 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FilePNG_alt) Then ;PNG alternative
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FilePNG_alt & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FilePNG_alt2) Then ;PNG alternative 2
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FilePNG_alt2 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FilePNG_alt3) Then ;PNG alternative 3
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FilePNG_alt3 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   ElseIf FileExists($s_FilePNG_alt4) Then ;PNG alternative 4
	  ShellExecuteWait($convert_exe, $v_Parameters & " " & $s_FilePNG_alt4 & " " & $s_FilePNG, @ScriptDir, "", @SW_HIDE)

   EndIf

   If not FileExists($s_FilePNG) Then $s_FilePNG = ""

   Return $s_FilePNG
EndFunc



#Region: Generic File Operation Routines

;Get the Filename out of a string with full paths
;(with extension = 0; without extension = 1; only extension = 2)
Func _SplitFileName($sFilePath, $noExt = 0)

   Local $sSplitFileName_Return = ""

   ;Dateinamen auslesen
   $aString = StringSplit($sFilePath, "\")
   If IsArray($aString) Then
	  $sFileName_Return = $aString[$aString[0]]
   Else
	  $sFileName_Return = $sFilePath
   EndIf

   ;Dateierweiterung auslesen
   $aExtension = StringSplit($sFileName_Return, ".")
   If IsArray($aExtension) Then
	  $sExtension_Return = "." & $aExtension[$aExtension[0]]
   Else
	  $sExtension_Return = ""
   EndIf

   ;Option (with extension = 0; without extension = 1; only extension = 2)
   If $noExt = 1 Then
	  $sSplitFileName_Return = StringReplace($sFileName_Return, $sExtension_Return, "")
   ElseIf $noExt = 2 Then
	  $sSplitFileName_Return = $sExtension_Return
   Else
	  $sSplitFileName_Return = $sFileName_Return
   EndIf

   Return $sSplitFileName_Return

EndFunc ;_SplitFileName



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
        If StringRegExp($sFile, $sPattern) And ($iFlag = 0 Or $iFlag = 1) Then $sReturn &= $sPath & $sFile & $sDelim
    WEnd
    FileClose($hSearch)
    If $iFormat Then Return StringSplit(StringTrimRight($sReturn, StringLen($sDelim)), $sDelim, $iFormat)

    Return $sReturn
 EndFunc



Func _Find ($s, $d = @HomeDrive)
   If StringRight ($d, 1) <> "\" Then $d &= "\"
   Local $h = FileFindFirstFile ($d & "*")
   If $h = -1 Then Return 0
   while 1
      $t = FileFindNextFile ($h)
      If $t = $s Then Return $d & $t
      $t = $d & $t
      If @Error Then Return 0 * FileClose ($h)
      If StringInStr (FileGetAttrib ($t), "D") Then
         $tmp = _Find ($s, $t)
         If $tmp <> "0" Then Return $tmp
         ContinueLoop
      EndIf
   WEnd
   FileClose ($h)
   Return 0
EndFunc ; ==> _Find

Func _FindAll ($s, $d = @HomeDrive)
   If Not IsDeclared ("sRet") Then
      Static $sRet = ""
   EndIf
   If StringRight ($d, 1) <> "\" Then $d &= "\"
   Local $h = FileFindFirstFile ($d & "*")
   If $h = -1 Then Return ""
   while 1
      $t = FileFindNextFile ($h)
      If @Error Then ExitLoop
      If $t = $s Then $sRet &= @CRLF & $d & $t
      $t = $d & $t
      If StringInStr (FileGetAttrib ($t), "D") Then $tmp = _FindAll ($s, $t)
   WEnd
   FileClose ($h)
   Return $sRet
EndFunc ; ==> _FindAll



Func _GetFiles($dir)
   $sFileList_full = ""
   $sFileList_final = ""

   $aReturn = _RecursiveFileListToArray($dir, "\.png\z|\.svg\z", 1) ;"\.png\z|\.svg\z"

   ;Dateliste erstellen
   If IsArray($aReturn) Then
	  _ArraySort($aReturn, 0, 1)

	  If $aReturn[1] <> "" or $aReturn[1] <> "1" Then
		 For $i = 1 to $aReturn[0]
			$sFileList_full &= _SplitFileName($aReturn[$i], 1) & "|"
		 Next
	  EndIf
   EndIf

   ;doppelte Einträge ausfiltern
   $aFileList = StringSplit($sFileList_full, "|")

   If IsArray($aFileList) Then
	  $aFileList = _ArrayUnique($aFileList, "", 1)

	  For $j = 1 to $aFileList[0]
		 $sFileList_final &= $aFileList[$j] & "|"
	  Next

	  $sFileList_final = StringTrimRight($sFileList_final, 1)
   EndIf

   ;MsgBox(0,"",StringTrimRight($sFileList_final, 1))

   Return $sFileList_final
EndFunc

#EndRegion