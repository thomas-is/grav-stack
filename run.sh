#!/bin/bash

base=$( realpath $( dirname $0 ) )

mkdir -p $base/volumes/grav/config

docker run --rm -it \
  --name grav \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 8080:80 \
  -v $base/volumes/grav/config:/config \
  lscr.io/linuxserver/grav:latest
