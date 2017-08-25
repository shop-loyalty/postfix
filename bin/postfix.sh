#!/bin/sh

set -e

trap "{ echo 'Stopping postfix'; postfix stop; exit 0; }" EXIT

if postfix status 2> /dev/null > /dev/null; then
    postfix reload
else
    postfix start
fi

while /bin/true; do
    postfix status 2> /dev/null > /dev/null
    exit_code=$?
    if [ "$exit_code" -ne 0 ]; then
        echo "postfix exiting"
        exit 1
    fi
    sleep 1
done