#!/bin/bash -eux
host=$1

mkdir -p ./certs

if [[ ! -e ./certs/$host.key ]]; then
  openssl req -new -days 3650 -nodes -x509 -sha256 \
    -subj "/CN=*.$host" \
    -keyout ./certs/$host.key \
    -out ./certs/$host.crt
fi

if [[ ! -e ./certs/$host.dhparam.pem ]]; then
  openssl dhparam -out ./certs/$host.dhparam.pem 2048
fi
