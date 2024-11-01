#!/bin/bash

# Update and upgrade the system
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

# Install necessary packages
echo "Installing packages..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release git figlet
sudo install -m 0755 -d /etc/apt/keyrings

# Add Docker’s official GPG key
echo "Installing Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# Update package database
apt-cache policy docker-ce

# Install docker
sudo apt install -y docker-ce

# Update package index and install Docker
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
docker --version
docker-compose --version

# Clone the repository containing docker-compose files
echo "Getting docker-compose.yml files..."
git clone https://github.com/Rafael-VP/hackathon-magalu-2024.git ~/docker-services

# Navigate to the directory with the docker-compose files
cd ~/docker-services/docker

# Create directories for configurations if necessary
mkdir -p nextcloud/config pihole/config homer/config wireguard/config WooCommerce/config baikal/config

echo "Deploying containers..."
# Deploy NextCloud
cd nextcloud
sudo docker-compose up -d

# Deploy Pi-hole
cd ../pihole
sudo docker-compose up -d

# Deploy Homer
cd ../homer
sudo docker-compose up -d

# Deploy WireGuard
cd ../wireguard
sudo docker-compose up -d

# Deploy WooCommerce
cd ../WooCommerce
sudo docker-compose up -d

# Deploy Baikal
cd ../baikal
sudo docker-compose up -d

figlet Magalu Cloud
echo "NextCloud, Pi-hole, Homer, and WireGuard have been set up and started."
echo "Access NextCloud at http://<your-server-ip>:8080"
echo "Access Pi-hole at http://<your-server-ip>"
echo "Access Homer at http://<your-server-ip>:8081"
echo "Ready to go!"
