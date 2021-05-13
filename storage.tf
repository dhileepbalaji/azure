module "storage1" {
    source = "./modules/azstorage"
    custom_name              = false
    name                     = "testlocaldevtest"
    resource_group_name      = local.resource_group_name
    location                 = local.location
    account_kind             = "StorageV2"
    account_replication_type = "LRS"
    account_tier             = "Standard"
    tags                     = var.tags
    virtual_network_subnet_ids = [module.vnet.subnet_ids[0]]
}