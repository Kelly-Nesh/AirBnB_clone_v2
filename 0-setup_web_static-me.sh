#!/usr/bin/env bash
# Bash script that sets up your web servers for the deployment of web_static.
apt update -y
if ! (command -v nginx &> /dev/null) then
        apt install nginx -y
fi
mkdir -p "/data/web_static/releases/test/"
echo "Hello from  web static" | tee /data/web_static/releases/test/index.html
if [ ! -e /data/web_static/current ]; then
        rm -f /data/web_static/current
fi
ln -s /data/web_static/releases/test /data/web_static/current
chown -R ubuntu:ubuntu /data/
sed -i "53i location /hbnb_static/ {\n\talias /data/web_static/current/;\n\tautoindex off;\n}" /etc/nginx/sites-available/default
service nginx restart
