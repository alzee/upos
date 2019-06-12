@echo off

:: Variables
set pos_exe=MTpos_jh.exe
set pos_bat=pos.bat
set "pos_path=d:\KSOA POS\"
set "update_pos_bat=\\192.168.10.55\s\src\update_pos.bat"

:: Is Windows XP?
ver | find "5.1" > nul 
if %errorlevel% equ 0 (
set "pos_lnk_old=%USERPROFILE%\×ÀÃæ\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\×ÀÃæ\%pos_bat%.lnk"
) else (
set "pos_lnk_old=%USERPROFILE%\Desktop\%pos_exe%.lnk"
set "pos_lnk=%USERPROFILE%\Desktop\%pos_bat%.lnk"
)

d:
cd "%pos_path%"

:: Run update_pos.bat
:: copy /Y %update_pos_bat%
%update_pos_bat%

:: run pos
start %pos_exe%