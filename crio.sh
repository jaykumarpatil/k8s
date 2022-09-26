OS=xUbuntu_20.04
CRIO_VERSION=1.23
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | sudo apt-key add -
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key add -
sudo apt update
sudo apt install cri-o cri-o-runc
apt show cri-o
systemctl enable crio.service
systemctl start crio.service
systemctl status crio.service
apt install cri-tools
cat <<EOF | tee /etc/crio/crio.conf
[crio.image]
pause_image="registry.k8s.io/pause:3.6"
EOF
cat <<EOF | tee /etc/crio/crio.conf.d/02-cgroup-manager.conf
[crio.runtime]
conmon_cgroup = "pod"
cgroup_manager = "cgroupfs"
EOF
systemctl reload crio