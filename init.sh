#!/bin/bash
set -xe

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $SCRIPT_DIR/common.sh $1


az storage container create --name $CONTAINER_NAME --account-name $STORAGEACCOUNT_NAME --auth-mode login 

terraform -chdir="../terraform" init -upgrade -migrate-state \
          -backend-config=storage_account_name=$STORAGEACCOUNT_NAME \
          -backend-config=container_name=$CONTAINER_NAME \
          -backend-config=key=$KEY_NAME \
          -backend-config=resource_group_name=$RESOURCEGROUP_NAME \
          -backend-config=use_oidc=true \
          -backend-config=client_id=$SERVICEPRINCIPAL_APPLICATION_ID \
          -backend-config=tenant_id=$TENANT_ID \
          -backend-config=subscription_id=$SUBSCRIPTION_ID \
          -backend-config=use_azuread_auth=true
