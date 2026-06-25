#!/bin/sh

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [net-warn] $*" | tee -a "$LOG"; }

log "Network unreachable, restarting networking"
rc-service networking restart
