#!/bin/sh

for s in /app/.profile.d/* ; do
    source $s
done

sh -c "$@"
