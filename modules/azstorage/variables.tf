variable "name" {}
variable "custom_name" {
  type    = bool
  default = false
}
variable "location" {
  type    = string
  default = "Central US"
}
variable "account_tier" {
  type    = string
  default = "Standard"
}
variable "account_replication_type" {
  type    = string
  default = "LRS"
}
variable "account_kind" {
  type    = string
  default = "BlobStorage"
}
variable "is_hns_enabled" {
  default = "false"
}
variable "access_tier" {
  type    = string
  default = "Hot"
}
variable "firewall_cidrs" {
  type = list
  default =[]
  
}
variable "custom_firewall_cidrs" {
  type    = list
  default = []
}
variable "virtual_network_subnet_ids" {
  type    = list
  default = null
}
variable "enable_https_traffic_only" {
  type    = bool
  default = true
}
variable "static_website" {
  type = list(object({
    index_document = string
    error_404_document = string
  }))
  default =[]
}

variable "tags" {
  description = "The tags to associate."
  type        = map(string)

  default = {}
}

variable "resource_group_name" {
  description = "The name of an existing resource group to be imported."
  type        = string
}

variable "default_action" {
  description = "Default Firewall action"
  type        = string
  default     = "Allow"
}

