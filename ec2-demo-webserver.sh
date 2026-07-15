#!/bin/bash

set -euo pipefail

echo "=========================================="
echo "Tamil CloudBee EC2 Apache Demo"
echo "=========================================="

export DEBIAN_FRONTEND=noninteractive

echo "Updating package list..."
apt-get update -y

echo "Installing Apache..."
apt-get install -y apache2

echo "Enabling Apache service..."
systemctl enable apache2

echo "Starting Apache service..."
systemctl restart apache2

cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tamil CloudBee EC2 Demo</title>

<style>

body{
    margin:0;
    padding:0;
    font-family:Arial,Helvetica,sans-serif;
    background:#5d1835;
    color:#ffffff;
}

.container{
    max-width:900px;
    margin:60px auto;
    background:#ffffff;
    color:#333333;
    padding:40px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.25);
}

h1{
    color:#5d1835;
    margin-bottom:10px;
}

h2{
    color:#8b1e3f;
}

.status{
    color:green;
    font-size:24px;
    font-weight:bold;
    margin:30px 0;
}

.info{
    margin-top:30px;
    padding:20px;
    background:#f5f5f5;
    border-radius:8px;
    text-align:left;
}

.info p{
    margin:10px 0;
}

.footer{
    margin-top:40px;
    color:#666666;
    font-size:16px;
}

</style>

</head>

<body>

<div class="container">

<h1>Tamil CloudBee</h1>

<h2>AWS EC2 Apache Demo</h2>

<div class="status">
Apache Web Server Installed Successfully
</div>

<p>
This web page is hosted on an Amazon EC2 Ubuntu instance using Apache HTTP Server.
</p>

<div class="info">

<h3>Server Information</h3>

<p><strong>Cloud Platform:</strong> Amazon Web Services</p>

<p><strong>Compute Service:</strong> Amazon EC2</p>

<p><strong>Operating System:</strong> Ubuntu Linux</p>

<p><strong>Web Server:</strong> Apache HTTP Server</p>

</div>

<div class="footer">

Tamil CloudBee

<br><br>

Learn DevOps, AWS, Linux, Kubernetes and Cloud Computing

</div>

</div>

</body>
</html>
EOF

chown -R www-data:www-data /var/www/html

echo "Verifying Apache service..."

if systemctl is-active --quiet apache2
then
    echo "Apache service is running."
else
    echo "Apache service failed to start."
    journalctl -u apache2 --no-pager
    exit 1
fi

echo ""
echo "=========================================="
echo "Installation Completed Successfully"
echo "=========================================="

TOKEN=$(curl -s -X PUT \
http://169.254.169.254/latest/api/token \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600" || true)

if [ -n "$TOKEN" ]; then
    PUBLIC_IP=$(curl -s \
    -H "X-aws-ec2-metadata-token: $TOKEN" \
    http://169.254.169.254/latest/meta-data/public-ipv4 || true)
else
    PUBLIC_IP=$(curl -s \
    http://169.254.169.254/latest/meta-data/public-ipv4 || true)
fi

echo ""

if [ -n "$PUBLIC_IP" ]; then
    echo "Open the following URL in your browser:"
    echo ""
    echo "http://$PUBLIC_IP"
else
    echo "No public IP address found."
fi
