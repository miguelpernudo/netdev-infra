#!/bin/sh

if ping -c 1 "$NET_TARGET" > /dev/null 2>&1; then
    exit 0
else
    exit 1
fi
