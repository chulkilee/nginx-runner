#!/bin/bash -eu
dir="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

if [[ $(docker-machine ip default) ]]; then
  echo '# using default docker-machine'
  eval $(docker-machine env default)
fi

if [[ $(docker ps -a -q -f name=nginx) ]]; then
  echo '# removing existing nginx container'
  docker rm -f nginx
fi

echo '# creating new nginx container'
docker create \
  --name nginx \
  -p 80:80 \
  -p 443:443 \
  -v /var/run/docker.sock:/tmp/docker.sock:ro \
  -v $dir/certs:/etc/nginx/certs \
  -v $dir/conf.d/common.conf:/etc/nginx/conf.d/common.conf:ro \
  -v $dir/htpasswd:/etc/nginx/htpasswd \
  -v $dir/vhost.d:/etc/nginx/vhost.d \
  jwilder/nginx-proxy:latest

echo '# staring nginx ctonainer'
docker start nginx
