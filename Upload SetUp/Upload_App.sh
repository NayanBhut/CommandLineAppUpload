#!/bin/bash

Now_Date=$(date +%Y-%m-%d\ %H-%M-%S)

email=''
password='' #App Specific

project_path="**/Source Code/*"
IPA_Export_Path="**/IPA/$Now_Date"
IPA_Path="**IPA/$Now_Date/*.ipa"
project_name='Test_Project'
archieve_path="**/$project_name.xcarchive"
export_plist="ExportOptions_Automatic.plist"
team_ID="ABCD1234"
version="1.4.1"
tempDir="**/IPA/TempApp"
python_parse="parse.py"




#!/bin/bash

#error: 

Now_Date=$(date +%Y-%m-%d\ %H-%M-%S)

# App Store Credential
email=''
password='' #App Specific
team_ID="ABCD1234"

#Upload Folder Path
upload_Script_Path=$(pwd) # "/Users/nayanbhut/Desktop/Upload/App" #pwd

# Project Code Path
project_Folder_name="Test_Project_Folder_Root"
project_root="/Users/**/Documents/** Projects/Projects/**"
project_path="$project_root/Source Code/$project_Folder_name"
plist_Path="$upload_Script_Path/ExportOptions_Automatic.plist"
project_name='Test_Project'

# Archieve Setup
artifact_Root="$project_root/IPA"
archieve_path="$artifact_Root/$project_name.xcarchive"

# IPA Setup
IPA_name="Display_Name.ipa"
IPA_Export_Path="$artifact_Root/$Now_Date"
IPA_Path="$artifact_Root/$Now_Date/$IPA_name"

# Log and Xcpretty
xcpretty="/Users/***/.gem/ruby/2.6.0/bin/xcpretty" 
build_log="xcodebuild.log"

#parsing
python_parse="$upload_Script_Path/appstore_Response.py"

#Temp DK
tempDir="/Users/**/Documents/** Projects/Projects/**/IPA/TempFolder"

#version
version="1.4.1"



#xcrun altool --list-providers -u "$email" -p "$password" Get list of team ids

function setupCode() {
    rm -rf "$tempDir"
    rm -rf "$archieve_path"

    cp  -R "$project_path" "$tempDir"
    cd "$tempDir"

    xcodebuild -list

    #Change Email and password
    echo "Please select Project Scheme"
    read project_scheme

    echo "Please Insert Short version number"
    read version
    xcrun agvtool new-version -all "$version"
    echo "$version"

    echo "Please Insert Version number"
    read market_version
    xcrun agvtool new-marketing-version "$market_version"
    echo "$version"

    updateIPAPath

    echo "$IPA_name"
    echo "IPA Path Name is IDKis : ${IPA_Path}"

    cleanProject
}

function updateIPAPath() {
    case $project_scheme in
        Scheme1)
        echo -n "Display_Name1"
        IPA_name="Display_Name1.ipa" #BUNDLE_NAME Plist
        ;;

    'Scheme2')
        echo -n "Display_Name2"
        IPA_name="Display_Name2.ipa" #BUNDLE_NAME Plist
        ;;

    'Scheme3')
        echo -n "Display_Name3"
        IPA_name="Display_Name3.ipa" #BUNDLE_NAME Plist
        ;;

    *)
        echo -n "unknown"
    ;;
    esac
    IPA_Path="$artifact_Root/$Now_Date/$IPA_name"
}

function getIPAPath() {
    echo "path is ${build_path}"
    cleanProject
    updateIPAname
}

function cleanProject() {
    echo "cleanProject"
    echo "⚠️ Clean ⚠️"
    xcodebuild clean -workspace "$project_name".xcworkspace -scheme "$project_scheme"
    STR=$'⚠️ Clean Done'
    echo "$STR"
    archieveProject
}

function archieveProject() {
    echo "archieveProject"
    echo "⚠️ Archieve ⚠️"
    osascript -e 'display notification "App Build Archieve..." with title "App Build Archieving"'
    xcodebuild -workspace "$project_name".xcworkspace -scheme "$project_scheme" -archivePath "$archieve_path" archive -destination 'generic/platform=iOS' -allowProvisioningUpdates | tee "$build_log" | "$xcpretty" 
    
    isArchieveAvailable
}

function isArchieveAvailable() {
    if [ -a "$archieve_path" ]; 
    then
        STR=$'⚠️ Archieve Done \n\n'
        say "Archieve Done"
        echo "$STR"
        createIPA
    else 
        clear && echo -en "\e[3J"
        grep --color=always "error" "$build_log"
        rm -rf "$tempDir"
        STR=$'Archieve not created \n\n'
        say "Archieve not created"
        echo "$STR"
    fi
}

function createIPA() {
    echo "createIPA"
    echo “⚠️ IPA ⚠️”
    osascript -e 'display notification "App IPA…" with title "Creating IPA.."'
    xcodebuild -exportArchive -archivePath "$archieve_path" -exportPath "$IPA_Export_Path" -exportOptionsPlist "$plist_Path" -allowProvisioningUpdates
    STR=$'IPA Done \n\n'
    say "IPA Done"
    echo "$STR"
    isIPAAvailable
}

function isIPAAvailable() {
    if [ -a "$IPA_Export_Path" ]; 
    then
        uploadIPA
    else 
        STR=$'IPA not created \n\n'
        say "IPA not created"
        echo "$STR"
    fi
}

function uploadIPA() {
    
    echo "uploadIPA"
    echo “⚠️ Uploading IPA ⚠️”
    say "Uploading IPA"
    osascript -e 'display notification "Uploading Start…" with title "Uploading App"'

    echo "$IPA_Path"

    Response=$(xcrun altool --upload-app -f "$IPA_Path" -t ios -u "$email" -p "$password" --asc-provider "$team_ID" --output-format json --show-progress)
    echo "$Response"
    SUCCESS=$(echo $Response | python -c "import sys, json; print json.load(sys.stdin)['success-message']")
    checkUploadStatus "$SUCCESS" #Passing param to function
    #--verbose
}

function checkUploadStatus() {
if [ -z "$1" ] # $0 is function name $1...$n params
    then
    clear
    Error=$(echo "$Response" | python "$python_parse")
    echo "$Error"
    osascript -e "display notification \"$Error\""
    say "Upload Failed!"

    return 1
else
    echo "$1"
    osascript -e 'display notification "Build is uploaded to Test Flight"'
    say "Upload Success!"
fi
}

setupCode
