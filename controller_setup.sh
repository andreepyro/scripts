# create volume
docker volume create openZitiFiles

# create docker network
docker network create openZitiNetwork

# start controller
docker run \
  --name ziti-controller \
  -e ZITI_CTRL_ADVERTISED_ADDRESS=ziti-edge-controller \
  --network openZitiNetwork \
  --network-alias ziti-controller \
  --network-alias ziti-edge-controller \
  -p 1280:1280 \
  -d \
  --rm \
  -v openZitiFiles:/persistent \
  openziti/quickstart \
  /var/openziti/scripts/run-controller.sh

# create edge router policies
docker run \
  --network openZitiNetwork \
  --network-alias ziti-controller-init-container \
  -d \
  --rm \
  -v openZitiFiles:/persistent \
  openziti/quickstart \
  /var/openziti/scripts/run-with-ziti-cli.sh  /var/openziti/scripts/access-control.sh

# start edge router
docker run \
  --name ziti-edge-router-1 \
  -e ZITI_ROUTER_NAME=ziti-edge-router-1 \
  -e ZITI_ROUTER_ADVERTISED_ADDRESS=ziti-edge-router-1 \
  -e ZITI_ROUTER_ROLES=public \
  --network openZitiNetwork \
  --network-alias ziti-edge-router-1 \
  -p 3022:3022 \
  -d \
  --rm \
  -v openZitiFiles:/persistent \
  openziti/quickstart \
  /var/openziti/scripts/run-router.sh edge

