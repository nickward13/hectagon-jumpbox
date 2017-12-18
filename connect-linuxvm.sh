#!/bin/sh

LINUX_IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagonlinux --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
ssh -i ~/.ssh/id_rsa $LINUX_IP_ADDRESS
