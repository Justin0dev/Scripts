# PowerShell script to list the last 15 logons

$computer = $env:computername
$logons =  Get-WinEvent -FilterHashtable @{LogName='Security';ID=4624} -MaxEvents 15 | 
    Select-Object TimeCreated,@{n='Username';e={[Security.Principal.WindowsIdentity]::GetCurrent().Name}}

# Display the logon events
$logons | Format-Table -AutoSize
