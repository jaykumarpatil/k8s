

#!/bin/bash

## Install cri-dockerd from source

## Install Golang on your system
wget https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile

## Confirm installation by checking version of Go.
go version

## Clone the project code from Github repository

git clone https://github.com/Mirantis/cri-dockerd.git

## Run the commands below to build this code (in a POSIX environment):
cd cri-dockerd
mkdir bin
cd src && go get && go build -o ../bin/cri-dockerd
cd ..

## Finally install cri-dockerd on a Linux system. This assumes your system uses systemd, and Docker Engine is installed.
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system

## Start and enable the cri-docker service
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket

## Check service status:
systemctl status cri-docker.socket