@echo off

set lnk_path=%ProgramFiles%\internet explorer\iexplore.exe baidu.com

call :is_xp
echo %lnk%
call :create_lnk

pause

exit /b %errorlevel%

REM Define Functions

:create_lnk
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%lnk%" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%lnk_path%" >> %SCRIPT%
:: echo oLink.IconLocation = %lnk_path% >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
exit /b %errorlevel%

:: Is Windows XP?
:is_xp
ver | find "5.1" > nul 
if %errorlevel% equ 0 (
set "lnk=%USERPROFILE%\����\ʮ��ҽ�����������Ϣ����ϵͳ.lnk"
) else (
set "lnk=%USERPROFILE%\Desktop\ʮ��ҽ�����������Ϣ����ϵͳ.lnk"
)
exit /b %errorlevel%
