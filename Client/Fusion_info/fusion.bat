@echo off 
::yincang pichuli benshen chuangkou
if "%1"=="h" goto begin 
start mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit 
:begin

:: start_get_admin_access
setlocal
set uac=~uac_permission_tmp_%random%
md "%SystemRoot%\system32\%uac%" 2>nul

if %errorlevel%==0 ( rd "%SystemRoot%\system32\%uac%" >nul 2>nul ) else (
 
   echo set uac = CreateObject^("Shell.Application"^)>"%temp%\%uac%.vbs"
   
   echo uac.ShellExecute "%~s0","","","runas",1 >>"%temp%\%uac%.vbs"
  
   echo WScript.Quit >>"%temp%\%uac%.vbs"
   
   "%temp%\%uac%.vbs" /f
    
del /f /q "%temp%\%uac%.vbs" & exit )

endlocal

:: panduan fuwu shifou cunzai
SC QUERY FusionInventory > NUL 
IF ERRORLEVEL 1060 GOTO NOTEXIST 
GOTO EXIST 

::panduan xitong leixing
:NOTEXIST 
if /i "%PROCESSOR_IDENTIFIER:~0,3%" == "X86" goto x86
if /i "%PROCESSOR_IDENTIFIER:~0,3%" NEQ "X86" goto x64

:x86
echo "----------------------------------"
echo "you computer is X32" 
echo "----------------------------------"
echo "install fusioninventory-agent_windows-x86_2.4"
%cd%\fusioninventory-agent_windows-x86_2.4 /acceptlicense /add-firewall-exception /execmode=Service /runnow /server='http://10.7.121.189/plugins/fusioninventory' /no-start-menu /installtasks=Inventory,Deploy,Collect,ESX,NetDiscovery,NetInventory,WakeOnLan /S
echo "install  sccession!!" 
ping -n 3 127.1>nul
echo "send computer infomation to server"
echo "please wait!~~ don't close the windos !!" 
call "C:\Program Files\FusionInventory-Agent\fusioninventory-agent.bat"
echo "----------------------------------"
echo "send sccession thinks!!!!"
ping -n 2 127.1>nul
exit


:x64
echo "----------------------------------"
echo "you computer is X64" 
echo "----------------------------------"
echo "install fusioninventory-agent_windows-x64_2.4-rc2.exe"
%cd%\fusioninventory-agent_windows-x64_2.4-rc2.exe /acceptlicense /add-firewall-exception /execmode=Service /runnow /server='http://10.7.121.189/plugins/fusioninventory' /no-start-menu /installtasks=Inventory,Deploy,Collect,ESX,NetDiscovery,NetInventory,WakeOnLan /S

echo "install  sccession!!" 
ping -n 3 127.1>nul
echo "send computer infomation to server"
echo "please wait!~~ don't close the windos !!" 
echo "About a few seconds!!" 
call "C:\Program Files\FusionInventory-Agent\fusioninventory-agent.bat"
echo "----------------------------------"
echo "send sccession thinks!!!!"
ping -n 3 127.1>nul
exit 
  


GOTO END 

:EXIST 
echo "start FusionInventory Agent"
echo "----------------------------------"
echo "----------------------------------"
net start "FusionInventory Agent
GOTO END 
exit

:END 
exit