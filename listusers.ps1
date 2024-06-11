# PowerShell script to list all users on the system

# Get the list of users
$users = Get-WmiObject -Class Win32_UserAccount

# Initialize an empty array to store the output
$output = @()

# Loop through the list of users
foreach ($user in $users) {
    # Get the last logon time for each user
    $lastLogon = (Get-WmiObject -Class Win32_UserProfile -Filter "SID='$($user.SID)'" | Select-Object -ExpandProperty LastUseTime).DateTime

    # Get the user's group membership
    $groups = (Get-WmiObject -Class Win32_GroupUser -Filter "PartComponent='Win32_UserAccount.Domain='$($user.Domain)',Name='$($user.Name)'`'" | Select-Object -ExpandProperty GroupComponent) -replace "Win32_Group.Domain='[^']+',Name='", "" -replace "'", ""

    # Determine if the user is an administrator
    $isAdmin = $false
    if ($groups -contains "Administrators") {
        $isAdmin = $true
    }

    # Create an object to store the user's information
    $userInfo = [PSCustomObject]@{
        'Username' = $user.Name
        'IsAdmin' = $isAdmin
        'LastLogon' = $lastLogon
    }

    # Add the user's information to the output array
    $output += $userInfo
}

# Display the output
$output | Format-Table -AutoSize

# Keep the PowerShell window open
Start-Sleep -Seconds 3600
