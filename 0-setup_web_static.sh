#!/usr/bin/env bash
<<<<<<< HEAD
# This script sets up web servers for deployment of web_static

# Install Nginx if not installed
if ! command -v nginx &> /dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary directories if they don't exist
directories=("/data" "/data/web_static" "/data/web_static/releases" "/data/web_static/shared" "/data/web_static/releases/test")
for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        sudo mkdir -p "$dir"
    fi
done

# Create fake HTML file for testing
fake_html="/data/web_static/releases/test/index.html"
if [ ! -f "$fake_html" ]; then
    echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee "$fake_html" > /dev/null
fi

# Create or update symbolic link
current_link="/data/web_static/current"
if [ -L "$current_link" ]; then
    sudo rm "$current_link"
fi
sudo ln -s /data/web_static/releases/test/ "$current_link"

# Set ownership to ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
nginx_config="/etc/nginx/sites-available/default"
if ! grep -q "location /hbnb_static" "$nginx_config"; then
    sudo sed -i '/^\s*server_name _;/a \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n' "$nginx_config"
fi

# Restart Nginx
sudo service nginx restart || sudo systemctl restart nginx
=======
# sets up the web servers for the deployment of web_static

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install nginx
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo "This is a test" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data/
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
sudo service nginx start
>>>>>>> 2cc83271651fce7bb03540cf792d939ffa5d5131
