#!/bin/bash
docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
echo "A veces la sincronización de los repositorios y ejecución de playboooks puede fallar."
echo "Se ha añadido delay entre los diferentes pasos por seguridad."
sleep 10
cd /home/vagrant/awx
make docker-compose COMPOSE_UP_OPTS=-d
sleep 15