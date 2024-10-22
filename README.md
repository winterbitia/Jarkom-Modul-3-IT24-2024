# Jarkom-Modul-2-IT24-2024

| Nama | NRP |
|---|---|
|Amoes Noland|5027231028|
|Radella Chesa Syaharani|5027231064|

## Daftar Isi

Bikin secara otomatis pake plugin aja nti jangan manual pls

## Pendahuluan

Pulau Paradis dan Marley, sama-sama menghadapi ancaman besar dari satu sama lain. Keduanya membangun infrastruktur pertahanan yang kuat untuk melindungi sistem vital mereka. Dengan strategi yang matang, mereka bersiap menghadapi serangan dan mempertahankan wilayah masing-masing.

**Bangsa Marley,** dipimpin oleh **Zeke,** telah mempersiapkan **Annie, Bertholdt, dan Reiner** untuk menyerang menggunakan **Laravel Worker.** Di sisi lain, **Klan Eldia** dari **Paradis** telah mempersiapkan **Armin, Eren, dan Mikasa** sebagai **PHP Worker** untuk mempertahankan pulau tersebut. **Warhammer** bertindak sebagai **Database Server**, sementara **Beast** dan **Colossal** sebagai **Load Balancer.** 

## Topologi

![Topologi](assets/gallery/topologi.png)

## Tabel IP

| **Node**         | **Node Type**       | **Interface** | **IP Address** | **Gateway**     |
|------------------|---------------------|---------------|----------------|-----------------|
| **Paradis**      | Router/DHCP Relay   | eth0          | DHCP           | -               |
|                  |                     | eth1          | 192.245.1.1    | -               |
|                  |                     | eth2          | 192.245.2.1    | -               |
|                  |                     | eth3          | 192.245.3.1    | -               |
|                  |                     | eth4          | 192.245.4.1    | -               |
| **Tybur**        | DHCP Server         | eth0          | 192.245.4.2    | 192.245.4.1     |
| **Fritz**        | DNS Server          | eth0          | 192.245.4.3    | 192.245.4.1     |
| **Warhammer**    | Database Server     | eth0          | 192.245.3.2    | 192.245.3.1     |
| **Beast**        | Load Balancer Laravel | eth0        | 192.245.3.3    | 192.245.3.1     |
| **Colossal**     | Load Balancer PHP   | eth0          | 192.245.3.4    | 192.245.3.1     |
| **Annie**        | Laravel Worker      | eth0          | 192.245.1.2    | 192.245.1.1     |
| **Bertholdt**    | Laravel Worker      | eth0          | 192.245.1.3    | 192.245.1.1     |
| **Reiner**       | Laravel Worker      | eth0          | 192.245.1.4    | 192.245.1.1     |
| **Armin**        | PHP Worker          | eth0          | 192.245.2.2    | 192.245.2.1     |
| **Eren**         | PHP Worker          | eth0          | 192.245.2.3    | 192.245.2.1     |
| **Mikasa**       | PHP Worker          | eth0          | 192.245.2.4    | 192.245.2.1     |
| **Zeke**         | Client              | eth0          | DHCP           | -               |
| **Erwin**        | Client              | eth0          | DHCP           | -               |


## Konfigurasi IP

### Paradis (Router/DHCP Relay)
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.245.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.245.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.245.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.245.4.1
	netmask 255.255.255.0
```

### Tybur (DHCP Server)
```
auto eth0
iface eth0 inet static
	address 192.245.4.2
	netmask 255.255.255.0
	gateway 192.245.4.1
```

### Fritz (DNS Server)
```
auto eth0
iface eth0 inet static
	address 192.245.4.3
	netmask 255.255.255.0
	gateway 192.245.4.1
```

### Warhammer (Database Server)
```
auto eth0
iface eth0 inet static
	address 192.245.3.2
	netmask 255.255.255.0
	gateway 192.245.3.1
```

### Beast (Load Balancer Laravel)
```
auto eth0
iface eth0 inet static
	address 192.245.3.3
	netmask 255.255.255.0
	gateway 192.245.3.1
