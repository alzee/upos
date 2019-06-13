@echo off

:: Variables
set "pos_exe=MTpos_jh.exe"
set "pos_bat=pos.bat"
set "pos_path=d:\KSOA POS"
set "server=\\192.168.10.55\s"
set "update_pos_bat=%server%\src\update_pos.bat"
set "online_flag=online_flag"

d:
cd "%pos_path%"

:: If can not connect to %server% in 2 seconds, don't run %update_pos_bat%
del %online_flag%
start /min if exist "%update_pos_bat%" echo. 2> %online_flag%
timeout /t 2
if exist %online_flag% call "%update_pos_bat%"

:: run pos
start "" "%pos_exe%"
