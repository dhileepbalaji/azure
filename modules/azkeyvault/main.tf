resource "azurerm_key_vault" "key_vault" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = var.purge_protection_enabled
  tags = var.tags


  dynamic "access_policy" {
    for_each = var.access_policy
    content {
      tenant_id           = access_policy.value.tenant_id
      object_id           = access_policy.value.object_id
      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }

  network_acls {
    default_action             = var.network_default_action
    bypass                     = "AzureServices"
    ip_rules                   = concat(var.firewall_cidrs, var.custom_firewall_cidrs)
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
  }
}

