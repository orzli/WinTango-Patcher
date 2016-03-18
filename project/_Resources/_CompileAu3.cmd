@echo off 
setlocal

set "AutoItPath=C:\Program Files (x86)\AutoIt3\Aut2Exe"
set "ScriptDir=%CD%"

if exist "_BuildRessources.exe" del /q /f "_BuildRessources.exe"

cd /d %AutoItPath%

start /wait Aut2exe.exe /in "%ScriptDir%\_BuildRessources.au3" /x86