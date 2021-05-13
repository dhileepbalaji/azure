module "virtual-machine" {
  source  = "./modules/azvm"

  # Resource Group, location, VNet and Subnet details
  resource_group_name = local.resource_group_name
  location            = local.location
  virtual_network_name = module.vnet.name
  subnet_name          = module.vnet.subnet_names[0]
  virtual_machine_name = "vm-linux"
  disable_password_authentication = false
  # add instance to loadbalancers
  backend_address_pool_internal = true
  backend_address_pool_external = true
  backend_address_pool_internal_id = module.private_lb.azurerm_lb_backend_address_pool_id
  backend_address_pool_external_id = module.public_lb.azurerm_lb_backend_address_pool_id

  # (Optional) To enable Azure Monitoring and install log analytics agents
  log_analytics_workspace_name = null
  hub_storage_account_name     = null

  # This module support multiple Pre-Defined Linux and Windows Distributions.
  os_flavor                  = "linux"
  linux_distribution_name    = "ubuntu1804"
  virtual_machine_size       = "Standard_A2_v2"
  instances_count            = 2
  enable_vm_availability_set = true
  # enable/disable boot diagnostics 
  boot_diagnostics = [{
    storage_account_uri = module.storage1.primary_blob_endpoint
  }]

  # Network Seurity group port allow definitions for each Virtual Machine
  # NSG association to be added automatically for all network interfaces.
  nsg_inbound_rules = [
    {
      name                   = "ssh"
      destination_port_range = "22"
      source_address_prefix  = "*"
    },

    {
      name                   = "http"
      destination_port_range = "80"
      source_address_prefix  = "*"
    },
  ]
  tags = var.tags

  depends_on = [module.vnet]

}