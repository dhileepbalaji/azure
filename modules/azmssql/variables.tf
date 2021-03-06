###### SQLDB VARIABLES #######

variable "auto_pause_delay_in_minutes" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "collation" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "create_mode" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "creation_source_database_id" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "elastic_pool_id" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "license_type" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "max_size_gb" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "name" {
  description = "(required)"
  type        = string
}

variable "read_replica_count" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "read_scale" {
  description = "(optional)"
  type        = bool
  default     = null
}

variable "restore_point_in_time" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "sample_name" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "server_id" {
  description = "(required)"
  type        = string
}

variable "sku_name" {
  description = "(optional)"
  type        = string
  default     = null
}


variable "tags" {
  description = "(optional)"
  type        = map(string)
  default     = null
}

variable "zone_redundant" {
  description = "(optional)"
  type        = bool
  default     = null
}



variable "resource_group_name" {
    default = ""
    description = "(optional)"
}


