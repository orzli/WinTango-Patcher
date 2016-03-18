@setlocal & echo off
title Compiling Patcher Resources

set "CURRDIR=%CD%"
set "tmpDir=%CD%\_tmp"
set "FILENAME=WinTango-Patcher-LATEST"

cd /d ".\project\_Resources"

echo Compressing Resources...
CALL _BuildRessources.exe
move "%CURRDIR%\project\_Resources\_ARCHIVES\*.7z" "%CURRDIR%"