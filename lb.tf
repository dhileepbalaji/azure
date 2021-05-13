module "public_lb" {
  source              = "./modules/azlb"
  resource_group_name = local.resource_group_name
  location            = local.location
  name                = "terraform-test-public"
  lb_sku              = "Standard"
  pip_sku             = "Standard" #`pip_sku` must match `lb_sku`

  tags = var.tags
}




module "private_lb" {
  source                                 = "./modules/azlb"
  name                                   = "terraform-test-private"
  resource_group_name                    = local.resource_group_name
  location                               = local.location
  type                                   = "private"
  frontend_subnet_id                     = module.vnet.subnet_ids[0]
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = "10.0.1.6"
  lb_sku                                 = "Standard"
  #[frontend_port, protocol, backend_port]
  nat_rule = {
    ssh = ["8222", "Tcp", "22"]
  }

  lb_rule = {
    http  = ["80", "Tcp", "80"]
    https = ["443", "Tcp", "443"]
  }

  lb_probe = {
    http  = [ "80", "Tcp", ""]
    http2 = [ "1443","Http", "/"]
  }

  tags = var.tags

  # Private link service
  enable_pls                       = true
  pls_name                         = "terraform-test-private-pls"
  auto_approval_subscription_ids   = []
  visibility_subscription_ids      = []
  private_ip_address               = "10.0.2.5"
  subnet_id                        = module.vnet.subnet_ids[1]

}