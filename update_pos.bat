@echo off
echo Start running %0 !!!
set "newfile=%server%\pos\ybDevice.702.dll"
set "oldfile=ybDevice.dll"

:: Is Windows XP?
ver | find "5.1" > nul 
if %errorlevel% equ 0 (
set "pos_lnk_old=%USERPROFILE%\×ÀÃæ\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\×ÀÃæ\%pos_bat%.lnk"
) else (
set "pos_lnk_old=%USERPROFILE%\Desktop\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\Desktop\%pos_bat%.lnk"
)

echo %pos_lnk_old%
echo %pos_lnk%
pause
exit

:: echo %cd%
mkdir "%pos_path%"
d:
cd "%pos_path%"

:: Copy pos.bat to local d:\KSOA POS\
copy /Y "%server%\src\pos.bat"

:: Remove lnk of 'MTpos_jh.exe' on desktop
:: del "%pos_lnk_old%"

:: Create lnk of pos.bat to desktop if not exist
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%pos_lnk_old%" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%pos_path%\%pos_bat%" >> %SCRIPT%
echo oLink.IconLocation = "%pos_path%\%pos_exe%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

:: Update
copy /Y "%newfile%" "%oldfile%"

:: Remove alipay*.log
del alipay2*.log
