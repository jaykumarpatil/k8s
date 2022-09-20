# Run these commands as root
###Install GO###
sudo wget https://storage.googleapis.com/golang/getgo/installer_linux
sudo chmod +x ./installer_linux
sudo ./installer_linux
sudo source ~/.bash_profile
sudo git clone https://github.com/Mirantis/cri-dockerd.git
sudo cd cri-dockerd
sudo mkdir bin
sudo go build -o bin/cri-dockerd
sudo mkdir -p /usr/local/bin
sudo install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
sudo cp -a packaging/systemd/* /etc/systemd/system
sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket