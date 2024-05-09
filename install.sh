#!/bin/bash

apt-get install curl -y
apt-get install net-tools -y
apt-get install exiftool -y
apt-get install tcpdump -y

sudo chmod +x conf.sh
sudo chmod +x cpu.sh
sudo chmod +x log.sh
sudo chmod +x meta.sh
sudo chmod +x network.sh
sudo chmod +x virustotal.sh
