#!/bin/sh

set -e

# waiting for ssl

until [ `ls /ssl|wc -w` -eq 1 ]
do
  >&2 echo "waiting for ssl certs..."
  sleep 1
done

ls /ssl

echo "starting trojan..."
/usr/local/bin/trojan /config/config.json
