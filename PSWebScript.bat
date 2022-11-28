@echo off
set SOURCE="{WebScript}"
net session >nul 2>&1
if %errorLevel% == 0 (
	wmic process where (Name="WMIC.exe" AND CommandLine LIKE "%%%TIME%%%") get ParentProcessId /value | find "ParentProcessId" >%T%
	set /P A=<%T%
	set PID=%A:~16%
	powershell Set-ExecutionPolicy bypass
	powershell Invoke-WebRequest -Uri "%SOURCE%" -OutFile "%SYSTEMROOT%\Temp\PSWebScript_%PID%.ps1"
	powershell "%SYSTEMROOT%\Temp\PSWebScript_%PID%.ps1"
	powershell Remove-Item "%SYSTEMROOT%\Temp\PSWebScript_%PID%.ps1" -Force
	powershell Set-ExecutionPolicy restricted
) else (
    echo Error: elevated permissions recquired to initiate script.
)
exit /b %errorLevel%
