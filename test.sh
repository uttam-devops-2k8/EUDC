#!/bin/bash
set -e

ENVIRONMENT_NAME=$(yq -e '.common.environment' ../environments/nonprd.yaml)

# try to do some autolookup
LOOKUP_RESOURCEGROUP_NAME=$(az group list --query "[?starts_with(name, 'rg-terraform-$ENVIRONMENT_NAME')]" | jq '.[0].name' --raw-output)
if [[ "$LOOKUP_RESOURCEGROUP_NAME" != "null" ]] && [ "$LOOKUP_RESOURCEGROUP_NAME" != "" ] 
then
    LOOKUP_STORAGEACCOUNT_NAME=$(az resource list --resource-group $LOOKUP_RESOURCEGROUP_NAME | jq '.[0].name' --raw-output)

    RESOURCEGROUP_NAME=$LOOKUP_RESOURCEGROUP_NAME
    STORAGEACCOUNT_NAME=$LOOKUP_STORAGEACCOUNT_NAME

    echo "Autolookup found the following entries:"
    echo "ResourceGroup: $RESOURCEGROUP_NAME"
    echo "StorageAccount: $STORAGEACCOUNT_NAME"

fi

