variable "config_yml" {
  type        = string
  description = "Name of the environment yml filename"
}

##################################################################################
# Variables below are only needed to run without private runner in github or local
##################################################################################
variable "domain_join_username" {
  description = "A logical name related to the application or service the resource is deployed for. Be consistent in the spelling of this component."
  type        = string
  default     = null
}

variable "domain_join_password" {
  description = "A logical name related to the application or service the resource is deployed for. Be consistent in the spelling of this component."
  type        = string
  default     = null
}

variable "domain_join_ou" {
  description = "A logical name related to the application or service the resource is deployed for. Be consistent in the spelling of this component."
  type        = string
  default     = null
}

variable "ldap_secret" {
  description = "A logical name related to the application or service the resource is deployed for. Be consistent in the spelling of this component."
  type        = string
  default     = null
}

variable "ldap_username" {
  description = "A logical name related to the application or service the resource is deployed for. Be consistent in the spelling of this component."
  type        = string
  default     = null
}
