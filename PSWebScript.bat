@echo off
set SOURCE="{WebScript}"
net session >nul 2>&1
if %errorLevel% == 0 (
    powershell Set-ExecutionPolicy bypass
	powershell Invoke-WebRequest -Uri "%SOURCE%" -OutFile "%SYSTEMROOT%\Temp\PSWebScript_%random%%random%.ps1"
	powershell "%SYSTEMROOT%\Temp\PSWebScript_%random%%random%.ps1"
	powershell Remove-Item "%SYSTEMROOT%\Temp\PSWebScript_%random%%random%.ps1" -Force
	powershell Set-ExecutionPolicy restricted
) else (
    echo Error: elevated permissions recquired to initiate script.
)
exit /b %errorLevel%
