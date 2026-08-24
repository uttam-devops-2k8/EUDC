#!/bin/bash
set -xe

if [ -z "$1" ]
then
  echo "Please pass a configuration file like '../environments/dev.yaml'"
  exit
fi
echo "Using the following configuration file: $1"

# when yq isn't installed. Install it.
if ! command -v yq &> /dev/null
then
    mkdir -p tmp
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O ./tmp/yq
    sudo chmod +x ./tmp/yq
    PATH="$PATH:./tmp/"
fi

LOCATION=$(yq '.common.location' $1)
SUBSCRIPTION_ID=$(yq '.common.subscription_id' $1)
TENANT_ID=$(yq '.common.tenant_id' $1)
SERVICEPRINCIPAL_APPLICATION_ID=$(yq '.common.service_principal_application_id' $1)

ENVIRONMENT_NAME=$(yq '.common.environment' $1)

RESOURCEGROUP_NAME=$(yq '.terraform.state.resource_group_name' $1)
STORAGEACCOUNT_NAME=$(yq '.terraform.state.storage_account_name' $1)
CONTAINER_NAME="terraformstate-${GITHUB_REPOSITORY#$GITHUB_REPOSITORY_OWNER/}-$ENVIRONMENT_NAME"
KEY_NAME=terraform.state

echo "$RESOURCEGROUP_NAME"
echo "$STORAGEACCOUNT_NAME"
echo "$CONTAINER_NAME"

echo "Set $SUBSCRIPTION_ID as current subscription"
az account set --subscription $SUBSCRIPTION_ID

export ARM_CLIENT_ID=$SERVICEPRINCIPAL_APPLICATION_ID
export ARM_SUBSCRIPTION_ID=$SUBSCRIPTION_ID
export ARM_TENANT_ID=$TENANT_ID