```

### Colossal (Load Balancer PHP)
```
auto eth0
iface eth0 inet static
	address 192.245.3.4
	netmask 255.255.255.0
	gateway 192.245.3.1
```

### Annie (Laravel Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.1.2
	netmask 255.255.255.0
	gateway 192.245.1.1
```

### Bertholdt (Laravel Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.1.3
	netmask 255.255.255.0
	gateway 192.245.1.1
```

### Reiner (Laravel Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.1.4
	netmask 255.255.255.0
	gateway 192.245.1.1
```

### Armin (PHP Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.2.2
	netmask 255.255.255.0
	gateway 192.245.2.1
```

### Eren (PHP Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.2.3
	netmask 255.255.255.0
	gateway 192.245.2.1
```

### Mikasa (PHP Worker)
```
auto eth0
iface eth0 inet static
	address 192.245.2.4
	netmask 255.255.255.0
	gateway 192.245.2.1
```

### Zeke (Client)
```
auto eth0
iface eth0 inet dhcp
```

### Erwin (Client)
```
auto eth0
iface eth0 inet dhcp
```

## Script Awal

### Paradis (DHCP Relay)
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.245.0.0/16
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay start
```

### Fritz (DNS Server)
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
apt-get update
apt-get install bind9 -y  
```

### Tybur (DHCP Server)
```
echo 'nameserver 192.245.4.3' > /etc/resolv.conf   # DNS Server 
apt-get update
apt install isc-dhcp-server -y
```

### Laravel Worker

### PHP Worker

### Load Balancer

### Client
```
apt-get update
```

## Soal 0

> Pulau Paradis telah menjadi tempat yang damai selama 1000 tahun, namun kedamaian tersebut tidak bertahan selamanya. Perang antara kaum Marley dan Eldia telah mencapai puncak. Kaum Marley yang dipimpin oleh Zeke, me-register domain name **marley.yyy.com** untuk worker Laravel mengarah pada **Annie**. Namun ternyata tidak hanya kaum Marley saja yang berinisiasi, kaum Eldia ternyata sudah mendaftarkan domain name **eldia.yyy.com** untuk worker PHP (0) mengarah pada **Armin**.

### Konfigurasi pada Fritz (DNS Server)

```sh
echo 'zone "marley.it24.com" {
    type master;
    file "/etc/bind/sites/marley.it24.com";
};
zone "eldia.it24.com" {
    type master;
    file "/etc/bind/sites/eldia.it24.com";
};' > /etc/bind/named.conf.local

mkdir -p /etc/bind/sites
cp /etc/bind/db.local /etc/bind/sites/marley.it24.com
cp /etc/bind/db.local /etc/bind/sites/eldia.it24.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     marley.it24.com. root.marley.it24.com. (
                        2024102301      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@       IN      NS      marley.it24.com.
@       IN      A       192.245.1.2    ; IP Annie
www     IN      CNAME   marley.it24.com.' > /etc/bind/sites/marley.it24.com

echo ';
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     eldia.it24.com. root.eldia.it24.com. (
                            2024102301         ; Serial
                            604800              ; Refresh
                            86400              ; Retry
                            2419200              ; Expire
                            604800 )            ; Negative Cache TTL
;
@       IN      NS      eldia.it24.com.
@       IN      A       192.245.2.2    ; IP Armin
www     IN      CNAME   eldia.it24.com.' > /etc/bind/sites/eldia.it24.com

echo 'options {
    directory "/var/cache/bind";

    forwarders {
        192.168.122.1;
    };

    // dnssec-validation auto;

    allow-query { any; };
    auth-nxdomain no;    # conform to RFC1035
    listen-on-v6 { any; };
};' > /etc/bind/named.conf.options

service bind9 restart
```

## Soal 1

> Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

* [Topologi](#topologi)
* [Tabel IP](#tabel-ip)
* [Konfigurasi IP](#konfigurasi-ip)

## Soal 2

> 

### Konfigur