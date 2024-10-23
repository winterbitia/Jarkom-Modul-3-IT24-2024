echo 'nameserver 192.245.4.3' > /etc/resolv.conf   # DNS Server 
apt-get update
apt install isc-dhcp-server -y

echo '
INTERFACESv4="eth0"
INTERFACESv6=""
' > /etc/default/isc-dhcp-server

echo '
subnet 192.245.1.0 netmask 255.255.255.0 {
	range 192.245.1.5 192.245.1.25;
	range 192.245.1.50 192.245.1.100;
	option routers 192.245.1.1;
	option broadcast-address 192.245.1.255;
	option domain-name-servers 192.245.4.3;
	default-lease-time 360;
	max-lease-time 5220;
}

subnet 192.245.2.0 netmask 255.255.255.0 {
	range 192.245.2.9 192.245.2.27;
	range 192.245.2.81 192.245.2.243;
	option routers 192.245.2.1;
	option broadcast-address 192.245.1.255;
	option domain-name-servers 192.245.4.3;
	default-lease-time 1800;
	max-lease-time 5220;
}

subnet 192.245.3.0 netmask 255.255.255.0 {
	option routers 192.245.3.1;
}

subnet 192.245.4.0 netmask 255.255.255.0 {
	option routers 192.245.4.1;
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart