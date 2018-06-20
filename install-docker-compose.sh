#!/usr/bin/env bash


# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

sudo apt-get update
sudo apt-get install git unzip python-setuptools -y


# Use the official docker install script
wget -qO- https://get.docker.com/ | sh

# Install docker-compose
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Add Permissions
sudo groupadd docker
# sudo useradd dockeruser -p dockeruser -G docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

#su dockeruser
#cd minio
#docker-compose up -d
#exit
echo "Logout and back in to enable docker group membership"
