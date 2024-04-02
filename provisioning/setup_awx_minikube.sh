#!/bin/bash
# https://www.server-world.info/en/note?os=Ubuntu_22.04&p=ansible&f=9
# Move to Ubuntu with minikube (¿?)
apt update && apt upgrade -y && apt install -y make pkg-config wget build-essential libncursesw5-dev libssl-dev  libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
cd /home/vagrant
curl -fsSl https://get.docker.com/ -o docker_setup.sh
chmod +x docker_setup.sh
./docker_setup.sh
usermod -aG vagrant docker
systemctl restart docker
rm /home/vagrant/.dock
wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tar.xz
tar -xvf Python-3.12.2.tar.xz
cd Python-3.12.2
./configure --enable-optimizations
make -j 2
make altinstall
cd ..
update-alternatives --install /usr/bin/python python /usr/local/bin/python3.12 2
curl -fSsl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python ./get-pip.py
python -m pip install --upgrade pip setuptools wheel
# apt install -y git python3-pip
apt install -y git
pip install ansible
curl -fSsl https://files.pythonhosted.org/packages/1f/6a/f4703077123ad0c90026985cb9780c0703922c2a5451ab93fb63511d915a/docker-compose-1.29.2.tar.gz -o docker-compose-pip.tar.gz
tar -xf docker-compose-pip.tar.gz
cd docker-compose-1.29.2/
python3 ./setup.py install
# pip uninstall docker
# pip install docker==6.1.3
# cd ..
# git clone -b 24.1.0 https://github.com/ansible/awx.git
# cd ./awx
# make docker-compose-build
# make docker-compose
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
minikube start --driver=docker --cpus=4 --memory=4g --addons=ingress
git clone https://github.com/ansible/awx-operator.git
cd awx-operator
git checkuot 2.14.0