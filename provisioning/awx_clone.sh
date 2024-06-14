#!/bin/bash

echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc
sudo chmod +x ~/ansible_resources/*

# Clonar el repositorio
git clone -b 24.5.0 https://github.com/ansible/awx.git