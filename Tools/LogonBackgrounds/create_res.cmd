@echo off
title Creating Backgrounds

set "FileIn=InputImage.jpg"

echo Creating backgrounds for imageres.dll...

::5031 - 1280x1024
call :processing 5031 x1024 1280x1024

::5032 - 1280x960
call :processing 5032 x960 1280x960

::5033 - 1024x768
call :processing 5033 x768 1024x768

::5034 - 1600x1200
call :processing 5034 x1200 1600x1200

::5035 - 1440x900
call :processing 5035 x900 1440x900

::5036 - 1920x1200
call :processing 5036 x1200 1920x1200

::5037 - 1280x768
call :processing 5037 1280 1280x768

::5038 - 1360x768
call :processing 5038 1360 1360x768

exit

:processing
convert.exe -resize %2 %FileIn% %1_tmp.jpg
convert.exe -gravity center -extent %3 %1_tmp.jpg %1.jpg
del /Q %1_tmp.jpg

::convert.exe -resize x1024 %FileIn% 5031_tmp.jpg
::convert.exe -gravity center -extent 1280x1024 5031_tmp.jpg 5031.jpg