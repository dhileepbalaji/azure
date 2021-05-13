resource "azurerm_private_dns_zone" "database" {
    name                    = "privatelink.database.windows.net"
    resource_group_name     = local.resource_group_name
    tags                    = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link1" {
    name                    = "vnet-private-zone-database"
    resource_group_name     = local.resource_group_name
    private_dns_zone_name   = azurerm_private_dns_zone.database.name
    virtual_network_id      = module.vnet.id
    tags                    = var.tags
}

resource "azurerm_private_dns_zone" "storage_blob" {
    name                    = "privatelink.blob.core.windows.net"
    resource_group_name     = local.resource_group_name
    tags                    = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link2" {
    name                    = "vnet-private-zone-storage-blob"
    resource_group_name     = local.resource_group_name
    private_dns_zone_name   = azurerm_private_dns_zone.storage_blob.name
    virtual_network_id      = module.vnet.id
    tags                    = var.tags
}

resource "azurerm_private_dns_zone" "keyvault" {
    name                    = "privatelink.vaultcore.azure.net"
    resource_group_name     = local.resource_group_name
    tags                    = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet-link3" {
    name                    = "vnet-private-zone-keyvault"
    resource_group_name     = local.resource_group_name
    private_dns_zone_name   = azurerm_private_dns_zone.keyvault.name
    virtual_network_id      = module.vnet.id
    tags                    = var.tags
}



