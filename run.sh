#!/bin/bash

base=$( realpath $( dirname $0 ) )

docker build -t 0lfi/grav ./docker || exit 1

mkdir -p $base/volumes/grav
docker run --rm -it \
  --name grav \
  -p 8080:80 \
  -v $base/volumes/grav:/srv/grav \
  0lfi/grav
