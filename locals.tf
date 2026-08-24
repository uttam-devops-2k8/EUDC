locals {
  config = yamldecode(file(var.config_yml))
}
