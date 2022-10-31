#!/bin/bash

## Install wget and curl command line tools.
### Debian based systems ###
apt update
apt install git wget curl

## latest binary package of cri-dockerd. But first, let’s get the latest release version:
VER=$(curl -s https://api.github.com/repos/Mirantis/cri-dockerd/releases/latest|grep tag_name | cut -d '"' -f 4|sed 's/v//g')
echo $VER

## We can then download the archive file from Github cri-dockerd releases page.
### For Intel 64-bit CPU ###
wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VER}/cri-dockerd-${VER}.amd64.tgz
tar xvf cri-dockerd-${VER}.amd64.tgz

### For ARM 64-bit CPU ###
wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VER}/cri-dockerd-${VER}.arm64.tgz
tar xvf cri-dockerd-${VER}.arm64.tgz

## Move cri-dockerd binary package to /usr/local/bin directory
mv cri-dockerd/cri-dockerd /usr/local/bin/

## Validate successful installation by running the commands below:
cri-dockerd --version

## Configure systemd units for cri-dockerd:
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
mv cri-docker.socket cri-docker.service /etc/systemd/system/
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

## Start and enable the services
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket

## Confirm the service is now running:
systemctl status cri-docker.socket