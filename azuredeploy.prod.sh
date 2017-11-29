#!/bin/sh
az group delete --name hectagon-jumpbox
az group create --name hectagon-jumpbox --location "West US"
SUBNET_ID=$(az network vnet subnet list --resource-group hectagon-shared --vnet-name hectagonvnet --query "[?name == 'jumpbox'].id" -o tsv)
az vm create --name hectagonlinux --resource-group hectagon-jumpbox --size Standard_DS2 --subnet $SUBNET_ID --image ubuntults --ssh-key-value @~/.ssh/id_rsa.pub 
az vm create --name hectagonwin --resource-group hectagon-jumpbox --size Standard_D2s_v3 --subnet $SUBNET_ID --image Win2016Datacenter --admin-username nickward
LINUX_IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagonlinux --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
ssh -i ~/.ssh/id_rsa $LINUX_IP_ADDRESS sudo apt-get update
ssh -i ~/.ssh/id_rsa $LINUX_IP_ADDRESS sudo apt install docker.io curl nodejs npm
ssh -i ~/.ssh/id_rsa $LINUX_IP_ADDRESS sudo apt-get upgrade
echo "IP Address is $LINUX_IP_ADDRESS"
WIN_IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagonwin --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
