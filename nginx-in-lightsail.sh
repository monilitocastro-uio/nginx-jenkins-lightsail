#!/bin/bash

# Check if sufficient arguments are passed
if [ $# -lt 2 ]; then
  echo "Usage: $0 <domain_name> <email>"
  exit 1
fi

domain_name=$1
user_email=$2

# No need to prompt user as arguments are passed directly
# Proceed with your server updates, configuration, and setup

sudo apt update
sudo apt install nginx

# Your NGINX and SSL configurations as before, now parameterized.



# Set the environment variable for domain name
export domain_name=$domain_name

# Path to the original and the destination nginx config files
original_config="./default.original"
destination_config="./default"

jenkins_1_original_config="./jenkins1.original"
jenkins_2_original_config="./jenkins2.original"
jenkins_destination_config="./jenkins"

# Copy original config to the destination config
cp $original_config $destination_config
cp $jenkins_1_original_config $jenkins_destination_config

# Placeholder to replace in the config file
placeholder="example.com"

# Check if the domain_name environment variable is set
if [ -z "$domain_name" ]
then
    echo "The domain_name environment variable is not set."
    exit 1
fi

# Use sed to replace the placeholder with the actual domain name
sed -i "s/$placeholder/$domain_name/g" $destination_config
sed -i "s/$placeholder/$domain_name/g" $jenkins_destination_config

echo "inserting index.html"
echo "<html><head><title>example.com</title></head><body><h1>Welcome to example.com</h1></body></html>" | sudo tee /var/www/html/index.html


echo "symbolic links to sites-enabled"
sudo ln -s $destination_config /etc/nginx/sites-enabled/
sudo ln -s $jenkins_destination_config /etc/nginx/sites-enabled/


echo "restarting nginx"
sudo systemctl restart nginx

sudo apt install certbot python3-certbot-nginx

echo "certbot for ssl"
sudo certbot --nginx -d $domain_name -d www.$domain_name --non-interactive --agree-tos --email $your_email

sudo certbot --nginx -d jenkins.$domain_name --non-interactive --agree-tos --email $your_email




echo "restarting nginx"
sudo systemctl restart nginx
echo "all done. enjoy!"