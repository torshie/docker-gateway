#!/bin/sh

s=`ifconfig eth0 | grep 192.168.11`
if [ ! -z "$s" ]; then
	wan=eth1
	lan=eth0
else
	wan=eth0
	lan=eth1
fi

ip route add default via 172.16.20.1 \
		|| ip route replace default via 172.16.20.1
iptables -t nat -A POSTROUTING -s 192.168.11.0/24 -o $wan -j MASQUERADE
sysctl -w net.ipv4.ip_forward=1

sed -i "s/ethX/$lan/" /etc/udhcpd.conf
udhcpd /etc/udhcpd.conf

while true; do
	/bin/sh
	echo 
	echo '**************************************************************'
	echo '* Command "exit" is diabled, please type <ctrl-p> <ctrl-q>   *'
	echo '* to detach                                                  *'
	echo '**************************************************************'
done
