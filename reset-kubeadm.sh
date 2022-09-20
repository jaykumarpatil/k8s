#!/bin/bash
sudo kubeadm reset
sudo rm -rf /etc/kubernetes
sudo rm -rf /etc/cni/net.d
sudo rm -rf $HOME/.kube