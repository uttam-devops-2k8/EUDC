

module "gso_tech" {
  source = "git::git@github.com:RoyalAholdDelhaize/gso-tech-terraform-modules.git//modules/gso-tech?ref=refs/tags/0.215.0"
  config_yml                 = var.config_yml
  domain_join_username       = var.domain_join_username
  domain_join_password       = var.domain_join_password
  domain_join_ou             = var.domain_join_ou
  ldap_secret                = var.ldap_secret
  ldap_username              = var.ldap_username
  get_secrets_from_key_vault = true

  providers = {
    azurerm.centralsubscription = azurerm.centralsubscription,
    azurerm.dns_subscription_id = azurerm.dns_subscription_id
  }
}
