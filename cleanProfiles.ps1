try{
    $keys=Get-ChildItem -Path 'hklm:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList' -Recurse -ErrorAction Stop
}catch{
    write-host $_.Exception.Message
}
$profiles=get-itemproperty $keys.PSPath| Where-Object -FilterScript {($_.ProfileImagePath -like 'C:\users\*') }

foreach($profile in $profiles){
    $parentPath=$profile.PSParentPath.IndexOf("::")
    if( Test-Path $profile.ProfileImagePath){
        write-host $profile.ProfileImagePath": profile folder exists"
    }else{
        do{
        write-host $profile.ProfileImagePath": profile folder doesn't exist"
        write-host "This could cause problems when the user logs in. A temp profile will be loaded"
        $value=Read-Host -Prompt "Do you want that registry key deleted? (y/n)"
        write-host $value
        }until($value -eq 'y' -or $value -eq 'j' -or $value -eq 'n')
            
        if($value -eq 'y' -or $value -eq 'j'){
            try{
                remove-item "$($profile.PSParentPath.ToString())\$($profile.PSChildName.ToString())" -recurse -ErrorAction Stop
                write-host "Key: $($profile.PSParentPath.Substring($parentPath+2))\$($profile.PSChildName.ToString()) deleted"
            }catch{
                write-host $_.Exception.Message
            }
        }elseif($value -eq 'n'){
            write-host "Key: $($profile.PSParentPath.Substring($parentPath+2))\$($profile.PSChildName.ToString()) not deleted"
        }
    }
}