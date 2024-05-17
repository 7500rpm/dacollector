#!/bin/bash
apt-get update -y
apt-get install curl -y
apt-get install net-tools -y
apt-get install exiftool -y
apt-get install tcpdump -y
apt-get install nmap -y
apt-get install jq -y

sudo chmod +x conf.sh
sudo chmod +x cpu.sh
sudo chmod +x log.sh
sudo chmod +x meta.sh
sudo chmod +x network.sh
sudo chmod +x virustotal.sh
sudo chmod +x analysis.sh
