#!/bin/bash
apt-get -y update
apt-get -y install nginx

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">NGINX from Terraform file<font color=red"> v0.12</font></h2><br><p>
<font color="green">Server PrivateIP: <font color="aqua">$myip<br><br>

<font color="margenta">
<b>Version 1.0<br>
<font color="white">
<b>Front_end_instance<br>
</body>
</html>
EOF

suco cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        proxy_pass ${aws_instance.private_instance.public_ip}:8080;
        try_files $uri $uri/ =404;        
    }
}
EOF

sudo systemctl start nginx
sudo chkconfig nginx on