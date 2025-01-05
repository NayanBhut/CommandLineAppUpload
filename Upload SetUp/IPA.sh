#!/bin/bash
#<< 'MULTILINE-COMMENT'
#MULTILINE-COMMENT

Archieve_Path="/Users/nayanbhut/Desktop/Medznat.xcarchive"
exportPath="/Users/nayanbhut/Desktop"
exportPlistPath="/Users/nayanbhut/Documents/Nayan\ Projects/Projects/Medznat/Medznat.plist"
Diawee_token="Diawi_Token"
callback_emails="test@email.com"

cd "Project Path"

echo "Clean"
xcodebuild clean -workspace **.xcworkspace -scheme **
STR=$'Clean Done\n\n'
echo "$STR"

#echo "Build Start"
#xcodebuild build -workspace **.xcworkspace -scheme ** -destination 'generic/platform=iOS'
#STR=$'Build Done \n\n'
#echo "$STR"

#Simulator Build
#xcodebuild -sdk iphonesimulator -workspace **.xcworkspace/ -scheme ** -configuration Debug

echo “Archieve”
xcodebuild -workspace Medznat.xcworkspace -scheme ** -archivePath **.xcarchive archive -destination 'generic/platform=iOS'
STR=$'Archieve Done \n\n'
echo "$STR"

echo “IPA”
xcodebuild -exportArchive -archivePath "$Archieve_Path" -exportPath "$exportPath" -exportOptionsPlist "$exportPlistPath"
STR=$'IPA Done \n\n'
echo "$STR"

cd
cd Desktop

STR=$'IPA Uploading \n\n'
echo "$STR"

upload_Diawi () {
cd
cd Desktop
result=$(curl https://upload.diawi.com/ -F token='$Diawee_token' \
-F file=@**.ipa \
-F callback_emails='$callback_emails')
echo "Response from server"
echo $result

SUCCESS=$(echo $result | python -c "import sys, json; print json.load(sys.stdin)['job']")
echo $SUCCESS

if [ -z "$SUCCESS" ]
then
echo "\$var is empty"
osascript -e 'display notification "Diawi is not Uploaded. please retry"'
upload_Diawi
return 1
else
echo "\$var is NOT empty"
osascript -e 'display notification "Diawi is Uploaded"'
fi

STR=$'IPA Uploading Done \n\n'
echo "$STR"

#<< 'MULTILINE-COMMENT'
#MULTILINE-COMMENT





Now_Date=$(date +%Y-%m-%d\ %H-%M-%S)
echo "$Now_Date"

STRDate="Medznat $Now_Date"
echo "$STRDate"

mkdir "$STRDate"

#mv ~/Desktop/Medznat.xcarchive ~/Desktop/"$STRDate"
mv ~/Desktop/DistributionSummary.plist ~/Desktop/"$STRDate"
mv ~/Desktop/ExportOptions.plist ~/Desktop/"$STRDate"
mv ~/Desktop/Medznat.ipa ~/Desktop/"$STRDate"
mv ~/Desktop/Packaging.log ~/Desktop/"$STRDate"

mv ~/Desktop/"$STRDate" ~/Documents/Nayan\ Projects/Projects/Medznat/IPA

}

#Diawi Upload Script. Email nayan.bhut@brainvire.com
upload_Diawi

#rm -rf ~/Desktop/**.xcarchive
#rm -rf ~/Desktop/DistributionSummary.plist
#rm -rf ~/Desktop/ExportOptions.plist
#rm -rf ~/Desktop/Packaging.log


#mv ~/Desktop/**.xcarchive ~/Desktop/"$STRDate"
#mv ~/Desktop/DistributionSummary.plist ~/Desktop/"$STRDate"
#mv ~/Desktop/ExportOptions.plist ~/Desktop/"$STRDate"
#mv ~/Desktop/Packaging.log ~/Desktop/"$STRDate"





build_path="/Users/**/Desktop/Upload/test.text"


# Update the project path if there is already ipa or xcarchieve
# add the Radio changes here
echo 'Please enter your choice: '
options=("Upload Old Build" "Upload New Build")

for ((i=0; i < ${#options[@]}; i++ )); do echo "$i : ${options[$i]}"; done

read opt
case "${options[$opt]}" in
        "Upload Old Build")
            echo "you choice is ${options[$opt]}"
            # source "/Users/nayanbhut/Desktop/IPA.sh"
            touch build_path
            # touch "${pwd}path.text"
            break
            ;;
        "Upload New Build")
            echo "you choice is ${options[$opt]}"
            # source "/Users/nayanbhut/Desktop/Upload.sh"
            rm -rf  build_path
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac

return

# changes done



