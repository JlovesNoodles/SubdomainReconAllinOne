#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install cowsay
echo "Installing cowsay..."
sudo apt-get install -y cowsay

# Install lolcat
echo "Installing lolcat..."
sudo gem install lolcat

# Install amass
echo "Installing amass..."
sudo snap install amass

# Install subfinder
echo "Installing subfinder..."
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

# Install assetfinder
echo "Installing assetfinder..."
go get -u github.com/tomnomnom/assetfinder

# Install curl
echo "Installing curl..."
sudo apt-get install -y curl

# Install jq
echo "Installing jq..."
sudo apt-get install -y jq

# Install pv
echo "Installing pv..."
sudo apt-get install -y pv

# Install httpx
echo "Installing httpx..."
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx

# Install httprobe
echo "Installing httprobe..."
go get -u github.com/tomnomnom/httprobe

echo "All required tools have been installed."
