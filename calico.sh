kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/custom-resources.yaml -O
kubectl create -f custom-resources.yaml
