module "azurerm_keyvault" {
    source = "./modules/azkeyvault"
    name                        = "test-dev-keyvault"
    resource_group_name         = local.resource_group_name
    location                    = local.location
    tenant_id                   = ""
    sku_name                    = "standard"
    virtual_network_subnet_ids  = [module.vnet.subnet_ids[0]]
}