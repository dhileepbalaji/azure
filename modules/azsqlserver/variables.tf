####### SQL SERVER VARIABLES #######
variable "resource_group_name" {
    description = "(required)"
}

variable "location" {
    description = "(required)"
}

variable "sqlserver_name" {
    description = "SQL server Name"
    default     = "sqldbserver-demodbapp"
}

variable "administrator_login" {
    description = "(required)"
}
variable "administrator_login_password" {
    description = "(required)"
}

variable "enable_sql_ad_admin" {
    description = "Allows you to set a user or group as the AD administrator for an Azure SQL server"
    default     = false
}

variable "ad_admin_login_name" {
    description = "The login name of the principal to set as the server administrator"
    default     = ""
}


variable "enable_firewall_rules" {
    description = "Manage an Azure SQL Firewall Rule"
    default     = false
}

variable "firewall_rules" {
  description = "Range of IP addresses to allow firewall connections."
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

#####LOGGING VARIABLES ######
variable "enable_auditing_policy" {
    description = "Audit policy for SQL server and database"
    default     = false
}

variable "log_retention_days" {
    description = "Specifies the number of days to keep in the Threat Detection audit logs"
    default     = "30"
}


variable "auditstorageaccname" {
  description = "The name of an existing resource group to be imported."
  type        = string
  default     = "sqlauditlog"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    environment = "dev"
  }
}

variable "virtual_network_subnet_ids" {
  type    = list
  default = null
}