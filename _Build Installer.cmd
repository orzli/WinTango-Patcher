@setlocal & echo off
title Compiling Patcher Resources

set "CURRDIR=%CD%"
set "tmpDir=%CD%\_tmp"
set "FILENAME=WinTango-Patcher-LATEST"

cd /d ".\project"

echo Compressing Installer...
CALL _CompileAu3.cmd

cd /d %CURRDIR%

:installer-files
md "%tmpDir%\Themes"
md "%tmpDir%\Tools"
md "%tmpDir%\Icons"
md "%tmpDir%\Lang"
xcopy "%CURRDIR%\project\Icons" "%tmpDir%\Icons" /S /Y
xcopy "%CURRDIR%\project\Lang" "%tmpDir%\Lang" /S /Y
move "%CURRDIR%\project\Patcher.exe" "%tmpDir%"
move "%CURRDIR%\project\PatcherCPL.exe" "%tmpDir%"
move "%CURRDIR%\project\Updater.exe" "%tmpDir%"
copy "%CURRDIR%\project\filesApps.ini" "%tmpDir%"
copy "%CURRDIR%\project\filesWindows.ini" "%tmpDir%"
copy "%CURRDIR%\Changelog.txt" "%tmpDir%"
copy "%CURRDIR%\project\Release Notes.txt" "%tmpDir%"
copy "%CURRDIR%\project\_Tools\7z.dll" "%tmpDir%\Tools"
copy "%CURRDIR%\project\_Tools\7z.exe" "%tmpDir%\Tools"
copy "%CURRDIR%\project\_Tools\ResHacker.exe" "%tmpDir%\Tools"
copy "%CURRDIR%\project\_Tools\UltraUXThemePatcher.exe" "%tmpDir%\Tools"
copy "%CURRDIR%\project\_Tools\UXTheme_Multi-Patcher.exe" "%tmpDir%\Tools"
if exist %FILENAME%.exe del /f /q %FILENAME%.exe

::Building Installer
cd /d %CURRDIR%
.\project\_Sfx\7z a -mx9 "%FILENAME%.7z" "%tmpDir%\*"
copy /b ".\project\_Sfx\7zsd_All.sfx" + ".\project\_Sfx\7zSfxCode.txt" + "%FILENAME%.7z" "%FILENAME%.exe"
.\project\_Sfx\upx\upx --best "%FILENAME%.exe"
del "%FILENAME%.7z"
.\project\_Sfx\7z a -mx9 "%FILENAME%.7z" "%FILENAME%.exe"


:cleanup
rd /s /q "%tmpDir%"