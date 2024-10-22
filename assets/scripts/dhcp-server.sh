echo 'nameserver 192.245.4.3' > /etc/resolv.conf   # DNS Server 
apt-get update
apt install isc-dhcp-server -y