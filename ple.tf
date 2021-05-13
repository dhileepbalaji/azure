module "sqlple01" {
    source                        = "./modules/azple"
    ple_connection_name           = "sqlple01"
    resource_group_name           = local.resource_group_name
    location                      = local.location
    subnet_id                     = module.vnet.subnet_ids[0]
    ple_source_id                 = module.sqlserver.id
    ple_subresource_names         = ["sqlServer"]
    enable_private_dns_zone_group = true
    private_dns_zone_ids          = [azurerm_private_dns_zone.database]
}

module "storage_ple01" {
    source                        = "./modules/azple"
    ple_connection_name           = "storage_ple01"
    resource_group_name           = local.resource_group_name
    location                      = local.location
    subnet_id                     = module.vnet.subnet_ids[0]
    ple_source_id                 = module.storage1.id
    ple_subresource_names         = ["blob"]
    enable_private_dns_zone_group = true
    private_dns_zone_ids          = [azurerm_private_dns_zone.storage_blob]
}

module "loadbalancerple01" {
    source                      = "./modules/azple"
    ple_connection_name         = "loadbalancerple01"
    resource_group_name         = local.resource_group_name
    location                    = local.location
    subnet_id                   = module.vnet.subnet_ids[0]
    ple_source_id               = module.private_lb.pls_id[0]
}