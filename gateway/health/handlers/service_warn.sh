#!/bin/sh

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [service-warn] $*" | tee -a "$LOG"; }

for svc in hostapd dnsmasq nftables; do
    if ! rc-service "$svc" status > /dev/null 2>&1; then
        log "Restarting $svc"
        rc-service "$svc" restart
    fi
done
