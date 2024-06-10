#!/bin/bash

# Function to install necessary dependencies
function install_dependencies() {
    sudo apt-get update
    sudo apt-get install -y wget curl jq python3 pv lolcat cowsay
    go get -u github.com/tomnomnom/assetfinder
    GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
    go get -u github.com/tomnomnom/httprobe
    git clone https://github.com/aboul3la/Sublist3r.git /opt/Sublist3r
}

# Check if dependencies are installed
if ! command -v cowsay &>/dev/null || ! command -v jq &>/dev/null || ! command -v python3 &>/dev/null || ! command -v pv &>/dev/null || ! command -v lolcat &>/dev/null || ! command -v go &>/dev/null; then
    echo "Some dependencies are missing. Installing..."
    install_dependencies
    echo "Dependencies installed successfully!"
else
    echo "All dependencies are already installed."
fi
