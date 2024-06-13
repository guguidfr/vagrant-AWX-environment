#!/bin/bash

# Actualizar el sistema y los repositorios
sudo apt update
sudo apt upgrade -y

# Instalar Python 3 y establecerlo como el comando "python" por defecto
sudo apt install -y python3 python3-pip
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Actualizar pip a la última versión
python -m pip install --upgrade pip

# Instalar Ansible con pip
pip install ansible
echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc

# Instalar n para gestionar versiones de Node.js y npm
sudo apt install -y curl
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
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant

# Instalar Docker Compose
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Instalar OpenSSL
sudo apt install -y openssl

# Instalar make
sudo apt install -y make

# Instalar git
sudo apt install -y git

# Instalar pwgen
sudo apt install -y pwgen

# Verificar las instalaciones
echo "Verificación de las instalaciones:"
python --version
pip --version
ansible --version
npm --version
node --version
docker --version
docker-compose --version
openssl version
make --version
git --version
pwgen --version

echo "Instalación completa."
