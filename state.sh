#!/bin/bash
set -xe

. ./common.sh $1

terraform state -chdir="../terraform" list

# terraform state rm 'module.vm["vmsouraccweeu03"].azurerm_storage_blob.script["customScriptLinux.sh"]'
# terraform state rm 'module.vm["vmsouraccweeu03"].azurerm_virtual_machine_extension.linux-scripts[0]'

terraform import 'module.vm["vmsouraccweeu03"].azurerm_key_vault_secret.keyvaultsecret-public-sshkey[0]' "https://kvgsoservice10nonprdweeu.vault.azure.net/secrets/vmsouraccweeu03-ssh-public-key/006fd57e08f24cf6b14f616361e2c839"
terraform import 'module.vm["vmsouraccweeu03"].azurerm_key_vault_secret.auth[0]' "https://kvgsoservice10nonprdweeu.vault.azure.net/secrets/vmsouraccweeu03-admin-password/3c10530056ee403695987c9a61dd34d8"
terraform import 'module.vm["vmsouraccweeu03"].azurerm_key_vault_secret.bootloader[0]' "https://kvgsoservice10nonprdweeu.vault.azure.net/secrets/vmsouraccweeu03-bootloader-password/37dd3f803b9b4759b033cc522eb80b90"
terraform import 'module.vm["vmsouraccweeu03"].azurerm_key_vault_secret.main[0]' "https://kvgsoservice10nonprdweeu.vault.azure.net/secrets/vmsouraccweeu03-ssh-private-key/1818975b600345b887864ecf842b03be"