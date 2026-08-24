terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
  storage_use_azuread = true
  subscription_id            = local.config.common.subscription_id
}

provider "azurerm" {
  use_oidc = true
  alias    = "centralsubscription"
  features {}
  subscription_id            = local.config.central.subscription_id
}

provider "azurerm" {
  use_oidc = true
  alias    = "dns_subscription_id"
  features {}
  subscription_id            = local.config.central.dns_subscription_id
}
