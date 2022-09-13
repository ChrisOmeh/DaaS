
import ipaddress

l = ["12.34.5.7"]
for i in l:
    a = i.split(".")[:2]
    print(a)
    print(len(a))

k = ["12.34.5.7"]
for i in range(4, 4):
     k.append('0')
print(k)


# import ipaddress
# input="127.0.0.0"
# input_arr=input.split(".") # ['127', '0', '0']
# netmask=len(input_arr)*8  # 24
# for i in range(len(input_arr), 4):
#      input_arr.append('0')
# # input_arr = ['127', '0', '0', '0']
# ip='.'.join(input_arr)  # '127.0.0.0'
# network=ip + '/' + str(netmask)  # '127.0.0.0/24'
# print(network)
# print("\n".join([str(x) for x in ipaddress.ip_network(network).hosts()]))

#network_address = ip/subnet_mask(cidr)
# # Import module
# import ipaddress

# # Example of valid IPv4 address
# print (ipaddress.ip_address(u'175.198.42.211'))

# # Invalid IPv4 address raises error
# print (ipaddress.ip_address(u'175.198.42.270'))


AA = [1,2,3]
print(AA[0])
print(AA[:1])
print(AA[:2])
print(AA[:3])