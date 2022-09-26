#!/bin/bash
kubeadm reset
rm -rf /etc/kubernetes
rm -rf /etc/cni/net.d
rm -rf $HOME/.kube