#!/bin/bash
kubeadm init --apiserver-advertise-address=192.168.56.201 --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock