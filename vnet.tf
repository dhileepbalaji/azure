module "vnet" {
    source              = "./modules/azvnet"
    name                = "vnet-default-hub-centralus"
    resource_group_name = local.resource_group_name
    location            = local.location
    address_space       = "10.0.0.0/16"
    subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
    subnet_names        = ["subnet1", "plssubnet"]
    service_endpoints   = {
        "subnet1" : ["Microsoft.Sql", "Microsoft.Storage","Microsoft.KeyVault"]
        "plssubnet": []
    }
    subnet_enforce_private_link_endpoint_network_policies = {
    "subnet1" : true
    }    
    subnet_enforce_private_link_service_network_policies = {
    "plssubnet" : true
    }
}