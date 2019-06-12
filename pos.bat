@echo off

:: Variables
set pos_exe=MTpos_jh.exe
set pos_bat=pos.bat
set "pos_path=d:\KSOA POS\"
set "pos_lnk_old=%USERPROFILE%\×ÀÃæ\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\×ÀÃæ\%pos_bat%.lnk"
set "update_pos_bat=\\192.168.10.55\s\src\update_pos.bat"

d:
cd "%pos_path%"

:: Run update_pos.bat
:: copy /Y %update_pos_bat%
%update_pos_bat%

:: run pos
::start %pos_exe%
