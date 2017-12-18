#!/bin/sh
az group create --name hectagon-jumpbox --location "West US" --tags Permanent=True
SUBNET_ID=$(az network vnet subnet list --resource-group hectagon-shared --vnet-name hectagonvnet --query "[?name == 'jumpbox'].id" -o tsv)
az vm create --name hectagonlinux --resource-group hectagon-jumpbox --size Standard_D2s_V3 --subnet $SUBNET_ID --image ubuntults --ssh-key-value @~/.ssh/id_rsa.pub 
az vm create --name hectagonwin --resource-group hectagon-jumpbox --size Standard_D2s_v3 --subnet $SUBNET_ID --image Win2016Datacenter --admin-username nickward
az vm create --name hectagondevvm --resource-group hectagon-jumpbox --size Standard_D2s_v3 --subnet $SUBNET_ID --image VS-2017-Ent-Latest-Win10-N --admin-username nickward
WIN_IP_ADDRESS=$(az vm list-ip-addresses --resource-group hectagon-jumpbox --name hectagonwin --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
