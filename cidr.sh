#!/bin/bash
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo kubeadm init --apiserver-advertise-address=192.168.56.201 --pod-network-cidr=10.244.0.0/16