#!/bin/bash
[[ $(ls /var/log/wireguard 2>/dev/null) ]] || mkdir /var/log/wireguard
[[ $(ls /var/log/wireguard/$(date +"%Y-%m-%d").log 2>/dev/null) ]] || touch /var/log/wireguard/$(date +"%Y-%m-%d").log 
var=0

sudo wg show | awk "/peer/{print; nr[NR+3]; next} NR in nr" | gawk '!/minute/ && /second/ {if(a) print strftime("%T"); print a; print} {a=$0}' >> /var/log/wireguard/$(date +"%Y-%m-%d").log
