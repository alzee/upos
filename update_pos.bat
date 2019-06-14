@echo off
set "newfile=%server%\pos\ybDevice.702.dll"
set "oldfile=ybDevice.dll"
set "updateid=updateid_20190614b"

if exist %updateid% exit /b

echo "系统升级中...请稍等！"

call :is_xp
call :create_lnk
call :cp_pos_bat
call :update_file %newfile% %oldfile%
call :rm_alipay_logs
call :del_old_files
call :updateid

exit /b %errorlevel%

REM Define Functions
:: Copy forfiles.exe
:cp_forfiles
set forfiles=%server%\misc\forfiles.exe
copy %forfiles% %windir%\system32 > nul
exit /b %errorlevel%

:del_old_files
if not exist %windir%\system32\forfiles.exe call :cp_forfiles
echo Deleting old logs in "%pos_path%\Logs"...
forfiles /p "%pos_path%\Logs" /D -60 /C "cmd /c del @path"
exit /b %errorlevel%

:: Delete file with specified .ext and modified after specified date
:del_old_files_xcopy
set date=04-01-2019
set ext=log
set tmpdir=%RANDOM%%RANDOM%
md %tmpdir%
xcopy /D:%date% *.%ext% %tmpdir% > nul
del *.%ext%
move %tmpdir%\*.%ext% .
rd /s /q %tmpdir%
exit /b %errorlevel%

:: Copy pos.bat to local d:\KSOA POS\
:cp_pos_bat
echo Replacing %pos_path%\pos.bat...
copy /Y "%server%\src\pos.bat" > nul
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
echo Replacing "%pos_path%\%2%"...
copy /Y "%1" "%2" > nul
exit /b %errorlevel%

:: Remove alipay*.log
:rm_alipay_logs
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
set "pos_lnk_old=%USERPROFILE%\桌面\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\桌面\%pos_bat%.lnk"
) else (
set "pos_lnk_old=%USERPROFILE%\Desktop\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\Desktop\%pos_bat%.lnk"
)
exit /b %errorlevel%
