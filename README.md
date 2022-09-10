# k8s
# Install Docker
curl -o docker.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/docker.sh

# Install Ip Table Configurations, Forwarding IPv4 and letting iptables see bridged traffic (Only Master)
curl -o iptables.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/iptables.sh

# Install Kubernetes
curl -o kubernetes.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/kubernetes.sh

# Configuring the kubelet cgroup driver
curl -o cgroup-driver.sh https://raw.githubusercontent.com/jaykumarpatil/k8s/main/cgroup-driver.sh