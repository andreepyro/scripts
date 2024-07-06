cd ~

mkdir controller

cd controller

wget https://get.openziti.io/dist/docker-images/ziti-controller/compose.yml

ZITI_PWD="mypass" \
ZITI_CTRL_ADVERTISED_ADDRESS=ctrl.192.168.88.254.sslip.io \
    docker compose up -d

ziti edge login ctrl.192.168.88.254.sslip.io:1280 -u admin -p mypass

ziti edge create edge-router "router1" --jwt-output-file=~/router1.jwt

