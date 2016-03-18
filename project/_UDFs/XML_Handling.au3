#include-once
#include <String.au3>


Func XmlRead($v_filename, $v_section = "")
   ;Usage: XmlRead("filename" [, "section"])

   Local $s_XML_Return = ""

   $s_XML_Content = FileRead($v_filename) ;read complete XML code

   If $v_section = "" Then ;use old content
	  $s_XML_Return = $s_XML_Content

   Else ;read only the value in defined section (e.g. <item>value</item>)
	  $a_XML_Read = _StringBetween($s_XML_Content, '<' & $v_section & '>', '</' & $v_section & '>')
	  If IsArray($a_XML_Read) Then $s_XML_Return = $a_XML_Read[0]

   EndIf

   Return $s_XML_Return
EndFunc


Func XmlModify($v_filename, $v_section_A, $s_value, $v_section_B = "")
   ;Usage: XmlModify("filename", "sectionA", "value" [, "sectionB"])

   Local $s_XML_Return = ""
   If $v_section_B = "" Then $v_section_B = $v_section_A

   ;Check for file to modify
   If FileExists($v_filename) Then
	  $s_XML_Content = FileRead($v_filename) ;read complete XML code

	  $a_XML_Read = _StringBetween($s_XML_Content, '<' & $v_section_A & '>', '</' & $v_section_B & '>') ;get current value
	  If IsArray($a_XML_Read) Then $s_XML_Return = StringReplace($s_XML_Content, $a_XML_Read[0], $s_value) ;replace with new value

	  ;Write new content to file
	  If $s_XML_Return <> "" Then
		 $v_filename_Out = FileOpen($v_filename, 256+2) ;UTF-8 berücksichtigen und alten Inhalt löschen
		 FileWrite($v_filename_Out, $s_XML_Return)
		 FileClose($v_filename_Out)
	  Else ;no content to write -> set @error
		 SetError(1)
	  EndIf

   Else ;No file! Function would have to guess the right structure... so let it be. Use XmlCreate() instead!
	  SetError(1)
   EndIf
EndFunc


Func XmlCreate($v_filename, $s_value) ;WIP!!!!
   FileWrite($v_filename, "")
   $v_filename_Out = FileOpen($v_filename, 256+2) ;UTF-8 berücksichtigen und alten Inhalt löschen
   FileWrite($v_filename_Out, $s_value)
   FileClose($v_filename_Out)
EndFunc



Func CfgModify($v_filename, $v_section_A, $s_value, $v_section_B)
   ;Usage: CfgModify("filename", "sectionA", "value" , sectionB")

   Local $s_CFG_Return = ""
   If $v_section_B = "" Then $v_section_B = $v_section_A

   ;Check for file to modify
   If FileExists($v_filename) Then
	  $s_CFG_Content = FileRead($v_filename) ;read complete CFG code

	  $a_CFG_Read = _StringBetween($s_CFG_Content, $v_section_A, $v_section_B) ;get current value
	  If IsArray($a_CFG_Read) Then $s_CFG_Return = StringReplace($s_CFG_Content, $a_CFG_Read[0], $s_value) ;replace with new value

	  ;Write new content to file
	  If $s_CFG_Return <> "" Then
		 $v_filename_Out = FileOpen($v_filename, 256+2) ;UTF-8 berücksichtigen und alten Inhalt löschen
		 FileWrite($v_filename_Out, $s_CFG_Return)
		 FileClose($v_filename_Out)
	  Else ;no content to write -> set @error
		 SetError(1)
	  EndIf

   Else ;No file! Create file with desired value. Maybe it works...
	  FileWrite($v_filename, "")
	  $v_filename_Out = FileOpen($v_filename, 256+2) ;UTF-8 berücksichtigen und alten Inhalt löschen
	  FileWrite($v_filename_Out, $v_section_A & $s_value & $v_section_B)
	  FileClose($v_filename_Out)

   EndIf
EndFunc