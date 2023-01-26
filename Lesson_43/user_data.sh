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
</body>
</html>
EOF

sudo systemctl start nginx
chkconfig nginx on