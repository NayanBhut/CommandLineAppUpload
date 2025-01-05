# CommandLineAppUpload

Check xcode is installed in the mac and selected.
If not selected try beload command to select specific xcode or update
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
                                or 
You can go to Xcode ➙ Preferences… ➙ Locations and pick one of the options for Command Line Tools to set the location.

Files Needed For Setup TestFlight Upload
    
    1) Upload File (.sh)
    2) Parsing File (.py)
    3) Demo testResponse and ExportOptions.Plist

Setup TestFlight Upload : 
    
    1. Set The Credential
        1) Email and App Specific password
    2. Set the Paths
        1) Project Root Folder
        2) IPA Export Folder 
        3) IPA Path ( Generated IPA) 
        4) Project Name 
        5) Archieve Path ( Generated Archieve)  
        6) Export Option Plist (Auto and Manual setup)
        7) Team Id to Upload
        8) Python Parsing file
        9) Temp Dir For Upload
    3) Set available Project Schemes
        1) Go to updateIPAPath function and add or remove schemes as per switch case
    4) Setup ExportOptions.Plist for manual or automatic code sign
        1) Check the demo file 
