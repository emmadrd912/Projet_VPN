#!/bin/bash
umask 077
wg genkey | tee privatekey | wg pubkey > publickey

path=$HOME/wg0-client.conf
[[ $(sudo ls $path 2>/dev/null) ]] && sudo rm -f $path

ip=2
while [[ $(sudo wg show | grep allowed | cut -d ":" -f 2 | cut -d " " -f 2 | grep 10.9.13.$ip) ]]
do
	ip=$((ip+1))
	if [[ $ip -gt 254 ]]
	then
		echo "No more clients can be added."
		exit 1
	fi
done

sudo touch $path
sudo printf "[Interface]\n" >> $path
sudo printf "Address = 10.9.13.$ip/32\n" >>  $path
sudo printf "PrivateKey = $(cat privatekey)\n" >> $path
sudo printf "DNS = 10.9.3.1\n\n" >> $path
sudo printf "[Peer]\n" >> $path
sudo printf "PublicKey = $(sudo wg show | grep "public key" | cut -d ":" -f 2 | cut -d " " -f 2)\n" >> $path
sudo printf "Endpoint = 192.168.100.122:1424\n" >> $path
sudo printf "AllowedIPs = 0.0.0.0/0\n" >> $path
sudo printf "PersistentKeepalive = 21\n" >> $path

sudo wg set wg0-server peer $(cat publickey) allowed-ips 10.9.13.$ip/32
sudo wg-quick save wg0-server

sudo rm -f publickey
sudo rm -f privatekey

sudo chmod 777 $path
echo "wg0-client.conf has been correctly created. You can find it there : $path"
exit 0
