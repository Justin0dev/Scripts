powershell -ExecutionPolicy Bypass -Command "Get-WmiObject -Class Win32_StartupCommand | Select-Object -Property Name, Command, Location | Format-Table -AutoSize"
