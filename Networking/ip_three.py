import pandas as pd
import os
import ipaddress

IP_ADDRESS = list()
IP_SUBNET = list()
SUBNET_TABLE = dict(IP_ADDRESS = IP_ADDRESS,IP_SUBNET=IP_SUBNET)

def subnets(ip_addresses):
    for ip in ip_addresses:
        network = ipaddress.IPv4Network(ip)
        for subnet in network.subnets(prefixlen_diff=0):
            print("================================================================")
            print(f"The Subnet for IP {ip} is: {subnet}")
            print("================================================================,\n")

            IP_ADDRESS.append(ip)
            IP_SUBNET.append(subnet)
    
    ip_table = pd.DataFrame.from_dict(SUBNET_TABLE)

    return f"THE IP SUBNET ARE STORED IN BELOW TABLE,\n{ip_table}"

if __name__ == "__main__":
    ip_addresses = ["192.168.50.0/24","165.100.0.0/16","210.100.56.0/24","195.85.8.0/24","178.100.0.0/16","200.175.14.0/24"]
    subnet_table = subnets(ip_addresses=ip_addresses)
    print(subnet_table)




    