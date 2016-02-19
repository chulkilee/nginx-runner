# nginx-runner

Running one nginx docker container to serve multiple containers via https easily, using [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) and [docker/compose](https://github.com/docker/compose).

## How to use

First of all, generate self-signed certs since all will be on https.

```
# create certs/local.docker.* files for *.local.docker domain
./generate-cert.sh local.docker
```

Then start a container using docker-compose. It will create a `nginx` container which listens 80 and 443 ports - make sure no other containers are listening them.

```
# see docker-compose.yml for details
docker-compose start
```

Once the `nginx` container is started, it will watch running docker containers and automatically update nginx configuration for containers who has `VIRTUAL_HOST` env variables. Note that you should use subdomain (e.g. `hello.local.docker`) to use `certs/local.docker.*` certs.

Also you must set up your dns resolver or update `/etc/hosts` so that your custom domains are resolved to the docker.

```
# example entry in /etc/hosts
192.168.99.100 hello.local.docker
```
