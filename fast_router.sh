cd ~

mkdir router

cd router

wget https://get.openziti.io/dist/docker-images/ziti-router/compose.yml

ZITI_ENROLL_TOKEN="$(<~/router1.jwt)" \
ZITI_CTRL_ADVERTISED_ADDRESS=ctrl.192.168.88.253.sslip.io \
ZITI_CTRL_ADVERTISED_PORT=1280 \
ZITI_ROUTER_ADVERTISED_ADDRESS=router1.192.168.88.253.sslip.io \
ZITI_ROUTER_PORT=3022 \
    docker compose up -d

