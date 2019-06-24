#!/bin/bash
if [[ -z $1 ]]
then
	echo "Please enter a valid input"
	exit 1
fi

if [[ $(sudo wg show | grep $1) ]]
then
	:
else
	echo "The client with the public key $1 does not exist."
	exit 1
fi

sudo wg set wg0-server peer $1 remove
sudo wg-quick save wg0-server
echo "The client with the public key $1 has been removed."
exit 0