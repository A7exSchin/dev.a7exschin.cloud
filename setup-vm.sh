#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function main() {
    # Update the package list
    sudo apt-get update

    # Enable UFW
    sudo ufw enable

    # Allow necessary ports
    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp

    # Install necessary packages
    sudo apt-get install -y nginx
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot

    # Start the Nginx service
    sudo systemctl start nginx

    # Configure website
    cp -af ${SCRIPT_DIR}/nginx-conf/website/. /var/www/html/

    # Restart Nginx
    sudo systemctl restart nginx

    # Obtain SSL certificate
    sudo certbot --nginx
}

main()