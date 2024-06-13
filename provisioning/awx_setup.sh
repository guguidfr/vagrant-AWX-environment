#!/bin/bash

# Clonar el repositorio
git clone -b 23.8.1 https://github.com/ansible/awx.git

# Entrar al directorio de AWX
cd /home/vagrant/awx

# Crear las imágenes de los contenedores
make docker-compose-build
make docker-compose COMPOSE_UP_OPTS=-d
docker exec tools_awx_1 make clean-ui ui-devel
docker exec -ti tools_awx_1 awx-manage createsuperuser