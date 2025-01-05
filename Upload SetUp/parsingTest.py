import json
  
# JSON string
employee ='{"id":"09", "name": "Nitin", "department":"Finance"}'
jsondata = '{"tool-version":"5.329.1309","tool-path":"\/Applications\/Xcode.app\/Contents\/SharedFrameworks\/ContentDeliveryServices.framework\/Versions\/A\/Frameworks\/AppStoreService.framework","success-message":"No errors uploading \'\/Users\/nayanbhut\/Documents\/Nayan Projects\/Projects\/GMG\/IPA\/2022-04-27 18-27-10\/Sun & Sand Sports.ipa\'","os-version":"12.3.1"}'
  
# Convert string to Python dict
employee_dict = json.loads(employee)
print(employee_dict)
  
print(employee_dict['name'])

# Convert string to Python dict
jsondata_dict = json.loads(jsondata)
print(jsondata_dict)
  
print(jsondata_dict['tool-path'])
print(jsondata_dict['tool-version'])
print("\n")
print(jsondata_dict['os-version'])