@echo off
set "newfile=%server%\pos\ybDevice.702.dll"
set "oldfile=ybDevice.dll"
set "updateid=updateid_20190613b"

if exist %updateid% exit /b

call :is_xp
call :create_lnk
call :cp_pos_bat
call :update_file %newfile% %oldfile%
call :rm_logs
call :updateid

exit /b %errorlevel%

REM Define Functions
:: Copy pos.bat to local d:\KSOA POS\
:cp_pos_bat
copy /Y "%server%\src\pos.bat"
exit /b %errorlevel%

:: Remove 'MTpos_jh.exe.lnk' on desktop
:rm_lnk_old
del "%pos_lnk_old%" 2> nul
exit /b %errorlevel%

:: Create lnk of pos.bat to desktop if not exist
:create_lnk
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%pos_lnk_old%" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%pos_path%\%pos_bat%" >> %SCRIPT%
echo oLink.IconLocation = "%pos_path%\%pos_exe%" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
exit /b %errorlevel%

:: Update
:update_file
copy /Y "%1" "%2"
exit /b %errorlevel%

:: Remove alipay*.log
:rm_logs
del alipay2*.log 2> nul
exit /b %errorlevel%

:: Create a file named %updateid%
:updateid
del updateid_* 2> nul
copy /Y NUL %updateid% > NUL
:: echo. 2> %updateid%
exit /b %errorlevel%

:: Is Windows XP?
:is_xp
ver | find "5.1" > nul 
if %errorlevel% equ 0 (
set "pos_lnk_old=%USERPROFILE%\×ÀÃæ\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\×ÀÃæ\%pos_bat%.lnk"
) else (
set "pos_lnk_old=%USERPROFILE%\Desktop\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\Desktop\%pos_bat%.lnk"
)
exit /b %errorlevel%
