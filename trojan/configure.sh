#!/bin/sh

set -e

until [ `ls -A /ssl|wc -w` -eq 1 ]
do
  >&2 echo "waiting for ssl certs..."
  sleep 1
done

exec $@