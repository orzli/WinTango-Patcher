@setlocal & echo off
title Compiling Patcher

set "CURRDIR=%CD%"
set "tmpDir=%CD%\_tmp"
set "FILENAME=WinTango-Patcher-LATEST"

cd /d ".\project\_Resources"

echo Compressing Resources...
CALL _BuildResources.exe
md "%CURRDIR%\project\Themes"
move "%CURRDIR%\project\_Resources\_ARCHIVES\*.7z" "%CURRDIR%\project\Themes"

cd /d "..\"

echo Building Installer...
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
if exist %FILENAME%-offline.exe del /f /q %FILENAME%-offline.exe

::Building Offline-Installer
cd /d %CURRDIR%
xcopy "%CURRDIR%\project\Themes" "%tmpDir%\Themes" /S /Y
.\project\_Sfx\7z a -mx9 "%FILENAME%-offline.7z" "%tmpDir%\*"
copy /b ".\project\_Sfx\7zsd_All.sfx" + ".\project\_Sfx\7zSfxCode.txt" + "%FILENAME%-offline.7z" "%FILENAME%-offline.exe"
.\project\_Sfx\upx\upx --best "%FILENAME%-offline.exe"
del "%FILENAME%-offline.7z"


:cleanup
rd /s /q "%tmpDir%"
rd /s /q "%CURRDIR%\project\Themes"