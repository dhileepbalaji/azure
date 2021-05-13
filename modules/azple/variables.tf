variable "location" {
  description = "(Required) The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where the load balancer resources will be imported."
  type        = string
}


variable "subnet_id" {
    type = string
}

variable "ple_source_id" {
    type = string
}

variable "ple_connection_name" {
    type = string
}

variable "ple_subresource_names" {
    type = list
    default =  []
}

variable "is_manual_connection" {
    default = false
}

variable "request_message" {
    default = null
}

variable "private_dns_zone_ids" {
    type = list
    default = []
}

variable "enable_private_dns_zone_group" {
    default = false
}
