#!/bin/sh

az group create --name hectagon-jumpbox --location "Australia Southeast"
az vm create --name hectagon-jumpbox --resource-group hectagon-jumpbox --image ubuntults --size Standard_DS2 --ssh-key-value @~/.ssh/id_rsa.pub --vnet hectagonvnet --subnet jumpbox --public-ip-address-dns-name hectagon-jumpbox

