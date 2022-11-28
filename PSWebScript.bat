@echo off
set SOURCE="{WebScript}"
set OUT_TMP="%SYSTEMROOT%\Temp\PSWebScript_%RANDOM%%RANDOM%.ps1"
net session >nul 2>&1
if %errorLevel% == 0 (
	powershell Set-ExecutionPolicy bypass
	powershell Invoke-WebRequest -Uri "%SOURCE%" -OutFile "%OUT_TMP%"
	powershell "%OUT_TMP%"
	powershell Remove-Item "%OUT_TMP%" -Force
	powershell Set-ExecutionPolicy restricted
) else (
    echo Error: elevated permissions recquired to initiate script.
)
exit /b %errorLevel%
