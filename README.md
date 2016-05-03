# cleanProfiles
A script to delet ProfileList entries that do not have a correspondend profile folder

Someone deleted some roaming profiles on our terminalservers.  
The intetion was to clean up.  
But the profiles where deleted manually from the filesystem.  
So the ProfileList Keys still existed.  
The user profile service couln't find the profile that was mentioned in  
the registry and in this case loaded a temporary profile.  

The script simply loads all subkeys unter ProfileList.  
Filters them for entries where the ProfileImagePath contains "c:\users\"  
After that the content of ProfileImagePath is checked for an correpsondend profile folder.  
If it doesn't exist a prompt asks if the key should be deleted.

