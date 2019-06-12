@echo off
echo Start running %0 !!!
set "newfile=\\192.168.10.55\s\pos\ybDevice.702.dll"
set oldfile=ybDevice.dll

:: echo %cd%
mkdir "%pos_path%"
d:
cd "%pos_path%"

:: Copy pos.bat to local d:\KSOA POS\
copy /Y \\192.168.10.55\s\pos.bat

:: Create lnk of pos.bat to desktop if not exist
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\%pos_exe%.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%pos_path%%pos_bat%" >> %SCRIPT%
echo oLink.IconLocation = "%pos_path%%pos_exe%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

copy  /Y "%newfile%" %oldfile%
pause

:: Remove alipay*.log
del alipay2*.log

