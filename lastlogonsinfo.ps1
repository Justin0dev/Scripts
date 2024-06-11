# PowerShell script to list the last 15 logons

$logons =  Get-WinEvent -FilterHashtable @{LogName='Security';ID=4624} -MaxEvents 15

$logons = $logons | ForEach-Object{
  $Properties = $_.Properties
  $user = $Properties | Where-Object {$_.Value -eq 'TargetUserName'} | Select-Object -ExpandProperty Value
  $time = $_.TimeCreated
  $timeLogoff = $Properties | Where-Object {$_.Value -eq 'TargetLogoffTime'} | Select-Object -ExpandProperty Value
  $duration = $timeLogoff - $time
  
  [PSCustomObject]@{
    'Username' = $user
    'Time' = $time
    'Duration' = $duration
  }
}

# Display the logon events
$logons | Format-Table -AutoSize
