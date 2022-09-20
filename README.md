# Manual prerequisite 

# Set hostname and add entries in the hosts file
## Login to to master node and set hostname using hostnamectl command,
$ sudo hostnamectl set-hostname "k8smaster.domain.com"
$ exec bash
## On the worker nodes, run
### 1st worker node
$ sudo hostnamectl set-hostname "k8sworker1.domain.com"

### 2nd worker node   
$ sudo hostnamectl set-hostname "k8sworker2.domain.com"   
$ exec bash

# Change the server name in /etc/hostname 
server@master:~$ sudo cat /etc/hostname 
master
### Add the following entries in /etc/hosts file on each node
192.168.56.201   k8smaster.domain.com k8smaster
192.168.56.202   k8sworker1.domain.com k8sworker1
192.168.56.203   k8sworker2.domain.com k8sworker2

# Change the server name in /etc/hosts
server@master:~$ sudo cat /etc/hosts
127.0.0.1 localhost
127.0.1.1 master

# Configure static ip /etc/netplan/00-installer-config.yaml
server@master:~$ sudo cat /etc/netplan/00-installer-config.yaml 
## This is the network config written by 'subiquity'
network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      addresses: [192.168.56.201/24]
      dhcp4: false
  version: 2
# Apply the network change in netplan
server@master:~$ sudo netplan apply

# Turn off the swap
server@master:~$ sudo swapoff -a

# Remove swap related disk form the following file
server@master:~$ sudo cat /etc/fstab
server@master:~$ sudo rm /swap.img 

# Manual prerequisite 

# k8s installation each script file one by one

# Install Docker
curl -o docker.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/docker.sh

# Install Ip Table Configurations, Forwarding IPv4 and letting iptables see bridged traffic (Only Master)
curl -o iptables.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/iptables.sh

# Install Kubernetes
curl -o kubernetes.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/kubernetes.sh

# Configuring the kubelet cgroup driver(Only Master)
curl -o cgroup-driver.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/cgroup-driver.sh

# k8s installation by clone the repository
server@master:~$ git clone https://github.com/jaykumarpatil/k8s.git
server@master:~$ cd k8s
server@master:~$ chmod +x *.sh
# Install Ip Table Configurations, Forwarding IPv4 and letting iptables see bridged traffic (Only Master)
server@master:~/k8s$ ./prerequisite.sh 
server@master:~/k8s$ ./iptables.sh

server@master:~/k8s$ ./docker.sh
### check docker installations 
server@master:~/k8s$ sudo systemctl status docker

## check cgroup
server@master:~$ stat -fc %T /sys/fs/cgroup/
## For cgroup v2, the output is cgroup2fs.
## For cgroup v1, the output is tmpfs.


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
