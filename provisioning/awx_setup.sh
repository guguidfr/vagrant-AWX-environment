#!/bin/bash
# Source: https://blog.andrehotzler.de/en/blog/technology/81-install-awx-ansible-on-debian-10-buster.html
# apt install -y git python3-pip docker docker-compose
curl -fsSL https://get.docker.com -o install-docker.sh
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
tar -xf Python-3.10.*.tgz
cd Python-3.10.*/
./configure --prefix=/usr/local --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make -j $(nproc)
sudo make altinstall
pip3.10 install --user --upgrade pip
sudo pip3.10 install module-name
update-alternatives --install /usr/bin/python python /usr/bin/python3 2
apt -y remove ansible
pip3 install ansible
cd /home/vagrant
git clone https://github.com/ansible/awx/
cd /home/vagrant/awx/installer
sed -i "s|postgres_data_dir=\"~/.awx/pgdocker\"|postgres_data_dir=\"/awx/pg\"|g" inventory
sed -i "s|docker_compose_dir=\"~/.awx/awxcompose\"|docker_compose_dir=\"/awx/compose\"|g" inventory
sed -i "s|#project_data_dir=/var/lib/awx/projects|project_data_dir=/awx/projects|g" inventory
ansible-playbook install.yml -i inventory