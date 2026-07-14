# Tamil CloudBee - AWS EC2-demo 

```
#!/bin/bash

set -e

echo "=========================================="
echo " Tamil CloudBee EC2 Demo"
echo " Installing Apache Web Server..."
echo "=========================================="

sudo apt update
sudo apt install apache2 -y

sudo systemctl enable apache2
sudo systemctl start apache2

sudo rm -f /var/www/html/index.html

sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tamil CloudBee EC2 Demo</title>

<style>

body{
    margin:0;
    font-family:Arial,Helvetica,sans-serif;
    background:linear-gradient(135deg,#5d1835,#8b1e3f);
    color:white;
    text-align:center;
    overflow-x: hidden;
}

.container{
    margin-top:70px;
}

/* Keyframe Animations */
@keyframes float {
    0% { transform: translateY(0px); }
    50% { transform: translateY(-15px); }
    100% { transform: translateY(0px); }
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.logo{
    font-size:70px;
    display: inline-block;
    animation: float 4s ease-in-out infinite; /* Continuous floating effect */
}

h1{
    font-size:52px;
    margin-bottom:5px;
    animation: fadeInUp 0.8s ease-out forwards;
}

h2{
    color:#FFD54F;
    animation: fadeInUp 1s ease-out forwards;
}

.badge{
    display:inline-block;
    margin-top:20px;
    background:#FFD54F;
    color:#5d1835;
    padding:10px 25px;
    border-radius:30px;
    font-weight:bold;
    animation: fadeInUp 1.2s ease-out forwards;
    transition: transform 0.3s ease;
}

.badge:hover {
    transform: scale(1.1); /* Slight pop on hover */
}

.card{
    width:70%;
    margin:auto;
    margin-top:40px;
    background:white;
    color:#333;
    border-radius:12px;
    padding:30px;
    box-shadow:0px 10px 30px rgba(0,0,0,0.3);
    animation: fadeInUp 1.4s ease-out forwards;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
    transform: translateY(-5px); /* Card lifts up when hovered */
    box-shadow: 0px 15px 35px rgba(0,0,0,0.4);
}

.success{
    color:green;
    font-size:28px;
    font-weight:bold;
}

.footer{
    margin-top:60px;
    color:#ddd;
    font-size:18px;
    animation: fadeInUp 1.6s ease-out forwards;
}

</style>

</head>

<body>

<div class="container">

<div class="logo">
☁️🐝
</div>

<h1>Tamil CloudBee</h1>

<h2>Welcome to Tamil CloudBee Demo</h2>

<div class="badge">
AWS EC2 + Apache Web Server
</div>

<div class="card">

<p class="success">
✅ Congratulations!
</p>

<h2>Your Apache Web Server is Running Successfully</h2>

<p>
This website is hosted on an
<b>Amazon EC2 Ubuntu Instance</b>
using
<b>Apache HTTP Server</b>.
</p>

<p>
Created as part of the
<b>Tamil CloudBee AWS EC2 Demo</b>
to demonstrate how to deploy a website on AWS.
</p>

<hr>

<h3>Technologies Used</h3>

<p>
☁️ AWS EC2<br><br>
🐧 Ubuntu Linux<br><br>
🌐 Apache HTTP Server
</p>

</div>

<div class="footer">
Learn DevOps • AWS • Linux • Cloud • Kubernetes
<br><br>
❤️ Thank you for watching Tamil CloudBee
</div>

</div>

</body>
</html>
EOF

sudo chown -R www-data:www-data /var/www/html

echo ""
echo "=========================================="
echo " Installation Completed Successfully"
echo "=========================================="
echo ""

INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 || true)

if [ -n "$INSTANCE_IP" ]; then
    echo "Open your browser:"
    echo ""
    echo "http://$INSTANCE_IP"
else
    echo "Apache Installed."
fi
```
