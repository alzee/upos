@echo off

:: Variables
set "pos_exe=MTpos_jh.exe"
set "pos_bat=pos.bat"
set "pos_path=d:\KSOA POS"
set "server=\\192.168.10.55\s"
set "update_pos_bat=%server%\src\update_pos.bat"

d:
cd "%pos_path%"

:: Run update_pos.bat
"%update_pos_bat%"

:: run pos
start "%pos_exe%"