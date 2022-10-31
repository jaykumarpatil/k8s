#!/bin/bash

## Uninstall old versions
### Older versions of Docker went by the names of docker, docker.io, or docker-engine. Uninstall any such older versions before attempting to install a new version:
apt-get remove -y docker docker-engine docker.io containerd runc
## Set up the repository
### Update the apt package index and install packages to allow apt to use a repository over HTTPS:
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release
### Add Docker’s official GPG key:
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
### Use the following command to set up the repository:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
## Install Docker Engine
apt-get update
## Install Docker Engine, containerd, and Docker Compose.
### To install the latest version, run:
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# # List the available versions:
# apt-cache madison docker-ce | awk '{ print $3 }'

# 5:20.10.16~3-0~ubuntu-jammy
# 5:20.10.15~3-0~ubuntu-jammy
# 5:20.10.14~3-0~ubuntu-jammy
# 5:20.10.13~3-0~ubuntu-jammy

# VERSION_STRING=5:20.10.13~3-0~ubuntu-jammy
# apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-compose-plugin

# Verify that the Docker Engine installation is successful by running the hello-world image:
service docker start
systemctl enable docker
docker run hello-world