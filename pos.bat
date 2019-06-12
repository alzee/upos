@echo off

:: Variables
set pos_exe=MTpos_jh.exe
set pos_bat=pos.bat
set "pos_path=d:\KSOA POS\"
set "pos_lnk_old=%USERPROFILE%\桌面\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\桌面\%pos_bat%.lnk"
set "update_pos_bat=\\192.168.10.55\s\update_pos.bat"

echo %pos_lnk%

pause
exit

d:
cd "%pos_path%"

:: Run update_pos.bat
:: copy /Y %update_pos_bat%
%update_pos_bat%

:: run pos
::start %pos_exe%

:: Remove lnk of 'MTpos_jh.exe' on desktop
::del %pos_lnk_old%
