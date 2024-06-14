#!/bin/bash

cd ../awx
make docker-compose-build
make docker-compose COMPOSE_UP_OPTS=-d
docker exec tools_awx_1 make clean-ui ui-devel
docker exec -ti tools_awx_1 awx-manage createsuperuser
echo "@reboot vagrant cd /home/vagrant/awx && make docker-compose COMPOSE_UP_OPTS=-d" >> sudo /etc/crontab