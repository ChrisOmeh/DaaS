import ipaddress
import os
import pandas as pd

# =================================================================================
def ip_network_address(ip_addresses):

    IP_ADDRESS = list()
    NETWORK_ADDRESS = list()

    for ip_add in ip_addresses:
        octet_1 = int(ip_add.split(".")[0])
        """
        Checking IP Addresses Range and subsequently getting the Network Address
        """
        if octet_1 >=1 and octet_1 <=127:
            print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS A IP ADDRESS")
            input_arr=ip_add.split(".")[:1]
            netmask=len(input_arr)*8 
            for i in range(len(input_arr), 4):
                input_arr.append('0')
            ip='.'.join(input_arr)  
            network_bit=ip + '/' + str(netmask) 
            print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
            NETWORK_ADDRESS.append(network_bit)
            IP_ADDRESS.append(ip_add)
        
        elif octet_1 >=128 and octet_1 <=191:
            print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS B IP ADDRESS")
            input_arr=ip_add.split(".")[:2] 
            netmask=len(input_arr)*8 
            for i in range(len(input_arr), 4):
                input_arr.append('0')
            ip='.'.join(input_arr) 
            network_bit=ip + '/' + str(netmask) 
            print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
            NETWORK_ADDRESS.append(network_bit)
            IP_ADDRESS.append(ip_add)
        
        elif octet_1 >=192 and octet_1 <= 223:
            print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS C IP ADDRESS")
            input_arr=ip_add.split(".")[:3]
            netmask=len(input_arr)*8 
            for i in range(len(input_arr), 4):
                input_arr.append('0')
            ip='.'.join(input_arr)
            network_bit=ip + '/' + str(netmask)
            print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
            NETWORK_ADDRESS.append(network_bit)
            IP_ADDRESS.append(ip_add)
        
        elif octet_1 >= 224 and octet_1 <= 239:
            print(f"THE IP ADDRESS {ip_add} BELONG TO ===== CLASS D IP ADDRESS")
            input_arr=ip_add.split(".")[:4] 
            netmask=len(input_arr)*8 
            for i in range(len(input_arr), 4):
                input_arr.append('0')
            ip='.'.join(input_arr)
            network_bit=ip + '/' + str(netmask)
            print(f"THE {ip_add} HAS A CIDR NETWORK ADDRESS OF: {network_bit}")
            NETWORK_ADDRESS.append(network_bit)
            IP_ADDRESS.append(ip_add)
        
        else:
            print(f"===THE IP ADDRESS {ip_add} DOES NOT BELONG TO ANY CLASS IP ADDRESS===")
    
    network_address_dict = dict(IP_ADDRESS=IP_ADDRESS,
                                NETWORK_ADDRESS = NETWORK_ADDRESS)

    df_table = pd.DataFrame.from_dict(network_address_dict)
    
    return f"\n,THE NETWORK ADDRESS FOR VARIOUS IPs ARE:,\n{df_table}"

if __name__ == '__main__':
    ip_addresses = ["188.10.18.2","10.10.48.80","192.149.24.191","150.203.23.19","10.10.10.10","186.13.23.110",
                    "223.69.230.250","200.120.135.15","27.125.200.151","199.20.150.35","191.55.165.135","28.212.250.254"]
    
    ip_addresses_1 = ["188.10.18.2","10.10.48.80"]
    network_add = ip_network_address(ip_addresses=ip_addresses)

    print(network_add)




ip_address_11 =  ["188.10.18.2","10.10.48.80","192.149.24.191","150.203.23.19","10.10.10.10","186.13.23.110",
                    "223.69.230.250","200.120.135.15","27.125.200.151","199.20.150.35","191.55.165.135","28.212.250.254"]

subnet_mask = ["255.255.0.0","255.255.255.0","255.255.255.0","255.255.0.0","255.0.0.0","255.255.255.0",
                "255.255.0.0","255.255.255.0","255.0.0.0","255.255.255.0","255.255.255.0","255.255.0.0"]
