@echo off 
setlocal

set "AutoItPath=C:\Program Files (x86)\AutoIt3\Aut2Exe"
set "ScriptDir=%CD%"

if exist "Patcher.exe" del /q /f "Patcher.exe"
if exist "PatcherCPL.exe" del /q /f "PatcherCPL.exe"
if exist "Updater.exe" del /q /f "Updater.exe"

cd /d %AutoItPath%

echo Compiling "Patcher.exe"...
start /wait Aut2exe.exe /in "%ScriptDir%\Patcher.au3" /icon "%ScriptDir%\Patcher.ico" /x86 /gui

echo Compiling "PatcherCPL.exe"...
start /wait Aut2exe.exe /in "%ScriptDir%\PatcherCPL.au3" /icon "%ScriptDir%\Patcher.ico" /x86 /gui

echo Compiling "Updater.exe"...
start /wait Aut2exe.exe /in "%ScriptDir%\Updater.au3" /icon "%ScriptDir%\Updater.ico" /x86 /gui