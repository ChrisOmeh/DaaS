import ipaddress
import os
import pandas as pd

#QUESTION ONE

# If the value is in the range 1 to 127, the address belongs to class A. 
# If the value is in the range 128 to 191, the address belongs to class B.
# If the value is in the range 192 to 223, the address belongs to class C.
# If the value is in the range 224 to 239, the address belongs to class D.

ip_address_array = ["10.250.1.1","150.10.15.0","192.14.2.0","148.17.9.1","193.42.1.1","126.8.156.0","220.200.23.1",
                    "230.230.45.58","177.100.18.4","119.18.45.0","249.240.80.78","199.155.77.56","117.89.56.45",
                    "215.45.45.0","199.200.15.0","95.0.21.90","33.0.0.0","158.98.80.0","219.21.56.0"]
IP_ADDRESS = []
IP_CLASS = []                    
range_table = dict(IP_ADDRESSES=IP_ADDRESS,
                              CLASSES=IP_CLASS)

for ip_addresses in ip_address_array:
     octet_1 = int(ip_addresses.split(".")[0])
     """
     Checking IP Addresses Range
     """
     if octet_1 >=1 or octet_1 <=127:
          print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS A IP ADDRESS")
     elif octet_1 >=128 or octet_1 <=191:
          print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS B IP ADDRESS")
     elif octet_1 >=192 or octet_1 <= 223:
          print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS C IP ADDRESS")
     elif octet_1 >= 224 or octet_1 <= 239:
          print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS D IP ADDRESS")
     elif octet_1 >= 240 or octet_1 <=255:
          print(f"===THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS E IP ADDRESS")
     else:
          print(f"===THE IP ADDRESS {ip_addresses} DOES NOT BELONG TO ANY CLASS IP ADDRESS===")

#CREATING A TABLE FOR THE IP ADDRESS AND THE RANGE
df = pd.DataFrame.from_dict(range_table)

#=================================================================================================================
#QUESTION TWO
ip_addresses_1 = ["188.10.18.2","10.10.48.80","192.149.24.191","150.203.23.19","10.10.10.10","186.13.23.110",
                "223.69.230.250","200.120.135.15","27.125.200.151","199.20.150.35","191.55.165.135","28.212.250.254"]

ip_addresses = ["188.10.18.2","10.10.48.80"]
for ip_add in ip_addresses:
     octet_1 = int(ip_add.split(".")[0])
     """
     Checking IP Addresses Range and subsequently getting the Network Address
     """
     if octet_1 >=1 or octet_1 <=127:
          print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS A IP ADDRESS")
          input_arr=ip_add.split(".")[:1]
          netmask=len(input_arr)*8 
          for i in range(len(input_arr), 4):
               input_arr.append('0')
          ip='.'.join(input_arr)  
          network_bit=ip + '/' + str(netmask) 
          print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
     
     elif octet_1 >=128 or octet_1 <=191:
          print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS B IP ADDRESS")
          input_arr=ip_add.split(".")[:2] 
          netmask=len(input_arr)*8 
          for i in range(len(input_arr), 4):
               input_arr.append('0')
          ip='.'.join(input_arr) 
          network_bit=ip + '/' + str(netmask) 
          print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
     
     elif octet_1 >=192 or octet_1 <= 223:
          print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS C IP ADDRESS")
          input_arr=ip_add.split(".")[:3]
          netmask=len(input_arr)*8 
          for i in range(len(input_arr), 4):
               input_arr.append('0')
          ip='.'.join(input_arr)
          network_bit=ip + '/' + str(netmask)
          print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
     
     elif octet_1 >= 224 or octet_1 <= 239:
          print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS D IP ADDRESS")
          input_arr=ip_add.split(".")[:4] 
          netmask=len(input_arr)*8 
          for i in range(len(input_arr), 4):
               input_arr.append('0')
          ip='.'.join(input_arr)
          network_bit=ip + '/' + str(netmask)
          print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS D IP ADDRESS")
     
     else:
          print(f"===THE IP ADDRESS {ip_add} DOES NOT BELONG TO ANY CLASS IP ADDRESS===")

#===============================================================================================