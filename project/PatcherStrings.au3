#cs ----------------------------------------------------------------------------

 Strings for the Patcher Apps.

#ce ----------------------------------------------------------------------------

;Global $string_XX = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "XX", "YY")

Func _Strings_Patcher()
   If _GetOSLanguage() = "DE" Then
	  $lang = "german"
   Else
	  $lang = "english"
   EndIf

   ;SingleInstance
   Global $string_msgSingleInstance = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgSingleInstance", "Warning")
   Global $string_msgSingleInstance_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgSingleInstance_msg", "is already running!")

   Global $string_msgExit = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgExit", "Exit")
   Global $string_msgExit_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgExit_msg", "Do you really want to exit the " & $AppName & "?")
   Global $string_msgNoExit_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgNoExit_msg", "You can't cancel the Patcher at this stage!")

   Global $string_msgPatchingDone = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgPatchingDone", "Patching completed.")
   Global $string_msgPatchingDoneRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "msgPatchingDoneRestart", "You need to reboot your system to apply the changes!")
   Global $string_btnRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Patcher", "btnRestart", "Reboot")

   ;GUI

EndFunc


Func _Strings_Reloader()
   If _GetOSLanguage() = "DE" Then
	  $lang = "german"
   Else
	  $lang = "english"
   EndIf

   Global $string_msgReloaderDone = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "msgReloaderDone", "file(s) were reloaded!")
   Global $string_msgReloaderDone2 = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "msgReloaderDone2", "If a file constantly requires reloading, replacement may have failed.")
   Global $string_msgReloaderDoneRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "msgReloaderDoneRestart", "You need to reboot your system to apply the changes!")
   Global $string_btnRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "btnRestart", "Reboot")

   Global $string_msgReloaderSilent = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "msgReloaderSilent", "file(s) were reloaded! You need to reboot to apply the changes. Do you want to reboot now?")

   Global $string_msgReloaderNone = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "msgReloaderNone", "No files needed Reloading. You can close the Reloader now.")
   Global $string_btnClose = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Reloader", "btnClose", "Close")

EndFunc


Func _Strings_Updater()
   If _GetOSLanguage() = "DE" Then
	  $lang = "german"
   Else
	  $lang = "english"
   EndIf

   Global $string_msgChecking = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgChecking", "Checking for new Version...")
   Global $string_msgNoUpdate = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgNoUpdate", "No Update available! The Updater will close now...")
   Global $string_msgYesUpdate = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgYesUpdate", "Update Available")
   Global $string_msgYesUpdate_msg1 = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgYesUpdate_msg1", "is available.")
   Global $string_msgYesUpdate_msg2 = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgYesUpdate_msg2", "Do you want to download this update now?")
   Global $string_msgDownloading = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgDownloading", "Downloading Application Files...")
   Global $string_msgDownloadDone = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Updater", "msgDownloadDone", "Download complete! The Patcher will close now...")

EndFunc


Func _Strings_Uninstaller()
   If _GetOSLanguage() = "DE" Then
	  $lang = "german"
   Else
	  $lang = "english"
   EndIf

   Global $string_msgUninstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "msgUninstall", "Uninstall")
   Global $string_msgUninstall_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "msgUninstall_msg", "Do you really want to completely uninstall the " & $AppName & "?")

   Global $string_msgUninstalling = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "msgUninstalling", "Removing Uninstaller & Backup Files...")
   Global $string_msgUninstallingDone = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "msgUninstallingDone", "Patching completed.")
   Global $string_msgUninstallingDoneRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "msgUninstallingDoneRestart", "You need to reboot your system to apply the changes!")
   Global $string_btnRestart = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "Uninstaller", "btnRestart", "Reboot")

EndFunc


Func _Strings_CPL()
   If _GetOSLanguage() = "DE" Then
	  $lang = "german"
   Else
	  $lang = "english"
   EndIf

   ;SingleInstance
   Global $string_msgSingleInstance = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgSingleInstance", "Warning")
   Global $string_msgSingleInstance_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgSingleInstance_msg", "is already running!")

   ;Tab Actions
   Global $string_TabActions = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "TabActions", "Actions")
   Global $string_lblReload = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReload", "Reload")
   Global $string_lblReloadDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReloadDesc", "Check for modified files and re-patch them")
   Global $string_btnReload = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnReload", "Reload")
   Global $string_lblReloaderStartup = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReloaderStartup", "Run the Reloader on system startup for constant Modding")
   Global $string_lblReinstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReinstall", "Re-Install")
   Global $string_lblReinstallDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReinstallDesc", "Perform a Re-Installation to solve bugs or change the")
   Global $string_btnReInstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnReInstall", "Re-Install")
   Global $string_msgReInstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgReInstall", "Re-Install")
   Global $string_msgReInstall_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgReInstall_msg", "Do you really want to Re-Install the " & $AppName & "?")
   Global $string_lblUpdate = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblUpdate", "Update")
   Global $string_lblUpdateDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblUpdateDesc", "Check for a new version.")
   Global $string_lblVersionInst = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblVersionInst", "Installed Version:")
   Global $string_lblVersionLatest = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblVersionLatest", "Latest Version:")
   Global $string_btnUpdate_a = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnUpdate_a", "Check now")
   Global $string_btnUpdate_b = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnUpdate_b", "Apply Update")
   Global $string_lblUpdateStartup = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblUpdateStartup", "Automatically check for a new version on system startup")
   Global $string_lblUninstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblUninstall", "Uninstall")
   Global $string_lblUninstallDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblUninstallDesc", "Completely remove the Patcher and all of its files")
   Global $string_btnUninstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnUninstall", "Uninstall")
   Global $string_msgUninstall = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgUninstall", "Uninstall")
   Global $string_msgUninstall_msg = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "msgUninstall_msg", "Do you really want to completely Uninstall the " & $AppName & "?")

   ;Tab Help
   Global $string_TabHelp = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "TabHelp", "Help")
   Global $string_lblReadme = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReadme", "Readme")
   Global $string_lblReadmeDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblReadmeDesc", "Get familiar with all the options and effects of the Patcher")
   Global $string_btnReadme = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnReadme", "Open")
   Global $string_lblBugReport = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblBugReport", "Bug Report")
   Global $string_lblBugReportDesc = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblBugReportDesc", "Report any undocumented Bug")
   Global $string_btnBugReport = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "btnBugReport", "File a Report")

   ;Tab About
   Global $string_TabAbout = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "TabAbout", "About")
   Global $string_editDescription = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "editDescription", "The WinTango Patcher is a mostly self-explanatory graphical wizard designed to make simple the process of modifying your system files with resources which were created by the Tango Desktop Project, the GNOME Project, the Gnome-Colors Project, the Elementary Project and many other open-source projects.")
   Global $string_lblContact = IniRead(@ScriptDir & "\lang\" & $lang & ".ini", "CPL", "lblContact", "Contact")

EndFunc
