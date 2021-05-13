resource "random_id" "id" {
  byte_length = 4
  prefix      = substr(var.name, 0, length(var.name) > 15 ? 15 : length(var.name))
}
resource "azurerm_storage_account" "storageaccount" {
  name                      = var.custom_name ? var.name : random_id.id.hex
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  resource_group_name       = var.resource_group_name
  account_kind              = var.account_kind
  is_hns_enabled            = var.is_hns_enabled
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only


  network_rules {
    default_action             = var.default_action
    ip_rules                   = concat(var.firewall_cidrs, var.custom_firewall_cidrs)
    virtual_network_subnet_ids = var.virtual_network_subnet_ids
    bypass                     = ["AzureServices"]
  }

  dynamic "static_website" {
    for_each = var.static_website
    content {
      index_document = static_website.value["index_document"]
      error_404_document = static_website.value["error_404_document"]
    }
  }

  tags = var.tags
}