@echo off 

set "AutoItPath=C:\Program Files (x86)\AutoIt3\Aut2Exe"
set "ScriptDir=%CD%"

cd /d %AutoItPath%
start /wait Aut2exe.exe /in "%ScriptDir%\IconCreator.au3" /out "%ScriptDir%\IconCreator.exe" /icon "%ScriptDir%\x-package-repository_+24_256.ico" /x86 /gui