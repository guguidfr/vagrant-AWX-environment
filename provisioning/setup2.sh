#!/bin/bash
apt update && apt upgrade -y
curl -fsSl https://get.docker.com/ -o docker_setup.sh
chmod +x docker_setup.sh
./docker_setup.sh
wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz
tar -xvf Python-3.12.2.tar.xz
cd Python-3.12.2
./configure --enable-optimizations
make -j 2
make altinstall
update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.12 2
apt install -y git python3-pip
git clone https://github.com/ansible/awx/
cd ./awx
