#!/bin/bash

# Actualizar el sistema y los repositorios
apt update
apt upgrade -y

# Instalar Python 3 y establecerlo como el comando "python" por defecto
apt install -y python3 python3-pip
update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Actualizar pip a la última versión
python -m pip install --upgrade pip

# Instalar Ansible con pip
echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc
pip install ansible

# Instalar n para gestionar versiones de Node.js y npm
apt install -y curl
curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
bash n lts

# Configurar npm para instalar paquetes globales sin necesidad de sudo
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

# Instalar la última versión de npm
npm install -g npm

# Instalar Docker
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker vagrant

# Instalar Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker vagrant

# Instalar OpenSSL
apt install -y openssl

# Instalar make
apt install -y make

# Instalar git
apt install -y git

# Instalar pwgen
apt install -y pwgen