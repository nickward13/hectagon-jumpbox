#!/bin/sh
az group create --name hectagon-jumpbox --location "Australia Southeast"
az vm create --name hectagon-jumpbox --resource-group hectagon-jumpbox --image ubuntults --size Standard_DS2 --ssh-key-value @~/.ssh/id_rsa.pub --vnet-name hectagonvnet --subnet jumpbox --public-ip-address-dns-name hectagon-jumpbox
IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagon-jumpbox \
    --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt-get update
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt install docker.io curl nodejs npm
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt-get upgrade


