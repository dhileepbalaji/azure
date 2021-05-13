variable "name" {}
variable "location" {
  type    = string
  default = "Central US"
}
variable "resource_group_name" {}
variable "tenant_id" {}
variable "sku_name" {
  default = "standard"
}
variable "network_default_action" {
  default = "Deny"
}
variable "firewall_cidrs" {
  type = list
  default = []
}
variable "custom_firewall_cidrs" {
  type    = list
  default = []
}
variable "access_policy" {
  type = list(object({
    tenant_id           = string
    object_id           = string
    key_permissions     = list(string)
    secret_permissions  = list(string)
    storage_permissions = list(string)
  }))
  default = []
}
variable "virtual_network_subnet_ids" {
  type    = list
  default = null
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "purge_protection_enabled" {
  default = false
}

variable "tags" {
  description = "The tags to associate."
  type        = map(string)

  default = {}
}