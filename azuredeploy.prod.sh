#!/bin/sh
az group create --name hectagon-jumpbox --location "West US"
SUBNET_ID=$(az network vnet subnet list --resource-group hectagon-shared --vnet-name hectagonvnet --query "[?name == 'jumpbox'].id" -o tsv)
az vm create --name hectagon-jumpbox-linux --resource-group hectagon-jumpbox --image ubuntults --size Standard_DS2 --ssh-key-value @~/.ssh/id_rsa.pub --subnet $SUBNET_ID --public-ip-address-dns-name hectagon-jumpbox-linux
az vm create --name hectagon-jumpbox-win --resource-group hectagon-jumpbox --image Win2016Datacenter --size Standard_DS2 --subnet $SUBNET_ID --public-ip-address-dns-name hectagon-jumpbox-windows --admin-username nickward
IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagon-jumpbox --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt-get update
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt install docker.io curl nodejs npm
ssh -i ~/.ssh/id_rsa $IP_ADDRESS sudo apt-get upgrade
echo "IP Address is $IP_ADDRESS"