#!/bin/bash
Response='{"tool-version":"5.329.1309","tool-path":"\/Applications\/Xcode.app\/Contents\/SharedFrameworks\/ContentDeliveryServices.framework\/Versions\/A\/Frameworks\/AppStoreService.framework","success-message":"No errors uploading \/Users\/nayanbhut\/Documents\/Nayan Projects\/Projects\/GMG\/IPA\/2022-04-27 18-27-10\/Sun & Sand Sports.ipa","os-version":"12.3.1"}'
# echo "$Response"
#SUCCESS=$(echo $Response | python -c "import sys, json; print json.load(sys.stdin)['success-message']")
SUCCESS=$(echo $Response | python3 -c "import sys, json; print(json.load(sys.stdin)['success-message'])") #python3
#--verbose

if [ -z "$SUCCESS" ]
then
clear
Error=$(echo "$Response" | python parse.py)
echo "$Error"
osascript -e "display notification \"$Error\""
return 1
else
echo "\$SUCCESS is NOT empty"
osascript -e 'display notification "Diawi is Uploaded"'
fi
