#!/bin/bash

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install necessary packages
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release git

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index and install Docker
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installation
docker --version
docker-compose --version

# Clone the repository containing docker-compose files
git clone https://github.com/Rafael-VP/hackathon-magalu-2024.git ~/docker-services

# Navigate to the directory with the docker-compose files
cd ~/docker-services/docker

# Create directories for configurations if necessary
mkdir -p nextcloud/config pihole/config homer/config wireguard/config

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

echo "NextCloud, Pi-hole, Homer, and WireGuard have been set up and started."
echo "Access NextCloud at http://<your-server-ip>:8080"
echo "Access Pi-hole at http://<your-server-ip>"
echo "Access Homer at http://<your-server-ip>:8081"

