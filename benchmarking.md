# Laporan Kerja Armin

## No.8
### Script Colossal (Load Balancer PHP)

```sh
mkdir -p /etc/nginx/supersecret
htpasswd -b -c /etc/nginx/supersecret/htpasswd arminannie jrkmit24

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

echo ' upstream worker {
        #least_conn;
        #ip_hash;
    server 192.245.2.2;
    server 192.245.2.3;
    server 192.245.2.4;
}

server {
    listen 80;
    server_name eldia.it24.com www.eldia.it24.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html index.php;

    server_name _;

    location / {
        proxy_pass http://worker;
    }

    auth_basic "Restricted Content";
    auth_basic_user_file /etc/nginx/supersecret/htpasswd;
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart
```
#### Round Robin
![](assets/gallery/erwin-rr.png)
#### Least Connection
![](assets/gallery/erwin-least_conn.png)
#### IP Hash
![](assets/gallery/erwin-ip_hash.png)

### Analisis
- Performa Tertinggi: Metode **IP Hash** memiliki jumlah request per detik tertinggi dengan 1803.36 request/detik, dengan waktu per request rata-rata yang lebih rendah (0.555 ms) dan transfer rate yang lebih tinggi (736.14 Kbytes/sec). Ini menunjukkan performa yang lebih baik dibandingkan dua metode lainnya.
- Stabilitas Waktu Respon: Metode **Round Robin** juga menunjukkan performa yang baik dengan waktu per request rata-rata yang cukup rendah, yaitu 0.589 ms, tetapi sedikit lebih lambat dibandingkan **IP Hash**.
- Performa Terendah: Metode **Least Connections** memiliki jumlah request per detik yang paling rendah (1257.11 request/detik) dan waktu per request yang lebih tinggi (0.795 ms). Selain itu, terdapat variasi waktu yang signifikan pada processing time dan waiting time, terutama dengan nilai maksimum mencapai 310 ms untuk request terpanjang.
### Grafik
![](assets/gallery/8rps.png)

## No.9
### Script Colossal (Load Balancer PHP)
```sh
echo ' upstream worker3 {
        least_conn;
        server 192.245.2.2;
        server 192.245.2.3;
        server 192.245.2.4;
}

upstream worker2 {
        least_conn;
        server 192.245.2.2;
        server 192.245.2.3;
}

upstream worker1 {
        least_conn;
        server 192.245.2.2;
}

server {
    listen 80;
    server_name eldia.it24.com www.eldia.it24.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html index.php;

    server_name _;

    location /worker3 {
        proxy_pass http://worker3;
    }

    location /worker2 {
        proxy_pass http://lworker2;
    }

    location /worker1 {
        proxy_pass http://worker1;
    }

} ' > /etc/nginx/sites-available/lb_php

service nginx restart
```

#### Worker-1
![](assets/gallery/zeke-1w.png)
#### Worker-2
![](assets/gallery/zeke-2w.png)
#### Worker-3
![](assets/gallery/zeke-3w.png)

### Analisis
- Perbandingan Kinerja: **Worker1** adalah yang paling cepat, diikuti oleh **Worker2**, sedangkan **Worker3** yang paling lambat dengan selisih yang cukup signifikan.
- Efisiensi Load Balancing: Berdasarkan hasil ini, load balancer sebaiknya memprioritaskan **Worker1** dan **Worker2** untuk mendapatkan respons yang lebih cepat. **Worker3** sebaiknya digunakan sebagai cadangan atau untuk tugas yang tidak membutuhkan waktu respons cepat, mengingat kinerjanya yang jauh lebih rendah.

### Grafik
#### Request per Second
![](assets/gallery/9rps.png)
#### Average Time per Request
![](assets/gallery/9avg.png)
