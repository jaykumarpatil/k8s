#!/bin/bash

echo "[TASK 1] Disable and turn off SWAP"
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a

echo "[TASK 2] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 3] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 4] Set root password"
echo -e "root\nroot" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[TASK 5] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.100   kmaster.example.com     kmaster
172.16.16.101   kworker1.example.com    kworker1
172.16.16.102   kworker2.example.com    kworker2
172.16.16.103   kworker3.example.com    kworker3
172.16.16.104   kworker4.example.com    kworker4
172.16.16.105   kworker5.example.com    kworker5
EOF

echo "[TASK 6]  Enable iptables Bridged Traffic"
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

echo "[TASK 7] sysctl params required by setup, params persist across reboots"
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

echo "[TASK 7] Apply sysctl params without reboot"
sysctl --system >/dev/null 2>&1