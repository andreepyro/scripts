mkdir -p $HOME/.ziti/zac-pki

docker run -it --rm --name temp \
  -v openZitiFiles:/persistent \
  -v $HOME/.ziti/zac-pki:/zac-pki busybox \
  cp /persistent/pki/ziti-edge-controller-intermediate/keys/ziti-edge-controller-server.key /zac-pki
  
docker run -it --rm --name temp \
  -v openZitiFiles:/persistent \
  -v $HOME/.ziti/zac-pki:/zac-pki busybox \
  cp /persistent/pki/ziti-edge-controller-intermediate/certs/ziti-edge-controller-server.chain.pem /zac-pki

docker run --rm \
       -d \
       --name zac \
       -p 1408:1408 \
       -p 8443:8443 \
       -v "$HOME/.ziti/zac-pki/ziti-edge-controller-server.key":/usr/src/app/server.key \
       -v "$HOME/.ziti/zac-pki/ziti-edge-controller-server.chain.pem":/usr/src/app/server.chain.pem \
       openziti/zac
