echo 'nameserver 192.245.4.3' > /etc/resolv.conf   # DNS Server 
apt-get update
apt-get install nginx -y
apt-get install wget unzip -y
apt-get install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip -y

service nginx start
service php7.3-fpm start

mkdir -p /var/www/eldia.it24.com

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1TvebIeMQjRjFURKVtA32lO9aL7U2msd6' -O /root/bangsaEldia.zip
unzip -o /root/bangsaEldia.zip -d /var/www/eldia.it24.com

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/eldia.it24.com

echo '
server {
  listen 80;
  listen [::]:80;

  root /var/www/eldia.it24.com;
  index index.php index.html index.htm;

  server_name eldia.it24.com;

  location / {
    try_files $uri $uri/ =404;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
  }

  location ~ /\.ht {
    deny all;
  }
}' > /etc/nginx/sites-available/eldia.it24.com

ln -s /etc/nginx/sites-available/eldia.it24.com /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
service nginx restart