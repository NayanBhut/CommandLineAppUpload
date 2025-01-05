# -*- coding: utf-8 -*-
import sys, json; 

# if len(sys.argv) == 2:
# 	Response = sys.argv[1]
# 	# print("Part 1")
# else:
# 	print("Data Not Found")
# 	print("Part 2")
# 	sys.exit()
# print("Part 2")

# print(sys.stdin)
json_as_str = input()
request = json.loads(json_as_str)


arrErrors = request["product-errors"]
c = ""

for error in arrErrors:
    c = c + error['message']

x = c.replace("\"","")
print(x)
