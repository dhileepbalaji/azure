#---------------------------------------------------------
# Storage Account to keep Audit logs - Default is "false"
#----------------------------------------------------------

resource "random_id" "id" {
  byte_length = 4
  prefix      = substr(var.auditstorageaccname, 0, length(var.auditstorageaccname) > 15 ? 15 : length(var.auditstorageaccname))
}

resource "azurerm_storage_account" "storeacc" {
    count                     = var.enable_auditing_policy ? 1 : 0
    name                      = random_id.id.hex
    resource_group_name       = local.resource_group_name
    location                  = local.location
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    account_replication_type  = "LRS"
    tags                      = var.tags

    network_rules {
      default_action             = "Deny"
      ip_rules                   = ["127.0.0.1"]
      virtual_network_subnet_ids = var.virtual_network_subnet_ids
      bypass                     = ["Logging", "Metrics", "AzureServices"]
  }
}


#-------------------------------------------------------------
# SQL server Creation
#-------------------------------------------------------------

resource "azurerm_sql_server" "sqlserver" {
    name                         = format("%s", var.sqlserver_name)
    resource_group_name          = local.resource_group_name
    location                     = local.location
    version                      = "12.0"
    administrator_login          = var.administrator_login
    administrator_login_password = var.administrator_login_password
    tags                         = var.tags
    identity {
        type = "SystemAssigned"
    }
    dynamic "extended_auditing_policy" {
        for_each = local.if_extended_auditing_policy_enabled
        content {
            storage_account_access_key = azurerm_storage_account.storeacc.0.primary_access_key
            storage_endpoint           = azurerm_storage_account.storeacc.0.primary_blob_endpoint
            retention_in_days          = var.log_retention_days
        }
    }
}

#-----------------------------------------------------------------------------------------------
# Adding AD Admin to SQL Server - Default is "false"
#-----------------------------------------------------------------------------------------------

data "azurerm_client_config" "current" {}

resource "azurerm_sql_active_directory_administrator" "aduser1" {
    count                   = var.enable_sql_ad_admin ? 1 : 0
    server_name             = azurerm_sql_server.sqlserver.name
    resource_group_name     = local.resource_group_name
    login                   = var.ad_admin_login_name
    tenant_id               = data.azurerm_client_config.current.tenant_id
    object_id               = data.azurerm_client_config.current.object_id
}


#---------------------------------------------------------
# Azure SQL Firewall Rule - Default is "false"
#---------------------------------------------------------

resource "azurerm_sql_firewall_rule" "fw01" {
    count                   = var.enable_firewall_rules && length(var.firewall_rules) > 0 ? length(var.firewall_rules) : 0
    name                    = element(var.firewall_rules, count.index).name
    resource_group_name     = local.resource_group_name
    server_name             = azurerm_sql_server.sqlserver.name
    start_ip_address        = element(var.firewall_rules, count.index).start_ip_address
    end_ip_address          = element(var.firewall_rules, count.index).end_ip_address
}