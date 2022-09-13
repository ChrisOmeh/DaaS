import ipaddress

#print("\n".join([str(x) for x in ipaddress.ip_network("192.0.2.0/28").network_address()]))
print("\n".join([str(x) for x in ipaddress.ip_network("192.10.10.0/28").hosts()]))
print(ipaddress.ip_address)
print(ipaddress.ip_interface)
print(ipaddress.ip_network)






def iprange(ip1,ip2):
    print(f'list of ip adresses between {ip1} and {ip2}') # list IPs between 127.0.0.1 and 127.0.0.100
    ip1_1 = ip1.split(".")
    ip2_2 = ip2.split(".")

    for i in range(0, len(ip1_1)):
        ip1_1[i] = int(ip1_1[i])
    for i in range(0, len(ip2_2)):
        ip2_2[i] = int(ip2_2[i])

    for i in range(ip1_1[0], ip2_2[0]+1):
        for j in range(ip1_1[1], ip2_2[1]+1):
            for k in range(ip1_1[2], ip2_2[2]+1):
                for z in range(ip1_1[3], ip2_2[3]+1):
                    print(f'{i}.{j}.{k}.{z}')

iprange("192.10.50.1","192.10.50.15")


