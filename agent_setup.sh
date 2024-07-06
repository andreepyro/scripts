# add docker GPG key and their repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# upgrade packages
sudo apt update
sudo apt upgrade -y

# install docker
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# pull docker images
docker pull openziti/quickstart
docker pull openziti/zac
docker pull openziti/ziti-router
docker pull openziti/ziti-controller
docker pull busybox

# install ziti-cli locally
curl -sS https://get.openziti.io/install.bash | sudo bash -s openziti

# download scripts
curl https://raw.githubusercontent.com/andreepyro/scripts/main/fast_ctrl.sh > fast_ctrl.sh
curl https://raw.githubusercontent.com/andreepyro/scripts/main/fast_router.sh > fast_router.sh

