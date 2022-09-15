import ipaddress
import os
import pandas as pd

#QUESTION ONE

# If the value is in the range 1 to 127, the address belongs to class A. 
# If the value is in the range 128 to 191, the address belongs to class B.
# If the value is in the range 192 to 223, the address belongs to class C.
# If the value is in the range 224 to 239, the address belongs to class D.

def ip_range(ip_address_array):
     IP_ADDRESS = list()
     IP_CLASS = list() 
     A_CLASS = "CLASS A"
     B_CLASS = "CLASS B"
     C_CLASS = "CLASS C"
     D_CLASS = "CLASS D"
     E_CLASS = "CLASS E"              
     NOT_IP = "NOT A VALID IP"     
     range_table = dict(IP_ADDRESSES=IP_ADDRESS,
                                   CLASSES=IP_CLASS)

     for ip_addresses in ip_address_array:
          octet_1 = int(ip_addresses.split(".")[0])
          """
          Checking IP Addresses Range
          """
          if octet_1 >=1 and octet_1 <=127:
               print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS A IP ADDRESS")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(A_CLASS)

          elif octet_1 >=128 and octet_1 <=191:
               print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS B IP ADDRESS")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(B_CLASS)
          
          elif octet_1 >=192 and octet_1 <= 223:
               print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS C IP ADDRESS")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(C_CLASS)
          
          elif octet_1 >= 224 and octet_1 <= 239:
               print(f"THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS D IP ADDRESS")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(D_CLASS)
          
          elif octet_1 >= 240 and octet_1 <=255:
               print(f"===THE IP ADDRESS {ip_addresses} BELONG TO ===== CLASS E IP ADDRESS")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(E_CLASS)
          else:
               print(f"===THE IP ADDRESS {ip_addresses} DOES NOT BELONG TO ANY CLASS IP ADDRESS===")
               IP_ADDRESS.append(ip_addresses)
               IP_CLASS.append(NOT_IP)

     #CREATING A TABLE FOR THE IP ADDRESS AND THE RANGE
     df = pd.DataFrame.from_dict(range_table)
     return f"\n,THE IP CLASS IS STORED IN BELOW TABLE,\n{df}"

if __name__ == "__main__":
     ip_address_array = ["10.250.1.1","150.10.15.0","192.14.2.0","148.17.9.1","193.42.1.1","126.8.156.0","220.200.23.1",
                         "230.230.45.58","177.100.18.4","119.18.45.0","249.240.80.78","199.155.77.56","117.89.56.45",
                         "215.45.45.0","199.200.15.0","95.0.21.90","33.0.0.0","158.98.80.0","219.21.56.0"]
     
     ip_ranges = ip_range(ip_address_array=ip_address_array)
     print(ip_ranges)


